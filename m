Return-Path: <linux-pci+bounces-24443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99231A6CBC1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 18:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C009188A99B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D3715CD46;
	Sat, 22 Mar 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3iYnyO/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44B22B8C3
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742666342; cv=none; b=G0avR2AqRe5vuSscTzUOD+l7u3+U39WPjFdVN7EF9LOGMnmt+jlDWKT7u2voMKSaPo9L2zJZptYi86ruebpbQ2PpmzEvonARA5Ft3pmgnROeM3kqYsBmTZ+Rx8DqR+e2E/wzvkRxaAcu1Y2StPAIihKp4Ta57O7MeMDGYQ6HRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742666342; c=relaxed/simple;
	bh=ZiA7Ur2YkX34Gz0vCSVtJcdowLhCDZ/nYr7DBsYCcuw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cfti4KPlQtwfwWMquL15uQNNA6ZUH/O+zNspRfPh/L0fEf+1MeNolqHjmDwute/TPieWqviS3rulpbkde2ocEBACI4RbDTVXYb0F8CekPi2SZ3kGFFsjpAtnVQBbNcHeNzxToBMHDwoGe4IDSg8H/rQuZNmYiZQD0x29cr2mVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3iYnyO/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742666340; x=1774202340;
  h=date:from:to:cc:subject:message-id;
  bh=ZiA7Ur2YkX34Gz0vCSVtJcdowLhCDZ/nYr7DBsYCcuw=;
  b=n3iYnyO/TsHWHEY2eEjudL4G2Cjb765Cz94Xx+5aNqzRZjNKF3tVaI1L
   m7Jjn7vA0c+YWXU8AEly9F0ZLn2P0z2xtSqYpXJObSr8EGzFNNN3sA2+6
   YPDlSk9ZMZqAk2zMU3nYgYzo6pSn7qhPjJ08khZfyCeYi8NwvMv2Rm5XO
   eWNRcO7f9aj7sLsRQgTr/tezOynxzs79Acqy3+hsFfo00TCdR5wFaOzZV
   nNQ3jmmjbLtzTCdcI+cnccvbvy8a6WFPyP5H24KMeLhBWn6tqjEmGaBff
   1pMIgr6Z/xUHfrDSA7gGOu4ra96qKT3WMPjR8gsbrLKp+s0Z3kShKsR45
   g==;
X-CSE-ConnectionGUID: H3jf2prRQLKbFlkHL645pg==
X-CSE-MsgGUID: sViesy7pQPuJyg6oa2PxOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="55293343"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="55293343"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 10:59:00 -0700
X-CSE-ConnectionGUID: KVgeKV7JSHueYaCqv3jB/w==
X-CSE-MsgGUID: XVJGwIauRWmtCn1HFXa12A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="160896844"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 22 Mar 2025 10:58:38 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw378-0002Jc-2b;
	Sat, 22 Mar 2025 17:58:32 +0000
Date: Sun, 23 Mar 2025 01:57:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD SUCCESS
 026e4bffb0af9632f5a0bbf8d594f2aace44cf07
Message-ID: <202503230128.VetxjpVR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: 026e4bffb0af9632f5a0bbf8d594f2aace44cf07  PCI/bwctrl: Fix pcie_bwctrl_select_speed() return type

elapsed time: 1443m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250322    gcc-10.5.0
arc                   randconfig-002-20250322    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250322    gcc-7.5.0
arm                   randconfig-002-20250322    gcc-7.5.0
arm                   randconfig-003-20250322    clang-21
arm                   randconfig-004-20250322    clang-19
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250322    clang-21
arm64                 randconfig-002-20250322    clang-21
arm64                 randconfig-003-20250322    gcc-8.5.0
arm64                 randconfig-004-20250322    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250322    gcc-14.2.0
csky                  randconfig-002-20250322    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250322    clang-21
hexagon               randconfig-002-20250322    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250322    clang-20
i386        buildonly-randconfig-002-20250322    gcc-12
i386        buildonly-randconfig-003-20250322    gcc-12
i386        buildonly-randconfig-004-20250322    clang-20
i386        buildonly-randconfig-005-20250322    clang-20
i386        buildonly-randconfig-006-20250322    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250322    gcc-14.2.0
loongarch             randconfig-002-20250322    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250322    gcc-6.5.0
nios2                 randconfig-002-20250322    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250322    gcc-5.5.0
parisc                randconfig-002-20250322    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250322    clang-21
powerpc               randconfig-002-20250322    gcc-8.5.0
powerpc               randconfig-003-20250322    clang-21
powerpc64             randconfig-001-20250322    clang-21
powerpc64             randconfig-002-20250322    gcc-8.5.0
powerpc64             randconfig-003-20250322    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250322    gcc-8.5.0
riscv                 randconfig-002-20250322    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250322    gcc-9.3.0
s390                  randconfig-002-20250322    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250322    gcc-10.5.0
sh                    randconfig-002-20250322    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250322    gcc-9.3.0
sparc                 randconfig-002-20250322    gcc-9.3.0
sparc64               randconfig-001-20250322    gcc-5.5.0
sparc64               randconfig-002-20250322    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250322    clang-21
um                    randconfig-002-20250322    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250322    clang-20
x86_64      buildonly-randconfig-002-20250322    clang-20
x86_64      buildonly-randconfig-003-20250322    clang-20
x86_64      buildonly-randconfig-004-20250322    gcc-12
x86_64      buildonly-randconfig-005-20250322    clang-20
x86_64      buildonly-randconfig-006-20250322    gcc-12
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250322    gcc-14.2.0
xtensa                randconfig-002-20250322    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

