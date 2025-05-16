Return-Path: <linux-pci+bounces-27847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA069AB99F5
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80719E2E10
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3BF381C4;
	Fri, 16 May 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4Dfc1HA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502321348
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390712; cv=none; b=q2mL5D2C5synl0kXBg4mfkDvkkUTmieAZ4Ezitno6JVh2Y2+eUHj9W8zZ6LXx9jcT9Ntt7XfWNM+ufD1GZNjo6ZjRAGpngCXmgpYRkSbsXvVR+JOFi49aPq5wH8vr6hG6HhEfy0onDsXksELrJidOrq5kMUkuZwoJ47xpNoVNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390712; c=relaxed/simple;
	bh=yLKk9yCBu5l7h/fzXL/OaPoWq/tR6MOp1ysy3nOwuWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Jxt8+tps2HqeLbkxbZjFi1PwJZDzCOThqNuE7FBbqMhEEoUIS+KbxoH9D/cn4RpKmtQHA5hflJGVounMHFGNf+H1ablaLrYC3wxGqEQCxeXV9vFwGOGf62SBfJeFKoI43xAJSUM7HLynTflr8CNqeuA22R+JslTEzmvPwSuBPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4Dfc1HA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747390710; x=1778926710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yLKk9yCBu5l7h/fzXL/OaPoWq/tR6MOp1ysy3nOwuWA=;
  b=U4Dfc1HAqqVJnj33609ORwkse38GhDz6DUBCHOI2EdfpPVe5zZ1nZECb
   0SXT3njCqoSUAf797dm4b8CfzaaeciABwFu/kMPO+hld1Cni1jmplFLdA
   stk11O29hx1i+3tfy++DHAV0FNCUDgw7Rrsx7LBKEIjCgvFtf4tM467zQ
   O5l8Jj2TJVoXzbpjEDMl3Y2g1Om7PGPtkXtt/sggQjpDZUvNRZ8ofF57m
   4i+VGUC4G2BiFOlC6SdyTXtdkaQ+bbVcQC9rI3zPVIOujzDa2huF5/7oN
   u1jIZd9mTyJjhv1/rnGoHwGu2J3HqbO9cth7V1DFAzGQPmkSruZZWrQKt
   w==;
X-CSE-ConnectionGUID: AOX/MUaZQU2NurQjU00yRQ==
X-CSE-MsgGUID: 7N++WVNhQ7W91n8EYnH7mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53172756"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53172756"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 03:18:30 -0700
X-CSE-ConnectionGUID: EVgv3AoFQja60Lw57OC7Cw==
X-CSE-MsgGUID: MtqKRjVWRU6lkh6gpOFRvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138567641"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 May 2025 03:18:29 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFs94-000JEv-2s;
	Fri, 16 May 2025 10:18:26 +0000
Date: Fri, 16 May 2025 18:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:ptm-debugfs] BUILD SUCCESS
 5fbfae69e78d242c5efb2a4b62eeea883af145ee
Message-ID: <202505161832.1aYdyt9w-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ptm-debugfs
branch HEAD: 5fbfae69e78d242c5efb2a4b62eeea883af145ee  PCI: qcom-ep: Mask PTM_UPDATING interrupt

elapsed time: 1451m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20250515    gcc-12.4.0
arc                   randconfig-002-20250515    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                           imxrt_defconfig    clang-21
arm                   randconfig-001-20250515    clang-21
arm                   randconfig-002-20250515    gcc-8.5.0
arm                   randconfig-003-20250515    gcc-8.5.0
arm                   randconfig-004-20250515    clang-21
arm                           sama5_defconfig    gcc-14.2.0
arm                           sama7_defconfig    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250515    clang-21
arm64                 randconfig-002-20250515    clang-21
arm64                 randconfig-003-20250515    clang-20
arm64                 randconfig-004-20250515    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250515    gcc-14.2.0
csky                  randconfig-002-20250515    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250515    clang-16
hexagon               randconfig-002-20250515    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-002-20250515    gcc-12
i386        buildonly-randconfig-003-20250515    clang-20
i386        buildonly-randconfig-004-20250515    clang-20
i386        buildonly-randconfig-005-20250515    gcc-12
i386        buildonly-randconfig-006-20250515    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250515    gcc-12.4.0
loongarch             randconfig-002-20250515    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                           sun3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250515    gcc-12.4.0
nios2                 randconfig-002-20250515    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250515    gcc-13.3.0
parisc                randconfig-002-20250515    gcc-13.3.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-21
powerpc               randconfig-001-20250515    gcc-8.5.0
powerpc               randconfig-002-20250515    gcc-6.5.0
powerpc               randconfig-003-20250515    clang-21
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    clang-21
powerpc64             randconfig-001-20250515    clang-21
powerpc64             randconfig-002-20250515    gcc-8.5.0
powerpc64             randconfig-003-20250515    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-002-20250515    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-002-20250515    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-002-20250515    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                    randconfig-001-20250515    gcc-12
um                    randconfig-002-20250515    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250515    clang-20
x86_64      buildonly-randconfig-002-20250515    clang-20
x86_64      buildonly-randconfig-003-20250515    clang-20
x86_64      buildonly-randconfig-004-20250515    clang-20
x86_64      buildonly-randconfig-005-20250515    clang-20
x86_64      buildonly-randconfig-006-20250515    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-002-20250515    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

