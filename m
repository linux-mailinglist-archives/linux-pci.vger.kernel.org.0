Return-Path: <linux-pci+bounces-13014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C732297439E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 21:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96A81C24C31
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4581A42A4;
	Tue, 10 Sep 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzFwMNlh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C412CD96
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997385; cv=none; b=uiMn3M0ThGWTa5xv0//wi67uNoLCrzNQq8YLM54UOKa8W/muDO8KhKIvmFIZy0vd3qEeQLVHEf0dTWDr6L2dJk7FXAk5Vop/5qRMhCrntwKRFyhpr509MGxjs4zhPwmu17HdwoCjXQqBUV5npDCwC9UmtFmSCz+NPltFqeRhs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997385; c=relaxed/simple;
	bh=bsEKtDv1Gr1MzCfLiwMAZ27r9uD8kCeHW6cB1DvRGsM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KyfoQE4x9KyRtIJPImUOg581L7Nslnf7Nf2wkKvKjFvyuMI91e9iJfHKmYYpyfQCSFXAPr9ysVZmKV3oJTtgBAE3dB5qWF7fsBJnqKcamyiEF1C/Oz2N9nRm6tfayDtSbGsFoKeXkUX60O5P4faXN5kNRW54eChGcV0oduiMTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzFwMNlh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725997383; x=1757533383;
  h=date:from:to:cc:subject:message-id;
  bh=bsEKtDv1Gr1MzCfLiwMAZ27r9uD8kCeHW6cB1DvRGsM=;
  b=CzFwMNlhJt2+Kn4Ue3r/yK3Ykm8PeVdmQmW3qQSTGUHSai0MNxFeRG6v
   4ieDk7k5QTjzdzT5Hmgf2ZgcgqkpknPBs4wSnbq1wnDg8G0zNY5Mk4UWE
   wSveYU2s0PpgExC0b6XcI6shxS0HhT5JYIbcpomQ/QSfcGg0AsmCdb4DT
   L8yGC8TFmMr9h+bHGe6EfWx/Nir9woQtm/4sqJEfGRiMUkdjWcpEuNCho
   XtfdTdTQfxG/JNnb8upEQ6/hUJHROqZSncadFuwCwxY0gv4BbQ/yDqizh
   19XsOGzskaBWOF67IgAvni3YT6zE1x0WEulPNPAAb5lsPGIUHG4BeZP+9
   Q==;
X-CSE-ConnectionGUID: pK2FKMORSiuPo24MY9MzEA==
X-CSE-MsgGUID: 1sS60ON3QdW/DT0DT/Fm+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24314806"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24314806"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 12:43:02 -0700
X-CSE-ConnectionGUID: W1/uyCAlREWpJekT4i0KsA==
X-CSE-MsgGUID: wFd4oSgrR9qlYcxpuTh9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="66774234"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2024 12:43:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so6lP-0002Xc-0g;
	Tue, 10 Sep 2024 19:42:59 +0000
Date: Wed, 11 Sep 2024 03:42:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:crs] BUILD SUCCESS
 0b778d31a16072f3078a762404635229619a8ca5
Message-ID: <202409110312.G6fo1P04-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git crs
branch HEAD: 0b778d31a16072f3078a762404635229619a8ca5  PCI: Rename CRS Completion Status to RRS

elapsed time: 1088m

configs tested: 149
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                     haps_hs_smp_defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      integrator_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                         orion5x_defconfig   gcc-14.1.0
arm                           sama7_defconfig   clang-20
arm                        spear3xx_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240910   clang-18
i386         buildonly-randconfig-002-20240910   clang-18
i386         buildonly-randconfig-003-20240910   clang-18
i386         buildonly-randconfig-004-20240910   clang-18
i386         buildonly-randconfig-005-20240910   clang-18
i386         buildonly-randconfig-006-20240910   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240910   clang-18
i386                  randconfig-002-20240910   clang-18
i386                  randconfig-003-20240910   clang-18
i386                  randconfig-004-20240910   clang-18
i386                  randconfig-005-20240910   clang-18
i386                  randconfig-006-20240910   clang-18
i386                  randconfig-011-20240910   clang-18
i386                  randconfig-012-20240910   clang-18
i386                  randconfig-013-20240910   clang-18
i386                  randconfig-014-20240910   clang-18
i386                  randconfig-015-20240910   clang-18
i386                  randconfig-016-20240910   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   clang-20
m68k                       bvme6000_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5275evb_defconfig   gcc-14.1.0
m68k                            mac_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson2k_defconfig   clang-20
mips                      loongson3_defconfig   gcc-14.1.0
mips                      pic32mzda_defconfig   clang-20
mips                       rbtx49xx_defconfig   clang-20
mips                           xway_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                         alldefconfig   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   clang-20
powerpc                       eiger_defconfig   clang-20
powerpc                     ep8248e_defconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   clang-20
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig   gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          rsk7264_defconfig   gcc-14.1.0
sh                           se7721_defconfig   gcc-14.1.0
sh                   sh7770_generic_defconfig   gcc-14.1.0
sh                        sh7785lcr_defconfig   clang-20
sh                            titan_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240910   gcc-12
x86_64       buildonly-randconfig-002-20240910   gcc-12
x86_64       buildonly-randconfig-003-20240910   gcc-12
x86_64       buildonly-randconfig-004-20240910   gcc-12
x86_64       buildonly-randconfig-005-20240910   gcc-12
x86_64       buildonly-randconfig-006-20240910   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240910   gcc-12
x86_64                randconfig-002-20240910   gcc-12
x86_64                randconfig-003-20240910   gcc-12
x86_64                randconfig-004-20240910   gcc-12
x86_64                randconfig-005-20240910   gcc-12
x86_64                randconfig-006-20240910   gcc-12
x86_64                randconfig-011-20240910   gcc-12
x86_64                randconfig-012-20240910   gcc-12
x86_64                randconfig-013-20240910   gcc-12
x86_64                randconfig-014-20240910   gcc-12
x86_64                randconfig-015-20240910   gcc-12
x86_64                randconfig-016-20240910   gcc-12
x86_64                randconfig-071-20240910   gcc-12
x86_64                randconfig-072-20240910   gcc-12
x86_64                randconfig-073-20240910   gcc-12
x86_64                randconfig-074-20240910   gcc-12
x86_64                randconfig-075-20240910   gcc-12
x86_64                randconfig-076-20240910   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

