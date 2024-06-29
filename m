Return-Path: <linux-pci+bounces-9457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9991CFB0
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 01:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB601F21C9A
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 23:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE23B1AC;
	Sat, 29 Jun 2024 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoVWdeFH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A1224CE
	for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719704120; cv=none; b=H12DQ1GYATmWscq5qGP4axSCPGsR2dvAR1OH8/5yWb/Y4BqlOtdjuWWkjFIGtVnv4F3il+YEJMVlAd7G/6qWNb0TeFXw2pcQmv+3m7CDvQG0MrFvAHfTjEdm7fuIvYKzAufI6eOD1+jeNuV/vB0JMry35XsQNk4bzydh4KivO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719704120; c=relaxed/simple;
	bh=a/dcUlqNgPm1PwDncpqODK7muBBQXs+VXNikkbI21dk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ixVsa6BMdGxufvABo+fChe3ILLEtu6YkYboMQmpAaE1a1s1IsOUQB2IAw+q0gDfo3Thm+nmfiFmednA9AWmFvheH9prtaz54qtbQOZuBKxK7Aw/ItMfNTMCik0Y+SEtEleIzPh32rpq/l+OuXKyc4ZUmrTqkVvpNHDPgJ9eZjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoVWdeFH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719704118; x=1751240118;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a/dcUlqNgPm1PwDncpqODK7muBBQXs+VXNikkbI21dk=;
  b=BoVWdeFHNhsGtwpgGFXH26oz1to8Tgd2S2lmmYRJNsdqZKFidN25ONl3
   ryeqZzbz9J+W4dA5k2HVQbsNHIA/PXPJaCYVTQs2Lve8tQmiM5ewrlRmm
   BOxzSn/RLMzUOAPxwi54rBl2hQoDqRdXzlQ4pMThOAdVjMJvuwmfRwowK
   BimXLxmnZKFnCIB9e9u72sG9kP7hQcEV+yT0woN/ilwK6m0xK8LTW2Nyc
   GsExezuhMWiP8v1OE3esG18CwTkCDGOow4U/xfB60o2+lnt6EDyAQ0P0q
   3k2ua/RflIypu4+++7SJ9bCpRGZ4f6YsvDCPFytyhpIsaLMRYk0cXwdUR
   A==;
X-CSE-ConnectionGUID: ydh16uCzTE6Gm5R/3KdNFQ==
X-CSE-MsgGUID: Ak5X2LoLTtmHF4vlgu41Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="12319180"
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="12319180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 16:35:18 -0700
X-CSE-ConnectionGUID: H5QSPUs7TK2BGId61P//0w==
X-CSE-MsgGUID: JR5U1u9fSr6HobZmDwKNZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="49569540"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jun 2024 16:35:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNhb8-000KPN-1v;
	Sat, 29 Jun 2024 23:35:14 +0000
Date: Sun, 30 Jun 2024 07:34:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/keystone] BUILD SUCCESS
 86f271f22bbb6391410a07e08d6ca3757fda01fa
Message-ID: <202406300738.tKCDJTld-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
branch HEAD: 86f271f22bbb6391410a07e08d6ca3757fda01fa  PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

elapsed time: 1491m

