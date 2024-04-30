Return-Path: <linux-pci+bounces-6869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95008B74ED
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F291F22820
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2D13C9C3;
	Tue, 30 Apr 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJ1LgTRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65527134412
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478024; cv=none; b=mdqAlC5vmcJuRgtHpGuCzasXgruhIV9Gnjr3cHA748lwSad/9pg8DDBFGEFhEUHfyI7c5LEY82ZUxSAsJzUM6uth/F8pU0YD40/enOtdvdsKxLFMoXLk6cFVn/mRHsHbZ9EGhNjYIfiQ+/cHZFa1f4dCmB4yGU4GrNR+xsKAszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478024; c=relaxed/simple;
	bh=mo5CnOgD2idV5MwUz1QZcg8vUV4i+bCc3bd5iPnHOss=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hCJykLKvzK3LkI+r3/yT/kLYJv2qw3lykVJhCw/XW4oluuJPfPgx5xTE/jXBwuFbj0qqhGVAv0VMNXbEh6AgJOw79LWt0Y70qosFgAs2eoJ6XANF1HDfWpnvvyGukePR9wKRkHsRGkgDNpzZSU/WNUdY/KgmtO/qLvQhrDsn4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJ1LgTRm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714478022; x=1746014022;
  h=date:from:to:cc:subject:message-id;
  bh=mo5CnOgD2idV5MwUz1QZcg8vUV4i+bCc3bd5iPnHOss=;
  b=LJ1LgTRmSvYW2ae+XoAhGqRGPjndA1S0dIHMeKnnFfykRPfOeLHbVBjm
   rBnbaXqqJeisZDFNsBmDKVEtUpooNSa4Wq070n7CA8CAmJSM9PBny6T07
   iOI0de/CqXqOTVhJ/G5YKkuObvl8BYQRqWcoaLFYzhaaTGjnPDc+Fh/7F
   JgJOAGffgZz/oHnGMeXrga7pG+KZWPrxWRnlH2I4vY1Fc/IZz+A2798sm
   3hGt6Wd93hPQMzQNrPyTNMqOKK+I9U/Lh3GuQ9hxigisM+csU3GOf+hD1
   +VQ6cyITX+kN+6N1lZw+o7iQV/LS6s037XatgD4Tz8uxsGA/Pbj66opbI
   w==;
X-CSE-ConnectionGUID: HHFX6ddQRe2euEnpJgajMg==
X-CSE-MsgGUID: 4TFkkCIAQiKn6eGonp+o0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21586932"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="21586932"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 04:53:40 -0700
X-CSE-ConnectionGUID: ooZYEMEKSdmC80hkppao+A==
X-CSE-MsgGUID: AK3rUMB1QSaIA8IxZJgLrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="30915592"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Apr 2024 04:53:38 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1m3C-00085o-1Y;
	Tue, 30 Apr 2024 11:53:34 +0000
Date: Tue, 30 Apr 2024 19:53:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 4c407392c1aff30025457972b173a0729830945f
Message-ID: <202404301918.DD6PQTJu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 4c407392c1aff30025457972b173a0729830945f  PCI: Clean up accessor macro formatting

elapsed time: 1168m

configs tested: 147
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
arc                   randconfig-001-20240430   gcc  
arc                   randconfig-002-20240430   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240430   gcc  
arm64                 randconfig-004-20240430   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240430   gcc  
csky                  randconfig-002-20240430   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240430   gcc  
i386         buildonly-randconfig-003-20240430   gcc  
i386         buildonly-randconfig-006-20240430   gcc  
i386                                defconfig   clang
i386                  randconfig-002-20240430   gcc  
i386                  randconfig-003-20240430   gcc  
i386                  randconfig-004-20240430   gcc  
i386                  randconfig-005-20240430   gcc  
i386                  randconfig-006-20240430   gcc  
i386                  randconfig-011-20240430   gcc  
i386                  randconfig-014-20240430   gcc  
i386                  randconfig-015-20240430   gcc  
i386                  randconfig-016-20240430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240430   gcc  
loongarch             randconfig-002-20240430   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240430   gcc  
nios2                 randconfig-002-20240430   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240430   gcc  
parisc                randconfig-002-20240430   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc               randconfig-001-20240430   gcc  
powerpc               randconfig-002-20240430   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240430   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240430   gcc  
s390                  randconfig-002-20240430   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240430   gcc  
sh                    randconfig-002-20240430   gcc  
sh                           se7721_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240430   gcc  
sparc64               randconfig-002-20240430   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240430   clang
x86_64       buildonly-randconfig-003-20240430   clang
x86_64       buildonly-randconfig-004-20240430   clang
x86_64       buildonly-randconfig-005-20240430   clang
x86_64       buildonly-randconfig-006-20240430   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240430   clang
x86_64                randconfig-002-20240430   clang
x86_64                randconfig-006-20240430   clang
x86_64                randconfig-011-20240430   clang
x86_64                randconfig-012-20240430   clang
x86_64                randconfig-014-20240430   clang
x86_64                randconfig-015-20240430   clang
x86_64                randconfig-016-20240430   clang
x86_64                randconfig-071-20240430   clang
x86_64                randconfig-072-20240430   clang
x86_64                randconfig-073-20240430   clang
x86_64                randconfig-074-20240430   clang
x86_64                randconfig-076-20240430   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240430   gcc  
xtensa                randconfig-002-20240430   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

