Return-Path: <linux-pci+bounces-7431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE098C47F3
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 22:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F43281AF8
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA93BB30;
	Mon, 13 May 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChC3gU+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5FE7E110
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630396; cv=none; b=Q81NdoJ9HyQh7zk8h2zURzTATfk8fivSKKzTh7EQadUwQc0CohLTNdR33iwRGM1pdS0Xz1ct1PZiehkO0AUrCLaFIhTn+D5y6aXixiqQL3yM/5O/lq0qTeGuHZcQPE/mEthhDGYT0aW5o1Hvj/Qnval3SnRmWFwZVwRTVY25Aug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630396; c=relaxed/simple;
	bh=ercRQJcjbZNWO7adHiaBIO+7kjKU3fmCGo3xUfuoAOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hHIJjyA0cDeqLccBcSvBSqBjmRfap1UPVTQVBe7KycRnwM6CvA0bZBlaXmTFX7m27i+pdZIrRTxKh2e2EShHlbsi3Z0nD56ZQ9fAVKQVRAbd/rVAbNTNRw7H9ClyB4PprBxECS+XCzEQLHyWeFxlD0eGVkDmo/uJDERKfu3EWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChC3gU+6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715630394; x=1747166394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ercRQJcjbZNWO7adHiaBIO+7kjKU3fmCGo3xUfuoAOY=;
  b=ChC3gU+6m2uXCC91opTHmENZ736c5mjCnFG1o5eMWIdou7uSEOcmCw+t
   jHaG355Plp+luxXY8PjxoPVAg55pa3cwO05WJ6Xw6qJMmNQOFAAu72mXo
   8Tp/X9/hFTbBG65Ia16I8zfL1smfKoeBYW8auJXQyJGZbFMbtFzNIpVrB
   hVjy2A0DsET+lIXwMOGm5Y6oecxNzBHZZERdX5UFNAymAOpoGHsGQC7z3
   qxHlYC8hj+niiHO9mph4B+YHw/1eq4bbj+O4Fknym51f+cEiA7QVSKXQO
   iVEphPJi3LRTGxQVB15gjJC+Oi7JDq0kTBkEKq5ILnPiwJHtneokvLjH/
   A==;
X-CSE-ConnectionGUID: DzwcMp7rSYueBrZx0mAvmw==
X-CSE-MsgGUID: Uszt8nqBTb6qpJTdX//S+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11798536"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11798536"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 12:59:53 -0700
X-CSE-ConnectionGUID: 2vsabQdIRn+n1gyFmJMmfA==
X-CSE-MsgGUID: I3U9/2NuQjCIMW1Oo6VBTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="34990544"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 May 2024 12:59:52 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6bpu-000AfN-10;
	Mon, 13 May 2024 19:59:50 +0000
Date: Tue, 14 May 2024 03:59:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD REGRESSION
 b1d4d63d52a72c55f09c99ce454588c51c5a1674
Message-ID: <202405140344.glj9WfzM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: b1d4d63d52a72c55f09c99ce454588c51c5a1674  PCI: dwc: keystone: Fix NULL pointer dereference in case of DT error in ks_pcie_setup_rc_app_regs()

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm64-randconfig-001-20240513
    `-- pcie-tegra194.c:(.text):undefined-reference-to-pci_epc_deinit_notify
clang_recent_errors
`-- arm64-randconfig-003-20240513
    `-- ld.lld:error:undefined-symbol:pci_epc_deinit_notify

elapsed time: 900m

configs tested: 177
configs skipped: 5

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240513   gcc  
arc                   randconfig-002-20240513   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                         lpc18xx_defconfig   clang
arm                   randconfig-001-20240513   clang
arm                   randconfig-002-20240513   gcc  
arm                   randconfig-003-20240513   clang
arm                   randconfig-004-20240513   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240513   gcc  
arm64                 randconfig-002-20240513   gcc  
arm64                 randconfig-003-20240513   clang
arm64                 randconfig-004-20240513   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240513   gcc  
csky                  randconfig-002-20240513   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240513   clang
hexagon               randconfig-002-20240513   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240513   clang
i386         buildonly-randconfig-002-20240513   clang
i386         buildonly-randconfig-003-20240513   gcc  
i386         buildonly-randconfig-004-20240513   clang
i386         buildonly-randconfig-005-20240513   gcc  
i386         buildonly-randconfig-006-20240513   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240513   gcc  
i386                  randconfig-002-20240513   clang
i386                  randconfig-003-20240513   gcc  
i386                  randconfig-004-20240513   clang
i386                  randconfig-005-20240513   gcc  
i386                  randconfig-006-20240513   gcc  
i386                  randconfig-011-20240513   gcc  
i386                  randconfig-012-20240513   clang
i386                  randconfig-013-20240513   clang
i386                  randconfig-014-20240513   gcc  
i386                  randconfig-015-20240513   gcc  
i386                  randconfig-016-20240513   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240513   gcc  
loongarch             randconfig-002-20240513   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                     loongson1b_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240513   gcc  
nios2                 randconfig-002-20240513   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240513   gcc  
parisc                randconfig-002-20240513   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240513   gcc  
powerpc               randconfig-002-20240513   gcc  
powerpc               randconfig-003-20240513   gcc  
powerpc64             randconfig-001-20240513   gcc  
powerpc64             randconfig-002-20240513   clang
powerpc64             randconfig-003-20240513   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240513   gcc  
riscv                 randconfig-002-20240513   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
s390                  randconfig-001-20240513   gcc  
s390                  randconfig-002-20240513   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240513   gcc  
sh                    randconfig-002-20240513   gcc  
sh                           se7206_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240513   gcc  
sparc64               randconfig-002-20240513   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240513   clang
um                    randconfig-002-20240513   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240513   gcc  
x86_64       buildonly-randconfig-002-20240513   gcc  
x86_64       buildonly-randconfig-003-20240513   gcc  
x86_64       buildonly-randconfig-004-20240513   clang
x86_64       buildonly-randconfig-005-20240513   clang
x86_64       buildonly-randconfig-006-20240513   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240513   clang
x86_64                randconfig-002-20240513   clang
x86_64                randconfig-003-20240513   clang
x86_64                randconfig-004-20240513   gcc  
x86_64                randconfig-005-20240513   clang
x86_64                randconfig-006-20240513   clang
x86_64                randconfig-011-20240513   clang
x86_64                randconfig-012-20240513   gcc  
x86_64                randconfig-013-20240513   clang
x86_64                randconfig-014-20240513   clang
x86_64                randconfig-015-20240513   gcc  
x86_64                randconfig-016-20240513   clang
x86_64                randconfig-071-20240513   clang
x86_64                randconfig-072-20240513   clang
x86_64                randconfig-073-20240513   clang
x86_64                randconfig-074-20240513   gcc  
x86_64                randconfig-075-20240513   gcc  
x86_64                randconfig-076-20240513   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240513   gcc  
xtensa                randconfig-002-20240513   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

