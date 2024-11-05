Return-Path: <linux-pci+bounces-16028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C09BC424
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 04:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC81B22182
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 03:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0518871D;
	Tue,  5 Nov 2024 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdUWau9Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB34CB47
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730778965; cv=none; b=fVOAb9lABvF7EpAvsKoMH6FjjusN5YJVKaWZ5YUP/mzWXmIWxncZ7GOvwQSuTQkbECx16K56fsMAVESvdJ/alhVvX3nbHcBAFZRYkhCMo0+x9tfwRa/kwFsRbb2yy84Kdr/cjI3W0ThtOZfe3mNU9PkCpg4u8Cxlk4ybpx/PwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730778965; c=relaxed/simple;
	bh=NnFk7YzDxJlViu8hQqQEjMcVWJqwI3uhrgcakOX5UG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=m8zuchJ8oWkRbSQ2E1QNmGdzo7duXOvpi6M4eH9bFHlJMHJ650Qrrx8t5cdAfO2o8Lylavr6R4ESk+nLaX6D5cOgRA7GZpWKu2IxiXHy8AljD4401dfkmmkwgrXZPTv2mOOhmBWjqAwXKnqefh3qaP7FnCMn6ua/d5LMCflVHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdUWau9Y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730778964; x=1762314964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NnFk7YzDxJlViu8hQqQEjMcVWJqwI3uhrgcakOX5UG8=;
  b=ZdUWau9YO7b6NibxmPXDoQWPEmV0hXYJ4juCbclk3Kr0mQ5wke/dNhQr
   vMGb92a+fUUdIDqQG3ZasTavHExO3WdS2ReYsPhaDs/rjtvRjckesskVf
   DwKG8Us5pwILBebZ25ROquvBvG9V8JcUxoX44E0wkzJsWdlVLfl7PuShR
   lly8rWWC4/n0fUQalpjdF0I3Poys+OyLnkxMc3dceIZjsDyE6GI+Hok7H
   eaYn85dEhG+qnGJBm4GdCS4/qPOz4Oznjtkj0EbkJsx3q/+Lii1unG3r0
   RvdEcFMyUrnXiLn+nVjSzdKuNE7XYqG/IiDp2fU63hGhoVKakKvghDGth
   Q==;
X-CSE-ConnectionGUID: OIcO/PfsRgG+vYzm4RwT4A==
X-CSE-MsgGUID: ipx1/R8qS/iixKajpBjDjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29933077"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="29933077"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:56:03 -0800
X-CSE-ConnectionGUID: UuWuYarbSiyPu2WKnnz2DA==
X-CSE-MsgGUID: DBUkPOjhRt264c8Sgp98Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83971640"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Nov 2024 19:56:02 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Aff-000la9-2r;
	Tue, 05 Nov 2024 03:55:59 +0000
Date: Tue, 05 Nov 2024 11:55:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/j721e] BUILD SUCCESS
 22a9120479a40a56c13c5e473a0100fad2e017c0
Message-ID: <202411051100.UdOjPePd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/j721e
branch HEAD: 22a9120479a40a56c13c5e473a0100fad2e017c0  PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS milliseconds

elapsed time: 871m

