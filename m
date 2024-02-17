Return-Path: <linux-pci+bounces-3660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65E8590A0
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 16:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449731C212A4
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7365BCA;
	Sat, 17 Feb 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggcMW9vM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF377C6D2
	for <linux-pci@vger.kernel.org>; Sat, 17 Feb 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184756; cv=none; b=Y6j/IQYjXOIIAKrT726fHwf2icF0YS/9n+IQmAwPFMBQZRVIHWSNwXksqoo68DYUlUZA9wufn8JKsR0VmWKLKwOzy5E9Vod/HDsObzegtDrh34dIQ0RudJuk6V5Npr4HICKg/RrmM/K2BRjqqVNDe0glm2wPeghQ138ndIyujN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184756; c=relaxed/simple;
	bh=6u1Gj6rDC0zeExWnz1c3YWYwO3VAZ0p27IWBWPxn/oQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r9sdhCyX4aS/wExvQlmq5r3cIXmp8JzeJ/BypA2zpx61y+tTENpI10G9XAGYF/3nd/r45doa6qtWzPmoNrQ/fCrWOe9dhhS1P/SFWZ1oo6ffXNqMpuFsv527JAbWKzmwKEpjFbVuaRkU7US7ee8PvRjBRBlh165x068ww+UAFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggcMW9vM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708184755; x=1739720755;
  h=date:from:to:cc:subject:message-id;
  bh=6u1Gj6rDC0zeExWnz1c3YWYwO3VAZ0p27IWBWPxn/oQ=;
  b=ggcMW9vMbiLxIUDCaKM24omN1PWtPdtyEOvmMrpdxnBeLeqVM7Wlg88f
   iru4BWI51+wkOweHl04UKlDnDKZM2oNgZTv4JsqQYinoA3Ke/XI3RCaHE
   UpYPsY1veuhS+SfmpEK0mwQe7aFbFPz0nA+WusbQXB3oqkFmy6Q1AB3qS
   D+VHHrrtkKc4m7NuOkcW8S++QbBp/Ml0EAViWV5QRzKYq5roh2vGHub76
   jjcR2MetGqae9ALkTjh/I9IA8/azzJ0ITKQpyajOkc903oGsMBHBygpqu
   lQSJ4Wrt+UH/Kwz0+/yfspFP1VJ49/ILWtPTP/yk0iMTfgN1237tTrlP3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="12854507"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="12854507"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 07:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="8791452"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 17 Feb 2024 07:45:53 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbMsw-0002Ce-1h;
	Sat, 17 Feb 2024 15:45:50 +0000
Date: Sat, 17 Feb 2024 23:45:23 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 9266514689fe6476423209ee40168db53134101d
Message-ID: <202402172320.AtdEbmfM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 9266514689fe6476423209ee40168db53134101d  PCI: endpoint: Drop only_64bit on reserved BARs

elapsed time: 1449m

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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             pxa_defconfig   gcc  
arm                         s5pv210_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240217   gcc  
i386         buildonly-randconfig-002-20240217   clang
i386         buildonly-randconfig-003-20240217   gcc  
i386         buildonly-randconfig-004-20240217   gcc  
i386         buildonly-randconfig-005-20240217   gcc  
i386         buildonly-randconfig-006-20240217   clang
i386                                defconfig   clang
i386                  randconfig-001-20240217   gcc  
i386                  randconfig-002-20240217   gcc  
i386                  randconfig-003-20240217   clang
i386                  randconfig-004-20240217   gcc  
i386                  randconfig-005-20240217   gcc  
i386                  randconfig-006-20240217   clang
i386                  randconfig-011-20240217   gcc  
i386                  randconfig-012-20240217   gcc  
i386                  randconfig-013-20240217   clang
i386                  randconfig-014-20240217   clang
i386                  randconfig-015-20240217   clang
i386                  randconfig-016-20240217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
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
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240217   gcc  
x86_64       buildonly-randconfig-002-20240217   clang
x86_64       buildonly-randconfig-003-20240217   gcc  
x86_64       buildonly-randconfig-004-20240217   gcc  
x86_64       buildonly-randconfig-005-20240217   clang
x86_64       buildonly-randconfig-006-20240217   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240217   gcc  
x86_64                randconfig-002-20240217   clang
x86_64                randconfig-003-20240217   clang
x86_64                randconfig-004-20240217   clang
x86_64                randconfig-005-20240217   clang
x86_64                randconfig-006-20240217   clang
x86_64                randconfig-011-20240217   gcc  
x86_64                randconfig-012-20240217   gcc  
x86_64                randconfig-013-20240217   clang
x86_64                randconfig-014-20240217   gcc  
x86_64                randconfig-015-20240217   gcc  
x86_64                randconfig-016-20240217   clang
x86_64                randconfig-071-20240217   gcc  
x86_64                randconfig-072-20240217   gcc  
x86_64                randconfig-073-20240217   gcc  
x86_64                randconfig-074-20240217   clang
x86_64                randconfig-075-20240217   gcc  
x86_64                randconfig-076-20240217   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

