Return-Path: <linux-pci+bounces-44117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717ECFA48D
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 19:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0223D3059ABC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C12D1F4E;
	Tue,  6 Jan 2026 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZE2yLg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE92773E5
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724675; cv=none; b=ZnJqvlgCt3vUiPAR2NHBe1vzKXiZ6+s6qo+fzxGdduXxvT6WoRDBmw7qw13Dzi4a2lpodfxtTVFm1XO2dRBuvrefWrh3iIk5LJX+uyboRo+ubXkIwP+tBnglxEMBSiIjzsAot3eamVVERlP8yRw0xtfloBI40lulgw10G6G4aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724675; c=relaxed/simple;
	bh=JNbVMuNxm5OaSkhD4s61e9tneD+njwATn7GLp7xN9lY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oYXPbmvVYy0kcVYN7SQ4jdjKygdRTAJUA+iQ89/vhFEHUVskan9+OY2q0aulnydPxW2Rux3cUpRbA432cbq+5UCCQcvO6LlXEd1+yndTG4up06TScOP/Z3Ze/Uv4IIQLexaD+lsp4bmqNrZi9oAlPC2y3WSir0x8aPbUtKJAenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZE2yLg3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767724673; x=1799260673;
  h=date:from:to:cc:subject:message-id;
  bh=JNbVMuNxm5OaSkhD4s61e9tneD+njwATn7GLp7xN9lY=;
  b=IZE2yLg3kWYmkFaYbEmWJl0+2NW7tBDpr//tw81j88WvISe/1io/tUwG
   tkGiCHM4ESL7O/525Ex5pG6EZaf4kIQccM1NuBBHfQUw2aMa7DS+Ia2Ll
   u2FWtWv3E+qIhzfmgGK/b1Jk4q2mzztGN4I7xQRXYLO4UtN1eG/w+8cRm
   yD8Ddiuuy9Azf7t+tA+FJOp50GyNm5uyVYnGW1WTWRKd0Mj4koi047HRW
   B+dKlbELrDOJEkwCJTKjmlMEEiqRLqMOhcdJ6WQg6sCeGLAkV/cyprrfc
   htp28/l4FuwwZwBVgOHA0umR0DJbzELmA1hNXzxY/9X75ypr1P32ke/8J
   Q==;
X-CSE-ConnectionGUID: ltoosV0pTyGBlp5uXWx1Zg==
X-CSE-MsgGUID: zN/AoZzhQ3a64UK9ypadnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79814045"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="79814045"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 10:37:53 -0800
X-CSE-ConnectionGUID: Xw54dsY7Qb2l+n6QcKgZ0w==
X-CSE-MsgGUID: +Kn8vPYqT8q8jz37l/6qVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="202622242"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2026 10:37:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdBwD-00000000320-3C4O;
	Tue, 06 Jan 2026 18:37:49 +0000
Date: Wed, 07 Jan 2026 02:37:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 df27c03b9e3ef2baa9e9c9f56a771d463a84489d
Message-ID: <202601070211.gSCIpzE1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: df27c03b9e3ef2baa9e9c9f56a771d463a84489d  PCI: meson: Report that link is up while in ASPM L0s and L1 states

elapsed time: 1507m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260106    gcc-13.4.0
arc                   randconfig-002-20260106    gcc-13.4.0
arm                               allnoconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20260106    gcc-13.4.0
arm                   randconfig-002-20260106    gcc-13.4.0
arm                   randconfig-003-20260106    gcc-13.4.0
arm                   randconfig-004-20260106    gcc-13.4.0
arm                         s5pv210_defconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260106    gcc-10.5.0
arm64                 randconfig-002-20260106    gcc-10.5.0
arm64                 randconfig-003-20260106    gcc-10.5.0
arm64                 randconfig-004-20260106    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260106    gcc-10.5.0
csky                  randconfig-002-20260106    gcc-10.5.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20260106    gcc-8.5.0
hexagon               randconfig-002-20260106    gcc-8.5.0
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20260106    clang-20
i386        buildonly-randconfig-002-20260106    clang-20
i386        buildonly-randconfig-003-20260106    clang-20
i386        buildonly-randconfig-004-20260106    clang-20
i386        buildonly-randconfig-005-20260106    clang-20
i386        buildonly-randconfig-006-20260106    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20260106    clang-20
i386                  randconfig-002-20260106    clang-20
i386                  randconfig-003-20260106    clang-20
i386                  randconfig-004-20260106    clang-20
i386                  randconfig-005-20260106    clang-20
i386                  randconfig-006-20260106    clang-20
i386                  randconfig-007-20260106    clang-20
i386                  randconfig-011-20260106    gcc-14
i386                  randconfig-012-20260106    gcc-14
i386                  randconfig-013-20260106    gcc-14
i386                  randconfig-014-20260106    gcc-14
i386                  randconfig-015-20260106    gcc-14
i386                  randconfig-016-20260106    gcc-14
i386                  randconfig-017-20260106    gcc-14
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260106    gcc-8.5.0
loongarch             randconfig-002-20260106    gcc-8.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       alldefconfig    clang-22
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260106    gcc-8.5.0
nios2                 randconfig-002-20260106    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    clang-22
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260106    gcc-8.5.0
parisc                randconfig-002-20260106    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                           allnoconfig    clang-22
powerpc                    gamecube_defconfig    clang-22
powerpc               randconfig-001-20260106    gcc-8.5.0
powerpc               randconfig-002-20260106    gcc-8.5.0
powerpc64             randconfig-001-20260106    gcc-8.5.0
powerpc64             randconfig-002-20260106    gcc-8.5.0
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20260106    gcc-8.5.0
riscv                 randconfig-002-20260106    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20260106    gcc-8.5.0
s390                  randconfig-002-20260106    gcc-8.5.0
sh                                allnoconfig    clang-22
sh                                  defconfig    gcc-14
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20260106    gcc-8.5.0
sh                    randconfig-002-20260106    gcc-8.5.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260106    gcc-8.5.0
sparc                 randconfig-002-20260106    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260106    gcc-8.5.0
sparc64               randconfig-002-20260106    gcc-8.5.0
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260106    gcc-8.5.0
um                    randconfig-002-20260106    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260106    clang-20
x86_64      buildonly-randconfig-002-20260106    clang-20
x86_64      buildonly-randconfig-003-20260106    clang-20
x86_64      buildonly-randconfig-004-20260106    clang-20
x86_64      buildonly-randconfig-005-20260106    clang-20
x86_64      buildonly-randconfig-006-20260106    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260106    clang-20
x86_64                randconfig-002-20260106    clang-20
x86_64                randconfig-003-20260106    clang-20
x86_64                randconfig-004-20260106    clang-20
x86_64                randconfig-005-20260106    clang-20
x86_64                randconfig-006-20260106    clang-20
x86_64                randconfig-011-20260106    gcc-14
x86_64                randconfig-012-20260106    gcc-14
x86_64                randconfig-013-20260106    gcc-14
x86_64                randconfig-014-20260106    gcc-14
x86_64                randconfig-015-20260106    gcc-14
x86_64                randconfig-016-20260106    gcc-14
x86_64                randconfig-071-20260106    clang-20
x86_64                randconfig-072-20260106    clang-20
x86_64                randconfig-073-20260106    clang-20
x86_64                randconfig-074-20260106    clang-20
x86_64                randconfig-075-20260106    clang-20
x86_64                randconfig-076-20260106    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                randconfig-001-20260106    gcc-8.5.0
xtensa                randconfig-002-20260106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

