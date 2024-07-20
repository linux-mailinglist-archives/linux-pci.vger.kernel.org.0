Return-Path: <linux-pci+bounces-10564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00D7937F5F
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80948281072
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 07:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2265323D;
	Sat, 20 Jul 2024 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J422RnZy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7C2B9A5
	for <linux-pci@vger.kernel.org>; Sat, 20 Jul 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721458913; cv=none; b=rL48INsaA+7HVTSy7NogZMm7bOhmkCLyKYU/ILGklkRE/09lXixLM7D7hLH4qHJb8z9dGXIKAHy6I5IL7Z7dtYHoRjwt8TYodQCrhFKRhOQFtIQlQvtt/UMYRU4TuyoGSESBIymDCMQe4F8RcN4/4zQ+4iS4P7V9D/cYtlI5OxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721458913; c=relaxed/simple;
	bh=FRy2CIsUhe+hJQPf+p/bnoIzFRbQGtSSuVp+yRRCfts=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k554A8/u5y0fY23iDj7PRF8NFPEPkBd1AtwFjx/Jtzi8C6W9kOBwhqjW8CQJH9lkq7EKq1puSW+nG1m50H/QRPVYn/s6gdPSZArwYyPl7Xp09yeTx+lYTNlW21HNXSbk3iqSb4MzvejF3WZTyXoOUhKmB6Y51z4gAZbyjaSpExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J422RnZy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721458911; x=1752994911;
  h=date:from:to:cc:subject:message-id;
  bh=FRy2CIsUhe+hJQPf+p/bnoIzFRbQGtSSuVp+yRRCfts=;
  b=J422RnZyE6CPTGHKWoJfmtNDsGlwUqf6DywDZuF1/tTs8f/bHrYeWXDs
   I0NVv2RRd1I0r/fQELw3KVNIXGoLowqpFWimxfttraXMq495r/cBKnYdj
   2MvmzuxZKpAhmH03o5gX++95BA/7WBgKiRt5kKMwvAqi2h5AbxnHtv7h/
   VVx+EJzKJC0xeeOw+zZgnuCTnecz9Rwc+UbBKENi2Myz4s7XFxZRrk/AI
   pTuALGDa5kf1Pm2XCJq2P5YuCz/85j5FJzcyF1OrfBNWMEOIgkCdgJp1u
   0x8sA8I+0tkSLosdqZgY8B+qZBCwpuUkrCmpnmRTLCYzkIBMfMq3uSH54
   w==;
X-CSE-ConnectionGUID: HyEF7hrfT0KVdO0cJlcRPQ==
X-CSE-MsgGUID: 4LdjRcIASxWPailzb98f+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="21986446"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="21986446"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 00:01:03 -0700
X-CSE-ConnectionGUID: lDuSET/7SeeAMfOr/nvF/A==
X-CSE-MsgGUID: nyeH8rk/QKq0uwnJ6KXLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="56172334"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Jul 2024 00:01:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sV45T-000ixJ-1F;
	Sat, 20 Jul 2024 07:00:59 +0000
Date: Sat, 20 Jul 2024 15:00:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/loongson] BUILD SUCCESS
 a4bbcac11d3cea85822af8b40daed7e96bca5068
Message-ID: <202407201459.hYwZBXKk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/loongson
branch HEAD: a4bbcac11d3cea85822af8b40daed7e96bca5068  PCI: loongson: Enable MSI in LS7A Root Complex

elapsed time: 880m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240720   gcc-13.2.0
arc                   randconfig-002-20240720   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240720   gcc-13.2.0
arm                   randconfig-002-20240720   gcc-13.2.0
arm                   randconfig-003-20240720   gcc-13.2.0
arm                   randconfig-004-20240720   gcc-13.2.0
arm                           stm32_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240720   gcc-13.2.0
arm64                 randconfig-002-20240720   gcc-13.2.0
arm64                 randconfig-003-20240720   gcc-13.2.0
arm64                 randconfig-004-20240720   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240720   gcc-13.2.0
csky                  randconfig-002-20240720   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240720   clang-18
i386         buildonly-randconfig-002-20240720   clang-18
i386         buildonly-randconfig-002-20240720   gcc-13
i386         buildonly-randconfig-003-20240720   clang-18
i386         buildonly-randconfig-003-20240720   gcc-13
i386         buildonly-randconfig-004-20240720   clang-18
i386         buildonly-randconfig-005-20240720   clang-18
i386         buildonly-randconfig-006-20240720   clang-18
i386         buildonly-randconfig-006-20240720   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240720   clang-18
i386                  randconfig-001-20240720   gcc-7
i386                  randconfig-002-20240720   clang-18
i386                  randconfig-003-20240720   clang-18
i386                  randconfig-004-20240720   clang-18
i386                  randconfig-005-20240720   clang-18
i386                  randconfig-005-20240720   gcc-13
i386                  randconfig-006-20240720   clang-18
i386                  randconfig-006-20240720   gcc-11
i386                  randconfig-011-20240720   clang-18
i386                  randconfig-011-20240720   gcc-13
i386                  randconfig-012-20240720   clang-18
i386                  randconfig-012-20240720   gcc-13
i386                  randconfig-013-20240720   clang-18
i386                  randconfig-013-20240720   gcc-13
i386                  randconfig-014-20240720   clang-18
i386                  randconfig-014-20240720   gcc-13
i386                  randconfig-015-20240720   clang-18
i386                  randconfig-015-20240720   gcc-12
i386                  randconfig-016-20240720   clang-18
i386                  randconfig-016-20240720   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240720   gcc-13.2.0
loongarch             randconfig-002-20240720   gcc-13.2.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                          rb532_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240720   gcc-13.2.0
nios2                 randconfig-002-20240720   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240720   gcc-13.2.0
parisc                randconfig-002-20240720   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240720   gcc-13.2.0
powerpc               randconfig-002-20240720   gcc-13.2.0
powerpc               randconfig-003-20240720   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240720   gcc-13.2.0
powerpc64             randconfig-002-20240720   gcc-13.2.0
powerpc64             randconfig-003-20240720   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240720   gcc-13.2.0
riscv                 randconfig-002-20240720   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240720   gcc-13.2.0
s390                  randconfig-002-20240720   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240720   gcc-13.2.0
sh                    randconfig-002-20240720   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240720   gcc-13.2.0
sparc64               randconfig-002-20240720   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240720   gcc-13.2.0
um                    randconfig-002-20240720   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240720   gcc-13.2.0
xtensa                randconfig-002-20240720   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

