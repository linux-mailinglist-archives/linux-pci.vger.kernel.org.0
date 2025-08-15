Return-Path: <linux-pci+bounces-34120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C881B287E9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 23:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9373A486E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 21:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C6213E7A;
	Fri, 15 Aug 2025 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnKvUD08"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9C20C029
	for <linux-pci@vger.kernel.org>; Fri, 15 Aug 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294135; cv=none; b=rbrIc1X/YJM8TVCDe2M2BzjtE3pXvtDn4vKm90J5rbaZPjl1z7E9jlYsUCEYTpFByogpvB+HiQKVwK2UHE1DXjUmHcNQcwd8ncbfT+oASSATLxuk3dBqy4MRORPLRwQKFAh+c2bSXlmDhMId47XQaD4+2Pd4K8FqTWChkkCulKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294135; c=relaxed/simple;
	bh=VJ83icHLnnw75ULuqPgb8SQQIGTg2TUPwTh4g/xXRRw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pCcEZoiRTJH/oI+bBBD7P720NSizXrLLT6KzxHCDx/Y5J9xfA5MsOVMtThsG2n/d5vrzD3oEfoXec2Usoy3XNI5BeYo915z0V7PsEnPKjM5KTQz2YdPvG+NY+x4UyANjESxxG0DkxH5faQU2rdx6DxmNiJA93UpacuDlvkk+pR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnKvUD08; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755294133; x=1786830133;
  h=date:from:to:cc:subject:message-id;
  bh=VJ83icHLnnw75ULuqPgb8SQQIGTg2TUPwTh4g/xXRRw=;
  b=AnKvUD082lANpIATiY1BHGPW0rqwt84OjxPtWxvUMi/Yg1SwERVPkxMB
   JXagPJq6BWmtbgIkVbEMmmTXzGhZlGn8kg/Y2cKTixW7BaeRKYoQBSWlz
   2xnJXM3RYrig8wz57a1QAWFqWpLE0zQz7ixzG8yAj+gnr6JWlL0Zl8FDE
   mLGVJYFv6XGKbLpwY9gGzLP4Tu1tZXB8XBpmZw4jNW2cYawYVl33+V4+t
   qpNhKgbTty1ju188KxdKn36/kRkQa0UrABebIR6DZPRn9dlT817BFljDi
   ar6ezXnLaZ5TiHuya9nxd12T1HbIE7Gy6TcIW5RW4UahS5cbAwapapSwn
   g==;
X-CSE-ConnectionGUID: K23lIWKeSNOqk0jlPcJOhg==
X-CSE-MsgGUID: LN4vDHWZSlqgX1vdMjkxmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="83045061"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="83045061"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:42:11 -0700
X-CSE-ConnectionGUID: SyJ5Z0N4QZG/7rj1AWsY7A==
X-CSE-MsgGUID: oT30CHOfTWuyp90t7ofT2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172315427"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2025 14:42:07 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un2BZ-000CMy-0s;
	Fri, 15 Aug 2025 21:42:05 +0000
Date: Sat, 16 Aug 2025 05:42:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:capability-search] BUILD SUCCESS
 312ed8c59e3a93b3fed59ea740c45519858d0352
Message-ID: <202508160556.Zwgg7MwV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git capability-search
branch HEAD: 312ed8c59e3a93b3fed59ea740c45519858d0352  PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets

elapsed time: 1453m

