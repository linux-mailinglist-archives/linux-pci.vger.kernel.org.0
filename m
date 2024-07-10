Return-Path: <linux-pci+bounces-10074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C592D2A5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CE287098
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE3818560A;
	Wed, 10 Jul 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ofk1DF5B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC31DDC5
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617693; cv=none; b=qwVkW8KPrFzxmEjK8Pewhheso51UbQaEluvFnD0rJWv2h48G1QyfV5t2hLcjoGPy0a/YqZ32T9+M3My+7dyMvLx61Gojygy9cw88R8s6HdyxjAU7lQKsRtSqlzMJi0m1WNaL160SYD3M3c+NMsngyEJkCkUGzkVJxRjsJij/pB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617693; c=relaxed/simple;
	bh=5EucVgItmtZS4959ihiiOlwy4zf++nhb5FNLWyq/PoQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J59oRsNFxAfTliS4BQwiIxK05YxrtzuDnd9qWZwLDIBOemWQpWc6kfpiQvSC+axe8vMYrx/wBu4s6idABFhfMGjpMAk3oNU+nY3VAe8fHCXmf0S6wIfoJTAwa0x4ZLk4/pYapDFfpOLQk6z0BsgCONHWA+1OchICAduBtrjg0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ofk1DF5B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720617691; x=1752153691;
  h=date:from:to:cc:subject:message-id;
  bh=5EucVgItmtZS4959ihiiOlwy4zf++nhb5FNLWyq/PoQ=;
  b=Ofk1DF5BrCHd9bIvGcUe55SxwnUmDJnMeV7DiooJjJ08e1GsdBSQUQcw
   j/p7r2E9WgJsfkRvCGo1ULH4xMumWlCkktVufU4aLV09BW9NFpWkE4Edn
   KU76qIZSnEhyehNpw5dquw1v9qq5VXOgM8u/4Js54q78YGylgcfhmPvVI
   FbancUDTa+jhcsIbyFD7/IaLVh4oQrb+T4FPL231JNaODA/pYt5WCBsF5
   i6hgoy8RldbVFswF0g0NqLep3PYgsFL0vimXISeCyoyIYm8be4tcRYA8x
   9CDKRS5b+bqKV4Ncp5c/IOC9oVav2l+kvGwuotk2z3x92QTnp7BtKigvM
   g==;
X-CSE-ConnectionGUID: Qo3vo+aPT56sV2Grzp7xdg==
X-CSE-MsgGUID: 6QM8hzKwSvKWK4YbO2sAoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21809190"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="21809190"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:21:30 -0700
X-CSE-ConnectionGUID: d6TSSTI2SXueBCwhlSONVg==
X-CSE-MsgGUID: 9W9pnuzVQjiDqgX82TjNwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48097936"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jul 2024 06:21:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRXGA-000Xsz-3B;
	Wed, 10 Jul 2024 13:21:26 +0000
Date: Wed, 10 Jul 2024 21:20:31 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/kirin] BUILD SUCCESS
 5f101ebdbf3cc021959c47a7d96d23c987254d1a
Message-ID: <202407102129.o9ynNP6R-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/kirin
branch HEAD: 5f101ebdbf3cc021959c47a7d96d23c987254d1a  PCI: kirin: Fix memory leak in kirin_pcie_parse_port()

elapsed time: 883m

