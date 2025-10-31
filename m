Return-Path: <linux-pci+bounces-39887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA88C23293
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 04:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08B6B4E14F2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 03:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698226BFCE;
	Fri, 31 Oct 2025 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yae9+Tpy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6028E5
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880989; cv=none; b=sARWZY3G6wqqG7ivL1Ljc/4dcPk06ZQUvmObQ4E63ScH0Oj45KRuNPYVPs9vBzKb8ExHJDRtZQQYvoSXI1cCrp6ssWmEIKNfJJcqNZwcWNV38BREyegFp05nl/fUYDD4H8Sl9mnw7NUuYeYuV+sRXo4ZJpgckM9U38y910rxE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880989; c=relaxed/simple;
	bh=HdZlZ3TTRYW3fRCpLFwMFV7bVR5YewTiQrKYJWfkbLo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eINd2ST5gArWk/FT8fDPBEiNs4fEwalzIumHrQJ1iigCyny0xCYxsJquGOgQdhp/uhnwrmX1CIIRIk/U6e0HxY4qachtNy50hacfHRwVbt4HqaM64z0UA2o7oZtmuSxZAeKvOiqyC3IF1mE8ucEXvCQ7qfnpGJh4eKC1dFgctl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yae9+Tpy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761880987; x=1793416987;
  h=date:from:to:cc:subject:message-id;
  bh=HdZlZ3TTRYW3fRCpLFwMFV7bVR5YewTiQrKYJWfkbLo=;
  b=Yae9+TpyXe/lYhel52yPgtPl9Y92XDZrc2gOmZB5Ckx5JOTB1h52g88C
   oNmrUZ4QanX7MnQDdw2f5YBAlh1c/Sxah7JpfcEUaqz8wTSf0NvHvxWA8
   MvdWtSA9kGJYjyIV0qTNW8qN1kbjH4aQNfGY5leTAEQKjYhQpnhpxuoOT
   YzHSbqV5HZyrNiZ1ndk8aHpG+M1L4rCY3dnN84f4NBaxxX/1TcuHCFfdE
   G+tEK/PXktntoeCth3XuxZKLNJH32JYZQedgnrb+1Fe1mwFnABn0yU7IB
   6wf7Cd+5HYWVQhIZVFHVs0d/saZ1RHH7cL3J4sNt7dxf1u9hP12Ghz1mP
   g==;
X-CSE-ConnectionGUID: NZ010XxuQ0uwz2PYvqSH5Q==
X-CSE-MsgGUID: 5fsI2tAWQiqZOLR57ZkcaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75384701"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75384701"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:23:03 -0700
X-CSE-ConnectionGUID: hOUVCp2bR3OjcqgQ4gaS5Q==
X-CSE-MsgGUID: CZ+H1wZIQyevReqtMnuCdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="223354778"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 30 Oct 2025 20:23:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEfjA-000MjN-1f;
	Fri, 31 Oct 2025 03:23:00 +0000
Date: Fri, 31 Oct 2025 11:22:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 5751f941efec1c26ed6df7e7fd517634c78fc0b1
Message-ID: <202510311139.1VIkw3Ez-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 5751f941efec1c26ed6df7e7fd517634c78fc0b1  PCI: Prevent restoring assigned resources

elapsed time: 1599m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251030    gcc-11.5.0
arc                   randconfig-002-20251030    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                         axm55xx_defconfig    clang-22
arm                          moxart_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20251030    gcc-10.5.0
arm                   randconfig-002-20251030    clang-19
arm                   randconfig-003-20251030    clang-22
arm                   randconfig-004-20251030    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251031    gcc-8.5.0
arm64                 randconfig-002-20251031    clang-22
arm64                 randconfig-003-20251031    gcc-10.5.0
arm64                 randconfig-004-20251031    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251031    gcc-9.5.0
csky                  randconfig-002-20251031    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251030    clang-22
hexagon               randconfig-002-20251030    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251031    gcc-14
i386        buildonly-randconfig-002-20251031    gcc-14
i386        buildonly-randconfig-003-20251031    clang-20
i386        buildonly-randconfig-004-20251031    gcc-14
i386        buildonly-randconfig-005-20251031    clang-20
i386        buildonly-randconfig-006-20251031    gcc-14
i386                  randconfig-001-20251031    gcc-14
i386                  randconfig-002-20251031    gcc-14
i386                  randconfig-003-20251031    gcc-14
i386                  randconfig-004-20251031    gcc-14
i386                  randconfig-005-20251031    gcc-14
i386                  randconfig-006-20251031    gcc-12
i386                  randconfig-007-20251031    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251030    clang-22
loongarch             randconfig-002-20251030    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251030    gcc-8.5.0
nios2                 randconfig-002-20251030    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251030    gcc-8.5.0
parisc                randconfig-002-20251030    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20251030    clang-22
powerpc               randconfig-002-20251030    clang-22
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc64             randconfig-002-20251030    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251030    gcc-13.4.0
riscv                 randconfig-002-20251030    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251030    clang-17
s390                  randconfig-002-20251030    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251030    gcc-15.1.0
sh                    randconfig-002-20251030    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251030    gcc-8.5.0
sparc                 randconfig-002-20251030    gcc-8.5.0
sparc64               randconfig-001-20251030    gcc-11.5.0
sparc64               randconfig-002-20251030    clang-20
um                               alldefconfig    clang-22
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251030    gcc-14
um                    randconfig-002-20251030    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251031    clang-20
x86_64      buildonly-randconfig-002-20251031    gcc-14
x86_64      buildonly-randconfig-003-20251031    clang-20
x86_64      buildonly-randconfig-004-20251031    gcc-14
x86_64      buildonly-randconfig-005-20251031    gcc-14
x86_64      buildonly-randconfig-006-20251031    gcc-14
x86_64                randconfig-011-20251031    gcc-14
x86_64                randconfig-012-20251031    clang-20
x86_64                randconfig-013-20251031    gcc-14
x86_64                randconfig-014-20251031    gcc-14
x86_64                randconfig-015-20251031    gcc-14
x86_64                randconfig-016-20251031    clang-20
x86_64                randconfig-071-20251031    gcc-14
x86_64                randconfig-072-20251031    clang-20
x86_64                randconfig-073-20251031    gcc-14
x86_64                randconfig-074-20251031    clang-20
x86_64                randconfig-075-20251031    gcc-14
x86_64                randconfig-076-20251031    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251030    gcc-10.5.0
xtensa                randconfig-002-20251030    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

