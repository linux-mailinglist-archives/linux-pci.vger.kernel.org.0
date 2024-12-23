Return-Path: <linux-pci+bounces-18968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D39FAE6D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 13:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA56A161438
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48F1917D8;
	Mon, 23 Dec 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXNNZrzF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A01A8F89
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958426; cv=none; b=iuCNZAr1VnTGiWwDmKTe1Ql3SWUVLQ9QHrjdy2bKAHIT8T89G7GNH9AegoYylpFrchjvWGG/sMCfpmHc/8YQgRiVWTuIf9u9mrnPxgx9Aw20dgJ2FPG5jULsVaICcqHtT9ckTolhOlRi0xFPlmkTonKrk5LXodVNgjoQI2F+x9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958426; c=relaxed/simple;
	bh=tviQYSv2SzkeaubNiEIo6kOzIrLIh1PrUmAzkMsUZCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WgWCR3qokJZRCL/rFoEMa3MKfqPIUglawRqfCguKpkOaw5gS2osJfDMhzXaS9yRkosA8S4rlJnJTqlNIA+3hDFCIiktbnwdSTHL+0jKfAYByZahvG6AaGdlTkj5B5lWDWM4l5SPQaJMUyO/cerIEW5ISIr2TAbFC5wF8qC4DkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXNNZrzF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734958424; x=1766494424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tviQYSv2SzkeaubNiEIo6kOzIrLIh1PrUmAzkMsUZCA=;
  b=lXNNZrzFnLMEKgirYl4Om6v7KLub5RRfV9VBlcmOs+Rntc1Y+GU5MjHP
   CszVKMhnSIIIfXPIDJLiNUkzQh9H5n+i7qIu9ph6NlJ6n/2pdUdOk5/CL
   BqX7M4z9tLhVyADZAsLZBVuCJURDXRmk1qaAPMCm13pu4/FWy7in38ce2
   kpo6Nwnktr2T86++tlTg/JlW8M1iQ/ZvfFeExCSbJKKbGFnYPOp59JyQz
   7FejB8CeygchPw5rYzZc5CAXf2r+//TP9tYmTjNGiaHOi2UuneLiKdI0K
   ODZj+kb5blN7+Qdz/8+adjJbpU4gUwKzOyO69CcNNaFtgNW+AuFpMxe1A
   g==;
X-CSE-ConnectionGUID: i9XdnozZRgq+GIrbCspOwA==
X-CSE-MsgGUID: 3eNDK0SNS0e6LHz9Uv2ugQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="39356937"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="39356937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 04:53:44 -0800
X-CSE-ConnectionGUID: aEUULxXCR2iMbXbXziZO1Q==
X-CSE-MsgGUID: aA9O7t+3RieTaojGkYtiEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104189907"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Dec 2024 04:53:42 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tPhwK-0003b9-0x;
	Mon, 23 Dec 2024 12:53:40 +0000
Date: Mon, 23 Dec 2024 20:53:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 220bd83f9da19e862e6c230fff78d3e1219990bd
Message-ID: <202412232009.vRn85T2x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 220bd83f9da19e862e6c230fff78d3e1219990bd  PCI: rockchip: Add missing fields descriptions for struct rockchip_pcie_ep

elapsed time: 884m

configs tested: 172
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241223    gcc-13.2.0
arc                   randconfig-002-20241223    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20241223    gcc-14.2.0
arm                   randconfig-002-20241223    clang-16
arm                   randconfig-003-20241223    clang-20
arm                   randconfig-004-20241223    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241223    gcc-14.2.0
arm64                 randconfig-002-20241223    clang-18
arm64                 randconfig-003-20241223    gcc-14.2.0
arm64                 randconfig-004-20241223    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241223    gcc-14.2.0
csky                  randconfig-002-20241223    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241223    clang-19
hexagon               randconfig-002-20241223    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241223    clang-19
i386        buildonly-randconfig-002-20241223    clang-19
i386        buildonly-randconfig-003-20241223    clang-19
i386        buildonly-randconfig-004-20241223    gcc-12
i386        buildonly-randconfig-005-20241223    clang-19
i386        buildonly-randconfig-006-20241223    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241223    gcc-12
i386                  randconfig-002-20241223    gcc-12
i386                  randconfig-003-20241223    gcc-12
i386                  randconfig-004-20241223    gcc-12
i386                  randconfig-005-20241223    gcc-12
i386                  randconfig-006-20241223    gcc-12
i386                  randconfig-007-20241223    gcc-12
i386                  randconfig-011-20241223    clang-19
i386                  randconfig-012-20241223    clang-19
i386                  randconfig-013-20241223    clang-19
i386                  randconfig-014-20241223    clang-19
i386                  randconfig-015-20241223    clang-19
i386                  randconfig-016-20241223    clang-19
i386                  randconfig-017-20241223    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241223    gcc-14.2.0
loongarch             randconfig-002-20241223    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-20
mips                           xway_defconfig    clang-20
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241223    gcc-14.2.0
nios2                 randconfig-002-20241223    gcc-14.2.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241223    gcc-14.2.0
parisc                randconfig-002-20241223    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241223    clang-18
powerpc               randconfig-002-20241223    clang-16
powerpc               randconfig-003-20241223    clang-20
powerpc                     skiroot_defconfig    clang-20
powerpc64             randconfig-001-20241223    gcc-14.2.0
powerpc64             randconfig-002-20241223    clang-18
powerpc64             randconfig-003-20241223    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241223    clang-20
riscv                 randconfig-002-20241223    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241223    clang-20
s390                  randconfig-002-20241223    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241223    gcc-14.2.0
sh                    randconfig-002-20241223    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20241223    gcc-14.2.0
sparc                 randconfig-002-20241223    gcc-14.2.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241223    gcc-14.2.0
sparc64               randconfig-002-20241223    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241223    clang-16
um                    randconfig-002-20241223    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241223    gcc-12
x86_64      buildonly-randconfig-002-20241223    clang-19
x86_64      buildonly-randconfig-003-20241223    clang-19
x86_64      buildonly-randconfig-004-20241223    gcc-12
x86_64      buildonly-randconfig-005-20241223    gcc-12
x86_64      buildonly-randconfig-006-20241223    clang-19
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20241223    clang-19
x86_64                randconfig-002-20241223    clang-19
x86_64                randconfig-003-20241223    clang-19
x86_64                randconfig-004-20241223    clang-19
x86_64                randconfig-005-20241223    clang-19
x86_64                randconfig-006-20241223    clang-19
x86_64                randconfig-007-20241223    clang-19
x86_64                randconfig-008-20241223    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                randconfig-001-20241223    gcc-14.2.0
xtensa                randconfig-002-20241223    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

