Return-Path: <linux-pci+bounces-7782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9778CD4F7
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4010B20B3B
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DE13C3D6;
	Thu, 23 May 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq/HBOeD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6413B7B3
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471677; cv=none; b=b9EU3nJlH8/Bt80E4YO/sMR3vaDg9qG3XjXU6KnqaFSxNB8Rb/30DRX/gWKiOujJ4fhKimjYj1oWP2pdOM4hfpbxT23QB2C0VUe/PR3xwgr70fb9t0M5vYZLNjIuGXppWqbMlvzs2zfI82hWHc/5MFl/QVbHYUldQC8bdMMLdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471677; c=relaxed/simple;
	bh=trQLn974SGISdapaBOKuYbWdpOwnOgkPSRCQSa27uRs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SSmv2WFjLfpEjuuGa6zjYanJvy2vGHDJQsBZtIyV4fWsZJ/ftKXXZH/ukmoOnvbqIzwyn0AMUqzFlC31A+hEnc6gltklpRL022XjqwB1ve/NEMIdvymXHv2AKOXeAu/gDsvLudjC/oxY5QvzCGTpwQTe0X8/iXGu9AhdDIUV4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq/HBOeD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716471676; x=1748007676;
  h=date:from:to:cc:subject:message-id;
  bh=trQLn974SGISdapaBOKuYbWdpOwnOgkPSRCQSa27uRs=;
  b=Iq/HBOeDxPfW948CzIJRbBdSmaGsBYjzDjNm7HX1lmn9lpuWv6p5CMPj
   ezkVz2cq9xjd3JHCQ7cAQqSX40WEXUXtADjC0oCMoQxjrim9FAwp+iJ8j
   NuCSOasAvK4vf03FbrI/Y7Lqus26l74kgj4jP7+ZpUc5Zci+C0UTcBgt4
   062hfKJ2JFyHLwFQK/CShwJEZN3pcQg9nvnkcqqBoTSg3iNXcuWjtX6R9
   I+gXPI3bPBkmDVOC/fobrB1hWllXEePhXyX9niXSQeR6mcdmNA8E5m5YC
   O5gU+5Nz7f9vh2HytdYmhsMD72Z8/8uwfmE5V9ag01xSFdjanKf+7DPPA
   A==;
X-CSE-ConnectionGUID: WahPkLQjQrO85ESXRu0bZg==
X-CSE-MsgGUID: qMP6u/FySVqDU/1wEMDYiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23922547"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="23922547"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:41:15 -0700
X-CSE-ConnectionGUID: Gx9yTuYeQ3y/kndL4ldgbg==
X-CSE-MsgGUID: at1RNHFORTu77cd52wpm5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33740192"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 May 2024 06:41:14 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA8gx-0002wQ-2b;
	Thu, 23 May 2024 13:41:11 +0000
Date: Thu, 23 May 2024 21:40:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra194] BUILD SUCCESS
 62014ee92c4214322506074f7fe411ef562e3911
Message-ID: <202405232113.h6EqHEbP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra194
branch HEAD: 62014ee92c4214322506074f7fe411ef562e3911  PCI: tegra194: Set EP alignment restriction for inbound ATU

elapsed time: 885m

configs tested: 132
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
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          sp7021_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240523   clang
i386         buildonly-randconfig-002-20240523   gcc  
i386         buildonly-randconfig-003-20240523   clang
i386         buildonly-randconfig-004-20240523   clang
i386         buildonly-randconfig-005-20240523   clang
i386         buildonly-randconfig-006-20240523   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240523   gcc  
i386                  randconfig-002-20240523   clang
i386                  randconfig-003-20240523   clang
i386                  randconfig-004-20240523   clang
i386                  randconfig-005-20240523   gcc  
i386                  randconfig-006-20240523   clang
i386                  randconfig-011-20240523   gcc  
i386                  randconfig-012-20240523   clang
i386                  randconfig-013-20240523   clang
i386                  randconfig-014-20240523   gcc  
i386                  randconfig-015-20240523   gcc  
i386                  randconfig-016-20240523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     tqm8540_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-004-20240523   clang
x86_64       buildonly-randconfig-005-20240523   clang
x86_64       buildonly-randconfig-006-20240523   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240523   clang
x86_64                randconfig-003-20240523   clang
x86_64                randconfig-004-20240523   clang
x86_64                randconfig-005-20240523   clang
x86_64                randconfig-006-20240523   clang
x86_64                randconfig-011-20240523   clang
x86_64                randconfig-013-20240523   clang
x86_64                randconfig-014-20240523   clang
x86_64                randconfig-016-20240523   clang
x86_64                randconfig-076-20240523   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

