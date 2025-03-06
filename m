Return-Path: <linux-pci+bounces-23069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14755A5547C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932273B9F89
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFDF26E657;
	Thu,  6 Mar 2025 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcMTL2Ax"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAF26B954
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284535; cv=none; b=hO85yLZ2Tm0jx35bCyLYhvPUbveoDzwNRXajhuoznO1O4HjS8/2BRefrSyERKF0ZUfo4wjF2AO0GgSnQUqrz4JlGx9kpxvCzWeODtGANcOo4C3WZhUMovLXIbLYo8Rc/WhgNtUQcd6uTKTzOYX3P38LtimPbi+UEalreFMqzHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284535; c=relaxed/simple;
	bh=U6h2UuuzBDfxzTXOMh8PxH+sQh941+XDvVzWJa5mwhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DmMtKvlri4rH0V08K4ADCsLgP4nhxWxT9hTnLgxOjWVCwNxWsiD29yP5KbvtnYxPku5I930wtJpk5sOUJRUax0zq8jn28EngLm90JrL1bTkJuJDAlwxYP4rWVV/0FWQ0fLutv6zessz8UCsSau/Mc6oKoc50S0ILejM68SWIz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcMTL2Ax; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741284533; x=1772820533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U6h2UuuzBDfxzTXOMh8PxH+sQh941+XDvVzWJa5mwhQ=;
  b=WcMTL2AxmPwsT7GOvjQXi9FH227BHhdAJPGEspwSVRCXqJc9JqQhrL4t
   3vURIHZwbBVVv7HacrFopkgcXT1tg1G/EK7VDoWK4fa60uEqGLE8699HF
   dShF1pM5BnZ41RgwOPvPb4MJQBItHWyfW/eiTDF/Ck0LHcjM8q3Mwg13u
   xHLhIPdbpfz2O5Ihq6sYGeddcXTlW4pEX5YtP05D7dHditUrjWU/AwF4l
   9p+tC39gQrhq84/D1NMUzjs8vPMiFj+fJQi5pkScnx6k+sUP8+3xdFZV0
   FwtRDtPwOh49HA/Plx0cXWY/PH612jfC2+pXjRo2m4ybQpDw2pix00H6/
   w==;
X-CSE-ConnectionGUID: JleJ+xffSX+3cvPpTBrg4Q==
X-CSE-MsgGUID: zHpaXH0UQ92kIhWaX/UCDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41565885"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="41565885"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:08:52 -0800
X-CSE-ConnectionGUID: ryopjkgiQDiU+Bv1ZvljLg==
X-CSE-MsgGUID: kbKl8iL4SF+hDkoQEW24+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120017194"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Mar 2025 10:08:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqFeK-000NR2-2l;
	Thu, 06 Mar 2025 18:08:48 +0000
Date: Fri, 07 Mar 2025 02:07:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 c10505a0d6be33f1f1d47904fe40d38fd5306d0d
Message-ID: <202503070251.hjHl1FKL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: c10505a0d6be33f1f1d47904fe40d38fd5306d0d  misc: pci_endpoint_test: Do not use managed IRQ functions

elapsed time: 1447m

configs tested: 78
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250306    gcc-13.2.0
arc                  randconfig-002-20250306    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250306    gcc-14.2.0
arm                  randconfig-002-20250306    gcc-14.2.0
arm                  randconfig-003-20250306    gcc-14.2.0
arm                  randconfig-004-20250306    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250306    gcc-14.2.0
arm64                randconfig-002-20250306    gcc-14.2.0
arm64                randconfig-003-20250306    gcc-14.2.0
arm64                randconfig-004-20250306    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250306    gcc-14.2.0
csky                 randconfig-002-20250306    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250306    clang-21
hexagon              randconfig-002-20250306    clang-19
i386       buildonly-randconfig-001-20250306    clang-19
i386       buildonly-randconfig-002-20250306    clang-19
i386       buildonly-randconfig-003-20250306    clang-19
i386       buildonly-randconfig-004-20250306    gcc-12
i386       buildonly-randconfig-005-20250306    gcc-12
i386       buildonly-randconfig-006-20250306    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250306    gcc-14.2.0
loongarch            randconfig-002-20250306    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                            allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250306    gcc-14.2.0
nios2                randconfig-002-20250306    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250306    gcc-14.2.0
parisc               randconfig-002-20250306    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250306    clang-21
powerpc              randconfig-002-20250306    clang-18
powerpc              randconfig-003-20250306    gcc-14.2.0
powerpc64            randconfig-001-20250306    clang-18
powerpc64            randconfig-002-20250306    clang-21
powerpc64            randconfig-003-20250306    clang-18
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250306    clang-18
riscv                randconfig-002-20250306    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250306    gcc-14.2.0
s390                 randconfig-002-20250306    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                               allnoconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250306    gcc-14.2.0
sh                   randconfig-002-20250306    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                            allnoconfig    gcc-14.2.0
sparc                randconfig-001-20250306    gcc-14.2.0
sparc                randconfig-002-20250306    gcc-14.2.0
sparc64              randconfig-001-20250306    gcc-14.2.0
sparc64              randconfig-002-20250306    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250306    gcc-12
um                   randconfig-002-20250306    clang-16
x86_64     buildonly-randconfig-001-20250306    gcc-11
x86_64     buildonly-randconfig-002-20250306    clang-19
x86_64     buildonly-randconfig-003-20250306    clang-19
x86_64     buildonly-randconfig-004-20250306    clang-19
x86_64     buildonly-randconfig-005-20250306    clang-19
x86_64     buildonly-randconfig-006-20250306    gcc-12
xtensa                           allnoconfig    gcc-14.2.0
xtensa               randconfig-001-20250306    gcc-14.2.0
xtensa               randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

