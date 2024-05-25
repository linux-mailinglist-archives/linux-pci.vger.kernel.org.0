Return-Path: <linux-pci+bounces-7825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA78CF024
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E675281546
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB424487A5;
	Sat, 25 May 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ha/YmtPC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480086120
	for <linux-pci@vger.kernel.org>; Sat, 25 May 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655360; cv=none; b=ZeECDG+2vAJg4fYNhGkenKCso13s0koKaM6nbeixfsZXT9rG/AaKYBRIXp4qHA3V9gs1eoWfihxOai10aZmga6RBkqTDoQDzY5X/TmeFjN09j8OjdJECTYvUHd/ShFcVwNfZGxXk4PJIOSzFOiCnIvA1IK3ACKm1qLe7MHgzIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655360; c=relaxed/simple;
	bh=uLxK9xyqHlVSkRI2FNtqlbjJbhDzKnvsunBJRG0CP30=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NXWkCnpKw/TmWbpi7bMybWyyp0dVlezzte4/zkReZcQIRI+9FYD7x+yd6O5sz5vntvPI2kkeMBnTkefHrRSgiaLtEIm8LYtfJ/EQjbsLRkpNOO9LyckLQMvNsfEZ+COQgDBUhfOryHoqnInV7bCs+I1IPu0xF6zUYm1LOLPbJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ha/YmtPC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716655359; x=1748191359;
  h=date:from:to:cc:subject:message-id;
  bh=uLxK9xyqHlVSkRI2FNtqlbjJbhDzKnvsunBJRG0CP30=;
  b=Ha/YmtPCSng9bAF6dvX9tCnZBeR11MaQ9WMAewsj3CezpVCncg8SsMd+
   BVTTBRg+hkee9HQ+4qpCbq31ap8gC2y/uRxYVLP6ody72UXOyN+S7LHTP
   2ug7c+QNpLM+xqvpbvDY2aB0IRVlQA8L05tVBG9Ij/9lPudJSo2s4I7qv
   a310PpMQMuXxbCihxadLEhFWzJndVxqjGu3FZN6WyMqDO2VL1bz9EhLXy
   GGUwQVEhaLSOHwzG+HOrrl0Q5sxHc450ECVHIgFAWJO71CfAkehm4ylbu
   8krtZz8PXujzp6i5UxOZcsYuP2L15s2rYpkDX+Oml0p3xSr8VQjyOYQRX
   Q==;
X-CSE-ConnectionGUID: 3RD6kelPTauFDka37lVKig==
X-CSE-MsgGUID: wAKFvK+7RLKClCP+N+oMeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="13243580"
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="13243580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 09:42:38 -0700
X-CSE-ConnectionGUID: BZiYEqQZShy7rQEq/VbEWQ==
X-CSE-MsgGUID: X/9RwkzkQeWsPHpSEO9T/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="34825916"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 25 May 2024 09:42:37 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAuTa-0007C9-0i;
	Sat, 25 May 2024 16:42:34 +0000
Date: Sun, 26 May 2024 00:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD REGRESSION
 1b36cee89f5f82bd04538b231e4261ed517ae174
Message-ID: <202405260009.1Y0RHqOJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 1b36cee89f5f82bd04538b231e4261ed517ae174  PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405250716.lpmrTGyQ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/controller/dwc/pcie-qcom-ep.c:658:17: error: implicit declaration of function 'dw_pcie_ep_linkdown'; did you mean 'dw_pcie_ep_linkup'? [-Werror=implicit-function-declaration]
drivers/pci/controller/dwc/pcie-qcom-ep.c:658:3: error: call to undeclared function 'dw_pcie_ep_linkdown'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- arc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- arc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- arm-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- arm-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- arm64-randconfig-001-20240525
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- arm64-randconfig-004-20240525
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- csky-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- csky-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- i386-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- i386-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- loongarch-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- microblaze-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- microblaze-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- mips-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- openrisc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- parisc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- parisc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- powerpc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- powerpc-randconfig-001-20240525
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- s390-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- sparc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- sparc64-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- sparc64-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
|-- um-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
`-- x86_64-buildonly-randconfig-004-20240525
    `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:implicit-declaration-of-function-dw_pcie_ep_linkdown
