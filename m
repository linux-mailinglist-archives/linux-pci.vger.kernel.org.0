Return-Path: <linux-pci+bounces-10566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32FD938088
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F02AB2136B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E004CE09;
	Sat, 20 Jul 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIQB64L+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBE29A2
	for <linux-pci@vger.kernel.org>; Sat, 20 Jul 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721468950; cv=none; b=QE49/YRUvJMNiTsqx7eKMJSZiB5X7CBCoVoK9Cg+G526mKlD4sNGECTCmoaks/sX+UlUQyhpMTKOyqoBuwHr9wEwqMrOOLWxqF+o9GfskIZCuDmWV/J94BAVSVCZHL2WpTPNwpNCGZNvIZwfEX6eGjQXBHjEVNoOqLcOumRsTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721468950; c=relaxed/simple;
	bh=jS9W1MssTUzsQWpyEDjy+CPj7dqkX61+xMjMDdgURYY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IppAyW9aiEerJOE62rDM3SHzfw01bTHuyC5pCmN4r8NxhpljaXI9CjUhhLkhTLdoNvKN5wb26/+rCfFGkDxVnDuD+FVOj33M4317b2xxcThSg0fEtd8SoKRAhiVmkqXmkYSG67CkguYAX7o11xBoUSxyCctum9bFPgBl/8YBHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIQB64L+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721468949; x=1753004949;
  h=date:from:to:cc:subject:message-id;
  bh=jS9W1MssTUzsQWpyEDjy+CPj7dqkX61+xMjMDdgURYY=;
  b=aIQB64L+3whRVRLbYlwgoNPwR2jvBLo8ikZMiUWYBlrffEWZsJ2wkfaw
   moNUqU7t4aV42gKDnmbAYL48Me+NGclLJeNYj1sdNzHiUBEQD769FvHMe
   bcyUPVWGKjq9pWFb0TiXfkjVT81O70LfxuVMQnnAHqtqqxCIHaf34UUwU
   9YXnet0Jh5cQXv8J8OTkY3ArKxjI/iaRHFl4IX304xZxnCvfM+HkFVcEE
   LwrQA2QjbZza5pEVPCHekeGgU0ZetcMmCXTZzfq64dIKgNsd1c2AtQfvo
   1/0sg9TL/GrP9vbXLN1SCokLBiq4CD003yhcnz1ITUmLMj5CQTb/HsJqE
   A==;
X-CSE-ConnectionGUID: MRRfZrx+QHKwctOdPFokJg==
X-CSE-MsgGUID: pMhujL7RQNeVSuKzbKhmTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="18799182"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="18799182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 02:49:08 -0700
X-CSE-ConnectionGUID: KWMDaWQlTLaPSDr/S6H0ew==
X-CSE-MsgGUID: LFpqT9vqTzyj2bqotfe7pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="51628743"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Jul 2024 02:49:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sV6i8-000j5G-0h;
	Sat, 20 Jul 2024 09:49:04 +0000
Date: Sat, 20 Jul 2024 17:48:08 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 45659274e60864f9acabba844468e405362bdc8c
Message-ID: <202407201705.vMWE0Q4q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 45659274e60864f9acabba844468e405362bdc8c  Merge branch 'pci/misc'

elapsed time: 1047m

configs tested: 211
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240720   gcc-13.2.0
arc                   randconfig-002-20240720   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-14.1.0
arm                          pxa168_defconfig   clang-19
arm                   randconfig-001-20240720   clang-15
arm                   randconfig-002-20240720   gcc-14.1.0
arm                   randconfig-003-20240720   gcc-14.1.0
arm                   randconfig-004-20240720   gcc-14.1.0
arm                        shmobile_defconfig   gcc-14.1.0
arm                           stm32_defconfig   gcc-13.2.0
arm                        vexpress_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240720   gcc-14.1.0
arm64                 randconfig-002-20240720   clang-17
arm64                 randconfig-003-20240720   gcc-14.1.0
arm64                 randconfig-004-20240720   clang-19
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240720   gcc-14.1.0
csky                  randconfig-002-20240720   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240720   clang-16
hexagon               randconfig-002-20240720   clang-19
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
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240720   gcc-14.1.0
loongarch             randconfig-002-20240720   gcc-14.1.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     decstation_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   clang-19
mips                           ip32_defconfig   clang-19
mips                       lemote2f_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   clang-14
mips                          rb532_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240720   gcc-14.1.0
nios2                 randconfig-002-20240720   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240720   gcc-14.1.0
parisc                randconfig-002-20240720   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                     asp8347_defconfig   clang-17
powerpc                 mpc832x_rdb_defconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240720   clang-19
powerpc               randconfig-002-20240720   clang-19
powerpc               randconfig-003-20240720   gcc-14.1.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240720   clang-19
powerpc64             randconfig-002-20240720   clang-19
powerpc64             randconfig-003-20240720   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240720   clang-19
riscv                 randconfig-002-20240720   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240720   gcc-14.1.0
s390                  randconfig-002-20240720   clang-15
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-14.1.0
sh                     magicpanelr2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240720   gcc-14.1.0
sh                    randconfig-002-20240720   gcc-14.1.0
sh                   rts7751r2dplus_defconfig   gcc-14.1.0
sh                             sh03_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240720   gcc-14.1.0
sparc64               randconfig-002-20240720   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240720   gcc-13
um                    randconfig-002-20240720   clang-15
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240720   clang-18
x86_64       buildonly-randconfig-002-20240720   gcc-13
x86_64       buildonly-randconfig-003-20240720   clang-18
x86_64       buildonly-randconfig-004-20240720   clang-18
x86_64       buildonly-randconfig-005-20240720   gcc-13
x86_64       buildonly-randconfig-006-20240720   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240720   clang-18
x86_64                randconfig-002-20240720   gcc-13
x86_64                randconfig-003-20240720   clang-18
x86_64                randconfig-004-20240720   clang-18
x86_64                randconfig-005-20240720   clang-18
x86_64                randconfig-006-20240720   gcc-13
x86_64                randconfig-011-20240720   gcc-13
x86_64                randconfig-012-20240720   clang-18
x86_64                randconfig-013-20240720   gcc-13
x86_64                randconfig-014-20240720   clang-18
x86_64                randconfig-015-20240720   gcc-13
x86_64                randconfig-016-20240720   gcc-13
x86_64                randconfig-071-20240720   clang-18
x86_64                randconfig-072-20240720   gcc-13
x86_64                randconfig-073-20240720   gcc-13
x86_64                randconfig-074-20240720   gcc-9
x86_64                randconfig-075-20240720   gcc-13
x86_64                randconfig-076-20240720   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240720   gcc-14.1.0
xtensa                randconfig-002-20240720   gcc-14.1.0
xtensa                         virt_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

