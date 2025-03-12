Return-Path: <linux-pci+bounces-23511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2201DA5E0A3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35B9165533
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17B1DE2BD;
	Wed, 12 Mar 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRZnWSUO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CC254842
	for <linux-pci@vger.kernel.org>; Wed, 12 Mar 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793933; cv=none; b=m9kAlJvCm4LThgGvWcvcLQMp2xuMy70Z6cxe/Oicgpk/q7wISF0C0crW7y0mJ5oK3g2suokuUqonzJTepzTpMsNw/TfMQN2xOf200ZJBJwZbFiRu+N+fg7tWQD1PB2mxyg94huVHqyKPqr9z8vguzjvdNTnnFen8YkN+cKV0tFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793933; c=relaxed/simple;
	bh=ofkbrdMNUCmuM3zn6z/zPlRwJA96vS1JtErEQoc1O6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mbBnmMZBgh7IOu9T9zWndNdaeoq4HRxXrCA/6Aweq+jS9yDlA6uOUtf9zs5QHsf06dZTWHlv578vIJHVxMgcfYKUuiz146JppTW5NdbZlDtLt4rXsIUH+4xYO1M7NycBvyoaA0wnDt5zTZipEOlZH243yjYHwmuk2H+MumWkG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRZnWSUO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741793932; x=1773329932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ofkbrdMNUCmuM3zn6z/zPlRwJA96vS1JtErEQoc1O6Q=;
  b=QRZnWSUOSUWtzWFAa8qj2KbjwsxHXxPOClBmtH44P42RkWPvYGTQk37j
   64n0tuqdR6yIRoMZXvu8HteaP7eXMotDZJj7zqttU1rDJ6t39AlI8HdBI
   R5z3sQ+6MIjw8Dqx/eJNY5lR9x2e+0QBkfohLm0BE4WwTQWOcQ2lKjhcx
   yv7g+bytNIpImBJiGatRACyTG5sfhsyMVwkbY/51fXZNeh+SYGKpspLIH
   YiUG1MvWiQMLWIVJel2Nc1SP9O3Vs/dGoPA0wevqOrMIUtjCZNxAEY0xQ
   F4/zmlIfNwkobfgdQVTxVYd3qkwi9VstY+jzUP1PtNcCVrGgxwtaRVtsm
   Q==;
X-CSE-ConnectionGUID: t/M4ePgySzO3PH0NxknCQQ==
X-CSE-MsgGUID: 9wFx4uoSQgWLvX2/dQ1WMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46529527"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="46529527"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:38:51 -0700
X-CSE-ConnectionGUID: s+uzFzO3R/6fo2vRyYuOiw==
X-CSE-MsgGUID: rs3myJL8T2Sc0dhabnNTMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121375034"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 12 Mar 2025 08:38:51 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsOAR-0008fQ-1y;
	Wed, 12 Mar 2025 15:38:47 +0000
Date: Wed, 12 Mar 2025 23:38:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx-cpm] BUILD SUCCESS
 ad3b7174d4d04b7e2ab81df5857c4da6b4bc1ade
Message-ID: <202503122306.7Ic6PC2P-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx-cpm
branch HEAD: ad3b7174d4d04b7e2ab81df5857c4da6b4bc1ade  PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller

elapsed time: 1449m

