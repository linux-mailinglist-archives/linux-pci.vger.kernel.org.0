Return-Path: <linux-pci+bounces-34965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B332FB39295
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 06:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BAC463FE9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 04:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EC614F112;
	Thu, 28 Aug 2025 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKbUCPL5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687F1E89C
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756355415; cv=none; b=QxoAQNqqaZEY5X/x+P9k6ks6sYNUcZJXxHf57POaP+ex0LqF4U+sciGzAOkGbSi/HGyD6hWv9WmuqVSADHuLGbvxs0uagN2VjE+cOeRhIyOmmbgXKu/VzOpzqVgNrYk1bPVVVDCrQ/lJ4rlE7JEtcBZVZHUzno/UdkurkNWaiBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756355415; c=relaxed/simple;
	bh=BLymeEW+Dw8jl3BaE214EjTnw7QxnVwjYtYuGOHR8p4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tqZoy8bnXSaaHZAEePO1bFaplzpAHQiXQOiJuoH7K9di1anV2NcLg07m0VPMPEphQLeeJpLegy2uOxxGQodAXGamYQIbsL5qK/nuWx1adMBzLoroN4vlnh3UCE6NEEYLkJGBoybzrHC5g9D5McSDSXD2e52EZsl+cvcwCj6YHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKbUCPL5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756355414; x=1787891414;
  h=date:from:to:cc:subject:message-id;
  bh=BLymeEW+Dw8jl3BaE214EjTnw7QxnVwjYtYuGOHR8p4=;
  b=iKbUCPL5lOL4QM5LyEhxX7QyP7xlBhFO6IkDS7dJKT1GtblNoV8C1/om
   qz9O7lLg6xo3dOLoNIx01HuAC7nQULAAvOC+gSmzS+adm7DKGvW7/QgW3
   WQZB2vztVXsEFgjfASYeYdzMSQIzCtbI9bmYPMCi4pfbS1TzAYqVnK1aJ
   j2JQ8tIGZYjwf72BQRD/8ruEt/xh5aAbi0pfB21PBZ12rkbktr1gv6fUg
   3X0Wi5ewxb88KNxRxm927TJ4NJhrragnUEoDz8Qmpto3St5tLlP3paLB4
   LaA/KLtr8Ay6bbKn8F1ngp7dHb0sBcpjdf9l4ikd9wEFnvMDgpNgAwJ4j
   w==;
X-CSE-ConnectionGUID: oSMIws8xSy+3s6P/+BbsQQ==
X-CSE-MsgGUID: ujx5nacwQY+yaMSxgVYvIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58466988"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58466988"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 21:30:14 -0700
X-CSE-ConnectionGUID: 8q1yw9yKTWS60C/U6fkMlQ==
X-CSE-MsgGUID: 3Hsaz1p8SPCxOwnBTpWCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169932653"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 27 Aug 2025 21:30:12 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urUH4-000TQ7-0K;
	Thu, 28 Aug 2025 04:30:10 +0000
Date: Thu, 28 Aug 2025 12:29:54 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 106fc08b30a2ece49a251b053165a83d41d50fd0
Message-ID: <202508281244.TGUjP06s-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 106fc08b30a2ece49a251b053165a83d41d50fd0  selftests: pci_endpoint: Skip IRQ test if IRQ is out of range.

elapsed time: 893m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250827    gcc-12.5.0
arc                   randconfig-002-20250827    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250827    clang-22
arm                   randconfig-002-20250827    clang-22
arm                   randconfig-003-20250827    clang-22
arm                   randconfig-004-20250827    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250827    gcc-11.5.0
arm64                 randconfig-002-20250827    gcc-8.5.0
arm64                 randconfig-003-20250827    clang-22
arm64                 randconfig-004-20250827    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250827    gcc-10.5.0
csky                  randconfig-002-20250827    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250827    clang-22
hexagon               randconfig-002-20250827    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-002-20250827    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        mvme147_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-17
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250827    gcc-8.5.0
nios2                 randconfig-002-20250827    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250827    gcc-12.5.0
parisc                randconfig-002-20250827    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250827    clang-22
powerpc               randconfig-002-20250827    clang-22
powerpc               randconfig-003-20250827    clang-22
powerpc64             randconfig-001-20250827    gcc-11.5.0
powerpc64             randconfig-002-20250827    gcc-11.5.0
powerpc64             randconfig-003-20250827    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250827    clang-19
riscv                 randconfig-002-20250827    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250827    gcc-13.4.0
s390                  randconfig-002-20250827    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250827    gcc-15.1.0
sh                    randconfig-002-20250827    gcc-9.5.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250827    gcc-15.1.0
sparc                 randconfig-002-20250827    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250827    gcc-11.5.0
sparc64               randconfig-002-20250827    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250827    gcc-12
um                    randconfig-002-20250827    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250827    clang-20
x86_64      buildonly-randconfig-002-20250827    clang-20
x86_64      buildonly-randconfig-003-20250827    gcc-12
x86_64      buildonly-randconfig-004-20250827    gcc-12
x86_64      buildonly-randconfig-005-20250827    clang-20
x86_64      buildonly-randconfig-006-20250827    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250827    gcc-10.5.0
xtensa                randconfig-002-20250827    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

