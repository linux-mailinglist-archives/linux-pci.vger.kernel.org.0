Return-Path: <linux-pci+bounces-13023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A659747DF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 03:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC910B20E91
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE03469D;
	Wed, 11 Sep 2024 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuibKR7P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B733F6
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018764; cv=none; b=MruTCZIERVfS9p2SD0lxHBIKN0MlKaqzSV4qJCi3crkkX4kq5B/0OdafnSSXkks9jA0if+0MWsdyEgNEp4JB5F9KXKeLvPoC1IqCLtjEc306MZeBmwGM055wgK3ckeamYgQ/mx3hOWNfnj90mOHsnXHjgHSvvVQ98aOL9y1hWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018764; c=relaxed/simple;
	bh=fjIypQhiwR7OdzqrfgO3tsWfvZk60gWamF9V7nTKVPk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=asw1LDHDkdqovUDGdiBbTd7Mk71gkMrGe+0qkE+lahhkECmXVBUubkbqoBto2XsC6zmwUV7jQhlgnvtEQ5yAbr7OyK++ZPlwsMgeiT6IWc4pQJhGHT58C3bNF0XuVVx2nqw8DC12/2+FmccZTB0R9xAoiwvy0SyNDK3qlOCGu9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuibKR7P; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726018763; x=1757554763;
  h=date:from:to:cc:subject:message-id;
  bh=fjIypQhiwR7OdzqrfgO3tsWfvZk60gWamF9V7nTKVPk=;
  b=kuibKR7P1yVGXBmDUEmfOZWaR67CJsl+xuZNJRcTIszJDpCBU2dadkvA
   wD5J1uND4Oi6PwdrcWEsGGu5aeO9enLVcEko/lRO/8QZReglcXYL+vyWA
   bzBEF/wlpvvEAHsoyh9GyQHqd5RFCDdtdWy2Wt8bNtILuNbH+3lHJfsc4
   Tqe+wCykLvuWFWM3WsRYOUdKwYDvdaFvDm+AYB/Qhu1rCPFaUWLqKhlHu
   JzXtmtqDlUoc/2Zi9FwVAzdMujlsaP4t9qAnvteS4uIcYQG5bmXsq9RXH
   3aFTeQcPzmg4e6OPXG54pVB0Ev5iMnxFRx5WM8mdN6P3lCJnhDVAwn/3r
   g==;
X-CSE-ConnectionGUID: ILCGPhu7SSGdeMOzreUr8w==
X-CSE-MsgGUID: GRhYuWB2RT+pqBrGntdeog==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35390190"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="35390190"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:39:22 -0700
X-CSE-ConnectionGUID: gJO/aSxpT+qkSz6EdhJvIA==
X-CSE-MsgGUID: SpjpOf5+R/GQ+07nVqSR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="71980597"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Sep 2024 18:39:21 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soCKF-0002vq-0i;
	Wed, 11 Sep 2024 01:39:19 +0000
Date: Wed, 11 Sep 2024 09:38:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 2a0091f9419cb6dbbada3a4c8d9e86117b80ead4
Message-ID: <202409110956.T1jlPbTA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 2a0091f9419cb6dbbada3a4c8d9e86117b80ead4  PCI: brcmstb: Sort enums, pcie_offsets[], pcie_cfg_data, .compatible strings

elapsed time: 1445m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                               allnoconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240911   gcc-13.2.0
arc                   randconfig-002-20240911   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   clang-14
arm                            mps2_defconfig   clang-20
arm                   randconfig-001-20240911   clang-20
arm                   randconfig-002-20240911   clang-20
arm                   randconfig-003-20240911   clang-20
arm                   randconfig-004-20240911   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240911   clang-20
arm64                 randconfig-002-20240911   clang-15
arm64                 randconfig-003-20240911   clang-20
arm64                 randconfig-004-20240911   clang-15
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240911   gcc-14.1.0
csky                  randconfig-002-20240911   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240911   clang-20
hexagon               randconfig-002-20240911   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240910   gcc-12
i386         buildonly-randconfig-002-20240910   gcc-12
i386         buildonly-randconfig-003-20240910   gcc-12
i386         buildonly-randconfig-004-20240910   clang-18
i386         buildonly-randconfig-005-20240910   clang-18
i386         buildonly-randconfig-006-20240910   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240910   gcc-12
i386                  randconfig-002-20240910   gcc-12
i386                  randconfig-003-20240910   gcc-12
i386                  randconfig-004-20240910   gcc-12
i386                  randconfig-005-20240910   gcc-12
i386                  randconfig-006-20240910   clang-18
i386                  randconfig-011-20240910   gcc-12
i386                  randconfig-012-20240910   clang-18
i386                  randconfig-013-20240910   clang-18
i386                  randconfig-014-20240910   gcc-12
i386                  randconfig-015-20240910   gcc-12
i386                  randconfig-016-20240910   clang-18
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240911   gcc-14.1.0
loongarch             randconfig-002-20240911   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       alldefconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                         db1xxx_defconfig   clang-20
mips                  decstation_64_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-20
mips                          rm200_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240911   gcc-14.1.0
nios2                 randconfig-002-20240911   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240911   gcc-14.1.0
parisc                randconfig-002-20240911   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   gcc-14.1.0
powerpc                     mpc512x_defconfig   clang-20
powerpc                      ppc64e_defconfig   gcc-14.1.0
powerpc               randconfig-003-20240911   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240911   clang-17
powerpc64             randconfig-002-20240911   clang-15
powerpc64             randconfig-003-20240911   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240911   gcc-14.1.0
riscv                 randconfig-002-20240911   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240911   gcc-14.1.0
s390                  randconfig-002-20240911   clang-20
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240911   gcc-14.1.0
sh                    randconfig-002-20240911   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240911   gcc-14.1.0
sparc64               randconfig-002-20240911   gcc-14.1.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

