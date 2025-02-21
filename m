Return-Path: <linux-pci+bounces-22008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A3A3FCCD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9583BC2BA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41E21B9EA;
	Fri, 21 Feb 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR8qaHqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC652228C8D
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157097; cv=none; b=mJVnkkYWuxqOWEhUDDsOqXFFfqcZGCa7lSSbLVefXeOEm4obPRLyzQWEuZTQQdMs6M3k1mVOgWHhnLYEVtuflR8s0hkZ78pU6orVoDzM5UuSSc9VAFB+KRJ6FPFGcEsUXUlCZjUVYdYS0jm8a/jm+0e3zd/qPnwRo/FTt7gV5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157097; c=relaxed/simple;
	bh=mAI/LKmgYNJGHIrtPeEJzw5W+G2uDJ+U2jltvyxclig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f+vRVnIq+oszgrc7znXt7kh97tBPMICghVvxNmaD76a6dRxs0lfr6tnOZNJmziNXez7GNmeetOujD5ueLflaHsos09XP+Ss5/ljcpo1OoWJjRI4AmHMJ6q1GE3A09ibrlVjj6ICoHRW24koZLErT+qN8jIksXk/kgfidLF+VlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR8qaHqB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740157096; x=1771693096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mAI/LKmgYNJGHIrtPeEJzw5W+G2uDJ+U2jltvyxclig=;
  b=AR8qaHqB50cMoHwkt8X6nwizLw0wunQko5ith0+blXsgs2IOO7+BNPnH
   oHYpCAFcCc1CeNLwmHhpyV+LaDS/bh6iOiMbaG5oK+/FVUMPE5f4HO659
   2GyySc5kQZPdA4ahBD8abk3X2vbrMqpAlpRjYX9miebINXF5VUAHN9Jg9
   t9GPmKHIw35pj5x8teC8eoiul4I3TJOkOJEVOsbsVFCReSzO1fV6dnZas
   r5LXcmnOKzJxMxiBGQIP+l2aAp7a4nfaZSHst2YSanwd5ffdY7GtrmW79
   LPTt5nm4IlH8PYti/7kReJh3zqfaikp9H2hIEV8jBR7kMGj0CYHMWZfNP
   Q==;
X-CSE-ConnectionGUID: ZROz9N6URduZRghPG35Oqw==
X-CSE-MsgGUID: 1Hti4s+PS+mNU4XqhH4DWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52412443"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52412443"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:58:13 -0800
X-CSE-ConnectionGUID: wWsykK0MTsWzrjXq6aOXqw==
X-CSE-MsgGUID: gAjptFP5QW6vmLr8Lw4NyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115923256"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 08:58:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlWLp-0005mF-2O;
	Fri, 21 Feb 2025 16:58:09 +0000
Date: Sat, 22 Feb 2025 00:58:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 0e2cb0f7b966d44910edb2b91c2e50afce113465
Message-ID: <202502220000.tfnCivrn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 0e2cb0f7b966d44910edb2b91c2e50afce113465  PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED

elapsed time: 1455m

configs tested: 74
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250221    gcc-13.2.0
arc                  randconfig-002-20250221    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250221    gcc-14.2.0
arm                  randconfig-002-20250221    clang-19
arm                  randconfig-003-20250221    gcc-14.2.0
arm                  randconfig-004-20250221    clang-21
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250221    clang-15
arm64                randconfig-002-20250221    clang-21
arm64                randconfig-003-20250221    clang-21
arm64                randconfig-004-20250221    gcc-14.2.0
csky                 randconfig-001-20250221    gcc-14.2.0
csky                 randconfig-002-20250221    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250221    clang-21
hexagon              randconfig-002-20250221    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250221    gcc-14.2.0
loongarch            randconfig-002-20250221    gcc-14.2.0
nios2                randconfig-001-20250221    gcc-14.2.0
nios2                randconfig-002-20250221    gcc-14.2.0
parisc               randconfig-001-20250221    gcc-14.2.0
parisc               randconfig-002-20250221    gcc-14.2.0
powerpc              randconfig-001-20250221    clang-21
powerpc              randconfig-002-20250221    clang-21
powerpc              randconfig-003-20250221    clang-17
powerpc64            randconfig-001-20250221    clang-21
powerpc64            randconfig-002-20250221    clang-21
powerpc64            randconfig-003-20250221    clang-19
riscv                randconfig-001-20250221    clang-21
riscv                randconfig-002-20250221    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250221    gcc-14.2.0
s390                 randconfig-002-20250221    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250221    gcc-14.2.0
sh                   randconfig-002-20250221    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250221    gcc-14.2.0
sparc                randconfig-002-20250221    gcc-14.2.0
sparc64              randconfig-001-20250221    gcc-14.2.0
sparc64              randconfig-002-20250221    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250221    gcc-12
um                   randconfig-002-20250221    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250221    gcc-12
x86_64     buildonly-randconfig-002-20250221    clang-19
x86_64     buildonly-randconfig-003-20250221    clang-19
x86_64     buildonly-randconfig-004-20250221    clang-19
x86_64     buildonly-randconfig-005-20250221    clang-19
x86_64     buildonly-randconfig-006-20250221    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250221    gcc-14.2.0
xtensa               randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

