Return-Path: <linux-pci+bounces-35738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B499FB4AC3F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 13:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79991884B0B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15921A436;
	Tue,  9 Sep 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE7uSg3T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3091F9C1
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417815; cv=none; b=UhIS+20a5AhhJPSmZ0h2KapY3BeAKuboyseIqk8K45GcNMzVh5cAFFHgPQzTDv+Lrbc6GoiVxMNKN3Dc4XyO1MzX0jQFLUgJkx53Tx7mfcSNjMpkLEeBLKXr0ZeRq0Qkg5rZkaZ4VnOvHtRXOQPaiFeZ33OfU3fQ8jD7G2bNBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417815; c=relaxed/simple;
	bh=PKCEsVwdoQREkczJQc//M/JddounJbYzWv0ldYpDzjs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VNX7K+5nQ+fUHmyQLheOn/h1JU+6KSrhBLG+HGuQA1oDHBFn4O/MtHu9Y4Pd+PfLDpTHsu8TFkOiXEBi55jnpu5nlKtCew+1TZOD4ZAM1KQ8g4IqdY7bTzlvJciU+1+MhPtMkbx12wEmLY+JuTskMqY4YpTNm6+NMQd1qLEhuYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE7uSg3T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757417814; x=1788953814;
  h=date:from:to:cc:subject:message-id;
  bh=PKCEsVwdoQREkczJQc//M/JddounJbYzWv0ldYpDzjs=;
  b=jE7uSg3TLdtiBrvMe6fi4PRvqUkS/ikAlUZOI1i8FjOlj41LOXojVJGi
   dTBRaA8NOK+PdhJuRkPblI7NANSvG8ISkV9Kcown5LsIjfBQ39o1t2Uzg
   AZyKzPmzPNQ5+xDsBhYt/J5S3Jz/cAF5vBvLVTr6g+L+JcJfW8V2xRIF1
   pvcsQNwv7jd7jY0t2otokByVc69bhQTfeU2cGQ7OuBsuIOlArbp3YoTmT
   2CflONz5VU/3xnqrqFrG7/vfg7ARz8ZncFP7zeawRBdgscLbfHhZtjU4d
   xKuPl9pjpd6aGka3TmHylPkg2Dvt00AbQVnGYF16xcWM4wzMBwOBQAv1Z
   Q==;
X-CSE-ConnectionGUID: pX8f6OiaR46k5gRa3mYynw==
X-CSE-MsgGUID: HI8LB5gaT5+bZQnzwsO/Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="62325917"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="62325917"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:36:53 -0700
X-CSE-ConnectionGUID: Mn03tpdjS36qM8kxOf5FEA==
X-CSE-MsgGUID: z9W+SSzXTfSzI4gSqoLe+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="204050277"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Sep 2025 04:36:52 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvweX-0004nd-2j;
	Tue, 09 Sep 2025 11:36:49 +0000
Date: Tue, 09 Sep 2025 19:36:18 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/ti] BUILD SUCCESS
 f842d3313ba179d4005096357289c7ad09cec575
Message-ID: <202509091908.bxmTFl7G-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/ti
branch HEAD: f842d3313ba179d4005096357289c7ad09cec575  PCI: j721e: Fix programming sequence of "strap" settings

elapsed time: 1336m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250909    gcc-8.5.0
arc                   randconfig-002-20250909    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250909    clang-18
arm                   randconfig-002-20250909    clang-17
arm                   randconfig-003-20250909    clang-22
arm                   randconfig-004-20250909    clang-19
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    gcc-11.5.0
arm64                 randconfig-003-20250909    gcc-11.5.0
arm64                 randconfig-004-20250909    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250909    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250909    clang-22
hexagon               randconfig-002-20250909    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250908    gcc-14
i386        buildonly-randconfig-002-20250908    gcc-14
i386        buildonly-randconfig-003-20250908    gcc-12
i386        buildonly-randconfig-004-20250908    gcc-14
i386        buildonly-randconfig-005-20250908    clang-20
i386        buildonly-randconfig-006-20250908    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250909    gcc-15.1.0
loongarch             randconfig-002-20250909    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250909    gcc-11.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250909    clang-22
powerpc               randconfig-002-20250909    clang-17
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20250909    clang-20
powerpc64             randconfig-002-20250909    gcc-10.5.0
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250908    gcc-11.5.0
riscv                 randconfig-002-20250908    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250908    clang-22
s390                  randconfig-002-20250908    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250908    gcc-14.3.0
sh                    randconfig-002-20250908    gcc-14.3.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250908    gcc-8.5.0
sparc                 randconfig-002-20250908    gcc-12.5.0
sparc64               randconfig-001-20250908    gcc-13.4.0
sparc64               randconfig-002-20250908    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250908    gcc-14
um                    randconfig-002-20250908    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250908    clang-20
x86_64      buildonly-randconfig-002-20250908    gcc-14
x86_64      buildonly-randconfig-003-20250908    gcc-14
x86_64      buildonly-randconfig-004-20250908    gcc-14
x86_64      buildonly-randconfig-005-20250908    gcc-14
x86_64      buildonly-randconfig-006-20250908    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250908    gcc-9.5.0
xtensa                randconfig-002-20250908    gcc-11.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

