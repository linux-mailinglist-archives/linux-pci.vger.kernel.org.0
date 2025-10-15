Return-Path: <linux-pci+bounces-38287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D5BE1070
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 01:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272174E1692
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802B30BB99;
	Wed, 15 Oct 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcyB7iOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA1129E6E
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760570893; cv=none; b=sGMNBLpyHrUmonXxfVSXAdCrFXbK3+zZeugqsq+QqhebThtkNnFUEC2ZzfuUytj8mtvndd/HGfnAeX9wCi/+orozPdi9DXzScbhjSW5BtrOoxxJhgJH69zJHtjtdSZPE8cx0jNb3hBwB36ezvzHVVPl2QiNN//NAkxp/2yoFuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760570893; c=relaxed/simple;
	bh=qobN+Ru6aFufzSsKp1uJ03A4RVZ4D8zK6SuvjMQBK3k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DSbghx8aHcfy7b71Y30BqI+H18Ym60hTiPYiJdfVrYTVJvYZATYmWcax2YSJV3Zv2iX838uzghZdm1gljFZqyN33xb3EbQvi/hRt95Ga8lWEzqJRh06HyElqwUX340oRjzhHXh4cl9IlyuK0HYbKmJxoZ2aglL0OpRml9dkEd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcyB7iOY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760570891; x=1792106891;
  h=date:from:to:cc:subject:message-id;
  bh=qobN+Ru6aFufzSsKp1uJ03A4RVZ4D8zK6SuvjMQBK3k=;
  b=QcyB7iOY9sANcF2U/hhMoFUp8tNnh+PCnPxyL820ZuQddt5aR3diqonI
   APiV7EVdE8IjI0eOHTWw637r6FSaEQJavJQmMFeqtZv0pO3GizYJ5TSWG
   zQ521YvjADx/OQ+e959l3S+TDj08b+xOBsnhWtKlHSlS0QxorDjVOeri3
   qkaj9G8L92b2DeVJ0Lm1SEHbgHmlnPoYeIkayux10zUuyw9JY3JyxRK00
   oJAOtQR4q5VFATih+RHmBkHYYJq5Rd2egHy+M9dtQvHDyTfzgkZjozeWo
   75BfrFXoE3OrTVx9MCQ/mx8sWX8Tr+UJjZBGDlta5GJAwkhxvxWB6oQX5
   g==;
X-CSE-ConnectionGUID: QhIfueL7QM2aaOrxdAeBAA==
X-CSE-MsgGUID: SQQpu48wROm87rGGWSYNkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62851876"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="62851876"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 16:27:43 -0700
X-CSE-ConnectionGUID: gldXdY1UQmC6jSRvwAL/Nw==
X-CSE-MsgGUID: XQSBu+z7SD2rDXCEROCzvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182286166"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 15 Oct 2025 16:27:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9AuB-0004I3-2A;
	Wed, 15 Oct 2025 23:27:39 +0000
Date: Thu, 16 Oct 2025 07:26:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD REGRESSION
 f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01
Message-ID: <202510160744.6ZojK8kI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01  PCI/VGA: Select SCREEN_INFO on X86

Error/Warning ids grouped by kconfigs:

recent_errors
`-- mips-allyesconfig
    |-- (.head.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
    `-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary

elapsed time: 1447m

