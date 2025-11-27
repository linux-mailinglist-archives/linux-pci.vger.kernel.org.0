Return-Path: <linux-pci+bounces-42231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B129EC90506
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 23:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 876BB4E0F46
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC159315D23;
	Thu, 27 Nov 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om3JjTXA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AF296BBC
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284325; cv=none; b=DwR8/7ika4Ep9I6m+1XNWk+xtf5xPEu6YoErboY+C91/W3xfb43l2T4X2f3lIJiag5cuVpVbdSMEz6K8Kdf50DHqrZm5+ObuTYKmT02WKFiIgUk0lZYx51WBrSmS3Q7OfNud+6DWnA7PQjRGigHFnPaypikF1mMDXR7w5r7SH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284325; c=relaxed/simple;
	bh=osPt1OwYCeGRiDAFR+jC3NuwGq1YNO9rNjse/VJ9OX0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tnw6FY1NSR5qqj5CItSVHUQFGT1dQwNS67tOu/z32up8RU8nQrA7RX9tDf+sonTM6oaZdPDRunBNV9O2OhX8f54qXjd0lfodWJKEXTa0abKltNakxFgLySCl1KXEFGLPanlP+/1RpNFEZHP2XWqRcJKc10uiOMSURZIdTu9Rs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om3JjTXA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764284324; x=1795820324;
  h=date:from:to:cc:subject:message-id;
  bh=osPt1OwYCeGRiDAFR+jC3NuwGq1YNO9rNjse/VJ9OX0=;
  b=Om3JjTXAwZ5XteMiprgRaEPg8k2IE4PpV7ZiA58E1dNqDl+iiNLUg8Aw
   +JAU4Q18utE2T2HCehzgCEAo84ZMv6EG+PjdhYYEnVtbeE1eMWGjzii1V
   sBt7W+ON3ka4LH4rJTnKFBw9+fziFYrW9crU5UFQG7Kc2JNAY5SDelTjK
   +C/XbINkx0XXs6XS1O6nJotlLVYSnDADly/fESjGDvWSA/nmzkg77bFbx
   h+8CgYb3HkDU7dDPp3A3mmNOOQceEKpSb1WwbIzrPrGzwlFoggX5HCfcE
   G7ogF0jgfvXRutMdNkp5XtPNfuPuiQoJ4P23dTyWw/c7hbywdWXCZ/jTw
   A==;
X-CSE-ConnectionGUID: 7iwxDb9cRZeC2R3zb2yfQw==
X-CSE-MsgGUID: 1SNlsmvVT2+udAvJg6i56g==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66216260"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66216260"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 14:58:44 -0800
X-CSE-ConnectionGUID: TqJ0vEdeQXuq+hmR+TGn9g==
X-CSE-MsgGUID: kF7ENSaJQUu5nGk++8g+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="193769305"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Nov 2025 14:58:42 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOkwi-000000005oP-1LPC;
	Thu, 27 Nov 2025 22:58:40 +0000
Date: Fri, 28 Nov 2025 06:58:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/s32g] BUILD SUCCESS
 c7533471578ece15dd206585444446f8caa2d2f8
Message-ID: <202511280622.NEhtYDf7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/s32g
branch HEAD: c7533471578ece15dd206585444446f8caa2d2f8  MAINTAINERS: Add NXP S32G PCIe controller driver maintainer

elapsed time: 1463m

