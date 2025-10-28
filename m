Return-Path: <linux-pci+bounces-39547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA58C15A15
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 16:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6C6188721A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CB255248;
	Tue, 28 Oct 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyKUkdqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21085344025
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666600; cv=none; b=Q6mJBY0SvhbWHHhHtsS//Kjdj76/Jj8H/hp0vmNcdondVMl60mx7s53G0Q6qqkwsHFekbCwimalgLgbO8OvfsQTvujULxhG1g8RqojiDDIAzgu88Qsc41znut6+OA8sOzHsH6rYd+Fc0Al4OE+bIHeOjgP7vkHEOsM6caJ+P9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666600; c=relaxed/simple;
	bh=tkwl3CdEcvEOkIlZudkiAbmuyyvEOuHBM3/YFBmVZeM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DPEX/AOtV1qMApRNEOToO2SWh+27eree1Un7B1ODWZmH3nVkC6BKwkgipTel5mqPKHMtKao1sVOw+469QBM25UlcKvsyNM99reWHz87KJxVl72EVUVAtdevZa/72Hv4mHRdPkep2siBhBN1Yx5KrP0nPZI898H/bj01liCyzRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyKUkdqq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761666599; x=1793202599;
  h=date:from:to:cc:subject:message-id;
  bh=tkwl3CdEcvEOkIlZudkiAbmuyyvEOuHBM3/YFBmVZeM=;
  b=eyKUkdqqlH6i0zXAo7F4GOnfvGmH3SWMPCVUPfe0nBxUQReeBW6hCbW9
   /D6KvxujU4N9ttt8dPOBMVSODIaA9OUh0fjRa2ENKWmnIAovzGCCs+Ef1
   pO7pQVJ00l2w3wYVB5mFiNVeU3GdkYhiUdFBEWlv87zMqDXBmyYwBKqi4
   Gy/ylabgD3/uMGL5XpszhVolQ4PVkVLtYYpV6vUijqbdOLj3m8uM6gXqS
   SjdB3uk9hJmlna5jbWu415VpTJnZ483q6yyT2ndfEhx4DVQF01fCj3yFT
   /mP1MvGSGZy8jOljJDAF2/57Sqqdj5iw9nh+lmGMVnKXIaQlGDcVNKoG2
   g==;
X-CSE-ConnectionGUID: igtVCvb+RjWMhbIUKXrmdA==
X-CSE-MsgGUID: VQG7IS45Q+SlUrMRsPgzrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75114520"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75114520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:49:58 -0700
X-CSE-ConnectionGUID: NzGQN/dHSKqxqaSCYQKtTg==
X-CSE-MsgGUID: gb37JWdPRk6hH+xSTomGwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184626140"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 28 Oct 2025 08:49:58 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDlxL-000JJn-0E;
	Tue, 28 Oct 2025 15:49:55 +0000
Date: Tue, 28 Oct 2025 23:43:08 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 dc693d60664470ec47188c328055d80e8ce7ea44
Message-ID: <202510282302.rMSfPBsK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: dc693d60664470ec47188c328055d80e8ce7ea44  PCI: endpoint: pci-epf-vntb: Add MSI doorbell support

elapsed time: 1453m

configs tested: 148
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251028    gcc-8.5.0
arc                   randconfig-002-20251028    gcc-13.4.0
arc                   randconfig-002-20251028    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                       aspeed_g5_defconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251028    clang-22
arm                   randconfig-001-20251028    gcc-8.5.0
arm                   randconfig-002-20251028    clang-22
arm                   randconfig-002-20251028    gcc-8.5.0
arm                   randconfig-003-20251028    clang-22
arm                   randconfig-003-20251028    gcc-8.5.0
arm                   randconfig-004-20251028    gcc-8.5.0
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251028    clang-22
arm64                 randconfig-001-20251028    gcc-8.5.0
arm64                 randconfig-002-20251028    clang-22
arm64                 randconfig-002-20251028    gcc-8.5.0
arm64                 randconfig-003-20251028    gcc-11.5.0
arm64                 randconfig-003-20251028    gcc-8.5.0
arm64                 randconfig-004-20251028    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251028    gcc-15.1.0
csky                  randconfig-002-20251028    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251028    clang-22
hexagon               randconfig-002-20251028    clang-17
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-006-20251028    gcc-14
i386                  randconfig-001-20251028    clang-20
i386                  randconfig-002-20251028    clang-20
i386                  randconfig-003-20251028    clang-20
i386                  randconfig-004-20251028    clang-20
i386                  randconfig-005-20251028    clang-20
i386                  randconfig-006-20251028    clang-20
i386                  randconfig-007-20251028    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20251028    gcc-12.5.0
loongarch             randconfig-002-20251028    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251028    gcc-8.5.0
nios2                 randconfig-002-20251028    gcc-9.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251028    gcc-9.5.0
parisc                randconfig-002-20251028    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251028    gcc-15.1.0
powerpc               randconfig-002-20251028    gcc-11.5.0
powerpc               randconfig-003-20251028    gcc-8.5.0
powerpc64             randconfig-001-20251028    clang-22
powerpc64             randconfig-002-20251028    clang-22
powerpc64             randconfig-003-20251028    gcc-13.4.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-14
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251028    clang-20
x86_64      buildonly-randconfig-001-20251028    gcc-14
x86_64      buildonly-randconfig-002-20251028    clang-20
x86_64      buildonly-randconfig-002-20251028    gcc-14
x86_64      buildonly-randconfig-003-20251028    clang-20
x86_64      buildonly-randconfig-004-20251028    clang-20
x86_64      buildonly-randconfig-005-20251028    clang-20
x86_64      buildonly-randconfig-006-20251028    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

