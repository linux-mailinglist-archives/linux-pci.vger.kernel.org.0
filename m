Return-Path: <linux-pci+bounces-37781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E124BCB2C4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 01:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2F124E116B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 23:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7162652B4;
	Thu,  9 Oct 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVt8tN47"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9772625
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760051468; cv=none; b=gNqfTOTyS8Vj0+6NTux/5oGfWb4DZwkO6QINnKoYh7ZzDjPkDmYmjTN7hC8hGa927oX69r4eEGs5b/x5aj60SFLPwWqfzPLlAMqWfmMNeo8YxEv3NxD60L1ehgkLtXgF+YAR9Iba1K62UNSVIT++d7R3rTo4JnW7Qdx2Jg89l6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760051468; c=relaxed/simple;
	bh=PTWi63uipc0U6ZyGhxRGE+lg18XmOlYzJcGA8gf3NlM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TZjoB5/7P+rQBfu9XqGpbnRJde/G/VeNzSuVWSbR7fKsACnSOBmhv51hujMM3mDHGzpwmc310Q5SkQdoTILTZwNxCPElk69wApZTMDPVBWNSgKnLDGuU0UGdMmYUl7yenK8P5l5g5nmzsoBW8fvS5C63WqRbYpp/FrV8nB1PCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVt8tN47; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760051467; x=1791587467;
  h=date:from:to:cc:subject:message-id;
  bh=PTWi63uipc0U6ZyGhxRGE+lg18XmOlYzJcGA8gf3NlM=;
  b=NVt8tN47wKRyusFWUkNJ32y433eO7FEggoEnXtZWZsqeQHzPkD04v8Lp
   rVb3VdeIan/wnDO4OdXNcV6l7b2QuTwBzaj0TfVMjh96TdLz/N6xyJlzw
   X03dHq4KRorpyiyDMcBSgkxn28tMnIpgVW+++Nb9merNoldJfbDDnr5+r
   z4YUr3BuM8m7SoRkrHw1BoBEq8WIsHMmUADIrxHKZYL0QWssS5EMXF3gg
   o4TDuvegFIBZFYCT2d5EMvNUcmtu5O8fX6vgP273MgKZGe0WUneZFxMCX
   kV62aNtu5mXsPIrruZApOyLTZAUpRhfR04p1cq2R3HqVkZ7OyN3s2hdS5
   w==;
X-CSE-ConnectionGUID: +Ye1ryHxSaqwseYrUMTknA==
X-CSE-MsgGUID: F1MUm8NQTQ6Lx7pyFhczyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="66127575"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="66127575"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 16:11:04 -0700
X-CSE-ConnectionGUID: qyh29hPlTYaJ9EU9bIaD+g==
X-CSE-MsgGUID: bYdWIJUMQ+69+IJbBk6H3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="204538295"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2025 16:11:03 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6zmn-0001ap-01;
	Thu, 09 Oct 2025 23:11:01 +0000
Date: Fri, 10 Oct 2025 07:10:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 a154f141604acacc0ec64a445d8058a045c308ef
Message-ID: <202510100732.3twg0x5c-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: a154f141604acacc0ec64a445d8058a045c308ef  PCI: Fix regression in pci_bus_distribute_available_resources()

elapsed time: 979m

