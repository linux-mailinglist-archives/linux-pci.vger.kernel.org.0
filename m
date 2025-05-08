Return-Path: <linux-pci+bounces-27412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B837BAAF1BF
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6656B1897DED
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F52155335;
	Thu,  8 May 2025 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gR4yzkPY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1684B1E7A
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675267; cv=none; b=VnaPlpAnjTHANPptTa5bZsRoe7pN1EF+JppRjBgCQ2+zSkQzLKz/FoNFenSIETEkbhdA8z1bAmJnGg4e3fy3PbLN9B1NZd1aicnIKwbVI/mvcHo0nuTFrfjHFWV46p9PTYh2mnkY3BRUwX5B9ojNDbkP03uJO9qbNG2ABJQU+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675267; c=relaxed/simple;
	bh=hLiRmbxo5RxTozMKy9mjwL0M/bD+uT1x8IXmu+27BAE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gnafU1y+/tU5vZwTV9XIg/ZpQiNK8v1V4qv0xrOsq1i3FyaeifOgdR6HhXxHgN3/eSmkcXdB8je11E7po9TWYDNyM5cCySed2zP5CqKtw9w7qG9EjJluTlwykinzdrGKYjnS4R9gaRFecPh0FcoAMjQ710qq1CeyVs6lz20o4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gR4yzkPY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746675267; x=1778211267;
  h=date:from:to:cc:subject:message-id;
  bh=hLiRmbxo5RxTozMKy9mjwL0M/bD+uT1x8IXmu+27BAE=;
  b=gR4yzkPYoKdoXr9u7Nv+nqoZlAe5LpeeQfjAX6ZGiWflWqB+l4rAF7cg
   F5Kp34rwmhTr6cn4gcxqrZbwDXkIy4oobMg8TJ4ZNgzGzlD0KCREW8JlX
   pHkO6CmjWySRB/pcy8q2JyfXevg3AFvgZzIxmTg7oHi6S9CirUZNJl3se
   J9r+dghCjnO57SHg08LJOcCqPLV3gG6VH61Hz5VJYJX0coirY1qkaDqzt
   QBiqCVE4Si8XBQK2Y4DcwS1P3JpCVQcGlDvK1e+OoeUZckCS0IMW/YPaB
   V1QSBIZX3tbu45yozN8zFdHC4S0nI1Ve+ttyVgwWqx0B6Jgx8uCcx7BDS
   w==;
X-CSE-ConnectionGUID: kn7+gQc5QaGFy0Zv0k76oA==
X-CSE-MsgGUID: uMWvaxD1SlybjDQkq9+42w==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58637856"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="58637856"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 20:34:26 -0700
X-CSE-ConnectionGUID: Oq04svBhRVGfebUWNcIqSw==
X-CSE-MsgGUID: wCkBGbxqRYawOTJlSiaKyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="141036860"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2025 20:34:24 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCs1e-0009lJ-17;
	Thu, 08 May 2025 03:34:22 +0000
Date: Thu, 08 May 2025 11:34:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 3e7d050cb72983302617a68f197e089bfc40b546
Message-ID: <202505081104.wo6rX3kV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 3e7d050cb72983302617a68f197e089bfc40b546  PCI: Limit visibility of match_driver flag to PCI core

elapsed time: 13637m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250429    gcc-13.3.0
arc                   randconfig-002-20250429    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                   randconfig-001-20250429    gcc-7.5.0
arm                   randconfig-002-20250429    clang-20
arm                   randconfig-003-20250429    gcc-10.5.0
arm                   randconfig-004-20250429    clang-21
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250429    gcc-7.5.0
arm64                 randconfig-002-20250429    clang-21
arm64                 randconfig-003-20250429    gcc-9.5.0
arm64                 randconfig-004-20250429    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250429    gcc-14.2.0
csky                  randconfig-002-20250429    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250429    clang-21
hexagon               randconfig-002-20250429    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250429    gcc-12
i386        buildonly-randconfig-002-20250429    gcc-11
i386        buildonly-randconfig-003-20250429    gcc-12
i386        buildonly-randconfig-004-20250429    gcc-12
i386        buildonly-randconfig-005-20250429    clang-20
i386        buildonly-randconfig-006-20250429    gcc-12
i386                                defconfig    clang-20
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250429    gcc-14.2.0
loongarch             randconfig-002-20250429    gcc-13.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
mips                         db1xxx_defconfig    clang-21
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250429    gcc-11.5.0
nios2                 randconfig-002-20250429    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250429    gcc-14.2.0
parisc                randconfig-002-20250429    gcc-10.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      chrp32_defconfig    clang-19
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250429    clang-21
powerpc               randconfig-002-20250429    clang-21
powerpc               randconfig-003-20250429    clang-21
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250429    clang-21
powerpc64             randconfig-002-20250429    clang-21
powerpc64             randconfig-003-20250429    gcc-7.5.0
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250429    gcc-14.2.0
riscv                 randconfig-002-20250429    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250429    clang-21
s390                  randconfig-002-20250429    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250429    gcc-5.5.0
sh                    randconfig-002-20250429    gcc-13.3.0
sh                           se7705_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250429    gcc-12.4.0
sparc                 randconfig-002-20250429    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250429    gcc-12.4.0
sparc64               randconfig-002-20250429    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250429    clang-18
um                    randconfig-002-20250429    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250429    gcc-12
x86_64      buildonly-randconfig-002-20250429    gcc-12
x86_64      buildonly-randconfig-003-20250429    clang-20
x86_64      buildonly-randconfig-004-20250429    gcc-12
x86_64      buildonly-randconfig-005-20250429    clang-20
x86_64      buildonly-randconfig-006-20250429    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250429    gcc-14.2.0
xtensa                randconfig-002-20250429    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

