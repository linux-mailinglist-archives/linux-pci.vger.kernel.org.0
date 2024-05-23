Return-Path: <linux-pci+bounces-7794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788A8CD8DE
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 19:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84AB1F21802
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E56D1B5;
	Thu, 23 May 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHDOF429"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01830AD2C
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483795; cv=none; b=shpNCp2C9Laa6en76DWQXhX1HUSkvfIkDMsaUjSwdJpo/YJPuolEeheL9IZnjkmaAfx2EqBjvMtEPddMZUYUPCj8JdFey2rR3hwXswyAFFCZUR3Xxzh39+YMZz2pkEtSVxMoRheChwZ25iPHwB5WQFZ9vis23l8tNC7juhxY25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483795; c=relaxed/simple;
	bh=o93VNVvvsRpcpIp7J9/1thDMNQ3oBx7C/L5HsmiADB8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YXkAMnOj3MFgvzS1QWyCC/VBJFGKJ8nkcAh7bOn4hXMgMXcnIAoD3lDjos1eAKa5vAOujJse5IZ0T7PFRNByktk+iaTUG69+PIfSej02r7Btw5PDPBKnQbsUsg/XR5o7s851iak5nxZc4HhlbWrByw9ogrrmheH41z1rk/usrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHDOF429; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716483794; x=1748019794;
  h=date:from:to:cc:subject:message-id;
  bh=o93VNVvvsRpcpIp7J9/1thDMNQ3oBx7C/L5HsmiADB8=;
  b=DHDOF429MgejCZBomQPn33MUuS0RlU2tryYEIbZD+FUDrvAb5gmUFYJN
   NAFYUaZMCpPODadiZnFWOBuEoCt+/J5yhzl633SrSrER+vHAg224rZ5px
   9QarWH0bPcOp+RzjW/a0vLjkQkNFdRZ8Tjgww284c/2yWCok0gwDzkLBm
   v1yMKbmbcPx9UR9mnLVE1qxeECuPTJQCPV5h3VS7FRX/L8gB5Y/P9AgM6
   ukukjZKzNtE3QHUClRo2TE3CaELDRc3FKInr8RV+frMlgd+4iEzimnXx6
   JFHsoOV0KkjwgpKEKK9EdgzO2sxZEZ1lK7+QZ4CKtDKTMbcuy/99mbGtZ
   w==;
X-CSE-ConnectionGUID: 3frMrOGyThaTmFOHvBcBXQ==
X-CSE-MsgGUID: ib/InyFfRKmiZmWCGLuewA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="30351243"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="30351243"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:03:01 -0700
X-CSE-ConnectionGUID: GRWvQ3+nQG6B2mOalBmBPg==
X-CSE-MsgGUID: ypMKsVdWTjSkzRBujxRJMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="34345075"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 May 2024 10:03:00 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sABqD-00039x-2J;
	Thu, 23 May 2024 17:02:57 +0000
Date: Fri, 24 May 2024 01:02:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/al] BUILD SUCCESS
 f0a4bff68595ab1a72ddc34e0da6e883c439eb03
Message-ID: <202405240128.18XIJxc0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/al
branch HEAD: f0a4bff68595ab1a72ddc34e0da6e883c439eb03  PCI: dwc: al: Check IORESOURCE_BUS existence during probe

elapsed time: 1088m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240523   gcc  
arc                   randconfig-002-20240523   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240523   gcc  
arm                   randconfig-002-20240523   gcc  
arm                   randconfig-003-20240523   gcc  
arm                   randconfig-004-20240523   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240523   clang
arm64                 randconfig-002-20240523   gcc  
arm64                 randconfig-003-20240523   clang
arm64                 randconfig-004-20240523   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240523   gcc  
csky                  randconfig-002-20240523   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240523   clang
hexagon               randconfig-002-20240523   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240523   clang
i386         buildonly-randconfig-002-20240523   gcc  
i386         buildonly-randconfig-003-20240523   clang
i386         buildonly-randconfig-004-20240523   clang
i386         buildonly-randconfig-005-20240523   clang
i386         buildonly-randconfig-006-20240523   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240523   gcc  
i386                  randconfig-002-20240523   clang
i386                  randconfig-003-20240523   clang
i386                  randconfig-004-20240523   clang
i386                  randconfig-005-20240523   gcc  
i386                  randconfig-006-20240523   clang
i386                  randconfig-011-20240523   gcc  
i386                  randconfig-012-20240523   clang
i386                  randconfig-013-20240523   clang
i386                  randconfig-014-20240523   gcc  
i386                  randconfig-015-20240523   gcc  
i386                  randconfig-016-20240523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240523   gcc  
loongarch             randconfig-002-20240523   gcc  
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
nios2                 randconfig-001-20240523   gcc  
nios2                 randconfig-002-20240523   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240523   gcc  
parisc                randconfig-002-20240523   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240523   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

