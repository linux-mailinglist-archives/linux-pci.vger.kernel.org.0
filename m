Return-Path: <linux-pci+bounces-33856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4CAB2249A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE6620280
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DC92EB5CC;
	Tue, 12 Aug 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="el+2r2C0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FE2E4249
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994519; cv=none; b=UexPpA+VR8L2jaO16z6tlJwgcwwNXrGeMN35Rb3qAwktu4G8oJmxion2CxUr110CkvWvnm/g1mS3b40/VhXXtUxtc2LosERQhvEhizHjx4z0Cpe6+joaBAHNMTby3M9ERBUwdizkg0CCHA/uDT347d34pwd63ZDrGq7freMro3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994519; c=relaxed/simple;
	bh=6sPXStlyOMmrnmJaJwc69jvo8JErEPnltfTgmxchzNg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kFkK0ogMgd+SoUlnRF6N5p/JyLOk+yQ96in2pectl4J6l+hcQp1ob/W0bnly6JrHZiM+lprrnUlyCfGNCM4jL9TpIVzMk6pv0TD/2j4XfH+poSfC+KjBuegdZVWzOrfMmlNGhw9bgv6GDS/1IovMOFVULLVCfB0BfT7opW8oXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=el+2r2C0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754994518; x=1786530518;
  h=date:from:to:cc:subject:message-id;
  bh=6sPXStlyOMmrnmJaJwc69jvo8JErEPnltfTgmxchzNg=;
  b=el+2r2C01VSgopPFif+r1y17x2MaPavosDfn5CmPJI5Gx59uYKLq7ug0
   R6tQj1FzRcT52zdIc/lwnFPY7TAnTwRf9J5gPNHvInGIg08AgYvQmXG6C
   BHhiE2OE6SdpAcxscOQZVTn+NJ6KExtPnQ/Oguwm0DHWL9STO/Q10LR76
   k08gpzIO7VkJYbJjETQKcjiB8jjumvonfr5gQczqTx1lkuA68+X+1/9Ui
   x+lfwHtyhMLW3xlLTS3nxstXW8dlA8Xc/J+0mrP3N8zJdIJklKBoAIs/G
   3SM5JcJ3jCHCyueYA5RdJ2cK94WKlFdT5vjR4cMvhbjMz6ktQKv98M9Xw
   Q==;
X-CSE-ConnectionGUID: 3zlrQNgXRw634plgndPFAQ==
X-CSE-MsgGUID: hRsZ55J3QpKVqKD7kJrKYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="82702831"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="82702831"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 03:28:37 -0700
X-CSE-ConnectionGUID: Fef3n/AxR9mqRYmlzH8U8w==
X-CSE-MsgGUID: fZ6kOsY4SKmnNXTl70O84Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166166508"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 12 Aug 2025 03:28:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulmEe-0006fz-05;
	Tue, 12 Aug 2025 10:28:16 +0000
Date: Tue, 12 Aug 2025 18:23:45 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 add7b05aeeb417c86239e6731a168e6c46b83279
Message-ID: <202508121839.fg6S0yf6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: add7b05aeeb417c86239e6731a168e6c46b83279  PCI: qcom: Select PCI Power Control Slot driver

elapsed time: 1377m

