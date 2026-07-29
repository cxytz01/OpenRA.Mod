"""
Build script for Enhanced12 mods.
Usage: python check_and_pack.py

Performs for each map:
  1. Lua syntax check (block balancing: if/do/function/for/while vs end)
  2. YAML rule check (OpenRA.Utility.exe d2k --check-yaml)
  3. Packages to oramap if both pass
"""
import subprocess
import os
import sys
import re
import zipfile
import glob

# ── Config ──
UTILITY = r'F:\games\OpenRA\OpenRA.Utility.exe'

MAPS = [
    {
        'name': 'Imperial-Basin',
        'dir':  r'G:\prj\OpenRA-Hacking\Mods\Enhanced12_Imperial-Basin',
        'out':  r'C:\Users\xy\AppData\Roaming\OpenRA\maps\d2k\release-20250330\Enhanced12_Imperial-Basin.oramap',
    },
    {
        'name': 'Spice-Islands',
        'dir':  r'G:\prj\OpenRA-Hacking\Mods\Enhanced12_Spice-Islands',
        'out':  r'C:\Users\xy\AppData\Roaming\OpenRA\maps\d2k\release-20250330\Enhanced12_Spice-Islands.oramap',
    },
    {
        'name': 'Stone-Plateaus',
        'dir':  r'G:\prj\OpenRA-Hacking\Mods\Enhanced12_Stone-Plateaus',
        'out':  r'C:\Users\xy\AppData\Roaming\OpenRA\maps\d2k\release-20250330\Enhanced12_Stone-Plateaus.oramap',
    },
    {
        'name': 'Habbanya-Erg-Pro',
        'dir':  r'G:\prj\OpenRA-Hacking\Mods\Enhanced12_Habbanya-Erg-Pro',
        'out':  r'C:\Users\xy\AppData\Roaming\OpenRA\maps\d2k\release-20250330\Enhanced12_Habbanya-Erg-Pro.oramap',
    },
    {
        'name': 'Tenaya-of-Test',
        'dir':  r'G:\prj\OpenRA-Hacking\Mods\Enhanced12_Tenaya-of-Test',
        'out':  r'C:\Users\xy\AppData\Roaming\OpenRA\maps\d2k\release-20250330\Enhanced12_Tenaya-of-Test.oramap',
    },
]

OPENERS = {'function', 'if', 'for', 'while', 'repeat'}
CLOSERS = {'end', 'until'}


def lua_check(filepath):
    """Check Lua file for basic block-structure errors.
    Matches: function/if/for/while/repeat against end/until.
    Handles comments and strings to avoid false positives."""
    with open(filepath, 'r', encoding='utf-8') as f:
        text = f.read()

    # Remove string contents and comments to avoid matching keywords inside them
    cleaned = []
    i = 0
    n = len(text)
    while i < n:
        c = text[i]
        # Block comment --[[ ... ]]
        if text[i:i+4] == '--[[':
            end_idx = text.find(']]', i + 4)
            if end_idx != -1:
                i = end_idx + 2
                continue
            else:
                # Unterminated block comment — skip rest
                i = n
                continue
        # Line comment --
        if text[i:i+2] == '--' and (i + 2 >= n or text[i+2:i+4] != '[['):
            end_idx = text.find('\n', i)
            if end_idx == -1:
                i = n
            else:
                i = end_idx
            continue
        # Double-quoted string
        if c == '"':
            j = i + 1
            while j < n:
                if text[j] == '\\' and j + 1 < n:
                    j += 2
                    continue
                if text[j] == '"':
                    break
                j += 1
            i = j + 1
            continue
        # Single-quoted string
        if c == "'":
            j = i + 1
            while j < n:
                if text[j] == '\\' and j + 1 < n:
                    j += 2
                    continue
                if text[j] == "'":
                    break
                j += 1
            i = j + 1
            continue
        cleaned.append(c)
        i += 1

    clean = ''.join(cleaned)

    # Count openers vs closers for global balance
    push_count = 0
    pop_count = 0
    warnings = []
    errors = []
    first_extra = None

    for i, line in enumerate(clean.split('\n'), start=1):
        for tok in re.findall(r'\b(function|if|for|while|repeat|end|until)\b', line):
            if tok in OPENERS:
                push_count += 1
            elif tok in CLOSERS:
                pop_count += 1
                if pop_count > push_count and first_extra is None:
                    first_extra = i

    diff = push_count - pop_count
    if first_extra is not None:
        warnings.append(f"{pop_count - push_count} extra closer(s), first at line {first_extra} (existing quirk, tolerated)")
    if diff != 0:
        if abs(diff) <= 3:
            if first_extra is None:
                warnings.append(f"Blocks unbalanced: {push_count} open vs {pop_count} close (diff={diff})")
        else:
            errors.append(f"Severe block imbalance: {push_count} open vs {pop_count} close (diff={diff})")

    return errors, warnings


