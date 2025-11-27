Return-Path: <linux-pci+bounces-42176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA34C8C6F1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 01:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04CAE35005E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC0D21E091;
	Thu, 27 Nov 2025 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L144wKNq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D61E9B0B
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764203974; cv=none; b=WO+ASpl7YFuoSPM/tr3JgBjJoPNBiK4B8uALZlWrVBkyoScJ9n4jsqbUWN18vka8dmxC5KXcHQKcf02bUn0C8Bwfthlr1rJyg+ipzYslazDIJm8+2SvFsD0eNnqfPj5VUR4SaEQiFq69N8IfhMdOnzkcloBx76C9Tnh95qx36UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764203974; c=relaxed/simple;
	bh=QFgkZmK061LT0SfE6dtkVP7bWuVD5Fg3FYf5yCt3Jqk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XNTft6lgsKeNVzevpQkZX09dhv8/kD713BwS04NIMutBKbAVOyCPDRcPU7SC4tHfUs057exhRZ4CaengHjUrUnTjMRDdkSUx36H8znUlFICfBS1McjbmHOLTbspZiNXQzXQGeFHqnls0j9Q0B8huU795ZJZt85ELfcOyRaTUAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L144wKNq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764203972; x=1795739972;
  h=date:from:to:cc:subject:message-id;
  bh=QFgkZmK061LT0SfE6dtkVP7bWuVD5Fg3FYf5yCt3Jqk=;
  b=L144wKNqrHiT6jXtSSxAgerZb6ZDcklLUJJ0BiuV2aw0bxcEgt9bz4Vj
   RIhw95OwHjyuL0pUNbp+bfQbRIuQXDTxn9rKEkBTWlFbOuxLxGI40dcxA
   VT3N8zlyvNdbwPTiAPdkU1Z34kljzoMqaPZVjdEbA4ZvvNXjuRZhwWycl
   WmLohRKgHj6eFnrQ2EXL+9C4LyPXbQKKSqQv7S6F2Zv+7Ygz7kwKZi/9h
   tVq+Jnx8EKLqZl1sibuen2pp6y3t1uHwiymABPUjwcsrg81pQfmjEzV47
   dZWZLRs3R5JxxWxMbMiayKAKEa+7HxvtrNlSdTKFCYROPzqngy0+szE2t
   g==;
X-CSE-ConnectionGUID: qoZ4k7kYSfi1pHgQFsAhkg==
X-CSE-MsgGUID: jXPBuTCDT6+LDA7I48d1HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66324117"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="66324117"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 16:39:32 -0800
X-CSE-ConnectionGUID: Q+gqkMD5S5ulnouDIYARFw==
X-CSE-MsgGUID: 8Gw67Uz1Svmh/HCS8/09lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="224043758"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2025 16:39:31 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOQ2i-000000003Vn-4A4e;
	Thu, 27 Nov 2025 00:39:28 +0000
Date: Thu, 27 Nov 2025 08:39:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 e8c5d2fd85975099d6db1336319d3a2f04018d47
Message-ID: <202511270811.uFXq6UWC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: e8c5d2fd85975099d6db1336319d3a2f04018d47  Merge branch 'pci/misc'

elapsed time: 1504m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251126    gcc-13.4.0
arc                   randconfig-002-20251126    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251126    clang-22
arm                   randconfig-002-20251126    clang-22
arm                   randconfig-003-20251126    clang-19
arm                   randconfig-004-20251126    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251127    gcc-8.5.0
arm64                 randconfig-002-20251127    clang-22
arm64                 randconfig-003-20251127    gcc-9.5.0
arm64                 randconfig-004-20251127    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251127    gcc-15.1.0
csky                  randconfig-002-20251127    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251126    clang-22
hexagon               randconfig-002-20251126    clang-22
i386                              allnoconfig    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251127    gcc-14
i386                  randconfig-002-20251127    gcc-14
i386                  randconfig-003-20251127    clang-20
i386                  randconfig-004-20251127    gcc-12
i386                  randconfig-005-20251127    clang-20
i386                  randconfig-006-20251127    clang-20
i386                  randconfig-007-20251127    clang-20
i386                  randconfig-011-20251127    gcc-13
i386                  randconfig-012-20251127    gcc-14
i386                  randconfig-013-20251127    clang-20
i386                  randconfig-014-20251127    clang-20
i386                  randconfig-015-20251127    gcc-14
i386                  randconfig-016-20251127    clang-20
i386                  randconfig-017-20251127    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251126    gcc-15.1.0
loongarch             randconfig-002-20251126    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251126    gcc-11.5.0
nios2                 randconfig-002-20251126    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251126    gcc-8.5.0
parisc                randconfig-002-20251126    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-19
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251126    gcc-10.5.0
powerpc               randconfig-002-20251126    gcc-8.5.0
powerpc64             randconfig-001-20251126    clang-19
powerpc64             randconfig-002-20251126    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251126    gcc-10.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251126    gcc-8.5.0
s390                  randconfig-002-20251126    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251126    gcc-14.3.0
sh                    randconfig-002-20251126    gcc-11.5.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251126    gcc-8.5.0
sparc                 randconfig-002-20251126    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251126    gcc-8.5.0
sparc64               randconfig-002-20251126    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-002-20251126    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251126    clang-20
x86_64      buildonly-randconfig-002-20251126    gcc-14
x86_64      buildonly-randconfig-003-20251126    clang-20
x86_64      buildonly-randconfig-004-20251126    clang-20
x86_64      buildonly-randconfig-005-20251126    gcc-14
x86_64      buildonly-randconfig-006-20251126    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251127    gcc-12
x86_64                randconfig-072-20251127    gcc-14
x86_64                randconfig-073-20251127    clang-20
x86_64                randconfig-074-20251127    gcc-14
x86_64                randconfig-075-20251127    gcc-14
x86_64                randconfig-076-20251127    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251126    gcc-14.3.0
xtensa                randconfig-002-20251126    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

