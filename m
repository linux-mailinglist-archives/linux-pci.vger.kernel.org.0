Return-Path: <linux-pci+bounces-22573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1CA4836C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3183BB2AF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46626BDBD;
	Thu, 27 Feb 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWZ76uTC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15526D5AE
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671060; cv=none; b=kiSwfKSzwVaZDmx91Hq3WM3w6GxCAr658Vu7XeYX90TPvlcQCFsOucg+PFblbKCHmlz326Q/hKNkjNs48GsQywBECS61mipDOIx+ZSnEt7v5qx0dvTXEpil/6QDZbhJYn+gj1zcQNmZ70mSW6qTo3Y+7+QCIQPOzDKnSEqoeXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671060; c=relaxed/simple;
	bh=10V2qsgxKg5gzwyRV98qHpL+WXAwRTVPKUyf2Lim47I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nFlXjYm0j+BycoeKJ4fqUHiJXRRHHY5Scl/SxjBvpzORbN3vzVOaz+t9256kRf0Vypv0tjW2uz9/3JZ301L+/z47K+498XBGofyfJ8GTf8vHhn9rkUCxcwVPGMy86nmguc98csl5eYk14v3fN9n3eAjszDyjbRBRyUP7g8HpHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWZ76uTC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740671059; x=1772207059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=10V2qsgxKg5gzwyRV98qHpL+WXAwRTVPKUyf2Lim47I=;
  b=mWZ76uTCiBAnuKp3lWLDXXAe1oN8Twa5mXXCxg1SOknh+/Auvw3aMP/x
   KiUHCfIZsbsqnM9t/YMOqwMqWyiMeOM6+0cjHyqLnjJWV1Ynj5UUTCSJy
   fwclfVNLEGzWq9p251FJaS6KRM+gtgsrpcAk3TcxDcLKN8me7Bovqc6aY
   69myF/jzWI5A2gwqteT+lZqBLcUPZKJRLkRyyhf1wLCiKRrWERKxknCSd
   Iz4YzJn81FKcqWq1yOd+TWwqSn916CI5D4n57jC8HCSD3meeZ9cV7z2ip
   jRsF4E22QxzhJEOr5925tNNlMCs1qU5fSK/Y5vIOiH/iZiFTNjEJYTVR0
   g==;
X-CSE-ConnectionGUID: QeufYtSBRxObxcGvCf8YvA==
X-CSE-MsgGUID: bqfyf874QvKv6ObXw9k0dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41486281"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41486281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:44:18 -0800
X-CSE-ConnectionGUID: osC57fLxT6Swb6HoLyrN9A==
X-CSE-MsgGUID: sbqE0RxTTU2O2fsgrHaMUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116933225"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 27 Feb 2025 07:44:17 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tng3a-000Dbi-0m;
	Thu, 27 Feb 2025 15:44:14 +0000
Date: Thu, 27 Feb 2025 23:43:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 1d9e7ac210060044cb4cdbed283d8cbeca50ff8d
Message-ID: <202502272309.VylRE2u6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 1d9e7ac210060044cb4cdbed283d8cbeca50ff8d  dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA interrupt

