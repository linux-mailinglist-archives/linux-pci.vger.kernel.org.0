Return-Path: <linux-pci+bounces-21553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F38A37134
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 00:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E6D3ACAC0
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 23:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF21624D4;
	Sat, 15 Feb 2025 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5ZG8VjH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9417B50B
	for <linux-pci@vger.kernel.org>; Sat, 15 Feb 2025 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739661352; cv=none; b=Ff+9E9HBLsgo1gkd+VgbhdIH2v+YiEhCf/3GVGUi6sUHpKkXBAP1N+Yzh8cPH5TZBmaw/J/YbjoUX+njszKCG1BBZN3o/xQg1cL7ae02Fw9ISUBiGu5tGF45DjhA0xFwJHKQNNL9BBRD9AizH4zawN1vpqw3ewtUeoxtW2C2T7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739661352; c=relaxed/simple;
	bh=zIsD97HDNR65B3qb8wx2TsBxXl925krXMDdP62+G6ek=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QAmfkHE78e1hutNLMnsCFRMrEMYLAx+hP4mO7xsYLkBOOdWK8V2B9Pv5+6quo9koywja7zfQ8iAkMjX2p/T8qhgN2AaSl6+NK9+z4vNY3ufW5jTFV+oJYoYOpINpBfnc7rr+KbSlwqZlEYPpVm1rzEcE+8lUxvtgJRG6IMnypwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5ZG8VjH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739661350; x=1771197350;
  h=date:from:to:cc:subject:message-id;
  bh=zIsD97HDNR65B3qb8wx2TsBxXl925krXMDdP62+G6ek=;
  b=l5ZG8VjHkkczTH/Z8rpH3Jq9NAiniA4Gx7c8/0pqMOYXnhbLXQiCCvll
   BHjUkfZLuVykOtlT7YVFsvx33zlaU1T5tdiUOA5z8aRrRHfGr787ZZuPI
   NaIRrve8cJfIAGRnlyldotWLFnRsOXubJoEbcPOiONJTSnOAcpLlXEaqK
   YiAclSay0uMdtHVBwIrCRnclatDlARMPWmx8N3lY3w5WqhDkoGeB+U2R7
   r5SzHztbc5ulM1Vv/zoFNb71RbzV9PMJUnAD1MYiRmpMvA6y75dH0F90A
   lk8gi8dnd2of1bGP2gp/etZx4KVRrvIiqVW7XIgFZKPHaEFerRsnEfY/Q
   g==;
X-CSE-ConnectionGUID: PUUstzJuR+6HmLNoP7dYMw==
X-CSE-MsgGUID: ZA4v/5ozTDuy7YRtipZwyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509965"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509965"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 15:15:49 -0800
X-CSE-ConnectionGUID: 8xNRThd5TcKVYjkCeqK9hQ==
X-CSE-MsgGUID: 6IngLrMXSfSwYCqW9ajbeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144699566"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Feb 2025 15:15:48 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjRNy-001BO3-1s;
	Sat, 15 Feb 2025 23:15:46 +0000
Date: Sun, 16 Feb 2025 07:15:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 5cf14680ca63f38634697f0d734060f171620823
Message-ID: <202502160723.okDtV80e-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 5cf14680ca63f38634697f0d734060f171620823  PCI: Rework optional resource handling

elapsed time: 1444m

