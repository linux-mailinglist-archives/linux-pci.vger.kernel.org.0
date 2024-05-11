Return-Path: <linux-pci+bounces-7383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB4E8C33B2
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7CC1F21626
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8291F94D;
	Sat, 11 May 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPvOGcq/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCE1CD00
	for <linux-pci@vger.kernel.org>; Sat, 11 May 2024 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715458228; cv=none; b=fTeKKxIyEFre70YLz67dC1gIv9Vov+83sVX9FZWIXvitHt/Ruku8XTylcVaOyooJHBCxHJ4w1OsXg8MRgtgbEwqrKLkXj0DJs3gIfKEYeytYoI43wpZaxUejE+KVAx0fCzXSabfmpJ0+G8nMH+ZH943Fbe7UXGoPYgJatGnYLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715458228; c=relaxed/simple;
	bh=f6xPE8pw79wP5+ikymvKG/l4szTZYhsJNpN5YMKyiEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KUaZZbiIhArQ4ZPXBuCJW5ksA3M5m6RzzukHd066wXDPUihlV2VzdySUEtUOylzaErI8o/WhJHv8Ec9KtTo2Plc1vua4NmpCq9UMnrGupi4Ghwsj0gTQ+FeyXkrfdaAPuwETaxgSZVqdF4EdZy9NSK0gLdYtNnDU9Q33E1Bs7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPvOGcq/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715458226; x=1746994226;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f6xPE8pw79wP5+ikymvKG/l4szTZYhsJNpN5YMKyiEE=;
  b=DPvOGcq/V6a+fHA7qZpsScmvi9CIyJkh9UDakxtF1L4SBotImNS2zQXa
   lbDfAohCaMw+QuPB5QKe1NlAU4eKFNaKf6DZLt3igsAri6QOqB0uEOuD+
   nrdJe8Jx7SbWK9vBAq/pG22a9k0pu+YcQncGi4D9jiefowU9fMSM4IFhM
   uredbxsU+sfUNiAnmQmzSULW6iAhsR4aI58bIDmh+FALisOqh5RgZkZES
   ra9DgfUtxvJo1PyhW9oRadC2JYOjQofABIUdlkTfUIG58gLZuoCwwcYIG
   DpJdWc8Tx6y/1ZOUl3IHnWzTscWkZ6FCGOAExnaYGn5AZcoBV77u0Zn1T
   g==;
X-CSE-ConnectionGUID: C5hxXKxWQp+L8MavbX1ylg==
X-CSE-MsgGUID: AEo/AQgfSUqyc77udLWiWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="22104976"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="22104976"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 13:10:24 -0700
X-CSE-ConnectionGUID: pYiN2d82TdCL99DNlsj4GA==
X-CSE-MsgGUID: 8QYBDxqYS9Cd+WiqE0xecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="67447924"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 May 2024 13:10:23 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5t2y-0007nT-0j;
	Sat, 11 May 2024 20:10:20 +0000
Date: Sun, 12 May 2024 04:09:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:acs] BUILD SUCCESS
 694b705cdbf7d0555e0b7b9ff71f534232e4af74
Message-ID: <202405120429.AFBnIJBT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git acs
branch HEAD: 694b705cdbf7d0555e0b7b9ff71f534232e4af74  PCI: Add ACS quirk for Broadcom BCM5760X NIC

elapsed time: 953m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240511   gcc  
arc                   randconfig-002-20240511   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240511   clang
arm                   randconfig-002-20240511   clang
arm                   randconfig-003-20240511   gcc  
arm                   randconfig-004-20240511   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240511   gcc  
arm64                 randconfig-002-20240511   clang
arm64                 randconfig-003-20240511   gcc  
arm64                 randconfig-004-20240511   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240511   gcc  
csky                  randconfig-002-20240511   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240511   clang
hexagon               randconfig-002-20240511   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240511   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240511   clang
i386         buildonly-randconfig-003-20240511   gcc  
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240511   clang
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240511   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240511   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240511   gcc  
i386                  randconfig-002-20240511   clang
i386                  randconfig-003-20240511   gcc  
i386                  randconfig-004-20240511   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240511   gcc  
i386                  randconfig-006-20240511   gcc  
i386                  randconfig-011-20240511   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240511   gcc  
i386                  randconfig-013-20240511   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240511   clang
i386                  randconfig-015-20240511   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240511   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240511   gcc  
loongarch             randconfig-002-20240511   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240511   gcc  
nios2                 randconfig-002-20240511   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240511   gcc  
parisc                randconfig-002-20240511   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240511   gcc  
powerpc               randconfig-002-20240511   clang
powerpc               randconfig-003-20240511   gcc  
powerpc                     sequoia_defconfig   clang
powerpc64             randconfig-001-20240511   gcc  
powerpc64             randconfig-002-20240511   gcc  
powerpc64             randconfig-003-20240511   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240511   gcc  
riscv                 randconfig-002-20240511   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240511   clang
s390                  randconfig-002-20240511   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240511   gcc  
sh                    randconfig-002-20240511   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240511   gcc  
sparc64               randconfig-002-20240511   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240511   gcc  
um                    randconfig-002-20240511   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240511   gcc  
x86_64       buildonly-randconfig-002-20240511   gcc  
x86_64       buildonly-randconfig-003-20240511   gcc  
x86_64       buildonly-randconfig-004-20240511   gcc  
x86_64       buildonly-randconfig-005-20240511   clang
x86_64       buildonly-randconfig-006-20240511   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240511   clang
x86_64                randconfig-002-20240511   clang
x86_64                randconfig-003-20240511   clang
x86_64                randconfig-004-20240511   gcc  
x86_64                randconfig-005-20240511   gcc  
x86_64                randconfig-006-20240511   clang
x86_64                randconfig-011-20240511   clang
x86_64                randconfig-012-20240511   gcc  
x86_64                randconfig-013-20240511   gcc  
x86_64                randconfig-014-20240511   gcc  
x86_64                randconfig-015-20240511   gcc  
x86_64                randconfig-016-20240511   gcc  
x86_64                randconfig-071-20240511   gcc  
x86_64                randconfig-072-20240511   gcc  
x86_64                randconfig-073-20240511   clang
x86_64                randconfig-074-20240511   gcc  
x86_64                randconfig-075-20240511   gcc  
x86_64                randconfig-076-20240511   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240511   gcc  
xtensa                randconfig-002-20240511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

