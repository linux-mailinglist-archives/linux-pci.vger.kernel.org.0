Return-Path: <linux-pci+bounces-32568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153AB0AB39
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 23:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397157A8969
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D921A436;
	Fri, 18 Jul 2025 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJY8cY70"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F991F91C8
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872400; cv=none; b=bYYSDQ2JO5HvZO+CW88pgMcBAyoJBJ8cCIe3uvvGj2c+QBXYY0Zq8CP3iJrC4/d5edSt79lWlQ+sx1Ud8WaFex5W6m/Y3cu3Fn/FaORRvr9D6waMWf4gYEa3llxogaxJD/Je9S1YsJJ4mg09VvWTFIakxGfCYni+ccWbRGCi59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872400; c=relaxed/simple;
	bh=cvZACTsfdu9p/qwObMtPmxQjwWaMddoiqT2S9mJxXdY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dko5C41JGceVcDudN0GQUsVcDG0ZqcLQtpexFiQ6Uupi6VdHEgQO+CgVvklsDdRhB1poUri4o9x3ljR19eqrVYafNF/piNZmaU9VMoODJbL07/cE1JGDreXopmURIZC+qR4kRWR+k/qOQtKC/KSHCsoo/37uA2iR9k9W2Brhj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJY8cY70; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752872398; x=1784408398;
  h=date:from:to:cc:subject:message-id;
  bh=cvZACTsfdu9p/qwObMtPmxQjwWaMddoiqT2S9mJxXdY=;
  b=dJY8cY70xDdzaGPB/KRum6ayQOCcV3dl8FM8gX1uVF0K1oddWahM7vNV
   jV3NKLn2uKqwZVrcHhEl8jf/9GoRRFnxuWZV2Y8hUPByAZjJqlhxC2h62
   7/H6yCIloJ0oLXRP42k2QtfPDjsWYNTdPdf2UnjxNNcZfP+RO2k2eW/MF
   6lKHVfgtoHAoWaS9ONZ82EPo4RR5YA5ka62Yw7WrTNfDpnD1qgBemMlIM
   L6m53V4aN29TlINiqWrJeRYiaJwTiW2yqKVmeERFBq9weFUjHxcZDBUXe
   xpkRDbSsaANQrRqlF6N2hpc2cvYKlwXLiTTEqQ6fbpS3pnkX5CsnoI+Wp
   w==;
X-CSE-ConnectionGUID: RsSg/43dQkSyb5n0zooQ2w==
X-CSE-MsgGUID: iVF6oLkQTLOxJbzOTZW6yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72739068"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="72739068"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 13:59:57 -0700
X-CSE-ConnectionGUID: MYkofMklTGyHlpfhcTB4Ig==
X-CSE-MsgGUID: 8pw+ja0FQqO6g1mlyo6zRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157557362"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 Jul 2025 13:59:55 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucsBN-000F2p-2u;
	Fri, 18 Jul 2025 20:59:53 +0000
Date: Sat, 19 Jul 2025 04:59:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 49c326665c4abca0d38a3931dbb339cebb8c73e0
Message-ID: <202507190429.QIAc6l5J-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 49c326665c4abca0d38a3931dbb339cebb8c73e0  PCI: pnv_php: Enable third attention indicator state

elapsed time: 1249m

configs tested: 207
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    clang-21
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-001-20250718    gcc-8.5.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm                   randconfig-004-20250718    gcc-8.5.0
arm                          sp7021_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-001-20250718    gcc-8.5.0
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-003-20250718    gcc-8.5.0
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-001-20250718    gcc-15.1.0
hexagon               randconfig-002-20250718    clang-21
hexagon               randconfig-002-20250718    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-002-20250718    gcc-12
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-004-20250718    gcc-12
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
i386        buildonly-randconfig-006-20250718    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250718    gcc-12
i386                  randconfig-002-20250718    gcc-12
i386                  randconfig-003-20250718    gcc-12
i386                  randconfig-004-20250718    gcc-12
i386                  randconfig-005-20250718    gcc-12
i386                  randconfig-006-20250718    gcc-12
i386                  randconfig-007-20250718    gcc-12
i386                  randconfig-011-20250718    clang-20
i386                  randconfig-012-20250718    clang-20
i386                  randconfig-013-20250718    clang-20
i386                  randconfig-014-20250718    clang-20
i386                  randconfig-015-20250718    clang-20
i386                  randconfig-016-20250718    clang-20
i386                  randconfig-017-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             alldefconfig    clang-21
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250718    gcc-15.1.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
nios2                 randconfig-002-20250718    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    clang-21
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-001-20250718    gcc-15.1.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc                randconfig-002-20250718    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250718    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.5.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-002-20250718    gcc-15.1.0
powerpc               randconfig-003-20250718    clang-17
powerpc               randconfig-003-20250718    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-001-20250718    gcc-15.1.0
powerpc64             randconfig-002-20250718    clang-21
powerpc64             randconfig-002-20250718    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-001-20250718    gcc-15.1.0
riscv                 randconfig-002-20250718    clang-16
riscv                 randconfig-002-20250718    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-001-20250718    gcc-15.1.0
s390                  randconfig-002-20250718    clang-21
s390                  randconfig-002-20250718    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-002-20250718    gcc-15.1.0
sh                           se7722_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc                 randconfig-002-20250718    gcc-15.1.0
sparc                       sparc32_defconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-001-20250718    gcc-15.1.0
sparc64               randconfig-002-20250718    clang-20
sparc64               randconfig-002-20250718    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-001-20250718    gcc-15.1.0
um                    randconfig-002-20250718    gcc-12
um                    randconfig-002-20250718    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    clang-20
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250718    clang-20
x86_64                randconfig-002-20250718    clang-20
x86_64                randconfig-003-20250718    clang-20
x86_64                randconfig-004-20250718    clang-20
x86_64                randconfig-005-20250718    clang-20
x86_64                randconfig-006-20250718    clang-20
x86_64                randconfig-007-20250718    clang-20
x86_64                randconfig-008-20250718    clang-20
x86_64                randconfig-071-20250718    clang-20
x86_64                randconfig-072-20250718    clang-20
x86_64                randconfig-073-20250718    clang-20
x86_64                randconfig-074-20250718    clang-20
x86_64                randconfig-075-20250718    clang-20
x86_64                randconfig-076-20250718    clang-20
x86_64                randconfig-077-20250718    clang-20
x86_64                randconfig-078-20250718    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-8.5.0
xtensa                randconfig-002-20250718    gcc-12.5.0
xtensa                randconfig-002-20250718    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

