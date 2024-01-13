Return-Path: <linux-pci+bounces-2136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40182CA4E
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 07:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926A21F236F8
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB7EAEA;
	Sat, 13 Jan 2024 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrdjl5Ci"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967B17727
	for <linux-pci@vger.kernel.org>; Sat, 13 Jan 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705128937; x=1736664937;
  h=date:from:to:cc:subject:message-id;
  bh=ame2Vk0SHlSzArLphMCBQWl+FiWCcQ5tDk/RczbyjzE=;
  b=Xrdjl5Ciy+pbapnNUZinZYwR6wGDPgdSdKA2vgvq5iGVCinK/pBjYRWX
   Gfb3arKfjip/128B2BvtU7LCiej+Eycp/om0FIYKNdK1JM+bo2JHsSy7d
   j0QsLKy+O+p1lab7dNlUYGPwGSPf9eFQ2/KzQvOoKlfRS9GdFncGX/tEw
   BoboBhJh/vr57HCzMO6YChHQOKe/I5oStBb8vmyEiSR9KiwC+J8Yfoij9
   m2MEgtdzFufCmEJA9lxfcWIBhthzJWZG8foIzthqajSEf8lQTiuwModYc
   I4wFiY7sbpX/vHKXzCvw9vsqm4zBGKcL43GTP3TfH2TLSThTA5Pyn6fwl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="389801234"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="389801234"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 22:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="902207124"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="902207124"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2024 22:55:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOXvZ-000ACI-2K;
	Sat, 13 Jan 2024 06:55:33 +0000
Date: Sat, 13 Jan 2024 14:54:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 e1721eaa13f6ed51bf487d4f52ee11ce517ef27d
Message-ID: <202401131456.TguAtdYD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: e1721eaa13f6ed51bf487d4f52ee11ce517ef27d  PCI: Fix kernel-doc issues

elapsed time: 1781m

configs tested: 101
configs skipped: 2

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
arc                   randconfig-001-20240113   gcc  
arc                   randconfig-002-20240113   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240113   gcc  
arm                   randconfig-002-20240113   gcc  
arm                   randconfig-003-20240113   gcc  
arm                   randconfig-004-20240113   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240113   gcc  
arm64                 randconfig-002-20240113   gcc  
arm64                 randconfig-003-20240113   gcc  
arm64                 randconfig-004-20240113   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240113   gcc  
csky                  randconfig-002-20240113   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240113   clang
hexagon               randconfig-002-20240113   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240113   gcc  
i386         buildonly-randconfig-002-20240113   gcc  
i386         buildonly-randconfig-003-20240113   gcc  
i386         buildonly-randconfig-004-20240113   gcc  
i386         buildonly-randconfig-005-20240113   gcc  
i386         buildonly-randconfig-006-20240113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240113   gcc  
i386                  randconfig-002-20240113   gcc  
i386                  randconfig-003-20240113   gcc  
i386                  randconfig-004-20240113   gcc  
i386                  randconfig-005-20240113   gcc  
i386                  randconfig-006-20240113   gcc  
i386                  randconfig-011-20240113   clang
i386                  randconfig-012-20240113   clang
i386                  randconfig-013-20240113   clang
i386                  randconfig-014-20240113   clang
i386                  randconfig-015-20240113   clang
i386                  randconfig-016-20240113   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240113   gcc  
loongarch             randconfig-002-20240113   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240113   gcc  
nios2                 randconfig-002-20240113   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240113   gcc  
parisc                randconfig-002-20240113   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240113   gcc  
powerpc               randconfig-002-20240113   gcc  
powerpc               randconfig-003-20240113   gcc  
powerpc64             randconfig-001-20240113   gcc  
powerpc64             randconfig-002-20240113   gcc  
powerpc64             randconfig-003-20240113   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240113   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20240113   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

