Return-Path: <linux-pci+bounces-20125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CBFA163AB
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2805D3A492A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FC188A0E;
	Sun, 19 Jan 2025 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z79+36W/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980F42AB4
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737312478; cv=none; b=OplNN35aBF5akiLUJuYSCaMvceOZio5aCQtuAtmel+/zdrer9igGJc8mgJmnyRH+u8WPHOn3zex33flxb6U3PR1eyQ08+PytpGenqq2xkFNa4kgLiZhvjVLsj9YunZt6LH9FiLTe3Tru8ardWsr2f5ADuzD6RJd5907srOd/7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737312478; c=relaxed/simple;
	bh=rR8vDwFEvnFMcudJrWZqnin/gV80gpfK3g/hM08RZoI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W4QWHwiH8aWNReyU6ub3Zd+4O9iHjCM5hXK03Yg1cq8MAzEdic+Af4z+gyNdCphSGaxIKxJbdjeqs/B7P6SgS0Y9FuB9awNvB+Z0IkWGAsLYtJC0BB3IpCaRBsDvdnJSX7lcVsq64UnPdAblIr6CFXrq97RYukVR4sLo5gSBTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z79+36W/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737312477; x=1768848477;
  h=date:from:to:cc:subject:message-id;
  bh=rR8vDwFEvnFMcudJrWZqnin/gV80gpfK3g/hM08RZoI=;
  b=Z79+36W/EirbdGFFkbh7QWfZBB10EXdILUiclzAdoZoNWgTLUPGD24ys
   cbiNgDy9t/Ue//WPX8cw5i3WZJJh8wMMoxvw2srOudTlXyOPJIimAOrhi
   oWTLL7OQbcF8m+tiRetbOVWIp/3sQAVghQ7Nkamd2afSTPfS32E7gHhhi
   jFMe23ZvpNVirkX1t8OWe8o59oILySIy26eXgkLfq+YbwpDE9kxLILuIT
   MO7QG96hlvHtckBH4N2bT/0V1Fd2MbCVmY6bDwmlBXe2mrtv3e2MZo+l0
   oMYq/CP4ZMgGcYTiZ2iWS+Kz3ijGSWO2+uuP3htIRxzGYHnN6HxZ0BItj
   g==;
X-CSE-ConnectionGUID: 1SHEgL0ZSTiBZVONJVy0fQ==
X-CSE-MsgGUID: Ykz+njaoS5Ov3b5VT2pJeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="49071040"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="49071040"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 10:47:56 -0800
X-CSE-ConnectionGUID: 9lzweogxSIGizV7Cm03gtA==
X-CSE-MsgGUID: 9cKlgF7JQ663cW1Ozyxtrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="111260549"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Jan 2025 10:47:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZaKu-000Vih-15;
	Sun, 19 Jan 2025 18:47:52 +0000
Date: Mon, 20 Jan 2025 02:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 057524c9e88c9b9a9231860296d7ceb54a7f7da3
Message-ID: <202501200209.1KfPuj9C-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 057524c9e88c9b9a9231860296d7ceb54a7f7da3  PCI: imx6: Clean up comments and whitespace

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20250119
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
|-- arm64-randconfig-052-20250119
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
|-- arm64-randconfig-053-20250119
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
|-- arm64-randconfig-054-20250119
|   `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short
`-- arm64-randconfig-055-20250119
    `-- arch-arm64-boot-dts-freescale-imx95-19x19-evk.dtb:pcie-4c300000:clock-names:pcie-pcie_bus-pcie_phy-pcie_aux-is-too-short

elapsed time: 1224m

configs tested: 130
configs skipped: 5

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
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250119    gcc-13.2.0
arc                   randconfig-002-20250119    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                        multi_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250119    gcc-14.2.0
arm                   randconfig-002-20250119    clang-20
arm                   randconfig-003-20250119    clang-16
arm                   randconfig-004-20250119    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250119    clang-20
arm64                 randconfig-002-20250119    clang-20
arm64                 randconfig-003-20250119    gcc-14.2.0
arm64                 randconfig-004-20250119    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250119    gcc-14.2.0
csky                  randconfig-002-20250119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250119    clang-20
hexagon               randconfig-002-20250119    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250119    clang-19
i386        buildonly-randconfig-002-20250119    gcc-12
i386        buildonly-randconfig-003-20250119    gcc-12
i386        buildonly-randconfig-004-20250119    gcc-12
i386        buildonly-randconfig-005-20250119    clang-19
i386        buildonly-randconfig-006-20250119    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250119    gcc-14.2.0
loongarch             randconfig-002-20250119    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250119    gcc-14.2.0
nios2                 randconfig-002-20250119    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250119    gcc-14.2.0
parisc                randconfig-002-20250119    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    clang-20
powerpc               randconfig-001-20250119    clang-20
powerpc               randconfig-002-20250119    clang-20
powerpc               randconfig-003-20250119    clang-16
powerpc64             randconfig-001-20250119    clang-18
powerpc64             randconfig-002-20250119    clang-16
powerpc64             randconfig-003-20250119    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250119    gcc-14.2.0
riscv                 randconfig-002-20250119    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250119    clang-20
s390                  randconfig-002-20250119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250119    gcc-14.2.0
sh                    randconfig-002-20250119    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250119    gcc-14.2.0
sparc                 randconfig-002-20250119    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250119    gcc-14.2.0
sparc64               randconfig-002-20250119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250119    clang-18
um                    randconfig-002-20250119    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250119    clang-19
x86_64      buildonly-randconfig-002-20250119    gcc-12
x86_64      buildonly-randconfig-003-20250119    gcc-12
x86_64      buildonly-randconfig-004-20250119    clang-19
x86_64      buildonly-randconfig-005-20250119    gcc-12
x86_64      buildonly-randconfig-006-20250119    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250119    gcc-14.2.0
xtensa                randconfig-002-20250119    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

