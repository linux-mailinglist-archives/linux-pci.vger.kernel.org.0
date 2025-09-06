Return-Path: <linux-pci+bounces-35615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F84B47736
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A349C7ADB78
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B37131E2D;
	Sat,  6 Sep 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWhcbNwN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2627815F
	for <linux-pci@vger.kernel.org>; Sat,  6 Sep 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757192429; cv=none; b=uw53gfBaessoN3ARRbY3YJNRugtE1dFhTzkg+hFhj0xyVUnloz+FjPLzhKB/CZt5XyAQU9gpVob/1y895VBSQs6sNVQkFsGnFYCojezNdXHuGmIlCfHBcZNLxxFCvm8zvLs0gw16Nmm6f6XkMQQbAbjcD0UN2KTxGeZu3E//22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757192429; c=relaxed/simple;
	bh=Lo9ExjO7aqO5iPobgZjeYlJvu3l4s9+l7qIV4u9WTa8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ql+wnittzVlxRi7UizVq18vJQVzz9cORRfvXzFEifzxe52Po2A6vn9DvaNPHRBI6bUS0rl937RFocPZ9VB67vCK+RHukymgbl33rF/3qXHxL5DiIQH2kyy9yJTylaLX7iipdvCURPYMSS57sG/sdE+k/dRbDkBR/cr5MSS4auW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWhcbNwN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757192428; x=1788728428;
  h=date:from:to:cc:subject:message-id;
  bh=Lo9ExjO7aqO5iPobgZjeYlJvu3l4s9+l7qIV4u9WTa8=;
  b=AWhcbNwN2Zzeeq03lv3EGNOlzi8/nTgRFhspu2DwA9eyOzSR3rGjS26d
   X3yjOO06pD2qgFcaX2DooDObXu6kjbbls+Wf9khd39mPnMFRGxUOINwPt
   AbJhwzgodFA3W9vuALDnLw6BTBEkqJCYbWzHgOoUR/G8RNDna3C6PuxMP
   XRc3qqk8DWGyZwrMmz0cT18rVYYzKFYYcYSZhyHW0zOjOFzmtldupt4LW
   uOgQktkGqIH1IukbdPnGOtWbvDdZ+rNMyyGKy0Xkk10yUw9p3CPhE2FWY
   tYGBWssqbMSl2mmt0NdoSU6wtobqzdCIgaXzDxJM/Z3jcqZBgIsww3H4o
   w==;
X-CSE-ConnectionGUID: ltoLu+wcTWuhxE/rcPwXiA==
X-CSE-MsgGUID: 5m3O2nh0TvGApLVXwO4/Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="59576621"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="59576621"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:00:27 -0700
X-CSE-ConnectionGUID: pZ9ie6+FThCUWCZMDwhulQ==
X-CSE-MsgGUID: uJb/hLCnRyS9O8UYcB3pQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172546267"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Sep 2025 14:00:26 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv01H-0001n1-1f;
	Sat, 06 Sep 2025 21:00:23 +0000
Date: Sun, 07 Sep 2025 04:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-ecam] BUILD SUCCESS
 f655b3da9db4f8886db6e34f6dcbc94753e3c198
Message-ID: <202509070426.V1UBnWby-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-ecam
branch HEAD: f655b3da9db4f8886db6e34f6dcbc94753e3c198  PCI: qcom: Configure ELBI base and iATU if ECAM is enabled by DWC core

elapsed time: 1946m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250905    gcc-11.5.0
arc                   randconfig-002-20250905    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250905    clang-22
arm                   randconfig-002-20250905    clang-22
arm                   randconfig-003-20250905    clang-16
arm                   randconfig-004-20250905    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250905    clang-22
arm64                 randconfig-002-20250905    clang-17
arm64                 randconfig-003-20250905    clang-17
arm64                 randconfig-004-20250905    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250906    gcc-15.1.0
csky                  randconfig-002-20250906    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250906    clang-20
hexagon               randconfig-002-20250906    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250905    clang-20
i386        buildonly-randconfig-002-20250905    clang-20
i386        buildonly-randconfig-003-20250905    clang-20
i386        buildonly-randconfig-004-20250905    gcc-13
i386        buildonly-randconfig-005-20250905    clang-20
i386        buildonly-randconfig-006-20250905    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250906    clang-22
loongarch             randconfig-002-20250906    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
mips                        omega2p_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250906    gcc-11.5.0
nios2                 randconfig-002-20250906    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250906    gcc-11.5.0
parisc                randconfig-002-20250906    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250906    gcc-14.3.0
powerpc               randconfig-002-20250906    clang-20
powerpc               randconfig-003-20250906    clang-22
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250906    gcc-13.4.0
powerpc64             randconfig-002-20250906    gcc-10.5.0
powerpc64             randconfig-003-20250906    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250905    gcc-14.3.0
riscv                 randconfig-002-20250905    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250905    gcc-9.5.0
s390                  randconfig-002-20250905    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250905    gcc-15.1.0
sh                    randconfig-002-20250905    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250905    gcc-8.5.0
sparc                 randconfig-002-20250905    gcc-15.1.0
sparc64               randconfig-001-20250905    gcc-8.5.0
sparc64               randconfig-002-20250905    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250905    clang-22
um                    randconfig-002-20250905    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250905    clang-20
x86_64      buildonly-randconfig-002-20250905    clang-20
x86_64      buildonly-randconfig-003-20250905    gcc-13
x86_64      buildonly-randconfig-004-20250905    clang-20
x86_64      buildonly-randconfig-005-20250905    clang-20
x86_64      buildonly-randconfig-006-20250905    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250905    gcc-8.5.0
xtensa                randconfig-002-20250905    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

