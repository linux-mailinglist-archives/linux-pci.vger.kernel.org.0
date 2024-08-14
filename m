Return-Path: <linux-pci+bounces-11674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94827951F76
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6125FB289C2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315C1E53A;
	Wed, 14 Aug 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4UWZB3H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A371B86CA
	for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651368; cv=none; b=lInQrSwAAbRkvJ+Jrp5aF2jYbyT1dyInqyozNbyl8LqtVfXISyruLanKJWlEvs9c5LFnXzVolMgepJT3tp/G7SjRbimMDvObdyT4HVZ+Y6p6zmKR6oTTYk1G84erWMS0zY5zdSy2jPLEnsr9DpmgwCkD1QshZYhXy10VC7WmB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651368; c=relaxed/simple;
	bh=dVpYbSMwXXH5xaDgXM/6yoVCQVcak2/YQIaWaKraFgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D7Csw9vZ/ie3cEGONF6z8CP94KIhel++ane9pA4DTCf03rLnWJ8sEBjlIO64xz/9AQljD1mVDEXt1Vu+LzIYOkvoLctM/v4poRKub+HXctDEVPLwltwpa6KB58oUca7SqHpzWme4yH0l07rvKXorHL81oRb+ZqAfyWM3iklR/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4UWZB3H; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723651366; x=1755187366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dVpYbSMwXXH5xaDgXM/6yoVCQVcak2/YQIaWaKraFgc=;
  b=N4UWZB3HMun/rh/BVRCB5kwErFOVFvwzsnwNAzFxEHs2B72GbP27cs4T
   2fxmSUcpEOaGboe8LCsRpfgGfOfkT5wMpAxV4b0AwTKGiq9AfW+eIMbcs
   KXiurgnfQUnHv29jh0OmUmknDt8F/ky1Nx2yLV5t9xcNCiKoKn5t9oPle
   nY9EHMJL+B6aL/Hn5klIISruUawpoD46yI1VKjenqEjJoQtgcppQeePLA
   s4YclLVG0v1Nw8laoazS5guUIugv0uvH+r85RYDEtSuUMQ19vfmF/wQ79
   6Zsi1mET5g4RrwBFHxvYf3yd3AO7hCPrzXsEbsWSGbgUmfRkBRYY9qdCZ
   A==;
X-CSE-ConnectionGUID: d4gDsD7uTACG9TvzlPszmw==
X-CSE-MsgGUID: Y3T6kZrORviFl10CywFbGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22029427"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="22029427"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 09:02:15 -0700
X-CSE-ConnectionGUID: wyXDO9UUTGG6g+AoFlOFKQ==
X-CSE-MsgGUID: 3bLHnk8oQ9qvpACNRQhblw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="89766454"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2024 09:02:14 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seGRv-0002Hu-1h;
	Wed, 14 Aug 2024 16:02:11 +0000
Date: Thu, 15 Aug 2024 00:01:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 6d27436b41d4e756565b4fdf93eda300df59cee5
Message-ID: <202408150056.1GFLHTr6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 6d27436b41d4e756565b4fdf93eda300df59cee5  PCI: qcom-ep: Disable MHI RAM data parity error interrupt for SA8775P SoC

elapsed time: 1178m

configs tested: 216
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240814   gcc-13.2.0
arc                   randconfig-002-20240814   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-12.4.0
arm                            hisi_defconfig   gcc-12.4.0
arm                          moxart_defconfig   gcc-12.4.0
arm                         mv78xx0_defconfig   gcc-12.4.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240814   gcc-13.2.0
arm                   randconfig-002-20240814   gcc-13.2.0
arm                   randconfig-003-20240814   gcc-13.2.0
arm                   randconfig-004-20240814   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-12.4.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240814   gcc-13.2.0
arm64                 randconfig-002-20240814   gcc-13.2.0
arm64                 randconfig-003-20240814   gcc-13.2.0
arm64                 randconfig-004-20240814   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240814   gcc-13.2.0
csky                  randconfig-002-20240814   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             alldefconfig   gcc-12.4.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-005-20240814   clang-18
i386         buildonly-randconfig-005-20240814   gcc-12
i386         buildonly-randconfig-006-20240814   clang-18
i386         buildonly-randconfig-006-20240814   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-002-20240814   clang-18
i386                  randconfig-002-20240814   gcc-12
i386                  randconfig-003-20240814   clang-18
i386                  randconfig-003-20240814   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-011-20240814   clang-18
i386                  randconfig-011-20240814   gcc-12
i386                  randconfig-012-20240814   clang-18
i386                  randconfig-012-20240814   gcc-12
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-014-20240814   clang-18
i386                  randconfig-014-20240814   gcc-11
i386                  randconfig-015-20240814   clang-18
i386                  randconfig-015-20240814   gcc-12
i386                  randconfig-016-20240814   clang-18
i386                  randconfig-016-20240814   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240814   gcc-13.2.0
loongarch             randconfig-002-20240814   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-12.4.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-12.4.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240814   gcc-13.2.0
nios2                 randconfig-002-20240814   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                  or1klitex_defconfig   gcc-12.4.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240814   gcc-13.2.0
parisc                randconfig-002-20240814   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-12.4.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   gcc-12.4.0
powerpc               randconfig-002-20240814   gcc-13.2.0
powerpc               randconfig-003-20240814   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240814   gcc-13.2.0
powerpc64             randconfig-002-20240814   gcc-13.2.0
powerpc64             randconfig-003-20240814   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240814   gcc-13.2.0
riscv                 randconfig-002-20240814   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-13.2.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240814   gcc-13.2.0
s390                  randconfig-002-20240814   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-12.4.0
sh                          polaris_defconfig   gcc-12.4.0
sh                    randconfig-001-20240814   gcc-13.2.0
sh                    randconfig-002-20240814   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-12.4.0
sh                          sdk7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-12.4.0
sh                     sh7710voipgw_defconfig   gcc-12.4.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-12.4.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240814   gcc-13.2.0
sparc64               randconfig-002-20240814   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240814   gcc-13.2.0
um                    randconfig-002-20240814   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240814   clang-18
x86_64       buildonly-randconfig-002-20240814   clang-18
x86_64       buildonly-randconfig-003-20240814   clang-18
x86_64       buildonly-randconfig-004-20240814   clang-18
x86_64       buildonly-randconfig-005-20240814   clang-18
x86_64       buildonly-randconfig-006-20240814   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240814   clang-18
x86_64                randconfig-002-20240814   clang-18
x86_64                randconfig-003-20240814   clang-18
x86_64                randconfig-004-20240814   clang-18
x86_64                randconfig-005-20240814   clang-18
x86_64                randconfig-006-20240814   clang-18
x86_64                randconfig-011-20240814   clang-18
x86_64                randconfig-012-20240814   clang-18
x86_64                randconfig-013-20240814   clang-18
x86_64                randconfig-014-20240814   clang-18
x86_64                randconfig-015-20240814   clang-18
x86_64                randconfig-016-20240814   clang-18
x86_64                randconfig-071-20240814   clang-18
x86_64                randconfig-072-20240814   clang-18
x86_64                randconfig-073-20240814   clang-18
x86_64                randconfig-074-20240814   clang-18
x86_64                randconfig-075-20240814   clang-18
x86_64                randconfig-076-20240814   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240814   gcc-13.2.0
xtensa                randconfig-002-20240814   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

