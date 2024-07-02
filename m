Return-Path: <linux-pci+bounces-9613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD56924C19
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 01:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930551C2169C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E791591E0;
	Tue,  2 Jul 2024 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEHioOcs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14591DA30B
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962745; cv=none; b=qO7PWs5JGmf39QTMPSgQHKIFCpkcGQT4q30EpImxwB4lvah4ZaVCoImtuhpnEdQGQiey/Fre6YZ+HrxGemf9hxh4C2sW2RDmarOVtnSs0WZ74NhceyTuUenJMGVlVuVU+cY7wwG03XOYncwXCrNQdE7JcYjQxqcsopY+F0mavmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962745; c=relaxed/simple;
	bh=kRNhN84d4NEElyCeKLlK7HeGb3hCIX22s0CtxI4K1GM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fKowG6MW67LmvE1t6gkLm41ZRU6j9WBREWq/x1cXEcga1Rkfd7fhZumZCzr/LJxzElFRhCTw3r4vzwE5dCVC8Nf2RahZsEnmWQb8Bne9YHUddXIf+60TKQGj1DPVhXx69I9YIGQ1SC7+4PcL8NdHRuLM33XIQKq7tlwJQLg/c3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEHioOcs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719962744; x=1751498744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kRNhN84d4NEElyCeKLlK7HeGb3hCIX22s0CtxI4K1GM=;
  b=lEHioOcs3xLgzI0bMGtXu1e6EUsTxvqnlNLDG1zftwYtkw6dtywxLVF3
   fwBZ9DRFY98f9v64mjJ7iRJ0nshJt9zgKbfjJ69RlQb2u84uICodGozYL
   SfMw0nulScDJYjAcz0zbyVvL1xg/l5gnoMHLeQqTtkCBgp1dbDPZn8TH4
   sNzzl8HqTeQ+sbB2TrUbfqW9dIJgCmBfo0xc6hIevn7UMSxirP47MA97R
   X3iJpVDN/V6RT+C/SBzfIu2sxRSCbeXCF8TK8wq+0Nbwxk0gx4z2vxeSi
   oN3FPiSYfwe13Z7zgS3VoFffuBy/fqGTyaVcvntLl48nAjLXIMSlg30Ez
   w==;
X-CSE-ConnectionGUID: No3HUFmCRnOr/PnsVBWOcA==
X-CSE-MsgGUID: G/j+LMOkRuumvSqZCe5RCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17005700"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17005700"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 16:25:43 -0700
X-CSE-ConnectionGUID: 5LxMXdqVSx6I8cgNZSXy5g==
X-CSE-MsgGUID: dsvRhLUTTAy23aR35VwCbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="77207657"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Jul 2024 16:25:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOmsW-000Oug-0c;
	Tue, 02 Jul 2024 23:25:40 +0000
Date: Wed, 03 Jul 2024 07:25:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 87451d7035ac089ca3118cf01f250e7788a4c2f2
Message-ID: <202407030706.YrqBF3z2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 87451d7035ac089ca3118cf01f250e7788a4c2f2  PCI: dw-rockchip: Use pci_epc_init_notify() directly

elapsed time: 1476m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                          collie_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                        spear3xx_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240702   gcc-13
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240702   gcc-10
i386         buildonly-randconfig-002-20240702   gcc-13
i386         buildonly-randconfig-002-20240703   clang-18
i386         buildonly-randconfig-003-20240702   gcc-13
i386         buildonly-randconfig-003-20240703   clang-18
i386         buildonly-randconfig-004-20240702   clang-18
i386         buildonly-randconfig-004-20240702   gcc-13
i386         buildonly-randconfig-004-20240703   clang-18
i386         buildonly-randconfig-005-20240702   gcc-10
i386         buildonly-randconfig-005-20240702   gcc-13
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240702   gcc-13
i386         buildonly-randconfig-006-20240703   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240702   gcc-10
i386                  randconfig-001-20240702   gcc-13
i386                  randconfig-001-20240703   clang-18
i386                  randconfig-002-20240702   gcc-12
i386                  randconfig-002-20240702   gcc-13
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240702   gcc-13
i386                  randconfig-003-20240703   clang-18
i386                  randconfig-004-20240702   gcc-13
i386                  randconfig-004-20240703   clang-18
i386                  randconfig-005-20240702   gcc-10
i386                  randconfig-005-20240702   gcc-13
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240702   clang-18
i386                  randconfig-006-20240702   gcc-13
i386                  randconfig-006-20240703   clang-18
i386                  randconfig-011-20240702   gcc-13
i386                  randconfig-011-20240702   gcc-9
i386                  randconfig-011-20240703   clang-18
i386                  randconfig-012-20240702   clang-18
i386                  randconfig-012-20240702   gcc-13
i386                  randconfig-012-20240703   clang-18
i386                  randconfig-013-20240702   gcc-11
i386                  randconfig-013-20240702   gcc-13
i386                  randconfig-013-20240703   clang-18
i386                  randconfig-014-20240702   clang-18
i386                  randconfig-014-20240702   gcc-13
i386                  randconfig-014-20240703   clang-18
i386                  randconfig-015-20240702   clang-18
i386                  randconfig-015-20240702   gcc-13
i386                  randconfig-015-20240703   clang-18
i386                  randconfig-016-20240702   clang-18
i386                  randconfig-016-20240702   gcc-13
i386                  randconfig-016-20240703   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                           alldefconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

