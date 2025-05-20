Return-Path: <linux-pci+bounces-28067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B9ABCF20
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 08:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA734A3EDA
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 06:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315C25CC5E;
	Tue, 20 May 2025 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIB/YA0i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61625CC58
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722060; cv=none; b=Y2Qj8GJA2cG4pSIbO0QkQHmN1Q2fTYrEXAO4covn6seKTBlyoylvDlKQHY21XeRRMhp7suElpYPeSDV7UaEw89sDtf7DwlPRYr71uOQ2OY8uwrn2bSCZkhWM1DL7gOk1OnQeiIX8vvbqxOd6WICzJNKHkdCpiWycH84+EEaEnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722060; c=relaxed/simple;
	bh=J7aQPdz77btnliXPo4Aop9BWGSHnMiPDzbo+Gn5rYnU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MAeGqBiXrqHaSH7vo1PGChPcVWhd0ov46RPxDiBRo1HeMaAfdGFE8vHEabbFnSoPinUQSlm/l/aTqAUqieReuYcOdg6AnM+2CBBoj5mfFOpLCiiNQRJE0SAU7wV3Plao9crqyjbaYUPRwtqHEPah2+Y34ulwtrFg+fwX6Uol8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIB/YA0i; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747722058; x=1779258058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J7aQPdz77btnliXPo4Aop9BWGSHnMiPDzbo+Gn5rYnU=;
  b=hIB/YA0i78PUMSmUqqjfGowN6VwFws1ssbKuMrxbTXh5As3yvUXAAe3X
   tYOeUTZc5dQd+F5n0f4Nfm3mxFOxJDR2EPAWS9NUTVYB4gD631b2moFCd
   gi/9hKjozuE+jYV+lvBGAqtmXSpU6A7cTyiEQNqI4XS3fvl+xLjuFz4HN
   Wb1s3XtlJdL0TYzcgeLXLDBpjFF7ZxdVQiRJGtMRiUSFAUgE546FMZSoZ
   EkMXZ39W81UJmaR7EZVOTLhMMqQ5dpNH5uFf/FbrYI1mXXkw3JrEk33Oj
   ed557MVjAYPY1EcCi57QktnEtnEm2Y9dYTw/qRE4cg24fhYxXX9nzsU5K
   g==;
X-CSE-ConnectionGUID: ygy9DLZBT02ayEeMjcGs7A==
X-CSE-MsgGUID: 72K5/ElFS+iicxGsyX+LOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48753255"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48753255"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 23:20:57 -0700
X-CSE-ConnectionGUID: Vq3drWB4TsaTSJEszKobyA==
X-CSE-MsgGUID: InK1BU/8TZCrbKfPJzqoWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="143594258"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 May 2025 23:20:56 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHGLO-000MDO-0r;
	Tue, 20 May 2025 06:20:54 +0000
Date: Tue, 20 May 2025 14:20:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 aa182e808041566ecf9a8123da0773ec2b96f134
Message-ID: <202505201401.dmS1ncNq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: aa182e808041566ecf9a8123da0773ec2b96f134  PCI: Remove hybrid-devres usage warnings from kernel-doc

elapsed time: 1032m

