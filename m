Return-Path: <linux-pci+bounces-23250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871DCA585B1
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 17:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC8A18896F1
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A8186A;
	Sun,  9 Mar 2025 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZhRZOeM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F33184F
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536224; cv=none; b=WUkvZLe+8l1G34ZDz7+EiET4mMnW1t4IyhV1BSb7RfM6i2prV6olCAV3ORkp+s/KGU4vuFn9bOQy7dXFc0iSZaA0dT641wyMmoK0Lks0RdkSGWzZl3diRy5NmlDwSTccGgZXTZ2P8QiZzN4Se5evPRED7JfFEkBF1/63/IL2XqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536224; c=relaxed/simple;
	bh=OInv6E2LcNy2ZNQS1vzxlJqu2I22GSfnMUbtQwpkDRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JJ6T4tlgSn2st1n2ZpVLiJP33IzMJ5bvnmmECc7h0iQ4RD5uaJF3hJ9u4JXh2fLkYfB4B6A5eTIVFoS7l/sWJzp5M1NKNBFcEQ5Pb4fKgYC6F/UZ/nCzz1vilYAl9pyI7Z/DBLITyAF2PjrxESzYdeXB5wAeK1dvkyF62KQbL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZhRZOeM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741536222; x=1773072222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OInv6E2LcNy2ZNQS1vzxlJqu2I22GSfnMUbtQwpkDRg=;
  b=iZhRZOeMqfhAjKwm2PV3RS6EicTd7mBljosu1s/1j54eaPs27AM1vIlY
   Pz4EQNVAMqrG3eXZYzU4XJeRByateybnFBG6TaXddlAfEpVKiSNkagYLR
   OHPVStkX4E4MgGPL4b1dMTuaJYsNXgC69O/Fj6AuffvyAh2Nu2CbJffgJ
   FfDwRiM/9UCC164w1zppkWAUXVs6rb2anbmtJOGLzfgODtuvBrq/7dCAH
   ooN67youQd3ZcESei7/UABkdgPxTLd/+bvjdVULWh5QuL3EJlv781mAZI
   tzNLrkAKPHQMrfZx/7MwDQUyl1dwTn9eQwRrbfpVBsyppiau6YUriL1Sv
   g==;
X-CSE-ConnectionGUID: UPl2dxZ6S724xPliRCR3cQ==
X-CSE-MsgGUID: 67NnLxXWQT629usCVFnD8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42725242"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42725242"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 09:03:42 -0700
X-CSE-ConnectionGUID: 5TDxNaE7QUu5Ud/a+za9EQ==
X-CSE-MsgGUID: 8pDJODIERlC0PhyoF7UomQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="125028507"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 09 Mar 2025 09:03:41 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trJ7q-0003Fs-1W;
	Sun, 09 Mar 2025 16:03:38 +0000
Date: Mon, 10 Mar 2025 00:02:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 41df330ca403d172da03f75c7ac1629af8eca8e0
Message-ID: <202503100034.GZb7Zx0n-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 41df330ca403d172da03f75c7ac1629af8eca8e0  dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop unnecessary status from example

elapsed time: 1441m

configs tested: 118
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250309    gcc-13.2.0
arc                   randconfig-002-20250309    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-17
arm                          gemini_defconfig    clang-21
arm                   randconfig-001-20250309    clang-21
arm                   randconfig-002-20250309    gcc-14.2.0
arm                   randconfig-003-20250309    clang-21
arm                   randconfig-004-20250309    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250309    clang-15
arm64                 randconfig-002-20250309    clang-17
arm64                 randconfig-003-20250309    clang-15
arm64                 randconfig-004-20250309    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250309    gcc-14.2.0
csky                  randconfig-002-20250309    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250309    clang-21
hexagon               randconfig-002-20250309    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250309    clang-19
i386        buildonly-randconfig-002-20250309    clang-19
i386        buildonly-randconfig-003-20250309    gcc-11
i386        buildonly-randconfig-004-20250309    gcc-12
i386        buildonly-randconfig-005-20250309    clang-19
i386        buildonly-randconfig-006-20250309    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250309    gcc-14.2.0
loongarch             randconfig-002-20250309    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250309    gcc-14.2.0
nios2                 randconfig-002-20250309    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250309    gcc-14.2.0
parisc                randconfig-002-20250309    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250309    gcc-14.2.0
powerpc               randconfig-002-20250309    clang-21
powerpc               randconfig-003-20250309    clang-21
powerpc64             randconfig-001-20250309    clang-15
powerpc64             randconfig-002-20250309    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250309    clang-15
riscv                 randconfig-002-20250309    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250309    clang-16
s390                  randconfig-002-20250309    gcc-14.2.0
s390                       zfcpdump_defconfig    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250309    gcc-14.2.0
sh                    randconfig-002-20250309    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250309    gcc-14.2.0
sparc                 randconfig-002-20250309    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250309    gcc-14.2.0
sparc64               randconfig-002-20250309    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250309    clang-21
um                    randconfig-002-20250309    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250309    gcc-12
x86_64      buildonly-randconfig-002-20250309    gcc-11
x86_64      buildonly-randconfig-003-20250309    gcc-12
x86_64      buildonly-randconfig-004-20250309    gcc-12
x86_64      buildonly-randconfig-005-20250309    clang-19
x86_64      buildonly-randconfig-006-20250309    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250309    gcc-14.2.0
xtensa                randconfig-002-20250309    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

