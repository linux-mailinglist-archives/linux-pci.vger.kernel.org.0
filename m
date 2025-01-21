Return-Path: <linux-pci+bounces-20180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF9A179D7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 10:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2388416567B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA61B87C2;
	Tue, 21 Jan 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8hJrysI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5242CAB
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450636; cv=none; b=JWFVMzRyNg9Ea3aSDyhFa6cPYFTqcpnBF9sZwjFyMrCXl7ADWky88pDdJm5JiT/974sG/XmP69gOcDMWZ1vPVHH99xlvbmiluYAGSGyFHEWGoRoWApe0uydIGdqjc6NuA+3KUjumWGhq4TEYY74fNqSxdTuvJysKykT0aaDGpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450636; c=relaxed/simple;
	bh=K5T7b3eRbFvAok5Z08Rs50pfAaNQrf2j18kDL2o2udg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LJIN/CAo35UIo7Iss5mxkjuAuQNZNJ/mBUvXTITvfRz6vlbKN4ZUpK3MQwnjTlcrE9lNAHGABkNBiK1hTqVJ7hcZZrvqQSKNRQANS4tTmJuIjrlAtqPUjZ+RVpl9LIbLWb3ZP9cSG+5mdJwjZ98W6kpNse0AuMrkRSQAKv904H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8hJrysI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737450634; x=1768986634;
  h=date:from:to:cc:subject:message-id;
  bh=K5T7b3eRbFvAok5Z08Rs50pfAaNQrf2j18kDL2o2udg=;
  b=Q8hJrysIsBwjsdcAwU2Rr0KDWlE3MCNgQjBF14k3k0mCFa9o97JVBWk/
   wo6xfCAUw8yQA/oNbXpM3LpuqcJMPNXmPMtGqmdc1NKjNTO3yRA93uCde
   /9WVLCLMU/+jbpTGROM6vPsngVvDF5SXh4k0QAboII4KM5SsophgOnYSn
   KeeGW0fCdGFc8VNkL6rOSz492JpJ8HlSw7IxujqF8pizEGcBapEtOyaUl
   ZXYe2CDCiQ9JV/LpxKrWMhLoLwmfDvbKVPCZXa4snlmwE86GoOJe9OfAz
   CJPTiIPdGwg4onOJgXgXoCQ0+JijBFKts9EuA0wQMjpSqO8tnc/xlKgHl
   w==;
X-CSE-ConnectionGUID: fuXp+bDuQsahmyESSTdZmA==
X-CSE-MsgGUID: wP9dfKuYSRCnH6kjKWwPoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="49249729"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="49249729"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 01:10:33 -0800
X-CSE-ConnectionGUID: Wkr1wL7ZS46yr9w6h9CrPg==
X-CSE-MsgGUID: gV7Fla/IT36kC5CSvWo5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="106863501"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Jan 2025 01:10:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taAHG-000XsJ-1l;
	Tue, 21 Jan 2025 09:10:30 +0000
Date: Tue, 21 Jan 2025 17:10:25 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 1108d677dae296d2f05664bc71fd1d50bd61eb1f
Message-ID: <202501211719.WWW4qCCW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 1108d677dae296d2f05664bc71fd1d50bd61eb1f  PCI: dwc: Simplify config resource lookup

elapsed time: 828m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250121    gcc-13.2.0
arc                   randconfig-002-20250121    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250121    clang-18
arm                   randconfig-002-20250121    gcc-14.2.0
arm                   randconfig-003-20250121    gcc-14.2.0
arm                   randconfig-004-20250121    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250121    gcc-14.2.0
arm64                 randconfig-002-20250121    gcc-14.2.0
arm64                 randconfig-003-20250121    gcc-14.2.0
arm64                 randconfig-004-20250121    clang-18
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250121    gcc-14.2.0
csky                  randconfig-002-20250121    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250121    clang-19
hexagon               randconfig-002-20250121    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250121    gcc-12
i386        buildonly-randconfig-002-20250121    clang-19
i386        buildonly-randconfig-003-20250121    gcc-12
i386        buildonly-randconfig-004-20250121    gcc-12
i386        buildonly-randconfig-005-20250121    gcc-12
i386        buildonly-randconfig-006-20250121    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250121    gcc-14.2.0
loongarch             randconfig-002-20250121    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250121    gcc-14.2.0
nios2                 randconfig-002-20250121    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250121    gcc-14.2.0
parisc                randconfig-002-20250121    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250121    clang-20
powerpc               randconfig-002-20250121    gcc-14.2.0
powerpc               randconfig-003-20250121    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250121    gcc-14.2.0
powerpc64             randconfig-002-20250121    clang-20
powerpc64             randconfig-003-20250121    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250121    gcc-14.2.0
riscv                 randconfig-002-20250121    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250121    clang-15
s390                  randconfig-002-20250121    gcc-14.2.0
s390                       zfcpdump_defconfig    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250121    gcc-14.2.0
sh                    randconfig-002-20250121    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250121    gcc-14.2.0
sparc                 randconfig-002-20250121    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250121    gcc-14.2.0
sparc64               randconfig-002-20250121    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250121    clang-16
um                    randconfig-002-20250121    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250121    gcc-12
x86_64      buildonly-randconfig-002-20250121    clang-19
x86_64      buildonly-randconfig-003-20250121    gcc-12
x86_64      buildonly-randconfig-004-20250121    clang-19
x86_64      buildonly-randconfig-005-20250121    clang-19
x86_64      buildonly-randconfig-006-20250121    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250121    gcc-14.2.0
xtensa                randconfig-002-20250121    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

