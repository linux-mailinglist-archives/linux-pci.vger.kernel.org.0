Return-Path: <linux-pci+bounces-19713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F47A1030C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 10:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D186A3A4475
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676622DC5F;
	Tue, 14 Jan 2025 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9JSo24t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773B22DC43
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847163; cv=none; b=UVHx9f4wtnxBp7KO8UYXYM1lr7l2QmnP4RsRBq2p5E5Z8nywN4mw5lKAp4Hm/frX6kulWiLUZblgtDPIg7PN+m0gBg63mOFSaT9dBwPIKgkXpE2NuhxXeTZ486iUfGRFRugA3DPCgS25vTyzBZ7SjT3H5dbK6Nh1m8yKebv5rkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847163; c=relaxed/simple;
	bh=vRRIS/C+iJGDTtNIIXvdzLIsr1fNm2/kUcDqcj1pk5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sMlBdSQqPvLQJx9uJkQsrNPqKCON+u6js74eo8ydmibwCQ0i9EezPSh/QxyXtL0KTS5mSlv+8fpiDiRJATJaAPMh2CybKQDKNEaPOoQENU7rncmTQnsBFQTxR3dO6h9vaPT6WiZqJZ84ZRwWqQaAlj1ajwPwIG35wInO+hrXFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9JSo24t; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736847161; x=1768383161;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vRRIS/C+iJGDTtNIIXvdzLIsr1fNm2/kUcDqcj1pk5M=;
  b=R9JSo24t6im2WQ4zRSTPlTGVsPUCdzEihnW8fhPKuQ9Rp38SMYaYt8rV
   /O5rL1hIXRO0qXVXCEr1VjSjWeK6+2PXvG5quRjEe73YDkAL5SkEKcVk8
   iScSYJ/pTP7LrBVmU5q8wRBrHAymbDjbwgblHRshDrrI8JSAAFLRm/V/c
   z/rju7Adtn6IE/aZ4l6SPAmm9DO6lxF/TJWl505TR5kXK/2XUyXNHTbqF
   MexWy+r8g1JB394qOdzfgGm5wxMnp1lX7smYroJARhnRvM/wpyfl2MlO1
   tFJhJTekab86EroWCQvbsrs5t/NylAcSrFxepur2+FmwM9TKrFTG+Ic7L
   Q==;
X-CSE-ConnectionGUID: p6n0jPCBQg+QmB8+TIKyng==
X-CSE-MsgGUID: er8Rf0okSmOL1BJTM5N75w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59619624"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="59619624"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 01:32:40 -0800
X-CSE-ConnectionGUID: nhCckC/rSw2RXGbqfa+Ziw==
X-CSE-MsgGUID: xZN50+a0TLmrglCyX1AlHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104512398"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Jan 2025 01:32:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXdHp-000OLH-1E;
	Tue, 14 Jan 2025 09:32:37 +0000
Date: Tue, 14 Jan 2025 17:32:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rcar-ep] BUILD SUCCESS
 2d2da5a4c1b4509f6f7e5a8db015cd420144beb4
Message-ID: <202501141717.KD1EDZP3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar-ep
branch HEAD: 2d2da5a4c1b4509f6f7e5a8db015cd420144beb4  PCI: rcar-ep: Fix incorrect variable used when calling devm_request_mem_region()

elapsed time: 1450m

configs tested: 142
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250113    gcc-13.2.0
arc                   randconfig-002-20250113    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                   randconfig-001-20250113    gcc-14.2.0
arm                   randconfig-002-20250113    gcc-14.2.0
arm                   randconfig-003-20250113    gcc-14.2.0
arm                   randconfig-004-20250113    clang-20
arm                        spear3xx_defconfig    clang-16
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250113    gcc-14.2.0
arm64                 randconfig-002-20250113    clang-18
arm64                 randconfig-003-20250113    clang-20
arm64                 randconfig-004-20250113    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250113    gcc-14.2.0
csky                  randconfig-002-20250113    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250113    clang-20
hexagon               randconfig-002-20250113    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250113    clang-19
i386        buildonly-randconfig-002-20250113    gcc-12
i386        buildonly-randconfig-003-20250113    clang-19
i386        buildonly-randconfig-004-20250113    clang-19
i386        buildonly-randconfig-005-20250113    clang-19
i386        buildonly-randconfig-006-20250113    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250114    clang-19
i386                  randconfig-002-20250114    clang-19
i386                  randconfig-003-20250114    clang-19
i386                  randconfig-004-20250114    clang-19
i386                  randconfig-005-20250114    clang-19
i386                  randconfig-006-20250114    clang-19
i386                  randconfig-007-20250114    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250113    gcc-14.2.0
loongarch             randconfig-002-20250113    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                           ip28_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250113    gcc-14.2.0
nios2                 randconfig-002-20250113    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250113    gcc-14.2.0
parisc                randconfig-002-20250113    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-17
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250113    clang-18
powerpc               randconfig-002-20250113    gcc-14.2.0
powerpc               randconfig-003-20250113    clang-20
powerpc                     redwood_defconfig    clang-20
powerpc64             randconfig-001-20250113    clang-20
powerpc64             randconfig-002-20250113    gcc-14.2.0
powerpc64             randconfig-003-20250113    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250113    gcc-14.2.0
riscv                 randconfig-002-20250113    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250113    gcc-14.2.0
s390                  randconfig-002-20250113    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250113    gcc-14.2.0
sh                    randconfig-002-20250113    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250113    gcc-14.2.0
sparc                 randconfig-002-20250113    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64               randconfig-001-20250113    gcc-14.2.0
sparc64               randconfig-002-20250113    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250113    gcc-12
um                    randconfig-002-20250113    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250113    gcc-12
x86_64      buildonly-randconfig-002-20250113    gcc-12
x86_64      buildonly-randconfig-003-20250113    gcc-12
x86_64      buildonly-randconfig-004-20250113    gcc-12
x86_64      buildonly-randconfig-005-20250113    clang-19
x86_64      buildonly-randconfig-006-20250113    clang-19
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250114    gcc-12
x86_64                randconfig-002-20250114    gcc-12
x86_64                randconfig-003-20250114    gcc-12
x86_64                randconfig-004-20250114    gcc-12
x86_64                randconfig-005-20250114    gcc-12
x86_64                randconfig-006-20250114    gcc-12
x86_64                randconfig-007-20250114    gcc-12
x86_64                randconfig-008-20250114    gcc-12
x86_64                randconfig-071-20250114    clang-19
x86_64                randconfig-072-20250114    clang-19
x86_64                randconfig-073-20250114    clang-19
x86_64                randconfig-074-20250114    clang-19
x86_64                randconfig-075-20250114    clang-19
x86_64                randconfig-076-20250114    clang-19
x86_64                randconfig-077-20250114    clang-19
x86_64                randconfig-078-20250114    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250113    gcc-14.2.0
xtensa                randconfig-002-20250113    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

