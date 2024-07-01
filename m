Return-Path: <linux-pci+bounces-9527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB6B91E8BF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 21:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A6128339D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 19:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D416D9BA;
	Mon,  1 Jul 2024 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMElnFht"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58D16F848
	for <linux-pci@vger.kernel.org>; Mon,  1 Jul 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862842; cv=none; b=h0FSknMFMziXDb1jnJfO0dMg/H4TqD6e2MM13+0ldrAyRuuRQOy16HXfrekiVd9IBZbppaUTRqfC78KPhPbtgbzuFXosGQMT02czPQiPi9l3dCXoHF5srhwH1U0SUP3oG4s2ew7MjMkBlbHHYUwuHz5I1+/hYvN0S00faJhBIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862842; c=relaxed/simple;
	bh=ZxZ8XlG6gYgoqnvSX4gS6vh2hLsq8p50fy4fpTT7XaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZnGyPECL2zc+bHHeabXYp7ZQWKXB8M7R+Z3An9OBrHGlFXg3R652VrNYT7PcUlm47kwd7kgUwsBV2JrMRG38lBFvOW87Qf55IBvc5XQiUDpDWkbc4pCKdUnkk00q/8rmG1fJS9VoLkaktZCiwqP9cip13KXHdO5ZtPz2rGnn264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMElnFht; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719862840; x=1751398840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZxZ8XlG6gYgoqnvSX4gS6vh2hLsq8p50fy4fpTT7XaY=;
  b=VMElnFhtI5KpA47y9Fl2We9nq0V8E4TX56IM5LIp/OO0/6TRWe2Bw3o1
   28LeTu6rMieyg4lmVCIe5nmL2wTJsV/myDkAxFecwuUU8BAXJQ1zTcroG
   DjRqVeMtQQo/L0SVyEeLZL2pnR0/bF03yVDPQxpnZLxOz9a/ik1MN2ErB
   ocE6WOOGoNzROeTd31u6uVJD7GsF6MyTXE0+uBCXekTqc1SEdyvFPzMpI
   orRTymOmgh7vXPJJ1r1YPMKwhICw45EaPt0IIa75ESnEv9TiiUYekr/iK
   7BZirj8P3XnUgc4txn1Rk/okA3Py+rYbC6Fm9A+AyTqUlTpC7VmrxmA3k
   A==;
X-CSE-ConnectionGUID: jzeYtb3UTDGGtP5YOvCPuw==
X-CSE-MsgGUID: 3DAHHszSTLGVu23EdUxtWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16964744"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16964744"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 12:40:15 -0700
X-CSE-ConnectionGUID: Drs1mf0hS+WSFi6YDbA+WA==
X-CSE-MsgGUID: 7J31Hc53SCmW/ZOJRSHQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45533111"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 Jul 2024 12:40:14 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOMsl-000NIe-31;
	Mon, 01 Jul 2024 19:40:11 +0000
Date: Tue, 02 Jul 2024 03:39:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 4548d07493dcc692a2f7a501d082c2145e0ec511
Message-ID: <202407020356.6gI45mhf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 4548d07493dcc692a2f7a501d082c2145e0ec511  Merge remote-tracking branch 'origin/controller/tegra194' into next

elapsed time: 2687m

configs tested: 105
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240701   gcc-13.2.0
arc                   randconfig-002-20240701   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                       multi_v4t_defconfig   clang-19
arm                   randconfig-001-20240701   gcc-13.2.0
arm                   randconfig-002-20240701   gcc-13.2.0
arm                   randconfig-003-20240701   clang-19
arm                   randconfig-004-20240701   clang-15
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240701   gcc-13.2.0
arm64                 randconfig-002-20240701   clang-19
arm64                 randconfig-003-20240701   gcc-13.2.0
arm64                 randconfig-004-20240701   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240701   gcc-13.2.0
csky                  randconfig-002-20240701   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240701   clang-19
hexagon               randconfig-002-20240701   clang-19
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240630   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240630   gcc-13
i386                  randconfig-001-20240630   gcc-13
i386                  randconfig-002-20240630   gcc-13
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240630   gcc-13
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240630   gcc-13
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240630   gcc-8
i386                  randconfig-014-20240630   gcc-8
i386                  randconfig-015-20240630   gcc-10
i386                  randconfig-016-20240630   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240701   gcc-13.2.0
loongarch             randconfig-002-20240701   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                           ip32_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240701   gcc-13.2.0
nios2                 randconfig-002-20240701   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                randconfig-001-20240701   gcc-13.2.0
parisc                randconfig-002-20240701   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240701   clang-19
powerpc               randconfig-002-20240701   gcc-13.2.0
powerpc               randconfig-003-20240701   gcc-13.2.0
powerpc64             randconfig-001-20240701   gcc-13.2.0
powerpc64             randconfig-002-20240701   gcc-13.2.0
powerpc64             randconfig-003-20240701   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                 randconfig-001-20240701   clang-17
riscv                 randconfig-002-20240701   clang-19
s390                              allnoconfig   clang-19
s390                  randconfig-001-20240701   gcc-13.2.0
s390                  randconfig-002-20240701   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                    randconfig-001-20240701   gcc-13.2.0
sh                    randconfig-002-20240701   gcc-13.2.0
sparc64               randconfig-001-20240701   gcc-13.2.0
sparc64               randconfig-002-20240701   gcc-13.2.0
um                                allnoconfig   clang-17
um                    randconfig-001-20240701   clang-19
um                    randconfig-002-20240701   clang-19
x86_64                           alldefconfig   gcc-13
x86_64       buildonly-randconfig-001-20240701   gcc-11
x86_64       buildonly-randconfig-002-20240701   gcc-13
x86_64       buildonly-randconfig-003-20240701   clang-18
x86_64       buildonly-randconfig-004-20240701   clang-18
x86_64       buildonly-randconfig-005-20240701   gcc-13
x86_64       buildonly-randconfig-006-20240701   gcc-11
x86_64                randconfig-001-20240701   gcc-10
x86_64                randconfig-002-20240701   gcc-13
x86_64                randconfig-003-20240701   gcc-13
x86_64                randconfig-004-20240701   clang-18
x86_64                randconfig-005-20240701   gcc-10
x86_64                randconfig-006-20240701   gcc-12
x86_64                randconfig-011-20240701   clang-18
x86_64                randconfig-012-20240701   clang-18
x86_64                randconfig-013-20240701   clang-18
x86_64                randconfig-014-20240701   clang-18
x86_64                randconfig-015-20240701   gcc-9
x86_64                randconfig-016-20240701   gcc-13
x86_64                randconfig-071-20240701   clang-18
x86_64                randconfig-072-20240701   gcc-9
x86_64                randconfig-073-20240701   clang-18
x86_64                randconfig-074-20240701   gcc-11
x86_64                randconfig-075-20240701   gcc-13
x86_64                randconfig-076-20240701   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240701   gcc-13.2.0
xtensa                randconfig-002-20240701   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

