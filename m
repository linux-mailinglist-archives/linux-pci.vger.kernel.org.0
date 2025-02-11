Return-Path: <linux-pci+bounces-21169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B1FA3124F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 18:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E917A2494
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A91DB34B;
	Tue, 11 Feb 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1WVL/AC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4525A321
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293299; cv=none; b=iaVR0DRed1z1OgJJPUSh0Uvo9r6HMUtK3RZKJUVRtJMKtRiKFPZw8ZXQbuPRbS6Wsb761fYuZELuqSiQHU50ucx3QqA0WAeLV3WuNF5iIhtWG10zszerJoyGcITKffRYVkI/omFL6ZtIVtgPiE9a1KPYL4oK9050Z8G1n8b1Lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293299; c=relaxed/simple;
	bh=DhzhKqVIUxJmsiHe5RrdSnI2xGaLLOlyTT8Q0nO/OCc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ill+lteIP7il7f1MMYuFLuWMVRX2D/qICNF42WAaMD730SXPwi72Knd0nsCdGGyuVO+4PFaLk416b/RG2kB+QhaohiFBYaIvya5DDB03W/xRxJN+6U2r/l4+2B23jcHJMMc/dT4mA1a6myDJfPPy11ExUlLl8SjZhDK6s1rOfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1WVL/AC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739293297; x=1770829297;
  h=date:from:to:cc:subject:message-id;
  bh=DhzhKqVIUxJmsiHe5RrdSnI2xGaLLOlyTT8Q0nO/OCc=;
  b=G1WVL/ACC3iQgq8vkKfqo3Tx8MXz2F/K2GWwq4+bXBRIspHJm3kSsDpF
   lhNnUW7/7dv3HgclZ20+az/ZlfmDJHqGFpISsvphRabD5HLWDhQ080Cla
   Gnta+JXUCdQGw2xSeK/pqgFoaMqZw+YPvWyxTN4ruMn0Ee4JNFGzQedKN
   eXVWavsICd88EQCvBiVtn19RK6J7B84jJoeqKGwMAOb0RqNi2DbIWR++z
   tPWw7TDnNX8nf6gM+srht97JB/NAgbt+wXxptvtHhyHd+b2Ay4cz3ihkA
   F8Vyb7Dk+Oedu8KDpMohEYBmo8m3P2OyKx/+GkcY64UmC7GkZ7d4LA39K
   Q==;
X-CSE-ConnectionGUID: W2XklSVJQOyonk5ixL9koQ==
X-CSE-MsgGUID: eqZq7C5WQPOTex3aqmU4Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50907377"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50907377"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:01:37 -0800
X-CSE-ConnectionGUID: KnS95nBYQE2XxVs5x4DCYw==
X-CSE-MsgGUID: OaXcs0TJQyWO3oer/qj7fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112329503"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Feb 2025 09:01:37 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thtdd-0014TH-2U;
	Tue, 11 Feb 2025 17:01:33 +0000
Date: Wed, 12 Feb 2025 01:01:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 c71f7bbc5d794984bbb6067b6712337d13f3af76
Message-ID: <202502120120.4CgirVPX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: c71f7bbc5d794984bbb6067b6712337d13f3af76  Merge branch 'pci/endpoint'

elapsed time: 1446m