configs tested: 232
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251010    gcc-8.5.0
arc                   randconfig-002-20251010    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                       imx_v4_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251010    gcc-8.5.0
arm                   randconfig-002-20251010    gcc-8.5.0
arm                   randconfig-003-20251010    gcc-8.5.0
arm                   randconfig-004-20251010    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251010    gcc-8.5.0
arm64                 randconfig-002-20251010    gcc-8.5.0
arm64                 randconfig-003-20251010    gcc-8.5.0
arm64                 randconfig-004-20251010    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251009    clang-16
csky                  randconfig-001-20251010    gcc-14.3.0
csky                  randconfig-002-20251009    clang-16
csky                  randconfig-002-20251010    gcc-14.3.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251009    clang-16
hexagon               randconfig-001-20251010    gcc-14.3.0
hexagon               randconfig-002-20251009    clang-16
hexagon               randconfig-002-20251010    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251009    gcc-14
i386        buildonly-randconfig-001-20251010    gcc-14
i386        buildonly-randconfig-002-20251009    gcc-14
i386        buildonly-randconfig-002-20251010    gcc-14
i386        buildonly-randconfig-003-20251009    gcc-14
i386        buildonly-randconfig-003-20251010    gcc-14
i386        buildonly-randconfig-004-20251009    gcc-14
i386        buildonly-randconfig-004-20251010    gcc-14
i386        buildonly-randconfig-005-20251009    gcc-14
i386        buildonly-randconfig-005-20251010    gcc-14
i386        buildonly-randconfig-006-20251009    gcc-14
i386        buildonly-randconfig-006-20251010    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251010    clang-20
i386                  randconfig-002-20251010    clang-20
i386                  randconfig-003-20251010    clang-20
i386                  randconfig-004-20251010    clang-20
i386                  randconfig-005-20251010    clang-20
i386                  randconfig-006-20251010    clang-20
i386                  randconfig-007-20251010    clang-20
i386                  randconfig-011-20251009    clang-20
i386                  randconfig-011-20251010    gcc-14
i386                  randconfig-012-20251009    clang-20
i386                  randconfig-012-20251010    gcc-14
i386                  randconfig-013-20251009    clang-20
i386                  randconfig-013-20251010    gcc-14
i386                  randconfig-014-20251009    clang-20
i386                  randconfig-014-20251010    gcc-14
i386                  randconfig-015-20251009    clang-20
i386                  randconfig-015-20251010    gcc-14
i386                  randconfig-016-20251009    clang-20
i386                  randconfig-016-20251010    gcc-14
i386                  randconfig-017-20251009    clang-20
i386                  randconfig-017-20251010    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251009    clang-16
loongarch             randconfig-001-20251010    gcc-14.3.0
loongarch             randconfig-002-20251009    clang-16
loongarch             randconfig-002-20251010    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    clang-22
mips                           ip22_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251009    clang-16
nios2                 randconfig-001-20251010    gcc-14.3.0
nios2                 randconfig-002-20251009    clang-16
nios2                 randconfig-002-20251010    gcc-14.3.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    clang-22
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251009    clang-16
parisc                randconfig-001-20251010    gcc-14.3.0
parisc                randconfig-002-20251009    clang-16
parisc                randconfig-002-20251010    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20251009    clang-16
powerpc               randconfig-001-20251010    gcc-14.3.0
powerpc               randconfig-002-20251009    clang-16
powerpc               randconfig-002-20251010    gcc-14.3.0
powerpc               randconfig-003-20251009    clang-16
powerpc               randconfig-003-20251010    gcc-14.3.0
powerpc64             randconfig-001-20251010    gcc-14.3.0
powerpc64             randconfig-002-20251009    clang-16
powerpc64             randconfig-002-20251010    gcc-14.3.0
powerpc64             randconfig-003-20251009    clang-16
powerpc64             randconfig-003-20251010    gcc-14.3.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20251009    clang-22
riscv                 randconfig-001-20251010    gcc-9.5.0
riscv                 randconfig-002-20251009    clang-22
riscv                 randconfig-002-20251010    gcc-9.5.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251009    clang-22
s390                  randconfig-001-20251010    gcc-9.5.0
s390                  randconfig-002-20251009    clang-22
s390                  randconfig-002-20251010    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20251009    clang-22
sh                    randconfig-001-20251010    gcc-9.5.0
sh                    randconfig-002-20251009    clang-22
sh                    randconfig-002-20251010    gcc-9.5.0
sh                           se7721_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251009    clang-22
sparc                 randconfig-001-20251010    gcc-9.5.0
sparc                 randconfig-002-20251009    clang-22
sparc                 randconfig-002-20251010    gcc-9.5.0
sparc64               randconfig-001-20251009    clang-22
sparc64               randconfig-001-20251010    gcc-9.5.0
sparc64               randconfig-002-20251009    clang-22
sparc64               randconfig-002-20251010    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                    randconfig-001-20251009    clang-22
um                    randconfig-001-20251010    gcc-9.5.0
um                    randconfig-002-20251009    clang-22
um                    randconfig-002-20251010    gcc-9.5.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251009    clang-20
x86_64      buildonly-randconfig-001-20251010    gcc-14
x86_64      buildonly-randconfig-002-20251009    clang-20
x86_64      buildonly-randconfig-002-20251010    gcc-14
x86_64      buildonly-randconfig-003-20251009    clang-20
x86_64      buildonly-randconfig-003-20251010    gcc-14
x86_64      buildonly-randconfig-004-20251009    clang-20
x86_64      buildonly-randconfig-004-20251010    gcc-14
x86_64      buildonly-randconfig-005-20251009    clang-20
x86_64      buildonly-randconfig-005-20251010    gcc-14
x86_64      buildonly-randconfig-006-20251009    clang-20
x86_64      buildonly-randconfig-006-20251010    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251010    clang-20
x86_64                randconfig-002-20251010    clang-20
x86_64                randconfig-003-20251010    clang-20
x86_64                randconfig-004-20251010    clang-20
x86_64                randconfig-005-20251010    clang-20
x86_64                randconfig-006-20251010    clang-20
x86_64                randconfig-007-20251010    clang-20
x86_64                randconfig-008-20251010    clang-20
x86_64                randconfig-071-20251009    gcc-14
x86_64                randconfig-071-20251010    clang-20
x86_64                randconfig-072-20251009    gcc-14
x86_64                randconfig-072-20251010    clang-20
x86_64                randconfig-073-20251009    gcc-14
x86_64                randconfig-073-20251010    clang-20
x86_64                randconfig-074-20251009    gcc-14
x86_64                randconfig-074-20251010    clang-20
x86_64                randconfig-075-20251009    gcc-14
x86_64                randconfig-075-20251010    clang-20
x86_64                randconfig-076-20251009    gcc-14
x86_64                randconfig-076-20251010    clang-20
x86_64                randconfig-077-20251009    gcc-14
x86_64                randconfig-077-20251010    clang-20
x86_64                randconfig-078-20251009    gcc-14
x86_64                randconfig-078-20251010    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251009    clang-22
xtensa                randconfig-001-20251010    gcc-9.5.0
xtensa                randconfig-002-20251009    clang-22
xtensa                randconfig-002-20251010    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

