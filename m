Return-Path: <linux-pci+bounces-12562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80A9675A3
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 11:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8531C20A39
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E413B2B8;
	Sun,  1 Sep 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Swbo+4+4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2715219F6
	for <linux-pci@vger.kernel.org>; Sun,  1 Sep 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725181243; cv=none; b=nNLGMwzP8ladJxPcqLlWxOK/BnJ36Oyq9qJguIApSgu+FjrrMJYE6CVCbvT+umQ/b+AAtLfXgLKgQZUeS6HPfvJstWRS3iO+ZRSBvTCXBCnvfZsEODNpHZq37Qm+UM6IgjBi84TGvZEJ0VNc+rZpUn/CCMmCsGsAR9k0fQ3kaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725181243; c=relaxed/simple;
	bh=/NRAkdWYpJuQdyR0L85ODKHRzXyOyLdhRthwLMBy2ms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Oz940FDgZb7OgXmAewSNBcO48PW4+ZjFyHSWm4hO4h8HHQVJ10RO5T9ZY67BmdyLjJf+gUnmGAIXHDlqvNMKhCuELC+XlH6OaaP+Xo3N/dklsVOCOq8rbqHrQFghWT+fjVchmEmAR1/YCA/uAq8h3HIb3CdUtfTLTXYOiAbkcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Swbo+4+4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725181241; x=1756717241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/NRAkdWYpJuQdyR0L85ODKHRzXyOyLdhRthwLMBy2ms=;
  b=Swbo+4+4diahatHIJRO3aEjuTwcDIzUVFytDqzmcFcB6i28PPxL3qqMP
   p8Sur/v/auo+ZkpUD0KKDSds0f1kN2H4i+H+EHwloFarnYIKOoqLPvHAp
   F4z/YN+pHQileqG5W3s8XiRTEG3921owTdtlp9+NcGrEut+ncSC4eT6tt
   Ywmsxo/U/rUAHnMyhCgdP/UoTChXrymR+aPLOPZ9EjU94K4lKMaAuY/Cz
   DfY9dMbyeXteirFr1GedxZHjGb2nr6BSchJG/rTB5lhwu0A2B32suA90p
   AuyXJ1Q4r84qiipPNkazeBytCC0G8+S2tCNRBTeEVdnDAoLC194LRQVLD
   Q==;
X-CSE-ConnectionGUID: wrYE0oqKSxKCp7Zxedh3TQ==
X-CSE-MsgGUID: 5rx522leQoeD0YArFkMHmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="46280168"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="46280168"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 02:00:41 -0700
X-CSE-ConnectionGUID: c93Ve0OVQ265Br85pu1McQ==
X-CSE-MsgGUID: F1FAEHGJTkKOfAi3Ecf65Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="63922968"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Sep 2024 02:00:39 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skgRp-0003Yc-0r;
	Sun, 01 Sep 2024 09:00:37 +0000
Date: Sun, 01 Sep 2024 16:59:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 1ae791a877e79f93a51743e998020d8833c54b2a
Message-ID: <202409011657.2E7w2D3Y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 1ae791a877e79f93a51743e998020d8833c54b2a  PCI: brcmstb: Enable 7712 SOCs

elapsed time: 809m

