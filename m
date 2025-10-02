Return-Path: <linux-pci+bounces-37445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E55BB4967
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AACE3BE868
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0F236A70;
	Thu,  2 Oct 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksJSuyIS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E19186284
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423590; cv=none; b=FDvW2CtTRIXoAF62ivvz5+ZxugPlJtA19q8RoQK9wxXHTUYYTHgc2jmGUb2hEr9adcr5UnzxtvG9uq+xR5U6cgV+CRu+1Lpry+qUMe/pwybpFvWmKuG0D4zvlmQVWN3y10x8YjRv6fHwzGOWZkJ92LJN+UyiTcLFhjNx/LU/XNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423590; c=relaxed/simple;
	bh=Nkyg/KJkuydWyPfTP8YY82CdH04Op1Hrn36KVMQjRY4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I5Cd3wrrni2X/lKjqEHZBcalSWN4NNJSPAWMTlBuO8cw6ml9epg8/77coiN6SN69XkVYUS8d+r1XpHGHBT+q94IdmvVtljxlATvP6VpGqj3PnGxnAB3Lv/RE5gGhB0Cl7w/Rn5FZc7/4qKuvWRNq8/IvnQ0zj32EdGMTNPxo8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksJSuyIS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759423589; x=1790959589;
  h=date:from:to:cc:subject:message-id;
  bh=Nkyg/KJkuydWyPfTP8YY82CdH04Op1Hrn36KVMQjRY4=;
  b=ksJSuyISBzoCZIBi/wxnLECaJRTip2wX47iNAvx9hPUhlVO4xMRkboH1
   XKMjlYI/1n4szVrWV9EG4Muej8X89VblthHDEVaUi4jYfmHVaLQ2WxgBe
   yT0fMeL97u8VRoNPTSgr06M8+1is6kwFaVa8v82fjNh01R6nQuuvs7bC0
   3P1DH6mSoAQa/sqipP4mYqV/Ffvm7eMRmTosQrpq1qj6uPhiMGHHt6jam
   OHsl6s4O4Ho64HP9sf4HgtfeGwpiVBvow51QZZdPL3n7JBsFRQcfXec+m
   jO619Gzh/Z9eY+cqjGEy3X764ac25Z2o81ws8nUkU/EuOiqJRXqkSZfI1
   w==;
X-CSE-ConnectionGUID: 0fWK6vR7QqawH+pLRsT7pA==
X-CSE-MsgGUID: KXi8W8fWRP6xtRTby/BV2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="60751147"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="60751147"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:46:28 -0700
X-CSE-ConnectionGUID: z1T7Kw3YSxK5Y/H2Di5Y6g==
X-CSE-MsgGUID: UZFYc/PGRxyE/RVCg5Sj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="202827884"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Oct 2025 09:46:27 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4MRl-0003xH-1a;
	Thu, 02 Oct 2025 16:46:25 +0000
Date: Fri, 03 Oct 2025 00:45:42 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/stm32] BUILD SUCCESS
 c86a24dfa902fc27dd4d7ce138b25315f7241d47
Message-ID: <202510030032.D1h8a0o0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/stm32
branch HEAD: c86a24dfa902fc27dd4d7ce138b25315f7241d47  MAINTAINERS: Add entry for ST STM32MP25 PCIe drivers

elapsed time: 1540m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251002    gcc-12.5.0
arc                   randconfig-002-20251002    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251002    gcc-12.5.0
arm                   randconfig-002-20251002    clang-22
arm                   randconfig-003-20251002    clang-22
arm                   randconfig-004-20251002    clang-20
arm                           sama5_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251002    gcc-8.5.0
arm64                 randconfig-002-20251002    clang-22
arm64                 randconfig-003-20251002    clang-22
arm64                 randconfig-004-20251002    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251002    gcc-15.1.0
csky                  randconfig-002-20251002    gcc-9.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251002    clang-22
hexagon               randconfig-002-20251002    clang-16
i386        buildonly-randconfig-001-20251002    clang-20
i386        buildonly-randconfig-002-20251002    gcc-14
i386        buildonly-randconfig-003-20251002    clang-20
i386        buildonly-randconfig-004-20251002    clang-20
i386        buildonly-randconfig-005-20251002    gcc-14
i386        buildonly-randconfig-006-20251002    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251002    gcc-15.1.0
loongarch             randconfig-002-20251002    clang-18
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                       rbtx49xx_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251002    gcc-11.5.0
nios2                 randconfig-002-20251002    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251002    gcc-9.5.0
parisc                randconfig-002-20251002    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251002    gcc-8.5.0
powerpc               randconfig-002-20251002    gcc-9.5.0
powerpc               randconfig-003-20251002    clang-22
powerpc64             randconfig-001-20251002    clang-22
powerpc64             randconfig-002-20251002    clang-22
powerpc64             randconfig-003-20251002    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251002    clang-22
riscv                 randconfig-002-20251002    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251002    gcc-14.3.0
s390                  randconfig-002-20251002    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251002    gcc-13.4.0
sh                    randconfig-002-20251002    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251002    gcc-8.5.0
sparc                 randconfig-002-20251002    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251002    clang-22
sparc64               randconfig-002-20251002    gcc-8.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251002    clang-22
um                    randconfig-002-20251002    clang-22
um                           x86_64_defconfig    clang-22
x86_64      buildonly-randconfig-001-20251002    gcc-13
x86_64      buildonly-randconfig-002-20251002    clang-20
x86_64      buildonly-randconfig-003-20251002    clang-20
x86_64      buildonly-randconfig-004-20251002    clang-20
x86_64      buildonly-randconfig-005-20251002    gcc-14
x86_64      buildonly-randconfig-006-20251002    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251002    gcc-8.5.0
xtensa                randconfig-002-20251002    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