configs tested: 245
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-001-20250812    gcc-14.3.0
arc                   randconfig-002-20250811    gcc-10.5.0
arc                   randconfig-002-20250812    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20250811    gcc-10.5.0
arm                   randconfig-001-20250812    gcc-14.3.0
arm                   randconfig-002-20250811    gcc-13.4.0
arm                   randconfig-002-20250812    gcc-14.3.0
arm                   randconfig-003-20250811    clang-22
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250811    gcc-10.5.0
arm                   randconfig-004-20250812    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                               defconfig    clang-22
arm64                 randconfig-001-20250811    clang-22
arm64                 randconfig-001-20250812    gcc-14.3.0
arm64                 randconfig-002-20250811    clang-19
arm64                 randconfig-002-20250812    gcc-14.3.0
arm64                 randconfig-003-20250811    clang-20
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250811    clang-22
arm64                 randconfig-004-20250812    gcc-14.3.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250811    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-12.5.0
csky                  randconfig-002-20250811    gcc-15.1.0
csky                  randconfig-002-20250812    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-001-20250812    gcc-12.5.0
hexagon               randconfig-002-20250811    clang-16
hexagon               randconfig-002-20250812    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250811    clang-20
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250811    clang-20
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250811    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250811    gcc-12
i386        buildonly-randconfig-004-20250812    gcc-12
i386        buildonly-randconfig-005-20250811    gcc-12
i386        buildonly-randconfig-005-20250812    gcc-12
i386        buildonly-randconfig-006-20250811    gcc-12
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250812    clang-20
i386                  randconfig-002-20250812    clang-20
i386                  randconfig-003-20250812    clang-20
i386                  randconfig-004-20250812    clang-20
i386                  randconfig-005-20250812    clang-20
i386                  randconfig-006-20250812    clang-20
i386                  randconfig-007-20250812    clang-20
i386                  randconfig-011-20250812    gcc-12
i386                  randconfig-012-20250812    gcc-12
i386                  randconfig-013-20250812    gcc-12
i386                  randconfig-014-20250812    gcc-12
i386                  randconfig-015-20250812    gcc-12
i386                  randconfig-016-20250812    gcc-12
i386                  randconfig-017-20250812    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250811    gcc-15.1.0
loongarch             randconfig-001-20250812    gcc-12.5.0
loongarch             randconfig-002-20250811    gcc-12.5.0
loongarch             randconfig-002-20250812    gcc-12.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-001-20250812    gcc-12.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
nios2                 randconfig-002-20250812    gcc-12.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-001-20250812    gcc-12.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc                randconfig-002-20250812    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      katmai_defconfig    clang-22
powerpc               randconfig-001-20250811    gcc-13.4.0
powerpc               randconfig-001-20250812    gcc-12.5.0
powerpc               randconfig-002-20250811    clang-22
powerpc               randconfig-002-20250812    gcc-12.5.0
powerpc               randconfig-003-20250811    gcc-13.4.0
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc64             randconfig-001-20250811    clang-22
powerpc64             randconfig-001-20250812    gcc-12.5.0
powerpc64             randconfig-002-20250811    clang-22
powerpc64             randconfig-002-20250812    gcc-12.5.0
powerpc64             randconfig-003-20250811    gcc-14.3.0
powerpc64             randconfig-003-20250812    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250811    gcc-8.5.0
riscv                 randconfig-001-20250812    clang-18
riscv                 randconfig-002-20250811    clang-22
riscv                 randconfig-002-20250812    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250811    gcc-8.5.0
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250811    clang-17
s390                  randconfig-002-20250812    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20250811    gcc-15.1.0
sh                    randconfig-001-20250812    clang-18
sh                    randconfig-002-20250811    gcc-15.1.0
sh                    randconfig-002-20250812    clang-18
sh                             sh03_defconfig    clang-22
sh                     sh7710voipgw_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250811    gcc-8.5.0
sparc                 randconfig-001-20250812    clang-18
sparc                 randconfig-002-20250811    gcc-8.5.0
sparc                 randconfig-002-20250812    clang-18
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250811    clang-22
sparc64               randconfig-001-20250812    clang-18
sparc64               randconfig-002-20250811    gcc-14.3.0
sparc64               randconfig-002-20250812    clang-18
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250811    clang-18
um                    randconfig-001-20250812    clang-18
um                    randconfig-002-20250811    clang-22
um                    randconfig-002-20250812    clang-18
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250811    gcc-12
x86_64      buildonly-randconfig-001-20250812    gcc-12
x86_64      buildonly-randconfig-002-20250811    clang-20
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250811    clang-20
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250811    clang-20
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250811    clang-20
x86_64      buildonly-randconfig-005-20250812    gcc-12
x86_64      buildonly-randconfig-006-20250811    clang-20
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250812    gcc-11
x86_64                randconfig-002-20250812    gcc-11
x86_64                randconfig-003-20250812    gcc-11
x86_64                randconfig-004-20250812    gcc-11
x86_64                randconfig-005-20250812    gcc-11
x86_64                randconfig-006-20250812    gcc-11
x86_64                randconfig-007-20250812    gcc-11
x86_64                randconfig-008-20250812    gcc-11
x86_64                randconfig-071-20250812    clang-20
x86_64                randconfig-072-20250812    clang-20
x86_64                randconfig-073-20250812    clang-20
x86_64                randconfig-074-20250812    clang-20
x86_64                randconfig-075-20250812    clang-20
x86_64                randconfig-076-20250812    clang-20
x86_64                randconfig-077-20250812    clang-20
x86_64                randconfig-078-20250812    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-001-20250812    clang-18
xtensa                randconfig-002-20250811    gcc-9.5.0
xtensa                randconfig-002-20250812    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

