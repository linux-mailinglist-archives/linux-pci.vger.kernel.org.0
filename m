Return-Path: <linux-pci+bounces-42975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65707CB73C9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 22:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D56301A194
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 21:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E492BE7C3;
	Thu, 11 Dec 2025 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix9Eausw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A726A1A4
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490094; cv=none; b=BlPEa6I4jKQJt1qu68gJtdNGIrzJbs2qo2RB9Aor4t4q02zhe0YvwNtT+8k+eUCSylAjZe/mcrlpRV9ub0YMgVrnhkBjfRr1K+xMZ0UEe2ggcT0NhS3cw2yU/CIla8B2qsZqceJT7AQhhWPDW9PVbKw+ZAhsHkmwZBhyRqY8xIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490094; c=relaxed/simple;
	bh=KYIOgu/1yPiibL+2tQq8/BlDb8nFoViAhxlLQuYcNwA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G+7osJ/9HOzD2wzSXXwwGbcIIx/V64PrBAWb099cyhs+IME6yhz2WxzvOJT117idR6bOt56aMsNga8cNEehp3c/w3gyFGOwj4jGsbrf/p/1CMcq10h41S6AOmZqAsen5Z5MQWuKTkrqRhIZRIKNmVU53FClRklhtn5XAlT7Hb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix9Eausw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765490093; x=1797026093;
  h=date:from:to:cc:subject:message-id;
  bh=KYIOgu/1yPiibL+2tQq8/BlDb8nFoViAhxlLQuYcNwA=;
  b=Ix9EausweyYEtZh4nr7wnpJ948S1JrtMKOpGamElWhz4+ytAZHnQoAWG
   kGU2pSbkumejDEYFcg6bP1st+IppFSeA9ySeSSNKWPbo7cQgGVWj//t7e
   uwtm+Z8Z0RgyjNg0Dlh+l+OK7Ds2l3Ta6e/eLyh7iHYDbEZHo7fOxT8CF
   PMRYbOaJOYhl0e3ElUaYK5O2cYxHjFbdnMWBt0NGtTxDJro7HRi6CB+e0
   E/yLMIj5C8X4Jh/rUfBGvNBeJ8ITqSD7KoNiodJIthZ9adouthAJQWqPi
   PSTnbne5joXEHUcoxBsTBsqizFGt41kQOQzq3Mtb/u8xNPc+18hWPSUe4
   A==;
X-CSE-ConnectionGUID: vKMJ3ka4RtmAvUECdfq8PA==
X-CSE-MsgGUID: 3BnE0xfkR76qU2zm/DFgiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67438798"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67438798"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 13:54:52 -0800
X-CSE-ConnectionGUID: FnmPlW7bSmOTArW+7QSsEg==
X-CSE-MsgGUID: NBOa0I0FSzqFRvJyoXm3kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197383731"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Dec 2025 13:54:51 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vToca-00000000593-2Eog;
	Thu, 11 Dec 2025 21:54:48 +0000
Date: Fri, 12 Dec 2025 05:54:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 3747d114a217930dc29dea355c74b588355355f7
Message-ID: <202512120520.I3WvOGOY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 3747d114a217930dc29dea355c74b588355355f7  PCI: Use resource_set_range() that correctly sets ->end

elapsed time: 1450m

