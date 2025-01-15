Return-Path: <linux-pci+bounces-19930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3CA12F5F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 00:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57BF3A61EC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198781DAC9D;
	Wed, 15 Jan 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjTPtQax"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898224A7CE
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985044; cv=none; b=TVSjcQOMoi+43VFnlgmmkLtXQ+/xdRxxW9YnKuwPW+pQa/xEoMoysee1EB/+QBB8TnHNvzxw6ZSPA6whBDl6oI3muHKmluFntUggqYbQNZ8xXZELFoWuQ1/zGGnTbFrjqNJGItJ75gq3NR8QnxI07zohIPFIWVPkCKDWXvVRrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985044; c=relaxed/simple;
	bh=iHFcZKDxR8fHpnSORuCsrqijxYkNvmx2brql/tk8LV4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LIGwToMMkhKfnyuK4wDmQw+IGgljNxmEJvrQQ4BfrfAmpBQU56bkjgLx91GCRUtRzysqRw5Zr95d9RDaiIpA/WSnKS9xGRJo9ijCDXsxSCJSAN0jne4+Jfk6ax+BpBYxIsHzqFC2hSnMhc6F+d2nohwppkfD2TVgJRjaGQPPYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjTPtQax; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736985042; x=1768521042;
  h=date:from:to:cc:subject:message-id;
  bh=iHFcZKDxR8fHpnSORuCsrqijxYkNvmx2brql/tk8LV4=;
  b=SjTPtQaxIaY5RgpJukxhwyqF22hKYE9aZinkzVsMR5f4732tZ9XNcFG9
   t74KCIq1xB4Ut3pWYhVCPykO5ZcJg4TJjzNde0llS+Fju8HOQ0N8+44xd
   D6nH4tCKBrDQLvq34vDMXRJJkRJ6rWpIpuMgPMKC2KTf8pgfAkH5bCLJq
   7J3CJ9bi6GDHATtepDaeSsBQdG+MkRnFIQiCviG4Yk2L50vtBlJSBDlXo
   uyR+3taAzvKJx8IzQOlDwv8CtViQFkP71mz2qQljnji+Q7MSPR0VUL6MO
   OjLqJXBc6AFDfweIoRybR7zl0KOSD6m9YWY0I3ZGK5FIcs+M8ZZKB1SPd
   Q==;
X-CSE-ConnectionGUID: KIjTvYRrQ5mMOxgh346Znw==
X-CSE-MsgGUID: y/K8KOS1RhKRvJzr1Ptxpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="54761256"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="54761256"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 15:50:41 -0800
X-CSE-ConnectionGUID: NBSSC95JROe+rWzYBkhF3w==
X-CSE-MsgGUID: ZwD2DI+XREGX/+oDujofZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109331007"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jan 2025 15:50:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYD9i-000R2R-0q;
	Wed, 15 Jan 2025 23:50:38 +0000
Date: Thu, 16 Jan 2025 07:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/microchip] BUILD SUCCESS
 affaf4cbc07f65556db7a72d80c441abfedd93f4
Message-ID: <202501160707.91SOcCeH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/microchip
branch HEAD: affaf4cbc07f65556db7a72d80c441abfedd93f4  dt-bindings: PCI: microchip,pcie-host: Allow dma-noncoherent

elapsed time: 1454m

