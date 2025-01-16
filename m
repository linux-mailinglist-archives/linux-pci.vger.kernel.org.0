Return-Path: <linux-pci+bounces-20019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6D7A1444E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 23:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BC83A11F8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E201DDC0F;
	Thu, 16 Jan 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIrvTT0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC32416A1
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064809; cv=none; b=iiXEzaQBUxMZcy+TO767YLyfuVzMssWMp5hfysryp4eKYLhmGxrCheBElcFgbKwbsqrRPjKPO+d3LcOhjH4fzpU9IMT39TaCA77uVnEAUtMioJq/M2CZ1QS+O0QQ0JDXy033nwwYdnfIoGbEcQM77JRGKAYlkspdHntC6ef08xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064809; c=relaxed/simple;
	bh=+0dwKHHiif4p5UohLpkx+7oIcJyOwTpF7MN9m7mf3+g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qw3HRfKuD0wluT7p8uP59ZlXjjeV9cD0wXtx6SsVICXT+UGscfBuWs7Z5pWQ7/k+7wnX09PQNYSfhOwBLv09S4KUP48ddHlajZGU+KKvjIygc1+BrzqK8LBvFn/3cCGO1fSXH0Z021COfF+G4A5G7RbXm1geulBGVZ4QaHkr8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIrvTT0a; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737064807; x=1768600807;
  h=date:from:to:cc:subject:message-id;
  bh=+0dwKHHiif4p5UohLpkx+7oIcJyOwTpF7MN9m7mf3+g=;
  b=YIrvTT0aD1POacaU5SjVqYRtzYqh8BuzqrkeTlHD1u+d+chtSv0Oeqva
   CR1eMehxRxjXaFaaTvn+IcsdpHCkaZMJhtVwXupgoyK7dEIW6tJzzwr7X
   lxAAb9UN+vAODDJmdHWqUxVyINx2PBIObwQIi4Y967GMt9qrFRq+m6Rbn
   2h4VuxwEFXj6wsx0LnnU5amSjqFV5yL/orz2eYawrYBwY1Flpy5dAekDC
   LYGk3GLZiaz+liJ8Abs4LeoT4dSaS4gDi8x0zfTeGDGmTda+9UsfdB9Qo
   iifYOIebi4/NqUY/FO4hVK0nw9ApvT2ExnjEKzrPj3ALEw8uPhX/scwww
   g==;
X-CSE-ConnectionGUID: CXhRX0CAT6C4v0isc+IF8Q==
X-CSE-MsgGUID: LMiOO8tHSSGdkY2R0NXCKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37392637"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37392637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 14:00:06 -0800
X-CSE-ConnectionGUID: pgtHvH/xT3utDDrshFISCQ==
X-CSE-MsgGUID: MDQ7oZRQTr+7VcrSV5Ot0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105464917"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Jan 2025 14:00:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYXuC-000SQp-2o;
	Thu, 16 Jan 2025 22:00:00 +0000
Date: Fri, 17 Jan 2025 05:59:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/iommu-map] BUILD SUCCESS
 d9f6642ab7ca007ab899b2a89a6b754dcabcad47
Message-ID: <202501170542.nBBokUqS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/iommu-map
branch HEAD: d9f6642ab7ca007ab899b2a89a6b754dcabcad47  PCI: apple: Convert to {en,dis}able_device() callbacks

elapsed time: 1444m

configs tested: 81
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250116    gcc-13.2.0
arc                   randconfig-002-20250116    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                            mps2_defconfig    clang-15
arm                   randconfig-001-20250116    gcc-14.2.0
arm                   randconfig-002-20250116    clang-15
arm                   randconfig-003-20250116    gcc-14.2.0
arm                   randconfig-004-20250116    gcc-14.2.0
arm                       spear13xx_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250116    gcc-14.2.0
arm64                 randconfig-002-20250116    gcc-14.2.0
arm64                 randconfig-003-20250116    clang-15
arm64                 randconfig-004-20250116    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250116    gcc-14.2.0
csky                  randconfig-002-20250116    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250116    clang-20
hexagon               randconfig-002-20250116    clang-20
i386        buildonly-randconfig-001-20250116    clang-19
i386        buildonly-randconfig-002-20250116    clang-19
i386        buildonly-randconfig-003-20250116    clang-19
i386        buildonly-randconfig-004-20250116    clang-19
i386        buildonly-randconfig-005-20250116    clang-19
i386        buildonly-randconfig-006-20250116    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250116    gcc-14.2.0
loongarch             randconfig-002-20250116    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250116    gcc-14.2.0
nios2                 randconfig-002-20250116    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250116    gcc-14.2.0
parisc                randconfig-002-20250116    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250116    clang-20
powerpc               randconfig-002-20250116    gcc-14.2.0
powerpc               randconfig-003-20250116    clang-20
powerpc64             randconfig-001-20250116    clang-19
powerpc64             randconfig-002-20250116    clang-20
powerpc64             randconfig-003-20250116    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250116    gcc-14.2.0
riscv                 randconfig-002-20250116    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250116    gcc-14.2.0
s390                  randconfig-002-20250116    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250116    gcc-14.2.0
sh                    randconfig-002-20250116    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250116    gcc-14.2.0
sparc                 randconfig-002-20250116    gcc-14.2.0
sparc64               randconfig-001-20250116    gcc-14.2.0
sparc64               randconfig-002-20250116    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250116    clang-19
um                    randconfig-002-20250116    gcc-12
x86_64      buildonly-randconfig-001-20250116    gcc-12
x86_64      buildonly-randconfig-002-20250116    gcc-12
x86_64      buildonly-randconfig-003-20250116    gcc-12
x86_64      buildonly-randconfig-004-20250116    clang-19
x86_64      buildonly-randconfig-005-20250116    clang-19
x86_64      buildonly-randconfig-006-20250116    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250116    gcc-14.2.0
xtensa                randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

