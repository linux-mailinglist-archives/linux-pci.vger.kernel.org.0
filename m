Return-Path: <linux-pci+bounces-7402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6E8C3664
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 14:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507DA2812CB
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC89208BC;
	Sun, 12 May 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJL6vEiZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4218E1E
	for <linux-pci@vger.kernel.org>; Sun, 12 May 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516096; cv=none; b=rHx4byg0Luxn0HWOPc8JGP1Nl7tFFBUY6KP+OINf0WKaCS9Ek1nztkPc0toOKKvyHncAqwaSfIIFtm8q7nqgoPXckq4VxN8zBUzwDUEPFpBQyh9QmI502y/T0xKgUHwGLpSvg12uX3W5nOteHdwI/Yg78b3p2hGdc46EDY/4/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516096; c=relaxed/simple;
	bh=FBBXD6EqwKY1cQf43vM5yYK2RPipJEjSFSJemwPXKEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rnrnEtmHIx6vrJpG5ie4K2VzLtHMyMscFQxil2ujkUgI5SRYwDPG0KA5WgiWr4Fg6eOtPI39p61mbzPmdbbWEYui/t7IyLUp+Nb7YGsOo4CxgeIzZs46MU1uX6zcSqMJsHNdLmQb4/G4noqOBAZGwO5zQB5FoTBakrJE6dimEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJL6vEiZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516095; x=1747052095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FBBXD6EqwKY1cQf43vM5yYK2RPipJEjSFSJemwPXKEM=;
  b=WJL6vEiZy12dBskOMEUCLy8Aa7WyVnW2mZDxNB9YsKtnGUWlhfk/7loF
   NOw95zXS2RXE7GbFQsynRlxq24QAypI0rjDtM8NlGj8r0FdWAD80BTSHp
   nhrrhdhXbDLDu/wPeWNXsp/3S5BJD2dXw89L5h/IK9/TH7KRN4NsvVnCS
   Yk+dNGrbZj8bB6YAiKhAz/z41DLrsVcedG3claVq6uqZBnfCfl7BD9pV7
   cVQwmpekcSDlCWSOIAW8RNw+oY1JZgrdcSdDXdaqsWmytQqF7YyqMpMix
   sE53iKHVZ5RVzcfFenD6/1gRVIoWp2QEeZ/miLA8Fj7sv+MutFXqM+b03
   Q==;
X-CSE-ConnectionGUID: VjWDf5pgRama5CbqtubOvA==
X-CSE-MsgGUID: P7q480k5SbK3VVcqr4AVLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11614513"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11614513"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:14:55 -0700
X-CSE-ConnectionGUID: smeABdbJTLiBOqrcL5utzQ==
X-CSE-MsgGUID: 6+BokqpMSW245CxArq+9/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="29924468"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 May 2024 05:14:53 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s686M-0008ZL-3A;
	Sun, 12 May 2024 12:14:50 +0000
Date: Sun, 12 May 2024 20:13:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 b00c483a10754f510ea726fd2ccc26a7e9462c32
Message-ID: <202405122049.bbHh0isL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: b00c483a10754f510ea726fd2ccc26a7e9462c32  PCI: dw-rockchip: Fix initial PERST# GPIO value

elapsed time: 1452m

configs tested: 164
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
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240512   gcc  
arc                   randconfig-002-20240512   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240512   gcc  
arm                   randconfig-004-20240512   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-004-20240512   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240512   gcc  
csky                  randconfig-002-20240512   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240512   clang
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240512   clang
i386                                defconfig   clang
i386                  randconfig-001-20240512   clang
i386                  randconfig-002-20240512   clang
i386                  randconfig-003-20240512   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240512   clang
i386                  randconfig-006-20240512   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240512   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240512   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240512   gcc  
loongarch             randconfig-002-20240512   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240512   gcc  
nios2                 randconfig-002-20240512   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240512   gcc  
parisc                randconfig-002-20240512   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240512   gcc  
s390                  randconfig-002-20240512   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240512   gcc  
sh                    randconfig-002-20240512   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240512   gcc  
sparc64               randconfig-002-20240512   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240512   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240512   clang
x86_64       buildonly-randconfig-002-20240512   clang
x86_64       buildonly-randconfig-003-20240512   clang
x86_64       buildonly-randconfig-005-20240512   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240512   clang
x86_64                randconfig-013-20240512   clang
x86_64                randconfig-015-20240512   clang
x86_64                randconfig-016-20240512   clang
x86_64                randconfig-071-20240512   clang
x86_64                randconfig-074-20240512   clang
x86_64                randconfig-075-20240512   clang
x86_64                randconfig-076-20240512   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240512   gcc  
xtensa                randconfig-002-20240512   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

