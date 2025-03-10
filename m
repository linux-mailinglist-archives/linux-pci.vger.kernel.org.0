Return-Path: <linux-pci+bounces-23335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F16A59B2C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7976C3A3988
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD6230269;
	Mon, 10 Mar 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KT08w8Rl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3822DFAE
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624689; cv=none; b=iJQ1mVcnm4qhBfqBuWp3OzE4VUHrWCeZ1qNb+Ghkg+GARPtwXIa9oRilRsMZIu+CqK5DhC/YVoxzDZmbrGS5LGsFVC73FDzRHbRxmPWyFJLdM3jyA690bAkhB8u8NnCDWMH2LPAOjOA98ZacSVfPiOnXzC8l7PZiP1hJXSBNeLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624689; c=relaxed/simple;
	bh=Kwpxo5cHLaTMuCQWcF5582EcYr4iZsiZy9ylLG8Z/Po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GfhiZlPgcsaP8CP0vPguDu/QXVwn7QXUirSfo05oFJZ+YS+XcNdHFNB7BkLOHuuBnkvg8ZQuDlfkcxxyP6GYfvStwoooFSi10mM9x0xiDHgv6ASh5uPwmdfqcqikeQQKid9wylfnykEa6QwAlDTgHwTbclQr0bFMJ1o5KNEoB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KT08w8Rl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741624687; x=1773160687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kwpxo5cHLaTMuCQWcF5582EcYr4iZsiZy9ylLG8Z/Po=;
  b=KT08w8RlV1smHvKF6w+0/qfmLb0TcEsO+V8XIVefNLWCOfQLOFqhHib/
   H5WP7R9PbBNhej/bqv2HkshnkJyQuEU8aCCDFa8cyvaE9VyhvzPZc3UtD
   ozwZFvk+mBh5YphGeC4PoOMCPVpokzlZ7MzOqyL7axkWn8X0bpkU2XfbM
   b/seehOROMR7VKb76U67FOCCg7N6CVirAk9nA2CdQKBb9FD1cKmltNFuF
   88VVdDWHTnpGPXGR9JDYkOzcWE05v+/lUPgn4lYHZXiVx2/bHvDeowNjj
   fP5g3EMZGv5ZzSUjB4LtmS1iacfQJGGsEcm0FV8Nt8zN068BEmM2qcTFf
   w==;
X-CSE-ConnectionGUID: /BDdgAqPTXmzc3lR5d0V+w==
X-CSE-MsgGUID: 92kxRHDWScK/s3qmmdVJ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="60177594"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="60177594"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:38:06 -0700
X-CSE-ConnectionGUID: nqeCH5dpQ/ydwQ7RG6Ol6w==
X-CSE-MsgGUID: tIxDd6CBQg6DAnX2vI9TbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="157252707"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2025 09:38:05 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trg8c-0004TO-2P;
	Mon, 10 Mar 2025 16:38:00 +0000
Date: Tue, 11 Mar 2025 00:37:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx-cpm] BUILD SUCCESS
 3f62f32802756b148cf4bc04b573079513f4af60
Message-ID: <202503110031.PP9pxKtY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx-cpm
branch HEAD: 3f62f32802756b148cf4bc04b573079513f4af60  PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller

elapsed time: 1400m

configs tested: 205
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250310    gcc-13.2.0
arc                   randconfig-002-20250310    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-17
arm                                 defconfig    clang-21
arm                          moxart_defconfig    clang-21
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250310    clang-21
arm                   randconfig-002-20250310    gcc-14.2.0
arm                   randconfig-003-20250310    gcc-14.2.0
arm                   randconfig-004-20250310    clang-21
arm                        realview_defconfig    clang-19
arm                          sp7021_defconfig    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250310    clang-19
arm64                 randconfig-002-20250310    clang-17
arm64                 randconfig-003-20250310    clang-15
arm64                 randconfig-004-20250310    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250310    gcc-14.2.0
csky                  randconfig-002-20250310    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250310    clang-21
hexagon               randconfig-001-20250310    gcc-14.2.0
hexagon               randconfig-002-20250310    clang-21
hexagon               randconfig-002-20250310    gcc-14.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250310    clang-19
i386        buildonly-randconfig-002-20250310    clang-19
i386        buildonly-randconfig-003-20250310    clang-19
i386        buildonly-randconfig-004-20250310    clang-19
i386        buildonly-randconfig-005-20250310    clang-19
i386        buildonly-randconfig-006-20250310    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250310    clang-19
i386                  randconfig-002-20250310    clang-19
i386                  randconfig-003-20250310    clang-19
i386                  randconfig-004-20250310    clang-19
i386                  randconfig-005-20250310    clang-19
i386                  randconfig-006-20250310    clang-19
i386                  randconfig-007-20250310    clang-19
i386                  randconfig-011-20250310    clang-19
i386                  randconfig-012-20250310    clang-19
i386                  randconfig-013-20250310    clang-19
i386                  randconfig-014-20250310    clang-19
i386                  randconfig-015-20250310    clang-19
i386                  randconfig-016-20250310    clang-19
i386                  randconfig-017-20250310    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250310    gcc-14.2.0
loongarch             randconfig-002-20250310    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-21
mips                         bigsur_defconfig    clang-21
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250310    gcc-14.2.0
nios2                 randconfig-002-20250310    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250310    gcc-14.2.0
parisc                randconfig-002-20250310    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-17
powerpc               randconfig-001-20250310    clang-17
powerpc               randconfig-001-20250310    gcc-14.2.0
powerpc               randconfig-002-20250310    clang-21
powerpc               randconfig-002-20250310    gcc-14.2.0
powerpc               randconfig-003-20250310    clang-17
powerpc               randconfig-003-20250310    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250310    gcc-14.2.0
powerpc64             randconfig-002-20250310    gcc-14.2.0
powerpc64             randconfig-003-20250310    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250310    clang-19
riscv                 randconfig-002-20250310    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250310    gcc-14.2.0
s390                  randconfig-002-20250310    clang-18
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250310    gcc-14.2.0
sh                    randconfig-002-20250310    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250310    gcc-14.2.0
sparc                 randconfig-002-20250310    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250310    gcc-14.2.0
sparc64               randconfig-002-20250310    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250310    gcc-12
um                    randconfig-002-20250310    clang-17
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250310    gcc-12
x86_64      buildonly-randconfig-002-20250310    clang-19
x86_64      buildonly-randconfig-003-20250310    clang-19
x86_64      buildonly-randconfig-004-20250310    clang-19
x86_64      buildonly-randconfig-005-20250310    clang-19
x86_64      buildonly-randconfig-006-20250310    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250310    gcc-12
x86_64                randconfig-002-20250310    gcc-12
x86_64                randconfig-003-20250310    gcc-12
x86_64                randconfig-004-20250310    gcc-12
x86_64                randconfig-005-20250310    gcc-12
x86_64                randconfig-006-20250310    gcc-12
x86_64                randconfig-007-20250310    gcc-12
x86_64                randconfig-008-20250310    gcc-12
x86_64                randconfig-071-20250310    clang-19
x86_64                randconfig-072-20250310    clang-19
x86_64                randconfig-073-20250310    clang-19
x86_64                randconfig-074-20250310    clang-19
x86_64                randconfig-075-20250310    clang-19
x86_64                randconfig-076-20250310    clang-19
x86_64                randconfig-077-20250310    clang-19
x86_64                randconfig-078-20250310    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250310    gcc-14.2.0
xtensa                randconfig-002-20250310    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

