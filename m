Return-Path: <linux-pci+bounces-9768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0739926D30
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 03:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F552812FD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2DA4C76;
	Thu,  4 Jul 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxlGMYh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96CC125
	for <linux-pci@vger.kernel.org>; Thu,  4 Jul 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057479; cv=none; b=mHUVfLGYoKhfWpf6U71bWcDaYA+gTJMQ4PW6dlgcEDH3ZPTd7XpiI41DGDMlYmbPWcptXkHTW8MP/bc/cgsFXX64uBa9u00rseajBdEwR7yWfKgPYd7OzrWXkkZ1FtweFMe+wk7X5ibF6Yqk+WdXdtRJrFxGRdC9ttRKLKfcpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057479; c=relaxed/simple;
	bh=lGQPQ8kjbnSw9UOEXSPHw18zTl3uHf0lZSVwvwWul9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tjz7IO0Q3M/nRfZ2CqQbndBWh4/tdCfd1drmeizW++e1H9LSVN0npnVFbeIKq7P4rxIfha6Ow1Z6z8z7M9hLVK/j31hm3JLPkvq1iVURYikc6UICi8Cozfq/ueC3WmsElGHcz9XohA91ja9Z6E5QL+h8d1mcVy8uZpl/i9gUcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxlGMYh8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720057478; x=1751593478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lGQPQ8kjbnSw9UOEXSPHw18zTl3uHf0lZSVwvwWul9M=;
  b=KxlGMYh8GQTq7jbrgnQdz9qe1KTXfXe4iuq83s5R2MdI9VoiraU1CdVY
   2t6zVaBZmj6biXLCJMp0QKYeJ/ZLORaFgmFRcq8T2FxFAh9qPZEebpSPq
   N3LjXP6SBlncSPXSmEyfSfwPQpcU2GYW5Gm87o97PX02KwXNha+pqiyQz
   f0b+Airt6DcxKKG7uICRLd251SVNo4enYpBvRStdmAifcmpzKVG6BRh2W
   KRuXsUbhD+AQ5gwY/jU3LhdtUkbLeBxpXU+mly037KDyUOL7v6ACGe7we
   d/SUs0nUg9ljEi1tgVfp+dcXYhIE3IHg4n5FJ/rxGeXPti8i1v+ExCLzQ
   Q==;
X-CSE-ConnectionGUID: bjPPAiydTP2r/wk8bB1TGA==
X-CSE-MsgGUID: Em3+lk/HTCiocPYHl3Fs9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="28706658"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28706658"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:44:38 -0700
X-CSE-ConnectionGUID: RnhjqnTQQlma5IthKRzywQ==
X-CSE-MsgGUID: low2jFbPR6CNZPAXcL5bPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="69640023"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jul 2024 18:44:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPBWU-000QPb-1d;
	Thu, 04 Jul 2024 01:44:34 +0000
Date: Thu, 04 Jul 2024 09:44:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 9d65d17606aae4e7070f2c0cf9dc6b8b64129bbe
Message-ID: <202407040911.ARc2lDAX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 9d65d17606aae4e7070f2c0cf9dc6b8b64129bbe  PCI: endpoint: Fix error handling in epf_ntb_epc_cleanup()

elapsed time: 1460m

configs tested: 188
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240703   gcc-13.2.0
arc                   randconfig-002-20240703   gcc-13.2.0
arm                              alldefconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                          collie_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                   randconfig-001-20240703   gcc-13.2.0
arm                   randconfig-002-20240703   gcc-13.2.0
arm                   randconfig-003-20240703   gcc-13.2.0
arm                   randconfig-004-20240703   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-13.2.0
arm                        spear3xx_defconfig   gcc-13.2.0
arm                       versatile_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240703   gcc-13.2.0
arm64                 randconfig-002-20240703   gcc-13.2.0
arm64                 randconfig-003-20240703   gcc-13.2.0
arm64                 randconfig-004-20240703   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240703   gcc-13.2.0
csky                  randconfig-002-20240703   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240703   clang-18
i386         buildonly-randconfig-003-20240703   clang-18
i386         buildonly-randconfig-004-20240703   clang-18
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240703   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240703   clang-18
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240703   clang-18
i386                  randconfig-004-20240703   clang-18
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240703   clang-18
i386                  randconfig-011-20240703   clang-18
i386                  randconfig-012-20240703   clang-18
i386                  randconfig-013-20240703   clang-18
i386                  randconfig-014-20240703   clang-18
i386                  randconfig-015-20240703   clang-18
i386                  randconfig-016-20240703   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240703   gcc-13.2.0
loongarch             randconfig-002-20240703   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         amcore_defconfig   gcc-13.2.0
m68k                          atari_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          eyeq5_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                           mtx1_defconfig   gcc-13.2.0
mips                          rm200_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240703   gcc-13.2.0
nios2                 randconfig-002-20240703   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                  or1klitex_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240703   gcc-13.2.0
parisc                randconfig-002-20240703   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   gcc-13.2.0
powerpc                      ppc40x_defconfig   gcc-13.2.0
powerpc               randconfig-003-20240703   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240703   gcc-13.2.0
powerpc64             randconfig-002-20240703   gcc-13.2.0
powerpc64             randconfig-003-20240703   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240703   gcc-13.2.0
riscv                 randconfig-002-20240703   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240703   gcc-13.2.0
s390                  randconfig-002-20240703   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                               j2_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                    randconfig-001-20240703   gcc-13.2.0
sh                    randconfig-002-20240703   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240703   gcc-13.2.0
sparc64               randconfig-002-20240703   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240703   gcc-13.2.0
um                    randconfig-002-20240703   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                           alldefconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240703   clang-18
x86_64       buildonly-randconfig-002-20240703   clang-18
x86_64       buildonly-randconfig-003-20240703   clang-18
x86_64       buildonly-randconfig-004-20240703   clang-18
x86_64       buildonly-randconfig-005-20240703   clang-18
x86_64       buildonly-randconfig-006-20240703   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240703   clang-18
x86_64                randconfig-002-20240703   clang-18
x86_64                randconfig-003-20240703   clang-18
x86_64                randconfig-004-20240703   clang-18
x86_64                randconfig-005-20240703   clang-18
x86_64                randconfig-006-20240703   clang-18
x86_64                randconfig-011-20240703   clang-18
x86_64                randconfig-012-20240703   clang-18
x86_64                randconfig-013-20240703   clang-18
x86_64                randconfig-014-20240703   clang-18
x86_64                randconfig-015-20240703   clang-18
x86_64                randconfig-016-20240703   clang-18
x86_64                randconfig-071-20240703   clang-18
x86_64                randconfig-072-20240703   clang-18
x86_64                randconfig-073-20240703   clang-18
x86_64                randconfig-074-20240703   clang-18
x86_64                randconfig-075-20240703   clang-18
x86_64                randconfig-076-20240703   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240703   gcc-13.2.0
xtensa                randconfig-002-20240703   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

