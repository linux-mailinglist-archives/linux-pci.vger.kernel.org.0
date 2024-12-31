Return-Path: <linux-pci+bounces-19125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E25309FEFDF
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 14:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABFF1882E59
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA019A298;
	Tue, 31 Dec 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSXf18g1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB5DDBE
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735653548; cv=none; b=FXQuPMqnyw2dE3DfTiwmc1kqBsM7EUSAHaqrn8faZwZrr17mKl2HKrKTP0JJManlkP5DolkMorBbR61BniuetJB9UEDpZ/4YX3y33eURhhZjmeMg8hHEGfzvWDQ7C0hcdWlfOT0trkRFTTKXFEo/zXrpNp0Df8d2zGsbYdfs8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735653548; c=relaxed/simple;
	bh=GtSp69YIsowzb5Ye8I2uYpiyzV5bo08SAw1awMrumi4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=olSOj79kmpdw3nUmtg/vKXOEtEbs6TDZNaobfqqlk13dKJIkyM1EKerritCKgZiUF5iFscnRdroRwSyLViaMrMiUvGGVgnsIKZOepv/dBekwMccH4FdSFdOaeKWOHc74pkDGTnu/UeU1dSsjAgtXmSL5D8oGVDa9IIg32+Cwyk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSXf18g1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735653546; x=1767189546;
  h=date:from:to:cc:subject:message-id;
  bh=GtSp69YIsowzb5Ye8I2uYpiyzV5bo08SAw1awMrumi4=;
  b=iSXf18g1/YobQAUyjOFtbWk8N9rBwzXm7OsCon8R6qaszvtCf6Vg2wBe
   m+cwTRUiXDaXS/0QcLjxseG3GuECYY+jSEMK62aU/wYbXAw0NDxM0cQGy
   +9Ma4v/jsh5emTPNhPEKwN1LqFH4Eqtam15TsXJefcVBcTZBFGgfeBgsR
   mDiQFusOfrawOxV4YvsjkMYVYIfZzNW9dOTA5FnebVXGeQKBWl1Tn4ARj
   yR+KQwGS77Tw7+JV49ngeMmbM1/aAnKNL2aeCP8qSQJoF4QTv9rvHyms9
   grcHbPUoh4Xg4qfm4DQnt22e/+Xcch1IgWqqM+tUjgW939GMf0SPDnXWD
   A==;
X-CSE-ConnectionGUID: 3ZAt8uK5TsSXTrswZEot7A==
X-CSE-MsgGUID: P2iSqLSnRkOJTDjI2tzT8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="39614478"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="39614478"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 05:59:05 -0800
X-CSE-ConnectionGUID: l60vaXNMQR2leD16/BzVyg==
X-CSE-MsgGUID: ktEc5hrLQgGPSxoKkW9Omw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="131996308"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Dec 2024 05:59:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tScly-00079u-1v;
	Tue, 31 Dec 2024 13:59:02 +0000
Date: Tue, 31 Dec 2024 21:58:31 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 be1bd93e8874e7c35f1c4a63f8f945981daddab1
Message-ID: <202412312125.DitbA33j-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: be1bd93e8874e7c35f1c4a63f8f945981daddab1  Merge branch 'pci/misc'

elapsed time: 896m

configs tested: 139
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                        nsim_700_defconfig    gcc-13.2.0
arc                   randconfig-001-20241231    gcc-13.2.0
arc                   randconfig-002-20241231    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                            dove_defconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-19
arm                   milbeaut_m10v_defconfig    clang-20
arm                   randconfig-001-20241231    clang-19
arm                   randconfig-002-20241231    clang-17
arm                   randconfig-003-20241231    gcc-14.2.0
arm                   randconfig-004-20241231    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241231    clang-20
arm64                 randconfig-002-20241231    clang-20
arm64                 randconfig-003-20241231    gcc-14.2.0
arm64                 randconfig-004-20241231    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241231    gcc-14.2.0
csky                  randconfig-002-20241231    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241231    clang-20
hexagon               randconfig-002-20241231    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241231    gcc-11
i386        buildonly-randconfig-002-20241231    clang-19
i386        buildonly-randconfig-003-20241231    clang-19
i386        buildonly-randconfig-004-20241231    clang-19
i386        buildonly-randconfig-005-20241231    gcc-12
i386        buildonly-randconfig-006-20241231    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241231    gcc-14.2.0
loongarch             randconfig-002-20241231    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241231    gcc-14.2.0
nios2                 randconfig-002-20241231    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241231    gcc-14.2.0
parisc                randconfig-002-20241231    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241231    clang-15
powerpc               randconfig-002-20241231    clang-20
powerpc               randconfig-003-20241231    clang-15
powerpc64             randconfig-001-20241231    clang-20
powerpc64             randconfig-002-20241231    clang-19
powerpc64             randconfig-003-20241231    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241231    clang-20
riscv                 randconfig-002-20241231    clang-15
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241231    gcc-14.2.0
s390                  randconfig-002-20241231    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                    randconfig-001-20241231    gcc-14.2.0
sh                    randconfig-002-20241231    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241231    gcc-14.2.0
sparc                 randconfig-002-20241231    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241231    gcc-14.2.0
sparc64               randconfig-002-20241231    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241231    clang-20
um                    randconfig-002-20241231    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241231    clang-19
x86_64      buildonly-randconfig-002-20241231    gcc-12
x86_64      buildonly-randconfig-003-20241231    clang-19
x86_64      buildonly-randconfig-004-20241231    gcc-12
x86_64      buildonly-randconfig-005-20241231    clang-19
x86_64      buildonly-randconfig-006-20241231    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241231    gcc-14.2.0
xtensa                randconfig-002-20241231    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

