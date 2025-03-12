Return-Path: <linux-pci+bounces-23521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E8A5E352
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 19:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B414A17AD2A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA141DED52;
	Wed, 12 Mar 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VI8udc8J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238620ED
	for <linux-pci@vger.kernel.org>; Wed, 12 Mar 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802377; cv=none; b=MvAtq/JEYymShDwh3DB57sYoqCGBdwDytT4V16KgY+0n/DlttcYW0QW+wKQg7m6rHMCPbtfT/ykfJs6UiqZzRAjc4RWn8k93ISaXABIm1QxdgFlaMLrmuz1APbncLibu5yWMb6yWFOFCRTGmX6Y+vTbVWakENhtQXVZGI85oX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802377; c=relaxed/simple;
	bh=w8U00065X52c7RqZS1uUNpTq4HC4b5vzQ5q9iIyiBh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DSW7eYJqk3c+L8GwU9rZvHm7GUgOqM/+We0I++Q5c4BIqZPLPiPiVQdGZD0GHIjayHDpJB1zqHOTnTUqV4gdOxoDOVvo/sV3CyGWlrEdxFS9mszA4CqRGmPWt9lE8pEGL3ERy+u86VmlXTCHm2rYgTUEf28COEtWFMwbvIFBmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VI8udc8J; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741802377; x=1773338377;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w8U00065X52c7RqZS1uUNpTq4HC4b5vzQ5q9iIyiBh4=;
  b=VI8udc8Ja+CYnS7s1+HjwMd376JG4r8/HgxBuAZcUhfb/YK4FZ6I1JJ0
   enc5muNofzPQOVAswQflKiN2PP7GNyQmal/N9x52eacSie0piR/58Oop1
   nGHDJTShShfZhDX0+LHZVUHUwCivou55v484zgyrfyQQcmrIGyn3fpskY
   ecbzpi0pfNfFEvR5BNDEuIjVtfaWvGyye+4nvC2p9ORYksYFKm7vsIh71
   Ky3yxhmj7n0TsD0njewUloO/hPTIOkynOB5Xl2Nt/QIl+tqYcPQde4LdE
   Vdb+Bbj6+g/YaJIHNZiWiaT5Cc2q64QtxffShNEExOeem+fiNfhp9GOIy
   w==;
X-CSE-ConnectionGUID: 9nHM1AxUTm2DauXPvgEHnw==
X-CSE-MsgGUID: xQYxtjacRKC/r/c6EsYOuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53890244"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53890244"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:59:36 -0700
X-CSE-ConnectionGUID: 6HZCBIhrT3qAoM/g5ohpqw==
X-CSE-MsgGUID: ToBq8/OMSuC3EQ+3tPWx6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120945772"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2025 10:59:34 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsQMe-0008mi-0z;
	Wed, 12 Mar 2025 17:59:32 +0000
Date: Thu, 13 Mar 2025 01:58:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 69255fc3c4d08173f8c2b51489fcd772b77c6fd1
Message-ID: <202503130128.89zLi1zo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 69255fc3c4d08173f8c2b51489fcd772b77c6fd1  PCI: dw-rockchip: Hide broken ATS capability for RK3588 running in EP mode

elapsed time: 1445m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250312    gcc-13.2.0
arc                   randconfig-002-20250312    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250312    clang-19
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250312    clang-19
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250312    gcc-14.2.0
arm64                 randconfig-003-20250312    gcc-14.2.0
arm64                 randconfig-004-20250312    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250312    clang-21
hexagon               randconfig-002-20250312    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250312    clang-19
i386        buildonly-randconfig-002-20250312    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250312    clang-19
i386                                defconfig    clang-19
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250312    clang-21
powerpc               randconfig-002-20250312    clang-21
powerpc               randconfig-003-20250312    clang-21
powerpc64             randconfig-001-20250312    clang-17
powerpc64             randconfig-002-20250312    clang-15
powerpc64             randconfig-003-20250312    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250312    clang-21
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250312    clang-15
s390                  randconfig-002-20250312    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250312    gcc-12
um                    randconfig-002-20250312    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250312    clang-19
x86_64      buildonly-randconfig-002-20250312    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250312    clang-19
x86_64      buildonly-randconfig-005-20250312    clang-19
x86_64      buildonly-randconfig-006-20250312    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

