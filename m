Return-Path: <linux-pci+bounces-28211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC4ABF2EA
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6981B1B685F9
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60EC264A70;
	Wed, 21 May 2025 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfQcHWGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71120264A60
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827296; cv=none; b=riz7AKZlcPQW/aQeCQDeA3VWvDV3ilrVJvG6NE55RAfAmnZzzE5hSvM+AYcTFDuIUweWcj8h3MYBpG74mSFRZGSPKWsCZW26ghTxeQ9nzJ6uAb9nX5Ds2bKR+jdyCMqfdcMEZ+/FAg72EBaSRpofeXOEAW1A7j2JMdnvNq4xFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827296; c=relaxed/simple;
	bh=tSrebYQMjU/0ax4fG2OYLDcWRQYsFxrIVtW/yOOZjGo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SYxnh+W0JlYM9UVJZ4EG0w4ybLJ9EgaFkMHSaUloEv6+TSLCtiQI4HDHiCt1SIrGhdO9HECQ0/LGYdWWrt9gnvLqNXTG81wU/s//7ivfYBYOV79nrl87esIQRQSg8qGt0X9U3+3AaDf44Of4xgAgmdOdSdwsOATkBdstsURQScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfQcHWGz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747827295; x=1779363295;
  h=date:from:to:cc:subject:message-id;
  bh=tSrebYQMjU/0ax4fG2OYLDcWRQYsFxrIVtW/yOOZjGo=;
  b=DfQcHWGzizeKV4780mau1U/DUvD7siLV+hfJANcVyoHahr3Q/RPDfqZD
   yynYuu34eO0IgVEuT4dOq5z8XFIcMKcMKIHH6E2Ftn1VpkjXtNMgCh4r2
   lxzRSklMrZHHtUPa+zHV7JdUhpqmDCo5y7/hWy2fOoV929PZaBPYIa4GQ
   b7s3g5Jr7pXFPCpI1tzXXEoIhDzheoYnvfjkaRD76q+mVNcHGl8gYZUgn
   9qDukBLZpdPHem4HeYuj2YNaeltQraVEzoi0gI1vqRSOF2tIfeFrOpa7x
   BfH8OxfMI2B8P3xbG3LJW6SJa/4Umis6kupMTwb2eE3QcwlT8UtVArYzn
   A==;
X-CSE-ConnectionGUID: tqSEJfYATtub/rhigIf8GA==
X-CSE-MsgGUID: LNRL/wxdQyy+KruVZK4Tbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67215397"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="67215397"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 04:34:53 -0700
X-CSE-ConnectionGUID: Fnl1tWiYSQ6Mg1dXQrH2bA==
X-CSE-MsgGUID: RicN3qBCQWmUn1bcnkFIfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="171030514"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 May 2025 04:34:52 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHhij-000OCE-1h;
	Wed, 21 May 2025 11:34:49 +0000
Date: Wed, 21 May 2025 19:34:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 21642f5c2c316f6b54181b0a8d64ef56b1db2469
Message-ID: <202505211925.tIkv4Qpw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 21642f5c2c316f6b54181b0a8d64ef56b1db2469  Merge branch 'pci/misc'

elapsed time: 729m

