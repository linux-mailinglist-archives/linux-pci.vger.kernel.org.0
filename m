Return-Path: <linux-pci+bounces-4718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50176877B8A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 09:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37B02822B0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C463AE;
	Mon, 11 Mar 2024 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsAqfdq4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C412B7F
	for <linux-pci@vger.kernel.org>; Mon, 11 Mar 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710144763; cv=none; b=eOcQak9dxzbb4yWa14XBbHn3YcVsCitSXY11IpU8O547dD+kSQryh6ufKHWdMscONEiLbdGF2ogfSrc7N2pmxqMAXbhW93C/NeR7Esv9q6KKzwgTRPNvAYu+ewCiGhyqFFBSzBIHHgXbW/k/WR1Mokll9Qlxyo+hpCCpd40Qwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710144763; c=relaxed/simple;
	bh=179CT+uQVysu9z5CdVJzuKSSV37vbMFj58vFF64VmxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XPsRgRraT+Sf4JFCNYDsAWFnQ85jz7KeLf6JnE0OQr4nzWV7NH65+j5pReBRYR358SvqsD2ze7lxCm6sLNNu/EOpF5K/0qq4UjkQRLND8ijHHQCj6ENivW85MeFBX5rStHt0/9YmlN8rWdIbLfciniMsc0vlJgMGN4djdXzufZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsAqfdq4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710144762; x=1741680762;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=179CT+uQVysu9z5CdVJzuKSSV37vbMFj58vFF64VmxQ=;
  b=AsAqfdq4fHVkX9Y25YI8Rw41j1tyytr7fba7fzr7mU8X5DIjmi+MrvGw
   k07noaA84M7a45b4lZIR0MhPbb9AnWAgTzixNRU34lWu2aeXPWebIRv7z
   DrhEVQaipIfwqHm4zOkBsDLHPMTi5MXKq+4R7vqs5Lza0ohLIaZPJfC1G
   DjYqB6o4Hm22hMwsKRp25HwWmpE8TqvL52aiS3dK7HxVXAlwkbrF76qj8
   0avf3kkz4BR0gqi+9GWdY/nta1x642KxUbC82sVAz09Ec0c8QWjtx14sK
   v8IEHpguKMCpgRWk8mtrN5Ast9aWuxvndG2yqX1Wx1cZ5/hrlpIrgP0Fn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4644071"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4644071"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 01:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15746122"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Mar 2024 01:12:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjalw-00090G-0o;
	Mon, 11 Mar 2024 08:12:36 +0000
Date: Mon, 11 Mar 2024 16:11:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 667a006d73fb7320fc6f414b6fe11a998fcf0c28
Message-ID: <202403111640.X1XllDXW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 667a006d73fb7320fc6f414b6fe11a998fcf0c28  PCI: cadence: Clear the ARI Capability Next Function Number of the last function

elapsed time: 795m

configs tested: 197
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240311   gcc  
arc                   randconfig-002-20240311   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                          exynos_defconfig   clang
arm                           h3600_defconfig   gcc  
arm                           imxrt_defconfig   clang
arm                      integrator_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240311   clang
arm                   randconfig-002-20240311   gcc  
arm                   randconfig-003-20240311   clang
arm                   randconfig-004-20240311   clang
arm                       spear13xx_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240311   clang
arm64                 randconfig-002-20240311   clang
arm64                 randconfig-003-20240311   clang
arm64                 randconfig-004-20240311   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240311   gcc  
csky                  randconfig-002-20240311   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240311   clang
hexagon               randconfig-002-20240311   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240311   clang
i386         buildonly-randconfig-002-20240311   clang
i386         buildonly-randconfig-003-20240311   clang
i386         buildonly-randconfig-004-20240311   gcc  
i386         buildonly-randconfig-005-20240311   clang
i386         buildonly-randconfig-006-20240311   clang
i386                                defconfig   clang
i386                  randconfig-001-20240311   gcc  
i386                  randconfig-002-20240311   gcc  
i386                  randconfig-003-20240311   clang
i386                  randconfig-004-20240311   clang
i386                  randconfig-005-20240311   gcc  
i386                  randconfig-006-20240311   clang
i386                  randconfig-011-20240311   gcc  
i386                  randconfig-012-20240311   gcc  
i386                  randconfig-013-20240311   clang
i386                  randconfig-014-20240311   gcc  
i386                  randconfig-015-20240311   clang
i386                  randconfig-016-20240311   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240311   gcc  
loongarch             randconfig-002-20240311   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240311   gcc  
nios2                 randconfig-002-20240311   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240311   gcc  
parisc                randconfig-002-20240311   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240311   gcc  
powerpc               randconfig-002-20240311   clang
powerpc               randconfig-003-20240311   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240311   clang
powerpc64             randconfig-002-20240311   clang
powerpc64             randconfig-003-20240311   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240311   clang
riscv                 randconfig-002-20240311   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240311   clang
s390                  randconfig-002-20240311   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240311   gcc  
sh                    randconfig-002-20240311   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240311   gcc  
sparc64               randconfig-002-20240311   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240311   gcc  
um                    randconfig-002-20240311   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240311   clang
x86_64       buildonly-randconfig-002-20240311   clang
x86_64       buildonly-randconfig-003-20240311   clang
x86_64       buildonly-randconfig-004-20240311   gcc  
x86_64       buildonly-randconfig-005-20240311   clang
x86_64       buildonly-randconfig-006-20240311   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240311   clang
x86_64                randconfig-002-20240311   clang
x86_64                randconfig-003-20240311   gcc  
x86_64                randconfig-004-20240311   gcc  
x86_64                randconfig-005-20240311   gcc  
x86_64                randconfig-006-20240311   clang
x86_64                randconfig-011-20240311   clang
x86_64                randconfig-012-20240311   clang
x86_64                randconfig-013-20240311   clang
x86_64                randconfig-014-20240311   gcc  
x86_64                randconfig-015-20240311   clang
x86_64                randconfig-016-20240311   gcc  
x86_64                randconfig-071-20240311   gcc  
x86_64                randconfig-072-20240311   clang
x86_64                randconfig-073-20240311   clang
x86_64                randconfig-074-20240311   gcc  
x86_64                randconfig-075-20240311   clang
x86_64                randconfig-076-20240311   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240311   gcc  
xtensa                randconfig-002-20240311   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

