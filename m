Return-Path: <linux-pci+bounces-8026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC08D3885
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE5B1F21509
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92211BC2F;
	Wed, 29 May 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfIJMLAr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674A1C290
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991198; cv=none; b=fY3iZ98mddPNb8TedT35a74jYz4v5hqdGJ9pgiadyHe61Pkil9qNiavuZD+cgUw41XcGywDmPkL/AXprgRvM1O5fOU96B2ho/iRoTKRjjPrFg2kmsawHS7HjcBnIxXaUI282AXorpsTeTQnnJx9MzIUgRDwpw28640LNhT9fbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991198; c=relaxed/simple;
	bh=cWU2ZpPAOK9EfFLEUlT4tcvACsHJ2LPMQt6qtyrwZpo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VJLl0kCwfwb1d73OCzyg7FaYBtrLf/0zLerW7Dp5eBlbRheu2FZ7p7Mle9NfpAtsaAtMm4fj3sGxr4fSQtED79DhoTQacsQX43Dyn7KLhDxiWeLx3+9smXMpCDRXXxEXkHdcmjFPmq6tarTaq4pNomhgv2XFThox9Fo7bOIwRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfIJMLAr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716991197; x=1748527197;
  h=date:from:to:cc:subject:message-id;
  bh=cWU2ZpPAOK9EfFLEUlT4tcvACsHJ2LPMQt6qtyrwZpo=;
  b=KfIJMLArRxU7+pKFOzMU+XWTJUcQZKT/lj/LfkiL7yIWl9KXIFsxbxWi
   bjRveWZKn4FyddVsLa0vWbAKCSYOUahjrAS7XGbt0WuVvykiRuIDPBrbG
   GImgi0b17k/1b4ZP0BwyHIOQ+/Bj7AGIHLTPtL2u3SpctUGOX4VwUTr2c
   /VwV/NX8shh9X7DoL1HvIND8xDlmznRiXODnIp3bIZhQ5JFz1wq76POIW
   qe/5Uxxshx8hv3rvn9MHmF2jY498Nj5HaAXJg1eACx/R3YG1jXcHKb6qI
   VXCPFVh7u9V5PYHnPeHTtuywMG0SgxEnLjx9FYD5y5hZqg626qdyVGI3d
   Q==;
X-CSE-ConnectionGUID: i5Rcnw8FROyno8vafzkP4w==
X-CSE-MsgGUID: BCCQbDBUQnyxuEkJcq9G9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16344288"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="16344288"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:59:56 -0700
X-CSE-ConnectionGUID: Or0e3tFVT4uTKnTx0ORngQ==
X-CSE-MsgGUID: CziKsOrJSZ2DXYVN7tgVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35505730"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 29 May 2024 06:59:55 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCJqI-000DkP-2P;
	Wed, 29 May 2024 13:59:51 +0000
Date: Wed, 29 May 2024 21:59:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:acs] BUILD SUCCESS
 524e057b2d66b61f9b63b6db30467ab7b0bb4796
Message-ID: <202405292122.uXQIrXW5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git acs
branch HEAD: 524e057b2d66b61f9b63b6db30467ab7b0bb4796  PCI: Add ACS quirk for Broadcom BCM5760X NIC

elapsed time: 1258m

configs tested: 163
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
arc                   randconfig-001-20240529   gcc  
arc                   randconfig-002-20240529   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240529   gcc  
arm                   randconfig-002-20240529   gcc  
arm                   randconfig-003-20240529   gcc  
arm                   randconfig-004-20240529   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240529   clang
arm64                 randconfig-002-20240529   clang
arm64                 randconfig-003-20240529   gcc  
arm64                 randconfig-004-20240529   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240529   gcc  
csky                  randconfig-002-20240529   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240529   clang
hexagon               randconfig-002-20240529   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240529   clang
i386         buildonly-randconfig-002-20240529   gcc  
i386         buildonly-randconfig-003-20240529   gcc  
i386         buildonly-randconfig-004-20240529   clang
i386         buildonly-randconfig-005-20240529   gcc  
i386         buildonly-randconfig-006-20240529   clang
i386                                defconfig   clang
i386                  randconfig-001-20240529   clang
i386                  randconfig-002-20240529   gcc  
i386                  randconfig-003-20240529   gcc  
i386                  randconfig-004-20240529   gcc  
i386                  randconfig-005-20240529   clang
i386                  randconfig-006-20240529   clang
i386                  randconfig-011-20240529   clang
i386                  randconfig-012-20240529   clang
i386                  randconfig-013-20240529   clang
i386                  randconfig-014-20240529   gcc  
i386                  randconfig-015-20240529   clang
i386                  randconfig-016-20240529   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240529   gcc  
loongarch             randconfig-002-20240529   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240529   gcc  
nios2                 randconfig-002-20240529   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240529   gcc  
parisc                randconfig-002-20240529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240529   clang
powerpc               randconfig-002-20240529   clang
powerpc               randconfig-003-20240529   clang
powerpc64             randconfig-001-20240529   gcc  
powerpc64             randconfig-002-20240529   clang
powerpc64             randconfig-003-20240529   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240529   gcc  
riscv                 randconfig-002-20240529   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240529   clang
s390                  randconfig-002-20240529   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240529   gcc  
sh                    randconfig-002-20240529   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240529   gcc  
sparc64               randconfig-002-20240529   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240529   clang
um                    randconfig-002-20240529   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240529   gcc  
x86_64       buildonly-randconfig-002-20240529   clang
x86_64       buildonly-randconfig-003-20240529   clang
x86_64       buildonly-randconfig-004-20240529   gcc  
x86_64       buildonly-randconfig-005-20240529   clang
x86_64       buildonly-randconfig-006-20240529   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240529   gcc  
x86_64                randconfig-002-20240529   clang
x86_64                randconfig-003-20240529   clang
x86_64                randconfig-004-20240529   clang
x86_64                randconfig-005-20240529   gcc  
x86_64                randconfig-006-20240529   gcc  
x86_64                randconfig-011-20240529   gcc  
x86_64                randconfig-012-20240529   gcc  
x86_64                randconfig-013-20240529   clang
x86_64                randconfig-014-20240529   gcc  
x86_64                randconfig-015-20240529   gcc  
x86_64                randconfig-016-20240529   clang
x86_64                randconfig-071-20240529   clang
x86_64                randconfig-072-20240529   gcc  
x86_64                randconfig-073-20240529   gcc  
x86_64                randconfig-074-20240529   clang
x86_64                randconfig-075-20240529   clang
x86_64                randconfig-076-20240529   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240529   gcc  
xtensa                randconfig-002-20240529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

