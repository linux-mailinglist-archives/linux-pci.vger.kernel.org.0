Return-Path: <linux-pci+bounces-36045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994F1B55502
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED413AA9F6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8A32145E;
	Fri, 12 Sep 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+KQ/ivW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F98322C63
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695801; cv=none; b=fu4lTduXSvWh7HuyDrrqstzKzExk00ppATagoLcis++lNqjFiIRoWqN/Dya+kSuCoCN1jQEkku4ZAC1GeBT+v6yyyn29jgAII4aQ7so+Ycx78s6F4ltPpqkNv/LdA1fARL+HJobpgELvr3JobGgJ/AH+OpHhBKZKPMWoXUr8tjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695801; c=relaxed/simple;
	bh=Lfu7+Ba0lXnK05IrfE1iSkXPFMCpVow9HGw2zBPlnx8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ppaeqoHI8H+9Zh1Rb6vBXkD0erD4qgWwDWqKNRKHnmFPOyjUfJTmuXj6j8NkF0P20SYGFXK9kyuvqYKgBDty3asdkVmcktTcHSq7H4u/PIMkq2H2uEyegxJ5u6gqC1OM3m4GjDc8DDL+cwLWdPpbxJiviLyV+Yy/w5sMiMaKZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+KQ/ivW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757695800; x=1789231800;
  h=date:from:to:cc:subject:message-id;
  bh=Lfu7+Ba0lXnK05IrfE1iSkXPFMCpVow9HGw2zBPlnx8=;
  b=W+KQ/ivWUG7hUZVKxhMMcKVzSEvlwTtupUw1zZzoxN/tMlinKJgvFolK
   eSNvlU88SDQX+qYJy+9XeMN6R7FmjhIXf3kWzAG3/k/8KQsCaIb7KNZv8
   0s3hlrwiOTv/S91JMUeMALovpY3E8fIPi55SvJYqMKqFvCOEhl7+0cQYq
   oAOi9e57/7mvSbC0ug4C84ao2PCvcJpXwTM4oAJRqOy9NgSiw/X4XUUYo
   Y0R4Mda0uiK80KTYdqLJHgWp7Th/vx6zXgtysVBNHdWXU7uAUXaxb/bem
   /ykX1blJiGQit7ZUXIA61pi+YxfCPynpHJAEWK3X8AHilZkr0OdUJy2YL
   A==;
X-CSE-ConnectionGUID: 3rkGPM/2S+WBHqbpKLuDjw==
X-CSE-MsgGUID: E/cJT6KhS9a2XmUxm4G+oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="77655329"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="77655329"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 09:49:59 -0700
X-CSE-ConnectionGUID: cKNWY/EBS0Ks/imWlmJgeA==
X-CSE-MsgGUID: ZGNbGiXlTUiCxGkvrQ3UaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173832281"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 12 Sep 2025 09:49:57 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ux6yA-00017e-2m;
	Fri, 12 Sep 2025 16:49:54 +0000
Date: Sat, 13 Sep 2025 00:49:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:of] BUILD SUCCESS
 df06eac219d072ac89ec9cc1b27efcbf14f38ee9
Message-ID: <202509130053.NvroTOMx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git of
branch HEAD: df06eac219d072ac89ec9cc1b27efcbf14f38ee9  PCI: of: Update parent unit address generation in of_pci_prop_intr_map()

elapsed time: 1446m

