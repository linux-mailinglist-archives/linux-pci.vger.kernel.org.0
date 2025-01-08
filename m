Return-Path: <linux-pci+bounces-19577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC8A06958
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 00:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D83D3A71DC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897802046B7;
	Wed,  8 Jan 2025 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdlrV18T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC961E9B16
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736378056; cv=none; b=cSGojCzFeszeiPPh+Z0hJOzofjReoDKDXVLt4ermuCjzpdFK2WjYfU03pb/yHtftN9URQoWDKD/bSQ0gDcxuV0wEa3GpzJ66NxRYC/nZrIJrCMFOs13EdjOmHR9J6xy/bI/D9+7IYF9swqzYjR8nrUYSsEaZjcakqMqVBiNl6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736378056; c=relaxed/simple;
	bh=D6324zdCR96+/x9YmomjXc4rNxFQl6gzY/mmUvbzYgY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H2zEMEsX2ZHIGiz8dFU8rGvVVoeAfOsy3r7sIAfN4oePAlX9SnPmEwdZfpYhrdLIov9AX93ynw7dgaZSt8UfJXHyNv5HmV8xaaWZI/mHN2UIuH5vCqQdkMJv0N8JGQirgqokGIxXikhQIqJ0JKJ3GbX9dsoxK4zNJ0tigAHiGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdlrV18T; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736378054; x=1767914054;
  h=date:from:to:cc:subject:message-id;
  bh=D6324zdCR96+/x9YmomjXc4rNxFQl6gzY/mmUvbzYgY=;
  b=OdlrV18T498NkEM1wm9ufwvdSDxg6dpJCuW46hdKNmCflnclgBQfVLD7
   COeZuo0vsu4ybx4ZzisD+iqss/uGTCwp6Nzxo9aT2eBTkl+jgoy78Kfpz
   vkPx3xIGrWgj3JVOlDGWhOsGUGwqSPvv/hbEZ889NtiZfelKe43L78PhH
   soIq1bOjo8XxuPDc50pfl3Vq/9zEpgfi3CJB7tp7AwTZqFjHssE7xoRp8
   fb5T+aQXLHAJ1Z3s69xG02Et8zzJgHk4yQBxLv3QrXp0Nm6ptvJHX2WwY
   A+4wmVQBUE4IMJd441AGSwT3BmoNTdiLbaqKkxtUWhBhQajMu/GksHp1a
   Q==;
X-CSE-ConnectionGUID: LsWNTDz7S2yQqOBg34pltA==
X-CSE-MsgGUID: khWINdwrQPijtv18fiCVgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="48034645"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="48034645"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 15:14:07 -0800
X-CSE-ConnectionGUID: Lyq141/OTy+DqG1ke8GONw==
X-CSE-MsgGUID: NWHWyR4sQhGnPWMxA7juEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108350217"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Jan 2025 15:14:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVfFT-000GnD-2O;
	Wed, 08 Jan 2025 23:14:03 +0000
Date: Thu, 09 Jan 2025 07:13:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 94346fb4d119f812507cf43c7bf10a79831d85da
Message-ID: <202501090759.tti8OBYW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 94346fb4d119f812507cf43c7bf10a79831d85da  Merge branch 'pci/misc'

elapsed time: 1462m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250108    gcc-13.2.0
arc                   randconfig-002-20250108    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                           imxrt_defconfig    clang-19
arm                         lpc32xx_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                   randconfig-001-20250108    gcc-14.2.0
arm                   randconfig-002-20250108    gcc-14.2.0
arm                   randconfig-003-20250108    clang-20
arm                   randconfig-004-20250108    clang-18
arm                           sama5_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250108    gcc-14.2.0
arm64                 randconfig-002-20250108    clang-20
arm64                 randconfig-003-20250108    gcc-14.2.0
arm64                 randconfig-004-20250108    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250108    gcc-14.2.0
csky                  randconfig-002-20250108    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250108    clang-20
hexagon               randconfig-002-20250108    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250108    clang-19
i386        buildonly-randconfig-002-20250108    gcc-12
i386        buildonly-randconfig-003-20250108    gcc-12
i386        buildonly-randconfig-004-20250108    gcc-12
i386        buildonly-randconfig-005-20250108    gcc-12
i386        buildonly-randconfig-006-20250108    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250108    gcc-14.2.0
loongarch             randconfig-002-20250108    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-16
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250108    gcc-14.2.0
nios2                 randconfig-002-20250108    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250108    gcc-14.2.0
parisc                randconfig-002-20250108    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc                      pasemi_defconfig    clang-20
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250108    clang-16
powerpc               randconfig-002-20250108    gcc-14.2.0
powerpc               randconfig-003-20250108    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-001-20250108    clang-18
powerpc64             randconfig-002-20250108    clang-16
powerpc64             randconfig-003-20250108    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250108    gcc-14.2.0
riscv                 randconfig-002-20250108    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250108    gcc-14.2.0
s390                  randconfig-002-20250108    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250108    gcc-14.2.0
sh                    randconfig-002-20250108    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250108    gcc-14.2.0
sparc                 randconfig-002-20250108    gcc-14.2.0
sparc64               randconfig-001-20250108    gcc-14.2.0
sparc64               randconfig-002-20250108    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250108    gcc-12
um                    randconfig-002-20250108    clang-16
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250108    clang-19
x86_64      buildonly-randconfig-002-20250108    gcc-11
x86_64      buildonly-randconfig-003-20250108    clang-19
x86_64      buildonly-randconfig-004-20250108    gcc-12
x86_64      buildonly-randconfig-005-20250108    gcc-12
x86_64      buildonly-randconfig-006-20250108    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250108    gcc-14.2.0
xtensa                randconfig-002-20250108    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

