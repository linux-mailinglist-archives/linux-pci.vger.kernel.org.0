Return-Path: <linux-pci+bounces-10087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0441A92D61C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DD41F2784E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8F1953BE;
	Wed, 10 Jul 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNzWGHHu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E91194AFD
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628167; cv=none; b=Da3AWVQqYVN6N8mrg2mULy1oLfc1LsXhnF3CW7ACw2NZSnz7zY5GKs/Qt9Ouh/DhdCxoHe3rNvW/KKTh2pTS/cqkVekJ3RkYbwn729wahgT2lIw4anem9GhSjX/DDkzos9g3/kw9rnin5YS51HGlACJlgrDvyOo9a9RVb28hhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628167; c=relaxed/simple;
	bh=hZqbZfwCclTd/aHR0vIa+uEdRhvhSFOVSxgi0Mt8ObY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BIni9rhOYXB2XpXXEO77dE1rtVmAHyIdGvYQcEOTTskO67zM6tuQWHkCI1DCkMi+l6Q1qnSMNiW8XvvMbTuQ0FgvQ3XYiqaQOVsziOQvWePK6dolFB1Qij2XvaTeyS0JeTChLNCwJumRp4NXrjvEiA5abtW8Qve4oqxJ5cpOIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNzWGHHu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720628166; x=1752164166;
  h=date:from:to:cc:subject:message-id;
  bh=hZqbZfwCclTd/aHR0vIa+uEdRhvhSFOVSxgi0Mt8ObY=;
  b=FNzWGHHu2L2VfOlxExpdhf8cMjswbyJasjRTgjCmq+3riAtPikAWbVCD
   wildhDxJleUy0P6vhR+56dVTKpBti97T+qMglN9cSSZE88idDPhoUZfO4
   2Z/gEA+KW2H2BiFMuf+St87s8vIdg07twai15zpR5/sdt/ciUbgCEDpXx
   l0AE4qCNtm3u+69bkF2iP26BxEC50kfEO7+tf6nwOnDDeK+HjudLHtLmN
   maBQvyn8ukpfp7/4lEv4LhREcELv2owbF8fY9wqk+4eyR9ZX3fYKNbMkJ
   M7EvOG8vb9gnYwRYw159Opa9y1NSnuOUW7BAUJ8OKPSEz9tlHyfZA9cDI
   A==;
X-CSE-ConnectionGUID: M//ApscsTTmgyh/JfGJALw==
X-CSE-MsgGUID: otAo6daFS9COCaOYARquwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="28568263"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="28568263"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:12:34 -0700
X-CSE-ConnectionGUID: R6JxPpQMS7GIEfRkq31aow==
X-CSE-MsgGUID: hSORzdtMRYaSxXKGXyB76A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48164659"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2024 09:12:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRZvi-000XzR-1q;
	Wed, 10 Jul 2024 16:12:30 +0000
Date: Thu, 11 Jul 2024 00:12:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/loongson] BUILD SUCCESS
 022f4ac0ca52de816530a35d3d5a4940c4497807
Message-ID: <202407110009.sQq3IBZ3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/loongson
branch HEAD: 022f4ac0ca52de816530a35d3d5a4940c4497807  PCI: loongson: Add LS7A MSI enablement quirk

elapsed time: 1054m

