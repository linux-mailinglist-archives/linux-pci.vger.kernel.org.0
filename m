Return-Path: <linux-pci+bounces-9972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EF92AE67
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 05:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB901F210A9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 03:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025593987D;
	Tue,  9 Jul 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnhMjbYm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF9A47
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2024 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494185; cv=none; b=a4LCoyx+fiVeSHFFCR+P5nUpAKRKlpSe2sMPEIE6U8QzDkP1TiD7bNFpkEfPVEedIgpl6JS8JprOJpAbtNP/brOz7OO1peswAenXd1U6qEgk+rAMOHEDqSblgYhcQGTiQM0AHk3OV47PVwg2jTleMHY42fItkq0SViHDs1xKbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494185; c=relaxed/simple;
	bh=shANIEMlYiCCqkS1/+u9UeAfPYwIRrEGaqvwf8htYKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ExEYJxbplqXPjQbPRa/XGspsnjzS+jalPBqq1SxP2p1EgzoL+jy94QtlV2YMePqHChP8LHbZqrkj4WOMm3oXwZNj17kxp1qC08mK4wMlW4nAWFmhJuO2rW5V+z6mERclYXCthDXa6MFm4eHmKIlAFiieZAjT1QY3SNeifNAynwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnhMjbYm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720494184; x=1752030184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=shANIEMlYiCCqkS1/+u9UeAfPYwIRrEGaqvwf8htYKo=;
  b=XnhMjbYmhDAZ5JSYa9lohI44oQnxmOGwcgNFMKZkcPpTUkX/Xe1Hsbcq
   29BXBl8OHxv2HAlLL04mVV9Cy407QsgIvGdRbCTrUedOL5a3xs6k7DLs8
   ErE/x0FUF5cWZRKYkLHbvFvy+wtdhq77Nnolgxo3X5PhZbTWrYwI1mLB8
   tZsj0UIFvuU/o5Ktau39CCALNdTXRsCYRfUHKfXlYIZV6A6EIB6BIpORC
   b+B9Hncoij+41IhVWx5e8P0aNi8JMpg5+38xPvb/CBjNJXlDpTSwENgR3
   nCuoLqWyeFEgS+3IZJSSppMK/egQ1fF+JtGnofM5ocfKkahYdQiErCWXB
   Q==;
X-CSE-ConnectionGUID: mGSNpmmFQLSA2HWSwCqp3Q==
X-CSE-MsgGUID: wgHm4ccgTKiMknhFbKT1sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="43145751"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="43145751"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 20:03:03 -0700
X-CSE-ConnectionGUID: eITjKhJpSlKd1nfMUwno2g==
X-CSE-MsgGUID: TPUdfXpDSdWsbUJPl1/2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52501734"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jul 2024 20:03:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sR187-000WHQ-2d;
	Tue, 09 Jul 2024 03:02:59 +0000
Date: Tue, 09 Jul 2024 11:02:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 cc7fe8c237ed004cc3cc1705e52e9befb814a7b9
Message-ID: <202407091140.NiJSLlzw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: cc7fe8c237ed004cc3cc1705e52e9befb814a7b9  Merge branch 'controller/tegra194' into next

elapsed time: 742m

configs tested: 151
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240709   gcc-13.2.0
arc                   randconfig-002-20240709   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   clang-19
arm                   randconfig-001-20240709   gcc-13.2.0
arm                   randconfig-002-20240709   clang-19
arm                   randconfig-003-20240709   clang-19
arm                   randconfig-004-20240709   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240709   clang-19
arm64                 randconfig-002-20240709   clang-17
arm64                 randconfig-003-20240709   clang-19
arm64                 randconfig-004-20240709   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240709   gcc-13.2.0
csky                  randconfig-002-20240709   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240709   clang-19
hexagon               randconfig-002-20240709   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240709   gcc-11
i386         buildonly-randconfig-002-20240709   gcc-13
i386         buildonly-randconfig-003-20240709   clang-18
i386         buildonly-randconfig-004-20240709   clang-18
i386         buildonly-randconfig-005-20240709   clang-18
i386         buildonly-randconfig-006-20240709   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240709   gcc-13
i386                  randconfig-002-20240709   clang-18
i386                  randconfig-003-20240709   gcc-11
i386                  randconfig-004-20240709   gcc-13
i386                  randconfig-005-20240709   gcc-13
i386                  randconfig-006-20240709   gcc-13
i386                  randconfig-011-20240709   clang-18
i386                  randconfig-012-20240709   gcc-13
i386                  randconfig-013-20240709   gcc-12
i386                  randconfig-014-20240709   clang-18
i386                  randconfig-015-20240709   clang-18
i386                  randconfig-016-20240709   gcc-10
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240709   gcc-13.2.0
loongarch             randconfig-002-20240709   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                         3c120_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240709   gcc-13.2.0
nios2                 randconfig-002-20240709   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                randconfig-001-20240709   gcc-13.2.0
parisc                randconfig-002-20240709   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                   lite5200b_defconfig   clang-14
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   clang-19
powerpc                     powernv_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240709   clang-19
powerpc               randconfig-002-20240709   gcc-13.2.0
powerpc               randconfig-003-20240709   clang-15
powerpc                     redwood_defconfig   clang-19
powerpc                      tqm8xx_defconfig   clang-19
powerpc64             randconfig-001-20240709   gcc-13.2.0
powerpc64             randconfig-002-20240709   gcc-13.2.0
powerpc64             randconfig-003-20240709   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                 randconfig-001-20240709   clang-17
riscv                 randconfig-002-20240709   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                  randconfig-001-20240709   gcc-13.2.0
s390                  randconfig-002-20240709   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                    randconfig-001-20240709   gcc-13.2.0
sh                    randconfig-002-20240709   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64               randconfig-001-20240709   gcc-13.2.0
sparc64               randconfig-002-20240709   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                    randconfig-001-20240709   gcc-13
um                    randconfig-002-20240709   gcc-11
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240709   gcc-11
x86_64       buildonly-randconfig-002-20240709   clang-18
x86_64       buildonly-randconfig-003-20240709   clang-18
x86_64       buildonly-randconfig-004-20240709   gcc-9
x86_64       buildonly-randconfig-005-20240709   gcc-13
x86_64       buildonly-randconfig-006-20240709   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240709   clang-18
x86_64                randconfig-002-20240709   gcc-10
x86_64                randconfig-003-20240709   clang-18
x86_64                randconfig-004-20240709   gcc-12
x86_64                randconfig-005-20240709   gcc-13
x86_64                randconfig-006-20240709   gcc-8
x86_64                randconfig-011-20240709   clang-18
x86_64                randconfig-012-20240709   clang-18
x86_64                randconfig-013-20240709   clang-18
x86_64                randconfig-014-20240709   clang-18
x86_64                randconfig-015-20240709   clang-18
x86_64                randconfig-016-20240709   clang-18
x86_64                randconfig-071-20240709   gcc-7
x86_64                randconfig-072-20240709   clang-18
x86_64                randconfig-073-20240709   gcc-13
x86_64                randconfig-074-20240709   gcc-13
x86_64                randconfig-075-20240709   gcc-11
x86_64                randconfig-076-20240709   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240709   gcc-13.2.0
xtensa                randconfig-002-20240709   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

