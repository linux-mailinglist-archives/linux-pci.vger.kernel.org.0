Return-Path: <linux-pci+bounces-12864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E296E71A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 03:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FEF1C22B09
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 01:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2EC11CA0;
	Fri,  6 Sep 2024 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKiyhVay"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D210940
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584857; cv=none; b=BAcpZrciw56Ef5QxxBSccr0Re/Kz3Wy47HQatfmrxurt4bWt/E9yozKOmphkI4lVqD/AfJOEajk7LGjCIdY4L6ylZp8OK5jKXTKD77FvuMVjC6//9aKby9DnlCr4FzedWmZUgyAHDjpmzI8qHTzRH1E/Ozu2IE3sXfHflRpsDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584857; c=relaxed/simple;
	bh=ns8pxWZAPcZp8M6Ho4bvp7yna9Yo07Q1EW0GaXqtqys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jT5l8vgcAZZJT9BDEs/UWWodO+9Xc6UK6rNZBer8dWFgBhcwh25Cgn/i7P+vliK6Fi9nf1ysyWBgT+/VlgJtWixhV8zZc9swevOe/LB82V5/kMgPloevlVsWWpMTsU8Xtds/Clohlm8i8vZTUbB7oh4n9jCWPPYkThVyR0BS9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKiyhVay; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725584855; x=1757120855;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ns8pxWZAPcZp8M6Ho4bvp7yna9Yo07Q1EW0GaXqtqys=;
  b=dKiyhVay7H/A5iuHElzUsHLo2WpcMSm9NOg2fi4DkcWS5o24Qnk2Laas
   6US+CceYtZfY/sfDQlqCEBPvSrCng+AV7A0XTrYPt84vDhnspauUPy38B
   ZK+4FAcx2lEXa2XJktSbOi+PHfqYgdZuZAvUy8TgkI5vS3zOKl6PG9ZL4
   taw+w8QAyDTJv9f5PyV/Kvw2xe4bWv8eZ8LNhGaKlE0i7PB53rbm0hgxC
   tnqVqSVXHFdBg6mK99SfutKhfFNERJAkRdsOlxgcHmKZok7y4C3nHRnIk
   HDEEzkglH/0UTzL86hs/A3Jn5fgtIhpm6Zb9Y1k+5PwdVKAdPJU7zWVyq
   A==;
X-CSE-ConnectionGUID: Ve5ELButRT6cE6athEJ8lw==
X-CSE-MsgGUID: YNVKpOjNRoGudKXT+D588w==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24134732"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="24134732"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 18:07:34 -0700
X-CSE-ConnectionGUID: xJk2tK3cSrSxzHIlIFpQmQ==
X-CSE-MsgGUID: ACK5u25nQYGGsSPDPalRYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="69956614"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Sep 2024 18:07:33 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smNRi-000ATS-2w;
	Fri, 06 Sep 2024 01:07:30 +0000
Date: Fri, 06 Sep 2024 09:06:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 36c125b163679846625bd02461e280693fed97c4
Message-ID: <202409060947.27OACbJW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 36c125b163679846625bd02461e280693fed97c4  PCI: imx6: Add i.MX8Q PCIe Root Complex (RC) support

elapsed time: 2137m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.3.0
arc                   randconfig-001-20240905   gcc-13.2.0
arc                   randconfig-002-20240905   gcc-13.2.0
arm                   randconfig-001-20240905   clang-14
arm                   randconfig-002-20240905   clang-20
arm                   randconfig-003-20240905   clang-20
arm                   randconfig-004-20240905   gcc-14.1.0
arm64                 randconfig-001-20240905   clang-20
arm64                 randconfig-002-20240905   gcc-14.1.0
arm64                 randconfig-003-20240905   clang-20
arm64                 randconfig-004-20240905   gcc-14.1.0
csky                  randconfig-001-20240905   gcc-14.1.0
csky                  randconfig-002-20240905   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon               randconfig-001-20240905   clang-20
hexagon               randconfig-002-20240905   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240905   clang-18
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-004-20240905   clang-18
i386         buildonly-randconfig-005-20240905   clang-18
i386         buildonly-randconfig-006-20240905   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-002-20240905   clang-18
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-004-20240905   gcc-11
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-011-20240905   clang-18
i386                  randconfig-012-20240905   clang-18
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-014-20240905   clang-18
i386                  randconfig-015-20240905   clang-18
i386                  randconfig-016-20240905   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch             randconfig-001-20240905   gcc-14.1.0
loongarch             randconfig-002-20240905   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
nios2                 randconfig-001-20240905   gcc-14.1.0
nios2                 randconfig-002-20240905   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                randconfig-001-20240905   gcc-14.1.0
parisc                randconfig-002-20240905   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-002-20240905   clang-20
powerpc64             randconfig-001-20240905   gcc-14.1.0
powerpc64             randconfig-002-20240905   gcc-14.1.0
powerpc64             randconfig-003-20240905   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                 randconfig-001-20240905   gcc-14.1.0
riscv                 randconfig-002-20240905   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240905   clang-20
s390                  randconfig-002-20240905   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                    randconfig-001-20240905   gcc-14.1.0
sh                    randconfig-002-20240905   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64               randconfig-001-20240905   gcc-14.1.0
sparc64               randconfig-002-20240905   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                    randconfig-001-20240905   gcc-12
um                    randconfig-002-20240905   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240905   gcc-12
x86_64       buildonly-randconfig-002-20240905   clang-18
x86_64       buildonly-randconfig-003-20240905   gcc-12
x86_64       buildonly-randconfig-004-20240905   clang-18
x86_64       buildonly-randconfig-005-20240905   clang-18
x86_64       buildonly-randconfig-006-20240905   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240905   clang-18
x86_64                randconfig-002-20240905   gcc-12
x86_64                randconfig-003-20240905   clang-18
x86_64                randconfig-004-20240905   gcc-12
x86_64                randconfig-005-20240905   clang-18
x86_64                randconfig-006-20240905   clang-18
x86_64                randconfig-011-20240905   gcc-12
x86_64                randconfig-012-20240905   gcc-12
x86_64                randconfig-013-20240905   clang-18
x86_64                randconfig-014-20240905   clang-18
x86_64                randconfig-015-20240905   gcc-12
x86_64                randconfig-016-20240905   gcc-12
x86_64                randconfig-071-20240905   clang-18
x86_64                randconfig-072-20240905   gcc-11
x86_64                randconfig-073-20240905   clang-18
x86_64                randconfig-074-20240905   clang-18
x86_64                randconfig-075-20240905   gcc-12
x86_64                randconfig-076-20240905   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                randconfig-001-20240905   gcc-14.1.0
xtensa                randconfig-002-20240905   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

