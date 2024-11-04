Return-Path: <linux-pci+bounces-15935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275849BB0E0
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B2AB20B50
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9D19309A;
	Mon,  4 Nov 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQ+DVtkA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3918C020
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715669; cv=none; b=RjAWckK70f+AYQ/gRmji/GEEg8UGNf2bXydQkgJ+tDaBMaofF9rVljoGHu3JjJOI2PVNdzAvOH22Tl7vsE+d020OlrerczpgtQLIF1KI5wyJXlY+ehg/3uG44YvROqjgulDIWIhqg5Sv1aweTXoqP5cMmgpIbRLmt1y2NlBd9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715669; c=relaxed/simple;
	bh=mxAUMNqHMYotasLflC4XDOsvd5ED5qvjDSSRtxNhyDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZrIrnRJLHvw9MSH76ULxpOgYz3Q9b2h3pGmuVCREp4lJwnt5280zuhkClXKj1V09gFgsFVoQOoGp+1MY5RcEdJnzmIlnXWLpBCuE9x+IWlZm9ilnP9FpZdieJnZCCi0pNrO/o9MPWMMLD07qvTDWaEJ4mySqvgyyj4/DEZQ3wNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQ+DVtkA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730715668; x=1762251668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mxAUMNqHMYotasLflC4XDOsvd5ED5qvjDSSRtxNhyDc=;
  b=cQ+DVtkARimRmQnam3BLUgtLxCsbv7jAjEd6EVzQQvRg6Gd9a7/BGWBx
   /UYMRp0gAesXqMpEG96F2mgtKtXPrcdR4Qm6Y2LE1W0RrM3AzCBu7FJBF
   Zd4bm9/DdZLcqPAJ+dsqPLhviQyudhxM/1fx/KigXzmRJQE3A1ot8T/1j
   MmLXZh3NYbez6yE5+D6qP/IUMf1LAnKkCbv7s8U0GlLYFbzL893/i2MMa
   ih4zsMD0CgaflApqq3iwsf/8yyY28cvkkm/zNBldYm+LoxKFP66jdtL+j
   WYwbCoGZ4OPCLzlTBrgEcxSgZRS95BBiTRrVxhd/i+QvnuUhupUwPf7Fy
   g==;
X-CSE-ConnectionGUID: Hz4PFI4eSmKIvA9/mjws3w==
X-CSE-MsgGUID: wdshop3VRpqyrtdmYXJWyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29820703"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29820703"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 02:21:07 -0800
X-CSE-ConnectionGUID: PAvW2tpFQeu/lOZRVCV8zQ==
X-CSE-MsgGUID: HQOkVcrOQHyPaxd6pXZvmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83545288"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Nov 2024 02:21:05 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7uCl-000kjZ-0t;
	Mon, 04 Nov 2024 10:21:03 +0000
Date: Mon, 04 Nov 2024 18:20:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/j721e] BUILD SUCCESS
 08e835268c35e851b308f326357224248cfb445b
Message-ID: <202411041856.p8A4ttNW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/j721e
branch HEAD: 08e835268c35e851b308f326357224248cfb445b  PCI: j721e: Add PCIe support for J722S SoC

elapsed time: 859m

