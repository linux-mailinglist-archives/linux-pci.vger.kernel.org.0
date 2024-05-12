Return-Path: <linux-pci+bounces-7400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB28C3632
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EEF28163A
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A033B1EA91;
	Sun, 12 May 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjGRZmsm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AA1865C
	for <linux-pci@vger.kernel.org>; Sun, 12 May 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715512915; cv=none; b=SyZNgVJ9uOn9mWHKA3mnMxW9Y/VpIxs4GlsaUd8lYfJdzrPayTw3dAy2wSZAUX/X11fm0DGHIUiD9CLMTvQosnYZMHeHSl+Ysn6KkWo68ptc3A9gANAIRQR2vG8PP3CZKSC1lpV1/v3mwLxZjyj2r9D6Z9w/cXAX/G3BDxA93nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715512915; c=relaxed/simple;
	bh=HaQnJgrbrr6ozUD+U26NyWsnJeaGC3HI8pRdGwM49/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=e3dTYgykQv9x7yD+1qIXJRlALaqOAtPbejELNtIswreVVLw/rfQa99MAvtU2hW/0yBnlJgx3Lo/v1FtuTRAdoBLEASbo22XJujCNJOJo1r4isYBV12ebik7ncYVPJCaOlDc5h1VUfdgImjNywxyS1NvnEbftFTfKqQ68LkTQ2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjGRZmsm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715512914; x=1747048914;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HaQnJgrbrr6ozUD+U26NyWsnJeaGC3HI8pRdGwM49/0=;
  b=PjGRZmsmbxUheH8KcIPNH+oXNZOI0R27K4y3kh77B9kaydl/mpfQE9nq
   6kFgvtgKIuDcVeAygN0Q3y3F/z+EuE4yeZm79ZodUfIWlWw9vu747+EeL
   zq0qHyeVFRS1LbW8OUBe/9tKGSlH+NoBBAwR83g3UF5I+AO8UrHxvJI2o
   cilWyiwt5GQi2NYvyNrV3KBHueKcPuhOzTBueiOvLhzChRRv8gUEydPZz
   RM+UCcY5BZqAelFzQacTpvI4f9XN3Oa0kLLxtP49zhq/B9edcGIFJ0+VU
   8teiv9Yb8VkGuIKxip+LHtgT7MHaPc04gwyHyMZGtQzNlTNWzsTTv4Hva
   g==;
X-CSE-ConnectionGUID: Jyc0NddpTYS4KKBcKCYQdQ==
X-CSE-MsgGUID: eQL+UXXJTjaMR4gXgtVM6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="33965042"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="33965042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 04:21:53 -0700
X-CSE-ConnectionGUID: MT9Mvy2bSXuGop/UI1KprQ==
X-CSE-MsgGUID: hy+MwXbtSxC+iKb7Bk3sOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="30029772"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 May 2024 04:21:52 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s67H3-0008XX-28;
	Sun, 12 May 2024 11:21:49 +0000
Date: Sun, 12 May 2024 19:21:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 13ee3f81afab9fe4b59d5061653c31c3285c7a49
Message-ID: <202405121908.6hznNkbW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 13ee3f81afab9fe4b59d5061653c31c3285c7a49  dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible

elapsed time: 1480m

configs tested: 112
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240512   gcc  
arc                   randconfig-002-20240512   gcc  
arm                               allnoconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                   randconfig-001-20240512   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240512   clang
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240512   clang
i386                                defconfig   clang
i386                  randconfig-001-20240512   clang
i386                  randconfig-002-20240512   clang
i386                  randconfig-003-20240512   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240512   clang
i386                  randconfig-006-20240512   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240512   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240512   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240512   clang
x86_64       buildonly-randconfig-002-20240512   clang
x86_64       buildonly-randconfig-003-20240512   clang
x86_64       buildonly-randconfig-004-20240512   gcc  
x86_64       buildonly-randconfig-006-20240512   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240512   gcc  
x86_64                randconfig-002-20240512   gcc  
x86_64                randconfig-003-20240512   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

