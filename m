Return-Path: <linux-pci+bounces-40953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF80C508D8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 05:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9A93A91AA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BE1A238C;
	Wed, 12 Nov 2025 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBVT6Tvj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FE28FFF6
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762922525; cv=none; b=YataJmJjCPBS+OgYmj4IbQcQ8vDl4J2JtGp6F976HDoXFgbqZeBL14XwAi8Hmt6U5cVypK+fPPF4f2kJjKTBA7NzAyvcVu9lEXWIkj0rSW4sGs+xEwnOL+ussKHtmQd5y9BzLdn2c+sQSMq2MIxyoxqZVCornw6UinnbDiiMCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762922525; c=relaxed/simple;
	bh=MLTzLa1upqtCjzVdj7E06SsZajEcJtjE40sO9TZCERY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AEkqkXIaduMAMmmd99Ovex3AFGNQ4ZSAhrOMLDyALtJbQLKo2yOp1BS2JclV3UYCxg5L2c6PvEr5yWpThrsJSbRAKng54bZFgRUXf19vFYxG/XxGB0pIbiw/5fzf1a2ESC1Apgg5/QW23jM2jnUOqlX94YpMHIOrixgyZQhP2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBVT6Tvj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762922524; x=1794458524;
  h=date:from:to:cc:subject:message-id;
  bh=MLTzLa1upqtCjzVdj7E06SsZajEcJtjE40sO9TZCERY=;
  b=NBVT6TvjPZrDjmsjRbQhCSgLj303FIdbXxIlWxibl1Q+Qw99uwHKspYI
   Ug7MA7OzWnXFcwtbBEbZxcWoioWlrO7sEpEhA1qAyN5zhG9m7eQpAoC+F
   Qi+XsnCR2s9BSxSGLPUCNJVtWgVxhXmad4XnydmuEQMH1t/5VME+1XyhO
   mzRD7vJR/GUuf43DapmH9v4ugoUX/euECPHhQPGGjAK22BsWQjE6cdK8z
   paI4SD2FVQKvXaBJzff/2XYYcasHwOVm0UWG+6MVht7/GC+74+QohE6E8
   lbInc8tQ4x6yTZ3NArBupjpydP0jNYS7esAseZALrlIPMFNnrvuXCs9e2
   A==;
X-CSE-ConnectionGUID: 5LmlHxorSMK+aGm50hsfdQ==
X-CSE-MsgGUID: 5ljbd5UkQSGQUgwe5RrJ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="67583180"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="67583180"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 20:42:03 -0800
X-CSE-ConnectionGUID: sRePnTzHQT2UVG9iNkheXw==
X-CSE-MsgGUID: KiHZFwGvSWiaocmcruHlIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="194100474"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Nov 2025 20:42:03 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJ2gC-0003pn-2G;
	Wed, 12 Nov 2025 04:42:00 +0000
Date: Wed, 12 Nov 2025 12:41:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 b8ec6bcdaa240d0bf56b50ae0e5de2d64929fc25
Message-ID: <202511121205.icleMtJ7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: b8ec6bcdaa240d0bf56b50ae0e5de2d64929fc25  PCI: Prevent restoring assigned resources

elapsed time: 1711m

configs tested: 106
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20251111    gcc-11.5.0
arc                   randconfig-002-20251111    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                   randconfig-001-20251111    clang-22
arm                   randconfig-002-20251111    clang-17
arm                   randconfig-003-20251111    clang-22
arm                   randconfig-004-20251111    gcc-10.5.0
arm                           tegra_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251112    clang-22
arm64                 randconfig-002-20251112    gcc-10.5.0
arm64                 randconfig-003-20251112    gcc-8.5.0
arm64                 randconfig-004-20251112    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251112    gcc-13.4.0
csky                  randconfig-002-20251112    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251111    clang-22
hexagon               randconfig-002-20251111    clang-16
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251112    clang-20
i386        buildonly-randconfig-002-20251112    gcc-14
i386        buildonly-randconfig-003-20251112    clang-20
i386        buildonly-randconfig-004-20251112    clang-20
i386        buildonly-randconfig-005-20251112    gcc-13
i386        buildonly-randconfig-006-20251112    clang-20
i386                  randconfig-001-20251112    gcc-14
i386                  randconfig-002-20251112    gcc-14
i386                  randconfig-003-20251112    gcc-14
i386                  randconfig-004-20251112    clang-20
i386                  randconfig-005-20251112    clang-20
i386                  randconfig-006-20251112    clang-20
i386                  randconfig-007-20251112    gcc-13
i386                  randconfig-011-20251112    gcc-14
i386                  randconfig-012-20251112    gcc-14
i386                  randconfig-013-20251112    clang-20
i386                  randconfig-014-20251112    clang-20
i386                  randconfig-015-20251112    clang-20
i386                  randconfig-016-20251112    gcc-14
i386                  randconfig-017-20251112    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251111    gcc-15.1.0
loongarch             randconfig-002-20251111    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251111    gcc-8.5.0
nios2                 randconfig-002-20251111    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251111    gcc-9.5.0
parisc                randconfig-002-20251111    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                     akebono_defconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20251111    gcc-8.5.0
powerpc               randconfig-002-20251111    clang-22
powerpc64             randconfig-002-20251111    gcc-12.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251112    gcc-8.5.0
sparc                 randconfig-002-20251112    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251112    gcc-8.5.0
sparc64               randconfig-002-20251112    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251112    gcc-14
um                    randconfig-002-20251112    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251112    clang-20
x86_64      buildonly-randconfig-002-20251112    clang-20
x86_64      buildonly-randconfig-003-20251112    clang-20
x86_64      buildonly-randconfig-004-20251112    clang-20
x86_64      buildonly-randconfig-005-20251112    gcc-14
x86_64      buildonly-randconfig-006-20251112    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-012-20251112    gcc-14
x86_64                randconfig-071-20251112    clang-20
x86_64                randconfig-073-20251112    clang-20
x86_64                randconfig-074-20251112    gcc-13
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251112    gcc-12.5.0
xtensa                randconfig-002-20251112    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

