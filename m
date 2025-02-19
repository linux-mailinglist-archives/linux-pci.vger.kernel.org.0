Return-Path: <linux-pci+bounces-21829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B52BA3C737
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6235F3AA96D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2D91B81DC;
	Wed, 19 Feb 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjE2pr8i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256088468
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989159; cv=none; b=HGXDyqMhrzgzCkJnR7Fj5h81EQQi+zHA7jXOxKwq9e3SQaEiBhrAgPXFAbPfJiMd15+g1teAWvGOGAlya0RkRCQ0aYpblknNRtdBPYrWGklZIsVBaP9o6RZZqQENw1+G181e1gJ1LX7Jjb2f7+UZhhUv1mEw9gpPrkVyRXCnAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989159; c=relaxed/simple;
	bh=qRHhwWPhblCCJ/N3T5JjVnkEnrUc0lB468s6qUCQldg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FsaYjkYkTBfmbFO08Ap/e+7x6UCU6CNLUsrD6AJQWoFeuv8H6UvlPMA3nL0ZlrVpqfffxoLktbhQobZp6rN5EnenqtqEbBq8uSfn3rf8JIZkxMYbq/gtoyxwF+eDtZC7OndQr9z5dPOkbfJWky4EKIqmmcPMPI/TpcCgbjQTbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjE2pr8i; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989158; x=1771525158;
  h=date:from:to:cc:subject:message-id;
  bh=qRHhwWPhblCCJ/N3T5JjVnkEnrUc0lB468s6qUCQldg=;
  b=mjE2pr8id04nVtXDf4g1ur2c9kuqgBLlXiaLAX0YoBqoYjk6u43QY0Rb
   rQTUOeGl9GQ7oNNK1Cv3vaiPPmUg4ORNf/9MBq27ypmJ9Ij6hOYVtcf+n
   QkpLj7olgUX8GEISqmxmf/mdcScj2SnEhXJWadK+B6WtyIgNcVl9o5EE5
   GglRyynlRRqnLKUgAZJwOq8qJHM+5Rk14w2ireLzwFq7fOS9vmQG6taXd
   zu3DFE79WxM6oQ0/Allbji09imCiMPhnkxTcDWzjKquJLWfi/G10FIsvj
   A2t7KLJNzv5zjtolNTHZbjWe6dRHxjqPL6eSifXFA0IcCifAWjSmwRTwU
   A==;
X-CSE-ConnectionGUID: l32iCLAKQQage/Pmf3hOzQ==
X-CSE-MsgGUID: cPAbuMyvQkCqFLLu+gkTEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58150124"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58150124"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:19:17 -0800
X-CSE-ConnectionGUID: HXzzsvJDRTiTaetrrdCNKQ==
X-CSE-MsgGUID: waWlhaP1Sc+Y8WkKNPjGHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114624316"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2025 10:19:15 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkofB-0003IN-0k;
	Wed, 19 Feb 2025 18:19:13 +0000
Date: Thu, 20 Feb 2025 02:19:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD REGRESSION
 42e8331215cfd096f86b8605822a0fe8b0a2e2bb
Message-ID: <202502200201.J1koGBI9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 42e8331215cfd096f86b8605822a0fe8b0a2e2bb  PCI: shpchp: Remove 'shpchp_debug' module parameter

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502190711.BtNyZppZ-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202502190754.ogAfcyNP-lkp@intel.com

    drivers/pci/hotplug/shpchp_core.c:330:2: error: call to undeclared function 'dbg'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_core.c:330:9: error: implicit declaration of function 'dbg' [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_core.c:331:2: error: call to undeclared function 'info'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_core.c:331:9: error: implicit declaration of function 'info' [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_hpc.c:678:2: error: call to undeclared function 'dbg'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_hpc.c:678:9: error: implicit declaration of function 'dbg' [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- arc-allmodconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- arc-allyesconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- arm-allmodconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- arm-allyesconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- arm-randconfig-001-20250219
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- arm64-allmodconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-info-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-allmodconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- i386-allyesconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- i386-buildonly-randconfig-004-20250219
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-info-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-allmodconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-info-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-allyesconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- s390-randconfig-001-20250219
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-info-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- sparc-allmodconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- um-allmodconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-info-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- um-allyesconfig
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-dbg
|   |-- drivers-pci-hotplug-shpchp_core.c:error:implicit-declaration-of-function-info
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:implicit-declaration-of-function-dbg
|-- um-randconfig-002-20250219
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-info-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-allyesconfig
    |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-info-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-dbg-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 1454m

configs tested: 80
configs skipped: 1

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250219    gcc-13.2.0
arc                  randconfig-002-20250219    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250219    gcc-14.2.0
arm                  randconfig-002-20250219    clang-17
arm                  randconfig-003-20250219    clang-15
arm                  randconfig-004-20250219    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250219    clang-21
arm64                randconfig-002-20250219    gcc-14.2.0
arm64                randconfig-003-20250219    gcc-14.2.0
arm64                randconfig-004-20250219    gcc-14.2.0
csky                 randconfig-001-20250219    gcc-14.2.0
csky                 randconfig-002-20250219    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250219    clang-14
hexagon              randconfig-002-20250219    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250219    clang-19
i386       buildonly-randconfig-002-20250219    clang-19
i386       buildonly-randconfig-003-20250219    gcc-12
i386       buildonly-randconfig-004-20250219    clang-19
i386       buildonly-randconfig-005-20250219    clang-19
i386       buildonly-randconfig-006-20250219    gcc-12
i386                               defconfig    clang-19
loongarch            randconfig-001-20250219    gcc-14.2.0
loongarch            randconfig-002-20250219    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                            allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250219    gcc-14.2.0
nios2                randconfig-002-20250219    gcc-14.2.0
parisc               randconfig-001-20250219    gcc-14.2.0
parisc               randconfig-002-20250219    gcc-14.2.0
powerpc              randconfig-001-20250219    clang-15
powerpc              randconfig-002-20250219    clang-17
powerpc              randconfig-003-20250219    gcc-14.2.0
powerpc64            randconfig-001-20250219    gcc-14.2.0
powerpc64            randconfig-002-20250219    gcc-14.2.0
powerpc64            randconfig-003-20250219    gcc-14.2.0
riscv                randconfig-001-20250219    clang-21
riscv                randconfig-002-20250219    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250219    clang-18
s390                 randconfig-002-20250219    clang-21
sh                              allmodconfig    gcc-14.2.0
sh                               allnoconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250219    gcc-14.2.0
sh                   randconfig-002-20250219    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                            allnoconfig    gcc-14.2.0
sparc                randconfig-001-20250219    gcc-14.2.0
sparc                randconfig-002-20250219    gcc-14.2.0
sparc64              randconfig-001-20250219    gcc-14.2.0
sparc64              randconfig-002-20250219    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250219    clang-21
um                   randconfig-002-20250219    clang-21
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250219    gcc-12
x86_64     buildonly-randconfig-002-20250219    clang-19
x86_64     buildonly-randconfig-003-20250219    gcc-12
x86_64     buildonly-randconfig-004-20250219    clang-19
x86_64     buildonly-randconfig-005-20250219    gcc-12
x86_64     buildonly-randconfig-006-20250219    clang-19
x86_64                             defconfig    gcc-11
xtensa                           allnoconfig    gcc-14.2.0
xtensa               randconfig-001-20250219    gcc-14.2.0
xtensa               randconfig-002-20250219    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