configs tested: 203
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                   randconfig-001-20250115    gcc-13.2.0
arc                   randconfig-001-20250116    clang-15
arc                   randconfig-002-20250115    gcc-13.2.0
arc                   randconfig-002-20250116    clang-15
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250115    clang-16
arm                   randconfig-001-20250116    clang-15
arm                   randconfig-002-20250115    clang-20
arm                   randconfig-002-20250116    clang-15
arm                   randconfig-003-20250115    clang-20
arm                   randconfig-003-20250116    clang-15
arm                   randconfig-004-20250115    clang-20
arm                   randconfig-004-20250116    clang-15
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250115    clang-20
arm64                 randconfig-001-20250116    clang-15
arm64                 randconfig-002-20250115    gcc-14.2.0
arm64                 randconfig-002-20250116    clang-15
arm64                 randconfig-003-20250115    clang-18
arm64                 randconfig-003-20250116    clang-15
arm64                 randconfig-004-20250115    gcc-14.2.0
arm64                 randconfig-004-20250116    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250115    gcc-14.2.0
csky                  randconfig-001-20250116    clang-20
csky                  randconfig-002-20250115    gcc-14.2.0
csky                  randconfig-002-20250116    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20250115    clang-20
hexagon               randconfig-001-20250116    clang-20
hexagon               randconfig-002-20250115    clang-19
hexagon               randconfig-002-20250116    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250115    clang-19
i386        buildonly-randconfig-001-20250116    clang-19
i386        buildonly-randconfig-002-20250115    gcc-12
i386        buildonly-randconfig-002-20250116    clang-19
i386        buildonly-randconfig-003-20250115    gcc-12
i386        buildonly-randconfig-003-20250116    clang-19
i386        buildonly-randconfig-004-20250115    gcc-12
i386        buildonly-randconfig-004-20250116    clang-19
i386        buildonly-randconfig-005-20250115    gcc-12
i386        buildonly-randconfig-005-20250116    clang-19
i386        buildonly-randconfig-006-20250115    gcc-12
i386        buildonly-randconfig-006-20250116    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250116    clang-19
i386                  randconfig-002-20250116    clang-19
i386                  randconfig-003-20250116    clang-19
i386                  randconfig-004-20250116    clang-19
i386                  randconfig-005-20250116    clang-19
i386                  randconfig-006-20250116    clang-19
i386                  randconfig-007-20250116    clang-19
i386                  randconfig-011-20250116    gcc-12
i386                  randconfig-012-20250116    gcc-12
i386                  randconfig-013-20250116    gcc-12
i386                  randconfig-014-20250116    gcc-12
i386                  randconfig-015-20250116    gcc-12
i386                  randconfig-016-20250116    gcc-12
i386                  randconfig-017-20250116    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250115    gcc-14.2.0
loongarch             randconfig-001-20250116    clang-20
loongarch             randconfig-002-20250115    gcc-14.2.0
loongarch             randconfig-002-20250116    clang-20
m68k                              allnoconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250115    gcc-14.2.0
nios2                 randconfig-001-20250116    clang-20
nios2                 randconfig-002-20250115    gcc-14.2.0
nios2                 randconfig-002-20250116    clang-20
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250115    gcc-14.2.0
parisc                randconfig-001-20250116    clang-20
parisc                randconfig-002-20250115    gcc-14.2.0
parisc                randconfig-002-20250116    clang-20
powerpc                           allnoconfig    clang-20
powerpc                 linkstation_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250115    gcc-14.2.0
powerpc               randconfig-001-20250116    clang-20
powerpc               randconfig-002-20250115    gcc-14.2.0
powerpc               randconfig-002-20250116    clang-20
powerpc               randconfig-003-20250115    gcc-14.2.0
powerpc               randconfig-003-20250116    clang-20
powerpc64             randconfig-001-20250115    gcc-14.2.0
powerpc64             randconfig-001-20250116    clang-20
powerpc64             randconfig-002-20250115    gcc-14.2.0
powerpc64             randconfig-002-20250116    clang-20
powerpc64             randconfig-003-20250115    clang-18
powerpc64             randconfig-003-20250116    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250115    gcc-14.2.0
riscv                 randconfig-001-20250116    gcc-14.2.0
riscv                 randconfig-002-20250115    clang-16
riscv                 randconfig-002-20250116    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250115    clang-20
s390                  randconfig-001-20250116    gcc-14.2.0
s390                  randconfig-002-20250115    clang-15
s390                  randconfig-002-20250116    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250115    gcc-14.2.0
sh                    randconfig-001-20250116    gcc-14.2.0
sh                    randconfig-002-20250115    gcc-14.2.0
sh                    randconfig-002-20250116    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250115    gcc-14.2.0
sparc                 randconfig-001-20250116    gcc-14.2.0
sparc                 randconfig-002-20250115    gcc-14.2.0
sparc                 randconfig-002-20250116    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250115    gcc-14.2.0
sparc64               randconfig-001-20250116    gcc-14.2.0
sparc64               randconfig-002-20250115    gcc-14.2.0
sparc64               randconfig-002-20250116    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250115    clang-18
um                    randconfig-001-20250116    gcc-14.2.0
um                    randconfig-002-20250115    gcc-12
um                    randconfig-002-20250116    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250115    gcc-12
x86_64      buildonly-randconfig-001-20250116    gcc-12
x86_64      buildonly-randconfig-002-20250115    gcc-12
x86_64      buildonly-randconfig-002-20250116    gcc-12
x86_64      buildonly-randconfig-003-20250115    clang-19
x86_64      buildonly-randconfig-003-20250116    gcc-12
x86_64      buildonly-randconfig-004-20250115    clang-19
x86_64      buildonly-randconfig-004-20250116    gcc-12
x86_64      buildonly-randconfig-005-20250115    gcc-12
x86_64      buildonly-randconfig-005-20250116    gcc-12
x86_64      buildonly-randconfig-006-20250115    clang-19
x86_64      buildonly-randconfig-006-20250116    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250116    gcc-12
x86_64                randconfig-002-20250116    gcc-12
x86_64                randconfig-003-20250116    gcc-12
x86_64                randconfig-004-20250116    gcc-12
x86_64                randconfig-005-20250116    gcc-12
x86_64                randconfig-006-20250116    gcc-12
x86_64                randconfig-007-20250116    gcc-12
x86_64                randconfig-008-20250116    gcc-12
x86_64                randconfig-071-20250116    gcc-12
x86_64                randconfig-072-20250116    gcc-12
x86_64                randconfig-073-20250116    gcc-12
x86_64                randconfig-074-20250116    gcc-12
x86_64                randconfig-075-20250116    gcc-12
x86_64                randconfig-076-20250116    gcc-12
x86_64                randconfig-077-20250116    gcc-12
x86_64                randconfig-078-20250116    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250115    gcc-14.2.0
xtensa                randconfig-001-20250116    gcc-14.2.0
xtensa                randconfig-002-20250115    gcc-14.2.0
xtensa                randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