configs tested: 182
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240710   gcc-13.2.0
arc                   randconfig-002-20240710   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.3.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.3.0
arm                          collie_defconfig   gcc-13.3.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.3.0
arm                           imxrt_defconfig   gcc-13.3.0
arm                   randconfig-001-20240710   gcc-13.2.0
arm                   randconfig-002-20240710   gcc-13.2.0
arm                   randconfig-003-20240710   gcc-13.2.0
arm                   randconfig-004-20240710   gcc-13.2.0
arm                           sama7_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240710   gcc-13.2.0
arm64                 randconfig-002-20240710   gcc-13.2.0
arm64                 randconfig-003-20240710   gcc-13.2.0
arm64                 randconfig-004-20240710   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-13.3.0
csky                  randconfig-001-20240710   gcc-13.2.0
csky                  randconfig-002-20240710   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240710   clang-18
i386         buildonly-randconfig-002-20240710   clang-18
i386         buildonly-randconfig-003-20240710   clang-18
i386         buildonly-randconfig-004-20240710   clang-18
i386         buildonly-randconfig-005-20240710   clang-18
i386         buildonly-randconfig-006-20240710   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240710   clang-18
i386                  randconfig-002-20240710   clang-18
i386                  randconfig-003-20240710   clang-18
i386                  randconfig-004-20240710   clang-18
i386                  randconfig-005-20240710   clang-18
i386                  randconfig-006-20240710   clang-18
i386                  randconfig-011-20240710   clang-18
i386                  randconfig-012-20240710   clang-18
i386                  randconfig-013-20240710   clang-18
i386                  randconfig-014-20240710   clang-18
i386                  randconfig-015-20240710   clang-18
i386                  randconfig-016-20240710   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240710   gcc-13.2.0
loongarch             randconfig-002-20240710   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.3.0
m68k                          amiga_defconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.3.0
microblaze                       alldefconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.3.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.3.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           mtx1_defconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240710   gcc-13.2.0
nios2                 randconfig-002-20240710   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.3.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240710   gcc-13.2.0
parisc                randconfig-002-20240710   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.3.0
powerpc                          g5_defconfig   gcc-13.3.0
powerpc                        icon_defconfig   gcc-13.3.0
powerpc                       maple_defconfig   gcc-13.3.0
powerpc                     mpc512x_defconfig   gcc-13.3.0
powerpc                      ppc44x_defconfig   gcc-13.3.0
powerpc               randconfig-001-20240710   gcc-13.2.0
powerpc               randconfig-002-20240710   gcc-13.2.0
powerpc               randconfig-003-20240710   gcc-13.2.0
powerpc                         wii_defconfig   gcc-13.3.0
powerpc64             randconfig-001-20240710   gcc-13.2.0
powerpc64             randconfig-002-20240710   gcc-13.2.0
powerpc64             randconfig-003-20240710   gcc-13.2.0
riscv                            allmodconfig   gcc-13.3.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.3.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240710   gcc-13.2.0
riscv                 randconfig-002-20240710   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240710   gcc-13.2.0
s390                  randconfig-002-20240710   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240710   gcc-13.2.0
sh                    randconfig-002-20240710   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240710   gcc-13.2.0
sparc64               randconfig-002-20240710   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240710   gcc-13.2.0
um                    randconfig-002-20240710   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240710   clang-18
x86_64       buildonly-randconfig-002-20240710   clang-18
x86_64       buildonly-randconfig-003-20240710   clang-18
x86_64       buildonly-randconfig-004-20240710   clang-18
x86_64       buildonly-randconfig-005-20240710   clang-18
x86_64       buildonly-randconfig-006-20240710   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240710   clang-18
x86_64                randconfig-002-20240710   clang-18
x86_64                randconfig-003-20240710   clang-18
x86_64                randconfig-004-20240710   clang-18
x86_64                randconfig-005-20240710   clang-18
x86_64                randconfig-006-20240710   clang-18
x86_64                randconfig-011-20240710   clang-18
x86_64                randconfig-012-20240710   clang-18
x86_64                randconfig-013-20240710   clang-18
x86_64                randconfig-014-20240710   clang-18
x86_64                randconfig-015-20240710   clang-18
x86_64                randconfig-016-20240710   clang-18
x86_64                randconfig-071-20240710   clang-18
x86_64                randconfig-072-20240710   clang-18
x86_64                randconfig-073-20240710   clang-18
x86_64                randconfig-074-20240710   clang-18
x86_64                randconfig-075-20240710   clang-18
x86_64                randconfig-076-20240710   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240710   gcc-13.2.0
xtensa                randconfig-002-20240710   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

