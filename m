Return-Path: <linux-pci+bounces-7587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3EC8C8014
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 04:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553E9B21A36
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474C944E;
	Fri, 17 May 2024 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsfpegxY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6E9441
	for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715914312; cv=none; b=bYWOua1NQJjwsFTdgcLhbWqqk98A8UGqtZEl1CZbWFvfJxrjgx/XpKk24TnRJy2AKrWrJk0GR4pTNBdVjrLpUefwFmKOtEthaajlAVtT+gH4V7ZXRwIA4tuhf8Kn0IBWCKOPI72NQQV//qak8D5qChUfOLEZuouvaLsSWfgpBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715914312; c=relaxed/simple;
	bh=4JPozfcts7O6j02SrPF5qKStQHG+JiuWOJLXECAEMew=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YUWTIKqywWFWYWgFdyjKKwweqHQuJSmh6QFnHCixbjQtqoKzEf9OkUDaA9gGjkJ5hpDvc7nugFfRmm/2RyyujhtKNDNrd+25DoWOYZk3d0Z+LqECA48XIWpiQ+K9vcpAUWAj0AX0kQf22Fb/oyppbDnvqSauf7RvHTNKbqBQTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsfpegxY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715914311; x=1747450311;
  h=date:from:to:cc:subject:message-id;
  bh=4JPozfcts7O6j02SrPF5qKStQHG+JiuWOJLXECAEMew=;
  b=ZsfpegxY6aMEa9aPKQghF6zHFX8FsTDVhNDkNe/tN/wH4xCHVS+LnPdY
   8+rVPGjqAoi4OVYrWqFU0sJ+nRx2zOCCNed3mTGvYK2kwN4S6Y5v6ULDB
   sxvLuooaSN3npRo6ZDj8vzwfQGVLVOjU4IIjuRptaMxD4fjh5r8NXpgK5
   EvUe4Qj0RHQd21EBTAQYkq7bvBL3B9gqyhxBahhFdV0wJL9Pty5Vt0rLv
   wHTdsT2alZCxsS545edrXZ/wPVyZCTc98eEdpnKWqxslj2rS0E+ukgfwh
   BghP0GluYMuV4iqUj0px5q0ZclwmI8JyoF9Oy0wRMB/tbU5owNZK4bu9Y
   w==;
X-CSE-ConnectionGUID: JPhiYV5ZSq+2usQWJfwR+Q==
X-CSE-MsgGUID: urQrujrSQ8+I8DcR7mch1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22674090"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="22674090"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:51:50 -0700
X-CSE-ConnectionGUID: 6bYDY7FNSPmPW544BDdxPw==
X-CSE-MsgGUID: ARGIGnt5TMyBQM92+BFSww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="36154653"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 19:51:48 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7nh2-00006F-2w;
	Fri, 17 May 2024 02:51:38 +0000
Date: Fri, 17 May 2024 10:46:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/keystone] BUILD SUCCESS
 8c990314172b37011cf31c33ed52f7978eca73d4
Message-ID: <202405171039.OLkgj8o7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
branch HEAD: 8c990314172b37011cf31c33ed52f7978eca73d4  PCI: keystone: Don't enable BAR 0 for AM654x

elapsed time: 733m

configs tested: 194
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240516   gcc  
arc                   randconfig-001-20240517   gcc  
arc                   randconfig-002-20240516   gcc  
arc                   randconfig-002-20240517   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                      jornada720_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240516   gcc  
arm                   randconfig-001-20240517   clang
arm                   randconfig-002-20240516   clang
arm                   randconfig-002-20240517   clang
arm                   randconfig-003-20240516   gcc  
arm                   randconfig-003-20240517   clang
arm                   randconfig-004-20240516   clang
arm                   randconfig-004-20240517   clang
arm                         s5pv210_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240516   gcc  
arm64                 randconfig-001-20240517   clang
arm64                 randconfig-002-20240516   clang
arm64                 randconfig-002-20240517   gcc  
arm64                 randconfig-003-20240516   clang
arm64                 randconfig-003-20240517   clang
arm64                 randconfig-004-20240516   gcc  
arm64                 randconfig-004-20240517   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240516   gcc  
csky                  randconfig-001-20240517   gcc  
csky                  randconfig-002-20240516   gcc  
csky                  randconfig-002-20240517   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240516   clang
hexagon               randconfig-001-20240517   clang
hexagon               randconfig-002-20240516   clang
hexagon               randconfig-002-20240517   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240517   clang
i386         buildonly-randconfig-002-20240517   clang
i386         buildonly-randconfig-003-20240517   gcc  
i386         buildonly-randconfig-004-20240517   clang
i386         buildonly-randconfig-005-20240517   clang
i386         buildonly-randconfig-006-20240517   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240517   gcc  
i386                  randconfig-002-20240517   gcc  
i386                  randconfig-003-20240517   gcc  
i386                  randconfig-004-20240517   gcc  
i386                  randconfig-005-20240517   gcc  
i386                  randconfig-006-20240517   gcc  
i386                  randconfig-011-20240517   gcc  
i386                  randconfig-012-20240517   clang
i386                  randconfig-013-20240517   gcc  
i386                  randconfig-014-20240517   gcc  
i386                  randconfig-015-20240517   clang
i386                  randconfig-016-20240517   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240516   gcc  
loongarch             randconfig-001-20240517   gcc  
loongarch             randconfig-002-20240516   gcc  
loongarch             randconfig-002-20240517   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240516   gcc  
nios2                 randconfig-001-20240517   gcc  
nios2                 randconfig-002-20240516   gcc  
nios2                 randconfig-002-20240517   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240516   gcc  
parisc                randconfig-001-20240517   gcc  
parisc                randconfig-002-20240516   gcc  
parisc                randconfig-002-20240517   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                      mgcoge_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240516   gcc  
powerpc               randconfig-001-20240517   clang
powerpc               randconfig-002-20240516   clang
powerpc               randconfig-002-20240517   clang
powerpc               randconfig-003-20240516   clang
powerpc               randconfig-003-20240517   gcc  
powerpc64             randconfig-001-20240516   gcc  
powerpc64             randconfig-001-20240517   gcc  
powerpc64             randconfig-002-20240516   clang
powerpc64             randconfig-002-20240517   gcc  
powerpc64             randconfig-003-20240516   gcc  
powerpc64             randconfig-003-20240517   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240516   gcc  
riscv                 randconfig-001-20240517   clang
riscv                 randconfig-002-20240516   clang
riscv                 randconfig-002-20240517   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240516   gcc  
s390                  randconfig-001-20240517   clang
s390                  randconfig-002-20240516   clang
s390                  randconfig-002-20240517   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240516   gcc  
sh                    randconfig-001-20240517   gcc  
sh                    randconfig-002-20240516   gcc  
sh                    randconfig-002-20240517   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240516   gcc  
sparc64               randconfig-001-20240517   gcc  
sparc64               randconfig-002-20240516   gcc  
sparc64               randconfig-002-20240517   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240516   clang
um                    randconfig-001-20240517   clang
um                    randconfig-002-20240516   clang
um                    randconfig-002-20240517   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240516   gcc  
xtensa                randconfig-001-20240517   gcc  
xtensa                randconfig-002-20240516   gcc  
xtensa                randconfig-002-20240517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

