Return-Path: <linux-pci+bounces-24520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3BA6DA50
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4E97A4BF3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65D25E462;
	Mon, 24 Mar 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQ+G8msU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9B25EF90
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820690; cv=none; b=L3swmOT9IcXMVpidv3qCBpx+5foAD9O1W4faGfVqegSmwNJ+oymk5iBFWR4Crhu622nOhMs3IqqJ/fv1B/OyMUyCT2XHDtM0UcF2nFFk/SdRZh2LQkS979QLCCd7j8wjgnr6IfBMuMh0iF7KzrBqAcZRj2HYDIXyZIx210mLuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820690; c=relaxed/simple;
	bh=Jr7SOY0m7qb2jqU2LjYtX8CCB/opIl+TRQvSOzUWmM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PaNYYMaTjWvr5jEIsdzpLiomOYK2PnpxjmZWdq0vLiuC9ZxiVK/DTdZe36ap6DnL5AuVvktpotZnAVRIY8ya0D6I4c7apcShKJCEEVMfjE1WTEal7+CYi/8DIlDWBGfKhTt+VdbmVrcq/dBwAeNLCqBfPkdpidvK4wNd9KKbg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQ+G8msU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742820688; x=1774356688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jr7SOY0m7qb2jqU2LjYtX8CCB/opIl+TRQvSOzUWmM4=;
  b=IQ+G8msUUdmD0hXDuWKyi6RWCSdld3MIwPmET4F/dJquGgieR9mFQOff
   2Zz9gZHKspQ9fOQtoiT5jaL7f4FhWRQ3VcOrLCTHyI64Avn8RxeI2SuLF
   Y/hlKZndFsv+aZYyzJKz8fQn5AMVUIq9XfBiUFfVLDwUhkpx7xcUHDafj
   /AHzP6BYzb0RuhT+YR4LiTPIfxNBS0s5wIrp2IwGOqmcnMoR48JytSAMk
   eNnJrqmVHrQW0Tw4WuIlud1qQuGpkvvbWsrf8AQ0qAMs/sF9NiZbB7MnN
   BDOSWrDqRgSc92liBKo/6Jb3UgJcWNk/9kJJaRW+GlK7TadOKSVGqfUJB
   Q==;
X-CSE-ConnectionGUID: WNIrUhuPRjKKVRJx6dVJBg==
X-CSE-MsgGUID: iiw6UE+2QgqNFk2mzjl0Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47896421"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="47896421"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:51:27 -0700
X-CSE-ConnectionGUID: jK6W9iDqTfKUAyyZgcqdCg==
X-CSE-MsgGUID: NQWU4lj6QMypvFzHijBpDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124560799"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 24 Mar 2025 05:51:26 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twhH1-0003ZI-1r;
	Mon, 24 Mar 2025 12:51:23 +0000
Date: Mon, 24 Mar 2025 20:50:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 d1e8487e25ffd7c6eb94160df01247de491d9136
Message-ID: <202503242042.FJLiHDga-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: d1e8487e25ffd7c6eb94160df01247de491d9136  dt-bindings: PCI: Add common schema for devices accessible through PCI BARs

elapsed time: 1446m

configs tested: 183
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250323    gcc-11.5.0
arc                   randconfig-002-20250323    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                   randconfig-001-20250323    gcc-7.5.0
arm                   randconfig-002-20250323    gcc-9.3.0
arm                   randconfig-003-20250323    clang-15
arm                   randconfig-004-20250323    gcc-5.5.0
arm                        realview_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250323    clang-21
arm64                 randconfig-002-20250323    gcc-5.5.0
arm64                 randconfig-003-20250323    gcc-9.5.0
arm64                 randconfig-004-20250323    gcc-7.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250323    gcc-13.3.0
csky                  randconfig-002-20250323    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250323    clang-21
hexagon               randconfig-002-20250323    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250323    clang-20
i386        buildonly-randconfig-002-20250323    gcc-12
i386        buildonly-randconfig-003-20250323    clang-20
i386        buildonly-randconfig-004-20250323    clang-20
i386        buildonly-randconfig-005-20250323    gcc-12
i386        buildonly-randconfig-006-20250323    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250324    gcc-12
i386                  randconfig-002-20250324    gcc-12
i386                  randconfig-003-20250324    gcc-12
i386                  randconfig-004-20250324    gcc-12
i386                  randconfig-005-20250324    gcc-12
i386                  randconfig-006-20250324    gcc-12
i386                  randconfig-007-20250324    gcc-12
i386                  randconfig-011-20250324    clang-20
i386                  randconfig-012-20250324    clang-20
i386                  randconfig-013-20250324    clang-20
i386                  randconfig-014-20250324    clang-20
i386                  randconfig-015-20250324    clang-20
i386                  randconfig-016-20250324    clang-20
i386                  randconfig-017-20250324    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250323    gcc-14.2.0
loongarch             randconfig-002-20250323    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-17
mips                           xway_defconfig    clang-21
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250323    gcc-13.3.0
nios2                 randconfig-002-20250323    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250323    gcc-10.5.0
parisc                randconfig-002-20250323    gcc-6.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-21
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250323    gcc-9.3.0
powerpc               randconfig-002-20250323    gcc-7.5.0
powerpc               randconfig-003-20250323    gcc-9.3.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250323    clang-16
powerpc64             randconfig-002-20250323    gcc-9.3.0
powerpc64             randconfig-003-20250323    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250323    gcc-9.3.0
riscv                 randconfig-002-20250323    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250323    gcc-8.5.0
s390                  randconfig-002-20250323    clang-15
s390                       zfcpdump_defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250323    gcc-5.5.0
sh                    randconfig-002-20250323    gcc-5.5.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250323    gcc-14.2.0
sparc                 randconfig-002-20250323    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250323    gcc-14.2.0
sparc64               randconfig-002-20250323    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250323    gcc-12
um                    randconfig-002-20250323    clang-17
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250323    clang-20
x86_64      buildonly-randconfig-002-20250323    clang-20
x86_64      buildonly-randconfig-003-20250323    gcc-12
x86_64      buildonly-randconfig-004-20250323    clang-20
x86_64      buildonly-randconfig-005-20250323    clang-20
x86_64      buildonly-randconfig-006-20250323    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250324    gcc-12
x86_64                randconfig-002-20250324    gcc-12
x86_64                randconfig-003-20250324    gcc-12
x86_64                randconfig-004-20250324    gcc-12
x86_64                randconfig-005-20250324    gcc-12
x86_64                randconfig-006-20250324    gcc-12
x86_64                randconfig-007-20250324    gcc-12
x86_64                randconfig-008-20250324    gcc-12
x86_64                randconfig-071-20250324    clang-20
x86_64                randconfig-072-20250324    clang-20
x86_64                randconfig-073-20250324    clang-20
x86_64                randconfig-074-20250324    clang-20
x86_64                randconfig-075-20250324    clang-20
x86_64                randconfig-076-20250324    clang-20
x86_64                randconfig-077-20250324    clang-20
x86_64                randconfig-078-20250324    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250323    gcc-14.2.0
xtensa                randconfig-002-20250323    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

