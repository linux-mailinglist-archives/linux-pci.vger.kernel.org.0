Return-Path: <linux-pci+bounces-11653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C2B950D1C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 21:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0DA284806
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9619D089;
	Tue, 13 Aug 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VybIuqMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51A1A254F
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577140; cv=none; b=KIOW+XflhUx7E4I6IeEEk1afOMM/dY5KDLPeMflqekL4VF89RQTiDVTTTyB16oXFEXSMETUv0i/QroD4qQEi2ipQmtmuEZJHBH7jazM9ML4wgJcaM0TUDfMeR8gyrIabnJds/S2X9BQomG0YYoI5rg2QRNUN5MZD02tLl3ngDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577140; c=relaxed/simple;
	bh=L4hpf5kTwdaOm+sk4/gxU9SP/8QrLGP1MQULxZPOLt8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aqnYeUCUDm5ppwxNGHZnAxjn1yyA35ZuFA092juBFOac1rKzrKt2eyD8rz9lsZcOGz6j5+37v3btix62xxpgSE3Z0dgtL4jy1gVnfnW+/+/1dkKhj6qAMZcZfTdXrcrOUPRHaXWA64ze3ai2sVe71tfh8HKpW7fQv4da88ZsQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VybIuqMk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723577139; x=1755113139;
  h=date:from:to:cc:subject:message-id;
  bh=L4hpf5kTwdaOm+sk4/gxU9SP/8QrLGP1MQULxZPOLt8=;
  b=VybIuqMkza6oXYT/zBBYYAUmcZe2wWHG0ei+R/MqQFr+O+oGbJ26h72Z
   bE+Dl6n/ZZBGxaQLi2tqgFxlWNvjV6EnrE8BEfg9NrH2P0x6bvZtPDMZV
   4DA85eAb8+ayJUOrePYhZETBwZ7kn0kVuBw7/fJwBx/e/NfDjrUiRdLrb
   GRUfPBr5AhvRzTPbYAfcXan8aslxI5jYG3IxyC6rgV5GKCIly6Ez8Nbq9
   G5Wl4Vd9QEgaPKTZBgQGrcgZI7u8JbDQyOPpBAVLKZIfy4VYlBo4g/zaw
   vgkvUmKiB4rNW1su+iZ5bHnS/zZOVasvexDN/h2U5pNdy1fxxD6JB2quu
   A==;
X-CSE-ConnectionGUID: ChrkkeVPR4qBvKqhm0DK+Q==
X-CSE-MsgGUID: XgeeaFroQwy007dW288p8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="24676095"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="24676095"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 12:25:38 -0700
X-CSE-ConnectionGUID: sW1MRdfKRlSFvtV+9D6zdg==
X-CSE-MsgGUID: pm/AhZzfStetOmUsr2b4tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58766170"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Aug 2024 12:25:37 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdx9D-0000gQ-0h;
	Tue, 13 Aug 2024 19:25:35 +0000
Date: Wed, 14 Aug 2024 03:25:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 054308ad90ae43ba2d4b9c83c6582e8fe94f6fed
Message-ID: <202408140317.JzX1emDQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 054308ad90ae43ba2d4b9c83c6582e8fe94f6fed  MAINTAINERS: Add Manivannan Sadhasivam as Reviewer for PCI native host bridge and endpoint drivers

elapsed time: 1442m

