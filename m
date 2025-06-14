Return-Path: <linux-pci+bounces-29805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29366AD9A09
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 06:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D5C3BA6A5
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 04:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB05145355;
	Sat, 14 Jun 2025 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J46vGTyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2542A87
	for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2025 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749875101; cv=none; b=rGm+224eZQ6xXT2u52/doGfqEtvJsZG1jllL1y+zy9mrj8f4e+3YJQHAhoGn+AN6LZY5TFBj6UO+RN3kWnDj6NzIDPqSnr5ZbQmjmiwN3r6JCI4HgXzu9wYOYlsWtfiHRLwIT+RZGtF79+unsuUjojzf+vSjkv2JneyI3+CkrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749875101; c=relaxed/simple;
	bh=oZ9HpfsKk+XpCapJ24qWQhfdaFOnmSzLn+kP6a/InK8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ntMjDdFDKBZ1MFTHLl+qSWjX0IbuLKGW7pGjcazKB0JP4/mBWQI7ZkPIBHzt1jvRPnaUZ7Q+d9z9WxLHuCUdqsHEksFjY+fGAZsM9WbCTg8aMiIaFWhmPHcmeIpqBRb+AON9aNbYmPvxgI2V5Hb8BYjijgG6empuqscsn5mteZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J46vGTyz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749875100; x=1781411100;
  h=date:from:to:cc:subject:message-id;
  bh=oZ9HpfsKk+XpCapJ24qWQhfdaFOnmSzLn+kP6a/InK8=;
  b=J46vGTyzRUS/52IXzD41/WcJ5QDoK4CbVQVlT+7T6sXDQ3gJn02kYa66
   CLsQ494uPpxaSrLzmC6wxkLWL8mY9AbWdT7CApBwqlGlBVwseCBLZN4zu
   bNWVGT+jM6BySKqIwWIvFSH6zfFX5OEPmzeqzJSJV9k63vZ4C0Kx7n2Wh
   wKgPNpteUXXoWg0vz9amyQ8bYf5j5ypHz/V6HYmdmqdeB8HUAouu+Oao8
   Bbht0RQfHHvsr8ZrlJJqQAMhHiA2alN/PfZeFdnJGg5HWzWntave/yn16
   AUfkzd5SnNobIZbwAOaZ2APBMIsMXLPDTLwfksEoRAj+ri1q2qk+Hg6CP
   g==;
X-CSE-ConnectionGUID: Mf+vM5uDQxGpi6lTbia1FA==
X-CSE-MsgGUID: PX0QKZG6Qg29RrGQItZs/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52186273"
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="52186273"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 21:24:59 -0700
X-CSE-ConnectionGUID: 5Wrxy7LQTba4naiGsCev0g==
X-CSE-MsgGUID: wounGQTXTgyY01D5L4C3Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="151816184"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Jun 2025 21:24:58 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQIRr-000DHq-2u;
	Sat, 14 Jun 2025 04:24:55 +0000
Date: Sat, 14 Jun 2025 12:24:36 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/sophgo] BUILD SUCCESS
 74ab255bab3082fa6bd2a925a986526e093d615b
Message-ID: <202506141227.thjPTKIF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/sophgo
branch HEAD: 74ab255bab3082fa6bd2a925a986526e093d615b  PCI: dwc: Add Sophgo SG2044 PCIe controller driver in Root Complex mode

elapsed time: 1385m

