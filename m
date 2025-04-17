Return-Path: <linux-pci+bounces-26059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008EAA914AD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6319F1907259
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76564A98;
	Thu, 17 Apr 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uem/Ltwl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161421E4929
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873461; cv=none; b=r97Iw6qLMuThNEfCvqU8AsS9RmOR5u2GuZNKFkMce1VJeHUb7FDPVIt+MV3S33YoQveXzaxJchO5lrJtg7z8kW9P9NY1Ia3NH66rVZslmMMqfzScdPtq4aGLmjiDB2qIMvEtDfVkPxbrZRe+yCu07BFXznetTFQvgubqO6v/s30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873461; c=relaxed/simple;
	bh=DUdlsTQ2Nf6AugerH38CePEEpq6ljGZsK3z8iILt4H0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RVJDFqMNY2zU8Anbfy3Q5wB5CLAqR/43IeGYoY3VSsLLG4glykJ3ProR0dZEvhLUTlaGtZdOBUPnrQHhJgjLyYBMJOUFO//ccMfZsh06Dqu4ebDs7OmEUzf+GpuTBF3LUd2fb6ctiB0J6auMsqmms3c2MyBKA3iKZ2WbuuZmxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uem/Ltwl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744873460; x=1776409460;
  h=date:from:to:cc:subject:message-id;
  bh=DUdlsTQ2Nf6AugerH38CePEEpq6ljGZsK3z8iILt4H0=;
  b=Uem/LtwlvI4a8PrxoCr+SWlPV+VcM1niQ8EQeybDT1Fq+VkyyXO2jRmW
   sTW7xBg1AiOfW2kwFLwrFb0lOIRRslTb6buUKLMm/qEKEt+mr5zvP+nb+
   OnTjHNrM4MDWhLhVgU7CpH3hUeNAl6nvORxMECNfq7Fpz3rJBjLfxYjct
   Nfu03tndEOY1t7/Y9zxNQvl3O9l1lfCyW1Ef8rZGUzwOYKPxrE5BMi1FJ
   +TPUy1C6rVaPLd2xsNGJX6VNq53PnCOrDkDg6qK3utokVp9JCLwF/qVYR
   AxNpPo9fsL7C1v61cAfEc7AYxSW6hWcECklsJeG5x7501I5shjNC3PlFA
   w==;
X-CSE-ConnectionGUID: ycAWkMZrQtGrlrTlXimsrw==
X-CSE-MsgGUID: jy38kGQcSTuYczlzHjYbHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57830019"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="57830019"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 00:04:20 -0700
X-CSE-ConnectionGUID: u4/QWcy0S+yvdzBWg5lVXw==
X-CSE-MsgGUID: uQKdYoWaQC6feYrvGgsgdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="130578507"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2025 00:04:19 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5JIG-000Lgv-2M;
	Thu, 17 Apr 2025 07:04:16 +0000
Date: Thu, 17 Apr 2025 15:04:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 8b8ca73cb92b9e18c9e1716c5b55111069622566
Message-ID: <202504171507.nyn1wTvg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 8b8ca73cb92b9e18c9e1716c5b55111069622566  PCI: hotplug: Drop superfluous #include directives

elapsed time: 1454m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250416    gcc-12.4.0
arc                   randconfig-002-20250416    gcc-10.5.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250416    clang-17
arm                   randconfig-002-20250416    gcc-7.5.0
arm                   randconfig-003-20250416    clang-21
arm                   randconfig-004-20250416    clang-19
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250416    gcc-8.5.0
arm64                 randconfig-002-20250416    clang-21
arm64                 randconfig-003-20250416    gcc-6.5.0
arm64                 randconfig-004-20250416    gcc-8.5.0
csky                  randconfig-001-20250416    gcc-14.2.0
csky                  randconfig-002-20250416    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250416    clang-21
hexagon               randconfig-002-20250416    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250416    clang-20
i386        buildonly-randconfig-002-20250416    gcc-12
i386        buildonly-randconfig-003-20250416    gcc-12
i386        buildonly-randconfig-004-20250416    gcc-11
i386        buildonly-randconfig-005-20250416    clang-20
i386        buildonly-randconfig-006-20250416    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250416    gcc-14.2.0
loongarch             randconfig-002-20250416    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250416    gcc-6.5.0
nios2                 randconfig-002-20250416    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250416    gcc-11.5.0
parisc                randconfig-002-20250416    gcc-7.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250416    gcc-8.5.0
powerpc               randconfig-002-20250416    clang-21
powerpc               randconfig-003-20250416    clang-21
powerpc64             randconfig-001-20250416    clang-21
powerpc64             randconfig-002-20250416    clang-21
powerpc64             randconfig-003-20250416    gcc-6.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250416    clang-20
riscv                 randconfig-002-20250416    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250416    clang-21
s390                  randconfig-002-20250416    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250416    gcc-14.2.0
sh                    randconfig-002-20250416    gcc-6.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250416    gcc-11.5.0
sparc                 randconfig-002-20250416    gcc-11.5.0
sparc64               randconfig-001-20250416    gcc-5.5.0
sparc64               randconfig-002-20250416    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250416    clang-21
um                    randconfig-002-20250416    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250416    gcc-12
x86_64      buildonly-randconfig-002-20250416    gcc-12
x86_64      buildonly-randconfig-003-20250416    gcc-12
x86_64      buildonly-randconfig-004-20250416    clang-20
x86_64      buildonly-randconfig-005-20250416    clang-20
x86_64      buildonly-randconfig-006-20250416    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250416    gcc-7.5.0
xtensa                randconfig-002-20250416    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

