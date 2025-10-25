Return-Path: <linux-pci+bounces-39329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF06DC09DC7
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 19:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EECBE4E6A1F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4C2D0298;
	Sat, 25 Oct 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqJLU5lc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040221767C
	for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412261; cv=none; b=hqJ+O5jchYR6lazn2BTAbL7IphMRw1qc3DaVnMNak+BAzVG5dkep8As3u4RXcjMiApU8cX6efoMnV2WXuVBNu45cF8GzlF8No94H8z82l9pUy9vtpyV1UU+g6+P+b8gJXm5Sse+SCnk/SCY0Awu03LoGmaXIWcfQjmfaphnVONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412261; c=relaxed/simple;
	bh=hZ4ZE6ZBuqJYfKVyqmetJFaigA1K9Txrsvzkvt10RqM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UmtW1am0IyFbZ5EE9zXqtU/l10nkxQHkpc4VimE3QsSP918fVmArWmD8sNfznGOYc/nuZEIDMAqDAZaqMsKNajiNswtqPBu0jkftMD2sIf7iq2+qGQ0F937CXTJEQroQQs+O7aHXi8QBQMmIujN8H0q0ogtZeremKrYf6TOZJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqJLU5lc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761412260; x=1792948260;
  h=date:from:to:cc:subject:message-id;
  bh=hZ4ZE6ZBuqJYfKVyqmetJFaigA1K9Txrsvzkvt10RqM=;
  b=BqJLU5lc8gEGmIrkc2sL1OW9zLLNRCa7FQ3S0R9T5l0kGVHLksVoQ86b
   1vP1AMcp+7PKvSntdEWVcUtikf3hG/QakmnULkri3mKY+eIzFMUR+GIxF
   Spq8/J5A4rFIGq5ajtJAnLhwtTWHklwYmgR7xxqllZOvkYhoNFE30HC3P
   EzrZyx1QrlwBpPO0T5QICkV7xqxFfNDN2VdUhv5EGAswRNJ7PvTE6WYDH
   ozKoowfma7AKkr+ZrnR5S8P0Y9km+q0E/nYMo8n9dL5bBduQecQPm8prD
   Wt8TLJ7YAqVupUYWGWq1rtnzUUSTRWJEGZOmVPDgwAUVqDVtLWQN7oMl5
   A==;
X-CSE-ConnectionGUID: RHJiRHtTS4ORB8VFkSSAcg==
X-CSE-MsgGUID: 6xLV85EUTdWzu7yWcG0C5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51134395"
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="51134395"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 10:10:59 -0700
X-CSE-ConnectionGUID: 1o9fIBRRRMy22HdYrJ8lHg==
X-CSE-MsgGUID: UqIxSU9mS/+KI6+bO2Q9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="189910260"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 25 Oct 2025 10:10:58 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vChn6-000FSN-0j;
	Sat, 25 Oct 2025 17:10:56 +0000
Date: Sun, 26 Oct 2025 01:09:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD REGRESSION
 df5192d9bb0e38bf831fb93e8026e346aa017ca8
Message-ID: <202510260122.iGsB6O8e-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: df5192d9bb0e38bf831fb93e8026e346aa017ca8  PCI/ASPM: Enable only L0s and L1 for devicetree platforms

Error/Warning ids grouped by kconfigs:

recent_errors
`-- mips-allyesconfig
    |-- (.head.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
    `-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary

elapsed time: 1370m