configs tested: 221
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250912    clang-19
arc                   randconfig-001-20250912    gcc-10.5.0
arc                   randconfig-002-20250912    clang-19
arc                   randconfig-002-20250912    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          gemini_defconfig    gcc-15.1.0
arm                   randconfig-001-20250912    clang-19
arm                   randconfig-001-20250912    clang-22
arm                   randconfig-002-20250912    clang-19
arm                   randconfig-002-20250912    gcc-14.3.0
arm                   randconfig-003-20250912    clang-19
arm                   randconfig-003-20250912    clang-22
arm                   randconfig-004-20250912    clang-19
arm                   randconfig-004-20250912    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250912    clang-19
arm64                 randconfig-001-20250912    clang-20
arm64                 randconfig-002-20250912    clang-16
arm64                 randconfig-002-20250912    clang-19
arm64                 randconfig-003-20250912    clang-19
arm64                 randconfig-003-20250912    clang-22
arm64                 randconfig-004-20250912    clang-19
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250912    clang-22
csky                  randconfig-001-20250912    gcc-15.1.0
csky                  randconfig-002-20250912    clang-22
csky                  randconfig-002-20250912    gcc-11.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250912    clang-22
hexagon               randconfig-002-20250912    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250912    gcc-13
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-002-20250912    gcc-13
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-004-20250912    gcc-13
i386        buildonly-randconfig-005-20250912    gcc-13
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250912    clang-20
i386        buildonly-randconfig-006-20250912    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20250912    gcc-14
i386                  randconfig-002-20250912    gcc-14
i386                  randconfig-003-20250912    gcc-14
i386                  randconfig-004-20250912    gcc-14
i386                  randconfig-005-20250912    gcc-14
i386                  randconfig-006-20250912    gcc-14
i386                  randconfig-007-20250912    gcc-14
i386                  randconfig-011-20250912    gcc-14
i386                  randconfig-012-20250912    gcc-14
i386                  randconfig-013-20250912    gcc-14
i386                  randconfig-014-20250912    gcc-14
i386                  randconfig-015-20250912    gcc-14
i386                  randconfig-016-20250912    gcc-14
i386                  randconfig-017-20250912    gcc-14
loongarch                        alldefconfig    gcc-15.1.0
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250912    clang-22
loongarch             randconfig-001-20250912    gcc-15.1.0
loongarch             randconfig-002-20250912    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250912    clang-22
nios2                 randconfig-001-20250912    gcc-11.5.0
nios2                 randconfig-002-20250912    clang-22
nios2                 randconfig-002-20250912    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250912    clang-22
parisc                randconfig-001-20250912    gcc-14.3.0
parisc                randconfig-002-20250912    clang-22
parisc                randconfig-002-20250912    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250912    clang-22
powerpc               randconfig-001-20250912    gcc-8.5.0
powerpc               randconfig-002-20250912    clang-22
powerpc               randconfig-003-20250912    clang-17
powerpc               randconfig-003-20250912    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250912    clang-22
powerpc64             randconfig-001-20250912    gcc-12.5.0
powerpc64             randconfig-002-20250912    clang-22
powerpc64             randconfig-003-20250912    clang-19
powerpc64             randconfig-003-20250912    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250912    clang-16
riscv                 randconfig-001-20250912    gcc-15.1.0
riscv                 randconfig-002-20250912    gcc-15.1.0
riscv                 randconfig-002-20250912    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250912    gcc-10.5.0
s390                  randconfig-001-20250912    gcc-15.1.0
s390                  randconfig-002-20250912    gcc-10.5.0
s390                  randconfig-002-20250912    gcc-15.1.0
s390                       zfcpdump_defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20250912    gcc-15.1.0
sh                    randconfig-002-20250912    gcc-15.1.0
sh                           se7619_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250912    gcc-15.1.0
sparc                 randconfig-001-20250912    gcc-8.5.0
sparc                 randconfig-002-20250912    gcc-13.4.0
sparc                 randconfig-002-20250912    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250912    gcc-15.1.0
sparc64               randconfig-001-20250912    gcc-8.5.0
sparc64               randconfig-002-20250912    clang-20
sparc64               randconfig-002-20250912    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250912    clang-22
um                    randconfig-001-20250912    gcc-15.1.0
um                    randconfig-002-20250912    gcc-14
um                    randconfig-002-20250912    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250912    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250912    gcc-14
x86_64                randconfig-002-20250912    gcc-14
x86_64                randconfig-003-20250912    gcc-14
x86_64                randconfig-004-20250912    gcc-14
x86_64                randconfig-005-20250912    gcc-14
x86_64                randconfig-006-20250912    gcc-14
x86_64                randconfig-007-20250912    gcc-14
x86_64                randconfig-008-20250912    gcc-14
x86_64                randconfig-071-20250912    clang-20
x86_64                randconfig-072-20250912    clang-20
x86_64                randconfig-073-20250912    clang-20
x86_64                randconfig-074-20250912    clang-20
x86_64                randconfig-075-20250912    clang-20
x86_64                randconfig-076-20250912    clang-20
x86_64                randconfig-077-20250912    clang-20
x86_64                randconfig-078-20250912    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250912    gcc-15.1.0
xtensa                randconfig-001-20250912    gcc-9.5.0
xtensa                randconfig-002-20250912    gcc-12.5.0
xtensa                randconfig-002-20250912    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

