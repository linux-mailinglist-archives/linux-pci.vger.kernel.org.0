Return-Path: <linux-pci+bounces-7398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B04388C35B8
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458ADB20AED
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A261C01;
	Sun, 12 May 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aukfeN3w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764263D6A
	for <linux-pci@vger.kernel.org>; Sun, 12 May 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502831; cv=none; b=IB8gfmrbgh9o43ruuHbqHMSjdgbjXriW9UoNw6OvDnT+2Zns3L5t5c9n3j+PsV4GLCLvWGQeQ1oIsFscidGjGpRk8dtwakXwzlZ+YU4BeVbcawQqX5NrvBxfOm04GJmkCnVb2B0t3WZ0KHAOLwb4w/DM98EsCpDMlvs74au7VQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502831; c=relaxed/simple;
	bh=ens/NdjlTNlWlHmX+9s5JtJ22dmWEzabw8YLYCurd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nrr/81XIWi/1SLZevCSVxxK+jAaHMVwJPgVtK+5Gy8/docy8MNT5106Dug+xdo1PMI8iXuhXHg0qavSrAiWYgOMAMDA0pkpxWMPiMtaLK7oBByAYOzPFTP50F9/eXXcCJxnIq6FNPvOvxitGW+AltxfzOfbh9OmgBRYX9oT368c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aukfeN3w; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715502830; x=1747038830;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ens/NdjlTNlWlHmX+9s5JtJ22dmWEzabw8YLYCurd2s=;
  b=aukfeN3wPWrq3NeLKS+gdhJBok4+KwJl295zbvPkHXELIkX+kD3CUZ9+
   lUW9Ub4fj1++FPtV0m9H1e82/E1XyvPcxGmjZ9O0oFTdOS8+3vHHz2wg8
   Q6Ug9WrhygImTrHr4Iwd0z/504T6u4zXGD2UvggnfmRELJSgeP501hY4p
   XxDWH7OTRHUQ0Dsa3rSesTFYrhaWyg4nJKMlA+LI2/zEZ2sYI4p9uKvpb
   4PkL1vSesSsfIbR6SQO8WqXIN2DxIuOS8MQBXgwXnp7v8bp3VJCPa3rSk
   wuluksE6iEoqK8JSF67ErAqGwXSPGWoGaChmMYxxhOtvR2S/FPEn6SZBU
   Q==;
X-CSE-ConnectionGUID: qkcQR5r6TtulFmUH2yGumg==
X-CSE-MsgGUID: +QpczhMQQoWHnjLNt97hjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="22123008"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="22123008"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 01:33:49 -0700
X-CSE-ConnectionGUID: kfgoXbFVTTOWDXobQYQVzw==
X-CSE-MsgGUID: MUCbeh/5TyaSEme2VaEgyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34568793"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 May 2024 01:33:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s64eP-0008Qv-2K;
	Sun, 12 May 2024 08:33:45 +0000
Date: Sun, 12 May 2024 16:33:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:qcom] BUILD SUCCESS
 6baf8302442ba27ab103fc9b333402c3a19faf30
Message-ID: <202405121659.6WYDm5Ld-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git qcom
branch HEAD: 6baf8302442ba27ab103fc9b333402c3a19faf30  PCI: qcom-ep: Add support for SA8775P SOC

elapsed time: 1457m

configs tested: 159
configs skipped: 3

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
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240512   gcc  
arc                   randconfig-002-20240512   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240512   gcc  
arm                   randconfig-004-20240512   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-004-20240512   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240512   gcc  
csky                  randconfig-002-20240512   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386                                defconfig   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240512   gcc  
loongarch             randconfig-002-20240512   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240512   gcc  
nios2                 randconfig-002-20240512   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240512   gcc  
parisc                randconfig-002-20240512   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc                     sequoia_defconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240512   gcc  
s390                  randconfig-002-20240512   gcc  
s390                       zfcpdump_defconfig   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240512   gcc  
sh                    randconfig-002-20240512   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240512   gcc  
sparc64               randconfig-002-20240512   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240512   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240512   clang
x86_64       buildonly-randconfig-002-20240512   clang
x86_64       buildonly-randconfig-003-20240512   clang
x86_64       buildonly-randconfig-005-20240512   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240512   clang
x86_64                randconfig-013-20240512   clang
x86_64                randconfig-015-20240512   clang
x86_64                randconfig-016-20240512   clang
x86_64                randconfig-071-20240512   clang
x86_64                randconfig-074-20240512   clang
x86_64                randconfig-075-20240512   clang
x86_64                randconfig-076-20240512   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240512   gcc  
xtensa                randconfig-002-20240512   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

