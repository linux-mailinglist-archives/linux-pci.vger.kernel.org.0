Return-Path: <linux-pci+bounces-20500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23AAA212F4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 21:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DCA165B81
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD513632B;
	Tue, 28 Jan 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNw4ofqS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7D1E1A3D
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738095389; cv=none; b=US96SPbkXHHVYdYlEFpv4B3tDdDQR5FKePW6u0G87FLoA920Lge1z4uJ7x3HMn6awVGc284aOZx9l+bsl82bJ7LxA0MqXVlgpxI63capGailo2t5A2twTLhjdgJ5Y6C8ckNhZEMUi6G+UnaQx4HuPVb1s33eEiLgU1TH8pLbHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738095389; c=relaxed/simple;
	bh=01m2CjRHIoC03u7v/m+vLCCsafU/VmIRWL4uuFu49h8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DD6bAFOwUQhUIDXadTpKVM+OWCxm83vgSEgGjKnCSM9T0xDRm6Ue3sjmes/KrFf+4nF0ME2X6q3AT1v6I5iz7P9ftOU+uSMKJJnumayS1FqAHuz4dOLoVQVZ3dg9MyVsbPGKg6eh8cLf9AgR971D13n6TO6Xvls/yWheG349fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNw4ofqS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738095387; x=1769631387;
  h=date:from:to:cc:subject:message-id;
  bh=01m2CjRHIoC03u7v/m+vLCCsafU/VmIRWL4uuFu49h8=;
  b=CNw4ofqS4NEqIkY1PR6heLZUDz23YucDJX975+2UlByvsMBX2lpxpuXn
   3FzF4VnDwDYdA+7nB9nRwefuAnoHVsQ00FxvJXqKcCuBqxzWDPXzklp1L
   8Rj6savmmy1ZbR2uNFueMItzhnZAH0P+4bUM/1j1c4r7jzE9hiiSSk+CJ
   mC4ydUrcgHpy3ZrDNyQJCLAMd8r9FHZPeReDZOs2kQVoD3p3MZYJrEOAT
   W+rS/o5gqleIo1AIdJkUJtyq6UNG2NnLCEIR8Ue1AL8RsOWPJxzn9d9gm
   B/bwoG8qLXslfzTkSrvSycMOdWaBajL6pctwjBkG1Ymno6adDwK9kA5R6
   Q==;
X-CSE-ConnectionGUID: DPsom9xJRR2dH+tx4DIS1A==
X-CSE-MsgGUID: feyOqIV8RCm4wtrhQjqkQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38479183"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="38479183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 12:16:26 -0800
X-CSE-ConnectionGUID: KQDAa2EkSeKjL6XjauPCZw==
X-CSE-MsgGUID: 4WH4DLI2QDi5WCyW8NjMDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="108641032"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jan 2025 12:16:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tcs0V-000iAl-0X;
	Tue, 28 Jan 2025 20:16:23 +0000
Date: Wed, 29 Jan 2025 04:15:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 d555ed45a5a10a813528c7685f432369d536ae3d
Message-ID: <202501290448.G0dg7ZX0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: d555ed45a5a10a813528c7685f432369d536ae3d  PCI: Restore original INTX_DISABLE bit by pcim_intx()

elapsed time: 1448m

configs tested: 196
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    clang-18
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250128    gcc-13.2.0
arc                   randconfig-002-20250128    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                      jornada720_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20250128    gcc-14.2.0
arm                   randconfig-002-20250128    clang-20
arm                   randconfig-003-20250128    clang-20
arm                   randconfig-004-20250128    clang-15
arm                           sunxi_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250128    gcc-14.2.0
arm64                 randconfig-002-20250128    clang-17
arm64                 randconfig-003-20250128    gcc-14.2.0
arm64                 randconfig-004-20250128    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250128    gcc-14.2.0
csky                  randconfig-002-20250128    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20250128    clang-20
hexagon               randconfig-002-20250128    clang-14
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250128    clang-19
i386        buildonly-randconfig-002-20250128    clang-19
i386        buildonly-randconfig-003-20250128    gcc-12
i386        buildonly-randconfig-004-20250128    clang-19
i386        buildonly-randconfig-005-20250128    clang-19
i386        buildonly-randconfig-006-20250128    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250129    gcc-12
i386                  randconfig-002-20250129    gcc-12
i386                  randconfig-003-20250129    gcc-12
i386                  randconfig-004-20250129    gcc-12
i386                  randconfig-005-20250129    gcc-12
i386                  randconfig-006-20250129    gcc-12
i386                  randconfig-007-20250129    gcc-12
i386                  randconfig-011-20250128    clang-19
i386                  randconfig-012-20250128    clang-19
i386                  randconfig-013-20250128    clang-19
i386                  randconfig-014-20250128    clang-19
i386                  randconfig-015-20250128    clang-19
i386                  randconfig-016-20250128    clang-19
i386                  randconfig-017-20250128    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250128    gcc-14.2.0
loongarch             randconfig-002-20250128    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250128    gcc-14.2.0
nios2                 randconfig-002-20250128    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250128    gcc-14.2.0
parisc                randconfig-002-20250128    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ep8248e_defconfig    clang-18
powerpc                    gamecube_defconfig    clang-16
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-18
powerpc               randconfig-001-20250128    clang-17
powerpc               randconfig-002-20250128    gcc-14.2.0
powerpc               randconfig-003-20250128    clang-20
powerpc                     redwood_defconfig    clang-20
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    clang-18
powerpc64             randconfig-001-20250128    clang-15
powerpc64             randconfig-002-20250128    gcc-14.2.0
powerpc64             randconfig-003-20250128    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250128    gcc-14.2.0
riscv                 randconfig-002-20250128    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250128    gcc-14.2.0
s390                  randconfig-002-20250128    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20250128    gcc-14.2.0
sh                    randconfig-002-20250128    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250128    gcc-14.2.0
sparc                 randconfig-002-20250128    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250128    gcc-14.2.0
sparc64               randconfig-002-20250128    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250128    gcc-12
um                    randconfig-002-20250128    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    clang-18
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250128    clang-19
x86_64      buildonly-randconfig-002-20250128    clang-19
x86_64      buildonly-randconfig-003-20250128    gcc-12
x86_64      buildonly-randconfig-004-20250128    clang-19
x86_64      buildonly-randconfig-005-20250128    clang-19
x86_64      buildonly-randconfig-006-20250128    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250128    gcc-12
x86_64                randconfig-002-20250128    gcc-12
x86_64                randconfig-003-20250128    gcc-12
x86_64                randconfig-004-20250128    gcc-12
x86_64                randconfig-005-20250128    gcc-12
x86_64                randconfig-006-20250128    gcc-12
x86_64                randconfig-007-20250128    gcc-12
x86_64                randconfig-008-20250128    gcc-12
x86_64                randconfig-071-20250128    gcc-12
x86_64                randconfig-072-20250128    gcc-12
x86_64                randconfig-073-20250128    gcc-12
x86_64                randconfig-074-20250128    gcc-12
x86_64                randconfig-075-20250128    gcc-12
x86_64                randconfig-076-20250128    gcc-12
x86_64                randconfig-077-20250128    gcc-12
x86_64                randconfig-078-20250128    gcc-12
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250128    gcc-14.2.0
xtensa                randconfig-002-20250128    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

