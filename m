Return-Path: <linux-pci+bounces-12658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58553969D9E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 14:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BA3285E11
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED721CF2A2;
	Tue,  3 Sep 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mC+4pygM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AE1C9877
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366608; cv=none; b=ZwBcEuMyS4+HQaIq2KPGukUowbV7kn20GGzOd2AAb8L++gUKR7eToXKkMZ9vpwmw374WDivx/itgWZAp1eo2T+0kWEXwlWOVsm31OiEklz+exdgHtR7ok7noAwBWzp3i3+8Yzb6sUL9OqCYK0lCz8qvzMRov6fQIeKg4J0pD9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366608; c=relaxed/simple;
	bh=5eiT/IDotgYrZmXJ8Mdoh1ChD7VJckJ3O8LS25vNanc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YZv0yKoC3jMubI6HHphdLfIhmBdd4bdfnxMy/5K+d8tKVz/WsfvWLzpwPGlIOlOJ+VsCuAb5FUXWQ76dzYkrB1PPQq2agyEl0bTSlXlTWmToI72kN+RqYHGpI1Qz/ZC3eivvS5WzbAgHr4uV/9t7CfYl/Jbj0/JycsBp/z8U2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mC+4pygM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725366607; x=1756902607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5eiT/IDotgYrZmXJ8Mdoh1ChD7VJckJ3O8LS25vNanc=;
  b=mC+4pygMdiUY2VuOCf+fkrw0nMQ2cd9uKyxliiMgOffw64cMK7NcZRpO
   dW7NqHtm0tbZdXtNVXcEYEwhrJuBefuBqdqywr/FJ2Z38e6sxi2kCmKiJ
   gBjsCH4N1EzxbplgUFtV4pfNUlypLm1DOsPOX2PoqZgXdPJ4gzDNgKTGI
   aUvXkB5RceLkBpncrXeRDzYk+9OON9KWLXmIMKP3tjWFxH5HyVeYgSLyf
   0PfgRtI6qt+LsQSCz9te9WU1G1HdotGjHhD58/bhSeI6jalHPE8+5TL0J
   IjRXB9j6YAobUznd9dXpV+pUQjUpP08UOmrMC0QxgD1vzc+Y4I/0665OG
   g==;
X-CSE-ConnectionGUID: 4xjC0kbpQ5e9Q3LDGbkxBw==
X-CSE-MsgGUID: hjQG3T/hS2KKiJdRBaIWIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="26877309"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="26877309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 05:30:06 -0700
X-CSE-ConnectionGUID: mW6LqSmfSj+32GcS7nPApA==
X-CSE-MsgGUID: QX6XWG4cQru/IXynrq5sMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="64878753"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2024 05:30:04 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slSfa-0006eA-1K;
	Tue, 03 Sep 2024 12:30:02 +0000
Date: Tue, 03 Sep 2024 20:29:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 551a928636b907e1a7508e1a0abb379873f32180
Message-ID: <202409032035.mVA5EKjm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 551a928636b907e1a7508e1a0abb379873f32180  PCI: brcmstb: Enable 7712 SOCs

elapsed time: 976m

