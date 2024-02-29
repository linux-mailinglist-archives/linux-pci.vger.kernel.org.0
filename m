Return-Path: <linux-pci+bounces-4267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B364786CF68
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 17:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBADBB224AD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563A870AC0;
	Thu, 29 Feb 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eaf7RPCz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322E160633
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224037; cv=none; b=jPOz4g/hQmQrUDYs4Wg0SRgNRKobbg0KKCvRCysYaOQ4+tIsVLShprqg0k7dlZo2M8IiAYtYqHpu7TtKkxyPHpTKWu5EtGb2fmnkp//4zmxpkuw3ULmtsyuyhHiSLxXoTupJsV6Gay5zcEbLm3oGANNLRIYCi/Z1RbKZYUulb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224037; c=relaxed/simple;
	bh=1ZvDU7d/N85+NThmR3U8XFqqDHFeuD6T/8W1AyNDhKY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PEcqwSIlM9ZjiS4gF/C1DNagMp2TSlJmZ3CuI+JbSuhJu2n5VIOI0f2rBH3wcJcppxUzVa5Vo0EZFGRJ1mxNFaScIBo+JXwVY3g4n8rY+hfVlp6lu8emXF/iNlKZkid+CTH0LYqgmA2K42E/i/D6uoHYoyNBBauYCLM6uBch9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eaf7RPCz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709224034; x=1740760034;
  h=date:from:to:cc:subject:message-id;
  bh=1ZvDU7d/N85+NThmR3U8XFqqDHFeuD6T/8W1AyNDhKY=;
  b=Eaf7RPCzVpH76TJHcFNlxYLtuH8nOtxpdKOSn83d1RKWXwRppqPua+C3
   3K9tIE+Y7+Dse3byUbSYvC1MsJn8iJrB/WUIEvkMgsR8U3JpDWEyKLxaG
   YVpLcio8z35uOfx4nEG3i9Oal+Uog37VfkEahwS7/xS+jUVko1JJGa3u4
   +7QsP63Alw8J8cEJL3aRweL2LF/ZDdHxTcAxIVMEjQHKj7s9LxY/d9JhW
   coWjH/BgdJkT+S21pipBI/dSg44UfAftdG9G3AXdDaivJI1kGi28Oak8W
   l2Nkp90M7FV2B5Wj+AZ2QhwspRRljVWjYThuavi+TsSb3E0q15zukvOYY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26167310"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="26167310"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8117795"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 29 Feb 2024 08:27:12 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfjFW-000D5d-1q;
	Thu, 29 Feb 2024 16:27:10 +0000
Date: Fri, 01 Mar 2024 00:26:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 a66f2b4a4d365dc4bac35576f3a9d4f5982f1d63
Message-ID: <202403010021.iFOIqxs2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: a66f2b4a4d365dc4bac35576f3a9d4f5982f1d63  Merge branch 'pci/qcom'

elapsed time: 967m

configs tested: 162
configs skipped: 4

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
arc                   randconfig-001-20240229   gcc  
arc                   randconfig-002-20240229   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240229   gcc  
arm                   randconfig-002-20240229   gcc  
arm                   randconfig-003-20240229   clang
arm                   randconfig-004-20240229   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240229   clang
arm64                 randconfig-002-20240229   gcc  
arm64                 randconfig-003-20240229   clang
arm64                 randconfig-004-20240229   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240229   gcc  
csky                  randconfig-002-20240229   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240229   clang
hexagon               randconfig-002-20240229   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240229   clang
i386         buildonly-randconfig-002-20240229   gcc  
i386         buildonly-randconfig-003-20240229   gcc  
i386         buildonly-randconfig-004-20240229   clang
i386         buildonly-randconfig-005-20240229   gcc  
i386         buildonly-randconfig-006-20240229   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240229   clang
i386                  randconfig-002-20240229   gcc  
i386                  randconfig-003-20240229   clang
i386                  randconfig-004-20240229   gcc  
i386                  randconfig-005-20240229   gcc  
i386                  randconfig-006-20240229   gcc  
i386                  randconfig-011-20240229   gcc  
i386                  randconfig-012-20240229   gcc  
i386                  randconfig-013-20240229   clang
i386                  randconfig-014-20240229   clang
i386                  randconfig-015-20240229   clang
i386                  randconfig-016-20240229   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240229   gcc  
loongarch             randconfig-002-20240229   gcc  
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
nios2                 randconfig-001-20240229   gcc  
nios2                 randconfig-002-20240229   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240229   gcc  
parisc                randconfig-002-20240229   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240229   clang
powerpc               randconfig-002-20240229   gcc  
powerpc               randconfig-003-20240229   clang
powerpc64             randconfig-001-20240229   gcc  
powerpc64             randconfig-002-20240229   clang
powerpc64             randconfig-003-20240229   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240229   clang
riscv                 randconfig-002-20240229   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240229   clang
s390                  randconfig-002-20240229   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240229   gcc  
sh                    randconfig-002-20240229   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240229   gcc  
sparc64               randconfig-002-20240229   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240229   gcc  
um                    randconfig-002-20240229   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240229   gcc  
x86_64       buildonly-randconfig-002-20240229   clang
x86_64       buildonly-randconfig-003-20240229   gcc  
x86_64       buildonly-randconfig-004-20240229   gcc  
x86_64       buildonly-randconfig-005-20240229   gcc  
x86_64       buildonly-randconfig-006-20240229   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240229   clang
x86_64                randconfig-002-20240229   clang
x86_64                randconfig-003-20240229   clang
x86_64                randconfig-004-20240229   clang
x86_64                randconfig-005-20240229   clang
x86_64                randconfig-006-20240229   clang
x86_64                randconfig-011-20240229   gcc  
x86_64                randconfig-012-20240229   gcc  
x86_64                randconfig-013-20240229   gcc  
x86_64                randconfig-014-20240229   gcc  
x86_64                randconfig-015-20240229   gcc  
x86_64                randconfig-016-20240229   gcc  
x86_64                randconfig-071-20240229   clang
x86_64                randconfig-072-20240229   clang
x86_64                randconfig-073-20240229   clang
x86_64                randconfig-074-20240229   clang
x86_64                randconfig-075-20240229   gcc  
x86_64                randconfig-076-20240229   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240229   gcc  
xtensa                randconfig-002-20240229   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

