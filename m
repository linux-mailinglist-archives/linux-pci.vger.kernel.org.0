Return-Path: <linux-pci+bounces-44393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C4D0BB04
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 18:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C5EA300876D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756B311C01;
	Fri,  9 Jan 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5fAHA6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD445366DAB
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980075; cv=none; b=PUM1153SV+ekTLnmw0JMyOOcOKhdficU1kudCHrU6jMdVsk5yTGq7OwIgroTuWaSUTRlV4chOPF+ZXAbrVOwG/+TaMfLIS4dDjCGeqAn4SnlEQqgdoqr08cbNaArUtVd8MJUjOwXUbI5Q1UdHpDcN7GnxXn2SUjqbCeYmbnA/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980075; c=relaxed/simple;
	bh=dA09wAKtdV4LnjSLDZTVlvpklLpSig8mLeC6L/E5sZY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h1W+rSjV5au6JBY+OR4iAqmpJIaeBp1XGU61eDSfqP56tiOK2F6z9RNPO4j4QUpn0e7te1vslKL7cJY10jiJ2kv4qTYWS3qg3YhvLEZjAU+/c0L/iZc6MqwCB5K3MdL8M2qjZU/EP3Hy3prGcyZ+HN5S8hOUYyeuPiWkwIcvxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5fAHA6W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767980074; x=1799516074;
  h=date:from:to:cc:subject:message-id;
  bh=dA09wAKtdV4LnjSLDZTVlvpklLpSig8mLeC6L/E5sZY=;
  b=P5fAHA6Wq4wH2BBhUazJeWB28ly7atlbRikYjELi0uxXJJ0y80a9lGWr
   L8TFDM0GjXsIMh0XrZdLRG2/QBYZpVADxHO+SDZJNwNvxsgtiQLCf9Z8C
   FiP5rT4sPEGF+/bGzNFJXMToUuHekKxPnL1y321H2YJXW8rZzuEbJafeK
   2JGxEqVDLL6LWXx/DF0Sa3newygY7Kk+NX3Jq33EJu65H57/w92Ao1NRW
   elRv0HfwEM3W2D7umeSuXoQKKG7pL67DkWYQeFVBQhdILCb8LQkd86cSH
   c+rVUh4CS4pXoqpj9SVo4RWfLWzelm/KispQE1Jghtn7pYT2Kn5UlczTu
   Q==;
X-CSE-ConnectionGUID: TtW1/WO8RMCguh4t9uMMfg==
X-CSE-MsgGUID: gxYvaut7T2e3sThw0/Jr/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="92026463"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="92026463"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:34:33 -0800
X-CSE-ConnectionGUID: jbbhsr4pTYOQgBGAucd5fw==
X-CSE-MsgGUID: 6i8ACSRzRyGZCo4TAkmQyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="207673413"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Jan 2026 09:34:31 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veGNY-000000007YM-3PxR;
	Fri, 09 Jan 2026 17:34:28 +0000
Date: Sat, 10 Jan 2026 01:33:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:trace] BUILD SUCCESS
 8236fc613d44e59f6736d6c3e9efffaf26ab7f00
Message-ID: <202601100150.Nttqyt83-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git trace
branch HEAD: 8236fc613d44e59f6736d6c3e9efffaf26ab7f00  Documentation: tracing: Add PCI tracepoint documentation

elapsed time: 1501m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260109    gcc-13.4.0
arc                   randconfig-002-20260109    gcc-9.5.0
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20260109    gcc-10.5.0
arm                   randconfig-002-20260109    gcc-15.2.0
arm                   randconfig-003-20260109    gcc-8.5.0
arm                   randconfig-004-20260109    gcc-11.5.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260109    clang-22
arm64                 randconfig-002-20260109    clang-22
arm64                 randconfig-003-20260109    gcc-11.5.0
arm64                 randconfig-004-20260109    gcc-8.5.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260109    gcc-9.5.0
csky                  randconfig-002-20260109    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260109    clang-22
hexagon               randconfig-002-20260109    clang-17
i386        buildonly-randconfig-001-20260109    clang-20
i386        buildonly-randconfig-002-20260109    gcc-14
i386        buildonly-randconfig-003-20260109    gcc-14
i386        buildonly-randconfig-004-20260109    clang-20
i386        buildonly-randconfig-005-20260109    gcc-12
i386        buildonly-randconfig-006-20260109    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260109    gcc-14
i386                  randconfig-002-20260109    gcc-14
i386                  randconfig-003-20260109    gcc-12
i386                  randconfig-004-20260109    gcc-14
i386                  randconfig-005-20260109    gcc-14
i386                  randconfig-006-20260109    clang-20
i386                  randconfig-007-20260109    gcc-14
i386                  randconfig-011-20260109    clang-20
i386                  randconfig-012-20260109    gcc-14
i386                  randconfig-013-20260109    clang-20
i386                  randconfig-014-20260109    gcc-14
i386                  randconfig-015-20260109    clang-20
i386                  randconfig-016-20260109    clang-20
i386                  randconfig-017-20260109    clang-20
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260109    clang-22
loongarch             randconfig-002-20260109    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                         cobalt_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260109    gcc-8.5.0
nios2                 randconfig-002-20260109    gcc-8.5.0
openrisc                            defconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260109    gcc-12.5.0
parisc                randconfig-002-20260109    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260109    clang-22
powerpc               randconfig-002-20260109    clang-22
powerpc64             randconfig-001-20260109    gcc-15.2.0
powerpc64             randconfig-002-20260109    gcc-8.5.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260109    gcc-14.3.0
riscv                 randconfig-002-20260109    gcc-8.5.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260109    clang-22
s390                  randconfig-002-20260109    clang-22
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260109    gcc-14.3.0
sh                    randconfig-002-20260109    gcc-13.4.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260109    gcc-8.5.0
sparc                 randconfig-002-20260109    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260109    gcc-8.5.0
sparc64               randconfig-002-20260109    clang-20
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260109    gcc-14
um                    randconfig-002-20260109    gcc-14
um                           x86_64_defconfig    clang-22
x86_64      buildonly-randconfig-001-20260109    clang-20
x86_64      buildonly-randconfig-002-20260109    gcc-14
x86_64      buildonly-randconfig-003-20260109    gcc-14
x86_64      buildonly-randconfig-004-20260109    gcc-14
x86_64      buildonly-randconfig-005-20260109    gcc-14
x86_64      buildonly-randconfig-006-20260109    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260109    clang-20
x86_64                randconfig-002-20260109    clang-20
x86_64                randconfig-003-20260109    gcc-14
x86_64                randconfig-004-20260109    clang-20
x86_64                randconfig-005-20260109    clang-20
x86_64                randconfig-006-20260109    gcc-14
x86_64                randconfig-011-20260109    gcc-12
x86_64                randconfig-012-20260109    clang-20
x86_64                randconfig-013-20260109    gcc-14
x86_64                randconfig-014-20260109    gcc-14
x86_64                randconfig-015-20260109    gcc-12
x86_64                randconfig-016-20260109    gcc-14
x86_64                randconfig-071-20260109    gcc-14
x86_64                randconfig-072-20260109    clang-20
x86_64                randconfig-073-20260109    gcc-14
x86_64                randconfig-074-20260109    gcc-14
x86_64                randconfig-075-20260109    gcc-14
x86_64                randconfig-076-20260109    gcc-12
xtensa                randconfig-001-20260109    gcc-12.5.0
xtensa                randconfig-002-20260109    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

