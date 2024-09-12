Return-Path: <linux-pci+bounces-13136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083859773F3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 23:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5F31C23DA3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022E81C174C;
	Thu, 12 Sep 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAO9o4qk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88C481C0
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178305; cv=none; b=jaU7Tu4r+mEWo/mgBVm/NL/LjH6R1HpIjlVeeEXXFZskrl9pVpv+7Vcx+nW14qB4Nn9MnJvB8jJP7tKXMfEGX6UrGCFzYpilp322SfbIahelwHmZHMx1IspToo7qkGWc8rA45ytMLi9CMSBPT7xTE1SbXxp1maoZOJuwWrjeics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178305; c=relaxed/simple;
	bh=tfdSk6J8NDuxLgSDEUEj50EHxku8uA97Ms1CbnXpxow=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kilSvhhPZAPuaTTZzASJMOmd+cH+wdRBqbgqxXIt7dhr/2nW7Zb8buFQmN8rSLKyz/LDLpJUiK/F0ii5VxV5/J1lJimAy0lgBnivyG8704bpBMi9Gw+V6xqeZ4oxAZ2d99j/rMwRtzNMmbQBZN55wOvsa9f71pfJQdTaVKhJ7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAO9o4qk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726178304; x=1757714304;
  h=date:from:to:cc:subject:message-id;
  bh=tfdSk6J8NDuxLgSDEUEj50EHxku8uA97Ms1CbnXpxow=;
  b=NAO9o4qkBed+tm+ypSuKKtp6eupFH74ZHKllsbMsr/4WqdFdGI0KvU+g
   2XrUB4+xNxRZleGvmD49mO3ouWSIMGbjZ7PbqMSK2A2HJJzseVKOpy+sH
   3RApkUrK2MDBjtOW4EJiGvyDDMCKnVarTIKoBhfkrz2zgpPN7NtzMkeuP
   FK+OYeZ32Q3sxGFVbS8kENpbMl7L/o3abmx2yj+5+fz0H19MpWomlcCqs
   xRBFkONiiTyHymTHdLx91PDyGDI24PyGKdYC/sduL/4V3Uzp0ZYVwQeSM
   11WhSM5C7oQK0IlKogslyPJIJYyb617Zw3t7fbcASB/Zn23G3KUqgq1Wv
   g==;
X-CSE-ConnectionGUID: C3XBV/lGQG2vZu4t8VYV4g==
X-CSE-MsgGUID: mmfzV92pTim8QJPESopjaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36411068"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="36411068"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 14:58:23 -0700
X-CSE-ConnectionGUID: D3IUow/8Sf+zozCWsy6mbg==
X-CSE-MsgGUID: 5zDIis+9T3OX/IecxHxr4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="67780979"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 Sep 2024 14:58:23 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sorpU-0005kY-0C;
	Thu, 12 Sep 2024 21:58:20 +0000
Date: Fri, 13 Sep 2024 05:57:32 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 c2699778e6be4757ee0b16449ab8777c6b46e6d0
Message-ID: <202409130525.9YxniaBe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: c2699778e6be4757ee0b16449ab8777c6b46e6d0  PCI: imx6: Add i.MX8Q PCIe Root Complex (RC) support

elapsed time: 1880m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20240913    gcc-13.2.0
arc                   randconfig-002-20240913    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                       omap2plus_defconfig    gcc-14.1.0
arm                   randconfig-001-20240913    gcc-14.1.0
arm                   randconfig-002-20240913    gcc-14.1.0
arm                   randconfig-003-20240913    gcc-14.1.0
arm                   randconfig-004-20240913    clang-20
arm                        spear6xx_defconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240913    clang-15
arm64                 randconfig-002-20240913    clang-20
arm64                 randconfig-003-20240913    gcc-14.1.0
arm64                 randconfig-004-20240913    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240913    gcc-14.1.0
csky                  randconfig-002-20240913    gcc-14.1.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20240913    clang-20
hexagon               randconfig-002-20240913    clang-20
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240912    gcc-12
i386        buildonly-randconfig-002-20240912    gcc-11
i386        buildonly-randconfig-003-20240912    gcc-12
i386        buildonly-randconfig-004-20240912    clang-18
i386        buildonly-randconfig-005-20240912    gcc-12
i386        buildonly-randconfig-006-20240912    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240912    gcc-12
i386                  randconfig-002-20240912    gcc-12
i386                  randconfig-003-20240912    gcc-11
i386                  randconfig-004-20240912    gcc-12
i386                  randconfig-005-20240912    clang-18
i386                  randconfig-006-20240912    clang-18
i386                  randconfig-011-20240912    clang-18
i386                  randconfig-012-20240912    gcc-12
i386                  randconfig-013-20240912    gcc-12
i386                  randconfig-014-20240912    gcc-12
i386                  randconfig-015-20240912    clang-18
i386                  randconfig-016-20240912    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    gcc-14.1.0
loongarch             randconfig-001-20240913    gcc-14.1.0
loongarch             randconfig-002-20240913    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    clang-20
mips                           ip28_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240913    gcc-14.1.0
nios2                 randconfig-002-20240913    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240913    gcc-14.1.0
parisc                randconfig-002-20240913    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                       holly_defconfig    clang-20
powerpc                      pmac32_defconfig    clang-20
powerpc               randconfig-001-20240913    clang-17
powerpc                    sam440ep_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20240913    clang-20
powerpc64             randconfig-002-20240913    clang-20
powerpc64             randconfig-003-20240913    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20240913    gcc-14.1.0
riscv                 randconfig-002-20240913    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

