Return-Path: <linux-pci+bounces-38830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898DBF42D8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB78034FDAF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4561922FD;
	Tue, 21 Oct 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQuXrimo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8417736
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007689; cv=none; b=UddRVyfDSpUyg5r8jur4uJc8GJtLwnqIcIQgPlt1aXbXsaw8BXtoO58JsJiSYfE9u2H3jzWP6xwTYLa4OPot+F5Hl3TojACNtdPNOyIpaRyb8q5//D5e2nNY4GhfllL2Fwyeft9E93J65i5A4LxkhlBoboOcecj8jR+v6ua+pJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007689; c=relaxed/simple;
	bh=FoX+KMMNv/ozf5f5ssIVd/ZG96F3FCG27rdL/Cmh+vY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J+A0kapm8Stxc1giaV2SiDAR/yGLtk5oXmXaQFhXq+jVYSIx5K8LVSj2QesyggnCDTYX7WgcXRKYvGkflwpfxRMjFcV6ua9kVUdKPJaW3wnYfc0hSnW2Si1i89k2Qm7t9QMWLt4h1GCgbVeglM+Coftbc3KIse761Uy8RvvrKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQuXrimo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761007688; x=1792543688;
  h=date:from:to:cc:subject:message-id;
  bh=FoX+KMMNv/ozf5f5ssIVd/ZG96F3FCG27rdL/Cmh+vY=;
  b=jQuXrimoix1KADXIcYg7quxCmlne7NN+fWyRzWD52+YCMr+g4jmqH4l0
   h07OkS+mS4L73ftzEBRPzKUXeEFTNBEGrr737uZBy/IrK2qVVyIWt1Lwe
   ID9lmAcGe1jjEtnrRuU1GJUPcL6z09rNA4XPY021ako4pKm1+tKOeitIs
   Xvj8FRcfDywWjqUn05f4iW+BNBAO/WvM9uSFK0UWUf5X9zoibmfssCvGy
   A6aWDZuGvVA4EbO+rbEfHEstwgvkD/1jJGYZ9jwVEC5fk4+GIOzTdfWSN
   Z1Zs3NX28wrWHU8WJEcWIaWkR7/PSGOk3oMbhk5NiR1k5knSfKhCZmIGg
   g==;
X-CSE-ConnectionGUID: TUC3zmPLQMSZaYwrlIfRhw==
X-CSE-MsgGUID: OigePRXcTQmLAhwbXsMeqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74569059"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="74569059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 17:48:07 -0700
X-CSE-ConnectionGUID: hu77YbtwRYOgUwnrtCQqDQ==
X-CSE-MsgGUID: DR/1QDZISxGx2ns9Ayd+Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="220623625"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Oct 2025 17:48:05 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vB0Xj-000AIv-08;
	Tue, 21 Oct 2025 00:48:03 +0000
Date: Tue, 21 Oct 2025 08:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 ad6014f77f6b66e862a912b5aa4571d00ab30405
Message-ID: <202510210841.SLUe69Nf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: ad6014f77f6b66e862a912b5aa4571d00ab30405  PCI: brcmstb: Fix disabling L0s capability

elapsed time: 1058m

