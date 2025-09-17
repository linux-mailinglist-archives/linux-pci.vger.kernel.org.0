Return-Path: <linux-pci+bounces-36324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F06B7D0CC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A131705B6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB782253E4;
	Wed, 17 Sep 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oE/PYvzt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7A2E62B3
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094208; cv=none; b=elHaJtKZikF0MlQA7wfE/2HYFKBnM47yUhzFOZ96H5XSobiN8xL89/1INrLt/wFOnWwW+lf9kKhRNuak5RPclKLTC2N7VjIrUFVyjTIcfUdNIpboMBcPDb4vt6CIRF8CH8MYvMSG1rJmtBc5SVQztw2iEEf3DAl8JhYDrVH6yGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094208; c=relaxed/simple;
	bh=4dYyIdsowBPlhUC3hlI7p/s1g6t26NSl0SqgRKsaVTM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XRHPCAYoOFta3loYnozzeu7ki34uSyAgXud3hJ81RJfZlQFqfFHRD3lDN1UMyr2FppRQumOCOZ2fGS7ZMT1bU2s4VWEWFzI3JlBx8jWKOvwIxUeitR7s2j+7oQURUneBpTtP9tQi9OKr8buo6S6WX/Ey6AZ6z4K4fJD1RETNWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oE/PYvzt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758094207; x=1789630207;
  h=date:from:to:cc:subject:message-id;
  bh=4dYyIdsowBPlhUC3hlI7p/s1g6t26NSl0SqgRKsaVTM=;
  b=oE/PYvzt3x4UENU6kFNRPkTJ9QqGSUHW6Oy4gyEFhUyS8IVZl9DUSedr
   4V8fr8PkGL2WKTsxkR4BzYNjo/MDOFKbOnKW/R25O7r0lqXZkhosIwKWn
   Jb+xHvO2yyMZCxVOvjgXZ7mqWL9ogWDloXPkAvy9uAULBg7XCg0TeJIfd
   Gs3LS4XvrSMScUtZvFIK+qEj+i2OgvlzHajHlhBCL5InRq/HQT07M3yXj
   8z0dBV6siBDbrfPAE/h3GoBfEvEmuAc4LHQKyLQ3GfcmGgBE7BaZutJKy
   WRqt4GqdUNtrQlRuv0XYHSLODp+/UD9dHV7yE7C88fyudotxZwJW3zf8x
   Q==;
X-CSE-ConnectionGUID: UWiFm5y2RDeN7b9eu3UyzQ==
X-CSE-MsgGUID: VWUS7CfsQMeXqgMdBEPCbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60259929"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60259929"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:30:07 -0700
X-CSE-ConnectionGUID: GEAV6quOSvu0BvngspoueQ==
X-CSE-MsgGUID: fCx3MIHpSGii7j9VbuULaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="179564954"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Sep 2025 00:30:03 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uymc4-0001DP-1u;
	Wed, 17 Sep 2025 07:30:00 +0000
Date: Wed, 17 Sep 2025 15:29:08 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 85afa9ea122dd9d4a2ead104a951d318975dcd25
Message-ID: <202509171501.CF8ktAzc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 85afa9ea122dd9d4a2ead104a951d318975dcd25  PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release

elapsed time: 1456m

configs tested: 111
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250916    gcc-8.5.0
arc                   randconfig-002-20250916    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20250916    gcc-11.5.0
arm                   randconfig-002-20250916    clang-22
arm                   randconfig-003-20250916    gcc-12.5.0
arm                   randconfig-004-20250916    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250916    clang-18
arm64                 randconfig-002-20250916    clang-22
arm64                 randconfig-003-20250916    clang-22
arm64                 randconfig-004-20250916    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250916    gcc-14.3.0
csky                  randconfig-002-20250916    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250916    clang-22
hexagon               randconfig-002-20250916    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250916    gcc-14
i386        buildonly-randconfig-002-20250916    gcc-14
i386        buildonly-randconfig-003-20250916    clang-20
i386        buildonly-randconfig-004-20250916    gcc-14
i386        buildonly-randconfig-005-20250916    gcc-14
i386        buildonly-randconfig-006-20250916    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250916    clang-18
loongarch             randconfig-002-20250916    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5475evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250916    gcc-11.5.0
nios2                 randconfig-002-20250916    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250916    gcc-9.5.0
parisc                randconfig-002-20250916    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250916    clang-16
powerpc               randconfig-002-20250916    clang-22
powerpc               randconfig-003-20250916    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250916    clang-22
powerpc64             randconfig-002-20250916    gcc-8.5.0
powerpc64             randconfig-003-20250916    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250916    clang-22
riscv                 randconfig-002-20250916    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250916    gcc-13.4.0
s390                  randconfig-002-20250916    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250916    gcc-15.1.0
sh                    randconfig-002-20250916    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250916    gcc-8.5.0
sparc                 randconfig-002-20250916    gcc-8.5.0
sparc64               randconfig-001-20250916    gcc-11.5.0
sparc64               randconfig-002-20250916    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250916    gcc-14
um                    randconfig-002-20250916    clang-19
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250916    gcc-14
x86_64      buildonly-randconfig-002-20250916    clang-20
x86_64      buildonly-randconfig-003-20250916    clang-20
x86_64      buildonly-randconfig-004-20250916    clang-20
x86_64      buildonly-randconfig-005-20250916    clang-20
x86_64      buildonly-randconfig-006-20250916    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250916    gcc-8.5.0
xtensa                randconfig-002-20250916    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

