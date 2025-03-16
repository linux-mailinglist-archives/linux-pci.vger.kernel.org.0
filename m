Return-Path: <linux-pci+bounces-23895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42ECA636FE
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 19:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B251885221
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35614A4F0;
	Sun, 16 Mar 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KG07WuUw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D61C8602
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149743; cv=none; b=hue9uoSDZTh7eTSrMwWuxiai0HVXMwxPsQz1JGgCox81rXN7cdfZOSx/H/QfHcnEPT+Fa5Q/7FqELY/Og3AccZZQ/vLeN9wZpUwXOKEU4IvM68MmYbVLTuFPEwLrLwDvzcp1anAHOjPh5hl+Xf3yRIWe0jlrZmfbVaApGrlYORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149743; c=relaxed/simple;
	bh=jrPaAvmeyfHZjT5WfqoBYSjAOxa0h9sf1zKafamAwG4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C+eKr7vJDBtNaQftEl7ZparBwHVgWyJxR4m68oYdUBauPmCdDQ8NtRbp3dHFO/3mNrbpdk/B8jiv2TSboNyIJeENbLxo45kn5iLscsWcFNVTIMtGTVx0A87mgcOSGXdf+V/+wQRrmhFrVjA+yB8ySz/BgNER7TwnvZ6seNB7NjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KG07WuUw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742149742; x=1773685742;
  h=date:from:to:cc:subject:message-id;
  bh=jrPaAvmeyfHZjT5WfqoBYSjAOxa0h9sf1zKafamAwG4=;
  b=KG07WuUwvmynvv1on2xYxeBGLMtUbJ5IdqsXVu2EQTvoRcoEGcqtJhor
   SHCJzd3Syc4TVSzmJYjRUtZBTiRLbTcwpppSg8cAOEOIPm93wHsorCeTG
   X9Xz0zbi+VuNTPAxVI3+r6g9SZ/s85siHtGyU1GGww2F/1Y9RDT1Nm28h
   y8bXLX0pACcOj8h4IJWjeXSgBkcj1lxUnw18ApnQ2OpQoyeMjvu7rmTS4
   9M9hkhtbO+kEWcnnYufg4biNGCbHZotalPpY3FXD/Rbjq9N1l/NHKTBM4
   cTHf/4bxqoBop8D9LLxLrBZ2xtDTK7r79cm+c4g/ajTyOn2JFF96zGcZB
   g==;
X-CSE-ConnectionGUID: uGBQeoXhQgONmqfTKy+EBw==
X-CSE-MsgGUID: gLKPod5URf2niegdb5+Z3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="53452106"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="53452106"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 11:29:02 -0700
X-CSE-ConnectionGUID: BtR4foIcQsys5C7IsP1D2w==
X-CSE-MsgGUID: jsp2X0F3SJe7H3Vx8cRZcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="121462425"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Mar 2025 11:29:01 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttsjJ-000CAR-2h;
	Sun, 16 Mar 2025 18:28:57 +0000
Date: Mon, 17 Mar 2025 02:28:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 f6a1fdfc78e203d2f7ccb9b34c00e5f0ac3d3a74
Message-ID: <202503170211.dAvTr0ge-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: f6a1fdfc78e203d2f7ccb9b34c00e5f0ac3d3a74  PCI: imx6: Use devm_clk_bulk_get_all() to fetch clocks

elapsed time: 1447m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250316    gcc-13.2.0
arc                   randconfig-002-20250316    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                            mmp2_defconfig    gcc-14.2.0
arm                             mxs_defconfig    clang-15
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250316    clang-15
arm                   randconfig-002-20250316    gcc-14.2.0
arm                   randconfig-003-20250316    gcc-14.2.0
arm                   randconfig-004-20250316    clang-21
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250316    clang-17
arm64                 randconfig-002-20250316    clang-19
arm64                 randconfig-003-20250316    clang-21
arm64                 randconfig-004-20250316    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250316    gcc-14.2.0
csky                  randconfig-002-20250316    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250316    clang-21
hexagon               randconfig-002-20250316    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250316    clang-19
i386        buildonly-randconfig-002-20250316    clang-19
i386        buildonly-randconfig-003-20250316    gcc-12
i386        buildonly-randconfig-004-20250316    clang-19
i386        buildonly-randconfig-005-20250316    clang-19
i386        buildonly-randconfig-006-20250316    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250316    gcc-14.2.0
loongarch             randconfig-002-20250316    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250316    gcc-14.2.0
nios2                 randconfig-002-20250316    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250316    gcc-14.2.0
parisc                randconfig-002-20250316    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               randconfig-001-20250316    gcc-14.2.0
powerpc               randconfig-002-20250316    gcc-14.2.0
powerpc               randconfig-003-20250316    clang-15
powerpc64             randconfig-001-20250316    clang-21
powerpc64             randconfig-002-20250316    clang-19
powerpc64             randconfig-003-20250316    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250316    clang-21
riscv                 randconfig-002-20250316    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250316    gcc-14.2.0
s390                  randconfig-002-20250316    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250316    gcc-14.2.0
sh                    randconfig-002-20250316    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250316    gcc-14.2.0
sparc                 randconfig-002-20250316    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250316    gcc-14.2.0
sparc64               randconfig-002-20250316    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250316    clang-21
um                    randconfig-002-20250316    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250316    gcc-12
x86_64      buildonly-randconfig-002-20250316    gcc-12
x86_64      buildonly-randconfig-003-20250316    clang-19
x86_64      buildonly-randconfig-004-20250316    clang-19
x86_64      buildonly-randconfig-005-20250316    gcc-12
x86_64      buildonly-randconfig-006-20250316    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250316    gcc-14.2.0
xtensa                randconfig-002-20250316    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