configs tested: 255
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    clang-20
arc                   randconfig-001-20241104    gcc-14.1.0
arc                   randconfig-002-20241104    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                            dove_defconfig    gcc-14.1.0
arm                          exynos_defconfig    clang-20
arm                       imx_v6_v7_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                         lpc18xx_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-14.1.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                         orion5x_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                   randconfig-001-20241104    gcc-14.1.0
arm                   randconfig-002-20241104    gcc-14.1.0
arm                   randconfig-003-20241104    gcc-14.1.0
arm                   randconfig-004-20241104    gcc-14.1.0
arm                           spitz_defconfig    gcc-14.1.0
arm                         vf610m4_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241104    gcc-14.1.0
arm64                 randconfig-002-20241104    gcc-14.1.0
arm64                 randconfig-003-20241104    gcc-14.1.0
arm64                 randconfig-004-20241104    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241104    gcc-14.1.0
csky                  randconfig-002-20241104    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241104    gcc-14.1.0
hexagon               randconfig-002-20241104    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241104    clang-19
i386        buildonly-randconfig-001-20241104    gcc-12
i386        buildonly-randconfig-002-20241104    gcc-12
i386        buildonly-randconfig-003-20241104    clang-19
i386        buildonly-randconfig-003-20241104    gcc-12
i386        buildonly-randconfig-004-20241104    gcc-12
i386        buildonly-randconfig-005-20241104    clang-19
i386        buildonly-randconfig-005-20241104    gcc-12
i386        buildonly-randconfig-006-20241104    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241104    gcc-12
i386                  randconfig-002-20241104    clang-19
i386                  randconfig-002-20241104    gcc-12
i386                  randconfig-003-20241104    gcc-12
i386                  randconfig-004-20241104    clang-19
i386                  randconfig-004-20241104    gcc-12
i386                  randconfig-005-20241104    clang-19
i386                  randconfig-005-20241104    gcc-12
i386                  randconfig-006-20241104    clang-19
i386                  randconfig-006-20241104    gcc-12
i386                  randconfig-011-20241104    gcc-12
i386                  randconfig-012-20241104    gcc-12
i386                  randconfig-013-20241104    clang-19
i386                  randconfig-013-20241104    gcc-12
i386                  randconfig-014-20241104    gcc-12
i386                  randconfig-015-20241104    gcc-12
i386                  randconfig-016-20241104    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    gcc-14.1.0
loongarch             randconfig-001-20241104    gcc-14.1.0
loongarch             randconfig-002-20241104    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    gcc-14.1.0
mips                           ip28_defconfig    gcc-14.1.0
mips                        maltaup_defconfig    gcc-14.1.0
mips                        qi_lb60_defconfig    clang-20
mips                       rbtx49xx_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241104    gcc-14.1.0
nios2                 randconfig-002-20241104    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.1.0
openrisc                    or1ksim_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-14.1.0
parisc                randconfig-001-20241104    gcc-14.1.0
parisc                randconfig-002-20241104    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                   currituck_defconfig    gcc-14.1.0
powerpc                      ep88xc_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-14.1.0
powerpc                          g5_defconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                        icon_defconfig    gcc-14.1.0
powerpc                 linkstation_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc                  mpc866_ads_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241104    gcc-14.1.0
powerpc               randconfig-002-20241104    gcc-14.1.0
powerpc               randconfig-003-20241104    gcc-14.1.0
powerpc                     taishan_defconfig    gcc-14.1.0
powerpc                     tqm8541_defconfig    gcc-14.1.0
powerpc                     tqm8555_defconfig    gcc-14.1.0
powerpc                     tqm8560_defconfig    gcc-14.1.0
powerpc                         wii_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241104    gcc-14.1.0
powerpc64             randconfig-002-20241104    gcc-14.1.0
powerpc64             randconfig-003-20241104    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-20
riscv                 randconfig-001-20241104    gcc-14.1.0
riscv                 randconfig-002-20241104    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241104    gcc-14.1.0
s390                  randconfig-002-20241104    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                        edosk7760_defconfig    gcc-14.1.0
sh                            hp6xx_defconfig    gcc-14.1.0
sh                          landisk_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    clang-20
sh                          r7785rp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241104    gcc-14.1.0
sh                    randconfig-002-20241104    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                           se7750_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.1.0
sh                        sh7757lcr_defconfig    gcc-14.1.0
sh                   sh7770_generic_defconfig    clang-20
sh                        sh7785lcr_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-14.1.0
sh                              ul2_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                          alldefconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241104    gcc-14.1.0
sparc64               randconfig-002-20241104    gcc-14.1.0
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241104    gcc-14.1.0
um                    randconfig-002-20241104    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241104    gcc-12
x86_64      buildonly-randconfig-002-20241104    gcc-12
x86_64      buildonly-randconfig-003-20241104    gcc-12
x86_64      buildonly-randconfig-004-20241104    gcc-12
x86_64      buildonly-randconfig-005-20241104    gcc-12
x86_64      buildonly-randconfig-006-20241104    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241104    gcc-12
x86_64                randconfig-002-20241104    gcc-12
x86_64                randconfig-003-20241104    gcc-12
x86_64                randconfig-004-20241104    gcc-12
x86_64                randconfig-005-20241104    gcc-12
x86_64                randconfig-006-20241104    gcc-12
x86_64                randconfig-011-20241104    gcc-12
x86_64                randconfig-012-20241104    gcc-12
x86_64                randconfig-013-20241104    gcc-12
x86_64                randconfig-014-20241104    gcc-12
x86_64                randconfig-015-20241104    gcc-12
x86_64                randconfig-016-20241104    gcc-12
x86_64                randconfig-071-20241104    gcc-12
x86_64                randconfig-072-20241104    gcc-12
x86_64                randconfig-073-20241104    gcc-12
x86_64                randconfig-074-20241104    gcc-12
x86_64                randconfig-075-20241104    gcc-12
x86_64                randconfig-076-20241104    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241104    gcc-14.1.0
xtensa                randconfig-002-20241104    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

