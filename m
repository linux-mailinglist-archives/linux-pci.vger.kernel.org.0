Return-Path: <linux-pci+bounces-23898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D996A6377D
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 22:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AD2169859
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B448189915;
	Sun, 16 Mar 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jttGMgve"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278B3D6F
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742159650; cv=none; b=LJs4bP9BGEvQ2E51Whg+Y8NoBcsETjge2tDU2KD6hPy8J3/EJigDLfa3chjpTZg7WK/tVZ9n/Xh/ThIGJlgJFpem4u7n+/Z2kQ+KMA8wdoGypV0ljjK1F83gU57BCK5dAcJoXQDvv9+rI17hQ3LnqirskoX4ViP2+5dLs4gV0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742159650; c=relaxed/simple;
	bh=hiDgk0yb7zRqdKNZpyk0dJJp50wNHKSt2fu0kROpTto=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uDh5mCdRErUgVESDt3hqgzMbRf9pvydO+6+nOSsqJMJ28HVwt3yiSIUk3Snk6TBxJoaD7W/P1mfihzVDXnJDnthbCISvHFPf+FT62tB0ehSvKeNcFo6qjdyeyLosGepuRqnuTuDnQieAbMLi4xhVEAiJts7JSzfmyqjJIttQejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jttGMgve; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742159649; x=1773695649;
  h=date:from:to:cc:subject:message-id;
  bh=hiDgk0yb7zRqdKNZpyk0dJJp50wNHKSt2fu0kROpTto=;
  b=jttGMgve3i5Cy/3yFjnThdl4eJFn9EiB9FkqNgCpXCR9ETL0zN1guRnN
   +QXM3ZfMTpoq73xHCjndNFwZdS3WVUphOvPtcrkcgowx3d32dMFIONJxt
   lvFBEymKTLxUCHbfaxCkqxlmYWiDGrj9rvYg8kNCdTbjtL06TxebMkPgw
   n0KCC2bUHM/erlRQWXutk78aJ3ZSe4L1d/qa9ctnGNtOodQcK1PYRQ9uG
   tb5VCsvAFIJ1IPblLt5b0PnAv2U5eXNW4aVyGqdhWBw83YmsYSf+DmLCP
   M6Z4VbDIFSw6x8rctufUPcerv7Y3TyB4aujjhbf1YbJS68rTSfL+TmTUZ
   A==;
X-CSE-ConnectionGUID: SDth1mZ4RGyeoxZEqdfoCQ==
X-CSE-MsgGUID: w8Rhco7TQj24jI/FySYYXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="60641570"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="60641570"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 14:14:08 -0700
X-CSE-ConnectionGUID: eohqh7L0Q1umJBm3i0LzQg==
X-CSE-MsgGUID: itzIHfgZSJO1MZsqYreEUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="121480312"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Mar 2025 14:14:07 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttvJ6-000CFU-2t;
	Sun, 16 Mar 2025 21:14:04 +0000
Date: Mon, 17 Mar 2025 05:13:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 df90ab163b755e94fe1604cbb758248e65b3a139
Message-ID: <202503170518.kv0KQK0u-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: df90ab163b755e94fe1604cbb758248e65b3a139  Merge branch 'pci/misc'

elapsed time: 1444m

configs tested: 129
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250316    gcc-13.2.0
arc                   randconfig-002-20250316    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250316    clang-15
arm                   randconfig-002-20250316    gcc-14.2.0
arm                   randconfig-003-20250316    gcc-14.2.0
arm                   randconfig-004-20250316    clang-21
arm                        realview_defconfig    clang-16
arm                        spear6xx_defconfig    clang-15
arm                        vexpress_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250316    clang-17
arm64                 randconfig-002-20250316    clang-19
arm64                 randconfig-003-20250316    clang-21
arm64                 randconfig-004-20250316    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250316    gcc-14.2.0
csky                  randconfig-002-20250316    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250316    clang-21
hexagon               randconfig-002-20250316    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250316    clang-19
i386        buildonly-randconfig-002-20250316    clang-19
i386        buildonly-randconfig-003-20250316    gcc-12
i386        buildonly-randconfig-004-20250316    clang-19
i386        buildonly-randconfig-005-20250316    clang-19
i386        buildonly-randconfig-006-20250316    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250316    gcc-14.2.0
loongarch             randconfig-002-20250316    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250316    gcc-14.2.0
nios2                 randconfig-002-20250316    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250316    gcc-14.2.0
parisc                randconfig-002-20250316    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20250316    gcc-14.2.0
powerpc               randconfig-002-20250316    gcc-14.2.0
powerpc               randconfig-003-20250316    clang-15
powerpc64             randconfig-001-20250316    clang-21
powerpc64             randconfig-002-20250316    clang-19
powerpc64             randconfig-003-20250316    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250316    clang-21
riscv                 randconfig-002-20250316    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250316    gcc-14.2.0
s390                  randconfig-002-20250316    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250316    gcc-14.2.0
sh                    randconfig-002-20250316    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250316    gcc-14.2.0
sparc                 randconfig-002-20250316    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250316    gcc-14.2.0
sparc64               randconfig-002-20250316    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250316    clang-21
um                    randconfig-002-20250316    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250316    gcc-12
x86_64      buildonly-randconfig-002-20250316    gcc-12
x86_64      buildonly-randconfig-003-20250316    clang-19
x86_64      buildonly-randconfig-004-20250316    clang-19
x86_64      buildonly-randconfig-005-20250316    gcc-12
x86_64      buildonly-randconfig-006-20250316    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250316    gcc-14.2.0
xtensa                randconfig-002-20250316    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

