Return-Path: <linux-pci+bounces-37144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A552BA53AF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B733B3D46
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9B1E8337;
	Fri, 26 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvh87KMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A62FE078
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922330; cv=none; b=BcPPDdjchkllfWHVoAXiMD85qhGmOxBbkafiXARmq3dR8zSXUi+T+ZpiZ8i1qXDJKrXOiBuRNnm1Vo4ROpLw0gUCCS4zrZCNMwkcKhrQNLh38jnblD5vbyzKBxNI6XyltzvTT8Tnd/wWJvYXIgUAvghibr4zRw3D0Mo2VU0Nx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922330; c=relaxed/simple;
	bh=Ep57ByS+elOhV1qjBgoHJPADNEIgzwZEsgHSJCLu+8M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iapg28lGa+MqB0E7+UTMgXNiNeCILmasCQcWC0z3/f+MLyM2MFUfJIAkuV0V4siB3X2Y98uG9GA9UqvgJcx60ArgTUbss5F8g9DdcNUqaL9iNo8oVBK2RjaqAsg60yXwza3OU2xxKTQThzllHb922WKxWXZ5DezN3ZJ+/m1gtMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvh87KMI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758922328; x=1790458328;
  h=date:from:to:cc:subject:message-id;
  bh=Ep57ByS+elOhV1qjBgoHJPADNEIgzwZEsgHSJCLu+8M=;
  b=bvh87KMI8IQTggYqZB2MY7JpdudGF6a7AxfFjJmuBZzNfaq58YS83z24
   y9NpA2pjEa/+Ym6eLbr7JMcQH+PUIdxcsRy5tAc++sae8TOb970osU4NN
   bsY1kjkbRCMb0jcoW75GBJnG+NXPysapucjBVrgS79+BYvIjZiMJ4A9pv
   f5PPa3NXo9ZegUsMmV42hagZJsObzNR13xOteFzM1+6fclFMclOZ6fgSZ
   cpJF0R083MkhT3VarNvrJ5VgzxPKlDPUnXH3vXpe64DQuJdZV6JXad78L
   aysglemtim3+4tUvZdeQJ3Go/mexusyik95+LDb7uoUWIwCFsiqfp+vBl
   A==;
X-CSE-ConnectionGUID: PHFjCxWXRdixqZN2q8PNeg==
X-CSE-MsgGUID: nlJlwm+HQSSpU08NJiRjRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61371921"
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="61371921"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 14:32:07 -0700
X-CSE-ConnectionGUID: 2f2QgHX2RgiSBBJvHWHwVg==
X-CSE-MsgGUID: DLJYu8nDQC6m0A7QYaQV1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="214847503"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 26 Sep 2025 14:32:07 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2G2t-0006cv-2b;
	Fri, 26 Sep 2025 21:32:03 +0000
Date: Sat, 27 Sep 2025 05:31:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 668b42687b947b5d395eb5f2a9b98a1d4db638df
Message-ID: <202509270546.8yvVseDO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 668b42687b947b5d395eb5f2a9b98a1d4db638df  PCI: imx6: Assert CLKREQ# during host controller initialization

elapsed time: 1325m

