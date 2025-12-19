Return-Path: <linux-pci+bounces-43367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A65CCF938
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75061300A8E7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8B304976;
	Fri, 19 Dec 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6q7BXp3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50541D27B6
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143876; cv=none; b=FOni1a5wofvAiRwbHMhevMaLYGRuRiWWX/DxLJclaEjuRl2IDOKTCGavm3eEGBNNRC6z25WuOU8AIpChauSeD/vaF2fwBC+WpOC24UzwJAlkYv77iWz9WheVf/4BXrCi8SfOBCxBUXK2KoZzRpC3hRyCJ5MdvH/EV9K/1P5PA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143876; c=relaxed/simple;
	bh=yIe0rWdbC8BrCiXq769ZcNmv3G8eFjtJvOIZGYiiuOE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SAocUDbuzclvozYZEyqavILSpxZDOcRD4tg3QZKsebHeUS/C98Z0OOJ4Zzez4i5PT9YK86h2o6j5LJ7mzfFV/QQdZ4UD8EKJB3A/e543cntalPfHJjQEM9gZWiDYjMJp6L/CF0s0dF/2/7dJqYT41XroB8rE1yszp2k70akDqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6q7BXp3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766143874; x=1797679874;
  h=date:from:to:cc:subject:message-id;
  bh=yIe0rWdbC8BrCiXq769ZcNmv3G8eFjtJvOIZGYiiuOE=;
  b=i6q7BXp3YkfUCxdcpsQSZ/r52hjbvXqTHHbyPXAW4n8yEXbqD9VnWx5p
   GBW7qcOx666TqYbs1NZs5DMvPvtZd7d5SIKRtfqRygvOdgcZIOUWymBF6
   q+sac34eheLEnNivY6CvVNg+UaErDPc1GgMw8+dJh+pHL0OzV0O8dMeO3
   Zvc+HjvfBxTH2nzDxYnqFT8QOK8NzqYfDi/RPfEZudkklk7ukmQpeRSA6
   QSe3qZs1sYabj/hqwW4fBa2MFADg6xW9CXglUlc1fPdDd3zF7evG4xDEo
   2qoqiKLx7cp8/tc/xtE50eXafwheIx2krBpG+uoiJVhOeOIP1rwJPRqJo
   A==;
X-CSE-ConnectionGUID: ZMpj4do1TJKB/4BkbxwqEg==
X-CSE-MsgGUID: KFZI80LEQ7yfWfla3ERx6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67983055"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="67983055"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 03:31:13 -0800
X-CSE-ConnectionGUID: dhgwaGygREmIUYu78vXsbQ==
X-CSE-MsgGUID: tweWpp2FRDSmZIdZ0/azOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198851026"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Dec 2025 03:31:12 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWYhR-000000003Q2-31SA;
	Fri, 19 Dec 2025 11:31:09 +0000
Date: Fri, 19 Dec 2025 19:30:23 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 0a19a6d9ed65ef7df845c32befa994e45620c12d
Message-ID: <202512191909.cRDXCA5r-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 0a19a6d9ed65ef7df845c32befa994e45620c12d  PCI: endpoint: Add missing NULL check for alloc_workqueue()

elapsed time: 1689m

configs tested: 115
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
i386                   allmodconfig    clang-20
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-15.1.0
i386                   allyesconfig    clang-20
i386                   allyesconfig    gcc-14
i386                      defconfig    gcc-15.1.0
loongarch               allnoconfig    gcc-15.1.0
loongarch                 defconfig    clang-19
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