configs tested: 214
configs skipped: 4

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251025    clang-22
arc                   randconfig-001-20251025    gcc-10.5.0
arc                   randconfig-002-20251025    clang-22
arc                   randconfig-002-20251025    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            hisi_defconfig    clang-22
arm                   randconfig-001-20251025    clang-22
arm                   randconfig-002-20251025    clang-22
arm                   randconfig-002-20251025    gcc-10.5.0
arm                   randconfig-003-20251025    clang-22
arm                   randconfig-004-20251025    clang-22
arm                           sama7_defconfig    clang-22
arm                        spear6xx_defconfig    clang-22
arm                           u8500_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251025    clang-22
arm64                 randconfig-001-20251025    gcc-14.3.0
arm64                 randconfig-002-20251025    clang-22
arm64                 randconfig-002-20251025    gcc-11.5.0
arm64                 randconfig-003-20251025    clang-22
arm64                 randconfig-003-20251025    gcc-9.5.0
arm64                 randconfig-004-20251025    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251025    gcc-10.5.0
csky                  randconfig-001-20251025    gcc-11.5.0
csky                  randconfig-002-20251025    gcc-10.5.0
csky                  randconfig-002-20251025    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251025    clang-18
hexagon               randconfig-001-20251025    gcc-10.5.0
hexagon               randconfig-002-20251025    clang-20
hexagon               randconfig-002-20251025    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251025    gcc-14
i386        buildonly-randconfig-002-20251025    gcc-14
i386        buildonly-randconfig-003-20251025    clang-20
i386        buildonly-randconfig-004-20251025    clang-20
i386        buildonly-randconfig-005-20251025    clang-20
i386        buildonly-randconfig-006-20251025    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251025    clang-20
i386                  randconfig-002-20251025    clang-20
i386                  randconfig-003-20251025    clang-20
i386                  randconfig-004-20251025    clang-20
i386                  randconfig-005-20251025    clang-20
i386                  randconfig-006-20251025    clang-20
i386                  randconfig-007-20251025    clang-20
i386                  randconfig-011-20251025    gcc-14
i386                  randconfig-012-20251025    gcc-14
i386                  randconfig-013-20251025    gcc-14
i386                  randconfig-014-20251025    gcc-14
i386                  randconfig-015-20251025    gcc-14
i386                  randconfig-016-20251025    gcc-14
i386                  randconfig-017-20251025    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251025    clang-22
loongarch             randconfig-001-20251025    gcc-10.5.0
loongarch             randconfig-002-20251025    clang-18
loongarch             randconfig-002-20251025    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251025    gcc-10.5.0
nios2                 randconfig-001-20251025    gcc-11.5.0
nios2                 randconfig-002-20251025    gcc-10.5.0
nios2                 randconfig-002-20251025    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251025    gcc-10.5.0
parisc                randconfig-001-20251025    gcc-14.3.0
parisc                randconfig-002-20251025    gcc-10.5.0
parisc                randconfig-002-20251025    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc               randconfig-001-20251025    gcc-10.5.0
powerpc               randconfig-001-20251025    gcc-11.5.0
powerpc               randconfig-002-20251025    clang-16
powerpc               randconfig-002-20251025    gcc-10.5.0
powerpc               randconfig-003-20251025    clang-22
powerpc               randconfig-003-20251025    gcc-10.5.0
powerpc64             randconfig-001-20251025    clang-17
powerpc64             randconfig-001-20251025    gcc-10.5.0
powerpc64             randconfig-002-20251025    clang-16
powerpc64             randconfig-002-20251025    gcc-10.5.0
powerpc64             randconfig-003-20251025    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251025    clang-22
riscv                 randconfig-002-20251025    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251025    gcc-11.5.0
s390                  randconfig-002-20251025    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251025    gcc-11.5.0
sh                    randconfig-002-20251025    gcc-15.1.0
sh                   sh7724_generic_defconfig    clang-22
sh                            titan_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251025    gcc-11.5.0
sparc                 randconfig-002-20251025    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251025    clang-22
sparc64               randconfig-002-20251025    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251025    clang-22
um                    randconfig-002-20251025    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251025    clang-20
x86_64      buildonly-randconfig-001-20251025    gcc-14
x86_64      buildonly-randconfig-002-20251025    clang-20
x86_64      buildonly-randconfig-002-20251025    gcc-14
x86_64      buildonly-randconfig-003-20251025    clang-20
x86_64      buildonly-randconfig-003-20251025    gcc-14
x86_64      buildonly-randconfig-004-20251025    clang-20
x86_64      buildonly-randconfig-005-20251025    clang-20
x86_64      buildonly-randconfig-006-20251025    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251025    clang-20
x86_64                randconfig-002-20251025    clang-20
x86_64                randconfig-003-20251025    clang-20
x86_64                randconfig-004-20251025    clang-20
x86_64                randconfig-005-20251025    clang-20
x86_64                randconfig-006-20251025    clang-20
x86_64                randconfig-007-20251025    clang-20
x86_64                randconfig-008-20251025    clang-20
x86_64                randconfig-071-20251025    clang-20
x86_64                randconfig-072-20251025    clang-20
x86_64                randconfig-073-20251025    clang-20
x86_64                randconfig-074-20251025    clang-20
x86_64                randconfig-075-20251025    clang-20
x86_64                randconfig-076-20251025    clang-20
x86_64                randconfig-077-20251025    clang-20
x86_64                randconfig-078-20251025    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251025    gcc-15.1.0
xtensa                randconfig-002-20251025    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

