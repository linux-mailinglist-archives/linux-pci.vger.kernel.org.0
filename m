Return-Path: <linux-pci+bounces-27852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C04AB9B3E
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63961BA3C5F
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2139C231846;
	Fri, 16 May 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZ0mMn/i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FCF2367D6
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395580; cv=none; b=TwlVC0BtSU0ChZdYBDD/4jRyC51RsqKxjjvk1DhbwPrN5DSNWq3u/cSukvWnw95SmmoaS8iycQ4/l/4Zt1QolD83pqJwSlSxBon15wiwQrTBkBRfzhnJp5JSbyChuWj2Q2vfXFF9IHm4tH35fHsn/ULZGL956NliacZhdZyLdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395580; c=relaxed/simple;
	bh=b38e987j7N/RdnnkLyjmhju1RU6ZGCvLSLTKjlVlq0U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rCpMS8GXOLDMxI3fve1WcJbCAessuzJWJFk+7ZGcWT1dOsqLWCTi4oNH0WwYTmO7/fWuAR738FmGdV8qnsb5kwMHaEmHcy++gSQvAV4eFa94xnVi2uElw6relo8KRWT8ow3dTeAS7E+S3AXVHWrV5uUFB2JyP0aGjzFHQ9S+lns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZ0mMn/i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747395578; x=1778931578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b38e987j7N/RdnnkLyjmhju1RU6ZGCvLSLTKjlVlq0U=;
  b=hZ0mMn/i/iPOR4SmVr13K6oVPkVwOPa0Pwuh713CbWkxfQX1MM0WRSv4
   LL58UISyPy2FbiF2tXWKRZwhfarkFPB7/wCz/1LNIhBtBIrSz133XtSjr
   DR7xaCW4PRtVYIt8KEenOQo0px9VqUL1RTXmQHezqAtdZixmFQyE6YtsB
   aPcXHgxk6gRHK18b9jIjbo0LpdJcwGdbBKxmwRbiFINJ+NqBoAxoKe2cB
   XQCz2herUWZMYVp6rpCHEVcjSRs3kvxZ9CWC3pkGNdKstoVM8OsxdTSE9
   +r+GWhqIlTXi45MyyiWY4bvh8Vo8YYG9rlvPtpWyyUhFHf36CVw5xvuNF
   A==;
X-CSE-ConnectionGUID: Y0czBnZ5QXShiudl3v7VEw==
X-CSE-MsgGUID: lVLepzxeTx+yWyTp12dx5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53036737"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53036737"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 04:39:37 -0700
X-CSE-ConnectionGUID: tbsDOwVGQYS08KgthjCfTw==
X-CSE-MsgGUID: 7QRs8rqcRhSvDK+0XOXc0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138714586"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 May 2025 04:39:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFtPa-000JId-0K;
	Fri, 16 May 2025 11:39:34 +0000
Date: Fri, 16 May 2025 19:38:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:slot-reset] BUILD REGRESSION
 ebf9d2fae99254fc37f49384b769f363e676018d
Message-ID: <202505161941.DgLuz14e-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git slot-reset
branch HEAD: ebf9d2fae99254fc37f49384b769f363e676018d  PCI: dw-rockchip: Add support for slot reset on link down event

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202505152337.AoKvnBmd-lkp@intel.com

    drivers/pci/controller/dwc/pcie-dw-rockchip.c:721:58: error: use of undeclared identifier 'PCIE_CLIENT_GENERAL_CON'
    drivers/pci/controller/dwc/pcie-dw-rockchip.c:721:65: error: 'PCIE_CLIENT_GENERAL_CON' undeclared (first use in this function); did you mean 'PCIE_CLIENT_GENERAL_CONTROL'?

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- alpha-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- arc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- arc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- arm64-randconfig-002-20250515
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON
|-- i386-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- i386-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- loongarch-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- microblaze-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- microblaze-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- mips-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- mips-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- openrisc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- parisc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- parisc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- powerpc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- powerpc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON
|-- riscv-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON
|-- riscv-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON
|-- s390-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON
|-- s390-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- sparc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:PCIE_CLIENT_GENERAL_CON-undeclared-(first-use-in-this-function)
|-- um-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON
|-- x86_64-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON
`-- x86_64-allyesconfig
    `-- drivers-pci-controller-dwc-pcie-dw-rockchip.c:error:use-of-undeclared-identifier-PCIE_CLIENT_GENERAL_CON

elapsed time: 1455m

configs tested: 124
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250515    gcc-12.4.0
arc                   randconfig-002-20250515    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                       aspeed_g4_defconfig    clang-21
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250515    clang-21
arm                   randconfig-002-20250515    gcc-8.5.0
arm                   randconfig-003-20250515    gcc-8.5.0
arm                   randconfig-004-20250515    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250515    clang-21
arm64                 randconfig-002-20250515    clang-21
arm64                 randconfig-003-20250515    clang-20
arm64                 randconfig-004-20250515    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250515    gcc-14.2.0
csky                  randconfig-002-20250515    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250515    clang-16
hexagon               randconfig-002-20250515    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-002-20250515    gcc-12
i386        buildonly-randconfig-003-20250515    clang-20
i386        buildonly-randconfig-004-20250515    clang-20
i386        buildonly-randconfig-005-20250515    gcc-12
i386        buildonly-randconfig-006-20250515    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250515    gcc-12.4.0
loongarch             randconfig-002-20250515    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-21
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250515    gcc-12.4.0
nios2                 randconfig-002-20250515    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250515    gcc-13.3.0
parisc                randconfig-002-20250515    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                   motionpro_defconfig    clang-21
powerpc               randconfig-001-20250515    gcc-8.5.0
powerpc               randconfig-002-20250515    gcc-6.5.0
powerpc               randconfig-003-20250515    clang-21
powerpc                     redwood_defconfig    clang-21
powerpc64             randconfig-001-20250515    clang-21
powerpc64             randconfig-002-20250515    gcc-8.5.0
powerpc64             randconfig-003-20250515    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-002-20250515    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-002-20250515    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-002-20250515    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250515    gcc-12
um                    randconfig-002-20250515    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250515    clang-20
x86_64      buildonly-randconfig-002-20250515    clang-20
x86_64      buildonly-randconfig-003-20250515    clang-20
x86_64      buildonly-randconfig-004-20250515    clang-20
x86_64      buildonly-randconfig-005-20250515    clang-20
x86_64      buildonly-randconfig-006-20250515    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-002-20250515    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

