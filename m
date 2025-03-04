Return-Path: <linux-pci+bounces-22902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736EA4EDEC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D7018914FF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848F189F5C;
	Tue,  4 Mar 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoGkR0L+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598261EE7AD
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118085; cv=none; b=dzQlcoKwqLcoiYp/cwKe6sEprk6EsjGDcmdqFOg2iOQetZrAT0dArPbMxc6cdxQpGrV4JqTZwhXIN9hxal8QxFC9Rpns5pchxvox9VeFESKzr1OUyfSZ9RFtly9D38s5NTzwD75GWGlzjJfn2j//cidAWV5ZDwpxQbaKuo4xQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118085; c=relaxed/simple;
	bh=sRwcR7Qrt83aD3jTNZ+BucXasg4YKKDzU0LibD2+y9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dRlx2YFgvEmrt/1Y8nfpHlPMjaaZA47vaBrydj4+Jh+VCZtFJh6A/AX5K4VyANtBWRBSx/xP8gXOR3ZFrv1gDoJqkplmupXcihqaBCnSm304UXbMMejmIqSLJtBcqx2Nm60SnnoacNzJ+j62LvEyEQCnZ3rya/Laxu0eXmIM0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoGkR0L+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741118084; x=1772654084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sRwcR7Qrt83aD3jTNZ+BucXasg4YKKDzU0LibD2+y9Y=;
  b=WoGkR0L+wlk0sY7Q5ttfhqJ/7b9oBKn8aO0JqgLHO/0D4akmCyj77C/F
   VaUn7LYOzYfrxeKNHBHduBxr2A/Yu5ONfKLMP6bGEFfVDeyrki8HVo9iD
   BoyMww7eSFmXgSEjuI7bUZ86WiWriNj/ET/d/USFahUzY4Gd+9xTXndzT
   OtTMqJCZx/DZV7R+wjUwC/qYvCa4CtAw1DO2/Ysg/2wLeAzzHZ27YdIru
   EBkYFK8H895UYzbc+K2rxWeivgzws/3zXgvlSSu1T3G7BTyeRhZTJNIeo
   GNRqrvFOPFUeaLMunmBs/D0wcw8vkS/IPyht47/a6E5t48AvmOduhznjp
   g==;
X-CSE-ConnectionGUID: /k730uqDS3+ukm4HyhCCxA==
X-CSE-MsgGUID: EPVsIGWVS/+LueRQMwVPgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42083968"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42083968"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:54:43 -0800
X-CSE-ConnectionGUID: KmDy5g+gRlWSVfnuEI3ftw==
X-CSE-MsgGUID: 8KTEprSYQHmPjco7FK/Q0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123671519"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2025 11:54:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpYLg-000KDa-1i;
	Tue, 04 Mar 2025 19:54:40 +0000
Date: Wed, 05 Mar 2025 03:53:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 249b78298078448a699c39356d27d8183af4b281
Message-ID: <202503050335.MugXQ4if-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 249b78298078448a699c39356d27d8183af4b281  PCI: mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC

elapsed time: 1451m

configs tested: 100
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250304    gcc-13.2.0
arc                   randconfig-002-20250304    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250304    clang-21
arm                   randconfig-002-20250304    gcc-14.2.0
arm                   randconfig-003-20250304    clang-21
arm                   randconfig-004-20250304    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250304    clang-21
arm64                 randconfig-002-20250304    gcc-14.2.0
arm64                 randconfig-003-20250304    gcc-14.2.0
arm64                 randconfig-004-20250304    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250304    gcc-14.2.0
csky                  randconfig-002-20250304    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250304    clang-21
hexagon               randconfig-002-20250304    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250304    clang-19
i386        buildonly-randconfig-002-20250304    clang-19
i386        buildonly-randconfig-003-20250304    gcc-12
i386        buildonly-randconfig-004-20250304    gcc-11
i386        buildonly-randconfig-005-20250304    gcc-11
i386        buildonly-randconfig-006-20250304    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250304    gcc-14.2.0
loongarch             randconfig-002-20250304    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250304    gcc-14.2.0
nios2                 randconfig-002-20250304    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250304    gcc-14.2.0
parisc                randconfig-002-20250304    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    clang-21
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250304    gcc-14.2.0
powerpc               randconfig-002-20250304    gcc-14.2.0
powerpc               randconfig-003-20250304    clang-21
powerpc64             randconfig-001-20250304    gcc-14.2.0
powerpc64             randconfig-002-20250304    gcc-14.2.0
powerpc64             randconfig-003-20250304    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250304    gcc-14.2.0
riscv                 randconfig-002-20250304    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                  randconfig-001-20250304    clang-15
s390                  randconfig-002-20250304    clang-15
sh                                allnoconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250304    gcc-14.2.0
sh                    randconfig-002-20250304    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250304    gcc-14.2.0
sparc                 randconfig-002-20250304    gcc-14.2.0
sparc64               randconfig-001-20250304    gcc-14.2.0
sparc64               randconfig-002-20250304    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250304    gcc-12
um                    randconfig-002-20250304    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250304    clang-19
x86_64      buildonly-randconfig-002-20250304    gcc-12
x86_64      buildonly-randconfig-003-20250304    gcc-12
x86_64      buildonly-randconfig-004-20250304    gcc-12
x86_64      buildonly-randconfig-005-20250304    gcc-12
x86_64      buildonly-randconfig-006-20250304    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250304    gcc-14.2.0
xtensa                randconfig-002-20250304    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