configs tested: 180
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240710   gcc-13.2.0
arc                   randconfig-002-20240710   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.3.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.3.0
arm                          collie_defconfig   gcc-13.3.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.3.0
arm                           imxrt_defconfig   gcc-13.3.0
arm                   randconfig-001-20240710   gcc-13.2.0
arm                   randconfig-002-20240710   gcc-13.2.0
arm                   randconfig-003-20240710   gcc-13.2.0
arm                   randconfig-004-20240710   gcc-13.2.0
arm                           sama7_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240710   gcc-13.2.0
arm64                 randconfig-002-20240710   gcc-13.2.0
arm64                 randconfig-003-20240710   gcc-13.2.0
arm64                 randconfig-004-20240710   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-13.3.0
csky                  randconfig-001-20240710   gcc-13.2.0
csky                  randconfig-002-20240710   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240710   clang-18
i386         buildonly-randconfig-002-20240710   clang-18
i386         buildonly-randconfig-003-20240710   clang-18
i386         buildonly-randconfig-004-20240710   clang-18
i386         buildonly-randconfig-005-20240710   clang-18
i386         buildonly-randconfig-006-20240710   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240710   clang-18
i386                  randconfig-002-20240710   clang-18
i386                  randconfig-003-20240710   clang-18
i386                  randconfig-004-20240710   clang-18
i386                  randconfig-005-20240710   clang-18
i386                  randconfig-006-20240710   clang-18
i386                  randconfig-011-20240710   clang-18
i386                  randconfig-012-20240710   clang-18
i386                  randconfig-013-20240710   clang-18
i386                  randconfig-014-20240710   clang-18
i386                  randconfig-015-20240710   clang-18
i386                  randconfig-016-20240710   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240710   gcc-13.2.0
loongarch             randconfig-002-20240710   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.3.0
m68k                          amiga_defconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.3.0
microblaze                       alldefconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.3.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.3.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           mtx1_defconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240710   gcc-13.2.0
nios2                 randconfig-002-20240710   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.3.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240710   gcc-13.2.0
parisc                randconfig-002-20240710   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.3.0
powerpc                          g5_defconfig   gcc-13.3.0
powerpc                        icon_defconfig   gcc-13.3.0
powerpc                       maple_defconfig   gcc-13.3.0
powerpc                     mpc512x_defconfig   gcc-13.3.0
powerpc                      ppc44x_defconfig   gcc-13.3.0
powerpc               randconfig-001-20240710   gcc-13.2.0
powerpc               randconfig-002-20240710   gcc-13.2.0
powerpc               randconfig-003-20240710   gcc-13.2.0
powerpc                         wii_defconfig   gcc-13.3.0
powerpc64             randconfig-001-20240710   gcc-13.2.0
powerpc64             randconfig-002-20240710   gcc-13.2.0
powerpc64             randconfig-003-20240710   gcc-13.2.0
riscv                            allmodconfig   gcc-13.3.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.3.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240710   gcc-13.2.0
riscv                 randconfig-002-20240710   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240710   gcc-13.2.0
s390                  randconfig-002-20240710   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240710   gcc-13.2.0
sh                    randconfig-002-20240710   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240710   gcc-13.2.0
sparc64               randconfig-002-20240710   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240710   gcc-13.2.0
um                    randconfig-002-20240710   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240710   clang-18
x86_64       buildonly-randconfig-002-20240710   clang-18
x86_64       buildonly-randconfig-003-20240710   clang-18
x86_64       buildonly-randconfig-004-20240710   clang-18
x86_64       buildonly-randconfig-005-20240710   clang-18
x86_64       buildonly-randconfig-006-20240710   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240710   clang-18
x86_64                randconfig-002-20240710   clang-18
x86_64                randconfig-003-20240710   clang-18
x86_64                randconfig-004-20240710   clang-18
x86_64                randconfig-005-20240710   clang-18
x86_64                randconfig-006-20240710   clang-18
x86_64                randconfig-011-20240710   clang-18
x86_64                randconfig-012-20240710   clang-18
x86_64                randconfig-013-20240710   clang-18
x86_64                randconfig-014-20240710   clang-18
x86_64                randconfig-015-20240710   clang-18
x86_64                randconfig-016-20240710   clang-18
x86_64                randconfig-071-20240710   clang-18
x86_64                randconfig-072-20240710   clang-18
x86_64                randconfig-073-20240710   clang-18
x86_64                randconfig-074-20240710   clang-18
x86_64                randconfig-075-20240710   clang-18
x86_64                randconfig-076-20240710   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240710   gcc-13.2.0
xtensa                randconfig-002-20240710   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