configs tested: 224
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250215    gcc-13.2.0
arc                   randconfig-001-20250216    gcc-14.2.0
arc                   randconfig-002-20250215    gcc-13.2.0
arc                   randconfig-002-20250216    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250215    clang-15
arm                   randconfig-001-20250216    gcc-14.2.0
arm                   randconfig-002-20250215    clang-17
arm                   randconfig-002-20250216    gcc-14.2.0
arm                   randconfig-003-20250215    gcc-14.2.0
arm                   randconfig-003-20250216    gcc-14.2.0
arm                   randconfig-004-20250215    gcc-14.2.0
arm                   randconfig-004-20250216    gcc-14.2.0
arm                        realview_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250215    clang-21
arm64                 randconfig-001-20250216    gcc-14.2.0
arm64                 randconfig-002-20250215    gcc-14.2.0
arm64                 randconfig-002-20250216    gcc-14.2.0
arm64                 randconfig-003-20250215    clang-17
arm64                 randconfig-003-20250216    gcc-14.2.0
arm64                 randconfig-004-20250215    gcc-14.2.0
arm64                 randconfig-004-20250216    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250215    gcc-14.2.0
csky                  randconfig-001-20250216    clang-15
csky                  randconfig-002-20250215    gcc-14.2.0
csky                  randconfig-002-20250216    clang-15
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250215    clang-21
hexagon               randconfig-001-20250216    clang-15
hexagon               randconfig-002-20250215    clang-21
hexagon               randconfig-002-20250216    clang-15
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250215    gcc-12
i386        buildonly-randconfig-001-20250216    gcc-12
i386        buildonly-randconfig-002-20250215    clang-19
i386        buildonly-randconfig-002-20250216    gcc-12
i386        buildonly-randconfig-003-20250215    clang-19
i386        buildonly-randconfig-003-20250216    gcc-12
i386        buildonly-randconfig-004-20250215    gcc-12
i386        buildonly-randconfig-004-20250216    gcc-12
i386        buildonly-randconfig-005-20250215    clang-19
i386        buildonly-randconfig-005-20250216    gcc-12
i386        buildonly-randconfig-006-20250215    clang-19
i386        buildonly-randconfig-006-20250216    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250216    gcc-12
i386                  randconfig-002-20250216    gcc-12
i386                  randconfig-003-20250216    gcc-12
i386                  randconfig-004-20250216    gcc-12
i386                  randconfig-005-20250216    gcc-12
i386                  randconfig-006-20250216    gcc-12
i386                  randconfig-007-20250216    gcc-12
i386                  randconfig-011-20250216    gcc-12
i386                  randconfig-012-20250216    gcc-12
i386                  randconfig-013-20250216    gcc-12
i386                  randconfig-014-20250216    gcc-12
i386                  randconfig-015-20250216    gcc-12
i386                  randconfig-016-20250216    gcc-12
i386                  randconfig-017-20250216    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250215    gcc-14.2.0
loongarch             randconfig-001-20250216    clang-15
loongarch             randconfig-002-20250215    gcc-14.2.0
loongarch             randconfig-002-20250216    clang-15
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250215    gcc-14.2.0
nios2                 randconfig-001-20250216    clang-15
nios2                 randconfig-002-20250215    gcc-14.2.0
nios2                 randconfig-002-20250216    clang-15
openrisc                          allnoconfig    clang-21
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-21
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250215    gcc-14.2.0
parisc                randconfig-001-20250216    clang-15
parisc                randconfig-002-20250215    gcc-14.2.0
parisc                randconfig-002-20250216    clang-15
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250215    gcc-14.2.0
powerpc               randconfig-001-20250216    clang-15
powerpc               randconfig-002-20250215    clang-21
powerpc               randconfig-002-20250216    clang-15
powerpc               randconfig-003-20250215    clang-19
powerpc               randconfig-003-20250216    clang-15
powerpc64             randconfig-001-20250215    gcc-14.2.0
powerpc64             randconfig-001-20250216    clang-15
powerpc64             randconfig-002-20250215    clang-21
powerpc64             randconfig-002-20250216    clang-15
powerpc64             randconfig-003-20250215    gcc-14.2.0
powerpc64             randconfig-003-20250216    clang-15
riscv                             allnoconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250215    clang-17
riscv                 randconfig-001-20250216    gcc-12
riscv                 randconfig-002-20250215    clang-19
riscv                 randconfig-002-20250216    gcc-12
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250215    gcc-14.2.0
s390                  randconfig-001-20250216    gcc-12
s390                  randconfig-002-20250215    gcc-14.2.0
s390                  randconfig-002-20250216    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250215    gcc-14.2.0
sh                    randconfig-001-20250216    gcc-12
sh                    randconfig-002-20250215    gcc-14.2.0
sh                    randconfig-002-20250216    gcc-12
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250215    gcc-14.2.0
sparc                 randconfig-001-20250216    gcc-12
sparc                 randconfig-002-20250215    gcc-14.2.0
sparc                 randconfig-002-20250216    gcc-12
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250215    gcc-14.2.0
sparc64               randconfig-001-20250216    gcc-12
sparc64               randconfig-002-20250215    gcc-14.2.0
sparc64               randconfig-002-20250216    gcc-12
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250215    clang-21
um                    randconfig-001-20250216    gcc-12
um                    randconfig-002-20250215    clang-19
um                    randconfig-002-20250216    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250215    gcc-12
x86_64      buildonly-randconfig-001-20250216    gcc-12
x86_64      buildonly-randconfig-002-20250215    clang-19
x86_64      buildonly-randconfig-002-20250216    gcc-12
x86_64      buildonly-randconfig-003-20250215    gcc-12
x86_64      buildonly-randconfig-003-20250216    gcc-12
x86_64      buildonly-randconfig-004-20250215    clang-19
x86_64      buildonly-randconfig-004-20250216    gcc-12
x86_64      buildonly-randconfig-005-20250215    clang-19
x86_64      buildonly-randconfig-005-20250216    gcc-12
x86_64      buildonly-randconfig-006-20250215    clang-19
x86_64      buildonly-randconfig-006-20250216    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250216    clang-19
x86_64                randconfig-002-20250216    clang-19
x86_64                randconfig-003-20250216    clang-19
x86_64                randconfig-004-20250216    clang-19
x86_64                randconfig-005-20250216    clang-19
x86_64                randconfig-006-20250216    clang-19
x86_64                randconfig-007-20250216    clang-19
x86_64                randconfig-008-20250216    clang-19
x86_64                randconfig-071-20250216    gcc-12
x86_64                randconfig-072-20250216    gcc-12
x86_64                randconfig-073-20250216    gcc-12
x86_64                randconfig-074-20250216    gcc-12
x86_64                randconfig-075-20250216    gcc-12
x86_64                randconfig-076-20250216    gcc-12
x86_64                randconfig-077-20250216    gcc-12
x86_64                randconfig-078-20250216    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250215    gcc-14.2.0
xtensa                randconfig-001-20250216    gcc-12
xtensa                randconfig-002-20250215    gcc-14.2.0
xtensa                randconfig-002-20250216    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

