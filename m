Return-Path: <linux-pci+bounces-43369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7123CCF9D4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82C130321E6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A448284B25;
	Fri, 19 Dec 2025 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZDQcR0O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E53176E4
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144296; cv=none; b=F2tVS8CKiSxRtJrFM71bbvnbaxsqRy5OEyo5nsPDMuPpyFHhmgmqmONg/65+NG9Vu35WcMAxgdYighLL/nvX9r4YvEiGCSXovHrGgh3ZGE4TKekaPOm3NQ1P/XpbV3IrZvxYL4hKn93fgabferggL6dxsC0rZBZmgjZxMKKGTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144296; c=relaxed/simple;
	bh=ML7M/UfvhB5PWfSxcUg71PSXr7q2PM65uvwWsRKCGZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DfvdLok/TXY6T7vCJep6OyjZyCURgveaSf3aJTC94aKH4iv5/zBR+fFTnNx6MXq2jn0jsNaP9FSXdI+W6ewn8IeSxH2koBmWiQIBxJrhglYD+UYdgEuccne4/+eqFIxwpY23chLRkvozy9gmTrz6BQcAV5f/PqJI5F546QvJ5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZDQcR0O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766144295; x=1797680295;
  h=date:from:to:cc:subject:message-id;
  bh=ML7M/UfvhB5PWfSxcUg71PSXr7q2PM65uvwWsRKCGZI=;
  b=nZDQcR0Os6kGzqEFcLD6WFsxKqkKxoZzgdKBxRVqXki5AVRgC7sDR+SW
   xHtpkGP+WD8MRH2o1b4LQvWQ9/vQ5Q79akaQTxa/NAP5HgkzleUAX38M7
   vHZjHtRnhryma1mHPIKKR7qEMuTpzZGoHbrBf/CpgVQXCF0+pOx9aR4Uv
   AnCB8W+81A7R5RvKLu9gry1uBSjmNhqIg25dIb4q6FEFTfAzzlM7+z4r5
   DUFV/XWQSv9xOqR3iW8FgBXr1gkcnSE+4yelVsEwdd5aJahh/7wwPOlNZ
   kYKfZfC/mL1xohlGVnnJ3N0EE73MbwagLjG48kKadsd37r4BBrA4IntH9
   A==;
X-CSE-ConnectionGUID: S585Z1GyTu2qpHaA0AQ47w==
X-CSE-MsgGUID: wFWUF40FSRSPciwNuH7uIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="90762736"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="90762736"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 03:38:14 -0800
X-CSE-ConnectionGUID: ie/9nqQ0SlOoY+ncpv2f+Q==
X-CSE-MsgGUID: a1aLdr0LQ0qC0ZpF/kqNjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="199098095"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Dec 2025 03:38:12 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWYoE-000000003RW-3MAO;
	Fri, 19 Dec 2025 11:38:10 +0000
Date: Fri, 19 Dec 2025 19:37:36 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 7f0cdcddf8bef1c8c18f9be6708073fd3790a20f
Message-ID: <202512191923.Ttsg7D7U-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 7f0cdcddf8bef1c8c18f9be6708073fd3790a20f  PCI: mediatek: Fix IRQ domain leak when MSI allocation fails

elapsed time: 1636m

configs tested: 121
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
alpha                     defconfig    gcc-15.1.0
arc                    allmodconfig    clang-16
arc                     allnoconfig    gcc-15.1.0
arc                       defconfig    gcc-15.1.0
arc         randconfig-001-20251219    gcc-11.5.0
arc         randconfig-002-20251219    gcc-11.5.0
arm                     allnoconfig    gcc-15.1.0
arm                    allyesconfig    clang-16
arm                       defconfig    gcc-15.1.0
arm         randconfig-001-20251219    gcc-11.5.0
arm         randconfig-002-20251219    gcc-11.5.0
arm         randconfig-003-20251219    gcc-11.5.0
arm         randconfig-004-20251219    gcc-11.5.0
arm64                   allnoconfig    gcc-15.1.0
arm64                     defconfig    gcc-15.1.0
arm64       randconfig-001-20251219    gcc-9.5.0
arm64       randconfig-002-20251219    gcc-9.5.0
arm64       randconfig-003-20251219    gcc-9.5.0
arm64       randconfig-004-20251219    gcc-9.5.0
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                      defconfig    gcc-15.1.0
csky        randconfig-001-20251219    gcc-9.5.0
csky        randconfig-002-20251219    gcc-9.5.0
hexagon                allmodconfig    gcc-15.1.0
hexagon                 allnoconfig    gcc-15.1.0
hexagon                   defconfig    gcc-15.1.0
hexagon     randconfig-001-20251219    gcc-11.5.0
hexagon     randconfig-002-20251219    gcc-11.5.0
i386                   allmodconfig    clang-20
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-15.1.0
i386                   allyesconfig    clang-20
i386                   allyesconfig    gcc-14
i386                      defconfig    gcc-15.1.0
loongarch               allnoconfig    gcc-15.1.0
loongarch                 defconfig    clang-19
loongarch   randconfig-001-20251219    gcc-11.5.0
loongarch   randconfig-002-20251219    gcc-11.5.0
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    clang-16
m68k                      defconfig    clang-19
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
microblaze                defconfig    clang-19
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                  allmodconfig    clang-22
nios2                   allnoconfig    clang-22
nios2                     defconfig    clang-19
nios2       randconfig-001-20251219    gcc-11.5.0
nios2       randconfig-002-20251219    gcc-11.5.0
openrisc               allmodconfig    clang-22
openrisc                allnoconfig    clang-22
openrisc                  defconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    clang-22
parisc                 allyesconfig    clang-19
parisc                    defconfig    gcc-15.1.0
parisc      randconfig-001-20251219    clang-22
parisc      randconfig-002-20251219    clang-22
parisc64                  defconfig    clang-19
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    clang-22
powerpc     randconfig-001-20251219    clang-22
powerpc     randconfig-002-20251219    clang-22
powerpc64   randconfig-001-20251219    clang-22
powerpc64   randconfig-002-20251219    clang-22
riscv                   allnoconfig    clang-22
riscv                  allyesconfig    clang-16
riscv                     defconfig    gcc-15.1.0
riscv       randconfig-001-20251219    clang-22
riscv       randconfig-002-20251219    clang-22
s390                   allmodconfig    clang-19
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390                      defconfig    gcc-15.1.0
s390        randconfig-001-20251219    clang-22
s390        randconfig-002-20251219    clang-22
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    clang-22
sh                     allyesconfig    clang-19
sh                        defconfig    gcc-14
sh          randconfig-001-20251219    clang-22
sh          randconfig-002-20251219    clang-22
sparc                   allnoconfig    clang-22
sparc                     defconfig    gcc-15.1.0
sparc       randconfig-001-20251219    gcc-8.5.0
sparc       randconfig-002-20251219    gcc-8.5.0
sparc64                allmodconfig    clang-22
sparc64                   defconfig    gcc-14
sparc64     randconfig-001-20251219    gcc-8.5.0
sparc64     randconfig-002-20251219    gcc-8.5.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-15.1.0
um                        defconfig    gcc-14
um                   i386_defconfig    gcc-14
um          randconfig-001-20251219    gcc-8.5.0
um          randconfig-002-20251219    gcc-8.5.0
um                 x86_64_defconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-22
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    clang-22
xtensa                 allyesconfig    clang-22
xtensa      randconfig-001-20251219    gcc-8.5.0
xtensa      randconfig-002-20251219    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

