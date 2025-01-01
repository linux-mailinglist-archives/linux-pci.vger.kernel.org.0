Return-Path: <linux-pci+bounces-19141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C999FF2CD
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 05:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B355D1882817
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 04:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70AC2E0;
	Wed,  1 Jan 2025 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmDw/mqo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AAF4E2
	for <linux-pci@vger.kernel.org>; Wed,  1 Jan 2025 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707385; cv=none; b=n0PAfQ5C5InjKOecDep3ymEGEgZn7Xana9VAz46MWcTGD1wIXukkYuwMPLj9WkobNXDDMdONV3xy/MKd7NZHClajrMY32tL6cRQEpYUZxAxeoJyBn1HAnoU97KWzNgaI1x/tIs07FNDM45EIx7jc7YmWeUGRNW/rIBJj38Kano8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707385; c=relaxed/simple;
	bh=khAPxQ8hPE1N49JfxgjtLt/dxWPURN8uG2376XZjl7g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IpeDwcydQj+YygH/JJcAh053tXfcDG7YE8KBI2G7E2TY0WRKFs2y5X9R9qbI0XIqA9szDwVk8ZTZIGb+SnXGEX3kGbnPrR224VhiUPyJ6OfzD7P/JtP2+kgGBnPS+ZWN4pQ0bQNsQWSIljbr8+ktaNy5AARGQkrEII1BZDBBJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmDw/mqo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707384; x=1767243384;
  h=date:from:to:cc:subject:message-id;
  bh=khAPxQ8hPE1N49JfxgjtLt/dxWPURN8uG2376XZjl7g=;
  b=SmDw/mqoiW/LwH5sviv42xIMiBjMZx6ptX02hPkLx5pFApv87DuB2/FE
   0KGbfNCCkkVH6r793KV09S7DuG6Ea5fKgeioEFje5KIGj0IJS1fSu6C/P
   ufkbwhFZb/icrcqGQJVvMxw/A7PJ//lZbE+hsHQNC17RuUA7JJWBNfJZ4
   hO8+9RVS5VFs9ZjCaKxSJ38VTCbqY9XdqfEgLak4AwEg5OA8dmnGINpqi
   6cu6+XvxXkKrNjX6k4x6JcctKVtM7NAg/r2/qrc2Yc0W9ZfTlz0XrHw9N
   5GDyCR4GuiDNyRWoDSySR9ThJnclFmXdVAK6bpUAcQ21uvAOMf5BLt7WL
   w==;
X-CSE-ConnectionGUID: Oar5ytS2SEyFpjoB6xP3BQ==
X-CSE-MsgGUID: 25WZ8SLkSjeCCRe1rBCspA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="35855454"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="35855454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 20:56:21 -0800
X-CSE-ConnectionGUID: rvq7lrKTTwOASvi3AhUreg==
X-CSE-MsgGUID: 7WlpvKgWQ4mgwP7l6LYBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101302940"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Dec 2024 20:56:19 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tSqmH-0007dV-0p;
	Wed, 01 Jan 2025 04:56:17 +0000
Date: Wed, 01 Jan 2025 12:55:21 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dt] BUILD SUCCESS
 a45646d86e69e6dfcec83e2d401bc8726bd0060c
Message-ID: <202501011214.FZEJEB8i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dt
branch HEAD: a45646d86e69e6dfcec83e2d401bc8726bd0060c  dt-bindings: PCI: mobiveil: Convert mobiveil-pcie.txt to yaml format

elapsed time: 828m

configs tested: 151
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250101    gcc-13.2.0
arc                   randconfig-002-20250101    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                         lpc32xx_defconfig    clang-20
arm                   randconfig-001-20250101    clang-15
arm                   randconfig-002-20250101    clang-17
arm                   randconfig-003-20250101    gcc-14.2.0
arm                   randconfig-004-20250101    gcc-14.2.0
arm                           sama7_defconfig    clang-16
arm                       spear13xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250101    clang-20
arm64                 randconfig-002-20250101    clang-20
arm64                 randconfig-003-20250101    gcc-14.2.0
arm64                 randconfig-004-20250101    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241231    gcc-14.2.0
csky                  randconfig-002-20241231    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241231    clang-20
hexagon               randconfig-002-20241231    clang-16
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241231    gcc-11
i386        buildonly-randconfig-002-20241231    clang-19
i386        buildonly-randconfig-003-20241231    clang-19
i386        buildonly-randconfig-004-20241231    clang-19
i386        buildonly-randconfig-005-20241231    gcc-12
i386        buildonly-randconfig-006-20241231    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241231    gcc-14.2.0
loongarch             randconfig-002-20241231    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241231    gcc-14.2.0
nios2                 randconfig-002-20241231    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241231    gcc-14.2.0
parisc                randconfig-002-20241231    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-17
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-20
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241231    clang-15
powerpc               randconfig-002-20241231    clang-20
powerpc               randconfig-003-20241231    clang-15
powerpc                     redwood_defconfig    clang-20
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241231    clang-20
powerpc64             randconfig-002-20241231    clang-19
powerpc64             randconfig-003-20241231    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241231    clang-20
riscv                 randconfig-002-20241231    clang-15
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241231    gcc-14.2.0
s390                  randconfig-002-20241231    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241231    gcc-14.2.0
sh                    randconfig-002-20241231    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241231    gcc-14.2.0
sparc                 randconfig-002-20241231    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241231    gcc-14.2.0
sparc64               randconfig-002-20241231    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241231    clang-20
um                    randconfig-002-20241231    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241231    clang-19
x86_64      buildonly-randconfig-002-20241231    gcc-12
x86_64      buildonly-randconfig-003-20241231    clang-19
x86_64      buildonly-randconfig-004-20241231    gcc-12
x86_64      buildonly-randconfig-005-20241231    clang-19
x86_64      buildonly-randconfig-006-20241231    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241231    gcc-14.2.0
xtensa                randconfig-002-20241231    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