configs tested: 217
configs skipped: 10

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
arc                   randconfig-001-20251020    gcc-14.3.0
arc                   randconfig-002-20251020    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20251020    gcc-14.3.0
arm                   randconfig-002-20251020    clang-22
arm                   randconfig-003-20251020    clang-22
arm                   randconfig-004-20251020    clang-22
arm                         s3c6400_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251020    clang-22
arm64                 randconfig-002-20251020    gcc-12.5.0
arm64                 randconfig-003-20251020    gcc-8.5.0
arm64                 randconfig-004-20251020    gcc-10.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251020    gcc-15.1.0
csky                  randconfig-002-20251020    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251020    clang-22
hexagon               randconfig-002-20251020    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251020    gcc-14
i386        buildonly-randconfig-001-20251021    clang-20
i386        buildonly-randconfig-002-20251020    clang-20
i386        buildonly-randconfig-002-20251021    clang-20
i386        buildonly-randconfig-003-20251020    gcc-14
i386        buildonly-randconfig-003-20251021    clang-20
i386        buildonly-randconfig-004-20251020    gcc-14
i386        buildonly-randconfig-004-20251021    clang-20
i386        buildonly-randconfig-005-20251020    clang-20
i386        buildonly-randconfig-005-20251021    clang-20
i386        buildonly-randconfig-006-20251020    clang-20
i386        buildonly-randconfig-006-20251021    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251020    gcc-14
i386                  randconfig-002-20251020    gcc-14
i386                  randconfig-003-20251020    gcc-14
i386                  randconfig-004-20251020    gcc-14
i386                  randconfig-005-20251020    gcc-14
i386                  randconfig-006-20251020    gcc-14
i386                  randconfig-007-20251020    gcc-14
i386                  randconfig-011-20251020    clang-20
i386                  randconfig-012-20251020    clang-20
i386                  randconfig-013-20251020    clang-20
i386                  randconfig-014-20251020    clang-20
i386                  randconfig-015-20251020    clang-20
i386                  randconfig-016-20251020    clang-20
i386                  randconfig-017-20251020    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251020    gcc-15.1.0
loongarch             randconfig-002-20251020    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251020    gcc-10.5.0
nios2                 randconfig-002-20251020    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251020    gcc-13.4.0
parisc                randconfig-002-20251020    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251020    clang-22
powerpc               randconfig-002-20251020    gcc-8.5.0
powerpc               randconfig-003-20251020    clang-22
powerpc                     tqm8548_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251020    clang-19
powerpc64             randconfig-002-20251020    gcc-11.5.0
powerpc64             randconfig-003-20251020    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251020    gcc-13.4.0
riscv                 randconfig-002-20251020    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251020    gcc-13.4.0
s390                  randconfig-002-20251020    clang-22
s390                  randconfig-002-20251020    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251020    gcc-13.4.0
sh                    randconfig-002-20251020    gcc-13.4.0
sh                           se7750_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251020    gcc-13.4.0
sparc                 randconfig-002-20251020    gcc-13.4.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251020    gcc-13.4.0
sparc64               randconfig-002-20251020    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251020    clang-22
um                    randconfig-001-20251020    gcc-13.4.0
um                    randconfig-002-20251020    clang-22
um                    randconfig-002-20251020    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251021    clang-20
x86_64      buildonly-randconfig-002-20251021    clang-20
x86_64      buildonly-randconfig-003-20251021    clang-20
x86_64      buildonly-randconfig-004-20251021    clang-20
x86_64      buildonly-randconfig-005-20251021    clang-20
x86_64      buildonly-randconfig-006-20251021    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251020    clang-20
x86_64                randconfig-001-20251021    gcc-14
x86_64                randconfig-002-20251020    clang-20
x86_64                randconfig-002-20251021    gcc-14
x86_64                randconfig-003-20251020    clang-20
x86_64                randconfig-003-20251021    gcc-14
x86_64                randconfig-004-20251020    clang-20
x86_64                randconfig-004-20251021    gcc-14
x86_64                randconfig-005-20251020    clang-20
x86_64                randconfig-005-20251021    gcc-14
x86_64                randconfig-006-20251020    clang-20
x86_64                randconfig-006-20251021    gcc-14
x86_64                randconfig-007-20251020    clang-20
x86_64                randconfig-007-20251021    gcc-14
x86_64                randconfig-008-20251020    clang-20
x86_64                randconfig-008-20251021    gcc-14
x86_64                randconfig-071-20251021    gcc-14
x86_64                randconfig-072-20251021    gcc-14
x86_64                randconfig-073-20251021    gcc-14
x86_64                randconfig-074-20251021    gcc-14
x86_64                randconfig-075-20251021    gcc-14
x86_64                randconfig-076-20251021    gcc-14
x86_64                randconfig-077-20251021    gcc-14
x86_64                randconfig-078-20251021    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251020    gcc-13.4.0
xtensa                randconfig-001-20251020    gcc-8.5.0
xtensa                randconfig-002-20251020    gcc-13.4.0
xtensa                randconfig-002-20251020    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