configs tested: 231
configs skipped: 6

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
arc                   randconfig-001-20250211    clang-19
arc                   randconfig-001-20250211    gcc-13.2.0
arc                   randconfig-002-20250211    clang-19
arc                   randconfig-002-20250211    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250211    clang-19
arm                   randconfig-001-20250211    gcc-14.2.0
arm                   randconfig-002-20250211    clang-19
arm                   randconfig-002-20250211    clang-21
arm                   randconfig-003-20250211    clang-19
arm                   randconfig-003-20250211    gcc-14.2.0
arm                   randconfig-004-20250211    clang-19
arm                   randconfig-004-20250211    gcc-14.2.0
arm                        realview_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250211    clang-17
arm64                 randconfig-001-20250211    clang-19
arm64                 randconfig-002-20250211    clang-19
arm64                 randconfig-003-20250211    clang-19
arm64                 randconfig-003-20250211    gcc-14.2.0
arm64                 randconfig-004-20250211    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250211    clang-18
csky                  randconfig-001-20250211    gcc-14.2.0
csky                  randconfig-002-20250211    clang-18
csky                  randconfig-002-20250211    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250211    clang-18
hexagon               randconfig-002-20250211    clang-18
hexagon               randconfig-002-20250211    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250211    gcc-12
i386        buildonly-randconfig-002-20250211    gcc-12
i386        buildonly-randconfig-003-20250211    gcc-12
i386        buildonly-randconfig-004-20250211    gcc-12
i386        buildonly-randconfig-005-20250211    gcc-12
i386        buildonly-randconfig-006-20250211    clang-19
i386        buildonly-randconfig-006-20250211    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250211    gcc-12
i386                  randconfig-002-20250211    gcc-12
i386                  randconfig-003-20250211    gcc-12
i386                  randconfig-004-20250211    gcc-12
i386                  randconfig-005-20250211    gcc-12
i386                  randconfig-006-20250211    gcc-12
i386                  randconfig-007-20250211    gcc-12
i386                  randconfig-011-20250211    gcc-11
i386                  randconfig-012-20250211    gcc-11
i386                  randconfig-013-20250211    gcc-11
i386                  randconfig-014-20250211    gcc-11
i386                  randconfig-015-20250211    gcc-11
i386                  randconfig-016-20250211    gcc-11
i386                  randconfig-017-20250211    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250211    clang-18
loongarch             randconfig-001-20250211    gcc-14.2.0
loongarch             randconfig-002-20250211    clang-18
loongarch             randconfig-002-20250211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250211    clang-18
nios2                 randconfig-001-20250211    gcc-14.2.0
nios2                 randconfig-002-20250211    clang-18
nios2                 randconfig-002-20250211    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250211    clang-18
parisc                randconfig-001-20250211    gcc-14.2.0
parisc                randconfig-002-20250211    clang-18
parisc                randconfig-002-20250211    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250211    clang-15
powerpc               randconfig-001-20250211    clang-18
powerpc               randconfig-002-20250211    clang-18
powerpc               randconfig-002-20250211    clang-21
powerpc               randconfig-003-20250211    clang-18
powerpc               randconfig-003-20250211    clang-19
powerpc64             randconfig-001-20250211    clang-18
powerpc64             randconfig-001-20250211    clang-21
powerpc64             randconfig-002-20250211    clang-18
powerpc64             randconfig-002-20250211    gcc-14.2.0
powerpc64             randconfig-003-20250211    clang-17
powerpc64             randconfig-003-20250211    clang-18
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250211    clang-15
riscv                 randconfig-001-20250211    gcc-14.2.0
riscv                 randconfig-002-20250211    clang-15
riscv                 randconfig-002-20250211    clang-19
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250211    clang-15
s390                  randconfig-001-20250211    clang-21
s390                  randconfig-002-20250211    clang-15
s390                  randconfig-002-20250211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250211    clang-15
sh                    randconfig-001-20250211    gcc-14.2.0
sh                    randconfig-002-20250211    clang-15
sh                    randconfig-002-20250211    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250211    clang-15
sparc                 randconfig-001-20250211    gcc-14.2.0
sparc                 randconfig-002-20250211    clang-15
sparc                 randconfig-002-20250211    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250211    clang-15
sparc64               randconfig-001-20250211    gcc-14.2.0
sparc64               randconfig-002-20250211    clang-15
sparc64               randconfig-002-20250211    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250211    clang-15
um                    randconfig-001-20250211    clang-17
um                    randconfig-002-20250211    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250211    clang-19
x86_64      buildonly-randconfig-001-20250211    gcc-12
x86_64      buildonly-randconfig-002-20250211    gcc-12
x86_64      buildonly-randconfig-003-20250211    clang-19
x86_64      buildonly-randconfig-003-20250211    gcc-12
x86_64      buildonly-randconfig-004-20250211    gcc-11
x86_64      buildonly-randconfig-004-20250211    gcc-12
x86_64      buildonly-randconfig-005-20250211    clang-19
x86_64      buildonly-randconfig-005-20250211    gcc-12
x86_64      buildonly-randconfig-006-20250211    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250211    gcc-11
x86_64                randconfig-002-20250211    gcc-11
x86_64                randconfig-003-20250211    gcc-11
x86_64                randconfig-004-20250211    gcc-11
x86_64                randconfig-005-20250211    gcc-11
x86_64                randconfig-006-20250211    gcc-11
x86_64                randconfig-007-20250211    gcc-11
x86_64                randconfig-008-20250211    gcc-11
x86_64                randconfig-071-20250211    clang-19
x86_64                randconfig-072-20250211    clang-19
x86_64                randconfig-073-20250211    clang-19
x86_64                randconfig-074-20250211    clang-19
x86_64                randconfig-075-20250211    clang-19
x86_64                randconfig-076-20250211    clang-19
x86_64                randconfig-077-20250211    clang-19
x86_64                randconfig-078-20250211    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250211    clang-15
xtensa                randconfig-001-20250211    gcc-14.2.0
xtensa                randconfig-002-20250211    clang-15
xtensa                randconfig-002-20250211    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

