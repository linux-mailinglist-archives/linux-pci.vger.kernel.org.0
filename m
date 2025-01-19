Return-Path: <linux-pci+bounces-20122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0A1A162AE
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72A8188480D
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A11DF259;
	Sun, 19 Jan 2025 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILeRmsz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F551DED4E
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737300718; cv=none; b=YWRWggeLBjKl8WRa8UtO2xZZTGigY79bYn6h0dBOUinyPTUEW0/FjETz1OqZnv+iv0uzQFojMuPLK8CP1iuihbdG+TAiBTJvKtu2fBSFAg0J0dBOJvQbAf3ewnqj+CZbPpLtmiC/Z3J2wv8ynK2ktlaNeT7TeT32VS/CkrXXRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737300718; c=relaxed/simple;
	bh=I4TOg0Z+1gHfv+5W7ksVE86dkycSIKNjVKYQTgX7cwE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qqvHbxXtKcuNim0ooxGZ5GFP0J5ZF86i5rl0kbEjsgt6uKjeE8g/L9eQb0xcWd1Qdh2NAyq6FmaLqvZzXKyvBDS/2fUkJPf6i9lAdApizefdPQOvONOXJZa3WbypemzYxsAVpeLAiT4PVjoxn98PMWJK9emDMCDbtw9eMa/2x3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILeRmsz5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737300716; x=1768836716;
  h=date:from:to:cc:subject:message-id;
  bh=I4TOg0Z+1gHfv+5W7ksVE86dkycSIKNjVKYQTgX7cwE=;
  b=ILeRmsz5u5pOgnjogdrKGzNtBEdlNEoiuVjutB7wVHdA2hciEpb1E9ds
   YXaxHnjOGuAEU1wYB72oZYEkLd/ZRUXt6HD1akFotqE8bBlV8YKhFMQXF
   LUxMGXfHPfchRMZ7XgVMiEGZdnAVvrtJWjSyzAjWD4nHivAB1W6PWxY8s
   MIhFwnElNoS399KxfkMhP24Wg7ZBsHTIJXQ8LVkRX7i5JrGDwGXsHiPr4
   JUIfLK63RW8uRMQlKObDCuq1uZHIkfw8oMrCdX+Zxhk6IcNELiujRTHHj
   U7SNcEEIVJup5N2Hl1Su+H66tdzV9nasHDU3pYxgDQtRiUVrwulrD6ndL
   w==;
X-CSE-ConnectionGUID: EkLOv9MkTlysar002m0X/w==
X-CSE-MsgGUID: I1gmrRgLReOeXhRlsiWmNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="40478673"
X-IronPort-AV: E=Sophos;i="6.13,217,1732608000"; 
   d="scan'208";a="40478673"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 07:31:55 -0800
X-CSE-ConnectionGUID: 1mT+3to9RkCBRLe9hiRNsA==
X-CSE-MsgGUID: IcypQne0TwmvtrwnhsFiFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="111238552"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Jan 2025 07:31:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZXHE-000VYF-0y;
	Sun, 19 Jan 2025 15:31:52 +0000
Date: Sun, 19 Jan 2025 23:31:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 dfa2f4d5f9e5d757700cefa8ee480099889f1c69
Message-ID: <202501192317.ori8XoDW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: dfa2f4d5f9e5d757700cefa8ee480099889f1c69  PCI: Remove devres from pci_intx()

elapsed time: 1101m

configs tested: 132
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250119    gcc-13.2.0
arc                   randconfig-002-20250119    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    clang-20
arm                   randconfig-001-20250119    gcc-14.2.0
arm                   randconfig-002-20250119    clang-20
arm                   randconfig-003-20250119    clang-16
arm                   randconfig-004-20250119    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm                        spear3xx_defconfig    clang-16
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250119    clang-20
arm64                 randconfig-002-20250119    clang-20
arm64                 randconfig-003-20250119    gcc-14.2.0
arm64                 randconfig-004-20250119    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250119    gcc-14.2.0
csky                  randconfig-002-20250119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20250119    clang-20
hexagon               randconfig-002-20250119    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250119    clang-19
i386        buildonly-randconfig-002-20250119    gcc-12
i386        buildonly-randconfig-003-20250119    gcc-12
i386        buildonly-randconfig-004-20250119    gcc-12
i386        buildonly-randconfig-005-20250119    clang-19
i386        buildonly-randconfig-006-20250119    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250119    gcc-14.2.0
loongarch             randconfig-002-20250119    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                           jazz_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250119    gcc-14.2.0
nios2                 randconfig-002-20250119    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250119    gcc-14.2.0
parisc                randconfig-002-20250119    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      katmai_defconfig    clang-18
powerpc                  mpc885_ads_defconfig    clang-18
powerpc               randconfig-001-20250119    clang-20
powerpc               randconfig-002-20250119    clang-20
powerpc               randconfig-003-20250119    clang-16
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250119    clang-18
powerpc64             randconfig-002-20250119    clang-16
powerpc64             randconfig-003-20250119    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250119    gcc-14.2.0
riscv                 randconfig-002-20250119    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250119    clang-20
s390                  randconfig-002-20250119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250119    gcc-14.2.0
sh                    randconfig-002-20250119    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250119    gcc-14.2.0
sparc                 randconfig-002-20250119    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250119    gcc-14.2.0
sparc64               randconfig-002-20250119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250119    clang-18
um                    randconfig-002-20250119    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250119    clang-19
x86_64      buildonly-randconfig-002-20250119    gcc-12
x86_64      buildonly-randconfig-003-20250119    gcc-12
x86_64      buildonly-randconfig-004-20250119    clang-19
x86_64      buildonly-randconfig-005-20250119    gcc-12
x86_64      buildonly-randconfig-006-20250119    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250119    gcc-14.2.0
xtensa                randconfig-002-20250119    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

