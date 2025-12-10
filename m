Return-Path: <linux-pci+bounces-42910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 559DCCB3D80
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 20:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95B9308AE0D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D7C324B16;
	Wed, 10 Dec 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHw2/4Xe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9D31D75E
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765394032; cv=none; b=tqAoFOXhvV4fb4Dt79YLgKdWP/pSeOuR1GZWvcoeGon/7D+UULOv/n/0yPu4DVcoOwt+ogpPGyBCg5rIlXt1vqpwzHkHFQ0X0VUs75RZFNosoOHoN+1pj+GM1xMwPYenMjqvlWxpm0AeKBj/NuPFHVxv/I0BpNJ/NlLIBUyDVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765394032; c=relaxed/simple;
	bh=LDmu8JKkAeoOYifkZSDkXUEscRL3+fNVwUxQDEujvWY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kh+JunMYR4jCmU5oZtz4/f6jQLz3USFqbnQfcOjXpheHYkrEe/ZAApuyimNAs0+1uicEXBbYb17ki4GKJT7TpK1JloGPs1xm6JOMq++SFWYo18rnIYVihrXFBxHfZHttWzvCz3K9cSyK2/HV0fg1EJjk6H+iGpxwQx4t6DWFrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHw2/4Xe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765394029; x=1796930029;
  h=date:from:to:cc:subject:message-id;
  bh=LDmu8JKkAeoOYifkZSDkXUEscRL3+fNVwUxQDEujvWY=;
  b=HHw2/4XeBz0CD62UEpJ9wyl9DW/x4GRi7xsLJ/aZBpUznoXSstDIZ1xB
   7Se8TJFRfH5ntZk0PElv2vAekTZ2U1apBqV/m+dypyLCY9SaSxHCabjP5
   6I6dAyHe/zjOCUsBEow3JbHIiEe9hTaKtXh+1cimQNeGA/YlHeHfwWANo
   CemZQ1TCb+Xmb7BhB/+l/LqZrrLWzKKnI5u7gnHVLfx9vqghiOC3/3ZBC
   8euk65W54F0N/58VAqOtXjjohrRENaG0DsOPkFwxvEzg0wNyEbFlJN1xJ
   +uYAPC9cGWLb530ymr/8NxGdLPLni4Pkdi/PAmBZvk6TQSjbvru76T0Du
   g==;
X-CSE-ConnectionGUID: +BNlcMi7RzyUEOfEpz4Umg==
X-CSE-MsgGUID: S4Eq5rPMTKicwiROnsFHAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="84780645"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="84780645"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 11:13:49 -0800
X-CSE-ConnectionGUID: Q+kma0oeRkSiteML3W7K5A==
X-CSE-MsgGUID: U8NMWYe3RCqZ/UbMYnmmzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="219940906"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Dec 2025 11:13:48 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTPdC-000000003g3-1KBh;
	Wed, 10 Dec 2025 19:13:46 +0000
Date: Thu, 11 Dec 2025 03:13:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra] BUILD SUCCESS
 902ddc237deb7c417216e8c9eaddb075f5422ae8
Message-ID: <202512110329.FE8aNfVc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra
branch HEAD: 902ddc237deb7c417216e8c9eaddb075f5422ae8  PCI: tegra: Allow building as a module

elapsed time: 1454m

configs tested: 169
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                          axs103_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251210    gcc-11.5.0
arc                   randconfig-002-20251210    gcc-11.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                          ep93xx_defconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-22
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20251210    gcc-11.5.0
arm                   randconfig-002-20251210    gcc-11.5.0
arm                   randconfig-003-20251210    gcc-11.5.0
arm                   randconfig-004-20251210    gcc-11.5.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251210    clang-17
arm64                 randconfig-002-20251210    clang-17
arm64                 randconfig-003-20251210    clang-17
arm64                 randconfig-004-20251210    clang-17
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251210    clang-17
csky                  randconfig-002-20251210    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251210    gcc-10.5.0
hexagon               randconfig-002-20251210    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251210    clang-20
i386        buildonly-randconfig-002-20251210    clang-20
i386        buildonly-randconfig-003-20251210    clang-20
i386        buildonly-randconfig-004-20251210    clang-20
i386        buildonly-randconfig-005-20251210    clang-20
i386        buildonly-randconfig-006-20251210    clang-20
i386                                defconfig    gcc-15.1.0
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251210    gcc-10.5.0
loongarch             randconfig-002-20251210    gcc-10.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                          amiga_defconfig    clang-22
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5208evb_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251210    gcc-10.5.0
nios2                 randconfig-002-20251210    gcc-10.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    clang-22
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251210    clang-19
parisc                randconfig-002-20251210    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      bamboo_defconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251210    clang-19
powerpc               randconfig-002-20251210    clang-19
powerpc                     taishan_defconfig    gcc-15.1.0
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251210    clang-19
powerpc64             randconfig-002-20251210    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251210    clang-22
riscv                 randconfig-002-20251210    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251210    clang-22
s390                  randconfig-002-20251210    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251210    clang-22
sh                    randconfig-002-20251210    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251210    gcc-15.1.0
sparc                 randconfig-002-20251210    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251210    gcc-15.1.0
sparc64               randconfig-002-20251210    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251210    gcc-15.1.0
um                    randconfig-002-20251210    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251210    clang-20
x86_64      buildonly-randconfig-002-20251210    clang-20
x86_64      buildonly-randconfig-003-20251210    clang-20
x86_64      buildonly-randconfig-004-20251210    clang-20
x86_64      buildonly-randconfig-005-20251210    clang-20
x86_64      buildonly-randconfig-006-20251210    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251210    gcc-14
x86_64                randconfig-002-20251210    gcc-14
x86_64                randconfig-003-20251210    gcc-14
x86_64                randconfig-004-20251210    gcc-14
x86_64                randconfig-005-20251210    gcc-14
x86_64                randconfig-006-20251210    gcc-14
x86_64                randconfig-011-20251210    clang-20
x86_64                randconfig-012-20251210    clang-20
x86_64                randconfig-013-20251210    clang-20
x86_64                randconfig-014-20251210    clang-20
x86_64                randconfig-015-20251210    clang-20
x86_64                randconfig-016-20251210    clang-20
x86_64                randconfig-071-20251210    clang-20
x86_64                randconfig-072-20251210    clang-20
x86_64                randconfig-073-20251210    clang-20
x86_64                randconfig-074-20251210    clang-20
x86_64                randconfig-075-20251210    clang-20
x86_64                randconfig-076-20251210    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251210    gcc-15.1.0
xtensa                randconfig-002-20251210    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