configs tested: 205
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250521    clang-21
arc                   randconfig-001-20250521    gcc-10.5.0
arc                   randconfig-002-20250521    clang-21
arc                   randconfig-002-20250521    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20250521    clang-21
arm                   randconfig-002-20250521    clang-21
arm                   randconfig-003-20250521    clang-16
arm                   randconfig-003-20250521    clang-21
arm                   randconfig-004-20250521    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250521    clang-21
arm64                 randconfig-001-20250521    gcc-6.5.0
arm64                 randconfig-002-20250521    clang-21
arm64                 randconfig-002-20250521    gcc-6.5.0
arm64                 randconfig-003-20250521    clang-21
arm64                 randconfig-003-20250521    gcc-8.5.0
arm64                 randconfig-004-20250521    clang-21
arm64                 randconfig-004-20250521    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250521    gcc-10.5.0
csky                  randconfig-001-20250521    gcc-14.2.0
csky                  randconfig-002-20250521    gcc-12.4.0
csky                  randconfig-002-20250521    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250521    clang-20
hexagon               randconfig-001-20250521    gcc-14.2.0
hexagon               randconfig-002-20250521    clang-21
hexagon               randconfig-002-20250521    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250521    clang-20
i386        buildonly-randconfig-002-20250521    clang-20
i386        buildonly-randconfig-003-20250521    clang-20
i386        buildonly-randconfig-003-20250521    gcc-12
i386        buildonly-randconfig-004-20250521    clang-20
i386        buildonly-randconfig-005-20250521    clang-20
i386        buildonly-randconfig-005-20250521    gcc-12
i386        buildonly-randconfig-006-20250521    clang-20
i386        buildonly-randconfig-006-20250521    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250521    clang-20
i386                  randconfig-002-20250521    clang-20
i386                  randconfig-003-20250521    clang-20
i386                  randconfig-004-20250521    clang-20
i386                  randconfig-005-20250521    clang-20
i386                  randconfig-006-20250521    clang-20
i386                  randconfig-007-20250521    clang-20
i386                  randconfig-011-20250521    gcc-12
i386                  randconfig-012-20250521    gcc-12
i386                  randconfig-013-20250521    gcc-12
i386                  randconfig-014-20250521    gcc-12
i386                  randconfig-015-20250521    gcc-12
i386                  randconfig-016-20250521    gcc-12
i386                  randconfig-017-20250521    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250521    gcc-14.2.0
loongarch             randconfig-001-20250521    gcc-15.1.0
loongarch             randconfig-002-20250521    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250521    gcc-14.2.0
nios2                 randconfig-002-20250521    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250521    gcc-13.3.0
parisc                randconfig-001-20250521    gcc-14.2.0
parisc                randconfig-002-20250521    gcc-11.5.0
parisc                randconfig-002-20250521    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       ebony_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250521    clang-21
powerpc               randconfig-001-20250521    gcc-14.2.0
powerpc               randconfig-002-20250521    gcc-14.2.0
powerpc               randconfig-002-20250521    gcc-8.5.0
powerpc               randconfig-003-20250521    gcc-14.2.0
powerpc               randconfig-003-20250521    gcc-6.5.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250521    gcc-14.2.0
powerpc64             randconfig-001-20250521    gcc-8.5.0
powerpc64             randconfig-002-20250521    gcc-14.2.0
powerpc64             randconfig-002-20250521    gcc-6.5.0
powerpc64             randconfig-003-20250521    clang-21
powerpc64             randconfig-003-20250521    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250521    gcc-8.5.0
riscv                 randconfig-002-20250521    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250521    clang-20
s390                  randconfig-001-20250521    gcc-8.5.0
s390                  randconfig-002-20250521    clang-21
s390                  randconfig-002-20250521    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250521    gcc-12.4.0
sh                    randconfig-001-20250521    gcc-8.5.0
sh                    randconfig-002-20250521    gcc-15.1.0
sh                    randconfig-002-20250521    gcc-8.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250521    gcc-13.3.0
sparc                 randconfig-001-20250521    gcc-8.5.0
sparc                 randconfig-002-20250521    gcc-13.3.0
sparc                 randconfig-002-20250521    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250521    gcc-13.3.0
sparc64               randconfig-001-20250521    gcc-8.5.0
sparc64               randconfig-002-20250521    gcc-13.3.0
sparc64               randconfig-002-20250521    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250521    clang-21
um                    randconfig-001-20250521    gcc-8.5.0
um                    randconfig-002-20250521    clang-21
um                    randconfig-002-20250521    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250521    clang-20
x86_64      buildonly-randconfig-002-20250521    clang-20
x86_64      buildonly-randconfig-003-20250521    gcc-12
x86_64      buildonly-randconfig-004-20250521    gcc-12
x86_64      buildonly-randconfig-005-20250521    clang-20
x86_64      buildonly-randconfig-006-20250521    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250521    gcc-12
x86_64                randconfig-002-20250521    gcc-12
x86_64                randconfig-003-20250521    gcc-12
x86_64                randconfig-004-20250521    gcc-12
x86_64                randconfig-005-20250521    gcc-12
x86_64                randconfig-006-20250521    gcc-12
x86_64                randconfig-007-20250521    gcc-12
x86_64                randconfig-008-20250521    gcc-12
x86_64                randconfig-071-20250521    clang-20
x86_64                randconfig-072-20250521    clang-20
x86_64                randconfig-073-20250521    clang-20
x86_64                randconfig-074-20250521    clang-20
x86_64                randconfig-075-20250521    clang-20
x86_64                randconfig-076-20250521    clang-20
x86_64                randconfig-077-20250521    clang-20
x86_64                randconfig-078-20250521    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250521    gcc-8.5.0
xtensa                randconfig-002-20250521    gcc-15.1.0
xtensa                randconfig-002-20250521    gcc-8.5.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

