Return-Path: <linux-pci+bounces-32890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B304B11015
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCCB3A5A57
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB18F58;
	Thu, 24 Jul 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2eel01s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AF1A23BB
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376390; cv=none; b=IdwzQgQNfYF8FVyzSpERauNIcNDWqaTHsEYxc+4TqLM4QJrC2p6foqbR8s7HYP3INfkcHXu75eT9pwAzqhumUD4Quoscq7xca1yv46xaTJnQSMpGwPnD7ZBSIASnyRLXporTgED2JR6q01dspQu/gLVMXh/pfzuHym/UL8+9UgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376390; c=relaxed/simple;
	bh=vvewo8/ejk2ZBmfS6jqPfQDhdxjyg7Q3FWtuh2Q6sRw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=el5yiprH45MGnK0BDNam/EwaT6bBo5fuqJRzcrzeD07ud4YrZVHGcZM2MPssDQf7KRGijCoGxJUvh7sRsdWQWuBUh6+/5W3f/y3yW+EOd0QjisL2j9slNMMPyjk4F3EdSIGaROeDBKGsV/KRFIfgsrM5js1Xn5uaD+2st1C/MqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2eel01s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753376388; x=1784912388;
  h=date:from:to:cc:subject:message-id;
  bh=vvewo8/ejk2ZBmfS6jqPfQDhdxjyg7Q3FWtuh2Q6sRw=;
  b=T2eel01spKn2cWugHezaYaGYg+XeHPtCRfJ2IPP7reaxZRfzP0PmUpGL
   NW00kmvfUz64aW3WO9jwdobXRE3YMciFQn06uIWD7BFybFfl323WOQCYf
   olwHq4Xo4baI1XPfosRE92oke8avvdR0mRzZ83XBdD2hj4/Ikbva0ZF1T
   AKjaqegRdhTcWIlfZJ8XFRLEvOCWutzAvqIBffzVXe+gx8uFIzSxZoSx3
   UUSbzFMVifArSYofIcB3iQnpixzLryZioJFQ6sMRdlCcneDl7/+XD7QLN
   ECKghGtlOCPagMgSkBEh5w3mmdvSujhzx7DDP3L7pxBKZFS65WDtbDl90
   w==;
X-CSE-ConnectionGUID: pKXhVctNR1CW0TynPkalKg==
X-CSE-MsgGUID: KBl4vrShSZ6usuKJ3eYjmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43314902"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="43314902"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 09:59:47 -0700
X-CSE-ConnectionGUID: G0LCFVatRTGMtIU6W1hR3w==
X-CSE-MsgGUID: vbrU6kiDSlS17+UFUcxh1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="164551974"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Jul 2025 09:59:46 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uezIF-000KeV-2E;
	Thu, 24 Jul 2025 16:59:43 +0000
Date: Fri, 25 Jul 2025 00:59:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 50fcd1c14e364a2d65e6049578db320d063e9fa1
Message-ID: <202507250023.b5jMXVBv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 50fcd1c14e364a2d65e6049578db320d063e9fa1  PCI: Fix typos

elapsed time: 1316m

