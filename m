Return-Path: <linux-pci+bounces-41324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE9FC61673
	for <lists+linux-pci@lfdr.de>; Sun, 16 Nov 2025 15:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE163B27A5
	for <lists+linux-pci@lfdr.de>; Sun, 16 Nov 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B11015539A;
	Sun, 16 Nov 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vem+g9mP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55DB1DA23
	for <linux-pci@vger.kernel.org>; Sun, 16 Nov 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763301908; cv=none; b=DdvQUG44lFapzPjbUJqFqS/TXx7Tohw2GnWQpwLTajSOO/RAUpnGZpfBVjF+Kgu3FcyyJJL6T259tCCkavOCo9jRREGnE5s+/m4P/l5/JQLZCYvDAlscsX41b2v6xsXuR82dZ8qQEh56Aqm7HCSTNA+2DzxtgzL5bv66ix/wYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763301908; c=relaxed/simple;
	bh=gYoXTu2yEwzX7LFEk7hPHATUOtP3YHCcAm1H5kBeOCs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T1g9n98XmSj9WxxaCYsdJqMq5s3JTXI1K8oIYCowblnxAyCrqzIB+ECv3M/+XRVVWWACO9UV/2Lw9J7oZl8M5CzdIKW9EOaYpku/D2lhkS7GFzNyCE7F04HNUHfBRhacU0SnSnhQ3+xWZPzkux4sX5Us6ba7z7agCvE9nsq7o8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vem+g9mP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763301907; x=1794837907;
  h=date:from:to:cc:subject:message-id;
  bh=gYoXTu2yEwzX7LFEk7hPHATUOtP3YHCcAm1H5kBeOCs=;
  b=Vem+g9mPLqzkzvz566dn+HPbvlSakD9o8BQgCa4tiWYi2PZhiZJ/9x/G
   w+1AIKhXVUH5zck/uqlHuTcRIRgre7zbFGlu8x1Utc9gW3hwUexENIipw
   UYkD/Fg3EGNk4BUtAAqOWaggkNIyV3Wqw16JQa77RU9VFzK/TaGvpHwuY
   ZYyzFBLS/tskZW04vuNHWlP6Z6ewv+5ME5BanJ0hRGDIwzRjn7eh35caU
   lGUype/qxu0wCwD8ucZvz4DpdcJZrOHk/uIw8gRwjpRLtSk2nLx0t9zDv
   oyYZVyKl/2JEHRszAgALkdnUNxi3ccztgd4nXCG5RpHqDzULatze14ghq
   A==;
X-CSE-ConnectionGUID: J3sSlF2jRAufnkbp+zPY+Q==
X-CSE-MsgGUID: dJRvX6bsSXOTUcIV+tCU5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="67926565"
X-IronPort-AV: E=Sophos;i="6.19,309,1754982000"; 
   d="scan'208";a="67926565"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 06:05:04 -0800
X-CSE-ConnectionGUID: DtH2XFqPQZG+J8CGKkOnlg==
X-CSE-MsgGUID: xwPXG3ZSTziPEyHJXyqRVg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Nov 2025 06:05:03 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKdNF-0008oh-0T;
	Sun, 16 Nov 2025 14:05:01 +0000
Date: Sun, 16 Nov 2025 22:04:52 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 479e9f2c479909e02852852d787602a3ee1d2667
Message-ID: <202511162246.e9UaKimn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 479e9f2c479909e02852852d787602a3ee1d2667  Merge branch 'pci/controller/sg2042'

elapsed time: 2184m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251115    gcc-13.4.0
arc                   randconfig-002-20251115    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251115    clang-22
arm                   randconfig-002-20251115    gcc-8.5.0
arm                   randconfig-003-20251115    gcc-10.5.0
arm                   randconfig-004-20251115    clang-22
arm                           sama7_defconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251116    gcc-12.5.0
arm64                 randconfig-002-20251116    gcc-10.5.0
arm64                 randconfig-003-20251116    clang-22
arm64                 randconfig-004-20251116    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251116    gcc-12.5.0
csky                  randconfig-002-20251116    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251116    clang-22
hexagon               randconfig-002-20251116    clang-17
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251116    clang-20
i386        buildonly-randconfig-002-20251116    clang-20
i386        buildonly-randconfig-003-20251116    clang-20
i386        buildonly-randconfig-004-20251116    gcc-14
i386        buildonly-randconfig-005-20251116    clang-20
i386                  randconfig-001-20251116    gcc-14
i386                  randconfig-002-20251116    clang-20
i386                  randconfig-003-20251116    gcc-14
i386                  randconfig-004-20251116    gcc-14
i386                  randconfig-005-20251116    clang-20
i386                  randconfig-006-20251116    clang-20
i386                  randconfig-007-20251116    clang-20
i386                  randconfig-011-20251116    clang-20
i386                  randconfig-012-20251116    gcc-14
i386                  randconfig-013-20251116    gcc-14
i386                  randconfig-014-20251116    clang-20
i386                  randconfig-015-20251116    gcc-12
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251116    gcc-15.1.0
loongarch             randconfig-002-20251116    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251116    gcc-11.5.0
nios2                 randconfig-002-20251116    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251116    gcc-12.5.0
parisc                randconfig-002-20251116    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20251116    gcc-10.5.0
powerpc               randconfig-002-20251116    clang-22
powerpc64             randconfig-001-20251116    clang-22
powerpc64             randconfig-002-20251116    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251116    clang-20
riscv                 randconfig-002-20251116    gcc-10.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251116    clang-22
s390                  randconfig-002-20251116    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251116    gcc-13.4.0
sh                    randconfig-002-20251116    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251116    gcc-8.5.0
sparc                 randconfig-002-20251116    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251116    gcc-15.1.0
sparc64               randconfig-002-20251116    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251116    clang-17
um                    randconfig-002-20251116    gcc-13
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251116    clang-20
x86_64      buildonly-randconfig-002-20251116    clang-20
x86_64      buildonly-randconfig-003-20251116    clang-20
x86_64      buildonly-randconfig-004-20251116    gcc-13
x86_64      buildonly-randconfig-005-20251116    clang-20
x86_64      buildonly-randconfig-006-20251116    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251116    gcc-14
x86_64                randconfig-002-20251116    gcc-14
x86_64                randconfig-003-20251116    clang-20
x86_64                randconfig-004-20251116    clang-20
x86_64                randconfig-005-20251116    gcc-12
x86_64                randconfig-006-20251116    clang-20
x86_64                randconfig-012-20251116    clang-20
x86_64                randconfig-013-20251116    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251116    gcc-8.5.0
xtensa                randconfig-002-20251116    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

