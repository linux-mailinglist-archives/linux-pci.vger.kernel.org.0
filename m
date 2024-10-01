Return-Path: <linux-pci+bounces-13675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81F98B981
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4071F23660
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26F23209;
	Tue,  1 Oct 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT/l2yBC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12681A00ED
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778189; cv=none; b=odYP5e8Y8R22DjxpIMEdXLcyGwbSL3nZ6xZzDKXx+1G1hGmw2RGogT70Pz1N8O/xnKIhj+yGJHhpnZjaSbRQHPAa26+9cMWypRZXkRmJaC2lePZEPR543c0qXHknov8jfeTtXDRvSCSUo8rlPEwXTzxALXXhZb5sxSQ62nnEX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778189; c=relaxed/simple;
	bh=cLcrA8FUvd+iuW6dhS2QGJv7pDDAD2zX6gPODoQq7H4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jhi2skl1/B7hf1KkgMVZ7PZYJrfqDgG4mcc9TFONJXx4HrviVp54NMbdrQSbHh10LPTpEzKaTIN6AZuy6ardxMVFe3wn2mLzopETkST7A1yx1Pitnc1jq4Hcmu83CEcoKBOZ/M4KvRDz3rTSXU2cvLhp9OEBuFtl1shYu2Na4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZT/l2yBC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727778188; x=1759314188;
  h=date:from:to:cc:subject:message-id;
  bh=cLcrA8FUvd+iuW6dhS2QGJv7pDDAD2zX6gPODoQq7H4=;
  b=ZT/l2yBCFRWape8qTm3IvGWwOi/MpcToi6diQqOH4HyYalWdlMLQwSel
   9SjMa+0U7aOOfCX6kDjnX9TAsKoo5pomSPOhx7lopOSYGsohXeCzt+cdI
   gCjZsHorBltmCT00mma5SIzACinKKI/oA/LH+HnFCCo7Mdeju1AstA1Ln
   9lZt6ggQFV1NC1NQ6/HBCEI3f89UIpVwUc2HXQxyAY6iTRvAlrN6ojaT7
   V8fGWgM5A8IOLsBkoPoBMKrroOWPZf3y96OPLaUpAupp7kxPxZHq/dg0p
   TUnh58SlK9BHtezNwNtV8wowSLl8/PnmTDnTHBSioNDunTqd6d/ynBM/e
   w==;
X-CSE-ConnectionGUID: docSv3HaRkqCq/7kqR3baQ==
X-CSE-MsgGUID: pmLW1xmKR82cjSenTufKSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30697714"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="30697714"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 03:23:07 -0700
X-CSE-ConnectionGUID: NBVBeOAPTeuFC4F/TW1yIA==
X-CSE-MsgGUID: hB1FhZDjSKC3AjugtzplKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="77672788"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2024 03:23:06 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sva24-000QXV-0w;
	Tue, 01 Oct 2024 10:23:04 +0000
Date: Tue, 01 Oct 2024 18:22:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/remove] BUILD SUCCESS
 64595530e8ebd4db9fdeec13e5495ac31b6aff4b
Message-ID: <202410011816.TGPoBYGZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/remove
branch HEAD: 64595530e8ebd4db9fdeec13e5495ac31b6aff4b  PCI: controller: Switch back to struct platform_driver::remove()

elapsed time: 843m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.1.0
alpha                      allyesconfig    clang-20
arc                        allmodconfig    clang-20
arc                         allnoconfig    gcc-14.1.0
arc                        allyesconfig    clang-20
arc                    axs103_defconfig    gcc-14.1.0
arm                        allmodconfig    clang-20
arm                         allnoconfig    gcc-14.1.0
arm                        allyesconfig    clang-20
arm                    collie_defconfig    gcc-14.1.0
arm               davinci_all_defconfig    gcc-14.1.0
arm                   lpc18xx_defconfig    gcc-14.1.0
arm                 versatile_defconfig    gcc-14.1.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.1.0
csky                        allnoconfig    gcc-14.1.0
hexagon                    allmodconfig    clang-20
hexagon                     allnoconfig    gcc-14.1.0
hexagon                    allyesconfig    clang-20
i386                       allmodconfig    clang-18
i386                        allnoconfig    clang-18
i386                       allyesconfig    clang-18
i386                          defconfig    clang-18
loongarch                  allmodconfig    gcc-14.1.0
loongarch                   allnoconfig    gcc-14.1.0
m68k                       allmodconfig    gcc-14.1.0
m68k                        allnoconfig    gcc-14.1.0
m68k                       allyesconfig    gcc-14.1.0
microblaze                 allmodconfig    gcc-14.1.0
microblaze                  allnoconfig    gcc-14.1.0
microblaze                 allyesconfig    gcc-14.1.0
mips                        allnoconfig    gcc-14.1.0
mips                   db1xxx_defconfig    gcc-14.1.0
mips                     rs90_defconfig    gcc-14.1.0
nios2                       allnoconfig    gcc-14.1.0
openrisc                    allnoconfig    clang-20
openrisc                   allyesconfig    gcc-14.1.0
openrisc                      defconfig    gcc-12
openrisc            or1klitex_defconfig    gcc-14.1.0
parisc                     allmodconfig    gcc-14.1.0
parisc                      allnoconfig    clang-20
parisc                     allyesconfig    gcc-14.1.0
parisc                        defconfig    gcc-12
powerpc                    allmodconfig    gcc-14.1.0
powerpc                     allnoconfig    clang-20
powerpc                    allyesconfig    gcc-14.1.0
powerpc           canyonlands_defconfig    gcc-14.1.0
powerpc                  cell_defconfig    gcc-14.1.0
powerpc                  fsp2_defconfig    gcc-14.1.0
powerpc         mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                   wii_defconfig    gcc-14.1.0
riscv                      allmodconfig    gcc-14.1.0
riscv                       allnoconfig    clang-20
riscv                      allyesconfig    gcc-14.1.0
riscv                         defconfig    gcc-12
s390                       allmodconfig    clang-20
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.1.0
s390                          defconfig    gcc-12
sh                         alldefconfig    gcc-14.1.0
sh                         allmodconfig    gcc-14.1.0
sh                          allnoconfig    gcc-14.1.0
sh                         allyesconfig    gcc-14.1.0
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    gcc-14.1.0
sh                      titan_defconfig    gcc-14.1.0
sh                        ul2_defconfig    gcc-14.1.0
sparc                      allmodconfig    gcc-14.1.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-18
x86_64                     allyesconfig    clang-18
x86_64                        defconfig    clang-18
x86_64                    rhel-8.3-rust    clang-18
xtensa                      allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