configs tested: 313
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250926    gcc-8.5.0
arc                   randconfig-001-20250927    gcc-10.5.0
arc                   randconfig-002-20250926    gcc-8.5.0
arc                   randconfig-002-20250926    gcc-9.5.0
arc                   randconfig-002-20250927    gcc-10.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         axm55xx_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            dove_defconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                          pxa910_defconfig    clang-22
arm                   randconfig-001-20250926    clang-22
arm                   randconfig-001-20250926    gcc-8.5.0
arm                   randconfig-001-20250927    gcc-10.5.0
arm                   randconfig-002-20250926    clang-17
arm                   randconfig-002-20250926    gcc-8.5.0
arm                   randconfig-002-20250927    gcc-10.5.0
arm                   randconfig-003-20250926    clang-22
arm                   randconfig-003-20250926    gcc-8.5.0
arm                   randconfig-003-20250927    gcc-10.5.0
arm                   randconfig-004-20250926    clang-22
arm                   randconfig-004-20250926    gcc-8.5.0
arm                   randconfig-004-20250927    gcc-10.5.0
arm                        realview_defconfig    gcc-15.1.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            alldefconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250926    gcc-8.5.0
arm64                 randconfig-001-20250927    gcc-10.5.0
arm64                 randconfig-002-20250926    gcc-12.5.0
arm64                 randconfig-002-20250926    gcc-8.5.0
arm64                 randconfig-002-20250927    gcc-10.5.0
arm64                 randconfig-003-20250926    gcc-8.5.0
arm64                 randconfig-003-20250926    gcc-9.5.0
arm64                 randconfig-003-20250927    gcc-10.5.0
arm64                 randconfig-004-20250926    clang-22
arm64                 randconfig-004-20250926    gcc-8.5.0
arm64                 randconfig-004-20250927    gcc-10.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250926    clang-22
csky                  randconfig-001-20250926    gcc-15.1.0
csky                  randconfig-001-20250927    clang-22
csky                  randconfig-002-20250926    clang-22
csky                  randconfig-002-20250926    gcc-14.3.0
csky                  randconfig-002-20250927    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250926    clang-22
hexagon               randconfig-001-20250927    clang-22
hexagon               randconfig-002-20250926    clang-22
hexagon               randconfig-002-20250927    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250926    clang-20
i386        buildonly-randconfig-001-20250927    clang-20
i386        buildonly-randconfig-002-20250926    clang-20
i386        buildonly-randconfig-002-20250927    clang-20
i386        buildonly-randconfig-003-20250926    clang-20
i386        buildonly-randconfig-003-20250927    clang-20
i386        buildonly-randconfig-004-20250926    clang-20
i386        buildonly-randconfig-004-20250927    clang-20
i386        buildonly-randconfig-005-20250926    clang-20
i386        buildonly-randconfig-005-20250927    clang-20
i386        buildonly-randconfig-006-20250926    clang-20
i386        buildonly-randconfig-006-20250927    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250926    clang-20
i386                  randconfig-001-20250927    gcc-14
i386                  randconfig-002-20250926    clang-20
i386                  randconfig-002-20250927    gcc-14
i386                  randconfig-003-20250926    clang-20
i386                  randconfig-003-20250927    gcc-14
i386                  randconfig-004-20250926    clang-20
i386                  randconfig-004-20250927    gcc-14
i386                  randconfig-005-20250926    clang-20
i386                  randconfig-005-20250927    gcc-14
i386                  randconfig-006-20250926    clang-20
i386                  randconfig-006-20250927    gcc-14
i386                  randconfig-007-20250926    clang-20
i386                  randconfig-007-20250927    gcc-14
i386                  randconfig-011-20250926    gcc-12
i386                  randconfig-011-20250927    clang-20
i386                  randconfig-012-20250926    gcc-12
i386                  randconfig-012-20250927    clang-20
i386                  randconfig-013-20250926    gcc-12
i386                  randconfig-013-20250927    clang-20
i386                  randconfig-014-20250926    gcc-12
i386                  randconfig-014-20250927    clang-20
i386                  randconfig-015-20250926    gcc-12
i386                  randconfig-015-20250927    clang-20
i386                  randconfig-016-20250926    gcc-12
i386                  randconfig-016-20250927    clang-20
i386                  randconfig-017-20250926    gcc-12
i386                  randconfig-017-20250927    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250926    clang-22
loongarch             randconfig-001-20250926    gcc-15.1.0
loongarch             randconfig-001-20250927    clang-22
loongarch             randconfig-002-20250926    clang-22
loongarch             randconfig-002-20250927    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          multi_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
nios2                         10m50_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250926    clang-22
nios2                 randconfig-001-20250926    gcc-11.5.0
nios2                 randconfig-001-20250927    clang-22
nios2                 randconfig-002-20250926    clang-22
nios2                 randconfig-002-20250926    gcc-8.5.0
nios2                 randconfig-002-20250927    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250926    clang-22
parisc                randconfig-001-20250926    gcc-10.5.0
parisc                randconfig-001-20250927    clang-22
parisc                randconfig-002-20250926    clang-22
parisc                randconfig-002-20250926    gcc-10.5.0
parisc                randconfig-002-20250927    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250926    clang-22
powerpc               randconfig-001-20250927    clang-22
powerpc               randconfig-002-20250926    clang-18
powerpc               randconfig-002-20250926    clang-22
powerpc               randconfig-002-20250927    clang-22
powerpc               randconfig-003-20250926    clang-22
powerpc               randconfig-003-20250927    clang-22
powerpc                     skiroot_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250926    clang-22
powerpc64             randconfig-001-20250927    clang-22
powerpc64             randconfig-002-20250926    clang-16
powerpc64             randconfig-002-20250926    clang-22
powerpc64             randconfig-002-20250927    clang-22
powerpc64             randconfig-003-20250926    clang-22
powerpc64             randconfig-003-20250926    gcc-15.1.0
powerpc64             randconfig-003-20250927    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20250926    clang-22
riscv                 randconfig-001-20250926    gcc-15.1.0
riscv                 randconfig-001-20250927    gcc-11.5.0
riscv                 randconfig-002-20250926    clang-22
riscv                 randconfig-002-20250926    gcc-15.1.0
riscv                 randconfig-002-20250927    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250926    clang-22
s390                  randconfig-001-20250926    gcc-15.1.0
s390                  randconfig-001-20250927    gcc-11.5.0
s390                  randconfig-002-20250926    gcc-15.1.0
s390                  randconfig-002-20250926    gcc-8.5.0
s390                  randconfig-002-20250927    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250926    gcc-12.5.0
sh                    randconfig-001-20250926    gcc-15.1.0
sh                    randconfig-001-20250927    gcc-11.5.0
sh                    randconfig-002-20250926    gcc-15.1.0
sh                    randconfig-002-20250927    gcc-11.5.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                           se7343_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250926    gcc-14.3.0
sparc                 randconfig-001-20250926    gcc-15.1.0
sparc                 randconfig-001-20250927    gcc-11.5.0
sparc                 randconfig-002-20250926    gcc-15.1.0
sparc                 randconfig-002-20250927    gcc-11.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250926    gcc-12.5.0
sparc64               randconfig-001-20250926    gcc-15.1.0
sparc64               randconfig-001-20250927    gcc-11.5.0
sparc64               randconfig-002-20250926    clang-22
sparc64               randconfig-002-20250926    gcc-15.1.0
sparc64               randconfig-002-20250927    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250926    clang-22
um                    randconfig-001-20250926    gcc-15.1.0
um                    randconfig-001-20250927    gcc-11.5.0
um                    randconfig-002-20250926    clang-22
um                    randconfig-002-20250926    gcc-15.1.0
um                    randconfig-002-20250927    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250926    clang-20
x86_64      buildonly-randconfig-001-20250926    gcc-14
x86_64      buildonly-randconfig-001-20250927    gcc-14
x86_64      buildonly-randconfig-002-20250926    clang-20
x86_64      buildonly-randconfig-002-20250926    gcc-14
x86_64      buildonly-randconfig-002-20250927    gcc-14
x86_64      buildonly-randconfig-003-20250926    gcc-14
x86_64      buildonly-randconfig-003-20250927    gcc-14
x86_64      buildonly-randconfig-004-20250926    gcc-14
x86_64      buildonly-randconfig-004-20250927    gcc-14
x86_64      buildonly-randconfig-005-20250926    gcc-14
x86_64      buildonly-randconfig-005-20250927    gcc-14
x86_64      buildonly-randconfig-006-20250926    gcc-14
x86_64      buildonly-randconfig-006-20250927    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250926    gcc-14
x86_64                randconfig-001-20250927    clang-20
x86_64                randconfig-002-20250926    gcc-14
x86_64                randconfig-002-20250927    clang-20
x86_64                randconfig-003-20250926    gcc-14
x86_64                randconfig-003-20250927    clang-20
x86_64                randconfig-004-20250926    gcc-14
x86_64                randconfig-004-20250927    clang-20
x86_64                randconfig-005-20250926    gcc-14
x86_64                randconfig-005-20250927    clang-20
x86_64                randconfig-006-20250926    gcc-14
x86_64                randconfig-006-20250927    clang-20
x86_64                randconfig-007-20250926    gcc-14
x86_64                randconfig-007-20250927    clang-20
x86_64                randconfig-008-20250926    gcc-14
x86_64                randconfig-008-20250927    clang-20
x86_64                randconfig-071-20250926    gcc-14
x86_64                randconfig-071-20250927    gcc-14
x86_64                randconfig-072-20250926    gcc-14
x86_64                randconfig-072-20250927    gcc-14
x86_64                randconfig-073-20250926    gcc-14
x86_64                randconfig-073-20250927    gcc-14
x86_64                randconfig-074-20250926    gcc-14
x86_64                randconfig-074-20250927    gcc-14
x86_64                randconfig-075-20250926    gcc-14
x86_64                randconfig-075-20250927    gcc-14
x86_64                randconfig-076-20250926    gcc-14
x86_64                randconfig-076-20250927    gcc-14
x86_64                randconfig-077-20250926    gcc-14
x86_64                randconfig-077-20250927    gcc-14
x86_64                randconfig-078-20250926    gcc-14
x86_64                randconfig-078-20250927    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250926    gcc-14.3.0
xtensa                randconfig-001-20250926    gcc-15.1.0
xtensa                randconfig-001-20250927    gcc-11.5.0
xtensa                randconfig-002-20250926    gcc-15.1.0
xtensa                randconfig-002-20250926    gcc-8.5.0
xtensa                randconfig-002-20250927    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

