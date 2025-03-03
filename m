Return-Path: <linux-pci+bounces-22754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4FDA4BD2A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 12:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71807A86EA
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42CB1F3BA8;
	Mon,  3 Mar 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVBe387a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCE1EF0AA
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999545; cv=none; b=FRmwFruMyJx3RPpoqtae3DA96qzIzU/+M8aGl9KCSgd2sweIBTDBU1LeDk84rCmOCloJOON/LpfQmAbzxpBo1yBHywulTxNJN+Am2cFmHtQvtVvIoN5GUjrssHJRMox0pxrpk8tXCP25jFk5KcsjXPSF++FadP2b+jt4AC2AC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999545; c=relaxed/simple;
	bh=vvQnJcl2Zu+jAJHZ+0stX32sVp9h78tuV/TlufqCRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=az+nMTwELLvoFWrCiF5ZUAVWyU9d0/NBVRdG4jDxyPto4kueW+Eu/6+zyrh8pmhsUiMBkvv+4Y/nWYwl34CRBhOAnGXdEBdzphyKprioG2OP/qlQDue+wpLdCu9D8KX7HKzDtN2jPuE5q/0PIf0QZzaMDev3RMSIRSnLrITfs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVBe387a; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740999544; x=1772535544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vvQnJcl2Zu+jAJHZ+0stX32sVp9h78tuV/TlufqCRdA=;
  b=nVBe387a4c030cHDrN+FOAa/tx16Y96Aor9MuNgovQeEi1vxjnEHTRHw
   aE4vdolucSL4aMZU3v5tlBn03GSGcPIPvuzXVdtCP0RUu9qYbeVm5FdPV
   1dLYHc4chvxj3qxeGZUMWjKMG/fLDU/Oc72tIXtMPcj4omLuNB5xgj/OU
   k8dLk8ZjgCLLGKA2SnOnpL+cNan4EfoJpqK3rj/+8nMU5K4FY5WCEC52h
   jgHoeQN2Lw/pbylbdRS/5NcODt4bVAZXWxCSGEQKY/NoVqyo1DnOfflaw
   XPMAwuE1TFZN0Iq0+8US5dTfMhNtbVwXGaW5xuHZ/sp//G34gOUA/k9L/
   w==;
X-CSE-ConnectionGUID: lracgmBCQVODDclrRAU6Tg==
X-CSE-MsgGUID: EWKghspPRSSvG1ca/l512w==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="67238804"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="67238804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:58:43 -0800
X-CSE-ConnectionGUID: W32JXt0bRJ+mNSbFKIS0AQ==
X-CSE-MsgGUID: bvnPkysHSQ6hb8oWGvrtog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118004979"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2025 02:58:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tp3VP-000INQ-1A;
	Mon, 03 Mar 2025 10:58:39 +0000
Date: Mon, 03 Mar 2025 18:58:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:scoped-cleanup] BUILD SUCCESS
 3c0d83dfb384442f9f54a101519a84e0a11050fb
Message-ID: <202503031808.6lQfmrCg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git scoped-cleanup
branch HEAD: 3c0d83dfb384442f9f54a101519a84e0a11050fb  PCI: tegra: Use helper function for_each_child_of_node_scoped()

elapsed time: 983m

configs tested: 119
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250303    gcc-13.2.0
arc                   randconfig-002-20250303    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                        multi_v7_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250303    clang-15
arm                   randconfig-002-20250303    gcc-14.2.0
arm                   randconfig-003-20250303    gcc-14.2.0
arm                   randconfig-004-20250303    clang-17
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250303    clang-21
arm64                 randconfig-002-20250303    clang-19
arm64                 randconfig-003-20250303    gcc-14.2.0
arm64                 randconfig-004-20250303    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250303    gcc-14.2.0
csky                  randconfig-002-20250303    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250303    clang-21
hexagon               randconfig-002-20250303    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250303    gcc-12
i386        buildonly-randconfig-002-20250303    clang-19
i386        buildonly-randconfig-003-20250303    clang-19
i386        buildonly-randconfig-004-20250303    gcc-12
i386        buildonly-randconfig-005-20250303    gcc-12
i386        buildonly-randconfig-006-20250303    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250303    gcc-14.2.0
loongarch             randconfig-002-20250303    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250303    gcc-14.2.0
nios2                 randconfig-002-20250303    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250303    gcc-14.2.0
parisc                randconfig-002-20250303    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 canyonlands_defconfig    clang-19
powerpc                       eiger_defconfig    clang-17
powerpc                    gamecube_defconfig    clang-16
powerpc               randconfig-001-20250303    clang-15
powerpc               randconfig-002-20250303    clang-21
powerpc               randconfig-003-20250303    clang-21
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-002-20250303    gcc-14.2.0
powerpc64             randconfig-003-20250303    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250303    gcc-14.2.0
riscv                 randconfig-002-20250303    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250303    clang-18
s390                  randconfig-002-20250303    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                    randconfig-001-20250303    gcc-14.2.0
sh                    randconfig-002-20250303    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250303    gcc-14.2.0
sparc                 randconfig-002-20250303    gcc-14.2.0
sparc64               randconfig-001-20250303    gcc-14.2.0
sparc64               randconfig-002-20250303    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250303    gcc-12
um                    randconfig-002-20250303    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250303    clang-19
x86_64      buildonly-randconfig-002-20250303    gcc-12
x86_64      buildonly-randconfig-003-20250303    clang-19
x86_64      buildonly-randconfig-004-20250303    gcc-12
x86_64      buildonly-randconfig-005-20250303    gcc-12
x86_64      buildonly-randconfig-006-20250303    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250303    gcc-14.2.0
xtensa                randconfig-002-20250303    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