configs tested: 198
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251127    gcc-15.1.0
arc                   randconfig-001-20251128    gcc-8.5.0
arc                   randconfig-002-20251127    gcc-8.5.0
arc                   randconfig-002-20251128    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251127    clang-22
arm                   randconfig-001-20251128    gcc-8.5.0
arm                   randconfig-002-20251127    clang-22
arm                   randconfig-002-20251128    gcc-8.5.0
arm                   randconfig-003-20251127    clang-22
arm                   randconfig-003-20251128    gcc-8.5.0
arm                   randconfig-004-20251127    gcc-10.5.0
arm                   randconfig-004-20251128    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251128    gcc-15.1.0
arm64                 randconfig-002-20251128    gcc-15.1.0
arm64                 randconfig-003-20251128    gcc-15.1.0
arm64                 randconfig-004-20251128    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251128    gcc-15.1.0
csky                  randconfig-002-20251128    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251127    clang-22
hexagon               randconfig-001-20251128    clang-22
hexagon               randconfig-002-20251127    clang-18
hexagon               randconfig-002-20251128    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20251128    gcc-13
i386        buildonly-randconfig-002-20251128    gcc-13
i386        buildonly-randconfig-003-20251128    gcc-13
i386        buildonly-randconfig-004-20251128    gcc-13
i386        buildonly-randconfig-005-20251128    gcc-13
i386        buildonly-randconfig-006-20251128    gcc-13
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251128    gcc-14
i386                  randconfig-002-20251128    gcc-14
i386                  randconfig-003-20251128    gcc-14
i386                  randconfig-004-20251128    gcc-14
i386                  randconfig-005-20251128    gcc-14
i386                  randconfig-006-20251128    gcc-14
i386                  randconfig-007-20251128    gcc-14
i386                  randconfig-011-20251128    gcc-14
i386                  randconfig-012-20251128    gcc-14
i386                  randconfig-013-20251128    gcc-14
i386                  randconfig-014-20251128    gcc-14
i386                  randconfig-015-20251128    gcc-14
i386                  randconfig-016-20251128    gcc-14
i386                  randconfig-017-20251128    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251127    clang-22
loongarch             randconfig-001-20251128    clang-22
loongarch             randconfig-002-20251127    gcc-15.1.0
loongarch             randconfig-002-20251128    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      loongson1_defconfig    clang-18
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251127    gcc-8.5.0
nios2                 randconfig-001-20251128    clang-22
nios2                 randconfig-002-20251127    gcc-11.5.0
nios2                 randconfig-002-20251128    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251127    gcc-8.5.0
parisc                randconfig-001-20251128    clang-22
parisc                randconfig-002-20251127    gcc-15.1.0
parisc                randconfig-002-20251128    clang-22
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    clang-18
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    clang-18
powerpc                      pcm030_defconfig    clang-18
powerpc               randconfig-001-20251127    clang-22
powerpc               randconfig-001-20251128    clang-22
powerpc               randconfig-002-20251127    gcc-13.4.0
powerpc               randconfig-002-20251128    clang-22
powerpc                         wii_defconfig    clang-18
powerpc64             randconfig-001-20251127    clang-20
powerpc64             randconfig-001-20251128    clang-22
powerpc64             randconfig-002-20251127    gcc-14.3.0
powerpc64             randconfig-002-20251128    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251127    gcc-12.5.0
riscv                 randconfig-001-20251128    gcc-15.1.0
riscv                 randconfig-002-20251127    clang-22
riscv                 randconfig-002-20251128    gcc-15.1.0
s390                             alldefconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251127    gcc-11.5.0
s390                  randconfig-001-20251128    gcc-15.1.0
s390                  randconfig-002-20251127    clang-22
s390                  randconfig-002-20251128    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251127    gcc-15.1.0
sh                    randconfig-001-20251128    gcc-15.1.0
sh                    randconfig-002-20251127    gcc-12.5.0
sh                    randconfig-002-20251128    gcc-15.1.0
sh                          sdk7780_defconfig    clang-18
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251127    gcc-13.4.0
sparc                 randconfig-001-20251128    clang-22
sparc                 randconfig-002-20251127    gcc-11.5.0
sparc                 randconfig-002-20251128    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251127    gcc-15.1.0
sparc64               randconfig-001-20251128    clang-22
sparc64               randconfig-002-20251128    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251127    gcc-14
um                    randconfig-001-20251128    clang-22
um                    randconfig-002-20251127    clang-22
um                    randconfig-002-20251128    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20251128    clang-20
x86_64      buildonly-randconfig-002-20251128    clang-20
x86_64      buildonly-randconfig-003-20251128    clang-20
x86_64      buildonly-randconfig-004-20251128    clang-20
x86_64      buildonly-randconfig-005-20251128    clang-20
x86_64      buildonly-randconfig-006-20251128    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251128    gcc-14
x86_64                randconfig-002-20251128    gcc-14
x86_64                randconfig-003-20251128    gcc-14
x86_64                randconfig-004-20251128    gcc-14
x86_64                randconfig-005-20251128    gcc-14
x86_64                randconfig-006-20251128    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251127    gcc-11.5.0
xtensa                randconfig-001-20251128    clang-22
xtensa                randconfig-002-20251127    gcc-10.5.0
xtensa                randconfig-002-20251128    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