configs tested: 219
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251211    gcc-10.5.0
arc                   randconfig-001-20251211    gcc-8.5.0
arc                   randconfig-002-20251211    gcc-10.5.0
arc                   randconfig-002-20251211    gcc-14.3.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251211    gcc-10.5.0
arm                   randconfig-001-20251211    gcc-8.5.0
arm                   randconfig-002-20251211    gcc-10.5.0
arm                   randconfig-003-20251211    clang-22
arm                   randconfig-003-20251211    gcc-10.5.0
arm                   randconfig-004-20251211    clang-22
arm                   randconfig-004-20251211    gcc-10.5.0
arm                         s5pv210_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251211    clang-22
arm64                 randconfig-002-20251211    clang-22
arm64                 randconfig-003-20251211    gcc-14.3.0
arm64                 randconfig-004-20251211    clang-16
csky                             allmodconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251211    gcc-11.5.0
csky                  randconfig-002-20251211    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251211    clang-19
hexagon               randconfig-001-20251211    gcc-8.5.0
hexagon               randconfig-002-20251211    clang-17
hexagon               randconfig-002-20251211    gcc-8.5.0
i386                             allmodconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251211    clang-20
i386        buildonly-randconfig-002-20251211    gcc-14
i386        buildonly-randconfig-003-20251211    clang-20
i386        buildonly-randconfig-004-20251211    gcc-13
i386        buildonly-randconfig-005-20251211    gcc-14
i386        buildonly-randconfig-006-20251211    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20251211    gcc-14
i386                  randconfig-002-20251211    clang-20
i386                  randconfig-003-20251211    clang-20
i386                  randconfig-004-20251211    gcc-14
i386                  randconfig-005-20251211    clang-20
i386                  randconfig-006-20251211    gcc-14
i386                  randconfig-007-20251211    clang-20
i386                  randconfig-011-20251211    clang-20
i386                  randconfig-011-20251211    gcc-14
i386                  randconfig-012-20251211    clang-20
i386                  randconfig-012-20251211    gcc-12
i386                  randconfig-013-20251211    clang-20
i386                  randconfig-014-20251211    clang-20
i386                  randconfig-015-20251211    clang-20
i386                  randconfig-016-20251211    clang-20
i386                  randconfig-017-20251211    clang-20
i386                  randconfig-017-20251211    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251211    gcc-14.3.0
loongarch             randconfig-001-20251211    gcc-8.5.0
loongarch             randconfig-002-20251211    clang-18
loongarch             randconfig-002-20251211    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           xway_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251211    gcc-8.5.0
nios2                 randconfig-002-20251211    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251211    gcc-14.3.0
parisc                randconfig-002-20251211    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251211    clang-22
powerpc               randconfig-002-20251211    clang-22
powerpc64             randconfig-001-20251211    gcc-8.5.0
powerpc64             randconfig-002-20251211    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251211    clang-22
riscv                 randconfig-001-20251211    gcc-11.5.0
riscv                 randconfig-002-20251211    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251211    gcc-11.5.0
s390                  randconfig-002-20251211    clang-22
s390                  randconfig-002-20251211    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251211    gcc-11.5.0
sh                    randconfig-001-20251211    gcc-15.1.0
sh                    randconfig-002-20251211    gcc-10.5.0
sh                    randconfig-002-20251211    gcc-11.5.0
sh                           se7712_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251211    gcc-11.5.0
sparc                 randconfig-002-20251211    gcc-11.5.0
sparc                 randconfig-002-20251211    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251211    gcc-11.5.0
sparc64               randconfig-001-20251211    gcc-8.5.0
sparc64               randconfig-002-20251211    gcc-11.5.0
sparc64               randconfig-002-20251211    gcc-8.5.0
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251211    clang-22
um                    randconfig-001-20251211    gcc-11.5.0
um                    randconfig-002-20251211    gcc-11.5.0
um                    randconfig-002-20251211    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251211    clang-20
x86_64      buildonly-randconfig-001-20251211    gcc-14
x86_64      buildonly-randconfig-002-20251211    clang-20
x86_64      buildonly-randconfig-002-20251211    gcc-14
x86_64      buildonly-randconfig-003-20251211    clang-20
x86_64      buildonly-randconfig-004-20251211    clang-20
x86_64      buildonly-randconfig-005-20251211    clang-20
x86_64      buildonly-randconfig-005-20251211    gcc-14
x86_64      buildonly-randconfig-006-20251211    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251211    gcc-12
x86_64                randconfig-001-20251211    gcc-14
x86_64                randconfig-002-20251211    clang-20
x86_64                randconfig-002-20251211    gcc-12
x86_64                randconfig-003-20251211    gcc-12
x86_64                randconfig-004-20251211    clang-20
x86_64                randconfig-004-20251211    gcc-12
x86_64                randconfig-005-20251211    gcc-12
x86_64                randconfig-005-20251211    gcc-14
x86_64                randconfig-006-20251211    gcc-12
x86_64                randconfig-006-20251211    gcc-14
x86_64                randconfig-011-20251211    gcc-14
x86_64                randconfig-012-20251211    gcc-14
x86_64                randconfig-013-20251211    gcc-14
x86_64                randconfig-014-20251211    gcc-14
x86_64                randconfig-015-20251211    gcc-14
x86_64                randconfig-016-20251211    gcc-14
x86_64                randconfig-071-20251211    gcc-14
x86_64                randconfig-072-20251211    clang-20
x86_64                randconfig-073-20251211    gcc-14
x86_64                randconfig-074-20251211    clang-20
x86_64                randconfig-075-20251211    clang-20
x86_64                randconfig-076-20251211    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251211    gcc-11.5.0
xtensa                randconfig-002-20251211    gcc-11.5.0
xtensa                randconfig-002-20251211    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

