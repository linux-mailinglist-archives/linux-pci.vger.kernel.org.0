Return-Path: <linux-pci+bounces-7386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0B8C34B5
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B00B2810A4
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BC2E644;
	Sat, 11 May 2024 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2KVVUWw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BA27457
	for <linux-pci@vger.kernel.org>; Sat, 11 May 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715469571; cv=none; b=OImThf0StuG1vL2RMFJOUN/kvTE8l4WNC98VtakpQzESIAMmgRHHFSJrts4OqsGnR45g0nELii0Xl60ai8n1UopFS9b9N6j1eGiPUDr2yZW5r2CccMeOhtDWXA7xEBx1OmimCr8e+L4VNdlsHoU/SS/q18j+V5rNvvqiRVXvtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715469571; c=relaxed/simple;
	bh=U8xcH0lwRhG+ROVtBnmkMLl2l7d7FYA2iQWqpnRKhXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fSMwlnJKO5WbchcdQyQ5t/5xbov+PTpiidl7cfhOCQBpb6lPCGcHxYXopdLWekv4tU8+FZTDyw8TCz6r13+f6rPyN8oOekLzgYXGX1U8JQSNzUWr2qIFLJOVGl11PGD1xQX6AfjvFn2ll6nlZr8yrojIqR/EzuF7uvTtweKVfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2KVVUWw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715469569; x=1747005569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U8xcH0lwRhG+ROVtBnmkMLl2l7d7FYA2iQWqpnRKhXU=;
  b=Q2KVVUWwk9jiYRk0p3qQNi4GA0D1TPCXP2cVxHZ9c65yQsd67Qo0Y3Y1
   FzJ21JzlncGYruP28FWrsV2TPXD6TE01c7IhrI0BJkWHIPYetMtp21X1H
   MhNvxWuypGbU1P80ilDCksOlKOVbTAwjgnxDjgzcK3R/FRGdyQwqGf4Z1
   MWIw/UGcjwTEzDl6xhT94/4CxeVJzR1UMeIL0/8OfU31bT1TrTy1yZoUn
   4kmJMZdOE+13MQdun9MPYU+OcABzkKVW/RNZwfyypnuR8F9MCRRtoWvd5
   jlOhEPnkAxIOs7xAQLtJm41KbMWjrvWm8lDksxALuF5p5xSsmjTRxkwSU
   w==;
X-CSE-ConnectionGUID: M0ZsG08fQHGM1qks4ZsNRg==
X-CSE-MsgGUID: En9qssypTaepaQV5s2YUzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11595458"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11595458"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 16:19:28 -0700
X-CSE-ConnectionGUID: OJycCQVuT26jQM70tlsxew==
X-CSE-MsgGUID: D5LK1acLS1CnVpvPgHi2NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="60810117"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 May 2024 16:19:27 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5vzx-0007vP-14;
	Sat, 11 May 2024 23:19:25 +0000
Date: Sun, 12 May 2024 07:19:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 ddc66cc4e6951f5e8bedcb0d4519fa63799dd872
Message-ID: <202405120758.D5roUSmo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: ddc66cc4e6951f5e8bedcb0d4519fa63799dd872  PCI: endpoint: Remove unused field in struct pci_epf_group

elapsed time: 1070m

