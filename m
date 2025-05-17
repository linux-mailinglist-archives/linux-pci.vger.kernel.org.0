Return-Path: <linux-pci+bounces-27914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81455ABABFB
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494F89E3ADC
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDF17B418;
	Sat, 17 May 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZTLfFSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB119CC27
	for <linux-pci@vger.kernel.org>; Sat, 17 May 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747508953; cv=none; b=Hp35HfaED+MNheLXf+XKe/c3Y5jAU6cOHR7eQ+XaLrMvNJAsLvVj6oxWr2USbL67e1ZtgrqOSpF7fb3acznAURDpEKUMLnMH2eDm0Mve8ZQicMWJd7dvrH8ihWcbVSTouFeR8lcbTzslMNwgWV+C2S4tebMAZyIhzLigBtFrfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747508953; c=relaxed/simple;
	bh=ZoFM4Y3YfxKEd8WgFh1GMqYMVNK2Lkpvbo+X0cW3YPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D2P4ca9aMX50e/g5wsNQMyhN5Q7Z/Vp9mP4WVsxuqmiLvuf91C7vdKHXWPZdvNzKYfeNTSOq89gecFX1mqZ71vE3OTL4N1a2azauu7GRgkpAswoURmpUhVEc40O80R86KszomR+Gg4rXGZnbWpLGIMVrp5kaXnS/qpdpVw2psIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZTLfFSZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747508951; x=1779044951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZoFM4Y3YfxKEd8WgFh1GMqYMVNK2Lkpvbo+X0cW3YPo=;
  b=BZTLfFSZq2cG88dnbssUHVWOgkbIjPaI7BYszajCQRmkISBdJcE2H8Ax
   UdXoI/vtp2su8IK8xAhBSsSbAT4SJIvWORtrS1jH7wbQF1r5BoV/ZpyLP
   wou7+pq2MQ3Qn+0gVS7btzZa0ReNTpVyk/KbjssPddvx63ITGQNNrLdXZ
   NuAyF+29E08ZmGy51aL9Mt5ZRgGgTwY3OvPmwCxwfwNsgx6GPW2CLdTXO
   ery36vr04wueyt1GYW+5RoBnopv4ke9zt15qiq5vepRoMsHPBmCMkgAIs
   sMML5WtH8HL/91S7nbCtyg149XMKSSoB0P5ZcaKlARivtzk/pmu5wUyt6
   Q==;
X-CSE-ConnectionGUID: BUZGTXeiTda+mYLtmiTw6Q==
X-CSE-MsgGUID: MDLgQUk+Rpy1owaW7nPmAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="49612678"
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="49612678"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 12:09:10 -0700
X-CSE-ConnectionGUID: 0wp1UThGROaJxqtL3qaIEw==
X-CSE-MsgGUID: aW7SiZHQRGmWOjiA5rDfYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="176111153"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2025 12:09:09 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGMuA-000KMe-2e;
	Sat, 17 May 2025 19:09:06 +0000
Date: Sun, 18 May 2025 03:08:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-ci/devres] BUILD SUCCESS
 d75e6f46d6fbf4dc3d46957762cab5e8e6ff2923
Message-ID: <202505180333.jC2YX4Id-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-ci/devres
branch HEAD: d75e6f46d6fbf4dc3d46957762cab5e8e6ff2923  PCI: Remove hybrid-devres hazzard warnings from doc

elapsed time: 1454m