configs tested: 254
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                   randconfig-001-20250519    gcc-12.4.0
arc                   randconfig-001-20250520    gcc-8.5.0
arc                   randconfig-002-20250519    gcc-8.5.0
arc                   randconfig-002-20250520    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                         bcm2835_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                       multi_v4t_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250519    clang-18
arm                   randconfig-001-20250520    gcc-8.5.0
arm                   randconfig-002-20250519    clang-21
arm                   randconfig-002-20250520    gcc-8.5.0
arm                   randconfig-003-20250519    clang-20
arm                   randconfig-003-20250520    gcc-8.5.0
arm                   randconfig-004-20250519    clang-21
arm                   randconfig-004-20250520    gcc-8.5.0
arm                        realview_defconfig    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250519    clang-17
arm64                 randconfig-001-20250520    gcc-8.5.0
arm64                 randconfig-002-20250519    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-8.5.0
arm64                 randconfig-003-20250519    clang-19
arm64                 randconfig-003-20250520    gcc-8.5.0
arm64                 randconfig-004-20250519    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250519    gcc-10.5.0
csky                  randconfig-001-20250520    gcc-9.3.0
csky                  randconfig-002-20250519    gcc-14.2.0
csky                  randconfig-002-20250520    gcc-9.3.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250519    clang-21
hexagon               randconfig-001-20250520    gcc-9.3.0
hexagon               randconfig-002-20250519    clang-21
hexagon               randconfig-002-20250520    gcc-9.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250519    clang-20
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-002-20250519    clang-20
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-003-20250519    gcc-12
i386        buildonly-randconfig-003-20250520    gcc-12
i386        buildonly-randconfig-004-20250519    gcc-12
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-005-20250519    gcc-12
i386        buildonly-randconfig-005-20250520    gcc-12
i386        buildonly-randconfig-006-20250519    clang-20
i386        buildonly-randconfig-006-20250520    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250520    gcc-12
i386                  randconfig-002-20250520    gcc-12
i386                  randconfig-003-20250520    gcc-12
i386                  randconfig-004-20250520    gcc-12
i386                  randconfig-005-20250520    gcc-12
i386                  randconfig-006-20250520    gcc-12
i386                  randconfig-007-20250520    gcc-12
i386                  randconfig-011-20250520    gcc-12
i386                  randconfig-012-20250520    gcc-12
i386                  randconfig-013-20250520    gcc-12
i386                  randconfig-014-20250520    gcc-12
i386                  randconfig-015-20250520    gcc-12
i386                  randconfig-016-20250520    gcc-12
i386                  randconfig-017-20250520    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250519    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-9.3.0
loongarch             randconfig-002-20250519    gcc-12.4.0
loongarch             randconfig-002-20250520    gcc-9.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250519    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-002-20250519    gcc-6.5.0
nios2                 randconfig-002-20250520    gcc-9.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250519    gcc-7.5.0
parisc                randconfig-001-20250520    gcc-9.3.0
parisc                randconfig-002-20250519    gcc-13.3.0
parisc                randconfig-002-20250520    gcc-9.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-19
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-21
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    clang-21
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250519    gcc-8.5.0
powerpc               randconfig-001-20250520    gcc-9.3.0
powerpc               randconfig-002-20250519    gcc-6.5.0
powerpc               randconfig-002-20250520    gcc-9.3.0
powerpc               randconfig-003-20250519    gcc-8.5.0
powerpc               randconfig-003-20250520    gcc-9.3.0
powerpc64             randconfig-001-20250519    clang-20
powerpc64             randconfig-001-20250520    gcc-9.3.0
powerpc64             randconfig-002-20250519    gcc-6.5.0
powerpc64             randconfig-002-20250520    gcc-9.3.0
powerpc64             randconfig-003-20250519    gcc-6.5.0
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250519    gcc-14.2.0
riscv                 randconfig-001-20250520    gcc-12.4.0
riscv                 randconfig-002-20250519    clang-17
riscv                 randconfig-002-20250520    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250519    gcc-7.5.0
s390                  randconfig-001-20250520    gcc-12.4.0
s390                  randconfig-002-20250519    gcc-9.3.0
s390                  randconfig-002-20250520    gcc-12.4.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250519    gcc-12.4.0
sh                    randconfig-001-20250520    gcc-12.4.0
sh                    randconfig-002-20250519    gcc-14.2.0
sh                    randconfig-002-20250520    gcc-12.4.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250519    gcc-11.5.0
sparc                 randconfig-001-20250520    gcc-12.4.0
sparc                 randconfig-002-20250519    gcc-7.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250519    gcc-7.5.0
sparc64               randconfig-001-20250520    gcc-12.4.0
sparc64               randconfig-002-20250519    gcc-11.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250519    gcc-12
um                    randconfig-001-20250520    gcc-12.4.0
um                    randconfig-002-20250519    gcc-12
um                    randconfig-002-20250520    gcc-12.4.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250519    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250519    gcc-12
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250519    clang-20
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250519    clang-20
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250519    gcc-12
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250519    gcc-12
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250520    gcc-12
x86_64                randconfig-002-20250520    gcc-12
x86_64                randconfig-003-20250520    gcc-12
x86_64                randconfig-004-20250520    gcc-12
x86_64                randconfig-005-20250520    gcc-12
x86_64                randconfig-006-20250520    gcc-12
x86_64                randconfig-007-20250520    gcc-12
x86_64                randconfig-008-20250520    gcc-12
x86_64                randconfig-071-20250520    gcc-12
x86_64                randconfig-072-20250520    gcc-12
x86_64                randconfig-073-20250520    gcc-12
x86_64                randconfig-074-20250520    gcc-12
x86_64                randconfig-075-20250520    gcc-12
x86_64                randconfig-076-20250520    gcc-12
x86_64                randconfig-077-20250520    gcc-12
x86_64                randconfig-078-20250520    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250519    gcc-7.5.0
xtensa                randconfig-001-20250520    gcc-12.4.0
xtensa                randconfig-002-20250519    gcc-9.3.0
xtensa                randconfig-002-20250520    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