elapsed time: 1444m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250227    clang-17
arc                   randconfig-001-20250227    gcc-13.2.0
arc                   randconfig-002-20250227    clang-17
arc                   randconfig-002-20250227    gcc-13.2.0
arm                               allnoconfig    gcc-14.2.0
arm                   randconfig-001-20250227    clang-17
arm                   randconfig-001-20250227    gcc-14.2.0
arm                   randconfig-002-20250227    clang-17
arm                   randconfig-003-20250227    clang-17
arm                   randconfig-003-20250227    gcc-14.2.0
arm                   randconfig-004-20250227    clang-17
arm                   randconfig-004-20250227    clang-21
arm                         socfpga_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250227    clang-17
arm64                 randconfig-001-20250227    gcc-14.2.0
arm64                 randconfig-002-20250227    clang-17
arm64                 randconfig-002-20250227    clang-19
arm64                 randconfig-003-20250227    clang-17
arm64                 randconfig-003-20250227    gcc-14.2.0
arm64                 randconfig-004-20250227    clang-17
arm64                 randconfig-004-20250227    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250227    gcc-14.2.0
csky                  randconfig-002-20250227    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250227    clang-14
hexagon               randconfig-001-20250227    gcc-14.2.0
hexagon               randconfig-002-20250227    clang-16
hexagon               randconfig-002-20250227    gcc-14.2.0
i386        buildonly-randconfig-001-20250227    gcc-12
i386        buildonly-randconfig-002-20250227    gcc-11
i386        buildonly-randconfig-002-20250227    gcc-12
i386        buildonly-randconfig-003-20250227    clang-19
i386        buildonly-randconfig-003-20250227    gcc-12
i386        buildonly-randconfig-004-20250227    gcc-12
i386        buildonly-randconfig-005-20250227    gcc-11
i386        buildonly-randconfig-005-20250227    gcc-12
i386        buildonly-randconfig-006-20250227    clang-19
i386        buildonly-randconfig-006-20250227    gcc-12
i386                  randconfig-001-20250227    clang-19
i386                  randconfig-002-20250227    clang-19
i386                  randconfig-003-20250227    clang-19
i386                  randconfig-004-20250227    clang-19
i386                  randconfig-005-20250227    clang-19
i386                  randconfig-006-20250227    clang-19
i386                  randconfig-007-20250227    clang-19
i386                  randconfig-011-20250227    gcc-12
i386                  randconfig-012-20250227    gcc-12
i386                  randconfig-013-20250227    gcc-12
i386                  randconfig-014-20250227    gcc-12
i386                  randconfig-015-20250227    gcc-12
i386                  randconfig-016-20250227    gcc-12
i386                  randconfig-017-20250227    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250227    gcc-14.2.0
loongarch             randconfig-002-20250227    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250227    gcc-14.2.0
nios2                 randconfig-002-20250227    gcc-14.2.0
openrisc                          allnoconfig    clang-15
parisc                            allnoconfig    clang-15
parisc                randconfig-001-20250227    gcc-14.2.0
parisc                randconfig-002-20250227    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc               randconfig-001-20250227    clang-19
powerpc               randconfig-001-20250227    gcc-14.2.0
powerpc               randconfig-002-20250227    gcc-14.2.0
powerpc               randconfig-003-20250227    clang-19
powerpc               randconfig-003-20250227    gcc-14.2.0
powerpc64             randconfig-001-20250227    clang-17
powerpc64             randconfig-001-20250227    gcc-14.2.0
powerpc64             randconfig-002-20250227    clang-21
powerpc64             randconfig-002-20250227    gcc-14.2.0
powerpc64             randconfig-003-20250227    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                 randconfig-001-20250227    gcc-14.2.0
riscv                 randconfig-002-20250227    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250227    clang-18
s390                  randconfig-001-20250227    gcc-14.2.0
s390                  randconfig-002-20250227    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250227    gcc-14.2.0
sh                    randconfig-002-20250227    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250227    gcc-14.2.0
sparc                 randconfig-002-20250227    gcc-14.2.0
sparc64               randconfig-001-20250227    gcc-14.2.0
sparc64               randconfig-002-20250227    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                    randconfig-001-20250227    clang-17
um                    randconfig-001-20250227    gcc-14.2.0
um                    randconfig-002-20250227    gcc-12
um                    randconfig-002-20250227    gcc-14.2.0
x86_64      buildonly-randconfig-001-20250227    clang-19
x86_64      buildonly-randconfig-002-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    gcc-12
x86_64      buildonly-randconfig-004-20250227    clang-19
x86_64      buildonly-randconfig-004-20250227    gcc-12
x86_64      buildonly-randconfig-005-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    gcc-12
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250227    gcc-12
x86_64                randconfig-002-20250227    gcc-12
x86_64                randconfig-003-20250227    gcc-12
x86_64                randconfig-004-20250227    gcc-12
x86_64                randconfig-005-20250227    gcc-12
x86_64                randconfig-006-20250227    gcc-12
x86_64                randconfig-007-20250227    gcc-12
x86_64                randconfig-008-20250227    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250227    gcc-14.2.0
xtensa                randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

