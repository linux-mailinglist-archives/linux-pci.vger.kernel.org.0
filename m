Return-Path: <linux-pci+bounces-40008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BBC27A57
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EA1189B69F
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 08:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F852BE037;
	Sat,  1 Nov 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsqU5KkN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08652BDC1B
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987258; cv=none; b=ZxHD74Ha1c3+eXiuwTYaKFBIwxggu0yDXE5pp28hgxlMVB+g0wLjbfkLgTQ1CXq3RXmFTFkwGY2Yd3KYjVh0jI+VfJziZP0nj7uzs4tMXioG7VSx+v2kaKiSAmPQCTbvumZcbqsnH5oSfhLpGNaYiNGKp3FRVNX+tIRnX16eSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987258; c=relaxed/simple;
	bh=lThArKjR/mDMFOMJ7UaDAQ9LF9kt8hFhSG8s81iwaT0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SWFgYX8mPHLeZEcLD2lhIc8adM8eKUkWruwA5w1Cp4JlqrWWBQIw+NNeMmUsMgItAuljI6qKdqz4CAfDbjiDdAvBgiVqq3JDPUPhhqSyksh5Az3if35Dho+S0pIYmX10Blzk3iQgdDuoUEhHfmrYjqlWiFX4K3d4pdP/d8NhqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsqU5KkN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761987257; x=1793523257;
  h=date:from:to:cc:subject:message-id;
  bh=lThArKjR/mDMFOMJ7UaDAQ9LF9kt8hFhSG8s81iwaT0=;
  b=dsqU5KkNpk+itsUQj/seErkOcg4OfRUAkLSEqKV1nAh59msy6ncPxZXk
   fUZwA5eY0orjJqHpawSJP1w7crPwGkHBhCE/mIxOAefO5Di64VqSFkkEL
   1oCCN3fH68hWRHE33WGRUW8I8oVZyC6o0UESbliLmxEjTpCwflVDx8TYF
   81b9QRakNjKnIr8LH4GD4sm7dczY6o5I8laVcQA4x2dLGpuTa5ktrP4nh
   sh/6ugUHlR0w0mgBWb9v+0xHD4NiiyNqIannzXvXts3nvBWeXylTBE7L9
   oimKubtb0KW+UObrI77mpqOnp7To2dkN7uSUJjHkzpqSv0qS5km+8isho
   w==;
X-CSE-ConnectionGUID: IcN/wE1QRMG7j7+Z+7IjBg==
X-CSE-MsgGUID: HfrpwgqXQhm2psl7nO90BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="66754975"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="66754975"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 01:54:15 -0700
X-CSE-ConnectionGUID: EyfZpf5ARfKIY0Qg9D5kFA==
X-CSE-MsgGUID: Dansp6mzTDqq11AuzKqpbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="186881305"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Nov 2025 01:54:14 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF7NE-000O3Y-0V;
	Sat, 01 Nov 2025 08:54:12 +0000
Date: Sat, 01 Nov 2025 16:54:01 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/ti] BUILD SUCCESS
 8895c0fc0671f38746ee1c02b728b126f7dbbf97
Message-ID: <202511011656.uDrWtAIN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/ti
branch HEAD: 8895c0fc0671f38746ee1c02b728b126f7dbbf97  PCI: j721e: Use 'pcie->reset_gpio' directly and drop the local variable

elapsed time: 1396m

