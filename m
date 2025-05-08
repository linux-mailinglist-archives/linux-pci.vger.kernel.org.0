Return-Path: <linux-pci+bounces-27414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BABAAAF220
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 06:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203521C028AB
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 04:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852C156C6A;
	Thu,  8 May 2025 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bF3R/TDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA268C1E
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746678947; cv=none; b=ss+i/Bo87H+CoAMrLmCdSFXnv6nJ7eUngx0kGJC2hw5UzIxzWrZScjIeoe4SrKj3e7HXF5xiJGn5QgWDLkyzFQKrPOoOs6otRrkRm1MEGW3L4A4mW8XA0gQ81ncvRhsT+c2MzZoT6voqdRJlX62JVHtq7BNWHM1EEepkiKBUwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746678947; c=relaxed/simple;
	bh=TTJzOQgWgDcPxEH0cPj6iJr5qovlcyqt4eXH6+iY7vw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W7+f28DOzgMfwF3E/7lQ2k1LRqAXIsu1x39TzlfYPcaaUbG61OkdLRmbvHOrDsVjAgLMoJtghiKjzeT9s6kl+3IAU7QM/EONVRTM+wyj3hZcIh0T31BJR/hmDXfEHF4Rz1dYdQ0cGL5bVzT8BS8cw/ZAychTi57i77wPb76bvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bF3R/TDW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746678945; x=1778214945;
  h=date:from:to:cc:subject:message-id;
  bh=TTJzOQgWgDcPxEH0cPj6iJr5qovlcyqt4eXH6+iY7vw=;
  b=bF3R/TDWosxBqnc+n3EFJUgkRHCvkGmZsQ5C+utij+YEf8ZM6SYML2Az
   e6qcdVnMiuJ06amHwuX+husVZaPkjUMq6l9pj6s2oJ818UJTlfbB0u9Sc
   X1s/FR1quZjuYuELx8QOUDAbzpf8Ugli2t8XOhh9Iwu4ZZVJXfxB4/HEy
   klBlbIE3QuDxmNtzlYC5AeDmNojQi5sADVxtYzwtgKVSEyqsQpzXmiBaJ
   yWl6Hi3mfRYhOlJHJaWWeIl+Xl0oNf5t6iWiuiHMNqLRekT1HJq/RlIE/
   F3jpyjK9QSIcEgUDOpfKc28zrR/1QzT3h34GhGhFYmxkZAS8OAs/CQ5sK
   g==;
X-CSE-ConnectionGUID: 6pc0KaKHTgW3OO9WxUHHrw==
X-CSE-MsgGUID: kGEZOPeBRAS09TbTV7FbyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59795275"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59795275"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 21:35:45 -0700
X-CSE-ConnectionGUID: MVqV5xtjRtGUeF8kQubxvg==
X-CSE-MsgGUID: CpAfQFA3QMClRCklI/F6EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="159490230"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 May 2025 21:35:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCsz0-000A5O-0D;
	Thu, 08 May 2025 04:35:42 +0000
Date: Thu, 08 May 2025 12:35:22 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra194] BUILD SUCCESS
 ed798ff1c52f6fe232ce2e24e68fb63f5470ab97
Message-ID: <202505081216.GYGVClEY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra194
branch HEAD: ed798ff1c52f6fe232ce2e24e68fb63f5470ab97  PCI: tegra194: Create debugfs directory only when CONFIG_PCIEASPM is enabled

elapsed time: 7071m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250503    gcc-14.2.0
arc                   randconfig-002-20250503    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250503    gcc-6.5.0
arm                   randconfig-002-20250503    clang-21
arm                   randconfig-003-20250503    gcc-6.5.0
arm                   randconfig-004-20250503    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250503    gcc-9.5.0
arm64                 randconfig-002-20250503    clang-21
arm64                 randconfig-003-20250503    clang-21
arm64                 randconfig-004-20250503    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250503    gcc-14.2.0
csky                  randconfig-002-20250503    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250503    clang-21
hexagon               randconfig-002-20250503    clang-16
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250503    gcc-12
i386        buildonly-randconfig-002-20250503    gcc-12
i386        buildonly-randconfig-003-20250503    gcc-12
i386        buildonly-randconfig-004-20250503    clang-20
i386        buildonly-randconfig-005-20250503    gcc-12
i386        buildonly-randconfig-006-20250503    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250503    gcc-14.2.0
loongarch             randconfig-002-20250503    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250503    gcc-11.5.0
nios2                 randconfig-002-20250503    gcc-7.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250503    gcc-8.5.0
parisc                randconfig-002-20250503    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20250503    gcc-5.5.0
powerpc               randconfig-002-20250503    gcc-9.3.0
powerpc               randconfig-003-20250503    clang-21
powerpc64             randconfig-001-20250503    gcc-7.5.0
powerpc64             randconfig-002-20250503    gcc-10.5.0
powerpc64             randconfig-003-20250503    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                 randconfig-001-20250503    clang-20
riscv                 randconfig-002-20250503    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250503    gcc-7.5.0
s390                  randconfig-002-20250503    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250503    gcc-5.5.0
sh                    randconfig-002-20250503    gcc-5.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250503    gcc-8.5.0
sparc                 randconfig-002-20250503    gcc-14.2.0
sparc64               randconfig-001-20250503    gcc-10.5.0
sparc64               randconfig-002-20250503    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250503    clang-21
um                    randconfig-002-20250503    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250503    gcc-12
x86_64      buildonly-randconfig-002-20250503    gcc-12
x86_64      buildonly-randconfig-003-20250503    gcc-12
x86_64      buildonly-randconfig-004-20250503    gcc-12
x86_64      buildonly-randconfig-005-20250503    clang-20
x86_64      buildonly-randconfig-006-20250503    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250503    gcc-10.5.0
xtensa                randconfig-002-20250503    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

