Return-Path: <linux-pci+bounces-43759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E933DCDF49C
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 06:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F59C3001028
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 05:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA21EEA55;
	Sat, 27 Dec 2025 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSd2V2X1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53177261A
	for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766813135; cv=none; b=JxRdD7FEwE7MBM6mt7Xb0gsubRP14OvdmiLAvynuZsxdXLy7Sf6MKOCSOw0fZpgbkoua5+peo4qcG9OrFqrn/yIM1Hqf9aCC7ieDLJFoi9jA2gOjXoEHGIhMyJXfzU8ZViSNnsfMJx+P5zvMrjfexnZVXiHgztnkJYhaefHU7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766813135; c=relaxed/simple;
	bh=s5KewPWpr4xSkLMj8R87qeMHUyJ89fRXYLp5dAg/irM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HZtkSkNWI77L6INANWrYhpXxUDUIMlOJ+iPJpBvvs5i4ZSspXTDfbGNogA7obdMLAJBJLELpjS0lyaCSgIBF3ooXsURdlF11ke1RTcGKitD5atUdoK4/qRaRRjnMVNTNE8h8gvq7l2pLjUk6PsN4XOuSWPg9MPW2N2jjv3WgquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSd2V2X1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766813133; x=1798349133;
  h=date:from:to:cc:subject:message-id;
  bh=s5KewPWpr4xSkLMj8R87qeMHUyJ89fRXYLp5dAg/irM=;
  b=JSd2V2X1El/6sKhn2vHO6va5be0HMxThgQ7p3JS+9zGinoaWBxsUtSJh
   KOfKbjl41EeEyxmrRYq6HJBDAecgEEtyM1FnPCecuWbjo4b4XWUJEmALB
   seWo08h45SP1rn9vcb8I9NAWOr7Scl08h2shdX2gBBIjyoXIWpN3xcCq4
   US/Ll7Y75Cg11Ercx2q9Dnd8eHOpDBwJqNEW3QWkmzXmAJLRnRER06EI9
   PWyyJXuCobVoJYShCupj5WPKf4dY7lZjAhiEhx92QvKepILGfAjNYoSNU
   YC+GzgpYD/t3CMxO0Zl5PE5M63cFoAWfzWD1nTkNGXQpq6QblftksoCFj
   Q==;
X-CSE-ConnectionGUID: mcRuOu/QRQmZAVRbb3dLzg==
X-CSE-MsgGUID: tBsu0DVSTIWYqycgpJHp7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11653"; a="78842122"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="78842122"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 21:25:32 -0800
X-CSE-ConnectionGUID: iEu5h4fgSi+JMcF08rcUHQ==
X-CSE-MsgGUID: FYzSigvMTVWEJQh4JlwRxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="200236428"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Dec 2025 21:25:30 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZMnw-000000005Zt-2xYW;
	Sat, 27 Dec 2025 05:25:28 +0000
Date: Sat, 27 Dec 2025 13:25:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra] BUILD SUCCESS
 aac5ba6acc79b37b01dfc9dd23eb457c89cf06f6
Message-ID: <202512271313.BHHTZjva-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra
branch HEAD: aac5ba6acc79b37b01dfc9dd23eb457c89cf06f6  PCI: tegra: Allow building as a module

elapsed time: 744m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251227    gcc-11.5.0
arc                   randconfig-002-20251227    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251227    gcc-8.5.0
arm                   randconfig-002-20251227    clang-22
arm                   randconfig-003-20251227    clang-22
arm                   randconfig-004-20251227    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251227    clang-19
arm64                 randconfig-002-20251227    gcc-15.1.0
arm64                 randconfig-003-20251227    clang-20
arm64                 randconfig-004-20251227    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251227    gcc-15.1.0
csky                  randconfig-002-20251227    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251227    clang-22
hexagon               randconfig-002-20251227    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251227    clang-20
i386        buildonly-randconfig-002-20251227    clang-20
i386        buildonly-randconfig-003-20251227    clang-20
i386        buildonly-randconfig-004-20251227    clang-20
i386        buildonly-randconfig-005-20251227    clang-20
i386        buildonly-randconfig-006-20251227    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251227    clang-20
i386                  randconfig-002-20251227    clang-20
i386                  randconfig-003-20251227    clang-20
i386                  randconfig-004-20251227    gcc-13
i386                  randconfig-005-20251227    gcc-14
i386                  randconfig-006-20251227    gcc-14
i386                  randconfig-007-20251227    clang-20
i386                  randconfig-011-20251227    gcc-14
i386                  randconfig-012-20251227    clang-20
i386                  randconfig-013-20251227    gcc-14
i386                  randconfig-014-20251227    gcc-14
i386                  randconfig-015-20251227    gcc-12
i386                  randconfig-016-20251227    clang-20
i386                  randconfig-017-20251227    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251227    clang-18
loongarch             randconfig-002-20251227    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251227    gcc-11.5.0
nios2                 randconfig-002-20251227    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251227    gcc-8.5.0
parisc                randconfig-002-20251227    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-22
powerpc               randconfig-001-20251227    gcc-8.5.0
powerpc               randconfig-002-20251227    clang-22
powerpc64             randconfig-001-20251227    clang-22
powerpc64             randconfig-002-20251227    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20251227    clang-22
riscv                 randconfig-002-20251227    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251227    clang-22
s390                  randconfig-002-20251227    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251227    gcc-15.1.0
sh                    randconfig-002-20251227    gcc-15.1.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251227    gcc-14.3.0
sparc                 randconfig-002-20251227    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251227    gcc-8.5.0
sparc64               randconfig-002-20251227    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251227    clang-22
um                    randconfig-002-20251227    clang-19
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251227    clang-20
x86_64      buildonly-randconfig-002-20251227    clang-20
x86_64      buildonly-randconfig-003-20251227    gcc-14
x86_64      buildonly-randconfig-004-20251227    clang-20
x86_64      buildonly-randconfig-005-20251227    clang-20
x86_64      buildonly-randconfig-006-20251227    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251227    gcc-14
x86_64                randconfig-002-20251227    gcc-12
x86_64                randconfig-003-20251227    gcc-14
x86_64                randconfig-004-20251227    clang-20
x86_64                randconfig-005-20251227    gcc-14
x86_64                randconfig-006-20251227    clang-20
x86_64                randconfig-011-20251227    gcc-14
x86_64                randconfig-012-20251227    clang-20
x86_64                randconfig-013-20251227    clang-20
x86_64                randconfig-014-20251227    gcc-14
x86_64                randconfig-015-20251227    gcc-13
x86_64                randconfig-016-20251227    gcc-14
x86_64                randconfig-071-20251227    clang-20
x86_64                randconfig-072-20251227    clang-20
x86_64                randconfig-073-20251227    clang-20
x86_64                randconfig-074-20251227    clang-20
x86_64                randconfig-075-20251227    clang-20
x86_64                randconfig-076-20251227    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251227    gcc-9.5.0
xtensa                randconfig-002-20251227    gcc-12.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

