Return-Path: <linux-pci+bounces-20251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B8A19A41
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 22:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A979188C8C7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F91C5D68;
	Wed, 22 Jan 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8M1yWpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788F1C5D4A
	for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580690; cv=none; b=mSA3sQXBhlSBGuOtfp3PQfYa7gF6KfVqxR+NRR6wEDvuRHaXEuLPBasoXC6jG/4aLUxmyY9MI1Dg+lsyGJJhy3Dds9AQvQLIsyev98y0Nh6LZrbF3OKrgdeZoXKGWpDVf2mam1nru1vZdWOk05gPNCrS/GYWUSEdWXNR5KzHnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580690; c=relaxed/simple;
	bh=0ItH+MgOI3zAMNgOxKzgSBcgNN/xcl6B16td7Q6mQ7U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NDcj5VkIifcXwwsCWVQlQc+ZCcoL/o2xCb8Cx+Gfisf0eVvMNk0b/5MkxWfgQzSdHwoUspmuDzjmXQiU+ISFb/JsC0ut1C2tw7eyMXA1xlFv2RaJr/v4+Qghp6BjWic6m8mo5kjmhdempg+1FfFPw643Vel/2trinFMYIn6dAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8M1yWpD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737580689; x=1769116689;
  h=date:from:to:cc:subject:message-id;
  bh=0ItH+MgOI3zAMNgOxKzgSBcgNN/xcl6B16td7Q6mQ7U=;
  b=U8M1yWpDbManGjCDoyiqkwfHsUH88ZFkbXUjl07stTPlVyvzBf0RCelP
   RptXLYUj+zUUd95i6TTViB1glPKas/d5eWv+FtJ8C+dqC/J9G2sOBfR4Q
   M6hi7XrmqfwpIz31cAeWVGqUpjSTMvC8bFpz9nZbpnvf9E1ja9bbC2UN5
   KkbEyxJygLcJRyaCH2n7qf0uC5BD1GoxQ0eSZgft08g93EnBpwseVLdYj
   gEznQeZsZuhbtKWCEEPpBgr/C52+AtTGSVwMgKBsX5F2o6nXKX47uCF/H
   8VAF7OnB9eHRLFXprNqmB8A6/qiBS7KCE6wsLaxSOuDbTNb3fPFuZ+dC7
   w==;
X-CSE-ConnectionGUID: ZG4gcsWfTFWTE7XmpMf0xg==
X-CSE-MsgGUID: Rg6WU0trQ8KbT0tVRQg3eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="48725878"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="48725878"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 13:18:08 -0800
X-CSE-ConnectionGUID: /W0pl/tcQaW1jtjlhTpEIQ==
X-CSE-MsgGUID: kgiT7xL1RJe9TQV9/Htczg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="107084828"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jan 2025 13:18:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tai6v-000aK8-25;
	Wed, 22 Jan 2025 21:18:05 +0000
Date: Thu, 23 Jan 2025 05:17:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint-test] BUILD SUCCESS
 392188bb0f6ec5162edf457c062929a6abfa369a
Message-ID: <202501230550.7vx1t3BQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint-test
branch HEAD: 392188bb0f6ec5162edf457c062929a6abfa369a  selftests: pci_endpoint: Migrate to Kselftest framework

elapsed time: 1445m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250122    gcc-13.2.0
arc                   randconfig-002-20250122    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                      integrator_defconfig    clang-15
arm                   milbeaut_m10v_defconfig    clang-20
arm                       omap2plus_defconfig    gcc-14.2.0
arm                   randconfig-001-20250122    clang-19
arm                   randconfig-002-20250122    clang-20
arm                   randconfig-003-20250122    gcc-14.2.0
arm                   randconfig-004-20250122    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250122    clang-20
arm64                 randconfig-002-20250122    clang-15
arm64                 randconfig-003-20250122    clang-20
arm64                 randconfig-004-20250122    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250122    gcc-14.2.0
csky                  randconfig-002-20250122    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250122    clang-20
hexagon               randconfig-002-20250122    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250122    clang-19
i386        buildonly-randconfig-002-20250122    gcc-12
i386        buildonly-randconfig-003-20250122    gcc-12
i386        buildonly-randconfig-004-20250122    clang-19
i386        buildonly-randconfig-005-20250122    clang-19
i386        buildonly-randconfig-006-20250122    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250122    gcc-14.2.0
loongarch             randconfig-002-20250122    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250122    gcc-14.2.0
nios2                 randconfig-002-20250122    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250122    gcc-14.2.0
parisc                randconfig-002-20250122    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                       ppc64_defconfig    clang-19
powerpc               randconfig-001-20250122    gcc-14.2.0
powerpc               randconfig-002-20250122    clang-17
powerpc               randconfig-003-20250122    clang-15
powerpc                     redwood_defconfig    clang-20
powerpc64             randconfig-001-20250122    clang-20
powerpc64             randconfig-002-20250122    clang-19
powerpc64             randconfig-003-20250122    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250122    clang-20
riscv                 randconfig-002-20250122    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250122    clang-18
s390                  randconfig-002-20250122    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250122    gcc-14.2.0
sh                    randconfig-002-20250122    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250122    gcc-14.2.0
sparc                 randconfig-002-20250122    gcc-14.2.0
sparc64               randconfig-001-20250122    gcc-14.2.0
sparc64               randconfig-002-20250122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250122    gcc-12
um                    randconfig-002-20250122    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250122    gcc-12
x86_64      buildonly-randconfig-002-20250122    clang-19
x86_64      buildonly-randconfig-003-20250122    gcc-12
x86_64      buildonly-randconfig-004-20250122    gcc-12
x86_64      buildonly-randconfig-005-20250122    gcc-12
x86_64      buildonly-randconfig-006-20250122    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250122    gcc-14.2.0
xtensa                randconfig-002-20250122    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

