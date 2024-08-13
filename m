Return-Path: <linux-pci+bounces-11634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB09E950775
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B83281B87
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1E19D076;
	Tue, 13 Aug 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRZhAuXC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369919B3DD
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559069; cv=none; b=kplBiDPRG+saCOcpex7JjyFJ6NCdyY8nGV8DZ5yVGSoS+xEPlvcQb6lF7c8AtWZacIIxcQEmNs3D2g3GaiFw22EDgQzh7+urLlPaCMZQNyWPN5eQ9pUZergnx+ZNySY8v6AzuZoUrAtwrnKPC5LuD49oqrt1UUk/iJafWDYuihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559069; c=relaxed/simple;
	bh=K8GtJqHcsxR/4v2fNrh+lYLUhqEh18kH5Da9sGNErzc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kD3X8yYvikwxTxtBDm8JAG1wWOpsginINk/Y4KYZxyxYpMmE1cN5wG8O3o3DbLCyMKHZsKSboActCsf7cF4Avp5pgz6aBcc5Fpol8LAnhZhgb/wNrzzFDQV7R+yGtfWZUvB89OM8n2fEWHhtL49ALUa1zRmx4hdaYyYsIcWwhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRZhAuXC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723559067; x=1755095067;
  h=date:from:to:cc:subject:message-id;
  bh=K8GtJqHcsxR/4v2fNrh+lYLUhqEh18kH5Da9sGNErzc=;
  b=MRZhAuXCd77njiYI+zEwrCddKPax29ZyXuq/xLt1vhGIS9YBLGhlCJl5
   Bpu8gPI3RRFcvroEc9puXk0jeMCQZVjDDPJWmWCkC4s6/tEA+kI1Oa3wR
   UEk6/z3GCwic8ZffSIugjc9c2kTkouybBLfXkxYqZ4OSSg/CLzQ/sirif
   +KPAeVQOPf9QuRVpNPOup0QV8RRrLJKbySQTZ/YxEF/8RQ2Z3LMSIz4yc
   Uwuk6T0kG7keplYnGgbZUqbbly2M2/hQ1ZA4U/IWaOhEmWPMbj2sxA7Oh
   OhEHlmrc3N61pD3xZISu7PBK2PMbYzEmpo6/YUnR0e1vkQS82DLYjgJ84
   g==;
X-CSE-ConnectionGUID: c15Fk9UTQreUe/YoArWalw==
X-CSE-MsgGUID: aW9IFrtgR9Ovz+foJnnX7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21593510"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21593510"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:24:27 -0700
X-CSE-ConnectionGUID: 7I1E0hPgRV2duN1TlquPKQ==
X-CSE-MsgGUID: xiJCAdgdQHa4PZvNRKYvNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="89486224"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Aug 2024 07:24:26 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdsRj-0000Ss-1p;
	Tue, 13 Aug 2024 14:24:23 +0000
Date: Tue, 13 Aug 2024 22:23:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 ed510ac9b4d07ff31a54c8bf436f187348a7a943
Message-ID: <202408132226.xPVeysIr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: ed510ac9b4d07ff31a54c8bf436f187348a7a943  PCI: Use an error code with PCIe failed link retraining

elapsed time: 1140m

configs tested: 176
configs skipped: 9

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
arm                        neponset_defconfig   clang-20
arm                           sama5_defconfig   gcc-14.1.0
arm                        shmobile_defconfig   clang-20
arm                         socfpga_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
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
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      cm5200_defconfig   clang-20
powerpc                   currituck_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                     powernv_defconfig   clang-20
powerpc                      ppc6xx_defconfig   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          rsk7203_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sh                   secureedge5410_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

