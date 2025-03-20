Return-Path: <linux-pci+bounces-24272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AEDA6B0FE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9138B7B0EFE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721012AE6A;
	Thu, 20 Mar 2025 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqJShop1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD851E9B1D
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510151; cv=none; b=ErL2cFRgfgDG1mp86gY9D2ro44LVHGkhmFU6ksTN2bdgy2XVc1fzQ/OZ8hP53MWOoGXqbByBT0ARpp+Wvd4YtJTs/Jev1zys1d/jVeIZebQ5Ya0gcE5Xg7ku/ir0pDCW9FHLWHVi+VMU0go9izrUPtCD8s5fm9IbrA+GLNl7LOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510151; c=relaxed/simple;
	bh=pyN1IpPoUEN/sj17w+1+8laOjqCQ6gpZFEjWWJtIfX0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ieK/TyOVSYl2bvwFfXQ1uNFqKuUhvpTTKesCnH642TbGIRxqJD9evchRc/hLLzbdRku/EL3OPyY4FjQSRxBV8ox5TzKKxtavxsiwHuRZQcAtooGxUgE/JKcmtP7YoCZYvSoegx0ujpml5rMU6wtdCjkxSGGyvvXPC9/MAvML+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqJShop1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742510150; x=1774046150;
  h=date:from:to:cc:subject:message-id;
  bh=pyN1IpPoUEN/sj17w+1+8laOjqCQ6gpZFEjWWJtIfX0=;
  b=JqJShop1w2lx8vSi/tTSeQIiTISJ38TaChfDxkfCXN8mAmiuc/WZJLlD
   XUfMBM7HAsM2J7BZTVmoZTvChpzrwua3WLcL4mZlrI6O7tlZP6jRzvRRY
   U7ys5wko1gQSfx/Vop4lkrHtANvy67Vk6hv6S5BV9JbvgMCnxBQZ404X8
   kqNq9kBxw01273GmmQydORraDypDRlzwGBMgKpdW0+av81x76aOYUA9tJ
   /CG73UvvSXTlwJZyq4sXPfMvPZLVP+NXpLbKjP8OX+gs5C0oY+n5/rQ//
   eQdqYQ5mryUSBJwVOfMvzLDsvZqca4r4qqM5Dmh22QrYOCLFk6bvFXvbx
   w==;
X-CSE-ConnectionGUID: q3XKZmphRA6kT3O+wC8RpQ==
X-CSE-MsgGUID: c1COf0CfTKyBbZHyNfnB5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61164660"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="61164660"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:35:48 -0700
X-CSE-ConnectionGUID: SU1gZBWVTTWTx31Qwwq8FA==
X-CSE-MsgGUID: W6fnFxt6Ru6YzbEKfSgWxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="128061246"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 20 Mar 2025 15:35:46 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvOUK-0000pf-1I;
	Thu, 20 Mar 2025 22:35:44 +0000
Date: Fri, 21 Mar 2025 06:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/amd-mdb] BUILD SUCCESS
 6af0b51d9328d1309af9200bdc7ca3181eebc6ba
Message-ID: <202503210644.g3FquO23-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/amd-mdb
branch HEAD: 6af0b51d9328d1309af9200bdc7ca3181eebc6ba  PCI: amd-mdb: Add AMD MDB Root Port driver

elapsed time: 1448m

