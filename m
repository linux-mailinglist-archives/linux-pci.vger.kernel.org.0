Return-Path: <linux-pci+bounces-17005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0A9D049F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE21B217D3
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548331D279C;
	Sun, 17 Nov 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw14pc8N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427426ACB
	for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731859312; cv=none; b=OW8JPpg+Te9nXm9g7eXUXqNEyVoAVVcIaOustL32gKd+AWlStdnFq6FuSWW581aa9+zNTyBpLA+bNajQ2Ci2fjWgcyiCouGBviy0st7Ho9QaIIJOUjcxNBBxwcP4Zw2lLays3oOeH89cUB1KqbYeYPeXTL3byb68zxJ9EHV2jiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731859312; c=relaxed/simple;
	bh=/31xvNz6SWXii3WO4qXHx/9ugS4dz81BYMx0vFZiEdw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nYdUD+rdUmh+gl7JlZ49axaNomHe9uVrfAIniiH83GbaVLv0CAvhHHngBkO9z/SrsRouEZm9C7qZvEFZnuoccTDyXZspvc11O0KRkVdjZulilpef17/fCnSQnXfMTbIsLl9E9Q8I0fJtvYaWubA47OWhLwlsVhi7QilmMyP46X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw14pc8N; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731859311; x=1763395311;
  h=date:from:to:cc:subject:message-id;
  bh=/31xvNz6SWXii3WO4qXHx/9ugS4dz81BYMx0vFZiEdw=;
  b=iw14pc8NL0UHV1pSG0S6Mx4GToYoQcEqE/tcQnKRtnOlNdNdwgV9bOZh
   GGT+FwmFL9GPtthWz8iADzFse9DqosCjrrF5R5NOY1+ZlrCjPccSVvWh3
   zfiwzIc9LmvxEMxsMVkpdYRvtJaqAIurdQOW/Kh0UgqxMDMR9F+LxR27N
   52oGAIu12oNcECurXLYp7c369rP+jJmRMna1KaWwHUcJSubO/X6I/tzXa
   AurwAldcXu81kgvrzOVq/KujGBI5JxTKJuZJaBRyfolU837jqgVr5b08o
   A5VgNhyyRNIGWRcni7wXQEQTVeBcVsL+f3MPoFtYAliDQRVxvylMcbRZ6
   w==;
X-CSE-ConnectionGUID: nSAFhnwcQyCu1HHPu7cVpg==
X-CSE-MsgGUID: H2xws8qKRoiAFudDxtN9Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31223301"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="31223301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 08:01:50 -0800
X-CSE-ConnectionGUID: PT1ayWejRYSyW7+34gQmpQ==
X-CSE-MsgGUID: R0ClWnxITYuxEfCZD8Ti6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="93462425"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Nov 2024 08:01:49 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tChic-0001sm-2o;
	Sun, 17 Nov 2024 16:01:46 +0000
Date: Mon, 18 Nov 2024 00:01:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 592aac418ebdf451fe9b146bc2ca6dfc96921af0
Message-ID: <202411180006.ahFN8muC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 592aac418ebdf451fe9b146bc2ca6dfc96921af0  PCI: rockchip-ep: Handle PERST# signal in endpoint mode

elapsed time: 1460m

configs tested: 173
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241117    clang-20
arc                   randconfig-002-20241117    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                          collie_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    clang-20
arm                        multi_v7_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241117    clang-20
arm                   randconfig-002-20241117    clang-20
arm                   randconfig-003-20241117    clang-20
arm                   randconfig-004-20241117    clang-20
arm                         s5pv210_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm                       versatile_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241117    clang-20
arm64                 randconfig-002-20241117    clang-20
arm64                 randconfig-003-20241117    clang-20
arm64                 randconfig-004-20241117    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241117    clang-20
csky                  randconfig-002-20241117    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241117    clang-20
hexagon               randconfig-002-20241117    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241117    clang-19
i386        buildonly-randconfig-002-20241117    clang-19
i386        buildonly-randconfig-003-20241117    clang-19
i386        buildonly-randconfig-004-20241117    clang-19
i386        buildonly-randconfig-005-20241117    clang-19
i386        buildonly-randconfig-006-20241117    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241117    clang-19
i386                  randconfig-002-20241117    clang-19
i386                  randconfig-003-20241117    clang-19
i386                  randconfig-004-20241117    clang-19
i386                  randconfig-005-20241117    clang-19
i386                  randconfig-006-20241117    clang-19
i386                  randconfig-011-20241117    clang-19
i386                  randconfig-012-20241117    clang-19
i386                  randconfig-013-20241117    clang-19
i386                  randconfig-014-20241117    clang-19
i386                  randconfig-015-20241117    clang-19
i386                  randconfig-016-20241117    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241117    clang-20
loongarch             randconfig-002-20241117    clang-20
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-13.2.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241117    clang-20
nios2                 randconfig-002-20241117    clang-20
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-13.2.0
parisc                randconfig-001-20241117    clang-20
parisc                randconfig-002-20241117    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                     rainier_defconfig    gcc-13.2.0
powerpc               randconfig-001-20241117    clang-20
powerpc               randconfig-002-20241117    clang-20
powerpc               randconfig-003-20241117    clang-20
powerpc                     sequoia_defconfig    gcc-13.2.0
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20241117    clang-20
powerpc64             randconfig-002-20241117    clang-20
powerpc64             randconfig-003-20241117    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241117    clang-20
riscv                 randconfig-002-20241117    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241117    clang-20
s390                  randconfig-002-20241117    clang-20
s390                       zfcpdump_defconfig    gcc-13.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    gcc-13.2.0
sh                    randconfig-001-20241117    clang-20
sh                    randconfig-002-20241117    clang-20
sh                           se7206_defconfig    gcc-13.2.0
sh                           se7750_defconfig    gcc-13.2.0
sh                        sh7785lcr_defconfig    gcc-13.2.0
sh                            shmin_defconfig    clang-20
sh                          urquell_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241117    clang-20
sparc64               randconfig-002-20241117    clang-20
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241117    clang-20
um                    randconfig-002-20241117    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241117    gcc-12
x86_64      buildonly-randconfig-002-20241117    gcc-12
x86_64      buildonly-randconfig-003-20241117    gcc-12
x86_64      buildonly-randconfig-004-20241117    gcc-12
x86_64      buildonly-randconfig-005-20241117    gcc-12
x86_64      buildonly-randconfig-006-20241117    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241117    gcc-12
x86_64                randconfig-002-20241117    gcc-12
x86_64                randconfig-003-20241117    gcc-12
x86_64                randconfig-004-20241117    gcc-12
x86_64                randconfig-005-20241117    gcc-12
x86_64                randconfig-006-20241117    gcc-12
x86_64                randconfig-011-20241117    gcc-12
x86_64                randconfig-012-20241117    gcc-12
x86_64                randconfig-013-20241117    gcc-12
x86_64                randconfig-014-20241117    gcc-12
x86_64                randconfig-015-20241117    gcc-12
x86_64                randconfig-016-20241117    gcc-12
x86_64                randconfig-071-20241117    gcc-12
x86_64                randconfig-072-20241117    gcc-12
x86_64                randconfig-073-20241117    gcc-12
x86_64                randconfig-074-20241117    gcc-12
x86_64                randconfig-075-20241117    gcc-12
x86_64                randconfig-076-20241117    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-20
xtensa                randconfig-001-20241117    clang-20
xtensa                randconfig-002-20241117    clang-20
xtensa                    xip_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