configs tested: 270
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250613    gcc-12.4.0
arc                   randconfig-001-20250614    gcc-8.5.0
arc                   randconfig-002-20250613    gcc-12.4.0
arc                   randconfig-002-20250614    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g5_defconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-21
arm                        multi_v7_defconfig    gcc-15.1.0
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20250613    clang-21
arm                   randconfig-001-20250614    gcc-8.5.0
arm                   randconfig-002-20250613    clang-20
arm                   randconfig-002-20250614    gcc-8.5.0
arm                   randconfig-003-20250613    gcc-8.5.0
arm                   randconfig-003-20250614    gcc-8.5.0
arm                   randconfig-004-20250613    clang-21
arm                   randconfig-004-20250614    gcc-8.5.0
arm                           spitz_defconfig    gcc-15.1.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250613    gcc-15.1.0
arm64                 randconfig-001-20250614    gcc-8.5.0
arm64                 randconfig-002-20250613    clang-21
arm64                 randconfig-002-20250614    gcc-8.5.0
arm64                 randconfig-003-20250613    clang-21
arm64                 randconfig-003-20250614    gcc-8.5.0
arm64                 randconfig-004-20250613    gcc-15.1.0
arm64                 randconfig-004-20250614    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250613    gcc-15.1.0
csky                  randconfig-001-20250614    clang-21
csky                  randconfig-002-20250613    gcc-15.1.0
csky                  randconfig-002-20250614    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250613    clang-21
hexagon               randconfig-001-20250614    clang-21
hexagon               randconfig-002-20250613    clang-21
hexagon               randconfig-002-20250614    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250613    gcc-12
i386        buildonly-randconfig-001-20250614    clang-20
i386        buildonly-randconfig-002-20250613    gcc-11
i386        buildonly-randconfig-002-20250614    clang-20
i386        buildonly-randconfig-003-20250613    gcc-12
i386        buildonly-randconfig-003-20250614    clang-20
i386        buildonly-randconfig-004-20250613    clang-20
i386        buildonly-randconfig-004-20250614    clang-20
i386        buildonly-randconfig-005-20250613    clang-20
i386        buildonly-randconfig-005-20250614    clang-20
i386        buildonly-randconfig-006-20250613    gcc-12
i386        buildonly-randconfig-006-20250614    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250614    clang-20
i386                  randconfig-002-20250614    clang-20
i386                  randconfig-003-20250614    clang-20
i386                  randconfig-004-20250614    clang-20
i386                  randconfig-005-20250614    clang-20
i386                  randconfig-006-20250614    clang-20
i386                  randconfig-007-20250614    clang-20
i386                  randconfig-011-20250614    clang-20
i386                  randconfig-012-20250614    clang-20
i386                  randconfig-013-20250614    clang-20
i386                  randconfig-014-20250614    clang-20
i386                  randconfig-015-20250614    clang-20
i386                  randconfig-016-20250614    clang-20
i386                  randconfig-017-20250614    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250613    gcc-15.1.0
loongarch             randconfig-001-20250614    clang-21
loongarch             randconfig-002-20250613    gcc-15.1.0
loongarch             randconfig-002-20250614    clang-21
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    clang-21
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250613    gcc-11.5.0
nios2                 randconfig-001-20250614    clang-21
nios2                 randconfig-002-20250613    gcc-11.5.0
nios2                 randconfig-002-20250614    clang-21
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250613    gcc-8.5.0
parisc                randconfig-001-20250614    clang-21
parisc                randconfig-002-20250613    gcc-13.3.0
parisc                randconfig-002-20250614    clang-21
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    gcc-15.1.0
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    clang-21
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    gcc-15.1.0
powerpc                      ppc64e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250613    clang-21
powerpc               randconfig-001-20250614    clang-21
powerpc               randconfig-002-20250613    gcc-8.5.0
powerpc               randconfig-002-20250614    clang-21
powerpc               randconfig-003-20250613    gcc-9.3.0
powerpc               randconfig-003-20250614    clang-21
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250613    gcc-8.5.0
powerpc64             randconfig-001-20250614    clang-21
powerpc64             randconfig-002-20250613    gcc-8.5.0
powerpc64             randconfig-002-20250614    clang-21
powerpc64             randconfig-003-20250613    gcc-10.5.0
powerpc64             randconfig-003-20250614    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250613    gcc-8.5.0
riscv                 randconfig-001-20250614    gcc-14.3.0
riscv                 randconfig-002-20250613    clang-21
riscv                 randconfig-002-20250614    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250613    clang-21
s390                  randconfig-001-20250614    gcc-14.3.0
s390                  randconfig-002-20250613    clang-21
s390                  randconfig-002-20250614    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250613    gcc-15.1.0
sh                    randconfig-001-20250614    gcc-14.3.0
sh                    randconfig-002-20250613    gcc-15.1.0
sh                    randconfig-002-20250614    gcc-14.3.0
sh                          rsk7269_defconfig    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sh                           se7724_defconfig    clang-21
sh                             shx3_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250613    gcc-10.3.0
sparc                 randconfig-001-20250614    gcc-14.3.0
sparc                 randconfig-002-20250613    gcc-13.3.0
sparc                 randconfig-002-20250614    gcc-14.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250613    gcc-15.1.0
sparc64               randconfig-001-20250614    gcc-14.3.0
sparc64               randconfig-002-20250613    gcc-8.5.0
sparc64               randconfig-002-20250614    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250613    gcc-12
um                    randconfig-001-20250614    gcc-14.3.0
um                    randconfig-002-20250613    gcc-12
um                    randconfig-002-20250614    gcc-14.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250613    clang-20
x86_64      buildonly-randconfig-001-20250614    clang-20
x86_64      buildonly-randconfig-002-20250613    gcc-12
x86_64      buildonly-randconfig-002-20250614    clang-20
x86_64      buildonly-randconfig-003-20250613    gcc-12
x86_64      buildonly-randconfig-003-20250614    clang-20
x86_64      buildonly-randconfig-004-20250613    gcc-12
x86_64      buildonly-randconfig-004-20250614    clang-20
x86_64      buildonly-randconfig-005-20250613    clang-20
x86_64      buildonly-randconfig-005-20250614    clang-20
x86_64      buildonly-randconfig-006-20250613    gcc-12
x86_64      buildonly-randconfig-006-20250614    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250614    clang-20
x86_64                randconfig-002-20250614    clang-20
x86_64                randconfig-003-20250614    clang-20
x86_64                randconfig-004-20250614    clang-20
x86_64                randconfig-005-20250614    clang-20
x86_64                randconfig-006-20250614    clang-20
x86_64                randconfig-007-20250614    clang-20
x86_64                randconfig-008-20250614    clang-20
x86_64                randconfig-071-20250614    clang-20
x86_64                randconfig-072-20250614    clang-20
x86_64                randconfig-073-20250614    clang-20
x86_64                randconfig-074-20250614    clang-20
x86_64                randconfig-075-20250614    clang-20
x86_64                randconfig-076-20250614    clang-20
x86_64                randconfig-077-20250614    clang-20
x86_64                randconfig-078-20250614    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                          iss_defconfig    clang-21
xtensa                randconfig-001-20250613    gcc-8.5.0
xtensa                randconfig-001-20250614    gcc-14.3.0
xtensa                randconfig-002-20250613    gcc-15.1.0
xtensa                randconfig-002-20250614    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

