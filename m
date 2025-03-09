Return-Path: <linux-pci+bounces-23257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31725A58865
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 22:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4678188DE76
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B0221B1AC;
	Sun,  9 Mar 2025 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbGlzJoq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73712C499
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741554673; cv=none; b=rWllXZBvIGRImV/HIKj0cocJ+F2IN5w6429v0F/ZI0oxLd7EHCsV/CxvGpbjNPC9GjkQXA6aMfsB/uRkDhDOoR6mK4lnKb0HeVKFvpFDeVfzZtTSkroPhteMEEVdvc1Aigig0/Da5gIqxpajo9ucD5H8f48wTlljLUWHIZLtGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741554673; c=relaxed/simple;
	bh=DCSL94WVeEaTScCxcSlgR5iZakp9vhNgu7X0EmIQez8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oNSKNilRlJr66fMA4+xNolIo9uMJIukrSp55UkLe2TEVvSEqLBYAe7uoGSr3YLv65bwd1xQI0IKgjyeZ7tFPUY6NLqJkCdknRvKGfd7lkV36M3+3noyLgFZgVoc02HkVzOthvoMkq3s1Pb5AFFyKc3Xp6DTOnQ2zsn2Y/fhZoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbGlzJoq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741554672; x=1773090672;
  h=date:from:to:cc:subject:message-id;
  bh=DCSL94WVeEaTScCxcSlgR5iZakp9vhNgu7X0EmIQez8=;
  b=jbGlzJoqwpS/03cA3nUIkdkOJlLQF4apxzDvgKAqgRSs/1AJxG73jncU
   huUIkzedtaSI1tSrmS9jbyulCEO3vVAmVCBiPukihxPuajfHLfts6ai1S
   WAF9r9ngtfesdaoDawW5N9aTVgqpAfLiic5xqZ2iYNXR4omn+z8eqHrTI
   q5jHyXKFUOWRhL6oNh6QZ050A9M3qhfUr26PKJDgifghihyufzuPXfvBi
   fmG3SUcw9WuxKkjsvqZ3jzXMpndGrUURJPgmqLyd43IO2wdgwrj5FJCvi
   m8Kb5LwaVeq62PZrHFZAg+SHjn7KVgfzkP1iLGpZgfbiNUfD2NK36dMub
   w==;
X-CSE-ConnectionGUID: ObkjXr8wT4uwVxfdOqyLrg==
X-CSE-MsgGUID: r1vFwwDzQ0KzEbG8b3Snkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42681360"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42681360"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 14:11:11 -0700
X-CSE-ConnectionGUID: QSQuy3zfQs2MIpihYpejDA==
X-CSE-MsgGUID: wATbeBbzQ0qYqFiouZfIzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="125066817"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 09 Mar 2025 14:11:10 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trNvN-0003TM-15;
	Sun, 09 Mar 2025 21:11:05 +0000
Date: Mon, 10 Mar 2025 05:10:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 2be8a520690fcef6319e3d5519e99d5e1f708ad4
Message-ID: <202503100505.fpSqqPpm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 2be8a520690fcef6319e3d5519e99d5e1f708ad4  Merge branch 'pci/misc'

elapsed time: 1383m

configs tested: 120
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250309    gcc-13.2.0
arc                   randconfig-002-20250309    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250309    clang-21
arm                   randconfig-002-20250309    gcc-14.2.0
arm                   randconfig-003-20250309    clang-21
arm                   randconfig-004-20250309    gcc-14.2.0
arm                        realview_defconfig    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250309    clang-15
arm64                 randconfig-002-20250309    clang-17
arm64                 randconfig-003-20250309    clang-15
arm64                 randconfig-004-20250309    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250309    gcc-14.2.0
csky                  randconfig-002-20250309    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250309    clang-21
hexagon               randconfig-002-20250309    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250309    clang-19
i386        buildonly-randconfig-002-20250309    clang-19
i386        buildonly-randconfig-003-20250309    gcc-11
i386        buildonly-randconfig-004-20250309    gcc-12
i386        buildonly-randconfig-005-20250309    clang-19
i386        buildonly-randconfig-006-20250309    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250309    gcc-14.2.0
loongarch             randconfig-002-20250309    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250309    gcc-14.2.0
nios2                 randconfig-002-20250309    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250309    gcc-14.2.0
parisc                randconfig-002-20250309    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250309    gcc-14.2.0
powerpc               randconfig-002-20250309    clang-21
powerpc               randconfig-003-20250309    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250309    clang-15
powerpc64             randconfig-002-20250309    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250309    clang-15
riscv                 randconfig-002-20250309    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250309    clang-16
s390                  randconfig-002-20250309    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250309    gcc-14.2.0
sh                    randconfig-002-20250309    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250309    gcc-14.2.0
sparc                 randconfig-002-20250309    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250309    gcc-14.2.0
sparc64               randconfig-002-20250309    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250309    clang-21
um                    randconfig-002-20250309    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250309    gcc-12
x86_64      buildonly-randconfig-002-20250309    gcc-11
x86_64      buildonly-randconfig-003-20250309    gcc-12
x86_64      buildonly-randconfig-004-20250309    gcc-12
x86_64      buildonly-randconfig-005-20250309    clang-19
x86_64      buildonly-randconfig-006-20250309    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250309    gcc-14.2.0
xtensa                randconfig-002-20250309    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