configs tested: 209
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240629   gcc-13.2.0
arc                   randconfig-002-20240629   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                       imx_v6_v7_defconfig   gcc-13.2.0
arm                        mvebu_v5_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240629   gcc-13.2.0
arm                   randconfig-002-20240629   gcc-13.2.0
arm                   randconfig-003-20240629   gcc-13.2.0
arm                   randconfig-004-20240629   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240629   gcc-13.2.0
arm64                 randconfig-002-20240629   gcc-13.2.0
arm64                 randconfig-003-20240629   gcc-13.2.0
arm64                 randconfig-004-20240629   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240629   gcc-13.2.0
csky                  randconfig-002-20240629   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240629   gcc-13.2.0
loongarch             randconfig-002-20240629   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240629   gcc-13.2.0
nios2                 randconfig-002-20240629   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240629   gcc-13.2.0
parisc                randconfig-002-20240629   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                       holly_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240629   gcc-13.2.0
powerpc               randconfig-002-20240629   gcc-13.2.0
powerpc               randconfig-003-20240629   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc                         wii_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240629   gcc-13.2.0
powerpc64             randconfig-002-20240629   gcc-13.2.0
powerpc64             randconfig-003-20240629   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240629   gcc-13.2.0
riscv                 randconfig-002-20240629   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240629   gcc-13.2.0
s390                  randconfig-002-20240629   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                         apsh4a3a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                    randconfig-001-20240629   gcc-13.2.0
sh                    randconfig-002-20240629   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                           se7343_defconfig   gcc-13.2.0
sh                           se7722_defconfig   gcc-13.2.0
sh                           se7724_defconfig   gcc-13.2.0
sh                           se7780_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240629   gcc-13.2.0
sparc64               randconfig-002-20240629   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240629   gcc-13.2.0
um                    randconfig-002-20240629   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240629   clang-18
x86_64       buildonly-randconfig-001-20240630   gcc-13
x86_64       buildonly-randconfig-002-20240629   clang-18
x86_64       buildonly-randconfig-002-20240630   gcc-13
x86_64       buildonly-randconfig-003-20240629   clang-18
x86_64       buildonly-randconfig-003-20240630   gcc-13
x86_64       buildonly-randconfig-004-20240629   clang-18
x86_64       buildonly-randconfig-004-20240630   gcc-13
x86_64       buildonly-randconfig-005-20240629   clang-18
x86_64       buildonly-randconfig-005-20240630   gcc-13
x86_64       buildonly-randconfig-006-20240629   clang-18
x86_64       buildonly-randconfig-006-20240630   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240629   clang-18
x86_64                randconfig-001-20240630   gcc-13
x86_64                randconfig-002-20240629   clang-18
x86_64                randconfig-002-20240630   gcc-13
x86_64                randconfig-003-20240629   clang-18
x86_64                randconfig-003-20240630   gcc-13
x86_64                randconfig-004-20240629   clang-18
x86_64                randconfig-004-20240630   gcc-13
x86_64                randconfig-005-20240629   clang-18
x86_64                randconfig-005-20240630   gcc-13
x86_64                randconfig-006-20240629   clang-18
x86_64                randconfig-006-20240630   gcc-13
x86_64                randconfig-011-20240629   clang-18
x86_64                randconfig-011-20240630   gcc-13
x86_64                randconfig-012-20240629   clang-18
x86_64                randconfig-012-20240630   gcc-13
x86_64                randconfig-013-20240629   clang-18
x86_64                randconfig-013-20240630   gcc-13
x86_64                randconfig-014-20240629   clang-18
x86_64                randconfig-014-20240630   gcc-13
x86_64                randconfig-015-20240629   clang-18
x86_64                randconfig-015-20240630   gcc-13
x86_64                randconfig-016-20240629   clang-18
x86_64                randconfig-016-20240630   gcc-13
x86_64                randconfig-071-20240629   clang-18
x86_64                randconfig-071-20240630   gcc-13
x86_64                randconfig-072-20240629   clang-18
x86_64                randconfig-072-20240630   gcc-13
x86_64                randconfig-073-20240629   clang-18
x86_64                randconfig-073-20240630   gcc-13
x86_64                randconfig-074-20240629   clang-18
x86_64                randconfig-074-20240630   gcc-13
x86_64                randconfig-075-20240629   clang-18
x86_64                randconfig-075-20240630   gcc-13
x86_64                randconfig-076-20240629   clang-18
x86_64                randconfig-076-20240630   gcc-13
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240629   gcc-13.2.0
xtensa                randconfig-002-20240629   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

