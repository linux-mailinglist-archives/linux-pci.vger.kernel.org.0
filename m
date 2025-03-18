Return-Path: <linux-pci+bounces-24062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE6A67E04
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 21:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713F3188D0FC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23E1DED5D;
	Tue, 18 Mar 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJqGko/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7D1DE4FE
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329739; cv=none; b=Wv/ru1RBXz532EER3Wm9/fIctCKlTJEwIXv2mF5KfrBwu+PCQL/5SYcuI/I+eOuv6wp2AfeJSlhrxhjOCH3x0Y+wO/KEzetYCwYp/7rcqDJxKY1F5Y5OKxMm3iQegRSZFyFgmLAcOmygicCFWOgSiKn9O4qEOXRp32FXZ6DO0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329739; c=relaxed/simple;
	bh=z3SwAzygq2jSUcYnwqKx9b+QxuvI4Z047qYhYaSz97o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ew/8FjSTVpcPheKHaDaBsoVOe2yRE74WxtweUTZI2aI7yhUiZl6mHzjF5mNISR02/uB9bZ8+B9O2DvcK39NnDmWMO43eo0l+qBqgBhY6GnkrUx/C0K41UcbZ5s1ssRdPigCRkMzBr+4qyXH6saKhydLVl2bcuwKhMSMYt5pCPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJqGko/f; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742329737; x=1773865737;
  h=date:from:to:cc:subject:message-id;
  bh=z3SwAzygq2jSUcYnwqKx9b+QxuvI4Z047qYhYaSz97o=;
  b=AJqGko/fEDgzcypCsUe9TpYb++8+UrxQZWDu0rEdX2WJlrpMkQXHJ5sJ
   PDuNJ2q6WOmqy/UMGCuQX7XGdjpvehB1SjW46Sfc3z0GTUYOUGfVk59D6
   PrYNYqFU++PPdnW8qQneXCW+B8TmEkw3CItobOqiWyn6jozdxmkjA0cbz
   aEn3Q0zGLIbUDPDZAYYjKCaoQgW39bDglLhfUO1SKtv5Tp763Fg5FDVhl
   gIymM4dFJn/E34oyTb0Zk6mATVuTjgKxEjGbjb5Tr+7gKBkcajQV9/qJa
   8oXCFBfBp4qumy2SVfySJ/6aIJZbnk61gYWaU8zsjiExpG+Ngy0N4ZW0m
   w==;
X-CSE-ConnectionGUID: o6hufzjPTtKl1Pfjld4ATQ==
X-CSE-MsgGUID: NRBnllyMSKCpJ8uQWP6uHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43595012"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43595012"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:28:56 -0700
X-CSE-ConnectionGUID: oEdFirUARnWlBfar5vEh1A==
X-CSE-MsgGUID: Z0rbKoSlRKef5QVRqwf2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127562953"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 13:28:56 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tudWQ-000EA2-28;
	Tue, 18 Mar 2025 20:27:08 +0000
Date: Wed, 19 Mar 2025 04:25:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 34f2ddfdaee9c1c18959de11f99c83929bf4532a
Message-ID: <202503190423.P918fz4J-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 34f2ddfdaee9c1c18959de11f99c83929bf4532a  Merge branch 'pci/misc'

elapsed time: 1454m

configs tested: 117
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-9.3.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.3.0
arc                              allyesconfig    gcc-10.5.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20250318    gcc-13.2.0
arc                   randconfig-002-20250318    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-11.5.0
arm                              allmodconfig    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-21
arm                      jornada720_defconfig    clang-21
arm                       multi_v4t_defconfig    clang-16
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250318    gcc-14.2.0
arm                   randconfig-002-20250318    clang-21
arm                   randconfig-003-20250318    gcc-14.2.0
arm                   randconfig-004-20250318    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-8.5.0
arm64                 randconfig-001-20250318    clang-21
arm64                 randconfig-002-20250318    clang-14
arm64                 randconfig-003-20250318    gcc-14.2.0
arm64                 randconfig-004-20250318    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-14.2.0
csky                  randconfig-002-20250318    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250318    clang-21
hexagon               randconfig-002-20250318    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250318    clang-20
i386        buildonly-randconfig-002-20250318    clang-20
i386        buildonly-randconfig-003-20250318    clang-20
i386        buildonly-randconfig-004-20250318    clang-20
i386        buildonly-randconfig-005-20250318    clang-20
i386        buildonly-randconfig-006-20250318    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-14.2.0
loongarch             randconfig-002-20250318    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-6.5.0
m68k                        m5272c3_defconfig    gcc-9.3.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250318    gcc-14.2.0
nios2                 randconfig-002-20250318    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    gcc-5.5.0
parisc                           allyesconfig    gcc-9.3.0
parisc                randconfig-001-20250318    gcc-14.2.0
parisc                randconfig-002-20250318    gcc-14.2.0
powerpc                          allmodconfig    gcc-10.5.0
powerpc                           allnoconfig    gcc-8.5.0
powerpc                          allyesconfig    clang-21
powerpc                     ep8248e_defconfig    gcc-11.5.0
powerpc                   lite5200b_defconfig    clang-21
powerpc               randconfig-001-20250318    clang-21
powerpc               randconfig-002-20250318    clang-21
powerpc               randconfig-003-20250318    gcc-14.2.0
powerpc64             randconfig-001-20250318    clang-21
powerpc64             randconfig-002-20250318    gcc-14.2.0
powerpc64             randconfig-003-20250318    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-7.5.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250318    clang-21
riscv                 randconfig-002-20250318    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250318    clang-15
s390                  randconfig-002-20250318    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-5.5.0
sh                    randconfig-001-20250318    gcc-14.2.0
sh                    randconfig-002-20250318    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-10.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250318    gcc-14.2.0
sparc                 randconfig-002-20250318    gcc-14.2.0
sparc64               randconfig-001-20250318    gcc-14.2.0
sparc64               randconfig-002-20250318    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250318    clang-21
um                    randconfig-002-20250318    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250318    clang-20
x86_64      buildonly-randconfig-002-20250318    clang-20
x86_64      buildonly-randconfig-003-20250318    clang-20
x86_64      buildonly-randconfig-004-20250318    clang-20
x86_64      buildonly-randconfig-005-20250318    gcc-12
x86_64      buildonly-randconfig-006-20250318    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250318    gcc-14.2.0
xtensa                randconfig-002-20250318    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

