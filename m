Return-Path: <linux-pci+bounces-32969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B5B12C1B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 21:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EFA17C684
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897151CEAA3;
	Sat, 26 Jul 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsVv8hTp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A77080D
	for <linux-pci@vger.kernel.org>; Sat, 26 Jul 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753559667; cv=none; b=ZrkrathwHisl8gk3kxuw72xiFIGLn9ckQONAZmlFdkQehxrVnD8caigGxcbar7MMb9nYOUCzvDH0lU6D3VdIvSNv7Izx7EfqKF53HTvBxFPm0Fz7vIN/7iDukM7UZx3VZuY6C0urAEU3OwSy5IIR783YZB3NSxMTSg2LxvK8mfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753559667; c=relaxed/simple;
	bh=iURJEWHLC7JYRU7/RicHoUgDEKqrMbu/4W3Pyt0zdmg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MAYKZ5EJv/gjve36hZNqg64NF/iM6plgTH1qkkNzBGNa1PrDi+5HDD87ZmVUv5NH88jr1npSGo7meVNUeP4V5X1lpjvmTfP8V76sdNwZZ8r1thg2jucmVB8rUb7EqeobzMsuMg0PgE7gwfU2pUMKMVLDm8ERABkJ5fsabzI0ORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsVv8hTp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753559665; x=1785095665;
  h=date:from:to:cc:subject:message-id;
  bh=iURJEWHLC7JYRU7/RicHoUgDEKqrMbu/4W3Pyt0zdmg=;
  b=EsVv8hTpF9/HiB098ZI68xB6Ce1PRhSbOT32J9z9WlYqICKZIi5aOSgQ
   K8Uk/uSN4gniH7JYzqS2mBBRe8TAp+/xHJ+kB88opP7WbzD4nbrFUpeWu
   M6EoYuRmjfKhFjxo4v5zPc605aDAQZI1TrMl5AhKGuRRO8l5Jnb16ShMk
   0kEE2TxXmpsPpnJxFYb3cSxJ4WVENvmk5TiSI+/WXl+ceDmOmPXsDR3I6
   sv4Yg4bq5msvAdum0TPk4iX0aE8J260V0/t10oZN1XAp7/FP0VjGiClN0
   pPOakp67WnOHqbfLZd/8upg46iGAKpwtkaShN836bDD+uzl3MhepTmGXq
   g==;
X-CSE-ConnectionGUID: dfJF6fc+QzKvTsbPi2qMJg==
X-CSE-MsgGUID: RyOdlypPS96A6fiYbCMXvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55742412"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55742412"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 12:54:19 -0700
X-CSE-ConnectionGUID: qgDUTBrrRcGUusihlBI9bQ==
X-CSE-MsgGUID: xaS0hJTWSu6yo6akatThfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162026551"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jul 2025 12:54:19 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufkyG-000MEt-1Y;
	Sat, 26 Jul 2025 19:54:16 +0000
Date: Sun, 27 Jul 2025 03:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 347599ee2a61dd9e220aa151df9d07431e189bd2
Message-ID: <202507270312.kLXY3vjD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 347599ee2a61dd9e220aa151df9d07431e189bd2  PCI: Move is_pciehp check out of pciehp_is_native()

elapsed time: 1442m

configs tested: 186
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250726    gcc-14.3.0
arc                   randconfig-002-20250726    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20250726    gcc-8.5.0
arm                   randconfig-002-20250726    gcc-10.5.0
arm                   randconfig-003-20250726    gcc-10.5.0
arm                   randconfig-004-20250726    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250726    gcc-8.5.0
arm64                 randconfig-002-20250726    clang-22
arm64                 randconfig-003-20250726    gcc-12.5.0
arm64                 randconfig-004-20250726    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250726    gcc-15.1.0
csky                  randconfig-001-20250727    gcc-11.5.0
csky                  randconfig-002-20250726    gcc-15.1.0
csky                  randconfig-002-20250727    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250726    clang-22
hexagon               randconfig-001-20250727    gcc-11.5.0
hexagon               randconfig-002-20250726    clang-20
hexagon               randconfig-002-20250727    gcc-11.5.0
i386                             alldefconfig    gcc-12
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250726    gcc-12
i386        buildonly-randconfig-002-20250726    gcc-12
i386        buildonly-randconfig-003-20250726    clang-20
i386        buildonly-randconfig-004-20250726    gcc-12
i386        buildonly-randconfig-005-20250726    clang-20
i386        buildonly-randconfig-006-20250726    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-011-20250727    clang-20
i386                  randconfig-012-20250727    clang-20
i386                  randconfig-013-20250727    clang-20
i386                  randconfig-014-20250727    clang-20
i386                  randconfig-015-20250727    clang-20
i386                  randconfig-016-20250727    clang-20
i386                  randconfig-017-20250727    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250726    gcc-15.1.0
loongarch             randconfig-001-20250727    gcc-11.5.0
loongarch             randconfig-002-20250726    gcc-14.3.0
loongarch             randconfig-002-20250727    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250726    gcc-8.5.0
nios2                 randconfig-001-20250727    gcc-11.5.0
nios2                 randconfig-002-20250726    gcc-8.5.0
nios2                 randconfig-002-20250727    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250726    gcc-8.5.0
parisc                randconfig-001-20250727    gcc-11.5.0
parisc                randconfig-002-20250726    gcc-8.5.0
parisc                randconfig-002-20250727    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250726    clang-16
powerpc               randconfig-001-20250727    gcc-11.5.0
powerpc               randconfig-002-20250726    gcc-11.5.0
powerpc               randconfig-002-20250727    gcc-11.5.0
powerpc               randconfig-003-20250726    gcc-8.5.0
powerpc               randconfig-003-20250727    gcc-11.5.0
powerpc64             randconfig-001-20250726    clang-22
powerpc64             randconfig-001-20250727    gcc-11.5.0
powerpc64             randconfig-002-20250726    gcc-10.5.0
powerpc64             randconfig-002-20250727    gcc-11.5.0
powerpc64             randconfig-003-20250726    clang-22
powerpc64             randconfig-003-20250727    gcc-11.5.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250726    gcc-11.5.0
riscv                 randconfig-002-20250726    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250726    clang-22
s390                  randconfig-002-20250726    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250726    gcc-12.5.0
sh                    randconfig-002-20250726    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250726    gcc-8.5.0
sparc                 randconfig-002-20250726    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250726    clang-22
sparc64               randconfig-002-20250726    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250726    gcc-12
um                    randconfig-002-20250726    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250726    gcc-12
x86_64      buildonly-randconfig-002-20250726    gcc-12
x86_64      buildonly-randconfig-003-20250726    gcc-12
x86_64      buildonly-randconfig-004-20250726    clang-20
x86_64      buildonly-randconfig-005-20250726    clang-20
x86_64      buildonly-randconfig-006-20250726    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250726    clang-20
x86_64                randconfig-002-20250726    clang-20
x86_64                randconfig-003-20250726    clang-20
x86_64                randconfig-004-20250726    clang-20
x86_64                randconfig-005-20250726    clang-20
x86_64                randconfig-006-20250726    clang-20
x86_64                randconfig-007-20250726    clang-20
x86_64                randconfig-008-20250726    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250726    gcc-8.5.0
xtensa                randconfig-002-20250726    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

