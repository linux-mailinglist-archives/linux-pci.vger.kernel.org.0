Return-Path: <linux-pci+bounces-28225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362DBABFA32
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9A17F055
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378F14A4E0;
	Wed, 21 May 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNZ2qXMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D21993B7
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842559; cv=none; b=dFtAd4E25c6LpY5AfeIjf09Sh13yWbHj0Foaot7HcyWLKFRqGhzgUQnpWgEUg2PA1j6dXJCl2lVjaG/k0fMWdLoGGtUGUdSEZDfAqL/l8xQd3fN1SaBxnXGfdBIAu3PkeY+FT5oq/yyweKuw+zzdpQvXiyWQ+jEBlozWhILYkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842559; c=relaxed/simple;
	bh=iNuYa6lww05xVnt4tl6Dtv6CEMsSUukx4nZtNGrqemI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BHYAlzAlxSeg3Hc9p8Hw3AtMBJyv1wp2VadeC2NlkUC3hJk0PVncYX5nd9oLtYk4kQOycOfZqeWvaMNB8Q/BydERmrkpB3dy84OgEzPjmiYph9+43IS5dw3iFBFkl3leMSr6hUAWSsh7uTD7feHYPXCR5L+9LIv+E25Cv26AZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNZ2qXMk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747842557; x=1779378557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iNuYa6lww05xVnt4tl6Dtv6CEMsSUukx4nZtNGrqemI=;
  b=JNZ2qXMk7x0C7V8Tuw21+6q+oVLXCs1wO4Xn/WqWnhvBc6BRMG6lSkdL
   SoejrO8RVha1+W6NemrpKi/mQign6VAOjHQIileXkGXlzyFVl9afaLgGx
   ZqWstBe9U7vEmQ4BJAvNWHJbT+fx5Ae7BUb9JJu/SQEwhNyzZXMJGsbYE
   DTNUrCeH0NZKLrsp1tk6ffA8zSFK7KdpQnA3SnvbDollUanqfILemrLMd
   HRA7XXXgrbHFwQWbJYJQyyam5oyvw1jEfg0563YxrPMFwKQu7R4PbD3CG
   CZvCXmtacLXn5lYNo3zYav0yFkMYB/qtNyCQEupt6MQIiXC3dKDXaYXsa
   w==;
X-CSE-ConnectionGUID: bueJneUXR/+AnfVdJ3B7ig==
X-CSE-MsgGUID: jD36p2cvT5G/bqcfsTW0cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49087770"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49087770"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:49:16 -0700
X-CSE-ConnectionGUID: 2WQcPWuZTHmoMK0GWYtfJQ==
X-CSE-MsgGUID: P7NKTx1xQzebvEkwQp9UOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140542369"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 May 2025 08:49:15 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHlgv-000OPQ-04;
	Wed, 21 May 2025 15:49:13 +0000
Date: Wed, 21 May 2025 23:49:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 607a1db09f96ba2f9f775147588ef9423003e9b4
Message-ID: <202505212356.Qv7rASay-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 607a1db09f96ba2f9f775147588ef9423003e9b4  PCI: Unnecessary linesplit in __pci_setup_bridge()

elapsed time: 1419m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250521    gcc-10.5.0
arc                   randconfig-002-20250521    gcc-12.4.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-21
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20250521    clang-21
arm                   randconfig-002-20250521    clang-21
arm                   randconfig-003-20250521    clang-16
arm                   randconfig-004-20250521    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250521    gcc-6.5.0
arm64                 randconfig-002-20250521    gcc-6.5.0
arm64                 randconfig-003-20250521    gcc-8.5.0
arm64                 randconfig-004-20250521    gcc-8.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250521    gcc-10.5.0
csky                  randconfig-002-20250521    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250521    clang-20
hexagon               randconfig-002-20250521    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250521    clang-20
i386        buildonly-randconfig-002-20250521    clang-20
i386        buildonly-randconfig-003-20250521    gcc-12
i386        buildonly-randconfig-004-20250521    clang-20
i386        buildonly-randconfig-005-20250521    gcc-12
i386        buildonly-randconfig-006-20250521    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250521    gcc-15.1.0
loongarch             randconfig-002-20250521    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250521    gcc-14.2.0
nios2                 randconfig-002-20250521    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250521    gcc-13.3.0
parisc                randconfig-002-20250521    gcc-11.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 canyonlands_defconfig    clang-21
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc                  mpc885_ads_defconfig    clang-21
powerpc                      ppc44x_defconfig    clang-21
powerpc               randconfig-001-20250521    clang-21
powerpc               randconfig-002-20250521    gcc-8.5.0
powerpc               randconfig-003-20250521    gcc-6.5.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250521    gcc-8.5.0
powerpc64             randconfig-002-20250521    gcc-6.5.0
powerpc64             randconfig-003-20250521    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250521    gcc-8.5.0
riscv                 randconfig-002-20250521    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                  randconfig-001-20250521    clang-20
s390                  randconfig-002-20250521    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250521    gcc-12.4.0
sh                    randconfig-002-20250521    gcc-15.1.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250521    gcc-13.3.0
sparc                 randconfig-002-20250521    gcc-13.3.0
sparc64               randconfig-001-20250521    gcc-13.3.0
sparc64               randconfig-002-20250521    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250521    clang-21
um                    randconfig-002-20250521    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250521    clang-20
x86_64      buildonly-randconfig-002-20250521    clang-20
x86_64      buildonly-randconfig-003-20250521    gcc-12
x86_64      buildonly-randconfig-004-20250521    gcc-12
x86_64      buildonly-randconfig-005-20250521    clang-20
x86_64      buildonly-randconfig-006-20250521    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250521    gcc-15.1.0
xtensa                randconfig-002-20250521    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