configs tested: 200
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              alldefconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                     haps_hs_smp_defconfig   gcc-14.1.0
arc                   randconfig-001-20240901   clang-20
arc                   randconfig-002-20240901   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g5_defconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          exynos_defconfig   clang-20
arm                       multi_v4t_defconfig   gcc-14.1.0
arm                        multi_v5_defconfig   gcc-14.1.0
arm                             mxs_defconfig   clang-20
arm                        neponset_defconfig   gcc-14.1.0
arm                         nhk8815_defconfig   clang-20
arm                       omap2plus_defconfig   gcc-14.1.0
arm                          pxa3xx_defconfig   clang-20
arm                   randconfig-001-20240901   clang-20
arm                   randconfig-002-20240901   clang-20
arm                   randconfig-003-20240901   clang-20
arm                   randconfig-004-20240901   clang-20
arm                        spear6xx_defconfig   gcc-14.1.0
arm64                            alldefconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240901   clang-20
arm64                 randconfig-002-20240901   clang-20
arm64                 randconfig-003-20240901   clang-20
arm64                 randconfig-004-20240901   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240901   clang-20
csky                  randconfig-002-20240901   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240901   clang-20
hexagon               randconfig-002-20240901   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240901   clang-18
i386         buildonly-randconfig-002-20240901   clang-18
i386         buildonly-randconfig-003-20240901   clang-18
i386         buildonly-randconfig-004-20240901   clang-18
i386         buildonly-randconfig-005-20240901   clang-18
i386         buildonly-randconfig-006-20240901   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240901   clang-18
i386                  randconfig-002-20240901   clang-18
i386                  randconfig-003-20240901   clang-18
i386                  randconfig-004-20240901   clang-18
i386                  randconfig-005-20240901   clang-18
i386                  randconfig-006-20240901   clang-18
i386                  randconfig-011-20240901   clang-18
i386                  randconfig-012-20240901   clang-18
i386                  randconfig-013-20240901   clang-18
i386                  randconfig-014-20240901   clang-18
i386                  randconfig-015-20240901   clang-18
i386                  randconfig-016-20240901   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240901   clang-20
loongarch             randconfig-002-20240901   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          hp300_defconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                      bmips_stb_defconfig   clang-20
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                           ci20_defconfig   clang-20
mips                          eyeq5_defconfig   clang-20
mips                           gcw0_defconfig   clang-20
mips                           ip28_defconfig   clang-20
nios2                         10m50_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240901   clang-20
nios2                 randconfig-002-20240901   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240901   clang-20
parisc                randconfig-002-20240901   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                       eiger_defconfig   clang-20
powerpc                        fsp2_defconfig   clang-20
powerpc                       holly_defconfig   gcc-14.1.0
powerpc                     mpc512x_defconfig   clang-20
powerpc                     mpc512x_defconfig   gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig   clang-20
powerpc               randconfig-001-20240901   clang-20
powerpc               randconfig-002-20240901   clang-20
powerpc                     sequoia_defconfig   clang-20
powerpc                     skiroot_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
powerpc                         wii_defconfig   clang-20
powerpc64             randconfig-001-20240901   clang-20
powerpc64             randconfig-002-20240901   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240901   clang-20
riscv                 randconfig-002-20240901   clang-20
s390                             alldefconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240901   clang-20
s390                  randconfig-002-20240901   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                         ecovec24_defconfig   clang-20
sh                               j2_defconfig   clang-20
sh                          kfr2r09_defconfig   clang-20
sh                    randconfig-001-20240901   clang-20
sh                    randconfig-002-20240901   clang-20
sh                  sh7785lcr_32bit_defconfig   gcc-14.1.0
sh                             shx3_defconfig   clang-20
sh                              ul2_defconfig   gcc-14.1.0
sh                          urquell_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240901   clang-20
sparc64               randconfig-002-20240901   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240901   clang-20
um                    randconfig-002-20240901   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240901   gcc-12
x86_64       buildonly-randconfig-002-20240901   gcc-12
x86_64       buildonly-randconfig-003-20240901   gcc-12
x86_64       buildonly-randconfig-004-20240901   gcc-12
x86_64       buildonly-randconfig-005-20240901   gcc-12
x86_64       buildonly-randconfig-006-20240901   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240901   gcc-12
x86_64                randconfig-002-20240901   gcc-12
x86_64                randconfig-003-20240901   gcc-12
x86_64                randconfig-004-20240901   gcc-12
x86_64                randconfig-005-20240901   gcc-12
x86_64                randconfig-006-20240901   gcc-12
x86_64                randconfig-011-20240901   gcc-12
x86_64                randconfig-012-20240901   gcc-12
x86_64                randconfig-013-20240901   gcc-12
x86_64                randconfig-014-20240901   gcc-12
x86_64                randconfig-015-20240901   gcc-12
x86_64                randconfig-016-20240901   gcc-12
x86_64                randconfig-071-20240901   gcc-12
x86_64                randconfig-072-20240901   gcc-12
x86_64                randconfig-073-20240901   gcc-12
x86_64                randconfig-074-20240901   gcc-12
x86_64                randconfig-075-20240901   gcc-12
x86_64                randconfig-076-20240901   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                          iss_defconfig   clang-20
xtensa                randconfig-001-20240901   clang-20
xtensa                randconfig-002-20240901   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