configs tested: 330
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250815    clang-22
arc                   randconfig-001-20250815    gcc-8.5.0
arc                   randconfig-001-20250816    gcc-8.5.0
arc                   randconfig-002-20250815    clang-22
arc                   randconfig-002-20250815    gcc-9.5.0
arc                   randconfig-002-20250816    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                      footbridge_defconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250815    clang-16
arm                   randconfig-001-20250815    clang-22
arm                   randconfig-001-20250816    gcc-8.5.0
arm                   randconfig-002-20250815    clang-18
arm                   randconfig-002-20250815    clang-22
arm                   randconfig-002-20250816    gcc-8.5.0
arm                   randconfig-003-20250815    clang-22
arm                   randconfig-003-20250815    gcc-14.3.0
arm                   randconfig-003-20250816    gcc-8.5.0
arm                   randconfig-004-20250815    clang-22
arm                   randconfig-004-20250815    gcc-8.5.0
arm                   randconfig-004-20250816    gcc-8.5.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250815    clang-22
arm64                 randconfig-001-20250815    gcc-8.5.0
arm64                 randconfig-001-20250816    gcc-8.5.0
arm64                 randconfig-002-20250815    clang-22
arm64                 randconfig-002-20250815    gcc-8.5.0
arm64                 randconfig-002-20250816    gcc-8.5.0
arm64                 randconfig-003-20250815    clang-22
arm64                 randconfig-003-20250816    gcc-8.5.0
arm64                 randconfig-004-20250815    clang-22
arm64                 randconfig-004-20250815    gcc-15.1.0
arm64                 randconfig-004-20250816    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250815    gcc-11.5.0
csky                  randconfig-001-20250815    gcc-15.1.0
csky                  randconfig-001-20250816    clang-22
csky                  randconfig-002-20250815    gcc-11.5.0
csky                  randconfig-002-20250815    gcc-15.1.0
csky                  randconfig-002-20250816    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250815    clang-22
hexagon               randconfig-001-20250815    gcc-11.5.0
hexagon               randconfig-001-20250816    clang-22
hexagon               randconfig-002-20250815    clang-22
hexagon               randconfig-002-20250815    gcc-11.5.0
hexagon               randconfig-002-20250816    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-001-20250816    clang-20
i386        buildonly-randconfig-002-20250815    clang-20
i386        buildonly-randconfig-002-20250815    gcc-12
i386        buildonly-randconfig-002-20250816    clang-20
i386        buildonly-randconfig-003-20250815    clang-20
i386        buildonly-randconfig-003-20250815    gcc-12
i386        buildonly-randconfig-003-20250816    clang-20
i386        buildonly-randconfig-004-20250815    clang-20
i386        buildonly-randconfig-004-20250815    gcc-12
i386        buildonly-randconfig-004-20250816    clang-20
i386        buildonly-randconfig-005-20250815    clang-20
i386        buildonly-randconfig-005-20250815    gcc-12
i386        buildonly-randconfig-005-20250816    clang-20
i386        buildonly-randconfig-006-20250815    gcc-12
i386        buildonly-randconfig-006-20250816    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250815    gcc-12
i386                  randconfig-001-20250816    clang-20
i386                  randconfig-002-20250815    gcc-12
i386                  randconfig-002-20250816    clang-20
i386                  randconfig-003-20250815    gcc-12
i386                  randconfig-003-20250816    clang-20
i386                  randconfig-004-20250815    gcc-12
i386                  randconfig-004-20250816    clang-20
i386                  randconfig-005-20250815    gcc-12
i386                  randconfig-005-20250816    clang-20
i386                  randconfig-006-20250815    gcc-12
i386                  randconfig-006-20250816    clang-20
i386                  randconfig-007-20250815    gcc-12
i386                  randconfig-007-20250816    clang-20
i386                  randconfig-011-20250815    gcc-12
i386                  randconfig-011-20250816    clang-20
i386                  randconfig-012-20250815    gcc-12
i386                  randconfig-012-20250816    clang-20
i386                  randconfig-013-20250815    gcc-12
i386                  randconfig-013-20250816    clang-20
i386                  randconfig-014-20250815    gcc-12
i386                  randconfig-014-20250816    clang-20
i386                  randconfig-015-20250815    gcc-12
i386                  randconfig-015-20250816    clang-20
i386                  randconfig-016-20250815    gcc-12
i386                  randconfig-016-20250816    clang-20
i386                  randconfig-017-20250815    gcc-12
i386                  randconfig-017-20250816    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250815    clang-22
loongarch             randconfig-001-20250815    gcc-11.5.0
loongarch             randconfig-001-20250816    clang-22
loongarch             randconfig-002-20250815    clang-20
loongarch             randconfig-002-20250815    gcc-11.5.0
loongarch             randconfig-002-20250816    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    gcc-15.1.0
mips                       rbtx49xx_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-001-20250816    clang-22
nios2                 randconfig-002-20250815    gcc-11.5.0
nios2                 randconfig-002-20250816    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250815    gcc-11.5.0
parisc                randconfig-001-20250815    gcc-8.5.0
parisc                randconfig-001-20250816    clang-22
parisc                randconfig-002-20250815    gcc-11.5.0
parisc                randconfig-002-20250815    gcc-14.3.0
parisc                randconfig-002-20250816    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-001-20250816    clang-22
powerpc               randconfig-002-20250815    clang-19
powerpc               randconfig-002-20250815    gcc-11.5.0
powerpc               randconfig-002-20250816    clang-22
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc               randconfig-003-20250816    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250815    gcc-14.3.0
powerpc64             randconfig-001-20250816    clang-22
powerpc64             randconfig-002-20250815    gcc-10.5.0
powerpc64             randconfig-002-20250815    gcc-11.5.0
powerpc64             randconfig-002-20250816    clang-22
powerpc64             randconfig-003-20250815    clang-22
powerpc64             randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-003-20250816    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250815    gcc-12.5.0
riscv                 randconfig-001-20250815    gcc-8.5.0
riscv                 randconfig-001-20250816    clang-22
riscv                 randconfig-002-20250815    gcc-8.5.0
riscv                 randconfig-002-20250816    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250815    gcc-8.5.0
s390                  randconfig-001-20250816    clang-22
s390                  randconfig-002-20250815    clang-22
s390                  randconfig-002-20250815    gcc-8.5.0
s390                  randconfig-002-20250816    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    clang-22
sh                    randconfig-001-20250815    gcc-11.5.0
sh                    randconfig-001-20250815    gcc-8.5.0
sh                    randconfig-001-20250816    clang-22
sh                    randconfig-002-20250815    gcc-12.5.0
sh                    randconfig-002-20250815    gcc-8.5.0
sh                    randconfig-002-20250816    clang-22
sh                      rts7751r2d1_defconfig    clang-22
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250815    gcc-11.5.0
sparc                 randconfig-001-20250815    gcc-8.5.0
sparc                 randconfig-001-20250816    clang-22
sparc                 randconfig-002-20250815    gcc-13.4.0
sparc                 randconfig-002-20250815    gcc-8.5.0
sparc                 randconfig-002-20250816    clang-22
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250815    clang-22
sparc64               randconfig-001-20250815    gcc-8.5.0
sparc64               randconfig-001-20250816    clang-22
sparc64               randconfig-002-20250815    gcc-15.1.0
sparc64               randconfig-002-20250815    gcc-8.5.0
sparc64               randconfig-002-20250816    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250815    gcc-12
um                    randconfig-001-20250815    gcc-8.5.0
um                    randconfig-001-20250816    clang-22
um                    randconfig-002-20250815    clang-19
um                    randconfig-002-20250815    gcc-8.5.0
um                    randconfig-002-20250816    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250815    clang-20
x86_64      buildonly-randconfig-001-20250815    gcc-12
x86_64      buildonly-randconfig-001-20250816    gcc-12
x86_64      buildonly-randconfig-002-20250815    gcc-12
x86_64      buildonly-randconfig-002-20250816    gcc-12
x86_64      buildonly-randconfig-003-20250815    gcc-12
x86_64      buildonly-randconfig-003-20250816    gcc-12
x86_64      buildonly-randconfig-004-20250815    clang-20
x86_64      buildonly-randconfig-004-20250815    gcc-12
x86_64      buildonly-randconfig-004-20250816    gcc-12
x86_64      buildonly-randconfig-005-20250815    clang-20
x86_64      buildonly-randconfig-005-20250815    gcc-12
x86_64      buildonly-randconfig-005-20250816    gcc-12
x86_64      buildonly-randconfig-006-20250815    gcc-12
x86_64      buildonly-randconfig-006-20250816    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250815    gcc-12
x86_64                randconfig-001-20250816    clang-20
x86_64                randconfig-002-20250815    gcc-12
x86_64                randconfig-002-20250816    clang-20
x86_64                randconfig-003-20250815    gcc-12
x86_64                randconfig-003-20250816    clang-20
x86_64                randconfig-004-20250815    gcc-12
x86_64                randconfig-004-20250816    clang-20
x86_64                randconfig-005-20250815    gcc-12
x86_64                randconfig-005-20250816    clang-20
x86_64                randconfig-006-20250815    gcc-12
x86_64                randconfig-006-20250816    clang-20
x86_64                randconfig-007-20250815    gcc-12
x86_64                randconfig-007-20250816    clang-20
x86_64                randconfig-008-20250815    gcc-12
x86_64                randconfig-008-20250816    clang-20
x86_64                randconfig-071-20250815    clang-20
x86_64                randconfig-071-20250816    gcc-11
x86_64                randconfig-072-20250815    clang-20
x86_64                randconfig-072-20250816    gcc-11
x86_64                randconfig-073-20250815    clang-20
x86_64                randconfig-073-20250816    gcc-11
x86_64                randconfig-074-20250815    clang-20
x86_64                randconfig-074-20250816    gcc-11
x86_64                randconfig-075-20250815    clang-20
x86_64                randconfig-075-20250816    gcc-11
x86_64                randconfig-076-20250815    clang-20
x86_64                randconfig-076-20250816    gcc-11
x86_64                randconfig-077-20250815    clang-20
x86_64                randconfig-077-20250816    gcc-11
x86_64                randconfig-078-20250815    clang-20
x86_64                randconfig-078-20250816    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250815    gcc-8.5.0
xtensa                randconfig-001-20250816    clang-22
xtensa                randconfig-002-20250815    gcc-15.1.0
xtensa                randconfig-002-20250815    gcc-8.5.0
xtensa                randconfig-002-20250816    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

