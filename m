Return-Path: <linux-pci+bounces-8505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8103890195C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 04:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DFC1C20DA0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 02:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189315A8;
	Mon, 10 Jun 2024 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+9W44ZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183337B
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717986447; cv=none; b=mePqmVGoF10qoW6LqtOvb48ZSTg1joCgsTLfaxZCCAzEzu5NXzRDybBPdUXZxrwdNXptrEPAaMKSmmzrrdj3yhJZbqENURUFzqT7CmXRpIg7/Bb39gkNjrdikZ7BhFPOPZWe80taFEs7+S6sjeT2J2pU7jNGJZPh9SL0t7+6lgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717986447; c=relaxed/simple;
	bh=OpWI7sQhTC9m6ZJ2EOgjH/e/EhT5dnxPha9AUVYZK30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=r7CJc+05Q51VY/ZJ0jhiiuxM3daiG9SFXepVnn+emum2PbZ7m88jD2LOc3I7gTXVLeLRRqS4hlx1zREj7XeaqalcKzomw/GmDzqggr9AZCpNL7mYiiVFrbAp5yZoYfivDi69e1j0lFFnrq/TPAHsJilkLwUfe8Jf9W2Sw/J4wLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+9W44ZO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717986446; x=1749522446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OpWI7sQhTC9m6ZJ2EOgjH/e/EhT5dnxPha9AUVYZK30=;
  b=l+9W44ZOQO6K2q/uuOfJqga3jDV9NcHH6/6Ltc0gXAJ+6iq1s8F3zBE3
   O+my70RO1tsvQ0UqJSW4PxSd8GQNbVFteDkySDCerAvIEeZFBIOElx4BV
   Be6QI/f5+EeCtkOX1pkqfeBUgXTVOugwvFBs3rXmOE4Suq9rVAqyagxZg
   fkP/THYsdr1XvZsyRioifZOTOEa3/CLZ9dkWCC9UXUHXUTyT1iH+LASmm
   /gFRuaQv/fT7gIO9fu2XVTSn0R6CHIhwT8niNgpJag1kFzgixlWBgskTV
   eygYRdmkYcpiIoUBUSZxwkn/EDHOiHTlHvVALqkk6+6jKrKXbp3SWLJf8
   A==;
X-CSE-ConnectionGUID: e32doe+RRou+4hdLsX/F7g==
X-CSE-MsgGUID: YPAtM+YuTDmH6tjhgKAhYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="32124491"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="32124491"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 19:27:25 -0700
X-CSE-ConnectionGUID: lGS7XugRQS2a2N3xGerj0Q==
X-CSE-MsgGUID: 77cxeunTRqKERZwryqsZtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="39000288"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Jun 2024 19:27:24 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGUkj-0001m3-1z;
	Mon, 10 Jun 2024 02:27:21 +0000
Date: Mon, 10 Jun 2024 10:27:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/sysfs-static-resource-attributes] BUILD
 SUCCESS 021f1d8bdbda9eb3e4859df9e8ad27f96729c288
Message-ID: <202406101058.5iOUWzRi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/sysfs-static-resource-attributes
branch HEAD: 021f1d8bdbda9eb3e4859df9e8ad27f96729c288  PCI: Convert dynamic PCI resources sysfs objects into static

elapsed time: 1327m

configs tested: 188
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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240610   gcc  
arc                   randconfig-002-20240610   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240610   gcc  
arm                   randconfig-002-20240610   gcc  
arm                   randconfig-003-20240610   clang
arm                   randconfig-004-20240610   gcc  
arm                         s5pv210_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240610   gcc  
arm64                 randconfig-002-20240610   gcc  
arm64                 randconfig-003-20240610   gcc  
arm64                 randconfig-004-20240610   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240610   gcc  
csky                  randconfig-002-20240610   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240610   clang
hexagon               randconfig-002-20240610   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240609   gcc  
i386         buildonly-randconfig-001-20240610   clang
i386         buildonly-randconfig-002-20240609   gcc  
i386         buildonly-randconfig-003-20240609   gcc  
i386         buildonly-randconfig-004-20240609   gcc  
i386         buildonly-randconfig-004-20240610   clang
i386         buildonly-randconfig-005-20240609   clang
i386         buildonly-randconfig-006-20240609   gcc  
i386         buildonly-randconfig-006-20240610   clang
i386                                defconfig   clang
i386                  randconfig-001-20240609   clang
i386                  randconfig-002-20240609   clang
i386                  randconfig-003-20240609   gcc  
i386                  randconfig-004-20240609   gcc  
i386                  randconfig-005-20240609   clang
i386                  randconfig-005-20240610   clang
i386                  randconfig-006-20240609   clang
i386                  randconfig-011-20240609   clang
i386                  randconfig-011-20240610   clang
i386                  randconfig-012-20240609   clang
i386                  randconfig-012-20240610   clang
i386                  randconfig-013-20240609   clang
i386                  randconfig-013-20240610   clang
i386                  randconfig-014-20240609   clang
i386                  randconfig-014-20240610   clang
i386                  randconfig-015-20240609   gcc  
i386                  randconfig-015-20240610   clang
i386                  randconfig-016-20240609   clang
i386                  randconfig-016-20240610   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240610   gcc  
loongarch             randconfig-002-20240610   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240610   gcc  
nios2                 randconfig-002-20240610   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240610   gcc  
parisc                randconfig-002-20240610   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240610   clang
powerpc               randconfig-002-20240610   clang
powerpc               randconfig-003-20240610   clang
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240610   clang
powerpc64             randconfig-002-20240610   clang
powerpc64             randconfig-003-20240610   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240610   gcc  
riscv                 randconfig-002-20240610   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240610   gcc  
s390                  randconfig-002-20240610   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240610   gcc  
sh                    randconfig-002-20240610   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240610   gcc  
sparc64               randconfig-002-20240610   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240610   gcc  
um                    randconfig-002-20240610   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240610   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240610   clang
x86_64                randconfig-006-20240610   clang
x86_64                randconfig-011-20240610   clang
x86_64                randconfig-015-20240610   clang
x86_64                randconfig-016-20240610   clang
x86_64                randconfig-072-20240610   clang
x86_64                randconfig-073-20240610   clang
x86_64                randconfig-075-20240610   clang
x86_64                randconfig-076-20240610   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240610   gcc  
xtensa                randconfig-002-20240610   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

