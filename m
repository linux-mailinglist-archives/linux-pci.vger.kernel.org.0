Return-Path: <linux-pci+bounces-41913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC1C7D3EE
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B23724E1469
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18926FA6C;
	Sat, 22 Nov 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EU+G0jcS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E018DB35
	for <linux-pci@vger.kernel.org>; Sat, 22 Nov 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763828408; cv=none; b=BKnlqi5LrMymPSp8U269l11dUZs4xAY7EU5OrtYuNf9/YB9w86Pfg1fiJpsLaIem3oq2Qc6gdwjzwBGx8NcaTvu5m2GZWkNNyyp2WF3r+rAEBodfjUbk0WCRLVpyCd5RiBU3UeSwegfw8WmTIVE2Nkf+2+r7YWjqIiK1xoPxivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763828408; c=relaxed/simple;
	bh=Mli5bhj0y4HGafEYSCMhrFlkqiL3f+4sqIQ07ycyNrc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IzJiPG6UYKkfgLLJaYqiSex1Pw39j0EfKS40H4C/UM/47qwM6MpucSI2SVqasoWV9vf/xQPniLFOivb/EPxQdY39LawVKUyHkJLkFiMtj5pwXaSoDziEhjkS2QdWzDShBljDr50gZCPPSep+5S03BlfbFe2LYTtYi0MYrT0HhWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EU+G0jcS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763828405; x=1795364405;
  h=date:from:to:cc:subject:message-id;
  bh=Mli5bhj0y4HGafEYSCMhrFlkqiL3f+4sqIQ07ycyNrc=;
  b=EU+G0jcS68GCUbstNkkJOhz2GE9br6uVKiYpY4rLDQeC8+S1MydYo3qE
   FFGjZW+qDqpR5zqe1T36NP08GIRMC9QYLAHhHg0qyRaizmlrwkizbtuiF
   ogVDfRU+QWM+s79sG5KIGg0vJD2/OOcIHvbxeurFrdf3VBex6ny7Gpw9p
   rrjEY1KRnLDEwSwW5kqvNwrZnjoBRm4vvs7uxfLhLLQ+B8oa2qpMEA6J4
   ZUmoI4E4gIGcPhHjFQROztTNefyP1wcWgIjIAuUoatifcLJqH0Ze1zqrH
   CY4GdQcHOqKx4m0JjcvakRzFeKDvK+FH8ATEtmJP7sKAc7K45TxGNI9eb
   Q==;
X-CSE-ConnectionGUID: eoOFYX7pR+ue+n3c0LaK/Q==
X-CSE-MsgGUID: 5TpE3g4lQ56UqpXFUqZLpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="69760482"
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="69760482"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 08:20:01 -0800
X-CSE-ConnectionGUID: Z8qsoAfhQrmObGqx9wJ+vA==
X-CSE-MsgGUID: /YZ8ohgmSeqgaA5wCyFaAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="196418383"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Nov 2025 08:20:00 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMqL7-0007fp-2y;
	Sat, 22 Nov 2025 16:19:57 +0000
Date: Sun, 23 Nov 2025 00:19:19 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/spacemit-k1] BUILD SUCCESS
 ff64e078e45faee50cc6ca7900a3520e8ff1c79e
Message-ID: <202511230014.j8cWTjvF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/spacemit-k1
branch HEAD: ff64e078e45faee50cc6ca7900a3520e8ff1c79e  PCI: spacemit: Add SpacemiT PCIe host driver

elapsed time: 7229m

configs tested: 64
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251118    gcc-14.3.0
arc         randconfig-002-20251118    gcc-15.1.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251118    gcc-8.5.0
arm         randconfig-002-20251118    gcc-10.5.0
arm         randconfig-003-20251118    clang-22
arm         randconfig-004-20251118    clang-22
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251118    clang-20
arm64       randconfig-002-20251118    clang-22
arm64       randconfig-003-20251118    clang-19
arm64       randconfig-004-20251118    clang-17
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251118    gcc-10.5.0
csky        randconfig-002-20251118    gcc-15.1.0
hexagon                 allnoconfig    clang-22
i386                    allnoconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc64   randconfig-002-20251118    gcc-8.5.0
riscv                  allmodconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh                        defconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc64                   defconfig    clang-20
um                      allnoconfig    clang-22
um                        defconfig    clang-22
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

