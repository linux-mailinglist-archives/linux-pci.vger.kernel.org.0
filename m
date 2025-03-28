Return-Path: <linux-pci+bounces-24966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4097A750C5
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 20:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D175172349
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80B1A83E5;
	Fri, 28 Mar 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikLPF71v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290B126C02
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190220; cv=none; b=YwRYbe9bFNrgMxjOnY77ZaabvZJwt1Gofx2kjtmUBzbTvo+7S9CCBNZFTfFDpKaVXA5Fej3GrSHvESo3YV2E1LAjCU4y546W+GYHEgq1vAEavprWvzm5RacvVODLU2NW+ctHMI8q/oQ6pZMTwgpqfZB1yukysOXgk2fQD14UZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190220; c=relaxed/simple;
	bh=Mk6k5vCGd/+10ruMiaE3vpBQN+6l4hPGcBhYYjkgGoE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tJfGPi2YNTQ/1IAxb789l0WhpCVYF08nfWGwdjUIErQ4uJhwyG/T0kcfOjNjMw2Hl5ircdZzYvneaPO9dHy8fXYHEPsBSdTVshFsNlE7hpo5EZPzKoFDuPN9ELAr+l3V74V92CB7Scvwa1vB4WYUjDbGNbg+JEIL0HIIV8iCLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikLPF71v; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743190215; x=1774726215;
  h=date:from:to:cc:subject:message-id;
  bh=Mk6k5vCGd/+10ruMiaE3vpBQN+6l4hPGcBhYYjkgGoE=;
  b=ikLPF71vo7Ge8AXYW9Ofgw4MnmfonB8VM+WO9wBDsvYKRCPqWoUjipzB
   AD1JLPZO2bImpMlbodtPWBiM0yJA5l+biWvzla4Kg3p5lPF2UyqrufUvQ
   ox7sOUdr0oxhxz24dpMi8v7irWUmUf3lPToeKegVbqJpe1VcRKYoOwGG4
   4IYQ07WCwrjc3H7hS3rBQj0keaUZ34qzny+5VHYf5FnZZom9M8Szrr2Nl
   fgKMwqvwwI8As9lMNsVatApBlyMaffC3SxOEqgkIy17+ChTtffUHiyIUw
   Nt/GoG1UOPZv/F5w0F2zwt2VC9ceYluE5BM/12DVdIracP2l5ipKEckDQ
   w==;
X-CSE-ConnectionGUID: ecuDEzamRCqX3FA6bAFCfw==
X-CSE-MsgGUID: D4U8DgvHR+mTN8w3ImooGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="43721409"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="43721409"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 12:30:14 -0700
X-CSE-ConnectionGUID: EWyqC+mUQCK6zK4XX7yZhQ==
X-CSE-MsgGUID: 4b3uFMbMRo2s296DVPq3Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="126341857"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 Mar 2025 12:30:13 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tyFP9-0007f0-0N;
	Fri, 28 Mar 2025 19:30:11 +0000
Date: Sat, 29 Mar 2025 03:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/layerscape] BUILD SUCCESS
 4c8c0ffd41d16cf08ccb0d3626beb54adfe5450a
Message-ID: <202503290335.DkSuU2Ap-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/layerscape
branch HEAD: 4c8c0ffd41d16cf08ccb0d3626beb54adfe5450a  PCI: layerscape: Fix arg_count to syscon_regmap_lookup_by_phandle_args()

elapsed time: 1445m

configs tested: 128
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250328    gcc-12.4.0
arc                   randconfig-002-20250328    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-21
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20250328    clang-18
arm                   randconfig-002-20250328    gcc-8.5.0
arm                   randconfig-003-20250328    clang-18
arm                   randconfig-004-20250328    gcc-8.5.0
arm                           sama7_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250328    gcc-8.5.0
arm64                 randconfig-002-20250328    clang-15
arm64                 randconfig-003-20250328    clang-16
arm64                 randconfig-004-20250328    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250328    gcc-12.4.0
csky                  randconfig-002-20250328    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250328    clang-21
hexagon               randconfig-002-20250328    clang-14
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250328    gcc-12
i386        buildonly-randconfig-002-20250328    gcc-12
i386        buildonly-randconfig-003-20250328    clang-20
i386        buildonly-randconfig-004-20250328    gcc-12
i386        buildonly-randconfig-005-20250328    clang-20
i386        buildonly-randconfig-006-20250328    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250328    gcc-14.2.0
loongarch             randconfig-002-20250328    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250328    gcc-6.5.0
nios2                 randconfig-002-20250328    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250328    gcc-9.3.0
parisc                randconfig-002-20250328    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                       eiger_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250328    clang-21
powerpc               randconfig-002-20250328    clang-21
powerpc               randconfig-003-20250328    clang-21
powerpc64             randconfig-001-20250328    clang-16
powerpc64             randconfig-002-20250328    clang-21
powerpc64             randconfig-003-20250328    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250328    gcc-8.5.0
riscv                 randconfig-002-20250328    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250328    gcc-6.5.0
s390                  randconfig-002-20250328    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250328    gcc-10.5.0
sh                    randconfig-002-20250328    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250328    gcc-13.3.0
sparc                 randconfig-002-20250328    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250328    gcc-11.5.0
sparc64               randconfig-002-20250328    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250328    clang-17
um                    randconfig-002-20250328    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250328    clang-20
x86_64      buildonly-randconfig-002-20250328    clang-20
x86_64      buildonly-randconfig-003-20250328    clang-20
x86_64      buildonly-randconfig-004-20250328    clang-20
x86_64      buildonly-randconfig-005-20250328    clang-20
x86_64      buildonly-randconfig-006-20250328    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250328    gcc-9.3.0
xtensa                randconfig-002-20250328    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

