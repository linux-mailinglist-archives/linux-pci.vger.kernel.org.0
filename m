Return-Path: <linux-pci+bounces-32573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF6BB0ABC8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 23:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6529C1881D57
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98D220F38;
	Fri, 18 Jul 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAFcyvKR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C421FF4E
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875943; cv=none; b=KlgNUfMLRHcjoW3a2zUNvXYA+cJBL/nx792lt27iyoBEn8RsOfbLa+4H8BUgWgaoof3p1M6B9WnYOvE4FplQvTzxAJxE7+DopLb3uJmcY8C2GSu/zvFDzRknDi7BXozFpA/1bqahHI+g+KVCcsyY3/towTRtaO85vq19uXSUkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875943; c=relaxed/simple;
	bh=LUOMg3ea/cI/ptU+IsoWmoNjZvBcJOpFKQmaunTk3rE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZrrQoVVt+MOG9amRLqQoOVj+eRzj0DL5iLcuN9uwSkJXhyF2r/PMrQN0tNAZPldUeL0FW0shwm5/zfMDTcQjKEXm2Ve3Q7GrozFj0xOQjCmBFD3h5qGE4Oi7B5HUpsSIQ6ydbxw+X4GOkYcNv+4Ms8wQ7pZbXEc8VqeLUd9ejIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAFcyvKR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752875943; x=1784411943;
  h=date:from:to:cc:subject:message-id;
  bh=LUOMg3ea/cI/ptU+IsoWmoNjZvBcJOpFKQmaunTk3rE=;
  b=TAFcyvKRPoyoGEPey0YLZDp6nNmWpj1AA/EXLnabk8Mq0GMTEqc2aTTt
   weWcXfnvyufi5A9O4b5toft0vT6MAicwcGmMiOiN3ImDypvrpWPJ871tC
   3Mwe4y0TYcTdla+ZAM8juXHPnQPZyr/lVMMeH8Oui8incqXfT7vW7fby3
   1TsITD7PDR8R8pTqgwFCbRrtkdw4isSc72W26JCrmLcgUgDfSwirqUw01
   FrTAkTODtOPASQrbbyBr2FqaACaT7rpmkuNCOAdcSf1Quilz1PRk+m2Lk
   0mV17Mo9hwhl6TeDMAuRI1Owz/ctgI0YhLu0C/1D82xNCXUBmobs/rxOZ
   A==;
X-CSE-ConnectionGUID: 4dr5Gvd9SGihKH78bExcyg==
X-CSE-MsgGUID: +BtqaiBbQFClS+izvtB03w==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="66622881"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="66622881"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 14:59:02 -0700
X-CSE-ConnectionGUID: 3zDY81ZoQaeFhcNnpOZ7WA==
X-CSE-MsgGUID: u/FaVrNqSy6n5qm2kP7pTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="158059909"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jul 2025 14:59:01 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uct6Y-000F4l-0K;
	Fri, 18 Jul 2025 21:58:58 +0000
Date: Sat, 19 Jul 2025 05:58:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 a6b18cb880f1e01e496b0577e52612fdf49ea4ea
Message-ID: <202507190520.GTtX5DrY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: a6b18cb880f1e01e496b0577e52612fdf49ea4ea  Merge branch 'pci/misc'

elapsed time: 1453m

configs tested: 106
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm                        spear6xx_defconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-002-20250718    clang-21
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-21
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.3.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-003-20250718    clang-17
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-002-20250718    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-002-20250718    clang-16
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-002-20250718    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-002-20250718    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-002-20250718    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-002-20250718    gcc-12
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-8.5.0
xtensa                randconfig-002-20250718    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

