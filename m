Return-Path: <linux-pci+bounces-36053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22655B555F0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 20:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9DA7A6D43
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6606A31B126;
	Fri, 12 Sep 2025 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgJ5RqM/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD8272E7B
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700927; cv=none; b=JvR8tQYTK86+G1KbVfFhazm87UIVToqrFriOIR2bsbzqnOt+/4ZTL+9kUowLq4OZtS+1Ga0NL9ORTaD1gTaPU/PHaoy8e/Xwn8ifA9chzYgsuj6GHnJ2+Pu7D/m1elGfKsn7c7g31or1IG7xiPjmwQEVEICvjifzOTEtl7NpejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700927; c=relaxed/simple;
	bh=a2WzcoAji3gWE6LKr8WrJiXrbK+d6ueTa+ikkip+UPo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uEmBIup9nP8/aAZhxrwT0lxY2jJaPC5BCGJ4FyAiVEZkAvwXKopjAWw9Z0/viYHi4Ar/6eMAJdROC8X8Ur+9iR6iIoYyQikssy+ZoQHmOTK1tVREfi7BRZ2l5HIy5MVBgv4Q16vJQ02iD6Q6w7FXhRi54m/o9FqqjyXZuKykSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgJ5RqM/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757700925; x=1789236925;
  h=date:from:to:cc:subject:message-id;
  bh=a2WzcoAji3gWE6LKr8WrJiXrbK+d6ueTa+ikkip+UPo=;
  b=XgJ5RqM/Eo0+rAndwBuZhvkZmnCjvc/eCH3C0PXLcVEraAo3btzSaBgb
   ZS7EL9eMpuISGfXP/4U+BDDRlBcnpKAxw15POsiMpfckdAxsigQeHwz3E
   sz3ClvyZhZdlTGoPGlN3a7UstirMBD3RugtQBqvNrzpJUVDGTb8XLjqAz
   OAE9IRCyL4ZzkuNw5W/A9+vyve5mv6W0I+zyJaBJlv3kZ7vUvZbm58Iip
   lVuvoHpIY7FamBXQm3YtUjow0awbTlgFfFrlAZ9NYKXvTi9pwn8+yD8zo
   IbQs+eA1hR/g5M4SNWgrTeoKZgoFlKlPvmayxvdkT8jQkCX7Ju4mkaNUE
   A==;
X-CSE-ConnectionGUID: I2CppT58QbyapFbsjBZQWw==
X-CSE-MsgGUID: KxdCnngTRIKDjZFXHTMvvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="77508189"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="77508189"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:15:25 -0700
X-CSE-ConnectionGUID: +zkyCdm6RzSXNLwupngktQ==
X-CSE-MsgGUID: tiikzwHGSs6SH4a6RZgL5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="179241837"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 12 Sep 2025 11:15:23 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ux8In-0001A8-2n;
	Fri, 12 Sep 2025 18:15:19 +0000
Date: Sat, 13 Sep 2025 02:14:51 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 54a8c34df746c979037c907ad7fe42c52a58b532
Message-ID: <202509130242.Uey5LFKI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 54a8c34df746c979037c907ad7fe42c52a58b532  PCI: endpoint: pci-epf-test: Fix doorbell test support

elapsed time: 1457m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250912    gcc-10.5.0
arc                   randconfig-002-20250912    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20250912    clang-22
arm                   randconfig-002-20250912    gcc-14.3.0
arm                   randconfig-003-20250912    clang-22
arm                   randconfig-004-20250912    gcc-10.5.0
arm                        spear3xx_defconfig    clang-17
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250912    clang-20
arm64                 randconfig-002-20250912    clang-16
arm64                 randconfig-003-20250912    clang-22
arm64                 randconfig-004-20250912    clang-19
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250912    gcc-15.1.0
csky                  randconfig-002-20250912    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250912    clang-22
hexagon               randconfig-002-20250912    clang-22
i386                             alldefconfig    gcc-14
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250912    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250912    gcc-15.1.0
loongarch             randconfig-002-20250912    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250912    gcc-11.5.0
nios2                 randconfig-002-20250912    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250912    gcc-14.3.0
parisc                randconfig-002-20250912    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250912    gcc-8.5.0
powerpc               randconfig-002-20250912    clang-22
powerpc               randconfig-003-20250912    clang-17
powerpc                     redwood_defconfig    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20250912    gcc-12.5.0
powerpc64             randconfig-002-20250912    clang-22
powerpc64             randconfig-003-20250912    clang-19
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250912    clang-16
riscv                 randconfig-002-20250912    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250912    gcc-10.5.0
s390                  randconfig-002-20250912    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250912    gcc-15.1.0
sh                    randconfig-002-20250912    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250912    gcc-8.5.0
sparc                 randconfig-002-20250912    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250912    gcc-8.5.0
sparc64               randconfig-002-20250912    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                    randconfig-001-20250912    clang-22
um                    randconfig-002-20250912    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250912    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250912    gcc-9.5.0
xtensa                randconfig-002-20250912    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

