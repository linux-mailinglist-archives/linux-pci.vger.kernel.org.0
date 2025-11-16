Return-Path: <linux-pci+bounces-41323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F63C6118D
	for <lists+linux-pci@lfdr.de>; Sun, 16 Nov 2025 08:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B86F3594AA
	for <lists+linux-pci@lfdr.de>; Sun, 16 Nov 2025 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8076222578;
	Sun, 16 Nov 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/zPWqxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0429CF5
	for <linux-pci@vger.kernel.org>; Sun, 16 Nov 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763279905; cv=none; b=WaPZr4Kb7LLN8lq3w5ajZjARpNXGly0p6CNp8H/FwiG7i+MBnkASXn346TRCgz8bEJ8eakaj/FKEaOoa4E7xCsC3GVtBLOVRpeiJkADCr0znIpgW5YHzfZkjufx3PWT162J9XbpRX83j/rMv2ZWULOSg2621ewZnEFApN00Q8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763279905; c=relaxed/simple;
	bh=5o1PnRRDHB7cJrWIjqY5qiX5uEfwc9TxSMmQcMxzZy0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LqZ/nmxNnpQaCHdBZENcRtqV4SzzM7tVnzxJ+UQX7knI6KF1gIX1+AAJA8OklZg9iNt+WZcPDVr4nvF0PDws42tAUK2xPpMy8AT8Hv232ywQlEfKcB/Yhvu9PComirPJc3wn3I8fB7IQGUWf90oyzmkI8LkoI+UkJmYEhX+wCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/zPWqxA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763279904; x=1794815904;
  h=date:from:to:cc:subject:message-id;
  bh=5o1PnRRDHB7cJrWIjqY5qiX5uEfwc9TxSMmQcMxzZy0=;
  b=l/zPWqxADnsUfW23GRhDwTRPENS4y6j2drxFrmyPDo4CbORJE1IqEB3l
   kqH2At18evTvLhBVFjTGz0Z0/aM3UjF+iV2ruS7krKAJpqqOigie7nEfV
   CtrqbGNghUJA6hv5UMnd8A0sMAQkWEV8lPONUdFGqsPd95rXj5jy7wJZ5
   O4sahh69vkXYO6K6WDs2i5nTancwtBz2mTFp45a0iiO3yFxzwNXyYgW1S
   2I9iTPf6vS9HF82//QoI+ajzg7/TosQr27j/kCBMdioQAPRgyK2C59/Dq
   IjuaJOF734RflHz0FhKUeX2AmsnIEXxaf5nWG11BB1MZ16elyCvMVDafA
   A==;
X-CSE-ConnectionGUID: rUI5VoHGSRSZcdUm6QZiGw==
X-CSE-MsgGUID: fYcOp2C+SkKwUwVI7uJSkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="75912858"
X-IronPort-AV: E=Sophos;i="6.19,309,1754982000"; 
   d="scan'208";a="75912858"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 23:58:23 -0800
X-CSE-ConnectionGUID: Pk4lRwmqTkOASepQ0Jg3Pw==
X-CSE-MsgGUID: xGrdNaZIQa6yhtBdKZmlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,309,1754982000"; 
   d="scan'208";a="190334967"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Nov 2025 23:58:22 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKXeO-0008cF-0C;
	Sun, 16 Nov 2025 07:58:20 +0000
Date: Sun, 16 Nov 2025 15:57:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 bf0a90fc907e47344f88e5b9b241082184dbac27
Message-ID: <202511161545.4jqUchCF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: bf0a90fc907e47344f88e5b9b241082184dbac27  PCI: Convert BAR sizes bitmasks to u64

elapsed time: 2183m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251115    gcc-13.4.0
arc                   randconfig-002-20251115    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20251115    clang-22
arm                   randconfig-002-20251115    gcc-8.5.0
arm                   randconfig-003-20251115    gcc-10.5.0
arm                   randconfig-004-20251115    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251116    gcc-12.5.0
arm64                 randconfig-002-20251116    gcc-10.5.0
arm64                 randconfig-003-20251116    clang-22
arm64                 randconfig-004-20251116    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251116    gcc-12.5.0
csky                  randconfig-002-20251116    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251116    clang-22
hexagon               randconfig-002-20251116    clang-17
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251116    clang-20
i386        buildonly-randconfig-002-20251116    clang-20
i386        buildonly-randconfig-003-20251116    clang-20
i386        buildonly-randconfig-004-20251116    gcc-14
i386        buildonly-randconfig-005-20251116    clang-20
i386        buildonly-randconfig-006-20251116    clang-20
i386                  randconfig-011-20251116    clang-20
i386                  randconfig-012-20251116    gcc-14
i386                  randconfig-013-20251116    gcc-14
i386                  randconfig-014-20251116    clang-20
i386                  randconfig-015-20251116    gcc-12
i386                  randconfig-016-20251116    clang-20
i386                  randconfig-017-20251116    gcc-14
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251116    gcc-15.1.0
loongarch             randconfig-002-20251116    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251116    gcc-11.5.0
nios2                 randconfig-002-20251116    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251116    gcc-12.5.0
parisc                randconfig-002-20251116    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc8315_rdb_defconfig    clang-22
powerpc               randconfig-001-20251116    gcc-10.5.0
powerpc               randconfig-002-20251116    clang-22
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251116    clang-22
powerpc64             randconfig-002-20251116    gcc-10.5.0
riscv                            alldefconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251115    clang-22
riscv                 randconfig-002-20251115    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251115    clang-17
s390                  randconfig-002-20251115    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251115    gcc-12.5.0
sh                    randconfig-002-20251115    gcc-15.1.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251116    gcc-8.5.0
sparc                 randconfig-002-20251116    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251116    gcc-15.1.0
sparc64               randconfig-002-20251116    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251116    clang-17
um                    randconfig-002-20251116    gcc-13
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251116    clang-20
x86_64      buildonly-randconfig-002-20251116    clang-20
x86_64      buildonly-randconfig-003-20251116    clang-20
x86_64      buildonly-randconfig-004-20251116    gcc-13
x86_64      buildonly-randconfig-005-20251116    clang-20
x86_64      buildonly-randconfig-006-20251116    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-012-20251116    clang-20
x86_64                randconfig-013-20251116    gcc-14
x86_64                randconfig-071-20251116    clang-20
x86_64                randconfig-072-20251116    clang-20
x86_64                randconfig-073-20251116    clang-20
x86_64                randconfig-074-20251116    clang-20
x86_64                randconfig-075-20251116    clang-20
x86_64                randconfig-076-20251116    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251116    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

