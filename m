Return-Path: <linux-pci+bounces-7827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C48CF108
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 20:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF041F21704
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0E86AE3;
	Sat, 25 May 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBz/RwFc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3E4AEF8
	for <linux-pci@vger.kernel.org>; Sat, 25 May 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716662633; cv=none; b=jRs8FONQqshpchHf8WowKOYrQe7Q1jSRVkoYGPStXYwrqy9bYPku33fVmoKo3yg+/be2DXjUMGnQA6rJJ/Ft02ciQF4wB1H5myK2KFreRjfnirRHVMfd7fnHgASDJ9Nc357YkGZ6kn3S3W3As1whUe+ncmTw0UDZb9XfnyvJ/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716662633; c=relaxed/simple;
	bh=CyqV9j7Mh3Q13JEQ5NCdmuwKAvGqeZXmXzg9HB50e+M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y1NkplGoL225MeW7kP7luSxVv7QdxHFbvlcLvf9KVEtf6yDrVse3+wg+8FbH+9Y1r4zbsQkrpNkogKMTfcaibvBg6RGIgjMfPw7OM5g5u1oXq7RhnNYEF4EmqaZjUu94uaZchBqISorxhpr0HYQ5siL67tymE1VrnyTMvtqQLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBz/RwFc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716662632; x=1748198632;
  h=date:from:to:cc:subject:message-id;
  bh=CyqV9j7Mh3Q13JEQ5NCdmuwKAvGqeZXmXzg9HB50e+M=;
  b=JBz/RwFc93kmEFqPip7RCaT5Q/MZzY4IWYCwnSkQ1ONLYDCfzZ06j3m1
   LAqFI0uxeqn410u6m2cPB73jl5ng41lD/kA1wqHcBHQzIXBXX2y7vlqwe
   NRX3jT09u4xTCJqMVTJJmkRHRGD3gPk/gW/cDDSz0QSnBQfbcbPgM1XLe
   K85cnnd73LENuV9zFqgpXC9L0RR4Lu0A7CKxf1FYg9ulmjXUxVmR1DBMz
   HdS+3yMkbmSm/m8lUrUwQoqOXGAiMYoYocxy28EnF9dIXGEqlkOtT2eDF
   yf6yJiJeWIbAWHTjSYhw5dbk3mFCnbzssNWb3Y1oRc3q9armElc2NVEKT
   A==;
X-CSE-ConnectionGUID: 1i7kaE1URYqJEZMNa5/TzA==
X-CSE-MsgGUID: BVCxXBaCTS6ivyXPemIZ5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="16853821"
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="16853821"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 11:43:52 -0700
X-CSE-ConnectionGUID: zEJzrx2bQcqc2wCTiGuc9Q==
X-CSE-MsgGUID: fir8RtQiSISsB6zfKdIA8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="34322456"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 May 2024 11:43:50 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAwMu-0007K3-0z;
	Sat, 25 May 2024 18:43:48 +0000
Date: Sun, 26 May 2024 02:43:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 3c19cd9603f2dfda6250ddc8d19f843c48a56422
Message-ID: <202405260210.szGy6FK4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 3c19cd9603f2dfda6250ddc8d19f843c48a56422  PCI: Relax bridge window tail sizing rules

elapsed time: 1227m

configs tested: 145
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
arc                   randconfig-001-20240525   gcc  
arc                   randconfig-002-20240525   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240525   gcc  
arm                   randconfig-002-20240525   gcc  
arm                   randconfig-003-20240525   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240525   gcc  
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
powerpc64             randconfig-002-20240525   gcc  
powerpc64             randconfig-003-20240525   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240525   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
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
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240525   clang
x86_64                randconfig-002-20240525   clang
x86_64                randconfig-003-20240525   clang
x86_64                randconfig-004-20240525   clang
x86_64                randconfig-005-20240525   clang
x86_64                randconfig-006-20240525   clang
x86_64                randconfig-011-20240525   clang
x86_64                randconfig-012-20240525   clang
x86_64                randconfig-014-20240525   clang
x86_64                randconfig-016-20240525   clang
x86_64                randconfig-072-20240525   clang
x86_64                randconfig-073-20240525   clang
x86_64                randconfig-076-20240525   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240525   gcc  
xtensa                randconfig-002-20240525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