configs tested: 248
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240813   gcc-13.2.0
arc                   randconfig-002-20240813   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                       aspeed_g4_defconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   clang-14
arm                           h3600_defconfig   clang-14
arm                        neponset_defconfig   clang-20
arm                             pxa_defconfig   clang-14
arm                   randconfig-001-20240813   gcc-13.2.0
arm                   randconfig-001-20240813   gcc-14.1.0
arm                   randconfig-002-20240813   gcc-13.2.0
arm                   randconfig-002-20240813   gcc-14.1.0
arm                   randconfig-003-20240813   gcc-13.2.0
arm                   randconfig-003-20240813   gcc-14.1.0
arm                   randconfig-004-20240813   gcc-13.2.0
arm                   randconfig-004-20240813   gcc-14.1.0
arm                           sama5_defconfig   clang-14
arm                           sama5_defconfig   gcc-14.1.0
arm                        shmobile_defconfig   clang-20
arm                         socfpga_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240813   gcc-13.2.0
arm64                 randconfig-001-20240813   gcc-14.1.0
arm64                 randconfig-002-20240813   gcc-13.2.0
arm64                 randconfig-002-20240813   gcc-14.1.0
arm64                 randconfig-003-20240813   gcc-13.2.0
arm64                 randconfig-004-20240813   gcc-13.2.0
arm64                 randconfig-004-20240813   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240813   gcc-13.2.0
csky                  randconfig-001-20240813   gcc-14.1.0
csky                  randconfig-002-20240813   gcc-13.2.0
csky                  randconfig-002-20240813   gcc-14.1.0
hexagon                          alldefconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240813   gcc-12
i386         buildonly-randconfig-002-20240813   gcc-12
i386         buildonly-randconfig-003-20240813   gcc-12
i386         buildonly-randconfig-004-20240813   gcc-11
i386         buildonly-randconfig-004-20240813   gcc-12
i386         buildonly-randconfig-005-20240813   clang-18
i386         buildonly-randconfig-005-20240813   gcc-12
i386         buildonly-randconfig-006-20240813   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240813   gcc-12
i386                  randconfig-002-20240813   clang-18
i386                  randconfig-002-20240813   gcc-12
i386                  randconfig-003-20240813   gcc-12
i386                  randconfig-004-20240813   gcc-12
i386                  randconfig-005-20240813   clang-18
i386                  randconfig-005-20240813   gcc-12
i386                  randconfig-006-20240813   clang-18
i386                  randconfig-006-20240813   gcc-12
i386                  randconfig-011-20240813   gcc-12
i386                  randconfig-012-20240813   gcc-12
i386                  randconfig-013-20240813   clang-18
i386                  randconfig-013-20240813   gcc-12
i386                  randconfig-014-20240813   clang-18
i386                  randconfig-014-20240813   gcc-12
i386                  randconfig-015-20240813   clang-18
i386                  randconfig-015-20240813   gcc-12
i386                  randconfig-016-20240813   clang-18
i386                  randconfig-016-20240813   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240813   gcc-13.2.0
loongarch             randconfig-001-20240813   gcc-14.1.0
loongarch             randconfig-002-20240813   gcc-13.2.0
loongarch             randconfig-002-20240813   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                      mmu_defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           gcw0_defconfig   clang-20
mips                           gcw0_defconfig   gcc-14.1.0
mips                        qi_lb60_defconfig   gcc-14.1.0
mips                         rt305x_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240813   gcc-13.2.0
nios2                 randconfig-001-20240813   gcc-14.1.0
nios2                 randconfig-002-20240813   gcc-13.2.0
nios2                 randconfig-002-20240813   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240813   gcc-13.2.0
parisc                randconfig-001-20240813   gcc-14.1.0
parisc                randconfig-002-20240813   gcc-13.2.0
parisc                randconfig-002-20240813   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      cm5200_defconfig   clang-20
powerpc                   currituck_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                     mpc5200_defconfig   clang-14
powerpc                     powernv_defconfig   clang-20
powerpc                      ppc44x_defconfig   clang-14
powerpc                      ppc6xx_defconfig   gcc-14.1.0
powerpc               randconfig-002-20240813   gcc-13.2.0
powerpc               randconfig-002-20240813   gcc-14.1.0
powerpc               randconfig-003-20240813   gcc-13.2.0
powerpc               randconfig-003-20240813   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240813   gcc-13.2.0
powerpc64             randconfig-001-20240813   gcc-14.1.0
powerpc64             randconfig-002-20240813   gcc-13.2.0
powerpc64             randconfig-002-20240813   gcc-14.1.0
powerpc64             randconfig-003-20240813   gcc-13.2.0
powerpc64             randconfig-003-20240813   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240813   gcc-13.2.0
riscv                 randconfig-001-20240813   gcc-14.1.0
riscv                 randconfig-002-20240813   gcc-13.2.0
riscv                 randconfig-002-20240813   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240813   clang-20
s390                  randconfig-001-20240813   gcc-13.2.0
s390                  randconfig-002-20240813   gcc-13.2.0
s390                  randconfig-002-20240813   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240813   gcc-13.2.0
sh                    randconfig-001-20240813   gcc-14.1.0
sh                    randconfig-002-20240813   gcc-13.2.0
sh                    randconfig-002-20240813   gcc-14.1.0
sh                          rsk7203_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sh                   secureedge5410_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240813   gcc-13.2.0
sparc64               randconfig-001-20240813   gcc-14.1.0
sparc64               randconfig-002-20240813   gcc-13.2.0
sparc64               randconfig-002-20240813   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240813   gcc-12
um                    randconfig-001-20240813   gcc-13.2.0
um                    randconfig-002-20240813   clang-14
um                    randconfig-002-20240813   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240813   clang-18
x86_64       buildonly-randconfig-002-20240813   clang-18
x86_64       buildonly-randconfig-003-20240813   clang-18
x86_64       buildonly-randconfig-004-20240813   clang-18
x86_64       buildonly-randconfig-005-20240813   clang-18
x86_64       buildonly-randconfig-006-20240813   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240813   clang-18
x86_64                randconfig-002-20240813   clang-18
x86_64                randconfig-003-20240813   clang-18
x86_64                randconfig-004-20240813   clang-18
x86_64                randconfig-005-20240813   clang-18
x86_64                randconfig-006-20240813   clang-18
x86_64                randconfig-011-20240813   clang-18
x86_64                randconfig-012-20240813   clang-18
x86_64                randconfig-013-20240813   clang-18
x86_64                randconfig-014-20240813   clang-18
x86_64                randconfig-015-20240813   clang-18
x86_64                randconfig-016-20240813   clang-18
x86_64                randconfig-071-20240813   clang-18
x86_64                randconfig-072-20240813   clang-18
x86_64                randconfig-073-20240813   clang-18
x86_64                randconfig-074-20240813   clang-18
x86_64                randconfig-075-20240813   clang-18
x86_64                randconfig-076-20240813   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                           alldefconfig   gcc-14.1.0
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240813   gcc-13.2.0
xtensa                randconfig-001-20240813   gcc-14.1.0
xtensa                randconfig-002-20240813   gcc-13.2.0
xtensa                randconfig-002-20240813   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