configs tested: 239
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-001-20250321    clang-21
arc                   randconfig-002-20250320    gcc-8.5.0
arc                   randconfig-002-20250321    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-001-20250321    clang-21
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-002-20250321    clang-21
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-003-20250321    clang-21
arm                   randconfig-004-20250320    gcc-7.5.0
arm                   randconfig-004-20250321    clang-21
arm                           sama7_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250320    clang-21
arm64                 randconfig-001-20250321    clang-21
arm64                 randconfig-002-20250320    clang-21
arm64                 randconfig-002-20250321    clang-21
arm64                 randconfig-003-20250320    clang-19
arm64                 randconfig-003-20250321    clang-21
arm64                 randconfig-004-20250320    gcc-8.5.0
arm64                 randconfig-004-20250321    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-001-20250321    gcc-7.5.0
csky                  randconfig-002-20250320    gcc-14.2.0
csky                  randconfig-002-20250321    gcc-7.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-001-20250321    gcc-7.5.0
hexagon               randconfig-002-20250320    clang-21
hexagon               randconfig-002-20250321    gcc-7.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250320    gcc-12
i386        buildonly-randconfig-002-20250320    clang-20
i386        buildonly-randconfig-003-20250320    clang-20
i386        buildonly-randconfig-004-20250320    clang-20
i386        buildonly-randconfig-005-20250320    gcc-12
i386        buildonly-randconfig-006-20250320    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250321    clang-20
i386                  randconfig-002-20250321    clang-20
i386                  randconfig-003-20250321    clang-20
i386                  randconfig-004-20250321    clang-20
i386                  randconfig-005-20250321    clang-20
i386                  randconfig-006-20250321    clang-20
i386                  randconfig-007-20250321    clang-20
i386                  randconfig-011-20250321    clang-20
i386                  randconfig-012-20250321    clang-20
i386                  randconfig-013-20250321    clang-20
i386                  randconfig-014-20250321    clang-20
i386                  randconfig-015-20250321    clang-20
i386                  randconfig-016-20250321    clang-20
i386                  randconfig-017-20250321    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250320    gcc-14.2.0
loongarch             randconfig-001-20250321    gcc-7.5.0
loongarch             randconfig-002-20250320    gcc-12.4.0
loongarch             randconfig-002-20250321    gcc-7.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-001-20250321    gcc-7.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
nios2                 randconfig-002-20250321    gcc-7.5.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250320    gcc-13.3.0
parisc                randconfig-001-20250321    gcc-7.5.0
parisc                randconfig-002-20250320    gcc-11.5.0
parisc                randconfig-002-20250321    gcc-7.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250320    gcc-6.5.0
powerpc               randconfig-001-20250321    gcc-7.5.0
powerpc               randconfig-002-20250320    clang-21
powerpc               randconfig-002-20250321    gcc-7.5.0
powerpc               randconfig-003-20250320    clang-21
powerpc               randconfig-003-20250321    gcc-7.5.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250320    clang-21
powerpc64             randconfig-001-20250321    gcc-7.5.0
powerpc64             randconfig-002-20250320    gcc-8.5.0
powerpc64             randconfig-002-20250321    gcc-7.5.0
powerpc64             randconfig-003-20250320    clang-21
powerpc64             randconfig-003-20250321    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-001-20250321    gcc-6.5.0
riscv                 randconfig-002-20250320    gcc-8.5.0
riscv                 randconfig-002-20250321    gcc-6.5.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                             allyesconfig    gcc-8.5.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-001-20250321    gcc-6.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
s390                  randconfig-002-20250321    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-001-20250321    gcc-6.5.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                    randconfig-002-20250321    gcc-6.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-001-20250321    gcc-6.5.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc                 randconfig-002-20250321    gcc-6.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-001-20250321    gcc-6.5.0
sparc64               randconfig-002-20250320    gcc-13.3.0
sparc64               randconfig-002-20250321    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-001-20250321    gcc-6.5.0
um                    randconfig-002-20250320    clang-16
um                    randconfig-002-20250321    gcc-6.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-001-20250321    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-002-20250321    clang-20
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-003-20250321    clang-20
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-004-20250321    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-005-20250321    clang-20
x86_64      buildonly-randconfig-006-20250320    gcc-12
x86_64      buildonly-randconfig-006-20250321    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250321    clang-20
x86_64                randconfig-002-20250321    clang-20
x86_64                randconfig-003-20250321    clang-20
x86_64                randconfig-004-20250321    clang-20
x86_64                randconfig-005-20250321    clang-20
x86_64                randconfig-006-20250321    clang-20
x86_64                randconfig-007-20250321    clang-20
x86_64                randconfig-008-20250321    clang-20
x86_64                randconfig-071-20250321    gcc-12
x86_64                randconfig-072-20250321    gcc-12
x86_64                randconfig-073-20250321    gcc-12
x86_64                randconfig-074-20250321    gcc-12
x86_64                randconfig-075-20250321    gcc-12
x86_64                randconfig-076-20250321    gcc-12
x86_64                randconfig-077-20250321    gcc-12
x86_64                randconfig-078-20250321    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-001-20250321    gcc-6.5.0
xtensa                randconfig-002-20250320    gcc-11.5.0
xtensa                randconfig-002-20250321    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

