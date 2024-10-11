Return-Path: <linux-pci+bounces-14342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA599A9C9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86661C222B6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B619F11E;
	Fri, 11 Oct 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFHhjbEp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA881AD7
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667232; cv=none; b=QxYmhmFTCzinuNHB+ACmf/BB/ym4HNaIEBVDX3YzBCFs7GPNiEawgfPQFiRHuzWhcsLcqLq+yQbXhSJvZG3IRR1OpGFb9qMnKPpWbtjoDpi0Ebd5EbXpPYO/B/RRxW65IeDhFTbaSm1VczWvEQYFJWK7QtCgLukqvQzDczEMGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667232; c=relaxed/simple;
	bh=/Wk4VcLHbJsFPelSd5euY0M99m1Sz+ZgR4hf36TQCs8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tjQOsvRD3+M2ps1AScR7gOPxzJWC6xabUoHhjrZiAjZWg39zSVUPEQ9W2rEW1SQjC32poIMMeboyP9MJilSoRJ5ohA7ZxxVHni9L/EjxF4SKS097Oo7GGZ4hvlWQtyUh3/uU3A/B5k4p0RjZBNQW/K+4cdyQgUeePwD41BJ4sAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFHhjbEp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728667230; x=1760203230;
  h=date:from:to:cc:subject:message-id;
  bh=/Wk4VcLHbJsFPelSd5euY0M99m1Sz+ZgR4hf36TQCs8=;
  b=XFHhjbEp6sEmfryagqqFkqt+cCoBQIFiAGtkSw27aVrkKPlFIzw0/ZWG
   /6ABdKqczjI/yEcEdGEdpmts1lJAmXPb8sKfaWIafx5ZBqRJoDksbmQeC
   ozRxouRQV7J7VqPEXQBz4zYqicmZ1seMu7Qlw6sZumTNW8sypa/EegMQy
   UiEKU9SF32ow9XgU9HbT2zNczq6s5a+05ZsiK/p/T3oQ0/V0PfC5NYwCP
   YkoW+wHM9AM467SQUO6479CA29+szv8v5Ir8CD/iLDn5RmuEw/8HsnVhB
   Bt2JIFYqONsyMQ2USI0yN9Z5jy8Mxlh6wn9Mjop0VkaSABfUoMNWoTgJF
   g==;
X-CSE-ConnectionGUID: VPR85jy6QUKqdwI1o4X4LA==
X-CSE-MsgGUID: 9fWxpe7+RHGIZgMgaY4fog==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28203429"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28203429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:20:30 -0700
X-CSE-ConnectionGUID: m4m5C99lSEqMg2fs45kJbg==
X-CSE-MsgGUID: 8YN8uYOaSp2BndW0qF6Yug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81788611"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Oct 2024 10:20:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szJJS-000CYX-2o;
	Fri, 11 Oct 2024 17:20:26 +0000
Date: Sat, 12 Oct 2024 01:20:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 e3bdd2dd3f618d0bb9f500aae17df2b4f726dca1
Message-ID: <202410120110.KxSOaP86-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: e3bdd2dd3f618d0bb9f500aae17df2b4f726dca1  PCI: Add ALIGN_DOWN_IF_NONZERO() helper

elapsed time: 1078m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241011    gcc-12
i386        buildonly-randconfig-002-20241011    gcc-12
i386        buildonly-randconfig-003-20241011    gcc-12
i386        buildonly-randconfig-004-20241011    gcc-12
i386        buildonly-randconfig-005-20241011    gcc-12
i386        buildonly-randconfig-006-20241011    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241011    gcc-12
i386                  randconfig-002-20241011    gcc-12
i386                  randconfig-003-20241011    gcc-12
i386                  randconfig-004-20241011    gcc-12
i386                  randconfig-005-20241011    gcc-12
i386                  randconfig-006-20241011    gcc-12
i386                  randconfig-011-20241011    gcc-12
i386                  randconfig-012-20241011    gcc-12
i386                  randconfig-013-20241011    gcc-12
i386                  randconfig-014-20241011    gcc-12
i386                  randconfig-015-20241011    gcc-12
i386                  randconfig-016-20241011    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

