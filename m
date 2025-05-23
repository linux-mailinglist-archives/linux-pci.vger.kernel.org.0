Return-Path: <linux-pci+bounces-28339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA7AC2839
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771ED3A57EF
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F84211A11;
	Fri, 23 May 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/gWqpCP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30742236F8
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020159; cv=none; b=YJOM2RM0OH21QrnPZ2bZ+Fj6W3kDefxZzedWioEhkjJblTfgroNffp6sB3XCKb2fyFmaRlZ8p/x52AOPK0wh4kyhFXVZTlm6YFbOi9XIhvrCMihK2ErlPKQuEAGgfwkrrwtqAI2tfuj8mk1v2pOkcHqq0cS2Xig8OvOT/HMm1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020159; c=relaxed/simple;
	bh=K3vXVcnQcVKpSxMenPFi3K8iLR+/f4lbckLz1CwNpe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g62bPH6OvExDTD6RqdhhaQwMCkc5/x/kEo5PNQ2QqIDqkjDbOkMsEyUJwiAP8isc8v+SdOf1KJZiP25sxsJRlb6akDO3sNyy9Uw+0dgwA+W5BLURCysr+tf2ouzB1NY0Vx6UnlZeepu/rADHlS75uffyjggyjGuPD1JcVPHWC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/gWqpCP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748020158; x=1779556158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K3vXVcnQcVKpSxMenPFi3K8iLR+/f4lbckLz1CwNpe4=;
  b=Y/gWqpCPeXEeDa4GxbmhWGDperpX4uCgxsWNJrFrDIbZzJSVM2vPbciK
   dcvyWiAC4ZLSNQXbTFT1rGwR8PJdVXLfyWhE2zt+uskJ6pQn4HYXWs0Yh
   CrRjAVTPy4L73wPjd16ok38GcGp0tG4XBQxPz8FAroUyEmOzM2yJPUy9v
   OCehEdeBtBNSRRFLgLSPPtyh1ZrgulhOmJPvX9xoggp00GBmrifo+Z67o
   mcw6Qk3QaRhtSQKEtjZJU7CnZ0fgNAaWb1PeDxdONIECllOSSVoj/mcOu
   1KoQ7yz/8+CtxNKDgdnPOENLsxapBFoZSY+zHbmmBIhhnbnMK+8DpIqbd
   A==;
X-CSE-ConnectionGUID: 5kaF6fN+Svq69NGvL+xhQA==
X-CSE-MsgGUID: XXmvGfXnS/Gvr39dCIULCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50007228"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="50007228"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:09:16 -0700
X-CSE-ConnectionGUID: jzyg6Di9QHWl94oM/AGc5A==
X-CSE-MsgGUID: 108zMnSuRHW6AyLIxrJPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="146196146"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 May 2025 10:09:14 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIVtQ-000QbW-1F;
	Fri, 23 May 2025 17:09:12 +0000
Date: Sat, 24 May 2025 01:08:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 0e99ca5ffb8b1716723e3b645e38d56448183ecd
Message-ID: <202505240133.UzI909ZM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 0e99ca5ffb8b1716723e3b645e38d56448183ecd  arm64: Kconfig: switch to HAVE_PWRCTRL

elapsed time: 1449m

