Return-Path: <linux-pci+bounces-7795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FDE8CDA27
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EE51C20D18
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CA187F;
	Thu, 23 May 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHv86Irw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357C849C
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490060; cv=none; b=XzF7i3Svd3xaeEBt0AmYgr1XUKu2kl4c5qBx3VBIlLodiM0Oc1S9qBTcAToSc9unbGpepiEPt/jKrj4gS2DtoXU7HB75M7v9Z78E/MKakobSsp69KFn+/4n+vclag0P+YHGIXU8azVdE4CH4tVMjq63VR6LS6QAKVYBjiAo63oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490060; c=relaxed/simple;
	bh=uEza3Kd4JwECQHy2CjBBzBX6FonFlP3wwbaKncNb8LY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bT5LrMNZC/7LbC19YD/cgf38FVE3+z/eRDSdsQPV6aB7vt5lPurSpbHRREaX0u0/x09OHtLWu6XKQ9F0ijCAqmeBgTgpOZFuGtXqa0Qyyx/KaXhUSzFtQtbakOh9CymZuOIHlTqbMjvPjBxCNRnvNO3Mkb62lvMEs2NNbImxwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHv86Irw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716490058; x=1748026058;
  h=date:from:to:cc:subject:message-id;
  bh=uEza3Kd4JwECQHy2CjBBzBX6FonFlP3wwbaKncNb8LY=;
  b=fHv86IrwpDSK9g4wetX840Yx9UjV9pWE1gFs88Qa+VrO07NGzeZJxzjK
   xYhNmW0GOYwmCVX9cl3kc/3elrofFdJCHONpyaTnXY9f3aXFh8MK3KUZ9
   ns62XJB7LkTXkkEV7nWzDV0fFbtVFUtFylvzJWS2Ttyt5A76x9wDToyHx
   8R2NXlbaYBgylGHe7TJCiyBBRkV7qcjq1XtPbxWL8OqkK6Jf4HfhfjTDD
   ZWF+mxuvnEuwUraodeZPYDiLIy5565TV1Nx4T1YRbyFwGA6i+xCYvlPn8
   XNoCdRAJTYeS5bss6ljfR3HeKeUdNpigtZKov3gF2hURkI7r8O3BuBei/
   Q==;
X-CSE-ConnectionGUID: N1sQ55lPSxSDiYqymaEavA==
X-CSE-MsgGUID: lfrkbnccTVSWLBoESkbyQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35348816"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="35348816"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 11:47:38 -0700
X-CSE-ConnectionGUID: QtaShCtFQ8W8VIthN8mdHg==
X-CSE-MsgGUID: xpPbyjtMRSS6EYrRc2n2pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="64592419"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 23 May 2024 11:47:37 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sADTS-0003FK-1t;
	Thu, 23 May 2024 18:47:34 +0000
Date: Fri, 24 May 2024 02:46:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/gpio] BUILD SUCCESS
 011d2c770dbd8da74902140d576b9441776cdcd0
Message-ID: <202405240251.DwGrgfog-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/gpio
branch HEAD: 011d2c770dbd8da74902140d576b9441776cdcd0  PCI: kirin: Convert to use agnostic GPIO API

elapsed time: 1192m

configs tested: 161
configs skipped: 4

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
arc                   randconfig-001-20240523   gcc  
arc                   randconfig-002-20240523   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240523   gcc  
arm                   randconfig-002-20240523   gcc  
arm                   randconfig-003-20240523   gcc  
arm                   randconfig-004-20240523   gcc  
arm                          sp7021_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240523   gcc  
arm64                 randconfig-004-20240523   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240523   gcc  
csky                  randconfig-002-20240523   gcc  
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
loongarch             randconfig-001-20240523   gcc  
loongarch             randconfig-002-20240523   gcc  
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
nios2                 randconfig-001-20240523   gcc  
nios2                 randconfig-002-20240523   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240523   gcc  
parisc                randconfig-002-20240523   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240523   gcc  
powerpc               randconfig-002-20240523   gcc  
powerpc               randconfig-003-20240523   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc64             randconfig-001-20240523   gcc  
powerpc64             randconfig-002-20240523   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240523   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240523   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240523   gcc  
sh                    randconfig-002-20240523   gcc  
sh                           se7751_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240523   gcc  
sparc64               randconfig-002-20240523   gcc  
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
xtensa                randconfig-001-20240523   gcc  
xtensa                randconfig-002-20240523   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