clang_recent_errors
|-- arm64-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:call-to-undeclared-function-dw_pcie_ep_linkdown-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- powerpc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:call-to-undeclared-function-dw_pcie_ep_linkdown-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:call-to-undeclared-function-dw_pcie_ep_linkdown-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:call-to-undeclared-function-dw_pcie_ep_linkdown-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:call-to-undeclared-function-dw_pcie_ep_linkdown-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-allyesconfig
    `-- drivers-pci-controller-dwc-pcie-qcom-ep.c:error:call-to-undeclared-function-dw_pcie_ep_linkdown-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 1179m

configs tested: 163
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240525   gcc  
arc                   randconfig-002-20240525   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240525   gcc  
arm                   randconfig-002-20240525   gcc  
arm                   randconfig-003-20240525   clang
arm                   randconfig-004-20240525   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240525   gcc  
arm64                 randconfig-002-20240525   clang
arm64                 randconfig-003-20240525   gcc  
arm64                 randconfig-004-20240525   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240525   gcc  
csky                  randconfig-002-20240525   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240525   clang
hexagon               randconfig-002-20240525   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240525   gcc  
i386         buildonly-randconfig-002-20240525   gcc  
i386         buildonly-randconfig-003-20240525   gcc  
i386         buildonly-randconfig-004-20240525   clang
i386         buildonly-randconfig-005-20240525   gcc  
i386         buildonly-randconfig-006-20240525   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240525   clang
i386                  randconfig-002-20240525   gcc  
i386                  randconfig-003-20240525   clang
i386                  randconfig-004-20240525   clang
i386                  randconfig-005-20240525   gcc  
i386                  randconfig-006-20240525   gcc  
i386                  randconfig-011-20240525   clang
i386                  randconfig-012-20240525   clang
i386                  randconfig-013-20240525   clang
i386                  randconfig-014-20240525   gcc  
i386                  randconfig-015-20240525   clang
i386                  randconfig-016-20240525   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240525   gcc  
loongarch             randconfig-002-20240525   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240525   gcc  
nios2                 randconfig-002-20240525   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240525   gcc  
parisc                randconfig-002-20240525   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240525   gcc  
powerpc               randconfig-002-20240525   gcc  
powerpc               randconfig-003-20240525   gcc  
powerpc64             randconfig-001-20240525   clang
powerpc64             randconfig-002-20240525   gcc  
powerpc64             randconfig-003-20240525   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240525   gcc  
riscv                 randconfig-002-20240525   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240525   clang
s390                  randconfig-002-20240525   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240525   gcc  
sh                    randconfig-002-20240525   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240525   gcc  
sparc64               randconfig-002-20240525   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240525   gcc  
um                    randconfig-002-20240525   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240525   clang
x86_64       buildonly-randconfig-002-20240525   gcc  
x86_64       buildonly-randconfig-003-20240525   gcc  
x86_64       buildonly-randconfig-004-20240525   gcc  
x86_64       buildonly-randconfig-005-20240525   gcc  
x86_64       buildonly-randconfig-006-20240525   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240525   clang
x86_64                randconfig-002-20240525   clang
x86_64                randconfig-003-20240525   clang
x86_64                randconfig-004-20240525   clang
x86_64                randconfig-005-20240525   clang
x86_64                randconfig-006-20240525   clang
x86_64                randconfig-011-20240525   clang
x86_64                randconfig-012-20240525   clang
x86_64                randconfig-013-20240525   gcc  
x86_64                randconfig-014-20240525   clang
x86_64                randconfig-015-20240525   gcc  
x86_64                randconfig-016-20240525   clang
x86_64                randconfig-071-20240525   gcc  
x86_64                randconfig-072-20240525   clang
x86_64                randconfig-073-20240525   clang
x86_64                randconfig-074-20240525   gcc  
x86_64                randconfig-075-20240525   gcc  
x86_64                randconfig-076-20240525   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240525   gcc  
xtensa                randconfig-002-20240525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

