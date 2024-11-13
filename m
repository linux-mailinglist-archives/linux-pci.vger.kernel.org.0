Return-Path: <linux-pci+bounces-16679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA19C78F0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E5E283AA3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8B1494DA;
	Wed, 13 Nov 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhDw/oDX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522F14F9E9
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515522; cv=none; b=S4Jw9hqNgBBuk2krX9Y00MJQymKVwvegyOw0Caha4PYyfOIak/lkemz6XN+tt0HdHSAb2ZcbMgirSW6O1SKHFUtWnzTKJAP9O8Syspl/aj+YIBUKfllctZLpMZh1n/2FHA1MKcjC7s8BzKrkr0kjDh31QUgBDnj/JPN98csp9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515522; c=relaxed/simple;
	bh=0X2rYJnN6ReqnS/NozvcFmRBD2VFjDXZbEz+dRq0ci0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AuviFwm+IIt1vyLVx6ZjGlIOoXcXXes/NeJrV/+bgr5KM+lhHajh1FCOXAFxP2Q2MDs7xl3egWBqtOVMrKdCn/ClCDWg/qopC5ejipWBcR4zFGWL+vtEeYN7D13lPyYAFs9ahuwto1GsBn1RBjTiRJOWbyBZvaBXYdkACvhobbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhDw/oDX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731515519; x=1763051519;
  h=date:from:to:cc:subject:message-id;
  bh=0X2rYJnN6ReqnS/NozvcFmRBD2VFjDXZbEz+dRq0ci0=;
  b=nhDw/oDXSK4sp27JMLP6r2PqoAQYdBTM36UKrTJceZD5kDZlB9pJhpVw
   Tf9WtyGJ1P3iop6Ue9AVd7q0HHeuAxmUt+XB9uZrfbcJHhlWZN+QleQWe
   XIy1L2bnuANqVch+sBIWRsQCO9Ndori+IoNyHZ3RC60Og9OGLN83HGw2O
   lLMMNKNnoCIYcHS4gq6KFNxwWA/Q3tzgdm6ujRR49Sn2ZE3UTYr3A0ICL
   Al2HZ5l8UQqkV8GtkVHyddEN3KzubXnLK+RpVW1QXVQfWluG0J94P/uoA
   2fIVpsX8I78vlD7W8KL5yK0JPToYZwADXydPnHiF96OjjIUxNjLH+Q+WW
   A==;
X-CSE-ConnectionGUID: wuECaPtnQBOnkEA9yflfUg==
X-CSE-MsgGUID: k4zM8GSRQLODdY9E4r9I0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="19024881"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="19024881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 08:31:58 -0800
X-CSE-ConnectionGUID: GIYlKWjdQd2MjfnqaNom+A==
X-CSE-MsgGUID: CSjqtiH/TOej59QiblwuuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92988419"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Nov 2024 08:31:57 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBGHa-0000Y9-2c;
	Wed, 13 Nov 2024 16:31:54 +0000
Date: Thu, 14 Nov 2024 00:31:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 0c33dd680dbbe6ec87c355422c1793a0a138dbe4
Message-ID: <202411140023.tREGd5w0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 0c33dd680dbbe6ec87c355422c1793a0a138dbe4  PCI: Enable runtime PM of the host bridge

elapsed time: 972m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241113    gcc-13.2.0
arc                   randconfig-002-20241113    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20241113    clang-20
arm                   randconfig-002-20241113    clang-20
arm                   randconfig-003-20241113    clang-20
arm                   randconfig-004-20241113    clang-20
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241113    clang-20
arm64                 randconfig-002-20241113    gcc-14.2.0
arm64                 randconfig-003-20241113    gcc-14.2.0
arm64                 randconfig-004-20241113    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241113    gcc-14.2.0
csky                  randconfig-002-20241113    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-002-20241113    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    gcc-12
i386        buildonly-randconfig-005-20241113    gcc-12
i386        buildonly-randconfig-006-20241113    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    gcc-12
i386                  randconfig-002-20241113    gcc-12
i386                  randconfig-005-20241113    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241113    gcc-14.2.0
loongarch             randconfig-002-20241113    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241113    gcc-14.2.0
nios2                 randconfig-002-20241113    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241113    gcc-14.2.0
parisc                randconfig-002-20241113    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                       maple_defconfig    clang-20
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241113    clang-20
powerpc               randconfig-002-20241113    clang-20
powerpc               randconfig-003-20241113    clang-15
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241113    gcc-14.2.0
powerpc64             randconfig-002-20241113    clang-20
powerpc64             randconfig-003-20241113    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241113    gcc-14.2.0
riscv                 randconfig-002-20241113    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241113    gcc-14.2.0
s390                  randconfig-002-20241113    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                    randconfig-001-20241113    gcc-14.2.0
sh                    randconfig-002-20241113    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241113    gcc-14.2.0
sparc64               randconfig-002-20241113    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241113    gcc-12
um                    randconfig-002-20241113    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241113    gcc-14.2.0
xtensa                randconfig-002-20241113    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

