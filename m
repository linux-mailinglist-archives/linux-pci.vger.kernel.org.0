Return-Path: <linux-pci+bounces-12797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9996CABA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 01:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C9A1F284F4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AC179958;
	Wed,  4 Sep 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DX91wajK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9379E1
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725491454; cv=none; b=WoCp2WcPesUx40sEfuj3zMsh4jBcjdfsnhDLJiJEpLZcIAOLJ83ntsyLk4SNTqWMWvxniH+Y/qWdQEECEEAyei31lVG03/Cd/uslds/bOHNlUhp/M+ID5+lSFR1o2law3McfyXmfJX6Spwm4VOULTU5xdjraqef2d5GE8Nw5tRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725491454; c=relaxed/simple;
	bh=wgSeqRe+xvrcq+Gy3vvqA+16xC7LCdJqd5grPbBStBI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XxTqd4nheREcoIJ//DaEXCXB/CNH6l7MeuuiVDQWSvafdzSZEKWsnkVvepwz9eaFclaruxiZgVFjC4jPSpN1de0ivvEPe77ohEN5NSMNLtCBuYOoyJ4yxnPP5v2MJjZv2F4RTf/Byt1EHp1pAgQpWFwBso5rzL3Ud+QdbnU/2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DX91wajK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725491453; x=1757027453;
  h=date:from:to:cc:subject:message-id;
  bh=wgSeqRe+xvrcq+Gy3vvqA+16xC7LCdJqd5grPbBStBI=;
  b=DX91wajKGLm0tomDs+STxXYwqTU8UbUDrRjC8fGTVTPVOASpDk1Fo9h6
   Opl/jhsGBbZTfRH7IBzmY4/SI6ejQL7LSIE8neJaEXjHMNHwyAXfZD6d/
   L1ID5Eg6EmRfw1o5BXYBfpFbj0j406ZGaWC7wQ/L9ZWNmETOwog0ZJWDK
   F3QCVMH19tXWBVQxPLrXyBNOf5FNdKmc8HHMB83vA3zIKe6Qv9RKPqpcZ
   1usRfsLy55fuy4+WiT7lDlPswirnNRweJRO4RQ2RNl0+AngWNmuEcCUmc
   00mjdSt+2OgUgIN7dqSuer1oJ4Nxz/VvZzEBHA8unYnKwnX5OreOAJn1M
   A==;
X-CSE-ConnectionGUID: +4IPYHhITmO35/TU6+cQbQ==
X-CSE-MsgGUID: XCIlBfC8QvaEFVSweQqK0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24134996"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24134996"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 16:10:51 -0700
X-CSE-ConnectionGUID: Lnukurd+Sca2VHKlt2hpcw==
X-CSE-MsgGUID: 5I8iNYV9R1uT+rt4Y8XySQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="88660025"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Sep 2024 16:10:50 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slz9D-0008gN-2E;
	Wed, 04 Sep 2024 23:10:47 +0000
Date: Thu, 05 Sep 2024 07:10:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 8f62819aaace77dd85037ae766eb767f8c4417ce
Message-ID: <202409050726.8yiFuqr5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 8f62819aaace77dd85037ae766eb767f8c4417ce  PCI/pwrctl: Rescan bus on a separate thread

elapsed time: 1456m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                          collie_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                          gemini_defconfig   gcc-14.1.0
arm                   milbeaut_m10v_defconfig   gcc-14.1.0
arm                           omap1_defconfig   gcc-14.1.0
arm                        spear3xx_defconfig   gcc-14.1.0
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                           allnoconfig   gcc-14.1.0
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson1c_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig   gcc-14.1.0
powerpc                         ps3_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          polaris_defconfig   gcc-14.1.0
sh                          r7785rp_defconfig   gcc-14.1.0
sh                           se7750_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                                allnoconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240904   clang-18
x86_64       buildonly-randconfig-002-20240904   clang-18
x86_64       buildonly-randconfig-003-20240904   clang-18
x86_64       buildonly-randconfig-004-20240904   clang-18
x86_64       buildonly-randconfig-005-20240904   clang-18
x86_64       buildonly-randconfig-006-20240904   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240904   clang-18
x86_64                randconfig-002-20240904   clang-18
x86_64                randconfig-003-20240904   clang-18
x86_64                randconfig-004-20240904   clang-18
x86_64                randconfig-005-20240904   clang-18
x86_64                randconfig-006-20240904   clang-18
x86_64                randconfig-011-20240904   clang-18
x86_64                randconfig-012-20240904   clang-18
x86_64                randconfig-013-20240904   clang-18
x86_64                randconfig-014-20240904   clang-18
x86_64                randconfig-015-20240904   clang-18
x86_64                randconfig-016-20240904   clang-18
x86_64                randconfig-071-20240904   clang-18
x86_64                randconfig-072-20240904   clang-18
x86_64                randconfig-073-20240904   clang-18
x86_64                randconfig-074-20240904   clang-18
x86_64                randconfig-075-20240904   clang-18
x86_64                randconfig-076-20240904   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0
xtensa                         virt_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

