Return-Path: <linux-pci+bounces-9430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C0191CA85
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 04:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1974D284685
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832E2C148;
	Sat, 29 Jun 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUyxjHM9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9428E3
	for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719628227; cv=none; b=J0U4jn5tbqc9XgYKRJ3/sB2Poeo+OyJPrHaoXPTPKpRtJi9Wy5nnLP+kcuA2FxVIUlnnxht/lX/VryRWXFhZRZ1+isg2joO/29zff0bJNn7bHIbDc27mR3pwPQK6Tf1xOPrvw+Jg0dgbGXM6VgqdTmSJeqTsOKmrvy2hAi7oHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719628227; c=relaxed/simple;
	bh=43QQm04FQJmoFQpORP80Sp8RcMKGNtRFnYWC4IhLC0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LfZXHuXSMtgoEiOJVfUl4TwsqdVywrRPOKDVpDsHrSVce96rWAz3TCRDMBr50+D+Plauyv1NXg1CQdeoamZbBBC2MYWKZLl+XOU0qODZE6I7QpoaXQjzJq5/dUAy7POzAbUbUFbviN8J6gocSUV2Ei+UH0Axz/KZT2Dp/AOEeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUyxjHM9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719628224; x=1751164224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=43QQm04FQJmoFQpORP80Sp8RcMKGNtRFnYWC4IhLC0c=;
  b=JUyxjHM9UjYSbxKbUw6V6lI1rzT/FSRHtWtzcPiNs56M1bys5igTVrO6
   s0TAETwl6CIcvsrve4UYn06NUKPzqKIkWWj0bhgIG4l5/gCKzGChEJZJD
   yD44ZLmrxgAvhh25if1g348L90WeQuKKUJAjHBLYEoIHUIuihqtnU60lv
   ptvlcDgENJqwu+QuxnA9/lPxgm1Kd70/0jUrsg2V61J0puHX7yHlClS4z
   vk9M5PuLXOXxPBTuHSrhD4imPaLJwiy1cgxH+X8tnroT6sSV2UABCJQ4O
   jaO9jiQUn1UnWPA38IjkK85XWmTnEcinweCp7nOi+NjcKh0VKfGyHS2Oz
   A==;
X-CSE-ConnectionGUID: 2fUxWP/2QPeipwliYKkEzA==
X-CSE-MsgGUID: zoVI3eTCQguig9rVtWVXJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16776641"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16776641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 19:30:24 -0700
X-CSE-ConnectionGUID: OBA6bPCFRn68mQNa+FoyeA==
X-CSE-MsgGUID: vPyjk3Y5S2qk+onq89VQ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="75641989"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jun 2024 19:30:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNNr2-000Ish-2Q;
	Sat, 29 Jun 2024 02:30:20 +0000
Date: Sat, 29 Jun 2024 10:29:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 1a1bb493a3644fd6ee33cb5c4ca0a4d528d5286f
Message-ID: <202406291020.7t9hw5Yn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 1a1bb493a3644fd6ee33cb5c4ca0a4d528d5286f  PCI: dw-rockchip: Depend on PCI_ENDPOINT if building endpoint mode support

elapsed time: 1539m

configs tested: 177
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   gcc-13.2.0
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   gcc-13.2.0
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240628   gcc-10
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-002-20240628   gcc-10
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-003-20240628   gcc-10
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-004-20240628   gcc-10
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-005-20240628   gcc-10
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-006-20240628   gcc-10
i386         buildonly-randconfig-006-20240629   gcc-7
i386                                defconfig   clang-18
i386                  randconfig-001-20240628   gcc-10
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-002-20240628   gcc-10
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-003-20240628   gcc-10
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-004-20240628   gcc-10
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-005-20240628   gcc-10
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-006-20240628   gcc-10
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-011-20240628   gcc-10
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-012-20240628   gcc-10
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-013-20240628   gcc-10
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-014-20240628   gcc-10
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-015-20240628   gcc-10
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-016-20240628   gcc-10
i386                  randconfig-016-20240629   gcc-7
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath79_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                    klondike_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240628   gcc-13.2.0
s390                  randconfig-002-20240628   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240628   gcc-13.2.0
um                    randconfig-002-20240628   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   gcc-13
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240628   gcc-13
x86_64                randconfig-002-20240628   gcc-13
x86_64                randconfig-003-20240628   gcc-13
x86_64                randconfig-004-20240628   gcc-13
x86_64                randconfig-005-20240628   gcc-13
x86_64                randconfig-006-20240628   gcc-13
x86_64                randconfig-011-20240628   gcc-13
x86_64                randconfig-012-20240628   gcc-13
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   gcc-13
x86_64                randconfig-015-20240628   gcc-13
x86_64                randconfig-016-20240628   gcc-13
x86_64                randconfig-071-20240628   gcc-13
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   gcc-13
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