configs tested: 220
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
arc                   randconfig-001-20240511   gcc  
arc                   randconfig-001-20240512   gcc  
arc                   randconfig-002-20240511   gcc  
arc                   randconfig-002-20240512   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240511   clang
arm                   randconfig-001-20240512   gcc  
arm                   randconfig-002-20240511   clang
arm                   randconfig-003-20240511   gcc  
arm                   randconfig-004-20240511   gcc  
arm                   randconfig-004-20240512   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240511   gcc  
arm64                 randconfig-002-20240511   clang
arm64                 randconfig-003-20240511   gcc  
arm64                 randconfig-004-20240511   clang
arm64                 randconfig-004-20240512   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240511   gcc  
csky                  randconfig-001-20240512   gcc  
csky                  randconfig-002-20240511   gcc  
csky                  randconfig-002-20240512   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240511   clang
hexagon               randconfig-002-20240511   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240511   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240511   clang
i386         buildonly-randconfig-003-20240511   gcc  
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240511   clang
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240511   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240511   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240511   gcc  
i386                  randconfig-002-20240511   clang
i386                  randconfig-003-20240511   gcc  
i386                  randconfig-004-20240511   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240511   gcc  
i386                  randconfig-006-20240511   gcc  
i386                  randconfig-011-20240511   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240511   gcc  
i386                  randconfig-013-20240511   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240511   clang
i386                  randconfig-015-20240511   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240511   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240511   gcc  
loongarch             randconfig-001-20240512   gcc  
loongarch             randconfig-002-20240511   gcc  
loongarch             randconfig-002-20240512   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240511   gcc  
nios2                 randconfig-001-20240512   gcc  
nios2                 randconfig-002-20240511   gcc  
nios2                 randconfig-002-20240512   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240511   gcc  
parisc                randconfig-001-20240512   gcc  
parisc                randconfig-002-20240511   gcc  
parisc                randconfig-002-20240512   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240511   gcc  
powerpc               randconfig-002-20240511   clang
powerpc               randconfig-003-20240511   gcc  
powerpc                     sequoia_defconfig   clang
powerpc64             randconfig-001-20240511   gcc  
powerpc64             randconfig-002-20240511   gcc  
powerpc64             randconfig-003-20240511   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240511   gcc  
riscv                 randconfig-002-20240511   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240511   clang
s390                  randconfig-001-20240512   gcc  
s390                  randconfig-002-20240511   gcc  
s390                  randconfig-002-20240512   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240511   gcc  
sh                    randconfig-001-20240512   gcc  
sh                    randconfig-002-20240511   gcc  
sh                    randconfig-002-20240512   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240511   gcc  
sparc64               randconfig-001-20240512   gcc  
sparc64               randconfig-002-20240511   gcc  
sparc64               randconfig-002-20240512   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240511   gcc  
um                    randconfig-002-20240511   gcc  
um                    randconfig-002-20240512   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240511   gcc  
x86_64       buildonly-randconfig-001-20240512   clang
x86_64       buildonly-randconfig-002-20240511   gcc  
x86_64       buildonly-randconfig-002-20240512   clang
x86_64       buildonly-randconfig-003-20240511   gcc  
x86_64       buildonly-randconfig-003-20240512   clang
x86_64       buildonly-randconfig-004-20240511   gcc  
x86_64       buildonly-randconfig-005-20240511   clang
x86_64       buildonly-randconfig-005-20240512   clang
x86_64       buildonly-randconfig-006-20240511   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240511   clang
x86_64                randconfig-002-20240511   clang
x86_64                randconfig-003-20240511   clang
x86_64                randconfig-003-20240512   clang
x86_64                randconfig-004-20240511   gcc  
x86_64                randconfig-005-20240511   gcc  
x86_64                randconfig-006-20240511   clang
x86_64                randconfig-011-20240511   clang
x86_64                randconfig-012-20240511   gcc  
x86_64                randconfig-013-20240511   gcc  
x86_64                randconfig-013-20240512   clang
x86_64                randconfig-014-20240511   gcc  
x86_64                randconfig-015-20240511   gcc  
x86_64                randconfig-015-20240512   clang
x86_64                randconfig-016-20240511   gcc  
x86_64                randconfig-016-20240512   clang
x86_64                randconfig-071-20240511   gcc  
x86_64                randconfig-071-20240512   clang
x86_64                randconfig-072-20240511   gcc  
x86_64                randconfig-073-20240511   clang
x86_64                randconfig-074-20240511   gcc  
x86_64                randconfig-074-20240512   clang
x86_64                randconfig-075-20240511   gcc  
x86_64                randconfig-075-20240512   clang
x86_64                randconfig-076-20240511   gcc  
x86_64                randconfig-076-20240512   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240511   gcc  
xtensa                randconfig-001-20240512   gcc  
xtensa                randconfig-002-20240511   gcc  
xtensa                randconfig-002-20240512   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

