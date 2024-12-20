Return-Path: <linux-pci+bounces-18922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C5C9F9B1C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 21:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219737A0407
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD22219A69;
	Fri, 20 Dec 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bb/UFE47"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20D19DF47
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734726194; cv=none; b=WSjOSI8ITiFk+5Sfp6CNZJ8hroqwcrfaHB4QKzgfBUgCFyIFy8Gy4dUVAVXmsLIDHwlkh22/j8fqXNwaLhHObb74nzCi1rVoF8UeRIwpMZ8QEQtDXpPqdVDgVqqC2LflPSHrkdXOW86NNk6f4ftLsh4zCqt6NgiCgqIWQkWG0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734726194; c=relaxed/simple;
	bh=qaRS0iKJcy5yozyujJ5l7/aK/sirbnANk2q/dwrh40Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bcDdbf6EewOLlU7nTVoTAqf9rrkzTSLHJ705qjjSjc5ip98jUoAcufGXbC2lEnIrhNV3MJ5PnuSsABeXziSnMGpu4M933h6wVAnyCF5we9sV6Gag2+aDhohhBjBMme4DmMmDluikqbviR2m/+T/psLEdL/6Lk0WRcl+QUrnI2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bb/UFE47; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734726193; x=1766262193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qaRS0iKJcy5yozyujJ5l7/aK/sirbnANk2q/dwrh40Q=;
  b=Bb/UFE47pziSvIsIyB82/1kysqIibbFEqlDdZItGC1WyuRmdyxBdjNR8
   lz9QqJ0HiZj3i6ioZi2SwqLY9Bv7WLyRL4b/DECa5oOjKQluU/yymYd7K
   pmnbnIfCTcWrlUfQgv2b3G9jGdNbAr33s2ec53j9veZOp5oFWNZRHjxvQ
   UJoBZGskOKO06Hyp131OhgdQZ+kiMK/Evo54XuVEQw/lhISGe5UElF4cc
   03XCtWZA/j0rTYM5wVoZxUuxeQBr+K1YP549MFi927gxqlmjHF8oCOuN0
   jdgkC0EfA7Xu0pT6fvLQPzxd+Y36fGLDFaoSkNmtY+uZFjGI5A03aYnO4
   Q==;
X-CSE-ConnectionGUID: CfD/bxuAS/S/QnbzOZF05Q==
X-CSE-MsgGUID: 8ZbRegcdSxa3Z3xkPUdlIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35430968"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35430968"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:23:12 -0800
X-CSE-ConnectionGUID: QeXehuVXQBO2XhSvET8qyw==
X-CSE-MsgGUID: G2P2Da3PR6OzNZwnSYjgqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98664752"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Dec 2024 12:23:12 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOjWf-0001ek-1p;
	Fri, 20 Dec 2024 20:23:09 +0000
Date: Sat, 21 Dec 2024 04:22:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 0d0a2b74dc080d89e75c782e7f243a01e7755c07
Message-ID: <202412210448.zjLz9do4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 0d0a2b74dc080d89e75c782e7f243a01e7755c07  PCI: mediatek-gen3: Avoid PCIe resetting via PCIE_RSTB for Airoha EN7581 SoC

elapsed time: 1447m

configs tested: 75
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                              defconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                                defconfig    gcc-13.2.0
arc                  randconfig-001-20241220    gcc-13.2.0
arc                  randconfig-002-20241220    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                          omap1_defconfig    gcc-14.2.0
arm                  randconfig-001-20241220    clang-19
arm                  randconfig-002-20241220    gcc-14.2.0
arm                  randconfig-003-20241220    gcc-14.2.0
arm                  randconfig-004-20241220    clang-20
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20241220    clang-17
arm64                randconfig-002-20241220    clang-19
arm64                randconfig-003-20241220    clang-20
arm64                randconfig-004-20241220    clang-19
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20241220    gcc-14.2.0
csky                 randconfig-002-20241220    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20241220    clang-20
hexagon              randconfig-002-20241220    clang-20
i386       buildonly-randconfig-001-20241220    gcc-12
i386       buildonly-randconfig-002-20241220    gcc-12
i386       buildonly-randconfig-003-20241220    gcc-12
i386       buildonly-randconfig-004-20241220    clang-19
i386       buildonly-randconfig-005-20241220    gcc-12
i386       buildonly-randconfig-006-20241220    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20241220    gcc-14.2.0
loongarch            randconfig-002-20241220    gcc-14.2.0
m68k                       stmark2_defconfig    gcc-14.2.0
nios2                randconfig-001-20241220    gcc-14.2.0
nios2                randconfig-002-20241220    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20241220    gcc-14.2.0
parisc               randconfig-002-20241220    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20241220    clang-15
powerpc              randconfig-002-20241220    gcc-14.2.0
powerpc              randconfig-003-20241220    gcc-14.2.0
powerpc64            randconfig-001-20241220    gcc-14.2.0
powerpc64            randconfig-002-20241220    clang-19
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241220    gcc-14.2.0
riscv                randconfig-002-20241220    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241220    gcc-14.2.0
s390                 randconfig-002-20241220    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241220    gcc-14.2.0
sh                   randconfig-002-20241220    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241220    gcc-14.2.0
sparc                randconfig-002-20241220    gcc-14.2.0
sparc64              randconfig-001-20241220    gcc-14.2.0
sparc64              randconfig-002-20241220    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241220    clang-20
um                   randconfig-002-20241220    clang-20
x86_64     buildonly-randconfig-001-20241220    gcc-12
x86_64     buildonly-randconfig-002-20241220    clang-19
x86_64     buildonly-randconfig-003-20241220    gcc-12
x86_64     buildonly-randconfig-004-20241220    gcc-12
x86_64     buildonly-randconfig-005-20241220    clang-19
x86_64     buildonly-randconfig-006-20241220    gcc-12
xtensa               randconfig-001-20241220    gcc-14.2.0
xtensa               randconfig-002-20241220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

