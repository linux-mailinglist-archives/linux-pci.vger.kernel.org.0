Return-Path: <linux-pci+bounces-17006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7269D04B8
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1B3B21B78
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6671401B;
	Sun, 17 Nov 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrPTBDPa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA46101E6
	for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731862863; cv=none; b=kQ8HfujGsYqzk91CqvhUzW/+nW9hKcYk6Fh8B/mZh+XJnoDi+aMmd5jzzxB7VYBPoiT78q0ZZXpQA7d+GA2KsuuWJsdrZm95xHPA9k1UTfIUljDiOmfaw1Ep5iO4Vkk8mT26rrZnaPJUhhNpE8/7pzbtlUXxk13c/VrLHxH7sbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731862863; c=relaxed/simple;
	bh=gbL1PhCbg1xIrwF3zDIoHst47D+GPJJL3qKiprju1Ks=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DHN64nDmWIhTWzS//AxXlSoO0KWQscN4OW3CEztFCrfod2rS67yBcK8HzFQsdiF4WFqTz+K9s2YUdw0Yv18+b05OHlPLwp/haagmWx4iPrM2A6aQjZhMDH4Tr5FNnc+ppddigAr8XXlOLaqe9DhUIdNYFayEqrK3DiKJh51B4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrPTBDPa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731862861; x=1763398861;
  h=date:from:to:cc:subject:message-id;
  bh=gbL1PhCbg1xIrwF3zDIoHst47D+GPJJL3qKiprju1Ks=;
  b=BrPTBDPa3EJz4/hdty4ivQJmoOI0m6DQgeNZv3PHpoVWNzcma998lILr
   vtQDLKCtajrQm2wcm/TKKwNSLN0sI5pTsoO1/AWxyh5qff5y1il8RvHIa
   Ix8T+ti9s/ES1FqimJ4RZMW2+pzf8euQZR2yW4xpI+LqIbFJqDMnxVYAQ
   /7zftNQsc0WceRovcxOAPJsnAsCVkNnVSUr9ud/i1YyOhrC9ynPibTxiC
   QkGS0iQj6YJ7DIcZGfLm2LNHvX/Fbb9RzRYCU31ottRHkKnVoWIlVwYBR
   cdXvzGexiOP1DegvZS8wDVRkjZGRB/Zx58WQ5PQSeLOZB+C7oL1SnCwj+
   w==;
X-CSE-ConnectionGUID: JcXlXrFEQ8iWTYBTEjVjew==
X-CSE-MsgGUID: Vx5p/b2VSuCpeJNA4bgu0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="34675314"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="34675314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 09:01:00 -0800
X-CSE-ConnectionGUID: wRt4uP/QTmGHQ2QNX0Y7cQ==
X-CSE-MsgGUID: ZwwIcDuQT7qO5245grZwoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="89423666"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Nov 2024 09:00:59 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCids-0001wn-2R;
	Sun, 17 Nov 2024 17:00:56 +0000
Date: Mon, 18 Nov 2024 00:59:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD SUCCESS
 ba58eee1c57b2ad45c36f782861c18faef170a55
Message-ID: <202411180053.icmQSehw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: ba58eee1c57b2ad45c36f782861c18faef170a55  PCI: Drop duplicate pcie_get_speed_cap(), pcie_get_width_cap() declarations

elapsed time: 1454m

configs tested: 185
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241117    clang-20
arc                   randconfig-002-20241117    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                          collie_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    clang-20
arm                        multi_v7_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241117    clang-20
arm                   randconfig-002-20241117    clang-20
arm                   randconfig-003-20241117    clang-20
arm                   randconfig-004-20241117    clang-20
arm                         s5pv210_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm                       versatile_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241117    clang-20
arm64                 randconfig-002-20241117    clang-20
arm64                 randconfig-003-20241117    clang-20
arm64                 randconfig-004-20241117    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241117    clang-20
csky                  randconfig-002-20241117    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241117    clang-20
hexagon               randconfig-002-20241117    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241117    clang-19
i386        buildonly-randconfig-002-20241117    clang-19
i386        buildonly-randconfig-003-20241117    clang-19
i386        buildonly-randconfig-004-20241117    clang-19
i386        buildonly-randconfig-005-20241117    clang-19
i386        buildonly-randconfig-006-20241117    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241117    clang-19
i386                  randconfig-002-20241117    clang-19
i386                  randconfig-003-20241117    clang-19
i386                  randconfig-004-20241117    clang-19
i386                  randconfig-005-20241117    clang-19
i386                  randconfig-006-20241117    clang-19
i386                  randconfig-011-20241117    clang-19
i386                  randconfig-012-20241117    clang-19
i386                  randconfig-013-20241117    clang-19
i386                  randconfig-014-20241117    clang-19
i386                  randconfig-015-20241117    clang-19
i386                  randconfig-016-20241117    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241117    clang-20
loongarch             randconfig-002-20241117    clang-20
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-13.2.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241117    clang-20
nios2                 randconfig-002-20241117    clang-20
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-13.2.0
parisc                randconfig-001-20241117    clang-20
parisc                randconfig-002-20241117    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                     rainier_defconfig    gcc-13.2.0
powerpc               randconfig-001-20241117    clang-20
powerpc               randconfig-002-20241117    clang-20
powerpc               randconfig-003-20241117    clang-20
powerpc                     sequoia_defconfig    gcc-13.2.0
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20241117    clang-20
powerpc64             randconfig-002-20241117    clang-20
powerpc64             randconfig-003-20241117    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241117    clang-20
riscv                 randconfig-002-20241117    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241117    clang-20
s390                  randconfig-002-20241117    clang-20
s390                       zfcpdump_defconfig    gcc-13.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    gcc-13.2.0
sh                    randconfig-001-20241117    clang-20
sh                    randconfig-002-20241117    clang-20
sh                           se7206_defconfig    gcc-13.2.0
sh                           se7750_defconfig    gcc-13.2.0
sh                        sh7785lcr_defconfig    gcc-13.2.0
sh                            shmin_defconfig    clang-20
sh                          urquell_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241117    clang-20
sparc64               randconfig-002-20241117    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241117    clang-20
um                    randconfig-002-20241117    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241117    gcc-12
x86_64      buildonly-randconfig-002-20241117    gcc-12
x86_64      buildonly-randconfig-003-20241117    gcc-12
x86_64      buildonly-randconfig-004-20241117    gcc-12
x86_64      buildonly-randconfig-005-20241117    gcc-12
x86_64      buildonly-randconfig-006-20241117    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241117    gcc-12
x86_64                randconfig-002-20241117    gcc-12
x86_64                randconfig-003-20241117    gcc-12
x86_64                randconfig-004-20241117    gcc-12
x86_64                randconfig-005-20241117    gcc-12
x86_64                randconfig-006-20241117    gcc-12
x86_64                randconfig-011-20241117    gcc-12
x86_64                randconfig-012-20241117    gcc-12
x86_64                randconfig-013-20241117    gcc-12
x86_64                randconfig-014-20241117    gcc-12
x86_64                randconfig-015-20241117    gcc-12
x86_64                randconfig-016-20241117    gcc-12
x86_64                randconfig-071-20241117    gcc-12
x86_64                randconfig-072-20241117    gcc-12
x86_64                randconfig-073-20241117    gcc-12
x86_64                randconfig-074-20241117    gcc-12
x86_64                randconfig-075-20241117    gcc-12
x86_64                randconfig-076-20241117    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-20
xtensa                randconfig-001-20241117    clang-20
xtensa                randconfig-002-20241117    clang-20
xtensa                    xip_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

