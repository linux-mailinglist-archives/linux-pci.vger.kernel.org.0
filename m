Return-Path: <linux-pci+bounces-33175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2623FB16079
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927AA7A7831
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFCB239E70;
	Wed, 30 Jul 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAGT+eKk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760A4C62
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879281; cv=none; b=WdLNlRETdp7psf/BvB+M5i50yoSUxjcDV3nVI1sRwc6HislIuTDRTO2Ox5R/Yh3Euzkz82ZLoNshxVZdJr7Zlwd7e+hHHBq//wXnSsxjbQZ6Qmuo4VLIGl88olimx1TCawJLF9EUT4cu+fFCuMukoGwiMyYDoJ0URWVoo4l2hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879281; c=relaxed/simple;
	bh=P7gBh8Tnwya4Hn72eHJJDWRMhrONmqCorzrWKl4pHMM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WEafEjGA92gaJMZSmbyHz0/Br6TcRFaU+LCOYlxnLKEj9l1L1Nuf4LN5rxv3t3Fdrl+J/oBCxalmv9kL9rGFZH8UMxrGEOfztYcXGggTTZL1LVdJAPQGgExwJViYflD9qce6iUREUKUPzh4Y2dkAXOd7QzZSu9Ed7tj7Ro2UELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAGT+eKk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753879279; x=1785415279;
  h=date:from:to:cc:subject:message-id;
  bh=P7gBh8Tnwya4Hn72eHJJDWRMhrONmqCorzrWKl4pHMM=;
  b=MAGT+eKkAXfC4AauP2cLmZmm+eWCVTdrKNepd1XXzmJGyrsPxIFPHtSa
   CvL0l18mFBS07q9IBshi3YyfRoiu2bXCMB7huMrj1D9FcJoN9EugJQ3ft
   z5VH6zZKRJfQlpwoe3lmpLLevGGjGjWbxENyjj8+G+GybL463V2iioiu8
   r2tkGbYex/FugJvn97oqxZ1qjdlcMho8S6aaIqTmibJHSn+FpN1kG6fge
   xzppmj56bzvgJmGUw7uqj8PWWApcnHrvAN++J42FSlJ/kmZKZLBQFYoGo
   2tZBaO56m8c1kcUt9aNwSI3dJXTjmU4M7gwpuBpX3FIxAhQjJ4J5ncCl9
   A==;
X-CSE-ConnectionGUID: AhrWJgDkQk6pOGfc3x6hlQ==
X-CSE-MsgGUID: wMZ3y8rgREGrhdPpuJsA+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67256650"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67256650"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 05:41:18 -0700
X-CSE-ConnectionGUID: 2RZsfPVIQAGjwryE6XOZiA==
X-CSE-MsgGUID: oCJtGYPqS8aqfXUWFFmAZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163323690"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jul 2025 05:41:17 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh67P-0002jW-2I;
	Wed, 30 Jul 2025 12:41:15 +0000
Date: Wed, 30 Jul 2025 20:40:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 e046b1731006b4c6c94bcb4ef1c6692a30014c43
Message-ID: <202507302026.qZqJycs5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: e046b1731006b4c6c94bcb4ef1c6692a30014c43  Merge branch 'pci/misc'

elapsed time: 1060m

configs tested: 116
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250730    gcc-8.5.0
arc                   randconfig-002-20250730    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                          ep93xx_defconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                   randconfig-001-20250730    clang-22
arm                   randconfig-002-20250730    clang-20
arm                   randconfig-003-20250730    gcc-8.5.0
arm                   randconfig-004-20250730    gcc-14.3.0
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250730    clang-22
arm64                 randconfig-002-20250730    clang-20
arm64                 randconfig-003-20250730    clang-17
arm64                 randconfig-004-20250730    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250730    gcc-14.3.0
csky                  randconfig-002-20250730    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250730    clang-20
hexagon               randconfig-002-20250730    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250730    clang-20
i386        buildonly-randconfig-002-20250730    clang-20
i386        buildonly-randconfig-003-20250730    gcc-12
i386        buildonly-randconfig-004-20250730    gcc-12
i386        buildonly-randconfig-005-20250730    clang-20
i386        buildonly-randconfig-006-20250730    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250730    clang-22
loongarch             randconfig-002-20250730    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250730    gcc-11.5.0
nios2                 randconfig-002-20250730    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250730    gcc-14.3.0
parisc                randconfig-002-20250730    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250730    gcc-8.5.0
powerpc               randconfig-002-20250730    gcc-8.5.0
powerpc               randconfig-003-20250730    clang-22
powerpc64             randconfig-001-20250730    clang-22
powerpc64             randconfig-002-20250730    clang-22
powerpc64             randconfig-003-20250730    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250730    gcc-10.5.0
riscv                 randconfig-002-20250730    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250730    clang-20
s390                  randconfig-002-20250730    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250730    gcc-12.5.0
sh                    randconfig-002-20250730    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250730    gcc-14.3.0
sparc                 randconfig-002-20250730    gcc-14.3.0
sparc64               randconfig-001-20250730    clang-22
sparc64               randconfig-002-20250730    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250730    gcc-11
um                    randconfig-002-20250730    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250730    gcc-12
x86_64      buildonly-randconfig-002-20250730    clang-20
x86_64      buildonly-randconfig-003-20250730    clang-20
x86_64      buildonly-randconfig-004-20250730    clang-20
x86_64      buildonly-randconfig-005-20250730    clang-20
x86_64      buildonly-randconfig-006-20250730    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250730    gcc-11.5.0
xtensa                randconfig-002-20250730    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

