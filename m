Return-Path: <linux-pci+bounces-43861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51BCEA348
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF33630380D1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDB21D3CD;
	Tue, 30 Dec 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLcNoPF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C198137923
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112903; cv=none; b=mPklb7CC/FVPw8gcrSj8qxmpQo28Uem0PA7fU/zVwFHgK8TiM9mezHSB3oG/g09Lwc7xixadWYJcu7y4lwKlSbGKQJ4nT1SX6hPWWhjWYgs7kQusX9+CJwkBOyi+paePBSq0aqBMmqIsMNuwFXEfwe5znuJ+o3RSuCgAS/qhTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112903; c=relaxed/simple;
	bh=yq84QaksitgbvmNnwXcBx9M4+wXJJX04FVEh4iuW/kM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MWEuIHTygx/bg1/021rUWHC2vs2/syX8Xq9K41imsKIP/2tHc7aKZgTYePeOhk3YSNxSZElZ1QG4NHNKAPjFL2k8A3HiNkT2BChPf15dtvevkcL0z95207yZiRbsYaXaPUEgCqCtrpUepkSndZIZw0x350vSu3gv3Dzh6K67Big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLcNoPF2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767112901; x=1798648901;
  h=date:from:to:cc:subject:message-id;
  bh=yq84QaksitgbvmNnwXcBx9M4+wXJJX04FVEh4iuW/kM=;
  b=QLcNoPF2WmKJrGCVxJCpHRlyBHcJQVUDmBUrBPeA006BN3eiEhZI+0rP
   V9v+rPFrdW6rEceIRJRFl8l5KFIj2Pyw0P3UbXzh2zAMr55YdIOcYT1cr
   SN9ms2UcUkV6gH1gAQaBktR0f8jq5JPwsiK7RzPnGEQmJQ78Qbcqwa/M6
   ZbFiNOD+uFfodHXGT08OJWnpYMnKvsPKXwLM3UUP577wv4LulB/LmQaOd
   g4YFBs3vuoIMyfG4cXe5JdKqVuKH48dL1lCV5sTlNpmx62pitJDTbhNOo
   wEKsmP+Ad3e2KjnWFSpS+IBJ4XrRTU2kn6RpsQiwK9RMUDawwHZqNC8TU
   w==;
X-CSE-ConnectionGUID: zRKrcRFnQJ2CYbGnjiZiqg==
X-CSE-MsgGUID: HbAEiZbcRteN90o7RYGxcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="56274107"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="56274107"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 08:41:40 -0800
X-CSE-ConnectionGUID: DEam4SUNTaGG7VDIHL4y0g==
X-CSE-MsgGUID: 18z0chigQbyqkkjWeRPUTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="238686026"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Dec 2025 08:41:39 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vacmu-000000000Xo-3PlF;
	Tue, 30 Dec 2025 16:41:36 +0000
Date: Wed, 31 Dec 2025 00:41:32 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 7c5c7d06bd1f86d2c3ebe62be903a4ba42db4d2c
Message-ID: <202512310026.I2vNboel-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 7c5c7d06bd1f86d2c3ebe62be903a4ba42db4d2c  PCI: endpoint: Avoid creating sub-groups asynchronously

elapsed time: 1428m

configs tested: 165
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251230    gcc-12.5.0
arc                   randconfig-002-20251230    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251230    gcc-8.5.0
arm                   randconfig-002-20251230    gcc-8.5.0
arm                   randconfig-003-20251230    gcc-10.5.0
arm                   randconfig-004-20251230    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251230    gcc-15.1.0
arm64                 randconfig-002-20251230    gcc-14.3.0
arm64                 randconfig-003-20251230    clang-22
arm64                 randconfig-004-20251230    clang-20
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251230    gcc-15.1.0
csky                  randconfig-002-20251230    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251230    clang-22
hexagon               randconfig-002-20251230    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251230    gcc-14
i386        buildonly-randconfig-002-20251230    clang-20
i386        buildonly-randconfig-003-20251230    clang-20
i386        buildonly-randconfig-004-20251230    clang-20
i386        buildonly-randconfig-005-20251230    clang-20
i386        buildonly-randconfig-006-20251230    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251230    gcc-14
i386                  randconfig-002-20251230    clang-20
i386                  randconfig-003-20251230    clang-20
i386                  randconfig-004-20251230    clang-20
i386                  randconfig-005-20251230    clang-20
i386                  randconfig-006-20251230    clang-20
i386                  randconfig-007-20251230    clang-20
i386                  randconfig-011-20251230    gcc-14
i386                  randconfig-012-20251230    gcc-14
i386                  randconfig-013-20251230    clang-20
i386                  randconfig-014-20251230    gcc-12
i386                  randconfig-015-20251230    gcc-14
i386                  randconfig-016-20251230    gcc-14
i386                  randconfig-017-20251230    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251230    gcc-15.1.0
loongarch             randconfig-002-20251230    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251230    gcc-8.5.0
nios2                 randconfig-002-20251230    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251230    gcc-15.1.0
parisc                randconfig-002-20251230    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    clang-22
powerpc               randconfig-001-20251230    gcc-10.5.0
powerpc               randconfig-002-20251230    gcc-12.5.0
powerpc64             randconfig-001-20251230    gcc-14.3.0
powerpc64             randconfig-002-20251230    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251230    gcc-15.1.0
riscv                 randconfig-002-20251230    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251230    gcc-14.3.0
s390                  randconfig-002-20251230    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20251230    gcc-13.4.0
sh                    randconfig-002-20251230    gcc-12.5.0
sh                          rsk7269_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251230    gcc-8.5.0
sparc                 randconfig-002-20251230    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251230    clang-22
sparc64               randconfig-002-20251230    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251230    gcc-13
um                    randconfig-002-20251230    clang-18
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251230    gcc-14
x86_64      buildonly-randconfig-002-20251230    gcc-14
x86_64      buildonly-randconfig-003-20251230    clang-20
x86_64      buildonly-randconfig-004-20251230    clang-20
x86_64      buildonly-randconfig-005-20251230    clang-20
x86_64      buildonly-randconfig-006-20251230    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251230    gcc-14
x86_64                randconfig-002-20251230    clang-20
x86_64                randconfig-003-20251230    clang-20
x86_64                randconfig-004-20251230    clang-20
x86_64                randconfig-005-20251230    clang-20
x86_64                randconfig-006-20251230    gcc-14
x86_64                randconfig-011-20251230    gcc-14
x86_64                randconfig-012-20251230    gcc-14
x86_64                randconfig-013-20251230    gcc-14
x86_64                randconfig-014-20251230    clang-20
x86_64                randconfig-015-20251230    clang-20
x86_64                randconfig-016-20251230    clang-20
x86_64                randconfig-071-20251230    clang-20
x86_64                randconfig-072-20251230    clang-20
x86_64                randconfig-073-20251230    gcc-14
x86_64                randconfig-074-20251230    clang-20
x86_64                randconfig-075-20251230    clang-20
x86_64                randconfig-076-20251230    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251230    gcc-8.5.0
xtensa                randconfig-002-20251230    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

