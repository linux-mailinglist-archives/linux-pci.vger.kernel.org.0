Return-Path: <linux-pci+bounces-40646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F236C435C7
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 23:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12CF3AF10E
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B9F2AEF5;
	Sat,  8 Nov 2025 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdVPJjzK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6F18E1F
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642740; cv=none; b=uoIw5/80nG+i8FBKfXougWLAehn15bOLVFOEjwADlII1gYVhu7cTQQJ0x5X0YzA0EP1AAAiDrAcr1CgxwyyBHQ7r0PxHzz1mPGXlvuMrwMECJE9kId2UHGdGjlapbiaepIrKr1Vk90WbC8msF8ko0cmDvW+O+nPYQ49YgVVP6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642740; c=relaxed/simple;
	bh=Wg2i7EaxkKdUzxrmllswZZb6v/kPcldu5WZSKMni+74=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HWH/gQm4ZD7+CR6q6y47tM7QYE824rRiepKtKRxWgTYdon6+DqbEZanNz86f8iAM58yCFhBbf1qzclI1pHXO1aBAaAynbFTx5AB1dNoZ/266oxnJYlHFzKobL4SLFh1LrOuvSAfITrpP2LZB7xLaMe0L5FCvxloHqf9drvrWalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdVPJjzK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762642738; x=1794178738;
  h=date:from:to:cc:subject:message-id;
  bh=Wg2i7EaxkKdUzxrmllswZZb6v/kPcldu5WZSKMni+74=;
  b=OdVPJjzKKkncs9A/ap0IKvYDx1MryWHHgQuGXT/F+LnqMo6OVKX7PyOj
   G9+JWNJ2rJeHeFgMkwOJtPm1KrbkVzFafEcL4awo4U8uzgM0Fv+3wOVOw
   o0WXuuh+bBUwYKrHEGMKWl0mrLm/KC25dLGHRc/UTqNbDjBgdFyxiwwye
   6qdQSd2wQijkBFADN0QHuVh//0MOaW5QuCisJiizc6qKDLzoDC4iwazbS
   JGxF55Jte8rnOsKX+ooVm9TmhvZFHaiPhiuN1pZdQj426iOOosnsfaYi4
   Pz9ggUO6ztwlFJK/7R8V+etbZyC93bxb8ha7t2V9fokRGgaJ9LRqvA7EC
   g==;
X-CSE-ConnectionGUID: NonMlCZQStqCJsy6H+2W5w==
X-CSE-MsgGUID: l3OXi4vURFSHLzYdlcrT+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="76197853"
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="76197853"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 14:58:58 -0800
X-CSE-ConnectionGUID: vxkEXQBhRY+8+mA8AONtpg==
X-CSE-MsgGUID: KM6yI62cQLCdOgUkHphD9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="188517391"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Nov 2025 14:58:57 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHrtW-0001WF-1K;
	Sat, 08 Nov 2025 22:58:54 +0000
Date: Sun, 09 Nov 2025 06:58:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD REGRESSION
 2b8258e8694f49b247b611933149c59c79013393
Message-ID: <202511090618.Y6KWUnlX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 2b8258e8694f49b247b611933149c59c79013393  PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports

Error/Warning ids grouped by kconfigs:

recent_errors
`-- mips-allyesconfig
    |-- (.head.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
    `-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary

elapsed time: 2835m

configs tested: 74
configs skipped: 1

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    clang-19
arc                    allmodconfig    clang-19
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    clang-19
arm                    allmodconfig    clang-19
arm                     allnoconfig    clang-22
arm                    allyesconfig    clang-19
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-19
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-19
hexagon     randconfig-001-20251107    clang-22
hexagon     randconfig-002-20251107    clang-22
i386                   allmodconfig    clang-20
i386                    allnoconfig    gcc-14
i386                   allyesconfig    clang-20
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
loongarch   randconfig-001-20251107    gcc-15.1.0
loongarch   randconfig-002-20251107    clang-19
m68k                   allmodconfig    clang-19
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    clang-19
microblaze             allmodconfig    clang-19
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    clang-19
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251107    gcc-11.5.0
nios2       randconfig-002-20251107    gcc-8.5.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    gcc-15.1.0
riscv                  allmodconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    gcc-15.1.0
riscv       randconfig-001-20251107    clang-22
riscv       randconfig-002-20251107    gcc-13.4.0
s390                    allnoconfig    clang-22
s390        randconfig-001-20251107    gcc-8.5.0
s390        randconfig-002-20251107    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh          randconfig-001-20251107    gcc-13.4.0
sh          randconfig-002-20251107    gcc-11.5.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    clang-19
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

