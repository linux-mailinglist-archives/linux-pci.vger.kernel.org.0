Return-Path: <linux-pci+bounces-43871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4ACEB9F8
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 10:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A120300A3E2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55526D4CA;
	Wed, 31 Dec 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0V/lB1n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AA31577B
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171875; cv=none; b=QdU7DkybTOBUXeFN1d6ChpgD3Qn9WcR3lNgXM5NSJ4/cUo6s/BvtqH7H8EK35hRRZa36m9P1Vb7tPc9pVuGUTCM0WVYZ+2a9llNcz2zq9/jBsuMPf/yrnuJeZeUwmkesXTSCU1vNezbwGXy5/GDMhuLG7/HZlEZeGJ5VGPTdVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171875; c=relaxed/simple;
	bh=MSi+JwwDiXZCRFklqNC2bU/4XMZUKH82XEiKggFLKFM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IGjHOgeSQ5NPSAmao6dDFnXDTsXmQXTZC7qJ6fp1iGSu5YpBB8m1VnWjeVocQbLcO/P/w35c+1sff2UfajU35xT4yDJ5XATlRn4GgJWIpOpMN4855vxIZzrhuNbnryOoZdimZB86MWQrtLo5rvn5OZjBa6Mb7P+47Wj0V47R7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0V/lB1n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767171873; x=1798707873;
  h=date:from:to:cc:subject:message-id;
  bh=MSi+JwwDiXZCRFklqNC2bU/4XMZUKH82XEiKggFLKFM=;
  b=Z0V/lB1nLRCrk5gldSbvFA+tJWFi/hOqZy7Zgv313f9u5CMHxtQS5eEo
   eJ0RiABZ7Dj4dNt5X+wX+V35Ph2b7WHVavp83Jdbtzjk7VLpT06UK50X8
   +RYNkF3OW2BfzLPh4HvgOHyEPqqGCnn0Ra7/HiK+cSdhreVvacRJzImP0
   han+SO0BMA9ZvS191Jft2YKp4Q196VL6N7VP5CWMao86aZJsWVblTBxro
   NMdrSW1JmkJKfW2nToLlLNlbjv9y58PbzFj2ji6Q9vJe7m6+Dc06PDbJa
   QBj8+u2FvGK8KEzj2Wk2OsMzLEgFJv47adbCqA7u8dy8lzNuccIaPNOfE
   w==;
X-CSE-ConnectionGUID: ONMRigmYQfWu+l6CHD0fUA==
X-CSE-MsgGUID: 9d0VsYIkQBSJ+VBhD5v81A==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="79051375"
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="79051375"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 01:04:33 -0800
X-CSE-ConnectionGUID: b5ufNmg8RmmrrkGCb4dGQw==
X-CSE-MsgGUID: pHeRavfxRl2pJiCNcahUmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="201406908"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Dec 2025 01:04:31 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vas82-0000000014V-1xFC;
	Wed, 31 Dec 2025 09:04:26 +0000
Date: Wed, 31 Dec 2025 17:03:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 4d1d1216640953e1129838b0801f87c07bc056b1
Message-ID: <202512311730.3vieOTaz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 4d1d1216640953e1129838b0801f87c07bc056b1  Merge branch 'pci/misc'

elapsed time: 904m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251231    gcc-11.5.0
arc                   randconfig-002-20251231    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                   randconfig-001-20251231    gcc-12.5.0
arm                   randconfig-002-20251231    clang-22
arm                   randconfig-003-20251231    gcc-8.5.0
arm                   randconfig-004-20251231    clang-19
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251231    clang-22
arm64                 randconfig-002-20251231    clang-19
arm64                 randconfig-003-20251231    gcc-8.5.0
arm64                 randconfig-004-20251231    gcc-13.4.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251231    gcc-14.3.0
csky                  randconfig-002-20251231    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251231    clang-22
hexagon               randconfig-002-20251231    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251231    clang-20
i386        buildonly-randconfig-002-20251231    gcc-14
i386        buildonly-randconfig-003-20251231    gcc-14
i386        buildonly-randconfig-004-20251231    gcc-14
i386        buildonly-randconfig-005-20251231    gcc-14
i386        buildonly-randconfig-006-20251231    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251231    gcc-14
i386                  randconfig-002-20251231    gcc-12
i386                  randconfig-003-20251231    gcc-14
i386                  randconfig-004-20251231    clang-20
i386                  randconfig-005-20251231    gcc-14
i386                  randconfig-006-20251231    gcc-14
i386                  randconfig-007-20251231    gcc-14
i386                  randconfig-011-20251231    gcc-14
i386                  randconfig-012-20251231    clang-20
i386                  randconfig-013-20251231    gcc-13
i386                  randconfig-014-20251231    gcc-14
i386                  randconfig-015-20251231    gcc-13
i386                  randconfig-016-20251231    clang-20
i386                  randconfig-017-20251231    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251231    gcc-12.5.0
loongarch             randconfig-002-20251231    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
mips                      malta_kvm_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251231    gcc-8.5.0
nios2                 randconfig-002-20251231    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251231    gcc-8.5.0
parisc                randconfig-002-20251231    gcc-11.5.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       holly_defconfig    clang-22
powerpc                       ppc64_defconfig    clang-22
powerpc               randconfig-001-20251231    gcc-8.5.0
powerpc               randconfig-002-20251231    clang-22
powerpc64             randconfig-001-20251231    clang-16
powerpc64             randconfig-002-20251231    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251231    gcc-14.3.0
riscv                 randconfig-002-20251231    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251231    gcc-8.5.0
s390                  randconfig-002-20251231    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251231    gcc-15.1.0
sh                    randconfig-002-20251231    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251231    gcc-11.5.0
sparc                 randconfig-002-20251231    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251231    clang-22
sparc64               randconfig-002-20251231    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251231    clang-22
um                    randconfig-002-20251231    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251231    gcc-14
x86_64      buildonly-randconfig-002-20251231    gcc-14
x86_64      buildonly-randconfig-003-20251231    gcc-14
x86_64      buildonly-randconfig-004-20251231    clang-20
x86_64      buildonly-randconfig-005-20251231    gcc-14
x86_64      buildonly-randconfig-006-20251231    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251231    gcc-13
x86_64                randconfig-002-20251231    clang-20
x86_64                randconfig-003-20251231    clang-20
x86_64                randconfig-004-20251231    clang-20
x86_64                randconfig-005-20251231    clang-20
x86_64                randconfig-006-20251231    clang-20
x86_64                randconfig-011-20251231    clang-20
x86_64                randconfig-012-20251231    gcc-14
x86_64                randconfig-013-20251231    gcc-14
x86_64                randconfig-014-20251231    gcc-12
x86_64                randconfig-015-20251231    gcc-14
x86_64                randconfig-016-20251231    gcc-14
x86_64                randconfig-071-20251231    clang-20
x86_64                randconfig-072-20251231    clang-20
x86_64                randconfig-073-20251231    gcc-12
x86_64                randconfig-074-20251231    gcc-14
x86_64                randconfig-075-20251231    clang-20
x86_64                randconfig-076-20251231    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251231    gcc-8.5.0
xtensa                randconfig-002-20251231    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

