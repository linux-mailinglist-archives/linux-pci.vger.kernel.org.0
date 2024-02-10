Return-Path: <linux-pci+bounces-3329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D5850629
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 20:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2468FB2296C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778475F849;
	Sat, 10 Feb 2024 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNJkmij0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379E5F47C
	for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707594100; cv=none; b=ke1/M3vqFIq91+eReh68GDOBkvPdChV0bUtfTgSn+2iBoJA2U5X9zo/iNpSwGTneDoH4zR4Oczu/ZIKx26PYZxQMRBA2UXIvqf+GVz0F9lC/rXGq0q3trgDBHvzArD95qVVCYcfE3KjnyyWge98bz08HT+g6OBQ8tEOmIT42QbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707594100; c=relaxed/simple;
	bh=+McifX7u7UfIS7QkvEVJXeSKnXwRirtOm0gFIJX0zjs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uTeZlBnMYxqdJkt2Fcxwl+2MOD6neKQvVTY8LmQ//vxo033LBIIxsXbzvTEw99j2bcXWyrz+M476pBj2VwGcBrfR3wCofO2Omxh/wv6vKc8Jvk/S1dhPNNC4SoAQtUWL1pMCcgK2fkJgE4VC90W/5hyEl58edey1Fltbs2mjZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNJkmij0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707594098; x=1739130098;
  h=date:from:to:cc:subject:message-id;
  bh=+McifX7u7UfIS7QkvEVJXeSKnXwRirtOm0gFIJX0zjs=;
  b=TNJkmij0I4487A1m8kPkRHs+SNJ7/s2jU1g/ydzCzSxk4rnuApWFk7um
   CAfA25b7Wfc7EDyQxhdSEjRn6Q8td5lsvDTEcECJPCZ7+MAh6loNG4als
   tEaEVHdHnQiahGN+f0Ox+zSTPAsIoclLfZ15TfNxlBSk8XgA4PpwioFvd
   8uhci9AeSF1d1UyI286/6AojVGI0+fd9aMSN+eaPqmIavpZd3dXoFh1pn
   lFoOaQPsyQ/1kwuoeCvmphpng3+25+HLA/6+se+sll+35Ocrfikaf7mWE
   hEL7nRZF9TfkZE/JY2zWtuVeNZU4dI6vG4d8ySUZ5ltamZDT2CzcBjZ5f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1469645"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1469645"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 11:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="6823371"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Feb 2024 11:41:37 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYtEE-00061f-1T;
	Sat, 10 Feb 2024 19:41:34 +0000
Date: Sun, 11 Feb 2024 03:40:51 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 41044d5360685e78a869d40a168491a70cdb7e73
Message-ID: <202402110349.07DGeXhu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 41044d5360685e78a869d40a168491a70cdb7e73  PCI: Fix active state requirement in PME polling

elapsed time: 1444m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240210   gcc  
arc                   randconfig-002-20240210   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240210   gcc  
arm                   randconfig-002-20240210   gcc  
arm                   randconfig-003-20240210   gcc  
arm                   randconfig-004-20240210   gcc  
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                       versatile_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240210   gcc  
arm64                 randconfig-003-20240210   gcc  
arm64                 randconfig-004-20240210   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240210   gcc  
csky                  randconfig-002-20240210   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240210   clang
i386         buildonly-randconfig-002-20240210   gcc  
i386         buildonly-randconfig-003-20240210   clang
i386         buildonly-randconfig-004-20240210   clang
i386         buildonly-randconfig-005-20240210   clang
i386         buildonly-randconfig-006-20240210   clang
i386                                defconfig   clang
i386                  randconfig-001-20240210   gcc  
i386                  randconfig-002-20240210   gcc  
i386                  randconfig-003-20240210   clang
i386                  randconfig-004-20240210   clang
i386                  randconfig-005-20240210   gcc  
i386                  randconfig-006-20240210   gcc  
i386                  randconfig-011-20240210   clang
i386                  randconfig-012-20240210   clang
i386                  randconfig-013-20240210   clang
i386                  randconfig-014-20240210   gcc  
i386                  randconfig-015-20240210   gcc  
i386                  randconfig-016-20240210   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240210   gcc  
loongarch             randconfig-002-20240210   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240210   gcc  
nios2                 randconfig-002-20240210   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240210   gcc  
parisc                randconfig-002-20240210   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240210   gcc  
powerpc               randconfig-003-20240210   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240210   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240210   gcc  
s390                  randconfig-002-20240210   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240210   gcc  
sh                    randconfig-002-20240210   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240210   gcc  
sparc64               randconfig-002-20240210   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240210   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-004-20240210   clang
x86_64       buildonly-randconfig-005-20240210   clang
x86_64       buildonly-randconfig-006-20240210   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240210   clang
x86_64                randconfig-002-20240210   clang
x86_64                randconfig-004-20240210   clang
x86_64                randconfig-005-20240210   clang
x86_64                randconfig-012-20240210   clang
x86_64                randconfig-013-20240210   clang
x86_64                randconfig-014-20240210   clang
x86_64                randconfig-016-20240210   clang
x86_64                randconfig-073-20240210   clang
x86_64                randconfig-075-20240210   clang
x86_64                randconfig-076-20240210   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240210   gcc  
xtensa                randconfig-002-20240210   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

