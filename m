Return-Path: <linux-pci+bounces-6153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32B8A1F92
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 21:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1431F2A8E6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905816419;
	Thu, 11 Apr 2024 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYQzpHJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8A175A5
	for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864248; cv=none; b=rusC7heFWxRVylULK2ULdEYKLfoTno2vrKjU7mFnjCK49vWRs/jAPd5x20b+gWbYvijsNuTnDhPdzPCuaeGNvoHxDi8P9QT5AvR23vb7/0K0LNIjKt8iQoTdlY+npdn0fXQUoVKQoyE6iouzCOqOmmn5nB2mR7FnjsDkq41evRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864248; c=relaxed/simple;
	bh=3rsTPXJR7lq+8MYPBM9faUmJwfoPErQv4ZdSeLfDLiM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xk/KjJRFA41ySd8IT80T/UoLTu/D42sKSUD5NL7V178dimppPjABx9gtw3u4t7ATEiNOf/QRKAX3P6l8yHxzfV/ef/sjEqhAu0DsOTRTT7+pQ/4Wy5EjvTP+U/WWBDhmIfOon6bWGWNLffvvUs20Je5ebIGozK+62bJxFunnbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYQzpHJm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712864245; x=1744400245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3rsTPXJR7lq+8MYPBM9faUmJwfoPErQv4ZdSeLfDLiM=;
  b=NYQzpHJm15NKF9AOPvKfmiHYjHVS8Z+3Rq9Z8X1QYkwgMligKbRM1B4T
   hzhmVg+zWg6sLpiz8ZpJum+67VEVhqMCQH7oXPCTy8OQlnNDJLPg98odt
   QAjt9GOCDprZthPV88I885LbgPuNVej413xa4djJFJdlsCkw9WTbqp/W9
   yjc6ndoFo4Q7n9yeUvdadz1q0WqO3PK8jnFcBccb8PGbqyIqnNXQQjGJ+
   ILvZO4L8sLM9J3HnZKlWLlozo57ikEOI1f3itHsgtI9ua4xHpJwCjikoi
   a/vF6VT3SZoDBRq01GQatGvbnQljlkDp2YMwUBM0DyHNtH6vNoqWWVIyZ
   g==;
X-CSE-ConnectionGUID: QZBzrLxYRu+iANtaORVb6g==
X-CSE-MsgGUID: ANGsl2oLSL6NHJsl1IeDiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8467128"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8467128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 12:37:24 -0700
X-CSE-ConnectionGUID: 9WVK3IbQRiyn2OBjSgES3w==
X-CSE-MsgGUID: mxCcPsp7R/CyL3DaOlUkyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="52177156"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Apr 2024 12:37:24 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv0Eb-0008vl-39;
	Thu, 11 Apr 2024 19:37:21 +0000
Date: Fri, 12 Apr 2024 03:37:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra194] BUILD SUCCESS
 19326006a21da26532d982254677c892dae8f29b
Message-ID: <202404120313.VpTatnJq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra194
branch HEAD: 19326006a21da26532d982254677c892dae8f29b  PCI: tegra194: Fix probe path for Endpoint mode

elapsed time: 1451m

configs tested: 152
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
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240411   gcc  
arc                   randconfig-002-20240411   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           omap1_defconfig   gcc  
arm                   randconfig-001-20240411   gcc  
arm                   randconfig-002-20240411   gcc  
arm                   randconfig-004-20240411   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240411   gcc  
arm64                 randconfig-003-20240411   gcc  
arm64                 randconfig-004-20240411   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240411   gcc  
csky                  randconfig-002-20240411   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240411   clang
i386         buildonly-randconfig-002-20240411   clang
i386         buildonly-randconfig-003-20240411   clang
i386         buildonly-randconfig-004-20240411   clang
i386         buildonly-randconfig-005-20240411   clang
i386         buildonly-randconfig-006-20240411   clang
i386                                defconfig   clang
i386                  randconfig-001-20240411   gcc  
i386                  randconfig-002-20240411   gcc  
i386                  randconfig-003-20240411   clang
i386                  randconfig-004-20240411   clang
i386                  randconfig-005-20240411   gcc  
i386                  randconfig-006-20240411   clang
i386                  randconfig-011-20240411   clang
i386                  randconfig-012-20240411   gcc  
i386                  randconfig-013-20240411   gcc  
i386                  randconfig-014-20240411   gcc  
i386                  randconfig-015-20240411   clang
i386                  randconfig-016-20240411   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240411   gcc  
loongarch             randconfig-002-20240411   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240411   gcc  
nios2                 randconfig-002-20240411   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240411   gcc  
parisc                randconfig-002-20240411   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240411   gcc  
powerpc               randconfig-003-20240411   gcc  
powerpc64             randconfig-002-20240411   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240411   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240411   gcc  
sh                    randconfig-002-20240411   gcc  
sh                           se7206_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240411   gcc  
sparc64               randconfig-002-20240411   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240411   gcc  
um                    randconfig-002-20240411   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240411   gcc  
x86_64       buildonly-randconfig-004-20240411   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240411   gcc  
x86_64                randconfig-005-20240411   gcc  
x86_64                randconfig-012-20240411   gcc  
x86_64                randconfig-014-20240411   gcc  
x86_64                randconfig-015-20240411   gcc  
x86_64                randconfig-016-20240411   gcc  
x86_64                randconfig-074-20240411   gcc  
x86_64                randconfig-075-20240411   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240411   gcc  
xtensa                randconfig-002-20240411   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

