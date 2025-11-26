Return-Path: <linux-pci+bounces-42090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18996C8790E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 01:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BE4F352942
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 00:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B92B9B9;
	Wed, 26 Nov 2025 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5Niu53A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D4F50F
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116247; cv=none; b=R5LG0D+N1ZPbkxeYsD2FWm52zs6JAo/DVAH8r4KAYnc+SpeoxioxLn0kzQA7gPkLsNjdhI9W2SU+u7qumpx0EyoFGdg3b2HVKrEMddzoj59OI1BT4MlmZ9BTvnmwP818jxbeMpYVbyOXwaB/JIlY5OS/GPQyA+vA2+oMEkb85Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116247; c=relaxed/simple;
	bh=DyJWEtcelEk7d2YG4PorqtYV4gx5rPiXpTLN9f/E370=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fcR1C+qyseclxAC1b77gnZ/M2HTjYpn1bxMcEkTmqh/e5EenEoFsAauX1mBW6oh9Yr0z5jSLN2pN8qmaICo1wfE4+qTSY7c3PqMYVt8zopf6xvte8E8NQuvGVIev9Jle+WoRm6VZhf0vsYY9R5Q3RCBOUnmyQ07G9t/rYgEg/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5Niu53A; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764116246; x=1795652246;
  h=date:from:to:cc:subject:message-id;
  bh=DyJWEtcelEk7d2YG4PorqtYV4gx5rPiXpTLN9f/E370=;
  b=Q5Niu53Af3ayuAA2zvEcA21A8HPTaGiCgVsBuXTqpojTaBAx/JqFPynf
   LnGYbCH9n0+f9nH/yHtDYJ+wbxANXhq6Iv7/uIaciTUYhMnNRECvQZZSL
   crn30MPnzdOk7F7oo8MNnzX8AwZcSRNu/T9JSX5Du0X/UNU/hVKLLcd/g
   3Vb+YPoMAFOJgLQQXkwU0WIttTLl1jK8sdeV1/KvxPSO9L5NFhDdS+RLD
   E+xf8jbtpWOhagJLHno94U1aFJVQcszkOVBS+4uzFft/gd0M+fO87TZ/Z
   xXnne7afP5jnpxK1QPGyB+byLxoqdG/JgDz+h4JYcX95Dgb4/VgpxFKKt
   A==;
X-CSE-ConnectionGUID: L7ruO3WARCOXzisxwwPKCA==
X-CSE-MsgGUID: 0j7Naa/hQ9yvGjJfkJZpIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69769450"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="69769450"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 16:17:25 -0800
X-CSE-ConnectionGUID: KGbH1/AlQFuIbgoAcli9kA==
X-CSE-MsgGUID: f9NWuYUSSfa32z4LkwoW5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="216140621"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2025 16:17:24 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO3Dl-000000002Nd-33Ji;
	Wed, 26 Nov 2025 00:17:21 +0000
Date: Wed, 26 Nov 2025 08:17:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl-tc9563] BUILD SUCCESS
 4c9c7be47310c1dbd7b6d37d45986123f5b133b4
Message-ID: <202511260806.815GD51l-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl-tc9563
branch HEAD: 4c9c7be47310c1dbd7b6d37d45986123f5b133b4  PCI: pwrctrl: Add power control driver for TC9563

elapsed time: 1547m

configs tested: 114
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251125    gcc-9.5.0
arc                   randconfig-002-20251125    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-002-20251125    gcc-10.5.0
arm                   randconfig-003-20251125    gcc-10.5.0
arm                   randconfig-004-20251125    gcc-8.5.0
arm                           tegra_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251125    gcc-11.5.0
arm64                 randconfig-002-20251125    gcc-13.4.0
arm64                 randconfig-003-20251125    gcc-8.5.0
arm64                 randconfig-004-20251125    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251125    gcc-11.5.0
csky                  randconfig-002-20251125    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251125    clang-19
hexagon               randconfig-002-20251125    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251125    gcc-14
i386        buildonly-randconfig-003-20251125    gcc-14
i386        buildonly-randconfig-004-20251125    gcc-14
i386        buildonly-randconfig-005-20251125    gcc-14
i386        buildonly-randconfig-006-20251125    clang-20
i386                  randconfig-001-20251125    gcc-12
i386                  randconfig-002-20251125    gcc-14
i386                  randconfig-003-20251125    gcc-14
i386                  randconfig-004-20251125    gcc-14
i386                  randconfig-005-20251125    gcc-14
i386                  randconfig-006-20251125    gcc-14
i386                  randconfig-007-20251125    gcc-14
i386                  randconfig-011-20251126    gcc-14
i386                  randconfig-012-20251126    gcc-14
i386                  randconfig-013-20251126    clang-20
i386                  randconfig-014-20251126    gcc-14
i386                  randconfig-015-20251126    clang-20
i386                  randconfig-016-20251126    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251125    gcc-15.1.0
loongarch             randconfig-002-20251125    gcc-12.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251125    gcc-8.5.0
nios2                 randconfig-002-20251125    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251125    gcc-13.4.0
parisc                randconfig-002-20251125    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251125    clang-19
powerpc               randconfig-002-20251125    gcc-8.5.0
powerpc64             randconfig-001-20251125    clang-16
powerpc64             randconfig-002-20251125    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251125    gcc-8.5.0
riscv                 randconfig-002-20251125    gcc-13.4.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251125    gcc-8.5.0
s390                  randconfig-002-20251125    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251125    gcc-15.1.0
sh                    randconfig-002-20251125    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251125    gcc-14.3.0
sparc                 randconfig-002-20251125    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251125    clang-22
sparc64               randconfig-002-20251125    gcc-8.5.0
um                               alldefconfig    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251125    clang-22
um                    randconfig-002-20251125    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251126    clang-20
x86_64      buildonly-randconfig-002-20251126    gcc-14
x86_64      buildonly-randconfig-003-20251126    clang-20
x86_64      buildonly-randconfig-004-20251126    clang-20
x86_64      buildonly-randconfig-005-20251126    gcc-14
x86_64      buildonly-randconfig-006-20251126    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251126    clang-20
x86_64                randconfig-002-20251126    gcc-14
x86_64                randconfig-004-20251126    gcc-14
x86_64                randconfig-013-20251126    gcc-14
x86_64                randconfig-071-20251126    clang-20
x86_64                randconfig-072-20251126    gcc-14
x86_64                randconfig-073-20251126    clang-20
x86_64                randconfig-074-20251126    gcc-14
x86_64                randconfig-075-20251126    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251125    gcc-8.5.0
xtensa                randconfig-002-20251125    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