configs tested: 183
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250517    gcc-10.5.0
arc                   randconfig-001-20250517    gcc-8.5.0
arc                   randconfig-002-20250517    gcc-14.2.0
arc                   randconfig-002-20250517    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                          gemini_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-21
arm                          moxart_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                   randconfig-001-20250517    clang-21
arm                   randconfig-001-20250517    gcc-8.5.0
arm                   randconfig-002-20250517    gcc-8.5.0
arm                   randconfig-003-20250517    gcc-8.5.0
arm                   randconfig-004-20250517    clang-21
arm                   randconfig-004-20250517    gcc-8.5.0
arm                        realview_defconfig    gcc-14.2.0
arm                             rpc_defconfig    gcc-14.2.0
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250517    clang-17
arm64                 randconfig-001-20250517    gcc-8.5.0
arm64                 randconfig-002-20250517    clang-16
arm64                 randconfig-002-20250517    gcc-8.5.0
arm64                 randconfig-003-20250517    gcc-6.5.0
arm64                 randconfig-003-20250517    gcc-8.5.0
arm64                 randconfig-004-20250517    gcc-8.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250517    gcc-10.5.0
csky                  randconfig-002-20250517    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250517    clang-21
hexagon               randconfig-002-20250517    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250517    clang-20
i386        buildonly-randconfig-002-20250517    clang-20
i386        buildonly-randconfig-003-20250517    clang-20
i386        buildonly-randconfig-004-20250517    clang-20
i386        buildonly-randconfig-004-20250517    gcc-12
i386        buildonly-randconfig-005-20250517    clang-20
i386        buildonly-randconfig-006-20250517    clang-20
i386        buildonly-randconfig-006-20250517    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250517    clang-20
i386                  randconfig-002-20250517    clang-20
i386                  randconfig-003-20250517    clang-20
i386                  randconfig-004-20250517    clang-20
i386                  randconfig-005-20250517    clang-20
i386                  randconfig-006-20250517    clang-20
i386                  randconfig-007-20250517    clang-20
i386                  randconfig-011-20250517    gcc-12
i386                  randconfig-012-20250517    gcc-12
i386                  randconfig-013-20250517    gcc-12
i386                  randconfig-014-20250517    gcc-12
i386                  randconfig-015-20250517    gcc-12
i386                  randconfig-016-20250517    gcc-12
i386                  randconfig-017-20250517    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250517    gcc-14.2.0
loongarch             randconfig-002-20250517    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250517    gcc-14.2.0
nios2                 randconfig-002-20250517    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250517    gcc-5.5.0
parisc                randconfig-002-20250517    gcc-11.5.0
parisc64                         alldefconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                     mpc512x_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250517    gcc-6.5.0
powerpc               randconfig-002-20250517    gcc-6.5.0
powerpc               randconfig-003-20250517    clang-16
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250517    clang-21
powerpc64             randconfig-002-20250517    gcc-6.5.0
powerpc64             randconfig-003-20250517    gcc-6.5.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250517    clang-21
riscv                 randconfig-001-20250517    gcc-9.3.0
riscv                 randconfig-002-20250517    clang-21
riscv                 randconfig-002-20250517    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250517    gcc-7.5.0
s390                  randconfig-001-20250517    gcc-9.3.0
s390                  randconfig-002-20250517    gcc-9.3.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250517    gcc-12.4.0
sh                    randconfig-001-20250517    gcc-9.3.0
sh                    randconfig-002-20250517    gcc-10.5.0
sh                    randconfig-002-20250517    gcc-9.3.0
sh                           se7343_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250517    gcc-11.5.0
sparc                 randconfig-001-20250517    gcc-9.3.0
sparc                 randconfig-002-20250517    gcc-7.5.0
sparc                 randconfig-002-20250517    gcc-9.3.0
sparc64               randconfig-001-20250517    gcc-7.5.0
sparc64               randconfig-001-20250517    gcc-9.3.0
sparc64               randconfig-002-20250517    gcc-5.5.0
sparc64               randconfig-002-20250517    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250517    gcc-12
um                    randconfig-001-20250517    gcc-9.3.0
um                    randconfig-002-20250517    gcc-12
um                    randconfig-002-20250517    gcc-9.3.0
x86_64                           alldefconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250517    clang-20
x86_64      buildonly-randconfig-001-20250517    gcc-12
x86_64      buildonly-randconfig-002-20250517    clang-20
x86_64      buildonly-randconfig-002-20250517    gcc-12
x86_64      buildonly-randconfig-003-20250517    clang-20
x86_64      buildonly-randconfig-004-20250517    clang-20
x86_64      buildonly-randconfig-005-20250517    clang-20
x86_64      buildonly-randconfig-006-20250517    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250517    gcc-9.3.0
xtensa                randconfig-002-20250517    gcc-13.3.0
xtensa                randconfig-002-20250517    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