configs tested: 218
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20250523    clang-16
arc                   randconfig-001-20250523    gcc-15.1.0
arc                   randconfig-002-20250523    clang-16
arc                   randconfig-002-20250523    gcc-10.5.0
arc                           tb10x_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                        clps711x_defconfig    gcc-14.2.0
arm                   randconfig-001-20250523    clang-16
arm                   randconfig-002-20250523    clang-16
arm                   randconfig-002-20250523    gcc-8.5.0
arm                   randconfig-003-20250523    clang-16
arm                   randconfig-004-20250523    clang-16
arm                   randconfig-004-20250523    clang-21
arm                        spear3xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250523    clang-16
arm64                 randconfig-002-20250523    clang-16
arm64                 randconfig-003-20250523    clang-16
arm64                 randconfig-003-20250523    clang-21
arm64                 randconfig-004-20250523    clang-16
arm64                 randconfig-004-20250523    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250523    gcc-10.5.0
csky                  randconfig-002-20250523    gcc-10.5.0
csky                  randconfig-002-20250523    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250523    clang-21
hexagon               randconfig-001-20250523    gcc-10.5.0
hexagon               randconfig-002-20250523    clang-21
hexagon               randconfig-002-20250523    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250523    clang-20
i386        buildonly-randconfig-002-20250523    clang-20
i386        buildonly-randconfig-003-20250523    clang-20
i386        buildonly-randconfig-004-20250523    clang-20
i386        buildonly-randconfig-005-20250523    clang-20
i386        buildonly-randconfig-006-20250523    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250523    gcc-12
i386                  randconfig-002-20250523    gcc-12
i386                  randconfig-003-20250523    gcc-12
i386                  randconfig-004-20250523    gcc-12
i386                  randconfig-005-20250523    gcc-12
i386                  randconfig-006-20250523    gcc-12
i386                  randconfig-007-20250523    gcc-12
i386                  randconfig-011-20250523    gcc-12
i386                  randconfig-012-20250523    gcc-12
i386                  randconfig-013-20250523    gcc-12
i386                  randconfig-014-20250523    gcc-12
i386                  randconfig-015-20250523    gcc-12
i386                  randconfig-016-20250523    gcc-12
i386                  randconfig-017-20250523    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250523    gcc-10.5.0
loongarch             randconfig-001-20250523    gcc-15.1.0
loongarch             randconfig-002-20250523    gcc-10.5.0
loongarch             randconfig-002-20250523    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                           sun3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    gcc-14.2.0
mips                          rb532_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250523    gcc-10.5.0
nios2                 randconfig-002-20250523    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250523    gcc-10.5.0
parisc                randconfig-001-20250523    gcc-9.3.0
parisc                randconfig-002-20250523    gcc-10.5.0
parisc                randconfig-002-20250523    gcc-7.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250523    clang-21
powerpc               randconfig-001-20250523    gcc-10.5.0
powerpc               randconfig-002-20250523    clang-21
powerpc               randconfig-002-20250523    gcc-10.5.0
powerpc               randconfig-003-20250523    clang-20
powerpc               randconfig-003-20250523    gcc-10.5.0
powerpc64             randconfig-001-20250523    clang-21
powerpc64             randconfig-001-20250523    gcc-10.5.0
powerpc64             randconfig-002-20250523    clang-19
powerpc64             randconfig-002-20250523    gcc-10.5.0
powerpc64             randconfig-003-20250523    clang-21
powerpc64             randconfig-003-20250523    gcc-10.5.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250523    gcc-11.5.0
riscv                 randconfig-001-20250523    gcc-8.5.0
riscv                 randconfig-002-20250523    clang-17
riscv                 randconfig-002-20250523    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250523    gcc-11.5.0
s390                  randconfig-001-20250523    gcc-6.5.0
s390                  randconfig-002-20250523    clang-21
s390                  randconfig-002-20250523    gcc-11.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250523    gcc-11.5.0
sh                    randconfig-001-20250523    gcc-12.4.0
sh                    randconfig-002-20250523    gcc-11.5.0
sh                    randconfig-002-20250523    gcc-6.5.0
sh                           se7722_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250523    gcc-10.3.0
sparc                 randconfig-001-20250523    gcc-11.5.0
sparc                 randconfig-002-20250523    gcc-10.3.0
sparc                 randconfig-002-20250523    gcc-11.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250523    gcc-11.5.0
sparc64               randconfig-001-20250523    gcc-9.3.0
sparc64               randconfig-002-20250523    gcc-11.5.0
sparc64               randconfig-002-20250523    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250523    gcc-11.5.0
um                    randconfig-001-20250523    gcc-12
um                    randconfig-002-20250523    gcc-11.5.0
um                    randconfig-002-20250523    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250523    gcc-12
x86_64      buildonly-randconfig-002-20250523    clang-20
x86_64      buildonly-randconfig-002-20250523    gcc-12
x86_64      buildonly-randconfig-003-20250523    clang-20
x86_64      buildonly-randconfig-003-20250523    gcc-12
x86_64      buildonly-randconfig-004-20250523    clang-20
x86_64      buildonly-randconfig-004-20250523    gcc-12
x86_64      buildonly-randconfig-005-20250523    clang-20
x86_64      buildonly-randconfig-005-20250523    gcc-12
x86_64      buildonly-randconfig-006-20250523    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250523    clang-20
x86_64                randconfig-002-20250523    clang-20
x86_64                randconfig-003-20250523    clang-20
x86_64                randconfig-004-20250523    clang-20
x86_64                randconfig-005-20250523    clang-20
x86_64                randconfig-006-20250523    clang-20
x86_64                randconfig-007-20250523    clang-20
x86_64                randconfig-008-20250523    clang-20
x86_64                randconfig-071-20250523    clang-20
x86_64                randconfig-072-20250523    clang-20
x86_64                randconfig-073-20250523    clang-20
x86_64                randconfig-074-20250523    clang-20
x86_64                randconfig-075-20250523    clang-20
x86_64                randconfig-076-20250523    clang-20
x86_64                randconfig-077-20250523    clang-20
x86_64                randconfig-078-20250523    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250523    gcc-11.5.0
xtensa                randconfig-001-20250523    gcc-9.3.0
xtensa                randconfig-002-20250523    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

