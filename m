Return-Path: <linux-pci+bounces-43825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC0CE8ACD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 05:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6A4B300DC9E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 04:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE115E8B;
	Tue, 30 Dec 2025 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jmd7k56e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8CCA6B
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 04:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767068307; cv=none; b=t8vlb9GUCI2qqDEHoIhhP6BgO6cFjHoDqnwRdHqUKky/3fxsQGGRwUBwW8LfXzUE8jXW1+NX1qGbSs9yUDD7FNAvWbQz1yUj5WDe5zJh7LhtXCIH+Av3/lAl8p6h3QOXylFmyyVusOF4fyS8UV40fksLMxg7IRbppE0tWSN+1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767068307; c=relaxed/simple;
	bh=4NccOV/ZNRfz+ht70WV5r05h9iJSDv06J00WvvhpQQ4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e1Ns300XpH1sCXsMuMLuQSSv1KreCeUOxvuK86QHS1shhqF6KWauCybWvacHNUnRk7SRnULTtPDnRFg+fpImC6dkTa0wyV2N9JtcZQw4GBU2yMdoovLtNO0IBGrp39KoH+nHicfRnWb5YxWAuJXYn+sgZ/S6CkWhm9pChf6R8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jmd7k56e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767068306; x=1798604306;
  h=date:from:to:cc:subject:message-id;
  bh=4NccOV/ZNRfz+ht70WV5r05h9iJSDv06J00WvvhpQQ4=;
  b=Jmd7k56eoXk3bYDUqyDeuiDTGZ9Iu/BBujA8KzZzj+xJMusAh5OheePV
   JKG65VCFWbQGClSQNAHyVNFurEhN+h8G4ij5gSaGkR4wt6bGNqwSmWqMZ
   0PJVSHurhRClKo92NV9fTq2ztaVEdhYsOAxz3+bmk21w1JoQIaJTXznN/
   NxxTaKW4D2b5NXVf4NCpOEx6qwfxRrNWy1TAO3moxNxjZhJP6bA5n8oAi
   UYZ4+7j/MrKCQA1aPgJW1TXiw3D7SnJiT/yEnhy+J6cS7+Mx0sxddnwwx
   qQTWyxDYRYljdnbuITzsNAc2I0Sr+Lt2XN2XbLpWWCrV0ijW8qvOSxGpD
   Q==;
X-CSE-ConnectionGUID: eRUPmfiHQHyHjKC06inFdw==
X-CSE-MsgGUID: FXti5X0uQVaGLjKVPyr0fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="67861754"
X-IronPort-AV: E=Sophos;i="6.21,187,1763452800"; 
   d="scan'208";a="67861754"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 20:18:25 -0800
X-CSE-ConnectionGUID: Kvi4DLQwTRuVsbwiGSXDXw==
X-CSE-MsgGUID: nqO23spXQ/OCCwXLLE58EA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Dec 2025 20:18:24 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaRBd-0000000004D-0mjQ;
	Tue, 30 Dec 2025 04:18:21 +0000
Date: Tue, 30 Dec 2025 12:18:05 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 68ac85fb42cfeb081cf029acdd8aace55ed375a2
Message-ID: <202512301200.XdTkLlIt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 68ac85fb42cfeb081cf029acdd8aace55ed375a2  PCI: dwc: Use cfg0_base as iMSI-RX target address to support 32-bit MSI devices

elapsed time: 784m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                   randconfig-001-20251230    gcc-12.5.0
arc                   randconfig-002-20251230    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                             mxs_defconfig    clang-22
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20251230    gcc-8.5.0
arm                   randconfig-002-20251230    gcc-8.5.0
arm                   randconfig-003-20251230    gcc-10.5.0
arm                   randconfig-004-20251230    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251230    gcc-15.1.0
arm64                 randconfig-002-20251230    gcc-14.3.0
arm64                 randconfig-003-20251230    clang-22
arm64                 randconfig-004-20251230    clang-20
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251230    gcc-15.1.0
csky                  randconfig-002-20251230    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251230    gcc-14
i386        buildonly-randconfig-002-20251230    clang-20
i386        buildonly-randconfig-003-20251230    clang-20
i386        buildonly-randconfig-004-20251230    clang-20
i386        buildonly-randconfig-005-20251230    clang-20
i386        buildonly-randconfig-006-20251230    clang-20
i386                  randconfig-001-20251230    gcc-14
i386                  randconfig-002-20251230    clang-20
i386                  randconfig-003-20251230    clang-20
i386                  randconfig-004-20251230    clang-20
i386                  randconfig-005-20251230    clang-20
i386                  randconfig-006-20251230    clang-20
i386                  randconfig-007-20251230    clang-20
i386                  randconfig-011-20251230    gcc-14
i386                  randconfig-012-20251230    gcc-14
i386                  randconfig-013-20251230    clang-20
i386                  randconfig-014-20251230    gcc-12
i386                  randconfig-015-20251230    gcc-14
i386                  randconfig-016-20251230    gcc-14
i386                  randconfig-017-20251230    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251230    gcc-15.1.0
parisc                randconfig-002-20251230    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251230    gcc-10.5.0
powerpc               randconfig-002-20251230    gcc-12.5.0
powerpc64             randconfig-001-20251230    gcc-14.3.0
powerpc64             randconfig-002-20251230    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251230    gcc-15.1.0
riscv                 randconfig-002-20251230    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251230    gcc-14.3.0
s390                  randconfig-002-20251230    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251230    gcc-13.4.0
sh                    randconfig-002-20251230    gcc-12.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251230    gcc-8.5.0
sparc                 randconfig-002-20251230    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251230    clang-22
sparc64               randconfig-002-20251230    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251230    gcc-13
um                    randconfig-002-20251230    clang-18
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251230    gcc-14
x86_64      buildonly-randconfig-002-20251230    gcc-14
x86_64      buildonly-randconfig-003-20251230    clang-20
x86_64      buildonly-randconfig-004-20251230    clang-20
x86_64      buildonly-randconfig-005-20251230    clang-20
x86_64      buildonly-randconfig-006-20251230    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251230    gcc-14
x86_64                randconfig-002-20251230    clang-20
x86_64                randconfig-003-20251230    clang-20
x86_64                randconfig-004-20251230    clang-20
x86_64                randconfig-006-20251230    gcc-14
x86_64                randconfig-071-20251230    clang-20
x86_64                randconfig-072-20251230    clang-20
x86_64                randconfig-073-20251230    gcc-14
x86_64                randconfig-074-20251230    clang-20
x86_64                randconfig-075-20251230    clang-20
x86_64                randconfig-076-20251230    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251230    gcc-8.5.0
xtensa                randconfig-002-20251230    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