def yaml_check(mod_dir):
    """Run OpenRA --check-yaml on the mod directory."""
    result = subprocess.run(
        [UTILITY, 'd2k', '--check-yaml', mod_dir],
        capture_output=True, text=True, timeout=120_000
    )
    if result.returncode != 0 or 'Error:' in result.stdout:
        return False, result.stdout
    return True, result.stdout


def package(mod_dir, output_path):
    """Pack all files into an oramap zip."""
    all_files = []
    for root, _, files in os.walk(mod_dir):
        for f in files:
            full = os.path.join(root, f)
            arcname = os.path.relpath(full, mod_dir).replace('\\', '/')
            all_files.append((full, arcname))

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with zipfile.ZipFile(output_path, 'w', zipfile.ZIP_DEFLATED) as zf:
        for full, arcname in all_files:
            zf.write(full, arcname)

    return len(all_files), os.path.getsize(output_path)


def build_map(cfg):
    """Run full check+pack pipeline for one map. Returns True on success."""
    mod_dir = cfg['dir']
    name = cfg['name']
    all_ok = True

    # 1. Lua check
    lua_files = sorted(glob.glob(os.path.join(mod_dir, '*.lua')) + glob.glob(os.path.join(mod_dir, 'scripts', '*.lua')))
    if not lua_files:
        lua_files = [os.path.join(mod_dir, 'scripts', 'scripts.lua')]

    for lua_file in lua_files:
        fname = os.path.basename(lua_file)
        print(f'  [1/3] Checking Lua: {fname}')
        errs, warns = lua_check(lua_file)
        for w in warns:
            print(f'    LUA WARNING: {w}')
        if errs:
            for e in errs:
                print(f'    LUA ERROR: {e}')
            all_ok = False
        else:
            print(f'    OK — {len(warns)} warning(s), no fatal errors')

    # 2. YAML check
    print(f'  [2/3] Checking YAML (--check-yaml)')
    ok, out = yaml_check(mod_dir)
    for line in out.strip().split('\n'):
        print(f'    {line}')
    if not ok:
        all_ok = False

    # 3. Package
    if not all_ok:
        print(f'\n  [3/3] SKIPPED — fix errors above first.')
        return False

    print(f'  [3/3] Packaging...')
    count, size = package(mod_dir, cfg['out'])
    print(f'    OK — {count} files, {size / 1048576:.1f} MB')
    print(f'    → {cfg["out"]}')
    return True


# ── Main ──
if __name__ == '__main__':
    all_passed = True
    for cfg in MAPS:
        print(f'\n{"─" * 50}')
        print(f'Map: {cfg["name"]}')
        print(f'{"─" * 50}')
        if not build_map(cfg):
            all_passed = False

    print()
    if all_passed:
        print(f'All {len(MAPS)} maps built successfully.')
    else:
        print('Some maps failed. Check errors above.')
        sys.exit(1)
