Return-Path: <linux-pci+bounces-9974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B892AEDF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 05:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F73281FF0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 03:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03C3A1DB;
	Tue,  9 Jul 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0FTw3LK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317134A0C
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720497246; cv=none; b=S0efX9swQr3QlGHUO6k/TsZPvHxgEBEiUpN31jLhbhvei8j1WLDrhuW48bUlnAx0j+DzVx/Spp6DK3E4EeuKSuOP1HGFENU0TEZTIDVba4rS5VCrXECOHUT5b6KCR97Xu+8udnj3KQSGf02Qq+Fr4lC7/xpxfS7wEYoeDUqUYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720497246; c=relaxed/simple;
	bh=xRsfGiMOqZ0xhHoXyiL5Hsv6b+YafHbSzW5RFuyocSE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aJ005CjGRlIzpUaKbAzvKnKNQMEVEN77kz2cugP8zLk+cTeUnjbgAK0ImexxAxkqayXDHcHKgag8tEq7hRdbm+t11+gbywL27LGZvAyiR1ggC+jYeRlNPbJRopraTjUJhHyyBw1I10N9dMsSLvITZocaWmBHDt6F7bMUB25mCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0FTw3LK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720497244; x=1752033244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xRsfGiMOqZ0xhHoXyiL5Hsv6b+YafHbSzW5RFuyocSE=;
  b=e0FTw3LKOGyyeol88PjG65W+DACnyJwSGjzEBg0Z1zoaaEJo454ZEW3w
   CYaZQenYDOmHGYbysO59C2ILKs7N9xW50RW9lEXRZmWN6ZZHDjbljrowH
   J3tAuEqRZoi0wHo+KncQ4ne3+cXtZ4YK79/tpW4hW5TdmuMdMirABi6YH
   Jng7AZrP+71Mq6MF5jC5x9UopZzX0O0sQFDsIu8eSPXHiBSIV4b2SJkxF
   Ba+u5Yz9VvWdBRi/eO7WqCjqV9Nyo3EpScXHga/Dmd4JY2VY5naQFjHdC
   hNpFe3X4hqJvpfWL2iUOU24RoUki9EO6E9nuez7kSC1IvkhkYYk3bYdnm
   Q==;
X-CSE-ConnectionGUID: WxDU7pkGSK6Ia5pxe/41mg==
X-CSE-MsgGUID: +WLfFhXTRZOqJJWlbCCHHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="12443420"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="12443420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 20:54:04 -0700
X-CSE-ConnectionGUID: lbSbgU2OT/2r++bvIQfgTg==
X-CSE-MsgGUID: zz0y0PeJTTW4m8OPQ8yt1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="47480429"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jul 2024 20:54:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sR1vU-000WIa-1M;
	Tue, 09 Jul 2024 03:54:00 +0000
Date: Tue, 09 Jul 2024 11:53:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 667017e99d274d38968663649d99b9cb079edfb9
Message-ID: <202407091100.tcJ66QKg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 667017e99d274d38968663649d99b9cb079edfb9  Documentation: PCI: pci-endpoint: Fix EPF ops list

elapsed time: 1120m

