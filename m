Return-Path: <linux-pci+bounces-42098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29718C88307
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 06:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F14914E193C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9D1F03D9;
	Wed, 26 Nov 2025 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAIEQo39"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682317D098
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136476; cv=none; b=DBECk34KLWfhDMjDi2+6MgO/a2/VT2rXQTCPDadcPjZ3xpKOIivBhFg8q3K7cG5cPEt64NLP3j/3YdfEHIfCTutbJqAIwbVYrpHxrUy5dnDSLKtTCtCJYDD9rus63pOZbt1wik0USmyfu7eZ2CHWZtfaf2eMN7BXPEJ1+oJ3UxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136476; c=relaxed/simple;
	bh=rjLUtvQr3s65gkXxJMLjWNloR2y2duaEj70BPM0lndc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hH3I3jPIk7rZ4rt3HD4eQqGekpgNhvswgWBQ1bIn8nLe64nFh34t3DXGOqBJIP87IKo1x0dZuxsulvBxQ/ri8Kbz0A8/a9ogswhpM1wpytBqyP5wzbvwpcPyR18N+jDpBSHQeV74qTCNmH8VyOLvK5Rx1u1XAhU0Xnb5lfvCc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAIEQo39; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764136474; x=1795672474;
  h=date:from:to:cc:subject:message-id;
  bh=rjLUtvQr3s65gkXxJMLjWNloR2y2duaEj70BPM0lndc=;
  b=gAIEQo39UTwWANLAbPUlQzv/Fb2arZde0YM4YHsK9ZR6tnVdHZ4VHocB
   HgWjHmTXQ/4KXjl13tYATCqVrvChtneURJW0dFSkztVAaua4ZzDJIf/cM
   2cqKPKMvyOtOZrzE6cK5eGspI+OS73P54CMaWrUuvwDthIi+iKnGmbt19
   ReZ9BX1Y407nhGW9qkd4XYm6ldn6MncfdaKGx9p/bJD4AmxtHM9VslHcS
   BKSkGXOV4ltNu318c/QBVKo+ztlrB2Zit3RnmwG+NarOqyTmIaEv6lW6x
   ASeYHRLWKDmkowXe8pJaqzhcE5exqmbC+nH/wuLvYIAbeNiDJ4hxto881
   A==;
X-CSE-ConnectionGUID: 4jdYzVouSUmN2KTHrFQ0og==
X-CSE-MsgGUID: v9Voi6xJQjaA4v/mK1UJew==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66051489"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="66051489"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 21:54:34 -0800
X-CSE-ConnectionGUID: hodO5cruSQGalExkHeCuDw==
X-CSE-MsgGUID: cFtK7YurSJuTG+J8bEnizw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192741191"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Nov 2025 21:54:33 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO8U2-000000002X7-3iE8;
	Wed, 26 Nov 2025 05:54:30 +0000
Date: Wed, 26 Nov 2025 13:53:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:err] BUILD SUCCESS
 5e09895b4063e9f57c6fc416cf30cd0c6ca7ec74
Message-ID: <202511261351.1gfivfVI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git err
branch HEAD: 5e09895b4063e9f57c6fc416cf30cd0c6ca7ec74  Documentation: PCI: Amend error recovery doc with pci_save_state() rules

elapsed time: 1810m

configs tested: 113
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251125    gcc-9.5.0
arc                   randconfig-002-20251125    gcc-8.5.0
arm                              alldefconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251125    clang-22
arm                   randconfig-002-20251125    gcc-10.5.0
arm                   randconfig-003-20251125    gcc-10.5.0
arm                   randconfig-004-20251125    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251126    gcc-8.5.0
arm64                 randconfig-002-20251126    clang-19
arm64                 randconfig-003-20251126    clang-22
arm64                 randconfig-004-20251126    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251126    gcc-11.5.0
csky                  randconfig-002-20251126    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-002-20251125    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251126    clang-20
i386        buildonly-randconfig-002-20251126    gcc-14
i386        buildonly-randconfig-003-20251126    clang-20
i386        buildonly-randconfig-004-20251126    clang-20
i386        buildonly-randconfig-005-20251126    clang-20
i386        buildonly-randconfig-006-20251126    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251125    gcc-12
i386                  randconfig-002-20251125    gcc-14
i386                  randconfig-003-20251125    gcc-14
i386                  randconfig-004-20251125    gcc-14
i386                  randconfig-005-20251125    gcc-14
i386                  randconfig-006-20251125    gcc-14
i386                  randconfig-007-20251125    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251125    gcc-15.1.0
loongarch             randconfig-002-20251125    gcc-12.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
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
powerpc                      chrp32_defconfig    clang-19
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
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251125    gcc-15.1.0
sh                    randconfig-002-20251125    gcc-15.1.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251125    gcc-14.3.0
sparc                 randconfig-002-20251125    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251125    clang-22
sparc64               randconfig-002-20251125    gcc-8.5.0
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
x86_64                randconfig-003-20251126    clang-20
x86_64                randconfig-004-20251126    gcc-14
x86_64                randconfig-005-20251126    gcc-12
x86_64                randconfig-006-20251126    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251125    gcc-8.5.0
xtensa                randconfig-002-20251125    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

