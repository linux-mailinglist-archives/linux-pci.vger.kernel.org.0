Return-Path: <linux-pci+bounces-9840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A4928970
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 15:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6506C284C32
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E644149DF7;
	Fri,  5 Jul 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4BB0q4B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C8149E0B
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185522; cv=none; b=FsCcMut86rRaM0B8T/2m5rgNygaSGG+8wlvOGURcoqNwSatWuLaaRgjIW6jyo3d9yzODkxKPeuBTDShqX/MCqYlOn8aiUgPXQKvJohpC5YQHsTYPXJgMjudqYrw3BpmevFe8sC+LWe3JYV+Wss6e+9mwL36Zu47JoP91x1kbAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185522; c=relaxed/simple;
	bh=/W4G0/Foc++OtqrxoLXNDTFTKoiOwKgK89jirC0tGDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qjSR6/k2V9juT+VvAFfnT7lBNzNNb/3kVn/P+NEbU/ELgvJLO0n5jKTXmpP7Ec2fHyr9Y4MM4PDdrksfKnMJXCh4qTvxA1VZC8lDl8ZvWUUKLIlFClvJArsxhgqGEmK0CjvVWigx0Rbsw7RtLDktR8VW4TwU00CTgeoO+geg3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4BB0q4B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720185521; x=1751721521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/W4G0/Foc++OtqrxoLXNDTFTKoiOwKgK89jirC0tGDA=;
  b=V4BB0q4Brb4t7YycGFPgzVdaHdYfvQgMbQxwGMKd+BXZneJJfPM5IOdG
   7vn1PRFsqbzD1a58RBawLFI+ll7Yr762MjrLhe5Vv5tQV2C4x8feikvN9
   syR8MSVy6NpXdzL4mIaqgGAGflwnPQLCSBEI9lx8cE8BNxFfdMtOlufSj
   JDU4sWz5C1hE4xJdKQxjQhuDY7oohOlmeGn7Du2xM8Nt3EBdHXG90yYyu
   GSta/mx6dOjj/93IWYaSL3XD4mPdOpRw8QbAYB/F+2uD+i6IqHAsMqE5N
   plSb/nmZ7ydlzxJPnzoZGoCEJATmyCZSbgV0C/9KQ7YxsiLMovkbVM5VG
   A==;
X-CSE-ConnectionGUID: vP49fettRruSOyAXpEj6fw==
X-CSE-MsgGUID: S0nvcQ4GQdWVOqGBhoMAbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17613347"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17613347"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:18:40 -0700
X-CSE-ConnectionGUID: 556HuQngQymEnKTnb0B1Rw==
X-CSE-MsgGUID: ezFionGSQJ6azIrFpJs61g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46654962"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Jul 2024 06:18:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPipg-000SPT-2O;
	Fri, 05 Jul 2024 13:18:36 +0000
Date: Fri, 05 Jul 2024 21:18:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 ddd49d2aab1ddab3f160e0b0e4f75e0766cd4284
Message-ID: <202407052108.fzFjjNwV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: ddd49d2aab1ddab3f160e0b0e4f75e0766cd4284  Documentation: PCI: pci-endpoint: Fix EPF ops list

elapsed time: 1313m

