Return-Path: <linux-pci+bounces-159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C787F726E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D825B21058
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96243BA43;
	Fri, 24 Nov 2023 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvHbd9/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8EED59
	for <linux-pci@vger.kernel.org>; Fri, 24 Nov 2023 03:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700824146; x=1732360146;
  h=date:from:to:cc:subject:message-id;
  bh=d/ubUcDLF0RwmbX+GxYiNo8hYZvyNknX7ZpdMEIHCwc=;
  b=RvHbd9/IjNLHHpPAnKutJCYAx+q8D79B964gpbx8sg+zVb05J84BPDLR
   ko4MyuyDDlEYQgeq50fG6FLjGnw7Q9NYfsoQQggxMegMdct6PKUgZ2qkg
   MUGobilCW9zdFcr2jVcuB8R8ZlkCFhhx0xfy4/hlWd5e6MeGadykzZ5Qb
   AoSTf7lq0Sqff5DE5OIxsEr2s+WekyY9owh1+uz75XvR2gL1nFAkojyhe
   xH81jFtqt9tdy26K0KpzSGfukoEq5sT+G8pKr5CVwX/1lFOwt6HLwYtCZ
   9GfgI6eShnBecKL02v1fvNfeVasyqjaMMnQUxER40T0YolQxqmRhtDT9E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423543173"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="423543173"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="838059061"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="838059061"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2023 03:09:05 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6U3T-0002dy-0n;
	Fri, 24 Nov 2023 11:09:03 +0000
Date: Fri, 24 Nov 2023 19:07:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:switchtec] BUILD SUCCESS
 df25461119d987b8c81d232cfe4411e91dcabe66
Message-ID: <202311241910.1ZN8Otkb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git switchtec
branch HEAD: df25461119d987b8c81d232cfe4411e91dcabe66  PCI: switchtec: Fix stdev_release() crash after surprise hot remove

elapsed time: 2539m

configs tested: 108
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20231124   gcc  
arc                   randconfig-002-20231124   gcc  
arm                   randconfig-001-20231124   clang
arm                   randconfig-002-20231124   clang
arm                   randconfig-003-20231124   clang
arm                   randconfig-004-20231124   clang
arm64                 randconfig-001-20231124   clang
arm64                 randconfig-002-20231124   clang
arm64                 randconfig-003-20231124   clang
arm64                 randconfig-004-20231124   clang
csky                  randconfig-001-20231124   gcc  
csky                  randconfig-002-20231124   gcc  
hexagon               randconfig-001-20231124   clang
hexagon               randconfig-002-20231124   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231123   gcc  
i386         buildonly-randconfig-002-20231123   gcc  
i386         buildonly-randconfig-003-20231123   gcc  
i386         buildonly-randconfig-004-20231123   gcc  
i386         buildonly-randconfig-005-20231123   gcc  
i386         buildonly-randconfig-006-20231123   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231123   gcc  
i386                  randconfig-002-20231123   gcc  
i386                  randconfig-003-20231123   gcc  
i386                  randconfig-004-20231123   gcc  
i386                  randconfig-005-20231123   gcc  
i386                  randconfig-006-20231123   gcc  
i386                  randconfig-011-20231123   clang
i386                  randconfig-012-20231123   clang
i386                  randconfig-013-20231123   clang
i386                  randconfig-014-20231123   clang
i386                  randconfig-015-20231123   clang
i386                  randconfig-016-20231123   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20231124   gcc  
loongarch             randconfig-002-20231124   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231124   gcc  
nios2                 randconfig-002-20231124   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231124   gcc  
parisc                randconfig-002-20231124   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231124   clang
powerpc               randconfig-002-20231124   clang
powerpc               randconfig-003-20231124   clang
powerpc64             randconfig-001-20231124   clang
powerpc64             randconfig-002-20231124   clang
powerpc64             randconfig-003-20231124   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20231124   clang
riscv                 randconfig-002-20231124   clang
riscv                          rv32_defconfig   clang
s390                  randconfig-001-20231124   gcc  
s390                  randconfig-002-20231124   gcc  
sh                    randconfig-001-20231124   gcc  
sh                    randconfig-002-20231124   gcc  
sparc64               randconfig-001-20231124   gcc  
sparc64               randconfig-002-20231124   gcc  
um                    randconfig-001-20231124   clang
um                    randconfig-002-20231124   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231123   gcc  
x86_64       buildonly-randconfig-002-20231123   gcc  
x86_64       buildonly-randconfig-003-20231123   gcc  
x86_64       buildonly-randconfig-004-20231123   gcc  
x86_64       buildonly-randconfig-005-20231123   gcc  
x86_64       buildonly-randconfig-006-20231123   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231123   clang
x86_64                randconfig-002-20231123   clang
x86_64                randconfig-003-20231123   clang
x86_64                randconfig-004-20231123   clang
x86_64                randconfig-005-20231123   clang
x86_64                randconfig-006-20231123   clang
x86_64                randconfig-011-20231123   gcc  
x86_64                randconfig-012-20231123   gcc  
x86_64                randconfig-013-20231123   gcc  
x86_64                randconfig-014-20231123   gcc  
x86_64                randconfig-015-20231123   gcc  
x86_64                randconfig-016-20231123   gcc  
x86_64                randconfig-071-20231123   gcc  
x86_64                randconfig-072-20231123   gcc  
x86_64                randconfig-073-20231123   gcc  
x86_64                randconfig-074-20231123   gcc  
x86_64                randconfig-075-20231123   gcc  
x86_64                randconfig-076-20231123   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231124   gcc  
xtensa                randconfig-002-20231124   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

