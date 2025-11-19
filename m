Return-Path: <linux-pci+bounces-41680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4113AC711B7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05D5B4E1418
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945B372AA7;
	Wed, 19 Nov 2025 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9WKqr6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82423D291
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586223; cv=none; b=LKGasA5/SVK3NsxDxp30cOI+dUgv2mRTASW2bg533rmhGsLa6wdG7XJDRgoKYJ4NYc2Ssm60ig7ZfFTZDgQ5wZim5dJI9vbSU9Mg9etw1gYxiMfi3J5ONsOCzopyLomeEeJy1pJ7n6/I++75gIwVOD87Pd7RCaoM+H4hzz5MobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586223; c=relaxed/simple;
	bh=uaL8xlToLFmXXQV9leEy9bTePmvmEYR1E1lF+0PO6gk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EcUvVBQgAJAMQRk/+xVkM1M1MXpSu7OUMG49P4yq4b9AJebDe8w2kWET0frdxSDfvClNY5GLFJhJ+4h2GVe3JyoL388mWg2L5xzSbrNrtyzXJWlFdP319OmjaCiFMJp/WsrBJQtMjgmC4oMA9MNx+WbtaaKwx3emvp6emYddX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9WKqr6e; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763586221; x=1795122221;
  h=date:from:to:cc:subject:message-id;
  bh=uaL8xlToLFmXXQV9leEy9bTePmvmEYR1E1lF+0PO6gk=;
  b=b9WKqr6eowNBysXfeT5goqZH5oCbH+6fnQCUJV5dCy0i9z42ygK+3zQr
   uG7BnbgpCuLPjA2br5CnC6htrpBV8kfNrhhauyJMxSkmt9wBPevUtkiki
   L2w6U+QFkqpWYUynI08a1PPZifZowIa4vgitARo0hsxNEjeFL/lz/YkNN
   909EdvEvHW4ez21Q4DuKzuFSGTgUWtgGvpbmz59TjOj1TFOJOh1rCFY8y
   vWRGcUuED4v3HGGuIGbbfQ7bi8x5rhEdXD0ieZnWByVFQsAdba4osLhnn
   n7NGd2dilua8oPkI1Fb12MmJDJmy+9iun2oDxcL+2nuScD/d2izR+W8eJ
   g==;
X-CSE-ConnectionGUID: BjCeO+f4QHeaucM6h92eGQ==
X-CSE-MsgGUID: lbO6ZlAvQi27lgMwZ1HRKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="91119712"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="91119712"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:03:40 -0800
X-CSE-ConnectionGUID: 8JDA1WDeTgyutxDQi9TqkA==
X-CSE-MsgGUID: KoL9NgN2SUSr0kq0bPQ1fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191295501"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 13:03:39 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLpKz-0003KF-13;
	Wed, 19 Nov 2025 21:03:37 +0000
Date: Thu, 20 Nov 2025 05:02:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl-tc9563] BUILD REGRESSION
 72359837ad0d3f2cbc1364d1cba84357d6d38615
Message-ID: <202511200536.AWGTZELg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl-tc9563
branch HEAD: 72359837ad0d3f2cbc1364d1cba84357d6d38615  PCI: pwrctrl: Add power control driver for TC9563

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511200555.M4TX84jK-lkp@intel.com

    (.text+0x4c): undefined reference to `i2c_unregister_device'
    alpha-linux-ld: (.text+0x50): undefined reference to `i2c_unregister_device'
    alpha-linux-ld: (.text+0x60): undefined reference to `i2c_put_adapter'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- alpha-randconfig-r054-20251120
    |-- (.text):undefined-reference-to-i2c_unregister_device
    |-- alpha-linux-ld:(.text):undefined-reference-to-i2c_put_adapter
    |-- alpha-linux-ld:(.text):undefined-reference-to-i2c_unregister_device
    `-- drivers-pci-pwrctrl-pci-pwrctrl-tc9563.c:Unneeded-semicolon

elapsed time: 1550m

configs tested: 112
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251119    gcc-10.5.0
arc                   randconfig-002-20251119    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251119    gcc-8.5.0
arm                   randconfig-002-20251119    clang-16
arm                   randconfig-003-20251119    clang-22
arm                   randconfig-004-20251119    gcc-13.4.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251119    clang-22
arm64                 randconfig-002-20251119    gcc-8.5.0
arm64                 randconfig-003-20251119    clang-22
arm64                 randconfig-004-20251119    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251119    gcc-15.1.0
csky                  randconfig-002-20251119    gcc-10.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251119    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251119    gcc-14
i386        buildonly-randconfig-002-20251119    clang-20
i386        buildonly-randconfig-003-20251119    clang-20
i386        buildonly-randconfig-004-20251119    clang-20
i386        buildonly-randconfig-005-20251119    gcc-14
i386        buildonly-randconfig-006-20251119    gcc-14
i386                  randconfig-011-20251119    clang-20
i386                  randconfig-012-20251119    clang-20
i386                  randconfig-013-20251119    clang-20
i386                  randconfig-014-20251119    gcc-14
i386                  randconfig-015-20251119    gcc-14
i386                  randconfig-016-20251119    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-002-20251119    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251119    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251119    gcc-8.5.0
parisc                randconfig-002-20251119    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20251119    clang-16
powerpc               randconfig-002-20251119    clang-22
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                     tqm8548_defconfig    clang-22
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251119    clang-19
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251119    gcc-15.1.0
riscv                 randconfig-002-20251119    gcc-10.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251119    gcc-8.5.0
s390                  randconfig-002-20251119    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251119    gcc-11.5.0
sh                    randconfig-002-20251119    gcc-9.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251119    gcc-15.1.0
sparc                 randconfig-002-20251119    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251119    gcc-15.1.0
sparc64               randconfig-002-20251119    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251119    clang-16
um                    randconfig-002-20251119    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251119    gcc-14
x86_64      buildonly-randconfig-002-20251119    gcc-14
x86_64      buildonly-randconfig-003-20251119    clang-20
x86_64      buildonly-randconfig-004-20251119    clang-20
x86_64      buildonly-randconfig-005-20251119    gcc-14
x86_64      buildonly-randconfig-006-20251119    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251119    clang-20
x86_64                randconfig-002-20251119    clang-20
x86_64                randconfig-003-20251119    gcc-14
x86_64                randconfig-004-20251119    gcc-14
x86_64                randconfig-005-20251119    gcc-14
x86_64                randconfig-006-20251119    clang-20
x86_64                randconfig-011-20251119    clang-20
x86_64                randconfig-012-20251119    clang-20
x86_64                randconfig-013-20251119    clang-20
x86_64                randconfig-014-20251119    gcc-14
x86_64                randconfig-015-20251119    clang-20
x86_64                randconfig-016-20251119    gcc-14
x86_64                randconfig-071-20251119    gcc-14
x86_64                randconfig-073-20251119    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251119    gcc-8.5.0
xtensa                randconfig-002-20251119    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