configs tested: 232
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20241105    gcc-14.1.0
arc                   randconfig-002-20241105    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                        clps711x_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                           imxrt_defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                        keystone_defconfig    gcc-14.1.0
arm                   randconfig-001-20241105    gcc-14.1.0
arm                   randconfig-002-20241105    gcc-14.1.0
arm                   randconfig-003-20241105    gcc-14.1.0
arm                   randconfig-004-20241105    gcc-14.1.0
arm                        shmobile_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241105    gcc-14.1.0
arm64                 randconfig-002-20241105    gcc-14.1.0
arm64                 randconfig-003-20241105    gcc-14.1.0
arm64                 randconfig-004-20241105    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241105    gcc-14.1.0
csky                  randconfig-002-20241105    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241105    gcc-14.1.0
hexagon               randconfig-002-20241105    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241105    clang-19
i386        buildonly-randconfig-002-20241105    clang-19
i386        buildonly-randconfig-003-20241105    clang-19
i386        buildonly-randconfig-004-20241105    clang-19
i386        buildonly-randconfig-005-20241105    clang-19
i386        buildonly-randconfig-006-20241105    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241105    clang-19
i386                  randconfig-002-20241105    clang-19
i386                  randconfig-003-20241105    clang-19
i386                  randconfig-004-20241105    clang-19
i386                  randconfig-005-20241105    clang-19
i386                  randconfig-006-20241105    clang-19
i386                  randconfig-011-20241105    clang-19
i386                  randconfig-012-20241105    clang-19
i386                  randconfig-013-20241105    clang-19
i386                  randconfig-014-20241105    clang-19
i386                  randconfig-015-20241105    clang-19
i386                  randconfig-016-20241105    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241105    gcc-14.1.0
loongarch             randconfig-002-20241105    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    gcc-14.1.0
mips                         bigsur_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                       rbtx49xx_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241105    gcc-14.1.0
nios2                 randconfig-002-20241105    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241105    gcc-14.1.0
parisc                randconfig-002-20241105    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc834x_itx_defconfig    gcc-14.1.0
powerpc                     ppa8548_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241105    gcc-14.1.0
powerpc               randconfig-002-20241105    gcc-14.1.0
powerpc               randconfig-003-20241105    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
powerpc                     taishan_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241105    gcc-14.1.0
powerpc64             randconfig-002-20241105    gcc-14.1.0
powerpc64             randconfig-003-20241105    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241105    gcc-14.1.0
riscv                 randconfig-002-20241105    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241105    gcc-14.1.0
s390                  randconfig-002-20241105    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         ap325rxa_defconfig    gcc-14.1.0
sh                         apsh4a3a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                             espt_defconfig    gcc-14.1.0
sh                          lboxre2_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-14.1.0
sh                          r7780mp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241105    gcc-14.1.0
sh                    randconfig-002-20241105    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                          sdk7786_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7722_defconfig    gcc-14.1.0
sh                           se7724_defconfig    gcc-14.1.0
sh                   secureedge5410_defconfig    gcc-14.1.0
sh                           sh2007_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241105    gcc-14.1.0
sparc64               randconfig-002-20241105    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241105    gcc-14.1.0
um                    randconfig-002-20241105    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241104    gcc-12
x86_64      buildonly-randconfig-001-20241105    gcc-12
x86_64      buildonly-randconfig-002-20241104    gcc-12
x86_64      buildonly-randconfig-002-20241105    gcc-12
x86_64      buildonly-randconfig-003-20241104    gcc-12
x86_64      buildonly-randconfig-003-20241105    gcc-12
x86_64      buildonly-randconfig-004-20241104    gcc-12
x86_64      buildonly-randconfig-004-20241105    gcc-12
x86_64      buildonly-randconfig-005-20241104    gcc-12
x86_64      buildonly-randconfig-005-20241105    gcc-12
x86_64      buildonly-randconfig-006-20241104    gcc-12
x86_64      buildonly-randconfig-006-20241105    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241104    gcc-12
x86_64                randconfig-001-20241105    gcc-12
x86_64                randconfig-002-20241104    gcc-12
x86_64                randconfig-002-20241105    gcc-12
x86_64                randconfig-003-20241104    gcc-12
x86_64                randconfig-003-20241105    gcc-12
x86_64                randconfig-004-20241104    gcc-12
x86_64                randconfig-004-20241105    gcc-12
x86_64                randconfig-005-20241104    gcc-12
x86_64                randconfig-005-20241105    gcc-12
x86_64                randconfig-006-20241104    gcc-12
x86_64                randconfig-006-20241105    gcc-12
x86_64                randconfig-011-20241104    gcc-12
x86_64                randconfig-011-20241105    gcc-12
x86_64                randconfig-012-20241104    gcc-12
x86_64                randconfig-012-20241105    gcc-12
x86_64                randconfig-013-20241104    gcc-12
x86_64                randconfig-013-20241105    gcc-12
x86_64                randconfig-014-20241104    gcc-12
x86_64                randconfig-014-20241105    gcc-12
x86_64                randconfig-015-20241104    gcc-12
x86_64                randconfig-015-20241105    gcc-12
x86_64                randconfig-016-20241104    gcc-12
x86_64                randconfig-016-20241105    gcc-12
x86_64                randconfig-071-20241104    gcc-12
x86_64                randconfig-071-20241105    gcc-12
x86_64                randconfig-072-20241104    gcc-12
x86_64                randconfig-072-20241105    gcc-12
x86_64                randconfig-073-20241104    gcc-12
x86_64                randconfig-073-20241105    gcc-12
x86_64                randconfig-074-20241104    gcc-12
x86_64                randconfig-074-20241105    gcc-12
x86_64                randconfig-075-20241104    gcc-12
x86_64                randconfig-075-20241105    gcc-12
x86_64                randconfig-076-20241104    gcc-12
x86_64                randconfig-076-20241105    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241105    gcc-14.1.0
xtensa                randconfig-002-20241105    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

