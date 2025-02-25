Return-Path: <linux-pci+bounces-22381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF4A44BB0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 20:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99A2420E87
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12B1DC9BB;
	Tue, 25 Feb 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJeYAwNj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7313957E
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512524; cv=none; b=qSrd3Xs+1UZUCYpKQLlSCFiYJ5j9uq6nQPTvojPLFVxiAx41T1iINkCLLM31q1jCJlh8GHxhzwrxe5jbKAljZGJM4Sx42N6hzcsVGVaZOHZcyrzPbPPDL2hA7K9W5WBV4k7DZrnVDO731VgV96cr4NTVk2tosuG90Lda2FXo5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512524; c=relaxed/simple;
	bh=t909DLc0x5Sg4/lZVmckf6btsFXsnaek76TAnnovma0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UwTwSS94X5hkNtP7E/bBFUjQD0yhEyTWyjOqm4vysuWFrGIlJKSG2NQtAwXODBdH3IW7vmXBPokPvy5WyHkfrBhEDSrG+s+i7UPcAgQxZpAn+MHrJSpwrCZ2Z/Ib24Gck5k8p9iAEgAPxSuKXP0MwjjK0oxw0/ODlYXWFysRW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJeYAwNj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740512522; x=1772048522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t909DLc0x5Sg4/lZVmckf6btsFXsnaek76TAnnovma0=;
  b=KJeYAwNjlKHrBZSOuPKhtD+YXQEKJLKHbH6UfBsZAjxieHJG32fbIbyK
   IgQhKXAsszJx/AmlpQ5C8iu76K+qhhkd7xoUlTZRQs0B4ZCLljWeu3hZ3
   vqQ1IYAeNBvHTAT2I4rhNZEzOwpRwkSSnMwmL0OYgATU3lg36X8O+QgcU
   1uGl7J8TNpG7SNfvYCqhB3tmKr0BUcIhyi/dXikYaYjPQ9LIIuOlwLscT
   OWsGNiK0xMlKUIKap+jKfetHqBP6mzmQyilqUVVFBKvwKJDuiHdzScjCQ
   6MG3F0/0biNVruF6Bq7hS2xsPc6r7ciIsN3tja9JjDe5MdcDFipczscLp
   Q==;
X-CSE-ConnectionGUID: ouP4NcRmS1SqyxLLpVUtow==
X-CSE-MsgGUID: jCX4Y0jdR9+XOh1ckgwlmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41042231"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41042231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 11:42:01 -0800
X-CSE-ConnectionGUID: 3gvJvC+xTJy3ELozS8vo8Q==
X-CSE-MsgGUID: dcfgU9JrR+G0rUxRdpG6Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116286829"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 11:42:00 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tn0oY-000AgJ-0Z;
	Tue, 25 Feb 2025 19:41:58 +0000
Date: Wed, 26 Feb 2025 03:40:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 a15a2270783471b4c224351a5a458c91e2776032
Message-ID: <202502260340.BBcgcJnC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: a15a2270783471b4c224351a5a458c91e2776032  PCI: brcmstb: Add BCM2712 support

elapsed time: 1452m

configs tested: 91
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
alpha                              defconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250225    gcc-13.2.0
arc                  randconfig-002-20250225    gcc-13.2.0
arm                             alldefconfig    gcc-14.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                             allyesconfig    gcc-14.2.0
arm                         moxart_defconfig    gcc-14.2.0
arm                  randconfig-001-20250225    gcc-14.2.0
arm                  randconfig-002-20250225    gcc-14.2.0
arm                  randconfig-003-20250225    gcc-14.2.0
arm                  randconfig-004-20250225    clang-15
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250225    clang-19
arm64                randconfig-002-20250225    clang-17
arm64                randconfig-003-20250225    clang-15
arm64                randconfig-004-20250225    clang-21
csky                 randconfig-001-20250225    gcc-14.2.0
csky                 randconfig-002-20250225    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250225    clang-21
hexagon              randconfig-002-20250225    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250225    clang-19
i386       buildonly-randconfig-002-20250225    gcc-11
i386       buildonly-randconfig-003-20250225    clang-19
i386       buildonly-randconfig-004-20250225    clang-19
i386       buildonly-randconfig-005-20250225    gcc-12
i386       buildonly-randconfig-006-20250225    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250225    gcc-14.2.0
loongarch            randconfig-002-20250225    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
m68k                       m5272c3_defconfig    gcc-14.2.0
mips                      rbtx49xx_defconfig    gcc-14.2.0
nios2                randconfig-001-20250225    gcc-14.2.0
nios2                randconfig-002-20250225    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250225    gcc-14.2.0
parisc               randconfig-002-20250225    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-16
powerpc              randconfig-001-20250225    gcc-14.2.0
powerpc              randconfig-002-20250225    clang-19
powerpc              randconfig-003-20250225    clang-21
powerpc64            randconfig-001-20250225    gcc-14.2.0
powerpc64            randconfig-002-20250225    gcc-14.2.0
powerpc64            randconfig-003-20250225    gcc-14.2.0
riscv                           allmodconfig    clang-21
riscv                           allyesconfig    clang-21
riscv                randconfig-001-20250225    clang-15
riscv                randconfig-002-20250225    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250225    clang-15
s390                 randconfig-002-20250225    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250225    gcc-14.2.0
sh                   randconfig-002-20250225    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250225    gcc-14.2.0
sparc                randconfig-002-20250225    gcc-14.2.0
sparc64              randconfig-001-20250225    gcc-14.2.0
sparc64              randconfig-002-20250225    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250225    clang-21
um                   randconfig-002-20250225    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250225    gcc-12
x86_64     buildonly-randconfig-002-20250225    clang-19
x86_64     buildonly-randconfig-003-20250225    clang-19
x86_64     buildonly-randconfig-004-20250225    gcc-11
x86_64     buildonly-randconfig-005-20250225    gcc-12
x86_64     buildonly-randconfig-006-20250225    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250225    gcc-14.2.0
xtensa               randconfig-002-20250225    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

