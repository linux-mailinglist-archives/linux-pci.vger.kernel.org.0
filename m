Return-Path: <linux-pci+bounces-33853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56EB2236C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D61AA426E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A12E54A3;
	Tue, 12 Aug 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJCr+2d0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B22E7BAB
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991634; cv=none; b=OevGG9UO/QhOA1hpfUS41IAabheOrN3Qiw3PcAjOGyIEzxQ5C00sEowW5G5TJMpDn16/Y4AXR2kFYqGcsJQWtP1dLDwJG8eMBJhgbYMBvqtquzla8LtzVdxJqa/2KU9rXvIh24J0ppOqyKpGVQyKdJrbvqH8fFenB+fisYobGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991634; c=relaxed/simple;
	bh=+27Nl5xMe6OI2jt1z9XNa+pd/z3DL3nL0o++0f6pyso=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OKFXDPuTv0Xi/UFGGjFbyQ6R81gct982kb/cai7X1G6yPG8H3CN6zrHoifzzf6BxbbHz00a/GvJmVUAfSh7fAuPmTEiXlPI0pbugMKqcqoDh7WKbRv2OiIJFKms++AC7gpCkUfeVJ7ALxS+qvBBG+mS7pRFgW1xLEEYuQBs4keY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJCr+2d0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754991632; x=1786527632;
  h=date:from:to:cc:subject:message-id;
  bh=+27Nl5xMe6OI2jt1z9XNa+pd/z3DL3nL0o++0f6pyso=;
  b=DJCr+2d0Oi7RWbJMEEkBBfvMNosejJh1pEVCY9qsyR1lrf9D0gxZ6I02
   RTeG+qSdc7E8KqJJkPrzzqOD1C8j5hscF9QHs2Vv7rqVBkkaMXbl/4t3r
   DbbPHAoeh9XLxb7aUBgz9Z7oyWMHTgxBgfri2+84bQJajq3WZrF5kTVm4
   OoDXlGkn/nbUj7v5/5KQWqan64XgbYN01Kz8kpwPbDHkvFuWyUtrB83E7
   zX/p0imNU8NFdWD3Np39Ctv5UuajqCBKkRsElFfDATrTbqGqcFzOXZhzw
   lUUePRhddh2fBmZEQ+XAHpJ/v7vMhPU21QWSPjx4mJMmHRcE0j7fMY07z
   A==;
X-CSE-ConnectionGUID: rrIjMHzCSye7mZT8KoK7nQ==
X-CSE-MsgGUID: PDqz0KunRCKUfCirLxuKBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67525128"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67525128"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 02:40:32 -0700
X-CSE-ConnectionGUID: fF/Xk198TZy+TDpkhnEhIQ==
X-CSE-MsgGUID: XzENfNU9RY2Z0urG4rwyXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165341364"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 12 Aug 2025 02:40:31 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ullUa-0006dZ-1o;
	Tue, 12 Aug 2025 09:40:28 +0000
Date: Tue, 12 Aug 2025 17:39:18 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 ddb81c5c911227f0c2ef4cc94a106ebfb3cb2d56
Message-ID: <202508121711.WHIalFfe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: ddb81c5c911227f0c2ef4cc94a106ebfb3cb2d56  dt-bindings: PCI: Add missing "#address-cells" to interrupt controllers

elapsed time: 1332m

configs tested: 134
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
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-002-20250811    gcc-10.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250811    gcc-10.5.0
arm                   randconfig-002-20250811    gcc-13.4.0
arm                   randconfig-003-20250811    clang-22
arm                   randconfig-004-20250811    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250811    clang-22
arm64                 randconfig-002-20250811    clang-19
arm64                 randconfig-003-20250811    clang-20
arm64                 randconfig-004-20250811    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250811    gcc-15.1.0
csky                  randconfig-002-20250811    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-002-20250811    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250811    clang-20
i386        buildonly-randconfig-002-20250811    clang-20
i386        buildonly-randconfig-003-20250811    gcc-12
i386        buildonly-randconfig-004-20250811    gcc-12
i386        buildonly-randconfig-005-20250811    gcc-12
i386        buildonly-randconfig-006-20250811    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250811    gcc-15.1.0
loongarch             randconfig-002-20250811    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      bamboo_defconfig    clang-22
powerpc               randconfig-001-20250811    gcc-13.4.0
powerpc               randconfig-002-20250811    clang-22
powerpc               randconfig-003-20250811    gcc-13.4.0
powerpc64             randconfig-001-20250811    clang-22
powerpc64             randconfig-002-20250811    clang-22
powerpc64             randconfig-003-20250811    gcc-14.3.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250811    gcc-8.5.0
riscv                 randconfig-002-20250811    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250811    gcc-8.5.0
s390                  randconfig-002-20250811    clang-17
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250811    gcc-15.1.0
sh                    randconfig-002-20250811    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250811    gcc-8.5.0
sparc                 randconfig-002-20250811    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250811    clang-22
sparc64               randconfig-002-20250811    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250811    clang-18
um                    randconfig-002-20250811    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250811    gcc-12
x86_64      buildonly-randconfig-002-20250811    clang-20
x86_64      buildonly-randconfig-003-20250811    clang-20
x86_64      buildonly-randconfig-004-20250811    clang-20
x86_64      buildonly-randconfig-005-20250811    clang-20
x86_64      buildonly-randconfig-006-20250811    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-002-20250811    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

