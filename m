Return-Path: <linux-pci+bounces-7412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9B28C3B55
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 08:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8157F1C20FDA
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 06:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC914658B;
	Mon, 13 May 2024 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxWBEtFo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BC1465A5
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581804; cv=none; b=UthzKnXl+5fb/ub0VoyIsGm7ar+iiEAAZZLo5b/VRhIA71jJtri7ks9prTxzqGT8Pba3a1oF+3WHSQjjewmmJgaX3F4WQW/KISTtMzKxNu5mYukivjYxagbrw0TsmLo573xZZws4bv+ni6aT907ZFrrhoJwycfJj8IhFB/+XFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581804; c=relaxed/simple;
	bh=7mYeRH6vUgm9MbbFusd0OvPWzb7Hs8e22qZZ0BmaDHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZeML56Zc9pYM4g1DDFgaLFFYAma21n0WdlKRxy04znPFrTFTNuSvK4HS2ttLlXnfmqVCOyKUIAtQXjumayx4XU8IQz3SvCRU5KOzlbKt3gZji4lL61+lwsWa2HEmOHdZIrIIx0FWup9NkcKTabgbmPX4MzrFV4Vy0UEUO6cwy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxWBEtFo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715581802; x=1747117802;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7mYeRH6vUgm9MbbFusd0OvPWzb7Hs8e22qZZ0BmaDHg=;
  b=bxWBEtFoZI6K/FsWMVZqTs9+VLWDf8Yzi6AoZXRfXVW66M9luJg3FnvZ
   GQHsjffkGbtlRjJZwCIi4OH03OHa+FkuVLrEbqOP1Cq7Xh/RoBxM+GCXt
   WxC2MBS7dCQBc4c30wZ5v0pNCZEU4pD/yMiyE0GT6eV5zlvp5udXjSNcJ
   fkUYtf6R9VPKSuDJo2CQ+7PG5d1iUjQ92AC+7TjQHKyR2AiUsk214FPKm
   0RzF4CKeYHMSrdmLJRolZavfczAoQm+zawO17e8XahacoqZuoB7RyNENg
   PrbgGfHx/SPsulGJWT2U5DDsu9Mk1vunJ+i6zIQ4wuYfr3LKrrl15F5oI
   w==;
X-CSE-ConnectionGUID: LT16wnkDTWia8fBN3x4+pQ==
X-CSE-MsgGUID: pdmVQf7JRla8xeSaqxCHXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11438396"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11438396"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 23:30:01 -0700
X-CSE-ConnectionGUID: pNJH3E/nQcudCh010Gn97Q==
X-CSE-MsgGUID: ggdeK/I5SRyMFN1xXKul1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30345539"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 May 2024 23:30:00 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6PCA-0009bZ-13;
	Mon, 13 May 2024 06:29:58 +0000
Date: Mon, 13 May 2024 14:28:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/exynos] BUILD SUCCESS
 358e579a9da21c2aa906a363f1e87768b5ccb028
Message-ID: <202405131456.rcemfOHv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/exynos
branch HEAD: 358e579a9da21c2aa906a363f1e87768b5ccb028  PCI: exynos: Adapt to use bulk clock APIs

elapsed time: 1178m

configs tested: 211
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240513   gcc  
arc                   randconfig-002-20240513   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        multi_v5_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                   randconfig-002-20240513   gcc  
arm                   randconfig-004-20240513   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240513   gcc  
arm64                 randconfig-002-20240513   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240513   gcc  
csky                  randconfig-002-20240513   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-001-20240513   clang
i386         buildonly-randconfig-002-20240512   clang
i386         buildonly-randconfig-002-20240513   clang
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-004-20240513   clang
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240512   clang
i386                                defconfig   clang
i386                  randconfig-001-20240512   clang
i386                  randconfig-002-20240512   clang
i386                  randconfig-002-20240513   clang
i386                  randconfig-003-20240512   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-004-20240513   clang
i386                  randconfig-005-20240512   clang
i386                  randconfig-006-20240512   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240512   clang
i386                  randconfig-012-20240513   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-013-20240513   clang
i386                  randconfig-014-20240512   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240512   gcc  
i386                  randconfig-016-20240513   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240513   gcc  
loongarch             randconfig-002-20240513   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
mips                          rb532_defconfig   clang
mips                          rm200_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240513   gcc  
nios2                 randconfig-002-20240513   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240513   gcc  
parisc                randconfig-002-20240513   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-001-20240513   gcc  
powerpc               randconfig-002-20240513   gcc  
powerpc               randconfig-003-20240513   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240513   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240513   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240513   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240513   gcc  
sh                    randconfig-002-20240513   gcc  
sh                           se7206_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240513   gcc  
sparc64               randconfig-002-20240513   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240513   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240512   clang
x86_64       buildonly-randconfig-001-20240513   gcc  
x86_64       buildonly-randconfig-002-20240512   clang
x86_64       buildonly-randconfig-002-20240513   gcc  
x86_64       buildonly-randconfig-003-20240512   clang
x86_64       buildonly-randconfig-003-20240513   gcc  
x86_64       buildonly-randconfig-004-20240512   gcc  
x86_64       buildonly-randconfig-005-20240512   clang
x86_64       buildonly-randconfig-006-20240512   gcc  
x86_64       buildonly-randconfig-006-20240513   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240512   gcc  
x86_64                randconfig-002-20240512   gcc  
x86_64                randconfig-003-20240512   clang
x86_64                randconfig-004-20240512   gcc  
x86_64                randconfig-004-20240513   gcc  
x86_64                randconfig-005-20240512   gcc  
x86_64                randconfig-006-20240512   gcc  
x86_64                randconfig-011-20240512   gcc  
x86_64                randconfig-012-20240512   gcc  
x86_64                randconfig-012-20240513   gcc  
x86_64                randconfig-013-20240512   clang
x86_64                randconfig-014-20240512   gcc  
x86_64                randconfig-015-20240512   clang
x86_64                randconfig-015-20240513   gcc  
x86_64                randconfig-016-20240512   clang
x86_64                randconfig-071-20240512   clang
x86_64                randconfig-072-20240512   gcc  
x86_64                randconfig-073-20240512   gcc  
x86_64                randconfig-074-20240512   clang
x86_64                randconfig-074-20240513   gcc  
x86_64                randconfig-075-20240512   clang
x86_64                randconfig-075-20240513   gcc  
x86_64                randconfig-076-20240512   clang
x86_64                randconfig-076-20240513   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240513   gcc  
xtensa                randconfig-002-20240513   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

