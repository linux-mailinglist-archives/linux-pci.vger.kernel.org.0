Return-Path: <linux-pci+bounces-20173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D331CA17978
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 09:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA03AB505
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB631DEFE2;
	Tue, 21 Jan 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcL6XBAP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B41C07F1
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449127; cv=none; b=beTq7wvzAc/lYgeS/0p7bdKQimgXfMqIaZELkcYH4SRvMdHku5X/VWI50J/AQJSNFPyP28HhRs75U1XR/+9D6FuO8vkWj/cxrF9R3ALjZc2Bj2z1hhwZUEvjf77edFiOvI9iePIcKTGfAjcmwfxLoGiNBRglHT/wZwoZBErb8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449127; c=relaxed/simple;
	bh=5Qq11hBuoHnsXvksvSWFRdWfLV550bui7BweL789nJI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Paso7f9ojlfCxNbvv91U+LQrT2Jxma2m5ZkRqirehx6LM3a5raelObNoLkxF8DTO4G4q8UIG6y47sAIRmdgMrCPkLISBeKASekUPnF94PSz2MWJ4J8vNgRFiYpLLRq7l71z3Zt/zk5wFiDS6aQkgt4Gr+qOOXuYpZVR5Kjh8T1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcL6XBAP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737449125; x=1768985125;
  h=date:from:to:cc:subject:message-id;
  bh=5Qq11hBuoHnsXvksvSWFRdWfLV550bui7BweL789nJI=;
  b=gcL6XBAPIxRdo+ihwXsWbRRDERVKpnF5kFtzKTAT8bl3SfnTLD2MFDAB
   C3fnnwrPQW3x6Z9Vao6izCz9b2tjhdzEXjy/8JFAIVNWR8kuwypAQhbrT
   KiE+E6NSgNaWtvi7AE6cOljl4aHbAxmIaZ6RDP28OjHIOpw8lBDr+sh07
   qe71SMT9CmzsgY5h1FQbvfAbjn40WYNpT1NieWAdlnq8j8S1gMikv/tZo
   Up/h+Rpjmwm/7J6zGkMGZrE7C27/i2j3imH86y7ZuPMlBBAj8hZ+OCMy+
   AmF9Vk/XoBXWW+a3mIuCuoPyRD1JWjgsgap0g2WgNV/bO7Vq1SeChoKCj
   g==;
X-CSE-ConnectionGUID: A3icYZqfQJaRiAscsqwUoA==
X-CSE-MsgGUID: hh4n/CTRRo2yRKAziMRPtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48345013"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="48345013"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 00:45:25 -0800
X-CSE-ConnectionGUID: r5n9oz+YR9OdQNyf7YDC+w==
X-CSE-MsgGUID: p+E0te6gS8y5bxubxx1cXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="106541496"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Jan 2025 00:45:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ta9sw-000XrB-08;
	Tue, 21 Jan 2025 08:45:22 +0000
Date: Tue, 21 Jan 2025 16:45:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 b881532991f81f5e3a069fe6d1a3e091400042b5
Message-ID: <202501211606.oEZrZ9ux-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: b881532991f81f5e3a069fe6d1a3e091400042b5  PCI: imx6: Clean up comments and whitespace

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20250121
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
|-- arm64-randconfig-052-20250121
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
|-- arm64-randconfig-053-20250121
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
|-- arm64-randconfig-054-20250121
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
`-- arm64-randconfig-055-20250121
    `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short

elapsed time: 802m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250121    gcc-13.2.0
arc                   randconfig-002-20250121    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                           imxrt_defconfig    clang-19
arm                   randconfig-001-20250121    clang-18
arm                   randconfig-002-20250121    gcc-14.2.0
arm                   randconfig-003-20250121    gcc-14.2.0
arm                   randconfig-004-20250121    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250121    gcc-14.2.0
arm64                 randconfig-002-20250121    gcc-14.2.0
arm64                 randconfig-003-20250121    gcc-14.2.0
arm64                 randconfig-004-20250121    clang-18
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250121    gcc-14.2.0
csky                  randconfig-002-20250121    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250121    clang-19
hexagon               randconfig-002-20250121    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250121    gcc-12
i386        buildonly-randconfig-002-20250121    clang-19
i386        buildonly-randconfig-003-20250121    gcc-12
i386        buildonly-randconfig-004-20250121    gcc-12
i386        buildonly-randconfig-005-20250121    gcc-12
i386        buildonly-randconfig-006-20250121    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250121    gcc-14.2.0
loongarch             randconfig-002-20250121    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250121    gcc-14.2.0
nios2                 randconfig-002-20250121    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250121    gcc-14.2.0
parisc                randconfig-002-20250121    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250121    clang-20
powerpc               randconfig-002-20250121    gcc-14.2.0
powerpc               randconfig-003-20250121    gcc-14.2.0
powerpc                     tqm8541_defconfig    clang-15
powerpc64             randconfig-001-20250121    gcc-14.2.0
powerpc64             randconfig-002-20250121    clang-20
powerpc64             randconfig-003-20250121    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250121    gcc-14.2.0
riscv                 randconfig-002-20250121    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250121    clang-15
s390                  randconfig-002-20250121    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250121    gcc-14.2.0
sh                    randconfig-002-20250121    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250121    gcc-14.2.0
sparc                 randconfig-002-20250121    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250121    gcc-14.2.0
sparc64               randconfig-002-20250121    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250121    clang-16
um                    randconfig-002-20250121    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250121    gcc-12
x86_64      buildonly-randconfig-002-20250121    clang-19
x86_64      buildonly-randconfig-003-20250121    gcc-12
x86_64      buildonly-randconfig-004-20250121    clang-19
x86_64      buildonly-randconfig-005-20250121    clang-19
x86_64      buildonly-randconfig-006-20250121    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250121    gcc-14.2.0
xtensa                randconfig-002-20250121    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

