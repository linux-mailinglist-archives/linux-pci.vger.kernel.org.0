Return-Path: <linux-pci+bounces-11018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C37940F5E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473A3B27771
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8843D19EEB1;
	Tue, 30 Jul 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDuDYUyN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE219E83B
	for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335257; cv=none; b=KwoowQGp5FNm0L43XIMK9VeD0pJDSxGEmcJaXisM7BP/nmamjgBkwIgtUkWNmv/7QbfH1KQ1xBRArTlYRtfhQHg7Iqt8B+QoC5PvT5pTcaEHoNTMb3usNrKUeDfK6NDXZgDMjT/MrJc3VvONV3Xz/f6uYV+R/+jbjNmjtNAT9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335257; c=relaxed/simple;
	bh=JCBbDMkREzVjLSNqD4R2A/XqNhmyZx9WvNazGwSsRs8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qzUIV7q0lSYjgu2q0KXaNnzkDMeSVnQOP3strMhvJySu9k9uQSa7Bj0t0eKgYXWrxSqQcoOQYkdX5nisH/5c0V1Wnuxf43IXAzCP6C5bEXLv2YxgwB2TwnfZK0Yc4NKSN1OYHNebWrNhd+hv6c2WqDRxaw8MLZk7Tllvo627kS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDuDYUyN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722335255; x=1753871255;
  h=date:from:to:cc:subject:message-id;
  bh=JCBbDMkREzVjLSNqD4R2A/XqNhmyZx9WvNazGwSsRs8=;
  b=GDuDYUyNkBF+Zneho5oEq+jO3qCv7BxxW5wW2XG2M6+eAzFgtHsgpZL9
   0iXwds/XxjzxWH+aLEy1629W0tnzaT94sleAawGjFggnZBW9yDXhyZy8T
   pLVCWhuV9GXxgcXvRMXH6gH9iJT/gq8yLeQj3HmsqKneUlafk688xPTPT
   Nz38ScQNeoC5HDfC5esmWAQQq26LvJmAUCHJ/4RFFylsVeoz03dKwJuNq
   E59Dl2TQ4jvMwYf6dlfmgFkz2yfaBMww+B+aHGsvn4JWkA0ZgGHeFY8SE
   QuA02aG05mNBE0PHs0xLOa/T4kohpz/L7EHVjizDkLfTnUJdNkkk47Pcn
   g==;
X-CSE-ConnectionGUID: apNE78xKQZS5oCCQASynqQ==
X-CSE-MsgGUID: uWutJPa1RJeK/jqwK4Vmyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20091048"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20091048"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 03:27:34 -0700
X-CSE-ConnectionGUID: t6tGGLwGSm6UhxUJHZW38w==
X-CSE-MsgGUID: OtgVui2DQseYz+XidPTtjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54196696"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2024 03:27:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYk4p-000skv-0d;
	Tue, 30 Jul 2024 10:27:31 +0000
Date: Tue, 30 Jul 2024 18:26:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 1db36ff41ea54adaa12241c70f38bfbe4b379519
Message-ID: <202407301836.cUx1WVmM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 1db36ff41ea54adaa12241c70f38bfbe4b379519  PCI: pciehp: Retain Power Indicator bits for userspace indicators

elapsed time: 971m

configs tested: 208
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240730   gcc-13.2.0
arc                   randconfig-002-20240730   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-13.2.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-14.1.0
arm                   randconfig-002-20240730   gcc-13.2.0
arm                   randconfig-002-20240730   gcc-14.1.0
arm                   randconfig-003-20240730   gcc-13.2.0
arm                   randconfig-003-20240730   gcc-14.1.0
arm                   randconfig-004-20240730   gcc-13.2.0
arm                   randconfig-004-20240730   gcc-14.1.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-14.1.0
arm64                 randconfig-002-20240730   clang-20
arm64                 randconfig-002-20240730   gcc-13.2.0
arm64                 randconfig-003-20240730   clang-20
arm64                 randconfig-003-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-14.1.0
csky                  randconfig-002-20240730   gcc-13.2.0
csky                  randconfig-002-20240730   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240730   clang-20
hexagon               randconfig-002-20240730   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240730   clang-18
i386         buildonly-randconfig-004-20240730   clang-18
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240730   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240730   gcc-8
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240730   gcc-10
i386                  randconfig-006-20240730   gcc-10
i386                  randconfig-011-20240730   gcc-11
i386                  randconfig-012-20240730   clang-18
i386                  randconfig-013-20240730   clang-18
i386                  randconfig-014-20240730   gcc-9
i386                  randconfig-015-20240730   gcc-9
i386                  randconfig-016-20240730   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-14.1.0
loongarch             randconfig-002-20240730   gcc-13.2.0
loongarch             randconfig-002-20240730   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-14.1.0
nios2                 randconfig-002-20240730   gcc-13.2.0
nios2                 randconfig-002-20240730   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240730   gcc-13.2.0
parisc                randconfig-001-20240730   gcc-14.1.0
parisc                randconfig-002-20240730   gcc-13.2.0
parisc                randconfig-002-20240730   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc               randconfig-002-20240730   clang-16
powerpc               randconfig-002-20240730   gcc-13.2.0
powerpc               randconfig-003-20240730   clang-20
powerpc               randconfig-003-20240730   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240730   gcc-13.2.0
powerpc64             randconfig-001-20240730   gcc-14.1.0
powerpc64             randconfig-002-20240730   clang-20
powerpc64             randconfig-002-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240730   clang-14
riscv                 randconfig-001-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240730   gcc-13.2.0
s390                  randconfig-001-20240730   gcc-14.1.0
s390                  randconfig-002-20240730   clang-20
s390                  randconfig-002-20240730   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-14.1.0
sh                    randconfig-002-20240730   gcc-13.2.0
sh                    randconfig-002-20240730   gcc-14.1.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240730   gcc-13.2.0
sparc64               randconfig-001-20240730   gcc-14.1.0
sparc64               randconfig-002-20240730   gcc-13.2.0
sparc64               randconfig-002-20240730   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240730   gcc-13
um                    randconfig-001-20240730   gcc-13.2.0
um                    randconfig-002-20240730   clang-20
um                    randconfig-002-20240730   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240730   clang-18
x86_64       buildonly-randconfig-002-20240730   clang-18
x86_64       buildonly-randconfig-003-20240730   clang-18
x86_64       buildonly-randconfig-004-20240730   clang-18
x86_64       buildonly-randconfig-005-20240730   clang-18
x86_64       buildonly-randconfig-006-20240730   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240730   clang-18
x86_64                randconfig-002-20240730   clang-18
x86_64                randconfig-003-20240730   clang-18
x86_64                randconfig-004-20240730   clang-18
x86_64                randconfig-005-20240730   clang-18
x86_64                randconfig-006-20240730   clang-18
x86_64                randconfig-011-20240730   clang-18
x86_64                randconfig-012-20240730   clang-18
x86_64                randconfig-013-20240730   clang-18
x86_64                randconfig-014-20240730   clang-18
x86_64                randconfig-015-20240730   clang-18
x86_64                randconfig-016-20240730   clang-18
x86_64                randconfig-071-20240730   clang-18
x86_64                randconfig-072-20240730   clang-18
x86_64                randconfig-073-20240730   clang-18
x86_64                randconfig-074-20240730   clang-18
x86_64                randconfig-075-20240730   clang-18
x86_64                randconfig-076-20240730   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240730   gcc-13.2.0
xtensa                randconfig-001-20240730   gcc-14.1.0
xtensa                randconfig-002-20240730   gcc-13.2.0
xtensa                randconfig-002-20240730   gcc-14.1.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

