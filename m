Return-Path: <linux-pci+bounces-7781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15598CD33F
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 15:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4EB1C217F3
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7213B7A3;
	Thu, 23 May 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJFTGARZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721114A4D1
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469759; cv=none; b=O18gp2R18UtT/M08cEUnhQRclodI7mIMuAZnT1dLrVkREzV7fdZ5rdWpwBqBntBaeizR4tI0uaEtlxpXzTZaCwb+0mh3D+mGcb0aWy/Efd2CHB5taa2bwh53eDcqxkv84fGlQB6AyJc0e4lXpugisNkf/6tgARvelz50PvvSPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469759; c=relaxed/simple;
	bh=XAn8TKwr+xJ2stcqo3UH7P7Hy8KPjetAngynl2GoXU0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VScuf7EukRAu4e2LAtmiG9hYWNALaQgcYzTtz9l/4IXWqEOt2zQS2Jyx6LO3wLwQIH9sI0cr//WZU9LMbmTfRHbk+JsUse+orZXy+550cb7mKKNm5FjEzZJbCecr90Vpkzw7ozK6JGYajZjKFO0iq4cvlDw1sjBtBjGoUcolTAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJFTGARZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716469758; x=1748005758;
  h=date:from:to:cc:subject:message-id;
  bh=XAn8TKwr+xJ2stcqo3UH7P7Hy8KPjetAngynl2GoXU0=;
  b=VJFTGARZlgAOtUpSo6I5fqHcKOUMVc7jV7MbCJ5SYNLsRlMdEqhZ9a8m
   h/Kh+Pl2nKKxm+NTox4FsjsBuwMdETR2Kb2ARjyABe40VKZaJo3RS4UsE
   oOhx+ULSweWNTybWHMyvP9vIallju7RR3PuWgdxUPaEbJybUDFFJbL2kc
   blFyfEX70m5WNB+ohzbeG4YQ1svVbSGFpzV14sDCcRQ3pM2oDeFLMCUf8
   F0KFBd6yjp7O5SeAOtY+EbkkVahHvop6vwCtnj48dPWyzH5aEqFqusnbt
   W72P4a+2uNZ0Q3n68Cd2QH9gqV0RdPckZJ7aT+RiemGaNY/uJU/IG3nVd
   w==;
X-CSE-ConnectionGUID: hRN0GovbRq2SJdnRXsDOzw==
X-CSE-MsgGUID: q1T7KZQnQu6c9JDwCtcKQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35297197"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="35297197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:09:17 -0700
X-CSE-ConnectionGUID: o6yETKkTSmyeU61zQaNSBA==
X-CSE-MsgGUID: zDxGPV/kQM+adT1dvu1nkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33733828"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 May 2024 06:09:15 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA8C0-0002tP-12;
	Thu, 23 May 2024 13:09:12 +0000
Date: Thu, 23 May 2024 21:08:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/artpec6] BUILD SUCCESS
 97e98aeed791b6f43890619f28c5cfbeb143e64c
Message-ID: <202405232133.neMeTdU7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/artpec6
branch HEAD: 97e98aeed791b6f43890619f28c5cfbeb143e64c  PCI: artpec6: Fix artpec6_pcie_cpu_addr_fixup() parameter name

elapsed time: 854m

configs tested: 114
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
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

