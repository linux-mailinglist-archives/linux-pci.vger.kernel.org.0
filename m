Return-Path: <linux-pci+bounces-10874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADBF93DF35
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E758F1C21301
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16457CB1;
	Sat, 27 Jul 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpFuPeKg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55C4D8BA
	for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722081990; cv=none; b=c9TOxPeNcz0LlW/rLPOLD8IjMQM/gb48eW2myVuHjRS8/IIIIp+kl6Jassm+W24NW2V+OlFkb+SJpVED49mQBFrNqaRNuBkBGaz1CT59EDYr2g0v1eqomiIpKpOYfdW1EYlBC0eZIG9TCq6Gr8RTCUq8we9IzSIsottY1Cj2HqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722081990; c=relaxed/simple;
	bh=QccdcE6m5zrm9iFYH0Mhxr+Yjm9N5KWYfal3o27aTlo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d7CbUyg4YtzOucaAvCTZt1e69glhrgXzsbMSADPqIP/4rLWPktebaIhVO+vigmMALDUB3FTAcArgyuOn8fWZx3SWDKz02WrEQRUAxEOVvNulYIC2G07JSapqLqsWd7k1yiSkU7+MBmQYzg7zlaUZ40RYAtrWhAI+VzpzPBJ7X6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpFuPeKg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722081988; x=1753617988;
  h=date:from:to:cc:subject:message-id;
  bh=QccdcE6m5zrm9iFYH0Mhxr+Yjm9N5KWYfal3o27aTlo=;
  b=MpFuPeKgsKpfbJMjEbYLor4FFnt6eGdL3IAYUCreWSg+Kiduawc8N1U0
   v71sWnjWLKrEU7gYjSl4TMGoyajx3RhlnZyV0S7voo1WEGaXOfHJHAX45
   VjhDtiJdhqi6oP9pHOS1eyqPRE+WH6yaRJ+Sw56k1sFP0IrXnaVVsa0g7
   11F3qIeGEoZzscaBn41VhKoPPaLFh4xPTyhn0uG3AleuvZsaI1GMKlVIL
   qEyXSvPu5AY1Ow6nI8+n+CcdiGTxwMx7wHtlDmuQZnl63Y6o9urNRb/cs
   3XePHQKspaMPVj7C7CBjE4tQlPnI1EgWhrFPLqTaefGNJaBITNd1bkk6M
   Q==;
X-CSE-ConnectionGUID: sqCbL5h8SgK4F2CJfQOo6A==
X-CSE-MsgGUID: SWgeS8WqSDukx3+13zaO8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="31275435"
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="31275435"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 05:06:27 -0700
X-CSE-ConnectionGUID: rNO99puoSteIkiK6lqQq8g==
X-CSE-MsgGUID: JJTMU7tFQ9yQ8HRo3Q2JuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="58615566"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Jul 2024 05:06:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXgBr-000pva-3D;
	Sat, 27 Jul 2024 12:06:23 +0000
Date: Sat, 27 Jul 2024 20:06:08 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 e8c0bc041bd69a1c7506e875846dc44285ced153
Message-ID: <202407272005.Vz65cAcr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: e8c0bc041bd69a1c7506e875846dc44285ced153  PCI: pciehp: Retain Power Indicator bits for userspace indicators

elapsed time: 987m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          pxa910_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240727   clang-18
i386         buildonly-randconfig-002-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-8
i386         buildonly-randconfig-004-20240727   gcc-10
i386         buildonly-randconfig-004-20240727   gcc-13
i386         buildonly-randconfig-005-20240727   clang-18
i386         buildonly-randconfig-005-20240727   gcc-13
i386         buildonly-randconfig-006-20240727   clang-18
i386         buildonly-randconfig-006-20240727   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240727   clang-18
i386                  randconfig-001-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-8
i386                  randconfig-003-20240727   clang-18
i386                  randconfig-003-20240727   gcc-13
i386                  randconfig-004-20240727   clang-18
i386                  randconfig-004-20240727   gcc-13
i386                  randconfig-005-20240727   clang-18
i386                  randconfig-005-20240727   gcc-13
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240727   gcc-11
i386                  randconfig-013-20240727   gcc-13
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240727   clang-18
i386                  randconfig-015-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-7
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-13.2.0
mips                     loongson1b_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
s390                             alldefconfig   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240727   gcc-8
x86_64       buildonly-randconfig-002-20240727   gcc-13
x86_64       buildonly-randconfig-002-20240727   gcc-8
x86_64       buildonly-randconfig-003-20240727   gcc-13
x86_64       buildonly-randconfig-003-20240727   gcc-8
x86_64       buildonly-randconfig-004-20240727   gcc-13
x86_64       buildonly-randconfig-004-20240727   gcc-8
x86_64       buildonly-randconfig-005-20240727   clang-18
x86_64       buildonly-randconfig-005-20240727   gcc-8
x86_64       buildonly-randconfig-006-20240727   gcc-13
x86_64       buildonly-randconfig-006-20240727   gcc-8
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240727   gcc-13
x86_64                randconfig-001-20240727   gcc-8
x86_64                randconfig-002-20240727   clang-18
x86_64                randconfig-002-20240727   gcc-8
x86_64                randconfig-003-20240727   clang-18
x86_64                randconfig-003-20240727   gcc-8
x86_64                randconfig-004-20240727   clang-18
x86_64                randconfig-004-20240727   gcc-8
x86_64                randconfig-005-20240727   gcc-13
x86_64                randconfig-005-20240727   gcc-8
x86_64                randconfig-006-20240727   clang-18
x86_64                randconfig-006-20240727   gcc-8
x86_64                randconfig-011-20240727   gcc-13
x86_64                randconfig-011-20240727   gcc-8
x86_64                randconfig-012-20240727   gcc-13
x86_64                randconfig-012-20240727   gcc-8
x86_64                randconfig-013-20240727   clang-18
x86_64                randconfig-013-20240727   gcc-8
x86_64                randconfig-014-20240727   gcc-10
x86_64                randconfig-014-20240727   gcc-8
x86_64                randconfig-015-20240727   gcc-12
x86_64                randconfig-015-20240727   gcc-8
x86_64                randconfig-016-20240727   gcc-10
x86_64                randconfig-016-20240727   gcc-8
x86_64                randconfig-071-20240727   gcc-13
x86_64                randconfig-071-20240727   gcc-8
x86_64                randconfig-072-20240727   gcc-13
x86_64                randconfig-072-20240727   gcc-8
x86_64                randconfig-073-20240727   gcc-8
x86_64                randconfig-074-20240727   gcc-8
x86_64                randconfig-075-20240727   clang-18
x86_64                randconfig-075-20240727   gcc-8
x86_64                randconfig-076-20240727   clang-18
x86_64                randconfig-076-20240727   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                generic_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

