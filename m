Return-Path: <linux-pci+bounces-15267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F589AFAF3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F125DB22280
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98B1B395F;
	Fri, 25 Oct 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGt2OHYi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677F1B21A7
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841401; cv=none; b=DJK2RQvczwjaojRZwXrtSo5/TDMjV/FzkjfiGAzFqEhpPJ+A/70r2twhX/uNZHfejb6P0pbepScnFmkrhbam30ezDaC2UQ/H3sVcyuTFTGt2PA2zRc+gLc8yjl+UKDbiqBKe2N4IUW7O44i7UfrvecVYzn3YS3iX6dCYAeBLUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841401; c=relaxed/simple;
	bh=t3mnuoBJZJ/jEwT5w5END/89dgqIe63JgMbEGug3rI4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AZ9jCFsftK5bCjRtXb/kmDQhwsOFRHMgCcFKGockJyS6ZYXZWHwEYxJhTDKq9eU/ou/MVdswMBj38BSbBEZmmgIK/Si+sgk0p+HMWmyf558ZPgb0n3ld9//9f6+Jh03nfp1LAzwd8B5NMORcQOW4R0hrRUKwG67AyromsBiApUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGt2OHYi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729841400; x=1761377400;
  h=date:from:to:cc:subject:message-id;
  bh=t3mnuoBJZJ/jEwT5w5END/89dgqIe63JgMbEGug3rI4=;
  b=AGt2OHYiQx4bv4+K8RezTyHamrRNjmWxxr9nr87RgCNtdN0jvHXjLWDu
   803R6MPj9W9EUG5yzj1cDFYKjOwtLSs73QM1lVkZc20ilwhErtZ9nt899
   41Hkn9gYse2cRndylSbhDSJDr76ihlChUcDWx0fMYnvh+5EB06OUrbYhN
   X3KCibJf4VyrmuBctJj7n2Iaa7L0VNRxfxXaNoCPudAlAjLXZeLAQ1u00
   BUEEsOuZvfj1sVpzeWdqPx1RpEFULinUu9hfR5q0lwhZV2m6PXjTRtA3x
   qp8gmCaWiaZCqHjtaLS6sC2YYolzY5diJ0eS0qhysRPjUj1NRIShz65Mu
   w==;
X-CSE-ConnectionGUID: TBMcx3yjRxye5Gx5K85EEA==
X-CSE-MsgGUID: as+eniBNRwSHCQ6t1X9Fuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29612235"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29612235"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 00:29:48 -0700
X-CSE-ConnectionGUID: Zh7SXwxzSDGApOQVI1PEaA==
X-CSE-MsgGUID: dOmsupCHRj26g4y3dCcO8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81158596"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Oct 2024 00:29:47 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4ElV-000Xls-0h;
	Fri, 25 Oct 2024 07:29:45 +0000
Date: Fri, 25 Oct 2024 15:28:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 ad783b9f8e78572fff3b04b6caee7bea3821eea8
Message-ID: <202410251539.AcrAF6pi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: ad783b9f8e78572fff3b04b6caee7bea3821eea8  PCI/pwrctl: Abandon QCom WCN probe on pre-pwrseq device-trees

elapsed time: 2193m

configs tested: 99
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-13.3.0
alpha                  allyesconfig    gcc-13.3.0
alpha                     defconfig    gcc-13.3.0
arc                    allmodconfig    gcc-13.2.0
arc                     allnoconfig    gcc-13.2.0
arc                    allyesconfig    gcc-13.2.0
arc                       defconfig    gcc-13.2.0
arc         randconfig-001-20241025    gcc-13.2.0
arc         randconfig-002-20241025    gcc-13.2.0
arc              vdk_hs38_defconfig    gcc-13.2.0
arm                    allmodconfig    gcc-14.1.0
arm                     allnoconfig    clang-20
arm                    allyesconfig    gcc-14.1.0
arm               bcm2835_defconfig    clang-20
arm                       defconfig    clang-14
arm             imx_v4_v5_defconfig    clang-16
arm         randconfig-001-20241025    gcc-14.1.0
arm         randconfig-002-20241025    gcc-14.1.0
arm         randconfig-003-20241025    gcc-14.1.0
arm         randconfig-004-20241025    gcc-14.1.0
arm                 u8500_defconfig    gcc-14.1.0
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.1.0
arm64                     defconfig    gcc-14.1.0
arm64       randconfig-001-20241025    clang-16
arm64       randconfig-002-20241025    clang-14
arm64       randconfig-003-20241025    clang-20
arm64       randconfig-004-20241025    gcc-14.1.0
csky                    allnoconfig    gcc-14.1.0
csky                      defconfig    gcc-14.1.0
csky        randconfig-001-20241025    gcc-14.1.0
csky        randconfig-002-20241025    gcc-14.1.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    clang-20
hexagon                allyesconfig    clang-20
hexagon                   defconfig    clang-20
hexagon     randconfig-001-20241025    clang-20
hexagon     randconfig-002-20241025    clang-20
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch              allmodconfig    gcc-14.1.0
loongarch               allnoconfig    gcc-14.1.0
loongarch   randconfig-001-20241025    gcc-14.1.0
loongarch   randconfig-002-20241025    gcc-14.1.0
m68k                   allmodconfig    gcc-14.1.0
m68k                    allnoconfig    gcc-14.1.0
m68k                   allyesconfig    gcc-14.1.0
microblaze             allmodconfig    gcc-14.1.0
microblaze              allnoconfig    gcc-14.1.0
microblaze             allyesconfig    gcc-14.1.0
mips                    allnoconfig    gcc-14.1.0
mips             bmips_be_defconfig    gcc-14.1.0
mips                 ci20_defconfig    clang-20
nios2                   allnoconfig    gcc-14.1.0
nios2       randconfig-001-20241025    gcc-14.1.0
nios2       randconfig-002-20241025    gcc-14.1.0
openrisc                allnoconfig    gcc-14.1.0
openrisc               allyesconfig    gcc-14.1.0
openrisc                  defconfig    gcc-14.1.0
openrisc          or1ksim_defconfig    gcc-14.1.0
parisc                 allmodconfig    gcc-14.1.0
parisc                  allnoconfig    gcc-14.1.0
parisc                 allyesconfig    gcc-14.1.0
parisc                    defconfig    gcc-14.1.0
parisc      randconfig-001-20241025    gcc-14.1.0
parisc      randconfig-002-20241025    gcc-14.1.0
powerpc                allmodconfig    gcc-14.1.0
powerpc                 allnoconfig    gcc-14.1.0
powerpc     randconfig-003-20241025    clang-14
powerpc64   randconfig-001-20241025    clang-20
powerpc64   randconfig-002-20241025    gcc-14.1.0
powerpc64   randconfig-003-20241025    clang-20
riscv                   allnoconfig    gcc-14.1.0
riscv                  allyesconfig    clang-20
riscv       randconfig-001-20241025    gcc-14.1.0
riscv       randconfig-002-20241025    gcc-14.1.0
s390                   allmodconfig    clang-20
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.1.0
s390        randconfig-001-20241025    gcc-14.1.0
s390        randconfig-002-20241025    clang-20
sh                     allmodconfig    gcc-14.1.0
sh                      allnoconfig    gcc-14.1.0
sh                     allyesconfig    gcc-14.1.0
sh                        defconfig    gcc-14.1.0
sh          randconfig-001-20241025    gcc-14.1.0
sh          randconfig-002-20241025    gcc-14.1.0
sparc                  allmodconfig    gcc-14.1.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-18
x86_64                     rhel-8.3    gcc-12
xtensa                  allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