configs tested: 213
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240705   gcc-13.2.0
arc                   randconfig-002-20240705   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         axm55xx_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                          pxa3xx_defconfig   gcc-13.2.0
arm                   randconfig-001-20240705   gcc-13.2.0
arm                   randconfig-002-20240705   gcc-13.2.0
arm                   randconfig-003-20240705   gcc-13.2.0
arm                   randconfig-004-20240705   gcc-13.2.0
arm                          sp7021_defconfig   gcc-13.2.0
arm                           u8500_defconfig   gcc-13.2.0
arm                         vf610m4_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240705   gcc-13.2.0
arm64                 randconfig-002-20240705   gcc-13.2.0
arm64                 randconfig-003-20240705   gcc-13.2.0
arm64                 randconfig-004-20240705   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240705   gcc-13.2.0
csky                  randconfig-002-20240705   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240705   gcc-13
i386         buildonly-randconfig-002-20240705   gcc-13
i386         buildonly-randconfig-002-20240705   gcc-9
i386         buildonly-randconfig-003-20240705   gcc-11
i386         buildonly-randconfig-003-20240705   gcc-13
i386         buildonly-randconfig-004-20240705   clang-18
i386         buildonly-randconfig-004-20240705   gcc-13
i386         buildonly-randconfig-005-20240705   clang-18
i386         buildonly-randconfig-005-20240705   gcc-13
i386         buildonly-randconfig-006-20240705   clang-18
i386         buildonly-randconfig-006-20240705   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240705   gcc-13
i386                  randconfig-002-20240705   clang-18
i386                  randconfig-002-20240705   gcc-13
i386                  randconfig-003-20240705   gcc-11
i386                  randconfig-003-20240705   gcc-13
i386                  randconfig-004-20240705   gcc-13
i386                  randconfig-005-20240705   clang-18
i386                  randconfig-005-20240705   gcc-13
i386                  randconfig-006-20240705   clang-18
i386                  randconfig-006-20240705   gcc-13
i386                  randconfig-011-20240705   gcc-13
i386                  randconfig-012-20240705   gcc-13
i386                  randconfig-013-20240705   clang-18
i386                  randconfig-013-20240705   gcc-13
i386                  randconfig-014-20240705   gcc-13
i386                  randconfig-014-20240705   gcc-8
i386                  randconfig-015-20240705   gcc-10
i386                  randconfig-015-20240705   gcc-13
i386                  randconfig-016-20240705   clang-18
i386                  randconfig-016-20240705   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240705   gcc-13.2.0
loongarch             randconfig-002-20240705   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                  decstation_64_defconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                          rb532_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240705   gcc-13.2.0
nios2                 randconfig-002-20240705   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240705   gcc-13.2.0
parisc                randconfig-002-20240705   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                   currituck_defconfig   gcc-13.2.0
powerpc                          g5_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   gcc-13.2.0
powerpc                      pasemi_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   gcc-13.2.0
powerpc                      ppc64e_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240705   gcc-13.2.0
powerpc64             randconfig-002-20240705   gcc-13.2.0
powerpc64             randconfig-003-20240705   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240705   gcc-13.2.0
riscv                 randconfig-002-20240705   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240705   gcc-13.2.0
s390                  randconfig-002-20240705   gcc-13.2.0
s390                       zfcpdump_defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240705   gcc-13.2.0
sh                    randconfig-002-20240705   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240705   gcc-13.2.0
sparc64               randconfig-002-20240705   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240705   gcc-13.2.0
um                    randconfig-002-20240705   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240705   gcc-7
x86_64       buildonly-randconfig-002-20240705   gcc-7
x86_64       buildonly-randconfig-003-20240705   gcc-7
x86_64       buildonly-randconfig-004-20240705   gcc-7
x86_64       buildonly-randconfig-005-20240705   gcc-7
x86_64       buildonly-randconfig-006-20240705   gcc-7
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240705   gcc-7
x86_64                randconfig-002-20240705   gcc-7
x86_64                randconfig-003-20240705   gcc-7
x86_64                randconfig-004-20240705   gcc-7
x86_64                randconfig-005-20240705   gcc-7
x86_64                randconfig-006-20240705   gcc-7
x86_64                randconfig-011-20240705   gcc-7
x86_64                randconfig-012-20240705   gcc-7
x86_64                randconfig-013-20240705   gcc-7
x86_64                randconfig-014-20240705   gcc-7
x86_64                randconfig-015-20240705   gcc-7
x86_64                randconfig-016-20240705   gcc-7
x86_64                randconfig-071-20240705   gcc-7
x86_64                randconfig-072-20240705   gcc-7
x86_64                randconfig-073-20240705   gcc-7
x86_64                randconfig-074-20240705   gcc-7
x86_64                randconfig-075-20240705   gcc-7
x86_64                randconfig-076-20240705   gcc-7
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240705   gcc-13.2.0
xtensa                randconfig-002-20240705   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