configs tested: 230
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250724    clang-22
arc                   randconfig-001-20250724    gcc-13.4.0
arc                   randconfig-002-20250724    clang-22
arc                   randconfig-002-20250724    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-22
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250724    clang-22
arm                   randconfig-001-20250724    gcc-10.5.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250724    clang-22
arm                   randconfig-003-20250724    gcc-8.5.0
arm                   randconfig-004-20250724    clang-22
arm                   randconfig-004-20250724    gcc-12.5.0
arm                           tegra_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250724    clang-22
arm64                 randconfig-001-20250724    gcc-8.5.0
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250724    clang-22
arm64                 randconfig-003-20250724    gcc-13.4.0
arm64                 randconfig-004-20250724    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250724    gcc-13.4.0
csky                  randconfig-001-20250724    gcc-14.3.0
csky                  randconfig-002-20250724    gcc-10.5.0
csky                  randconfig-002-20250724    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250724    clang-22
hexagon               randconfig-001-20250724    gcc-14.3.0
hexagon               randconfig-002-20250724    clang-22
hexagon               randconfig-002-20250724    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250724    clang-20
i386        buildonly-randconfig-002-20250724    gcc-12
i386        buildonly-randconfig-003-20250724    clang-20
i386        buildonly-randconfig-003-20250724    gcc-12
i386        buildonly-randconfig-004-20250724    clang-20
i386        buildonly-randconfig-004-20250724    gcc-12
i386        buildonly-randconfig-005-20250724    clang-20
i386        buildonly-randconfig-005-20250724    gcc-12
i386        buildonly-randconfig-006-20250724    clang-20
i386        buildonly-randconfig-006-20250724    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250724    clang-20
i386                  randconfig-002-20250724    clang-20
i386                  randconfig-003-20250724    clang-20
i386                  randconfig-004-20250724    clang-20
i386                  randconfig-005-20250724    clang-20
i386                  randconfig-006-20250724    clang-20
i386                  randconfig-007-20250724    clang-20
i386                  randconfig-011-20250724    gcc-12
i386                  randconfig-012-20250724    gcc-12
i386                  randconfig-013-20250724    gcc-12
i386                  randconfig-014-20250724    gcc-12
i386                  randconfig-015-20250724    gcc-12
i386                  randconfig-016-20250724    gcc-12
i386                  randconfig-017-20250724    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250724    clang-22
loongarch             randconfig-001-20250724    gcc-14.3.0
loongarch             randconfig-002-20250724    gcc-13.4.0
loongarch             randconfig-002-20250724    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                          hp300_defconfig    clang-22
m68k                       m5475evb_defconfig    clang-22
m68k                        stmark2_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250724    gcc-11.5.0
nios2                 randconfig-001-20250724    gcc-14.3.0
nios2                 randconfig-002-20250724    gcc-14.3.0
nios2                 randconfig-002-20250724    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250724    gcc-14.3.0
parisc                randconfig-002-20250724    gcc-14.3.0
parisc                randconfig-002-20250724    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-22
powerpc               randconfig-001-20250724    clang-22
powerpc               randconfig-001-20250724    gcc-14.3.0
powerpc               randconfig-002-20250724    gcc-14.3.0
powerpc               randconfig-002-20250724    gcc-8.5.0
powerpc               randconfig-003-20250724    clang-22
powerpc               randconfig-003-20250724    gcc-14.3.0
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250724    clang-22
powerpc64             randconfig-001-20250724    gcc-14.3.0
powerpc64             randconfig-002-20250724    gcc-13.4.0
powerpc64             randconfig-002-20250724    gcc-14.3.0
powerpc64             randconfig-003-20250724    gcc-14.3.0
powerpc64             randconfig-003-20250724    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250724    gcc-13.4.0
riscv                 randconfig-002-20250724    gcc-13.4.0
riscv                 randconfig-002-20250724    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-12
s390                  randconfig-001-20250724    clang-22
s390                  randconfig-001-20250724    gcc-13.4.0
s390                  randconfig-002-20250724    gcc-10.5.0
s390                  randconfig-002-20250724    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250724    gcc-13.4.0
sh                    randconfig-002-20250724    gcc-13.4.0
sh                    randconfig-002-20250724    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250724    gcc-13.4.0
sparc                 randconfig-001-20250724    gcc-15.1.0
sparc                 randconfig-002-20250724    gcc-13.4.0
sparc                 randconfig-002-20250724    gcc-8.5.0
sparc                       sparc32_defconfig    clang-22
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250724    gcc-13.4.0
sparc64               randconfig-001-20250724    gcc-8.5.0
sparc64               randconfig-002-20250724    clang-22
sparc64               randconfig-002-20250724    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250724    clang-22
um                    randconfig-001-20250724    gcc-13.4.0
um                    randconfig-002-20250724    gcc-12
um                    randconfig-002-20250724    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250724    gcc-12
x86_64      buildonly-randconfig-002-20250724    clang-20
x86_64      buildonly-randconfig-002-20250724    gcc-12
x86_64      buildonly-randconfig-003-20250724    gcc-12
x86_64      buildonly-randconfig-004-20250724    gcc-12
x86_64      buildonly-randconfig-005-20250724    clang-20
x86_64      buildonly-randconfig-005-20250724    gcc-12
x86_64      buildonly-randconfig-006-20250724    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250724    gcc-12
x86_64                randconfig-002-20250724    gcc-12
x86_64                randconfig-003-20250724    gcc-12
x86_64                randconfig-004-20250724    gcc-12
x86_64                randconfig-005-20250724    gcc-12
x86_64                randconfig-006-20250724    gcc-12
x86_64                randconfig-007-20250724    gcc-12
x86_64                randconfig-008-20250724    gcc-12
x86_64                randconfig-071-20250724    clang-20
x86_64                randconfig-072-20250724    clang-20
x86_64                randconfig-073-20250724    clang-20
x86_64                randconfig-074-20250724    clang-20
x86_64                randconfig-075-20250724    clang-20
x86_64                randconfig-076-20250724    clang-20
x86_64                randconfig-077-20250724    clang-20
x86_64                randconfig-078-20250724    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250724    gcc-12.5.0
xtensa                randconfig-001-20250724    gcc-13.4.0
xtensa                randconfig-002-20250724    gcc-12.5.0
xtensa                randconfig-002-20250724    gcc-13.4.0
xtensa                    smp_lx200_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