configs tested: 297
configs skipped: 5

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
arc                   randconfig-001-20251015    gcc-8.5.0
arc                   randconfig-001-20251016    clang-22
arc                   randconfig-002-20251015    gcc-8.5.0
arc                   randconfig-002-20251016    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g5_defconfig    clang-22
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          ep93xx_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20251015    clang-22
arm                   randconfig-001-20251015    gcc-8.5.0
arm                   randconfig-001-20251016    clang-22
arm                   randconfig-002-20251015    clang-22
arm                   randconfig-002-20251015    gcc-8.5.0
arm                   randconfig-002-20251016    clang-22
arm                   randconfig-003-20251015    gcc-8.5.0
arm                   randconfig-003-20251016    clang-22
arm                   randconfig-004-20251015    clang-22
arm                   randconfig-004-20251015    gcc-8.5.0
arm                   randconfig-004-20251016    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251015    clang-22
arm64                 randconfig-001-20251015    gcc-8.5.0
arm64                 randconfig-001-20251016    clang-22
arm64                 randconfig-002-20251015    gcc-13.4.0
arm64                 randconfig-002-20251015    gcc-8.5.0
arm64                 randconfig-002-20251016    clang-22
arm64                 randconfig-003-20251015    clang-22
arm64                 randconfig-003-20251015    gcc-8.5.0
arm64                 randconfig-003-20251016    clang-22
arm64                 randconfig-004-20251015    clang-22
arm64                 randconfig-004-20251015    gcc-8.5.0
arm64                 randconfig-004-20251016    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251015    clang-22
csky                  randconfig-001-20251015    gcc-15.1.0
csky                  randconfig-002-20251015    clang-22
csky                  randconfig-002-20251015    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251015    clang-22
hexagon               randconfig-002-20251015    clang-19
hexagon               randconfig-002-20251015    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251015    clang-20
i386        buildonly-randconfig-001-20251015    gcc-13
i386        buildonly-randconfig-001-20251016    clang-20
i386        buildonly-randconfig-002-20251015    clang-20
i386        buildonly-randconfig-002-20251015    gcc-14
i386        buildonly-randconfig-002-20251016    clang-20
i386        buildonly-randconfig-003-20251015    clang-20
i386        buildonly-randconfig-003-20251016    clang-20
i386        buildonly-randconfig-004-20251015    clang-20
i386        buildonly-randconfig-004-20251016    clang-20
i386        buildonly-randconfig-005-20251015    clang-20
i386        buildonly-randconfig-005-20251016    clang-20
i386        buildonly-randconfig-006-20251015    clang-20
i386        buildonly-randconfig-006-20251016    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251015    clang-20
i386                  randconfig-001-20251016    clang-20
i386                  randconfig-002-20251015    clang-20
i386                  randconfig-002-20251016    clang-20
i386                  randconfig-003-20251015    clang-20
i386                  randconfig-003-20251016    clang-20
i386                  randconfig-004-20251015    clang-20
i386                  randconfig-004-20251016    clang-20
i386                  randconfig-005-20251015    clang-20
i386                  randconfig-005-20251016    clang-20
i386                  randconfig-006-20251015    clang-20
i386                  randconfig-006-20251016    clang-20
i386                  randconfig-007-20251015    clang-20
i386                  randconfig-007-20251016    clang-20
i386                  randconfig-011-20251015    clang-20
i386                  randconfig-011-20251016    gcc-14
i386                  randconfig-012-20251015    clang-20
i386                  randconfig-012-20251016    gcc-14
i386                  randconfig-013-20251015    clang-20
i386                  randconfig-013-20251016    gcc-14
i386                  randconfig-014-20251015    clang-20
i386                  randconfig-014-20251016    gcc-14
i386                  randconfig-015-20251015    clang-20
i386                  randconfig-015-20251016    gcc-14
i386                  randconfig-016-20251015    clang-20
i386                  randconfig-016-20251016    gcc-14
i386                  randconfig-017-20251015    clang-20
i386                  randconfig-017-20251016    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251015    clang-22
loongarch             randconfig-001-20251015    gcc-15.1.0
loongarch             randconfig-002-20251015    clang-22
loongarch             randconfig-002-20251015    gcc-15.1.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251015    clang-22
nios2                 randconfig-001-20251015    gcc-8.5.0
nios2                 randconfig-002-20251015    clang-22
nios2                 randconfig-002-20251015    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251015    clang-22
parisc                randconfig-001-20251015    gcc-9.5.0
parisc                randconfig-002-20251015    clang-22
parisc                randconfig-002-20251015    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20251015    clang-22
powerpc               randconfig-001-20251015    gcc-15.1.0
powerpc               randconfig-002-20251015    clang-22
powerpc               randconfig-002-20251015    gcc-12.5.0
powerpc               randconfig-003-20251015    clang-22
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64                        alldefconfig    gcc-15.1.0
powerpc64             randconfig-001-20251015    clang-22
powerpc64             randconfig-002-20251015    clang-22
powerpc64             randconfig-003-20251015    clang-22
powerpc64             randconfig-003-20251015    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20251015    clang-22
riscv                 randconfig-001-20251015    gcc-10.5.0
riscv                 randconfig-001-20251016    gcc-10.5.0
riscv                 randconfig-002-20251015    clang-22
riscv                 randconfig-002-20251016    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251015    clang-22
s390                  randconfig-001-20251015    gcc-12.5.0
s390                  randconfig-001-20251016    gcc-10.5.0
s390                  randconfig-002-20251015    clang-22
s390                  randconfig-002-20251016    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251015    clang-22
sh                    randconfig-001-20251015    gcc-11.5.0
sh                    randconfig-001-20251016    gcc-10.5.0
sh                    randconfig-002-20251015    clang-22
sh                    randconfig-002-20251015    gcc-11.5.0
sh                    randconfig-002-20251016    gcc-10.5.0
sh                          rsk7269_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251015    clang-22
sparc                 randconfig-001-20251015    gcc-8.5.0
sparc                 randconfig-001-20251016    gcc-10.5.0
sparc                 randconfig-002-20251015    clang-22
sparc                 randconfig-002-20251015    gcc-13.4.0
sparc                 randconfig-002-20251016    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251015    clang-22
sparc64               randconfig-001-20251016    gcc-10.5.0
sparc64               randconfig-002-20251015    clang-22
sparc64               randconfig-002-20251015    gcc-11.5.0
sparc64               randconfig-002-20251016    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251015    clang-22
um                    randconfig-001-20251016    gcc-10.5.0
um                    randconfig-002-20251015    clang-22
um                    randconfig-002-20251016    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251015    clang-20
x86_64      buildonly-randconfig-001-20251015    gcc-13
x86_64      buildonly-randconfig-002-20251015    gcc-13
x86_64      buildonly-randconfig-002-20251015    gcc-14
x86_64      buildonly-randconfig-003-20251015    clang-20
x86_64      buildonly-randconfig-003-20251015    gcc-13
x86_64      buildonly-randconfig-004-20251015    clang-20
x86_64      buildonly-randconfig-004-20251015    gcc-13
x86_64      buildonly-randconfig-005-20251015    gcc-13
x86_64      buildonly-randconfig-005-20251015    gcc-14
x86_64      buildonly-randconfig-006-20251015    gcc-13
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251015    clang-20
x86_64                randconfig-001-20251016    clang-20
x86_64                randconfig-002-20251015    clang-20
x86_64                randconfig-002-20251016    clang-20
x86_64                randconfig-003-20251015    clang-20
x86_64                randconfig-003-20251016    clang-20
x86_64                randconfig-004-20251015    clang-20
x86_64                randconfig-004-20251016    clang-20
x86_64                randconfig-005-20251015    clang-20
x86_64                randconfig-005-20251016    clang-20
x86_64                randconfig-006-20251015    clang-20
x86_64                randconfig-006-20251016    clang-20
x86_64                randconfig-007-20251015    clang-20
x86_64                randconfig-007-20251016    clang-20
x86_64                randconfig-008-20251015    clang-20
x86_64                randconfig-008-20251016    clang-20
x86_64                randconfig-071-20251015    gcc-14
x86_64                randconfig-072-20251015    gcc-14
x86_64                randconfig-073-20251015    gcc-14
x86_64                randconfig-074-20251015    gcc-14
x86_64                randconfig-075-20251015    gcc-14
x86_64                randconfig-076-20251015    gcc-14
x86_64                randconfig-077-20251015    gcc-14
x86_64                randconfig-078-20251015    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251015    clang-22
xtensa                randconfig-001-20251015    gcc-9.5.0
xtensa                randconfig-001-20251016    gcc-10.5.0
xtensa                randconfig-002-20251015    clang-22
xtensa                randconfig-002-20251015    gcc-15.1.0
xtensa                randconfig-002-20251016    gcc-10.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