configs tested: 312
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240708   gcc-13.2.0
arc                   randconfig-001-20240709   gcc-13.2.0
arc                   randconfig-002-20240708   gcc-13.2.0
arc                   randconfig-002-20240709   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              alldefconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                          moxart_defconfig   clang-19
arm                        mvebu_v5_defconfig   clang-19
arm                         nhk8815_defconfig   gcc-13.2.0
arm                             pxa_defconfig   clang-19
arm                   randconfig-001-20240708   gcc-13.2.0
arm                   randconfig-001-20240709   gcc-13.2.0
arm                   randconfig-002-20240708   gcc-13.2.0
arm                   randconfig-002-20240709   gcc-13.2.0
arm                   randconfig-003-20240708   gcc-13.2.0
arm                   randconfig-003-20240709   gcc-13.2.0
arm                   randconfig-004-20240708   gcc-13.2.0
arm                   randconfig-004-20240709   gcc-13.2.0
arm                        spear6xx_defconfig   gcc-13.2.0
arm                         vf610m4_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240708   gcc-13.2.0
arm64                 randconfig-001-20240709   gcc-13.2.0
arm64                 randconfig-002-20240708   gcc-13.2.0
arm64                 randconfig-002-20240709   gcc-13.2.0
arm64                 randconfig-003-20240708   gcc-13.2.0
arm64                 randconfig-003-20240709   gcc-13.2.0
arm64                 randconfig-004-20240708   gcc-13.2.0
arm64                 randconfig-004-20240709   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240708   gcc-13.2.0
csky                  randconfig-001-20240709   gcc-13.2.0
csky                  randconfig-002-20240708   gcc-13.2.0
csky                  randconfig-002-20240709   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240708   clang-18
i386         buildonly-randconfig-001-20240709   gcc-11
i386         buildonly-randconfig-002-20240708   clang-18
i386         buildonly-randconfig-002-20240709   gcc-11
i386         buildonly-randconfig-003-20240708   clang-18
i386         buildonly-randconfig-003-20240709   gcc-11
i386         buildonly-randconfig-004-20240708   clang-18
i386         buildonly-randconfig-004-20240709   gcc-11
i386         buildonly-randconfig-005-20240708   clang-18
i386         buildonly-randconfig-005-20240709   gcc-11
i386         buildonly-randconfig-006-20240708   clang-18
i386         buildonly-randconfig-006-20240709   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240708   clang-18
i386                  randconfig-001-20240709   gcc-11
i386                  randconfig-002-20240708   clang-18
i386                  randconfig-002-20240709   gcc-11
i386                  randconfig-003-20240708   clang-18
i386                  randconfig-003-20240709   gcc-11
i386                  randconfig-004-20240708   clang-18
i386                  randconfig-004-20240709   gcc-11
i386                  randconfig-005-20240708   clang-18
i386                  randconfig-005-20240709   gcc-11
i386                  randconfig-006-20240708   clang-18
i386                  randconfig-006-20240709   gcc-11
i386                  randconfig-011-20240708   clang-18
i386                  randconfig-011-20240709   gcc-11
i386                  randconfig-012-20240708   clang-18
i386                  randconfig-012-20240709   gcc-11
i386                  randconfig-013-20240708   clang-18
i386                  randconfig-013-20240709   gcc-11
i386                  randconfig-014-20240708   clang-18
i386                  randconfig-014-20240709   gcc-11
i386                  randconfig-015-20240708   clang-18
i386                  randconfig-015-20240709   gcc-11
i386                  randconfig-016-20240708   clang-18
i386                  randconfig-016-20240709   gcc-11
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240708   gcc-13.2.0
loongarch             randconfig-001-20240709   gcc-13.2.0
loongarch             randconfig-002-20240708   gcc-13.2.0
loongarch             randconfig-002-20240709   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                       bvme6000_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   clang-19
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                         3c120_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240708   gcc-13.2.0
nios2                 randconfig-001-20240709   gcc-13.2.0
nios2                 randconfig-002-20240708   gcc-13.2.0
nios2                 randconfig-002-20240709   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240708   gcc-13.2.0
parisc                randconfig-001-20240709   gcc-13.2.0
parisc                randconfig-002-20240708   gcc-13.2.0
parisc                randconfig-002-20240709   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   gcc-13.2.0
powerpc                       holly_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-13.2.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc                      mgcoge_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   clang-19
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   clang-19
powerpc                     powernv_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   clang-19
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240708   gcc-13.2.0
powerpc               randconfig-001-20240709   gcc-13.2.0
powerpc               randconfig-002-20240708   gcc-13.2.0
powerpc               randconfig-002-20240709   gcc-13.2.0
powerpc               randconfig-003-20240708   gcc-13.2.0
powerpc               randconfig-003-20240709   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   clang-19
powerpc                     tqm5200_defconfig   clang-19
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8555_defconfig   clang-19
powerpc                      tqm8xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240708   gcc-13.2.0
powerpc64             randconfig-001-20240709   gcc-13.2.0
powerpc64             randconfig-002-20240708   gcc-13.2.0
powerpc64             randconfig-002-20240709   gcc-13.2.0
powerpc64             randconfig-003-20240708   gcc-13.2.0
powerpc64             randconfig-003-20240709   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240708   gcc-13.2.0
riscv                 randconfig-001-20240709   gcc-13.2.0
riscv                 randconfig-002-20240708   gcc-13.2.0
riscv                 randconfig-002-20240709   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240708   gcc-13.2.0
s390                  randconfig-001-20240709   gcc-13.2.0
s390                  randconfig-002-20240708   gcc-13.2.0
s390                  randconfig-002-20240709   gcc-13.2.0
s390                       zfcpdump_defconfig   gcc-13.2.0
sh                               alldefconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                            hp6xx_defconfig   gcc-13.2.0
sh                    randconfig-001-20240708   gcc-13.2.0
sh                    randconfig-001-20240709   gcc-13.2.0
sh                    randconfig-002-20240708   gcc-13.2.0
sh                    randconfig-002-20240709   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240708   gcc-13.2.0
sparc64               randconfig-001-20240709   gcc-13.2.0
sparc64               randconfig-002-20240708   gcc-13.2.0
sparc64               randconfig-002-20240709   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240708   gcc-13.2.0
um                    randconfig-001-20240709   gcc-13.2.0
um                    randconfig-002-20240708   gcc-13.2.0
um                    randconfig-002-20240709   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240708   gcc-13
x86_64       buildonly-randconfig-001-20240709   gcc-11
x86_64       buildonly-randconfig-002-20240708   gcc-13
x86_64       buildonly-randconfig-002-20240709   gcc-11
x86_64       buildonly-randconfig-003-20240708   gcc-13
x86_64       buildonly-randconfig-003-20240709   gcc-11
x86_64       buildonly-randconfig-004-20240708   gcc-13
x86_64       buildonly-randconfig-004-20240709   gcc-11
x86_64       buildonly-randconfig-005-20240708   gcc-13
x86_64       buildonly-randconfig-005-20240709   gcc-11
x86_64       buildonly-randconfig-006-20240708   gcc-13
x86_64       buildonly-randconfig-006-20240709   gcc-11
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240708   gcc-13
x86_64                randconfig-001-20240709   gcc-11
x86_64                randconfig-002-20240708   gcc-13
x86_64                randconfig-002-20240709   gcc-11
x86_64                randconfig-003-20240708   gcc-13
x86_64                randconfig-003-20240709   gcc-11
x86_64                randconfig-004-20240708   gcc-13
x86_64                randconfig-004-20240709   gcc-11
x86_64                randconfig-005-20240708   gcc-13
x86_64                randconfig-005-20240709   gcc-11
x86_64                randconfig-006-20240708   gcc-13
x86_64                randconfig-006-20240709   gcc-11
x86_64                randconfig-011-20240708   gcc-13
x86_64                randconfig-011-20240709   gcc-11
x86_64                randconfig-012-20240708   gcc-13
x86_64                randconfig-012-20240709   gcc-11
x86_64                randconfig-013-20240708   gcc-13
x86_64                randconfig-013-20240709   gcc-11
x86_64                randconfig-014-20240708   gcc-13
x86_64                randconfig-014-20240709   gcc-11
x86_64                randconfig-015-20240708   gcc-13
x86_64                randconfig-015-20240709   gcc-11
x86_64                randconfig-016-20240708   gcc-13
x86_64                randconfig-016-20240709   gcc-11
x86_64                randconfig-071-20240708   gcc-13
x86_64                randconfig-071-20240709   gcc-11
x86_64                randconfig-072-20240708   gcc-13
x86_64                randconfig-072-20240709   gcc-11
x86_64                randconfig-073-20240708   gcc-13
x86_64                randconfig-073-20240709   gcc-11
x86_64                randconfig-074-20240708   gcc-13
x86_64                randconfig-074-20240709   gcc-11
x86_64                randconfig-075-20240708   gcc-13
x86_64                randconfig-075-20240709   gcc-11
x86_64                randconfig-076-20240708   gcc-13
x86_64                randconfig-076-20240709   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240708   gcc-13.2.0
xtensa                randconfig-001-20240709   gcc-13.2.0
xtensa                randconfig-002-20240708   gcc-13.2.0
xtensa                randconfig-002-20240709   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

