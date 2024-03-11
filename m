Return-Path: <linux-pci+bounces-4715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB6877B1E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 08:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CA22810FA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F210FA;
	Mon, 11 Mar 2024 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUv2ze4Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08342101C2
	for <linux-pci@vger.kernel.org>; Mon, 11 Mar 2024 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710140441; cv=none; b=mztTXrL//sWeEG4A18ectNY9HDRkIJMUs+2cJ/Kg2M5abc/1O4HPlZts5u4WUimsYk1yYdKawl136eCEZoDyFjohD/kbE7l5ahKuapy7W/lOHZT04GoJg19f3GDflGiGtQgagWky7t1L5oqCi0sbzCjvuPhnCBmxOCLVZ+HNcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710140441; c=relaxed/simple;
	bh=PgvhXmAE8w+DmHulHilvY3i0E+5d0IDU5c5fnx/x+L8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cOLeFxs7itg+YsOP2u0CEIRrl3I/UjFX6ffyM5/uRsuaHJTn63lwwzU4BBK8Qt/o+jHSRkp2QElRMj73AOnqzKCV2aBA/VQJd7PniwcK+f6WBE6X2hW9Of/mCO3/kj4FtIVFHERobWRAv+XAET03TlEMHmQjoZsO9jpVLH+Ki0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUv2ze4Y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710140439; x=1741676439;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PgvhXmAE8w+DmHulHilvY3i0E+5d0IDU5c5fnx/x+L8=;
  b=WUv2ze4Y9Az/xNB7F3d5U3sC15jf1+ffrLJgPc4qOAl2NC11Vy2bOIQi
   Mq4ffjXthvlNH7c6zzpv6HtYjTM1gc60v7cSyYRUskEc6Q4Me0FhkOBcW
   Z7An1Wm2u3dPjXiFltw3M8wAheIpPoHdcEV6dT/GZjpoKbYVBfvjMAW+u
   Gy2LMBvZfCKGTQXQEnttk7F/CXcsSgw0eVoY+ElNpwDNIpCHDbSVwk2Xb
   28JIHlufhBCdBh74SjCb4OcfvJaQCytFjQisKXfjGR/bbE5GyijBAKO7E
   AJsWQQ3rGgB4IHFt94wcv+HHp5D4TChaqySpigArNqAj/ZofHeV/MNUUL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8607078"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="8607078"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 00:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="10964791"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Mar 2024 00:00:36 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjZeD-0008y3-1K;
	Mon, 11 Mar 2024 07:00:33 +0000
Date: Mon, 11 Mar 2024 15:00:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/hyperv] BUILD SUCCESS
 b5ff74c1ef50fe08e384026875fec660fadfaedd
Message-ID: <202403111527.I6d6oDoQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/hyperv
branch HEAD: b5ff74c1ef50fe08e384026875fec660fadfaedd  PCI: hv: Fix ring buffer size calculation

elapsed time: 724m

configs tested: 204
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240311   gcc  
arc                   randconfig-002-20240311   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                           imxrt_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240311   clang
arm                   randconfig-002-20240311   gcc  
arm                   randconfig-003-20240311   clang
arm                   randconfig-004-20240311   clang
arm                        shmobile_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240311   clang
arm64                 randconfig-002-20240311   clang
arm64                 randconfig-003-20240311   clang
arm64                 randconfig-004-20240311   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240311   gcc  
csky                  randconfig-002-20240311   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240311   clang
hexagon               randconfig-002-20240311   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240311   clang
i386         buildonly-randconfig-002-20240311   clang
i386         buildonly-randconfig-003-20240311   clang
i386         buildonly-randconfig-004-20240311   gcc  
i386         buildonly-randconfig-005-20240311   clang
i386         buildonly-randconfig-006-20240311   clang
i386                                defconfig   clang
i386                  randconfig-001-20240311   gcc  
i386                  randconfig-002-20240311   gcc  
i386                  randconfig-003-20240311   clang
i386                  randconfig-004-20240311   clang
i386                  randconfig-005-20240311   gcc  
i386                  randconfig-006-20240311   clang
i386                  randconfig-011-20240311   gcc  
i386                  randconfig-012-20240311   gcc  
i386                  randconfig-013-20240311   clang
i386                  randconfig-014-20240311   gcc  
i386                  randconfig-015-20240311   clang
i386                  randconfig-016-20240311   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240311   gcc  
loongarch             randconfig-002-20240311   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240311   gcc  
nios2                 randconfig-002-20240311   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240311   gcc  
parisc                randconfig-002-20240311   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20240311   gcc  
powerpc               randconfig-002-20240311   clang
powerpc               randconfig-003-20240311   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240311   clang
powerpc64             randconfig-002-20240311   clang
powerpc64             randconfig-003-20240311   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240311   clang
riscv                 randconfig-002-20240311   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240311   clang
s390                  randconfig-002-20240311   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240311   gcc  
sh                    randconfig-002-20240311   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240311   gcc  
sparc64               randconfig-002-20240311   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240311   gcc  
um                    randconfig-002-20240311   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240311   clang
x86_64       buildonly-randconfig-002-20240311   clang
x86_64       buildonly-randconfig-003-20240311   clang
x86_64       buildonly-randconfig-004-20240311   gcc  
x86_64       buildonly-randconfig-005-20240311   clang
x86_64       buildonly-randconfig-006-20240311   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240311   clang
x86_64                randconfig-002-20240311   clang
x86_64                randconfig-003-20240311   gcc  
x86_64                randconfig-004-20240311   gcc  
x86_64                randconfig-005-20240311   gcc  
x86_64                randconfig-006-20240311   clang
x86_64                randconfig-011-20240311   clang
x86_64                randconfig-012-20240311   clang
x86_64                randconfig-013-20240311   clang
x86_64                randconfig-014-20240311   gcc  
x86_64                randconfig-015-20240311   clang
x86_64                randconfig-016-20240311   gcc  
x86_64                randconfig-071-20240311   gcc  
x86_64                randconfig-072-20240311   clang
x86_64                randconfig-073-20240311   clang
x86_64                randconfig-074-20240311   gcc  
x86_64                randconfig-075-20240311   clang
x86_64                randconfig-076-20240311   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240311   gcc  
xtensa                randconfig-002-20240311   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