configs tested: 210
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
arc                          axs103_defconfig    clang-21
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250312    clang-21
arc                   randconfig-001-20250312    gcc-13.2.0
arc                   randconfig-002-20250312    clang-21
arc                   randconfig-002-20250312    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-21
arm                           h3600_defconfig    clang-21
arm                         mv78xx0_defconfig    clang-21
arm                   randconfig-001-20250312    clang-19
arm                   randconfig-001-20250312    clang-21
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250312    clang-19
arm                   randconfig-003-20250312    clang-21
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250312    clang-21
arm64                 randconfig-002-20250312    gcc-14.2.0
arm64                 randconfig-003-20250312    clang-21
arm64                 randconfig-003-20250312    gcc-14.2.0
arm64                 randconfig-004-20250312    clang-21
arm64                 randconfig-004-20250312    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250312    clang-21
hexagon               randconfig-001-20250312    gcc-14.2.0
hexagon               randconfig-002-20250312    clang-21
hexagon               randconfig-002-20250312    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250312    clang-19
i386        buildonly-randconfig-001-20250312    gcc-12
i386        buildonly-randconfig-002-20250312    clang-19
i386        buildonly-randconfig-002-20250312    gcc-12
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250312    clang-19
i386        buildonly-randconfig-006-20250312    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250312    clang-19
i386                  randconfig-002-20250312    clang-19
i386                  randconfig-003-20250312    clang-19
i386                  randconfig-004-20250312    clang-19
i386                  randconfig-005-20250312    clang-19
i386                  randconfig-006-20250312    clang-19
i386                  randconfig-007-20250312    clang-19
i386                  randconfig-011-20250312    gcc-11
i386                  randconfig-012-20250312    gcc-11
i386                  randconfig-013-20250312    gcc-11
i386                  randconfig-014-20250312    gcc-11
i386                  randconfig-015-20250312    gcc-11
i386                  randconfig-016-20250312    gcc-11
i386                  randconfig-017-20250312    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    clang-21
mips                           ip28_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-21
powerpc               randconfig-001-20250312    clang-21
powerpc               randconfig-001-20250312    gcc-14.2.0
powerpc               randconfig-002-20250312    clang-21
powerpc               randconfig-002-20250312    gcc-14.2.0
powerpc               randconfig-003-20250312    clang-21
powerpc               randconfig-003-20250312    gcc-14.2.0
powerpc64             randconfig-001-20250312    clang-17
powerpc64             randconfig-001-20250312    gcc-14.2.0
powerpc64             randconfig-002-20250312    clang-15
powerpc64             randconfig-002-20250312    gcc-14.2.0
powerpc64             randconfig-003-20250312    clang-21
powerpc64             randconfig-003-20250312    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250312    clang-21
riscv                 randconfig-001-20250312    gcc-14.2.0
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250312    clang-15
s390                  randconfig-001-20250312    gcc-14.2.0
s390                  randconfig-002-20250312    clang-16
s390                  randconfig-002-20250312    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    clang-21
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250312    gcc-12
um                    randconfig-001-20250312    gcc-14.2.0
um                    randconfig-002-20250312    clang-15
um                    randconfig-002-20250312    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250312    clang-19
x86_64      buildonly-randconfig-001-20250312    gcc-12
x86_64      buildonly-randconfig-002-20250312    clang-19
x86_64      buildonly-randconfig-002-20250312    gcc-12
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250312    clang-19
x86_64      buildonly-randconfig-004-20250312    gcc-12
x86_64      buildonly-randconfig-005-20250312    clang-19
x86_64      buildonly-randconfig-005-20250312    gcc-12
x86_64      buildonly-randconfig-006-20250312    clang-19
x86_64      buildonly-randconfig-006-20250312    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250312    gcc-12
x86_64                randconfig-002-20250312    gcc-12
x86_64                randconfig-003-20250312    gcc-12
x86_64                randconfig-004-20250312    gcc-12
x86_64                randconfig-005-20250312    gcc-12
x86_64                randconfig-006-20250312    gcc-12
x86_64                randconfig-007-20250312    gcc-12
x86_64                randconfig-008-20250312    gcc-12
x86_64                randconfig-071-20250312    clang-19
x86_64                randconfig-072-20250312    clang-19
x86_64                randconfig-073-20250312    clang-19
x86_64                randconfig-074-20250312    clang-19
x86_64                randconfig-075-20250312    clang-19
x86_64                randconfig-076-20250312    clang-19
x86_64                randconfig-077-20250312    clang-19
x86_64                randconfig-078-20250312    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

