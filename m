Return-Path: <linux-pci+bounces-23193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E3A57E26
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2253AB644
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796049620;
	Sat,  8 Mar 2025 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1ctQgYZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD871F94A
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465603; cv=none; b=bgD5CbCQLcfsHe+pqoNceZFjZQwJUG3tFQnzIhbqxoUAO6ZftoEYfimtSt+QvyZ7sHCpyjjY2k89oKZGhmhsTZbkonxjT2dtECVVLEGVJwA9diGH85naKpAkvQ/5yYqC8AbVgNUk0AqM3lrKAq+BYYP97wlKSMVPCBW8pgglQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465603; c=relaxed/simple;
	bh=Xsqf1Gv50jsEr45SB/Qbc5qupgiZhrtRjzdKI2nr2IA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fXrLeKeob7qqPmTblVPEdSoaGSyXVET85dQzBCALnK5dDicjoLtJejIqvSD3mAjk/uMzEuLnGcd1FzSJqyCIQjYV5BGZuV+EKFEjs92oxCmy0USFdDVoW1BonBhUfvHLm3V1yoOmXiLi0I0IHkUe2y8FQl06OncvEMoqZX+r7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1ctQgYZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741465601; x=1773001601;
  h=date:from:to:cc:subject:message-id;
  bh=Xsqf1Gv50jsEr45SB/Qbc5qupgiZhrtRjzdKI2nr2IA=;
  b=e1ctQgYZZ7tuh+5EuYtJ0AccpwEUzY+s+fsR8PvnLhBdtloR2vpjA27W
   eIVbe58/apGhL0OpkuRf4I0D9Odi7sUHgc+gqf81qCBjyiOQ4t7WMw8pr
   XNJtUrBhX1V0OK+Z5z0GEJd3iEFMLIYDv4hG0J7duYF4eEvlBWKWgS+yZ
   Oy21c2EeFtCpdEZayX11zT7pyAxwou0zWwymoBzprFtZmcvLNNqC9TgV1
   9w+6J0pLeuf31us+Omgo/J/9BZrcXzHecEDGjcu97nM5Ad/zEBpQLQ6qx
   eK30UBXFgNwaZTpeFRD1wcEoaB88TmYmQiKrGR2hSaV5ue+W2eBPKVLO7
   A==;
X-CSE-ConnectionGUID: /4a0S72kRLm6VgSu0Y6qDQ==
X-CSE-MsgGUID: Zoq9w80iTf6+RM1gKK1BeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42692533"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42692533"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 12:26:41 -0800
X-CSE-ConnectionGUID: etR0uc5kT5mECzvpD2BH+A==
X-CSE-MsgGUID: XMgaJxbBRuuXOo76meKKYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120157771"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 08 Mar 2025 12:26:39 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tr0kn-0002Hc-11;
	Sat, 08 Mar 2025 20:26:37 +0000
Date: Sun, 09 Mar 2025 04:25:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 c4ed809acf34b385bee6cf9957c5568cd01feb5c
Message-ID: <202503090441.buyok28W-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: c4ed809acf34b385bee6cf9957c5568cd01feb5c  PCI: Remove stray put_device() in pci_register_host_bridge()

elapsed time: 1444m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250308    gcc-13.2.0
arc                   randconfig-002-20250308    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250308    gcc-14.2.0
arm                   randconfig-002-20250308    gcc-14.2.0
arm                   randconfig-003-20250308    gcc-14.2.0
arm                   randconfig-004-20250308    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250308    gcc-14.2.0
arm64                 randconfig-002-20250308    gcc-14.2.0
arm64                 randconfig-003-20250308    clang-16
arm64                 randconfig-004-20250308    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250308    gcc-14.2.0
csky                  randconfig-002-20250308    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon               randconfig-001-20250308    clang-19
hexagon               randconfig-002-20250308    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250308    gcc-12
i386        buildonly-randconfig-002-20250308    gcc-11
i386        buildonly-randconfig-003-20250308    clang-19
i386        buildonly-randconfig-004-20250308    clang-19
i386        buildonly-randconfig-005-20250308    clang-19
i386        buildonly-randconfig-006-20250308    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250308    gcc-14.2.0
loongarch             randconfig-002-20250308    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250308    gcc-14.2.0
nios2                 randconfig-002-20250308    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250308    gcc-14.2.0
parisc                randconfig-002-20250308    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250308    clang-18
powerpc               randconfig-002-20250308    gcc-14.2.0
powerpc               randconfig-003-20250308    gcc-14.2.0
powerpc64             randconfig-001-20250308    gcc-14.2.0
powerpc64             randconfig-003-20250308    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250308    clang-21
riscv                 randconfig-002-20250308    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250308    clang-19
s390                  randconfig-002-20250308    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250308    gcc-14.2.0
sh                    randconfig-002-20250308    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250308    gcc-14.2.0
sparc                 randconfig-002-20250308    gcc-14.2.0
sparc64               randconfig-001-20250308    gcc-14.2.0
sparc64               randconfig-002-20250308    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250308    gcc-12
um                    randconfig-002-20250308    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250308    gcc-12
x86_64      buildonly-randconfig-002-20250308    clang-19
x86_64      buildonly-randconfig-003-20250308    gcc-12
x86_64      buildonly-randconfig-004-20250308    clang-19
x86_64      buildonly-randconfig-005-20250308    clang-19
x86_64      buildonly-randconfig-006-20250308    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250308    gcc-14.2.0
xtensa                randconfig-002-20250308    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