configs tested: 186
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                        nsim_700_defconfig   clang-20
arc                        nsimosci_defconfig   clang-20
arc                   randconfig-001-20240903   clang-20
arc                   randconfig-002-20240903   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      jornada720_defconfig   clang-20
arm                          pxa910_defconfig   gcc-14.1.0
arm                   randconfig-001-20240903   clang-20
arm                   randconfig-002-20240903   clang-20
arm                   randconfig-003-20240903   clang-20
arm                   randconfig-004-20240903   clang-20
arm                             rpc_defconfig   gcc-14.1.0
arm                        spear6xx_defconfig   gcc-14.1.0
arm                           sunxi_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240903   clang-20
arm64                 randconfig-002-20240903   clang-20
arm64                 randconfig-003-20240903   clang-20
arm64                 randconfig-004-20240903   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240903   clang-20
csky                  randconfig-002-20240903   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240903   clang-20
hexagon               randconfig-002-20240903   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240903   gcc-12
i386         buildonly-randconfig-002-20240903   gcc-12
i386         buildonly-randconfig-003-20240903   gcc-12
i386         buildonly-randconfig-004-20240903   gcc-12
i386         buildonly-randconfig-005-20240903   gcc-12
i386         buildonly-randconfig-006-20240903   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240903   gcc-12
i386                  randconfig-002-20240903   gcc-12
i386                  randconfig-003-20240903   gcc-12
i386                  randconfig-004-20240903   gcc-12
i386                  randconfig-005-20240903   gcc-12
i386                  randconfig-006-20240903   gcc-12
i386                  randconfig-011-20240903   gcc-12
i386                  randconfig-012-20240903   gcc-12
i386                  randconfig-013-20240903   gcc-12
i386                  randconfig-014-20240903   gcc-12
i386                  randconfig-015-20240903   gcc-12
i386                  randconfig-016-20240903   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240903   clang-20
loongarch             randconfig-002-20240903   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                        mvme147_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                         db1xxx_defconfig   clang-20
mips                     loongson1b_defconfig   clang-20
mips                    maltaup_xpa_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240903   clang-20
nios2                 randconfig-002-20240903   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240903   clang-20
parisc                randconfig-002-20240903   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        fsp2_defconfig   clang-20
powerpc                   lite5200b_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   clang-20
powerpc                   microwatt_defconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc                      ppc44x_defconfig   gcc-14.1.0
powerpc                      ppc6xx_defconfig   gcc-14.1.0
powerpc               randconfig-002-20240903   clang-20
powerpc64                        alldefconfig   clang-20
powerpc64             randconfig-001-20240903   clang-20
powerpc64             randconfig-002-20240903   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240903   clang-20
riscv                 randconfig-002-20240903   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                          debug_defconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240903   clang-20
s390                  randconfig-002-20240903   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                ecovec24-romimage_defconfig   clang-20
sh                        edosk7760_defconfig   clang-20
sh                          r7780mp_defconfig   clang-20
sh                    randconfig-001-20240903   clang-20
sh                    randconfig-002-20240903   clang-20
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7619_defconfig   clang-20
sh                           se7619_defconfig   gcc-14.1.0
sh                           se7721_defconfig   clang-20
sh                   sh7724_generic_defconfig   clang-20
sh                        sh7785lcr_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240903   clang-20
sparc64               randconfig-002-20240903   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240903   clang-20
um                    randconfig-002-20240903   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240903   gcc-12
x86_64       buildonly-randconfig-002-20240903   gcc-12
x86_64       buildonly-randconfig-003-20240903   gcc-12
x86_64       buildonly-randconfig-004-20240903   gcc-12
x86_64       buildonly-randconfig-005-20240903   gcc-12
x86_64       buildonly-randconfig-006-20240903   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240903   gcc-12
x86_64                randconfig-002-20240903   gcc-12
x86_64                randconfig-003-20240903   gcc-12
x86_64                randconfig-004-20240903   gcc-12
x86_64                randconfig-005-20240903   gcc-12
x86_64                randconfig-006-20240903   gcc-12
x86_64                randconfig-011-20240903   gcc-12
x86_64                randconfig-012-20240903   gcc-12
x86_64                randconfig-013-20240903   gcc-12
x86_64                randconfig-014-20240903   gcc-12
x86_64                randconfig-015-20240903   gcc-12
x86_64                randconfig-016-20240903   gcc-12
x86_64                randconfig-071-20240903   gcc-12
x86_64                randconfig-072-20240903   gcc-12
x86_64                randconfig-073-20240903   gcc-12
x86_64                randconfig-074-20240903   gcc-12
x86_64                randconfig-075-20240903   gcc-12
x86_64                randconfig-076-20240903   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240903   clang-20
xtensa                randconfig-002-20240903   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

