Return-Path: <linux-pci+bounces-11004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7394094C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 09:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05591F25245
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9A38B;
	Tue, 30 Jul 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdFhTRv5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA942AA5
	for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323791; cv=none; b=IEhr0M4yb0b2SrFEymAEx6lRZ2RETTjK1S+52P4ymviMPhtVv5b3jAnLG7+sBOxydFb5PfOZAtCaQGK06VzwL//qgn1nT0E8rBF9nnwAiGRXkTLS/7b2e4iqG+nd/COgHzRUBi7dVS2kH1BgqZsYuUeNjoNAREk0Hz0U7korK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323791; c=relaxed/simple;
	bh=ctXf1BziAUod9yruJJlhulCnCn9HMKVe1og7C/O65Tw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kjNElrl6IKojN1YT11/pOF/EdzSVIEZmmuzf+jiDp9MY90soie3FOA3if5TQ22Y2SpgDrXu++T3DQwEGbPPrm6OJX3ArgT60oklgNChey8Bde7cQROwlIFjCQNluYYSKzImnZjyb6dRkO4r98WgCmnRccvqHSoYlEYHnizEZP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdFhTRv5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722323790; x=1753859790;
  h=date:from:to:cc:subject:message-id;
  bh=ctXf1BziAUod9yruJJlhulCnCn9HMKVe1og7C/O65Tw=;
  b=VdFhTRv5Yxq2z4Z+GPoF+Cg/QGj5+s8K4y/znQZQJifsq8gkBarhPx+P
   kMtfdaxPtUcKkTWJ1Ugkubl9GH3qOIzAsDAWkGC/AjeHBKppEjZAbgHgc
   VizNcoyRXLUiZ1PEum7asfomMB0AYs3mzd7UAndg6wulcin4n9Fo5jeTf
   GanOY46BXM4CVm3CP0HyQKROrdXsX1wtW7RAD5zmSn8WttbWN4EU+TH7l
   Pcwf/ckQpxtZgoVDZ1ufjUqtjK1aAl0UIHDnUZSSjsxEdlTmro5ICgTDe
   r5PzXUb9YW7+BKCScaGVCJYfCRoVR1uK9ZZQ2o7N6I/NKsk/PnI5WAa3H
   g==;
X-CSE-ConnectionGUID: e7BAhPF1RNmsvNchYKYdug==
X-CSE-MsgGUID: K1gLPpTISC6BLrZJFDF6zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30785210"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="30785210"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 00:16:29 -0700
X-CSE-ConnectionGUID: rFNbTst1R7e3JnY8Iue3Yg==
X-CSE-MsgGUID: lUY1jvXFQeC/sZzsChCbXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="59319683"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Jul 2024 00:16:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYh5t-000sbY-2c;
	Tue, 30 Jul 2024 07:16:25 +0000
Date: Tue, 30 Jul 2024 15:15:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/affinity] BUILD SUCCESS
 51c3c92a1229b916195699c25c24d667178853a2
Message-ID: <202407301546.gB2axACO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/affinity
branch HEAD: 51c3c92a1229b916195699c25c24d667178853a2  PCI: xilinx: Silence 'set affinity failed' warning

elapsed time: 781m

configs tested: 114
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
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-13.2.0
arm                             pxa_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240730   clang-18
i386         buildonly-randconfig-004-20240730   clang-18
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240730   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240730   gcc-8
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240730   gcc-10
i386                  randconfig-006-20240730   gcc-10
i386                  randconfig-011-20240730   gcc-11
i386                  randconfig-012-20240730   clang-18
i386                  randconfig-013-20240730   clang-18
i386                  randconfig-014-20240730   gcc-9
i386                  randconfig-015-20240730   gcc-9
i386                  randconfig-016-20240730   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

