Return-Path: <linux-pci+bounces-33887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FCB23A95
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 23:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE94C1AA00A0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2061F0E56;
	Tue, 12 Aug 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaGPTG/n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4643D987
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033793; cv=none; b=RazkZyTV3AuHhOC4IFEac5KOfzridR6ATkmdXiUz8RlQSDkGUSrF+wWD2sQqtQoAkTLOiBK1eyDwVysupWHoivgwfZKHBE/6xnOP0kurg+j/zNE4H7vigPedmK+8CUopK0GHjrZ4XSmgr0jKr5Fm9r1UqiGo8nnYpBmuQbAaX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033793; c=relaxed/simple;
	bh=0KpbbkJisBNtODdp5sgSwAPM+E/OCFscRhG5/DQtuRw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OE3CLAUEpmGjj7aYQFRudubV5FGKwNCugw7swCnWm/inSIbGpvIP77fPeS6tv0pv9mfzLM94aXH/7DChk7DHeleNEPMlU2DmxNKvLUG0/Agq9zYTqF8ZqlMS+iUzMFZwgBQHgH8/6bmg+H27oYMtIrp+46UbZGTzoGrxQIEILmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaGPTG/n; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755033792; x=1786569792;
  h=date:from:to:cc:subject:message-id;
  bh=0KpbbkJisBNtODdp5sgSwAPM+E/OCFscRhG5/DQtuRw=;
  b=LaGPTG/nndyE8h1D/HpMc4VyfoSJuNjEqkQOZE6tDIuQAJ4artOInUlv
   XSMKiiW7LZd/tVwsYDKzFenfODQUStty5RBoFeD6U3oVt6BNHoIkgP2HL
   1bas9ninj3sZDC8NK918LfulV4wFT2Tgj5+iZuLdVU1nkwryb3FFHmfyP
   V3KfoXAS8rVjhPOoSFnJEeV18mDsSpvFHxd5AnILZWUg5Wmsuod9mj23D
   Cq2mUF2fY6LUqvvf6Lz70NhA6tuKcUAbUdCVTVl8yam8dsCUuaJtO5xRh
   8xXDbzI2hBr2l6STYld+eZ/dgxPBi0VMBNqGwoNND9htuPph+TEUcbSr1
   g==;
X-CSE-ConnectionGUID: izgC62b9RG6ymEUnIfy6sQ==
X-CSE-MsgGUID: E13DwqPDT4Kh4YXR3fDtMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57383222"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57383222"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 14:23:11 -0700
X-CSE-ConnectionGUID: nwJ3ouwpR+uWuiFrocEaGQ==
X-CSE-MsgGUID: R9baplUHQvmZXpw32gRvwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="189998377"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2025 14:23:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulwSU-0009JA-1m;
	Tue, 12 Aug 2025 21:23:04 +0000
Date: Wed, 13 Aug 2025 05:22:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 642b44ee5a26822fc616bc41cabf209724814ae4
Message-ID: <202508130505.LubRsdde-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 642b44ee5a26822fc616bc41cabf209724814ae4  PCI: Fix whitespace issues

elapsed time: 1450m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250812    gcc-8.5.0
arc                   randconfig-002-20250812    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20250812    clang-22
arm                   randconfig-002-20250812    clang-22
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250812    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250812    gcc-8.5.0
arm64                 randconfig-002-20250812    gcc-8.5.0
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250812    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-13.4.0
csky                  randconfig-002-20250812    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250812    clang-22
hexagon               randconfig-002-20250812    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250812    clang-20
i386        buildonly-randconfig-005-20250812    clang-20
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250812    gcc-15.1.0
loongarch             randconfig-002-20250812    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250812    gcc-10.5.0
nios2                 randconfig-002-20250812    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250812    gcc-10.5.0
parisc                randconfig-002-20250812    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250812    clang-19
powerpc               randconfig-002-20250812    clang-22
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc64             randconfig-001-20250812    clang-22
powerpc64             randconfig-002-20250812    clang-16
powerpc64             randconfig-003-20250812    clang-18
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250812    gcc-9.5.0
riscv                 randconfig-002-20250812    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250812    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250812    gcc-15.1.0
sh                    randconfig-002-20250812    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250812    gcc-8.5.0
sparc                 randconfig-002-20250812    gcc-8.5.0
sparc64               randconfig-001-20250812    clang-22
sparc64               randconfig-002-20250812    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250812    gcc-11
um                    randconfig-002-20250812    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250812    clang-20
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250812    clang-20
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250812    gcc-10.5.0
xtensa                randconfig-002-20250812    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

