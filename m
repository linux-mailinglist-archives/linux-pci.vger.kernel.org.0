Return-Path: <linux-pci+bounces-13211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379D9791B5
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1162C1F2221E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587F1D0163;
	Sat, 14 Sep 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PknUj5Uk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2771CDA13
	for <linux-pci@vger.kernel.org>; Sat, 14 Sep 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325948; cv=none; b=hEFXxtnV4SraEywnil9y62O77bZ1Phovlpgv1He44wFHcHn4yDAZs2VgbKIcYCOXOPKUd2bJ4k2cqdZAB8BxCQvbYF038Lpf1Xk0+qEeRinSfOuP+MmFNz4GbEdjNH8Xc4nS3XaC2tzU+BNl8BOZaHf0alWyMCEr/74MBjiaaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325948; c=relaxed/simple;
	bh=CVUXMdwQsZiP4ULUGXWtym6Y97fZdZWYGsnkSiyoNLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ONZemBpQx3YRGRd2e2ayfEb9n9Jh0qlnrypG9mOUPUgzgt0By7F/30/0eEbreq3S6JsUA0ubfZXPfY/jDJPBne3gIZrYHAgJ1AZhb0lsOgIdKMvzw69ByEh54a8moSAasPvY1fnGiFfCB5ED6NuHhe3ggVMj8fW9bxINaTX7LNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PknUj5Uk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726325947; x=1757861947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CVUXMdwQsZiP4ULUGXWtym6Y97fZdZWYGsnkSiyoNLk=;
  b=PknUj5UkRwDDhM49opD2TOQUyKOCkRVL4VnfDoi92CaoofZ3dQfjpKb3
   xFXTMYHGwZZMynABuKlbtKrZbjAbmAwh57DjdlVimBCOXoEHlUnu0mfap
   xa9Oaq3dArNkA0m1/MHniAXYMnKoIl/qOuv/ChT1JsMwKo+7TTppIfPBp
   JN4Fui2jXo9d1r3sh2myvFNDvrs2hv3xLb+Kpu1sgsdw00JcAviYOsFE/
   iqu1h9t1fPdrA7KCcUMX59zQmNmDJOu4i3wrpNUVuPePb9vxNzgOKiCCH
   h/CrvYzwrAYtb5Pd2/27z+CyH6mOc0MPUrRyXo1Al+rQBdvF0Ltv2Hi4L
   A==;
X-CSE-ConnectionGUID: k8lyEEpOTmaupLlBzYsZzQ==
X-CSE-MsgGUID: IOqhaGeLSDekMRGhPlvkrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25103037"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="25103037"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 07:59:06 -0700
X-CSE-ConnectionGUID: fvH6AUsDTeuSsGd1jIjf/g==
X-CSE-MsgGUID: 9NTrwA7gQNSPALw1ZgawpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="72802867"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Sep 2024 07:59:04 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spUEo-0007rs-28;
	Sat, 14 Sep 2024 14:59:02 +0000
Date: Sat, 14 Sep 2024 22:58:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:tools] BUILD SUCCESS
 d0aac667f2e02f114bc6c3bf8c085a6060599aef
Message-ID: <202409142241.qplCdL4l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tools
branch HEAD: d0aac667f2e02f114bc6c3bf8c085a6060599aef  tools: PCI: Remove unused BILLION macro

elapsed time: 910m

