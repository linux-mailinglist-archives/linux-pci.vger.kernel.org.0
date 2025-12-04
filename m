Return-Path: <linux-pci+bounces-42662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE7CA575D
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 22:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D794730988EC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB53308F07;
	Thu,  4 Dec 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkyugliZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA2305960
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883600; cv=none; b=DAliSftozoGLw4G8us6UnExeO73msnCYZyfP8gJHLRO8EwCxyJVXtlaimJwk+5qfm34PAONgcZhT/fYmpBKEA4rhD31mMOn2f9UB/noQEnaPU9F7Xkd6/cVDQgKCz5E+M7Jz5X5Hc6lsSD/mJs73FIiK7irBehD455lQy55c090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883600; c=relaxed/simple;
	bh=XcmLxDhmESMJfzgMGeiUdOtcunv+SZtWW6ISERjupVw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=no7CrTXClx+uY4OUTrkPWK/IWEcWMEFTfGtTHru+Fnt8hU922OGZZm1pu1Es6zBiqxonUit+G66Ht8sntPxQ8CxVwvXI5jVIPVUXmvV1XrSh6aDeLP3+3t92nebPm+uJYAJ0jBApB3uD8K21ZOSmxMvNBQ6RfnqOusNQXvXN+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkyugliZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764883599; x=1796419599;
  h=date:from:to:cc:subject:message-id;
  bh=XcmLxDhmESMJfzgMGeiUdOtcunv+SZtWW6ISERjupVw=;
  b=TkyugliZSNI9Foy9OAnz/jHTJdmsmjTiB012B2tU8CdeAL6zfQuvJXQz
   OjHIJl1/hqxMeYV99TvMZUzcwDUZDoaduiVM4gaky01+bphwlkfQZTYMx
   iR44vFTKAv+NW55nN6RixGZJzFQOpGj3LFLLUDvrbBPiyn3JaJYEU/xkq
   LF5wieKGE8EtjW2csQAn/vTwPuKPx7GZDxkp32wp8dibpX7LXwfs+Par/
   HDmCcYLvsf4mNq51EIlDZaH+xHvZXQApe204JH+j2Z+qmwBNw6RWQxa9T
   1zYFJZnmT96PrNxu5amas6EvCdaWFSielrtHv1LZO9dsRSNW+67GSNw9V
   Q==;
X-CSE-ConnectionGUID: JID5ErgzTHClfrCrcDm2Yw==
X-CSE-MsgGUID: q0T/Mjj8SzOSJ16drXNiqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="67080999"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="67080999"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 13:26:37 -0800
X-CSE-ConnectionGUID: DoDBQScRT2yAumJ34MmMzQ==
X-CSE-MsgGUID: AwpR2vehTV6ZH4qyWujpjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="195325869"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Dec 2025 13:26:35 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRGqP-00000000EFo-0Qc1;
	Thu, 04 Dec 2025 21:26:33 +0000
Date: Fri, 05 Dec 2025 05:26:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 cd6b7c82b69139070ee1aaa73f768ecac99e4c3e
Message-ID: <202512050500.6AAegA3j-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: cd6b7c82b69139070ee1aaa73f768ecac99e4c3e  Merge branch 'pci/misc'

elapsed time: 1466m

configs tested: 185
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251204    gcc-10.5.0
arc                   randconfig-002-20251204    gcc-10.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                         orion5x_defconfig    gcc-15.1.0
arm                   randconfig-001-20251204    gcc-10.5.0
arm                   randconfig-002-20251204    gcc-10.5.0
arm                   randconfig-003-20251204    gcc-10.5.0
arm                   randconfig-004-20251204    gcc-10.5.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251204    gcc-14.3.0
arm64                 randconfig-002-20251204    gcc-14.3.0
arm64                 randconfig-003-20251204    gcc-14.3.0
arm64                 randconfig-004-20251204    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251204    gcc-14.3.0
csky                  randconfig-002-20251204    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251204    gcc-15.1.0
hexagon               randconfig-002-20251204    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251204    clang-20
i386        buildonly-randconfig-002-20251204    clang-20
i386        buildonly-randconfig-003-20251204    clang-20
i386        buildonly-randconfig-004-20251204    clang-20
i386        buildonly-randconfig-005-20251204    clang-20
i386        buildonly-randconfig-006-20251204    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251204    clang-20
i386                  randconfig-002-20251204    clang-20
i386                  randconfig-003-20251204    clang-20
i386                  randconfig-004-20251204    clang-20
i386                  randconfig-005-20251204    clang-20
i386                  randconfig-006-20251204    clang-20
i386                  randconfig-007-20251204    clang-20
i386                  randconfig-011-20251204    gcc-14
i386                  randconfig-012-20251204    gcc-14
i386                  randconfig-013-20251204    gcc-14
i386                  randconfig-014-20251204    gcc-14
i386                  randconfig-015-20251204    gcc-14
i386                  randconfig-016-20251204    gcc-14
i386                  randconfig-017-20251204    gcc-14
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251204    gcc-15.1.0
loongarch             randconfig-002-20251204    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251204    gcc-15.1.0
nios2                 randconfig-002-20251204    gcc-15.1.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251204    clang-22
parisc                randconfig-002-20251204    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251204    clang-22
powerpc               randconfig-002-20251204    clang-22
powerpc                     tqm8548_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251204    clang-22
powerpc64             randconfig-002-20251204    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251204    clang-22
riscv                 randconfig-002-20251204    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251204    clang-22
s390                  randconfig-002-20251204    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251204    clang-22
sh                    randconfig-002-20251204    clang-22
sh                          rsk7201_defconfig    gcc-15.1.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251204    clang-22
sparc                 randconfig-002-20251204    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251204    clang-22
sparc64               randconfig-002-20251204    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251204    clang-22
um                    randconfig-002-20251204    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251204    clang-20
x86_64      buildonly-randconfig-002-20251204    clang-20
x86_64      buildonly-randconfig-003-20251204    clang-20
x86_64      buildonly-randconfig-004-20251204    clang-20
x86_64      buildonly-randconfig-005-20251204    clang-20
x86_64      buildonly-randconfig-006-20251204    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251204    clang-20
x86_64                randconfig-002-20251204    clang-20
x86_64                randconfig-003-20251204    clang-20
x86_64                randconfig-004-20251204    clang-20
x86_64                randconfig-005-20251204    clang-20
x86_64                randconfig-006-20251204    clang-20
x86_64                randconfig-011-20251204    clang-20
x86_64                randconfig-012-20251204    clang-20
x86_64                randconfig-013-20251204    clang-20
x86_64                randconfig-014-20251204    clang-20
x86_64                randconfig-015-20251204    clang-20
x86_64                randconfig-016-20251204    clang-20
x86_64                randconfig-071-20251204    clang-20
x86_64                randconfig-072-20251204    clang-20
x86_64                randconfig-073-20251204    clang-20
x86_64                randconfig-074-20251204    clang-20
x86_64                randconfig-075-20251204    clang-20
x86_64                randconfig-076-20251204    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251204    clang-22
xtensa                randconfig-002-20251204    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

