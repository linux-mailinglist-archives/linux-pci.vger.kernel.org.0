Return-Path: <linux-pci+bounces-32858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03035B0FD87
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 01:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766D7AA5C48
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A655207E03;
	Wed, 23 Jul 2025 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUoB4xUI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840926D4E8
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313196; cv=none; b=Xvh8m/U8QLADdWHIwzpbuoSZDx59rAqwDKeIxaqdiRcEa38AVgBvPJCgCsDSkuSlmMZKXKXzpqEXg8f1nohYa0i/ByjXoHjgt3m+37pqsU+e5FNgR9oSLLUHCM8Ec6jJpo2dILFw9UvRKijWSqbNf7kDoOWrAdAbdq5Zha2CNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313196; c=relaxed/simple;
	bh=9m/2PIwvMlkSyQYYxdYAVl/4s52lGRHVXYBWN6ncTIw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f3M08WJNfdfm/xTQiCkYCVRP/qlCraC4sQ6vU5iR8/m4WTJqmKljoVomwm7jnaiYC0ds/FtMAZWG0gzDLEI4vgFGfbcLl1vsVennHUCxluBpBEtHx8LzdT9kVo2YL7B6UZO3fHUOC9R0y7J9HAYj+KIwhyGPVWNSBAqEmTRTKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUoB4xUI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753313195; x=1784849195;
  h=date:from:to:cc:subject:message-id;
  bh=9m/2PIwvMlkSyQYYxdYAVl/4s52lGRHVXYBWN6ncTIw=;
  b=KUoB4xUI+rrj6eb7ixuDP2L7PjIp+EaRiOqwjPemKr/yyAMqi5mqhaff
   aM1DcwlQNPIQHl+3yTnw4j1SBPJTiH02biYatOtQgcsxYU//ZsemtAFkN
   U1YH6KUSF96DSV0IR169c4erR/+iko5vhM+JooreJJK1Zn1ENe3nkdsni
   RTRm6r/VDLsXu8dh2BdEV+IdZvhy2/KGeauM1+kqYi4Pu9QoGxNt3f9OS
   QYOGIBM5CeDT5nOfGMzWSIGwdahSmkKtucoy1aRjnqziV2x+PX5lsUpzv
   +MJWBhQX7SzVDZAGJYnc2WuyMVpk3Kd9qBtHcsynIbnhJsVlhVnRZaXq+
   w==;
X-CSE-ConnectionGUID: w6GE32B0QGO1mn2uuxpG/g==
X-CSE-MsgGUID: yu0IOeuRSF+Ye0Qmdyg8uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43228840"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="43228840"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 16:26:34 -0700
X-CSE-ConnectionGUID: U9Ei7aUUTwmoY9I23c1jGQ==
X-CSE-MsgGUID: qAoybAehSfOYEf5pWWhawA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="196924819"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jul 2025 16:26:34 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueir0-000Jsp-2u;
	Wed, 23 Jul 2025 23:26:30 +0000
Date: Thu, 24 Jul 2025 07:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 5c0d0ee36f168f6962a710205436533be31c9a42
Message-ID: <202507240758.6iKdTA48-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 5c0d0ee36f168f6962a710205436533be31c9a42  PCI: Support Immediate Readiness on devices without PM capabilities

elapsed time: 1449m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-002-20250723    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-004-20250723    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250723    clang-22
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-004-20250723    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-002-20250723    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-002-20250723    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-006-20250723    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-002-20250723    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       holly_defconfig    clang-22
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-003-20250723    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-002-20250723    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-002-20250723    clang-20
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-002-20250723    gcc-9.5.0
sh                           se7705_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-002-20250723    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250723    gcc-12
um                    randconfig-002-20250723    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-002-20250723    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