configs tested: 217
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251031    gcc-8.5.0
arc                   randconfig-001-20251101    gcc-8.5.0
arc                   randconfig-002-20251031    gcc-8.5.0
arc                   randconfig-002-20251101    gcc-8.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                         mv78xx0_defconfig    gcc-15.1.0
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20251031    gcc-14.3.0
arm                   randconfig-001-20251101    gcc-8.5.0
arm                   randconfig-002-20251031    clang-22
arm                   randconfig-002-20251101    gcc-8.5.0
arm                   randconfig-003-20251031    gcc-11.5.0
arm                   randconfig-003-20251101    gcc-8.5.0
arm                   randconfig-004-20251031    clang-22
arm                   randconfig-004-20251101    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251101    gcc-14.3.0
arm64                 randconfig-002-20251101    gcc-14.3.0
arm64                 randconfig-003-20251101    gcc-14.3.0
arm64                 randconfig-004-20251101    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251101    gcc-14.3.0
csky                  randconfig-002-20251101    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251031    clang-22
hexagon               randconfig-001-20251101    clang-19
hexagon               randconfig-002-20251031    clang-22
hexagon               randconfig-002-20251101    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251101    clang-20
i386        buildonly-randconfig-002-20251101    clang-20
i386        buildonly-randconfig-003-20251101    clang-20
i386        buildonly-randconfig-004-20251101    clang-20
i386        buildonly-randconfig-005-20251101    clang-20
i386        buildonly-randconfig-006-20251101    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251101    gcc-14
i386                  randconfig-002-20251101    gcc-14
i386                  randconfig-003-20251101    gcc-14
i386                  randconfig-004-20251101    gcc-14
i386                  randconfig-005-20251101    gcc-14
i386                  randconfig-006-20251101    gcc-14
i386                  randconfig-007-20251101    gcc-14
i386                  randconfig-011-20251101    clang-20
i386                  randconfig-012-20251101    clang-20
i386                  randconfig-013-20251101    clang-20
i386                  randconfig-014-20251101    clang-20
i386                  randconfig-015-20251101    clang-20
i386                  randconfig-016-20251101    clang-20
i386                  randconfig-017-20251101    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch             randconfig-001-20251101    clang-19
loongarch             randconfig-002-20251101    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ci20_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                            allyesconfig    gcc-11.5.0
nios2                 randconfig-001-20251101    clang-19
nios2                 randconfig-002-20251101    clang-19
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251101    clang-20
parisc                randconfig-001-20251101    gcc-11.5.0
parisc                randconfig-002-20251101    clang-20
parisc                randconfig-002-20251101    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251101    clang-20
powerpc               randconfig-001-20251101    gcc-11.5.0
powerpc               randconfig-002-20251101    clang-20
powerpc               randconfig-002-20251101    clang-22
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251101    clang-20
powerpc64             randconfig-001-20251101    gcc-11.5.0
powerpc64             randconfig-002-20251101    clang-20
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251031    gcc-8.5.0
riscv                 randconfig-001-20251101    clang-17
riscv                 randconfig-002-20251031    clang-17
riscv                 randconfig-002-20251101    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251031    clang-16
s390                  randconfig-001-20251101    clang-17
s390                  randconfig-002-20251031    gcc-12.5.0
s390                  randconfig-002-20251101    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20251031    gcc-14.3.0
sh                    randconfig-001-20251101    clang-17
sh                    randconfig-002-20251031    gcc-14.3.0
sh                    randconfig-002-20251101    clang-17
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251101    clang-16
sparc                 randconfig-002-20251101    clang-16
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251101    clang-16
sparc64               randconfig-002-20251101    clang-16
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251101    clang-16
um                    randconfig-002-20251101    clang-16
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251101    gcc-14
x86_64      buildonly-randconfig-002-20251101    gcc-14
x86_64      buildonly-randconfig-003-20251101    gcc-14
x86_64      buildonly-randconfig-004-20251101    gcc-14
x86_64      buildonly-randconfig-005-20251101    gcc-14
x86_64      buildonly-randconfig-006-20251101    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251101    clang-20
x86_64                randconfig-002-20251101    clang-20
x86_64                randconfig-003-20251101    clang-20
x86_64                randconfig-004-20251101    clang-20
x86_64                randconfig-005-20251101    clang-20
x86_64                randconfig-006-20251101    clang-20
x86_64                randconfig-011-20251101    gcc-14
x86_64                randconfig-012-20251101    gcc-14
x86_64                randconfig-013-20251101    gcc-14
x86_64                randconfig-014-20251101    gcc-14
x86_64                randconfig-015-20251101    gcc-14
x86_64                randconfig-016-20251101    gcc-14
x86_64                randconfig-071-20251101    clang-20
x86_64                randconfig-072-20251101    clang-20
x86_64                randconfig-073-20251101    clang-20
x86_64                randconfig-074-20251101    clang-20
x86_64                randconfig-075-20251101    clang-20
x86_64                randconfig-076-20251101    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251101    clang-16
xtensa                randconfig-002-20251101    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

