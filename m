Return-Path: <linux-pci+bounces-28681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AEAC82ED
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 21:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628D81C008A2
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466C722FF37;
	Thu, 29 May 2025 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFaJo3Nq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0422D9F9
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748548674; cv=none; b=L2c19ao4dODxBPKTlAdw5jm6BVvuFOJXudB1wF92VkDDb3bzHft37tjXNvrJd4WzBOkQsLgce2V0f8tu8NBFC/76w8NJ7g9NG9Ia3A9zzUkUoD63xLVHwCtqQ4j8MZ963HKE18p8GtLMgNo/wrbmxH2jNCvlzO6HxApMtqI4P8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748548674; c=relaxed/simple;
	bh=IpwVa50tlt5pOSdhzG3eyqOm//bPgkc4rwQI0E3RS9k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s9MFdVy7dEdg/o+CfMD+PCzrTjRbf454WqQjiZFNx+VeRRGTPjqcAop3FcNjPYj4cOqmDaUAaBCGqNPRmN3kVQK9TRjFWkaxvmsAxalPGXiaYgzsZ0rzPGIpqE76JvBWU0s7JEO7+wjV1xPGDpkcuZPW9T4kD8vSC0nqUI5Uxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFaJo3Nq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748548673; x=1780084673;
  h=date:from:to:cc:subject:message-id;
  bh=IpwVa50tlt5pOSdhzG3eyqOm//bPgkc4rwQI0E3RS9k=;
  b=aFaJo3NqEo5GIM6gzY1V3JrhZDFrR8dV2Z2UUlCxUSmwiFXlS7VTiZ0r
   sZoi/5G1EOmljGVeQOnIINzboylhIrh9gq0hLdMYt5GjAcGV+SUI/HLJS
   8GjRiKBR6LT92eU+HjHMEBPgOEDniRAKlrGdUQilSwFawoNM8S5jvkSfv
   jc5N4h2EUAUb1AgSjIUJlPCXOA5XUyfhVjYHImJtZN/uEEA0QVK7NeGbK
   f/Zh0zDL3P1ZiaXMXw3TB+LIoo+pZj153BCB1qb/etQFHuF2ugKQdEWY0
   U1Kk4fLvTClloE48fBeSDJQMUI/WxyE8c3G4jiRFyPg/5BDIDEBS+FXtN
   A==;
X-CSE-ConnectionGUID: j/MJOffGS2aeaGd2XXUBfw==
X-CSE-MsgGUID: hBP6sCUVTzeUXH0cUgxa1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="61978035"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="61978035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 12:57:52 -0700
X-CSE-ConnectionGUID: 8clH4YKwS3+VJvb5mPWWfg==
X-CSE-MsgGUID: IvXOhb+eQCSAkYF7XMmJSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="174658915"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2025 12:57:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKjNs-000X3A-0A;
	Thu, 29 May 2025 19:57:48 +0000
Date: Fri, 30 May 2025 03:57:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 de0321bcc5fdd83631f0c2a6fdebfe0ad4e23449
Message-ID: <202505300323.fLOC8rbY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: de0321bcc5fdd83631f0c2a6fdebfe0ad4e23449  PCI: endpoint: Align pci_epc_set_msix(), pci_epc_ops::set_msix() nr_irqs encoding

elapsed time: 1271m

configs tested: 178
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-14.3.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-14.3.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-14.3.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250529    gcc-10.5.0
arc                   randconfig-002-20250529    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250529    clang-21
arm                   randconfig-002-20250529    gcc-8.5.0
arm                   randconfig-003-20250529    clang-21
arm                   randconfig-004-20250529    clang-21
arm                           spitz_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250529    gcc-6.5.0
arm64                 randconfig-002-20250529    clang-21
arm64                 randconfig-003-20250529    gcc-8.5.0
arm64                 randconfig-004-20250529    gcc-8.5.0
csky                              allnoconfig    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250529    gcc-15.1.0
csky                  randconfig-002-20250529    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250529    clang-21
hexagon               randconfig-002-20250529    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250529    gcc-12
i386        buildonly-randconfig-002-20250529    gcc-12
i386        buildonly-randconfig-003-20250529    gcc-12
i386        buildonly-randconfig-004-20250529    gcc-11
i386        buildonly-randconfig-005-20250529    clang-20
i386        buildonly-randconfig-006-20250529    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250530    clang-20
i386                  randconfig-002-20250530    clang-20
i386                  randconfig-003-20250530    clang-20
i386                  randconfig-004-20250530    clang-20
i386                  randconfig-005-20250530    clang-20
i386                  randconfig-006-20250530    clang-20
i386                  randconfig-007-20250530    clang-20
i386                  randconfig-011-20250530    gcc-12
i386                  randconfig-012-20250530    gcc-12
i386                  randconfig-013-20250530    gcc-12
i386                  randconfig-014-20250530    gcc-12
i386                  randconfig-015-20250530    gcc-12
i386                  randconfig-016-20250530    gcc-12
i386                  randconfig-017-20250530    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-14.3.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250529    gcc-15.1.0
loongarch             randconfig-002-20250529    gcc-12.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-14.3.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-14.3.0
mips                              allnoconfig    gcc-15.1.0
mips                           mtx1_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250529    gcc-12.4.0
nios2                 randconfig-002-20250529    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.3.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.3.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250529    gcc-9.3.0
parisc                randconfig-002-20250529    gcc-13.3.0
parisc64                         alldefconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.3.0
powerpc                          allyesconfig    clang-21
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                      katmai_defconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc               randconfig-001-20250529    clang-19
powerpc               randconfig-002-20250529    clang-21
powerpc               randconfig-003-20250529    clang-21
powerpc                     skiroot_defconfig    gcc-15.1.0
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc                 xes_mpc85xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250529    gcc-6.5.0
powerpc64             randconfig-002-20250529    clang-21
powerpc64             randconfig-003-20250529    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.3.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250529    clang-21
riscv                 randconfig-002-20250529    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250529    gcc-6.5.0
s390                  randconfig-002-20250529    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250529    gcc-15.1.0
sh                    randconfig-002-20250529    gcc-12.4.0
sh                           se7750_defconfig    gcc-15.1.0
sh                             sh03_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-14.3.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250529    gcc-11.5.0
sparc                 randconfig-002-20250529    gcc-11.5.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250529    gcc-11.5.0
sparc64               randconfig-002-20250529    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250529    clang-21
um                    randconfig-002-20250529    gcc-11
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250529    gcc-12
x86_64      buildonly-randconfig-002-20250529    clang-20
x86_64      buildonly-randconfig-003-20250529    gcc-12
x86_64      buildonly-randconfig-004-20250529    clang-20
x86_64      buildonly-randconfig-005-20250529    gcc-12
x86_64      buildonly-randconfig-006-20250529    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250530    gcc-12
x86_64                randconfig-002-20250530    gcc-12
x86_64                randconfig-003-20250530    gcc-12
x86_64                randconfig-004-20250530    gcc-12
x86_64                randconfig-005-20250530    gcc-12
x86_64                randconfig-006-20250530    gcc-12
x86_64                randconfig-007-20250530    gcc-12
x86_64                randconfig-008-20250530    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.3.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250529    gcc-7.5.0
xtensa                randconfig-002-20250529    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

