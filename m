Return-Path: <linux-pci+bounces-19945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68BDA132DC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 06:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCF01881746
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFC141987;
	Thu, 16 Jan 2025 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYCemNNo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972E18DF60
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737007096; cv=none; b=fvWDDWTpDUQFqAfxgLUsLbI+TjjxHS8RW/X/HblryjUaXLVzNdrG4rA0EDFrdTjhywmZDtc5tTbqbZhshSaGHt7X8i5tVtcYoUnWK+qzUX89KhTkogL5MOx5817IpPmHY2fJ/uVdISmeoOBefhAf85kjz/9bZTg8fNtdlYOv7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737007096; c=relaxed/simple;
	bh=evKJg0Vs95UDB2MXrpIGHvXlAayPJ+Tiea1A0sfVsCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nIydL57h5WvLHgx1GaqZeiuK5MkiFzXAmRaQM283fES+255+hMTkXCg0tXOMJ95vxu1rIwBNQd7AQqZqlMc7etq8OeAZpuigMpz1d0QlKs77LjlbCdUnV17y4yZ2d7SG9n3kCyjC1z9d/Eta74tCWi1Wbzd6OBx+1DMGkC1HzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYCemNNo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737007095; x=1768543095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=evKJg0Vs95UDB2MXrpIGHvXlAayPJ+Tiea1A0sfVsCo=;
  b=fYCemNNoSqvRtwvFbd8eSl8+jBA2+M7toIuE+GF0ToXrKBynLpXDTawg
   a8nkGz/v0lH64IYwnUdPuBkFYTUUjv4DCENfP6M+hBWWB8tv/5uMPaUpU
   +O/Zg7c9Y5LTl4KyPvPOU/NIWGhckwKSc1HmuWFu+qKLzbLdW6VkIyLoF
   KyrMSvBgUSAcoPNvH3tuwnMIMSgtTjnGR+4oUCAZ3WLU0cx9QjYWGTEzJ
   6nlNc7WVlmAJ7caLS0xsfywTiYODFUoRfMo1EPKuORhMHHv2GV8/oaJ1j
   PEI9uOR7DtleX3qaUfnD8Ioo9acE3SPYTnywpfAovEMFONXtShhFzT6Mk
   w==;
X-CSE-ConnectionGUID: NVOrUGCzT9CWSxdNGIdxGA==
X-CSE-MsgGUID: TtB/rL4oTYaRbLjL94Z2JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37608873"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="37608873"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 21:58:14 -0800
X-CSE-ConnectionGUID: J+Dwxt3dToCWO6HOtBohPw==
X-CSE-MsgGUID: +FaV/GtGSeGjlsCpIC8sFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106247541"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Jan 2025 21:58:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYItO-000RSx-1p;
	Thu, 16 Jan 2025 05:58:10 +0000
Date: Thu, 16 Jan 2025 13:57:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pci-sysfs] BUILD SUCCESS
 2d54d23c604dc117a2bd99f90353ab761e209384
Message-ID: <202501161321.Np47OdKF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-sysfs
branch HEAD: 2d54d23c604dc117a2bd99f90353ab761e209384  PCI/sysfs: Remove unnecessary zero in initializer

elapsed time: 1454m

configs tested: 114
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250115    gcc-13.2.0
arc                   randconfig-002-20250115    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-20
arm                          exynos_defconfig    clang-20
arm                            mmp2_defconfig    gcc-14.2.0
arm                             mxs_defconfig    clang-20
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20250115    clang-16
arm                   randconfig-002-20250115    clang-20
arm                   randconfig-003-20250115    clang-20
arm                   randconfig-004-20250115    clang-20
arm                         s3c6400_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250115    clang-20
arm64                 randconfig-002-20250115    gcc-14.2.0
arm64                 randconfig-003-20250115    clang-18
arm64                 randconfig-004-20250115    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250115    gcc-14.2.0
csky                  randconfig-002-20250115    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250115    clang-20
hexagon               randconfig-002-20250115    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250115    clang-19
i386        buildonly-randconfig-002-20250115    gcc-12
i386        buildonly-randconfig-003-20250115    gcc-12
i386        buildonly-randconfig-004-20250115    gcc-12
i386        buildonly-randconfig-005-20250115    gcc-12
i386        buildonly-randconfig-006-20250115    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250115    gcc-14.2.0
loongarch             randconfig-002-20250115    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250115    gcc-14.2.0
nios2                 randconfig-002-20250115    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250115    gcc-14.2.0
parisc                randconfig-002-20250115    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-17
powerpc               randconfig-001-20250115    gcc-14.2.0
powerpc               randconfig-002-20250115    gcc-14.2.0
powerpc               randconfig-003-20250115    gcc-14.2.0
powerpc64             randconfig-001-20250115    gcc-14.2.0
powerpc64             randconfig-002-20250115    gcc-14.2.0
powerpc64             randconfig-003-20250115    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250115    gcc-14.2.0
riscv                 randconfig-002-20250115    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250115    clang-20
s390                  randconfig-002-20250115    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250115    gcc-14.2.0
sh                    randconfig-002-20250115    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250115    gcc-14.2.0
sparc                 randconfig-002-20250115    gcc-14.2.0
sparc64               randconfig-001-20250115    gcc-14.2.0
sparc64               randconfig-002-20250115    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250115    clang-18
um                    randconfig-002-20250115    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250115    gcc-12
x86_64      buildonly-randconfig-002-20250115    gcc-12
x86_64      buildonly-randconfig-003-20250115    clang-19
x86_64      buildonly-randconfig-004-20250115    clang-19
x86_64      buildonly-randconfig-005-20250115    gcc-12
x86_64      buildonly-randconfig-006-20250115    clang-19
x86_64                              defconfig    gcc-11
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250115    gcc-14.2.0
xtensa                randconfig-002-20250115    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

