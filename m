Return-Path: <linux-pci+bounces-11576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789794DE98
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2024 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC7A1C20A97
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349F83CA1;
	Sat, 10 Aug 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGAmQloh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27019381BA
	for <linux-pci@vger.kernel.org>; Sat, 10 Aug 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723322948; cv=none; b=ChraWG7BqUnQxNQyyQ49Gm18Do0zlqpu2OyrV3VJxj+br9/W57zcOjGLyLsLP+yCwwT1KEINlHbZMIdokWCG4D3eAYRSxYbEmBrqgA/IN5QqjDq++4pRjBqDK8aHcioiHE2QSgVYC8ptdz8Q1EmorLXwMbIpJqFKTgV+puqpv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723322948; c=relaxed/simple;
	bh=esS/sIY0XVzTNsYhOQDlIv6qZHqxIrp2/sd/ZzVjaxs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UmDvTtOhGoVpgnz/gWVtD6K665AK7bYYoY4JY+oU420CjMPspM9I4peWZQtgTdXKjhar3yjmrGeIvjKG1LZIeJCwvVpfr1+4TSJn2ppzpF3bVuku9VSZ+oXrYvwE5ItJLYG1BceOvfsI8wk1sBXXrOT4noCu6UUpk47qdo5LFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGAmQloh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723322946; x=1754858946;
  h=date:from:to:cc:subject:message-id;
  bh=esS/sIY0XVzTNsYhOQDlIv6qZHqxIrp2/sd/ZzVjaxs=;
  b=kGAmQlohaV2TQn5eenLSgJHNvo+zZyMRJcgbzjlqEDSSCV+XPVKOpdIy
   he1C/JUOtdKfSRBGoOE2FrAZl7Jodhcmvk+rtv85zxbIFqnNrNukLiJOQ
   bMZcXDnms0fm9lODxNQqRabOeSjIn4UrxF8kWQmlif99CKrMGQlsspHTw
   ef7+QZwSnvOWLKNRASbTwiBdHr+gaYlHYSZsse6rK8L6rn0xgObk+5hYd
   jbUcQQMQZ0AsQkcJg2sz5UQjXDfjecetwIiLnWJStE64GLLIxfqQ3Yhaa
   bWzPbhjISs0S3Rf5Yf6S3ngklYdeTeXUCGv+a2bLE/kd9PQGqFABrZ9iy
   w==;
X-CSE-ConnectionGUID: x9mIUBB/TVOdKRxS1byO2A==
X-CSE-MsgGUID: w1TEYgrsSOK6lL9T3xjdCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="24378329"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="24378329"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 13:49:06 -0700
X-CSE-ConnectionGUID: 8xEBM6ePS0CcjlpnS3Y74A==
X-CSE-MsgGUID: 2nWugHMfSIKejaIFurFnOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="95401356"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 10 Aug 2024 13:49:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sct1K-000AHX-0c;
	Sat, 10 Aug 2024 20:49:02 +0000
Date: Sun, 11 Aug 2024 04:48:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 265baca69a0735b64227a43d4be865a95ba514bb
Message-ID: <202408110439.rlhTqO2J-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: 265baca69a0735b64227a43d4be865a95ba514bb  s390/pci: Stop usurping pdev->dev.groups

elapsed time: 1456m

configs tested: 214
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240810   gcc-13.2.0
arc                   randconfig-002-20240810   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                            mps2_defconfig   gcc-13.2.0
arm                             mxs_defconfig   gcc-14.1.0
arm                          pxa168_defconfig   gcc-14.1.0
arm                   randconfig-001-20240810   gcc-13.2.0
arm                   randconfig-002-20240810   gcc-13.2.0
arm                   randconfig-003-20240810   gcc-13.2.0
arm                   randconfig-004-20240810   gcc-13.2.0
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240810   gcc-13.2.0
arm64                 randconfig-002-20240810   gcc-13.2.0
arm64                 randconfig-003-20240810   gcc-13.2.0
arm64                 randconfig-004-20240810   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240810   gcc-13.2.0
csky                  randconfig-002-20240810   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-005-20240810   clang-18
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-006-20240810   clang-18
i386         buildonly-randconfig-006-20240810   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-002-20240810   clang-18
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-004-20240810   clang-18
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-005-20240810   clang-18
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-011-20240810   clang-18
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-012-20240810   clang-18
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-014-20240810   clang-18
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-015-20240810   clang-18
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-016-20240810   clang-18
i386                  randconfig-016-20240810   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240810   gcc-13.2.0
loongarch             randconfig-002-20240810   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-14.1.0
mips                           ip27_defconfig   gcc-14.1.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240810   gcc-13.2.0
nios2                 randconfig-002-20240810   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240810   gcc-13.2.0
parisc                randconfig-002-20240810   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-14.1.0
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   gcc-14.1.0
powerpc                        warp_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240810   gcc-13.2.0
powerpc64             randconfig-002-20240810   gcc-13.2.0
powerpc64             randconfig-003-20240810   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240810   gcc-13.2.0
riscv                 randconfig-002-20240810   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240810   gcc-13.2.0
s390                  randconfig-002-20240810   gcc-13.2.0
s390                       zfcpdump_defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240810   gcc-13.2.0
sh                    randconfig-002-20240810   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240810   gcc-13.2.0
sparc64               randconfig-002-20240810   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240810   gcc-13.2.0
um                    randconfig-002-20240810   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240810   gcc-12
x86_64       buildonly-randconfig-002-20240810   gcc-12
x86_64       buildonly-randconfig-003-20240810   gcc-12
x86_64       buildonly-randconfig-004-20240810   gcc-12
x86_64       buildonly-randconfig-005-20240810   gcc-12
x86_64       buildonly-randconfig-006-20240810   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240810   gcc-12
x86_64                randconfig-002-20240810   gcc-12
x86_64                randconfig-003-20240810   gcc-12
x86_64                randconfig-004-20240810   gcc-12
x86_64                randconfig-005-20240810   gcc-12
x86_64                randconfig-006-20240810   gcc-12
x86_64                randconfig-011-20240810   gcc-12
x86_64                randconfig-012-20240810   gcc-12
x86_64                randconfig-013-20240810   gcc-12
x86_64                randconfig-014-20240810   gcc-12
x86_64                randconfig-015-20240810   gcc-12
x86_64                randconfig-016-20240810   gcc-12
x86_64                randconfig-071-20240810   gcc-12
x86_64                randconfig-072-20240810   gcc-12
x86_64                randconfig-073-20240810   gcc-12
x86_64                randconfig-074-20240810   gcc-12
x86_64                randconfig-075-20240810   gcc-12
x86_64                randconfig-076-20240810   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240810   gcc-13.2.0
xtensa                randconfig-002-20240810   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