configs tested: 168
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240914    gcc-13.2.0
arc                   randconfig-002-20240914    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      jornada720_defconfig    clang-20
arm                            mmp2_defconfig    clang-20
arm                        multi_v5_defconfig    clang-20
arm                   randconfig-001-20240914    gcc-13.2.0
arm                   randconfig-002-20240914    gcc-13.2.0
arm                   randconfig-003-20240914    gcc-13.2.0
arm                   randconfig-004-20240914    gcc-13.2.0
arm                         wpcm450_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240914    gcc-13.2.0
arm64                 randconfig-002-20240914    gcc-13.2.0
arm64                 randconfig-003-20240914    gcc-13.2.0
arm64                 randconfig-004-20240914    gcc-13.2.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240914    gcc-13.2.0
csky                  randconfig-002-20240914    gcc-13.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240914    gcc-13.2.0
hexagon               randconfig-002-20240914    gcc-13.2.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240914    clang-18
i386        buildonly-randconfig-002-20240914    clang-18
i386        buildonly-randconfig-003-20240914    clang-18
i386        buildonly-randconfig-004-20240914    clang-18
i386        buildonly-randconfig-005-20240914    clang-18
i386        buildonly-randconfig-006-20240914    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240914    clang-18
i386                  randconfig-002-20240914    clang-18
i386                  randconfig-003-20240914    clang-18
i386                  randconfig-004-20240914    clang-18
i386                  randconfig-005-20240914    clang-18
i386                  randconfig-006-20240914    clang-18
i386                  randconfig-011-20240914    clang-18
i386                  randconfig-012-20240914    clang-18
i386                  randconfig-013-20240914    clang-18
i386                  randconfig-014-20240914    clang-18
i386                  randconfig-015-20240914    clang-18
i386                  randconfig-016-20240914    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240914    gcc-13.2.0
loongarch             randconfig-002-20240914    gcc-13.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    clang-20
m68k                        m5307c3_defconfig    clang-20
m68k                          multi_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        omega2p_defconfig    clang-20
mips                      pic32mzda_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240914    gcc-13.2.0
nios2                 randconfig-002-20240914    gcc-13.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    clang-20
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240914    gcc-13.2.0
parisc                randconfig-002-20240914    gcc-13.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    clang-20
powerpc                   microwatt_defconfig    clang-20
powerpc               randconfig-001-20240914    gcc-13.2.0
powerpc64             randconfig-001-20240914    gcc-13.2.0
powerpc64             randconfig-002-20240914    gcc-13.2.0
powerpc64             randconfig-003-20240914    gcc-13.2.0
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240914    gcc-13.2.0
riscv                 randconfig-002-20240914    gcc-13.2.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240914    gcc-13.2.0
s390                  randconfig-002-20240914    gcc-13.2.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20240914    gcc-13.2.0
sh                    randconfig-002-20240914    gcc-13.2.0
sh                           se7705_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240914    gcc-13.2.0
sparc64               randconfig-002-20240914    gcc-13.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240914    gcc-13.2.0
um                    randconfig-002-20240914    gcc-13.2.0
um                           x86_64_defconfig    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240914    clang-18
x86_64      buildonly-randconfig-002-20240914    clang-18
x86_64      buildonly-randconfig-003-20240914    clang-18
x86_64      buildonly-randconfig-004-20240914    clang-18
x86_64      buildonly-randconfig-005-20240914    clang-18
x86_64      buildonly-randconfig-006-20240914    clang-18
x86_64                              defconfig    clang-18
x86_64                randconfig-001-20240914    clang-18
x86_64                randconfig-002-20240914    clang-18
x86_64                randconfig-003-20240914    clang-18
x86_64                randconfig-004-20240914    clang-18
x86_64                randconfig-005-20240914    clang-18
x86_64                randconfig-006-20240914    clang-18
x86_64                randconfig-011-20240914    clang-18
x86_64                randconfig-012-20240914    clang-18
x86_64                randconfig-013-20240914    clang-18
x86_64                randconfig-014-20240914    clang-18
x86_64                randconfig-015-20240914    clang-18
x86_64                randconfig-016-20240914    clang-18
x86_64                randconfig-071-20240914    clang-18
x86_64                randconfig-072-20240914    clang-18
x86_64                randconfig-073-20240914    clang-18
x86_64                randconfig-074-20240914    clang-18
x86_64                randconfig-075-20240914    clang-18
x86_64                randconfig-076-20240914    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240914    gcc-13.2.0
xtensa                randconfig-002-20240914    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

