Return-Path: <linux-pci+bounces-33835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22057B21DC0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA61903661
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C929BD97;
	Tue, 12 Aug 2025 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9UUwlUL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4A2882D3
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978305; cv=none; b=nWATI3aXK7bX7780wuL/gQ9ADFqwm9GEdfg2w9+Co1ectvQS8MPYqvSjpsYJQAYRTIuXNzzhIdxM6vkTij7cj2GR5oqr1kjB1WEAhqBANZzFLI4Zm7rnCLGF7GVvyJWDlw0RbIvaenKEVS9pPWSu1BbFqbaVJlaHlq66OcvGPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978305; c=relaxed/simple;
	bh=MyTkbvLfHIO2qHk8lxsby4u8OP9pTm9ANIHAA5ClNfo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YYgFejD0Yu911JyhWuqnRnAJMprJTVM7ecBNAO/fWAefM1igcoWDr15Yn295RMBdWE8O557p7dnMUNwdFaCsGSX8ZHumVoi7o1gNAMwZwZ8QgkVpAap6+2l9tH4qP2DolOhTDXmqBdbu/1tPzASGoyr+5fsQCXG8Y7LLS5+1Fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9UUwlUL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754978303; x=1786514303;
  h=date:from:to:cc:subject:message-id;
  bh=MyTkbvLfHIO2qHk8lxsby4u8OP9pTm9ANIHAA5ClNfo=;
  b=E9UUwlUL9NPNemZMYCEIBiraILpApC/4aVXV4wH53BGNgocc8USAO7cV
   wMihBM/efyIRdxX5vrnv43deXhAXy+dMuwvSq8LTDW0RfJ4VC+da7wBVw
   KVvJ5n88w77xQrymWeOQXdJccFJwz3LeWoTdLBDU7E1hTOuJdJKJZnPZT
   s4hjAoLy94raMCjBKlClTgE+M9JnbFvBf4qrHMOAACwF+KDYOOqP3RXzB
   AQ4pgwO529/aQHagvhSdIrby85r+H4ktpw6qnlH7UR8rEDKXStY2x8wMd
   dYrAQEioDFtVmhwB4HZFcmjfV+BrqceyQzkjyQEg3sgoZv4wjtoGTzivR
   g==;
X-CSE-ConnectionGUID: wY7NEpHVRnKb1ysAhI+Bmw==
X-CSE-MsgGUID: 4APW3w+5S0y6wG7Tnb2QkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57163981"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57163981"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 22:58:22 -0700
X-CSE-ConnectionGUID: wL+OHP6LSXqRchuFvhiIXA==
X-CSE-MsgGUID: KUTaFYXaQhWHR22fsrA+Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166904250"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 11 Aug 2025 22:58:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uli1b-0006S9-25;
	Tue, 12 Aug 2025 05:58:19 +0000
Date: Tue, 12 Aug 2025 13:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/amd-mdb] BUILD SUCCESS
 1d0156c8b230ca74272708a3206684e6d6157302
Message-ID: <202508121357.IlKDZV8F-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/amd-mdb
branch HEAD: 1d0156c8b230ca74272708a3206684e6d6157302  PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

elapsed time: 1111m

configs tested: 243
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-001-20250812    gcc-14.3.0
arc                   randconfig-002-20250811    gcc-10.5.0
arc                   randconfig-002-20250812    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
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
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-001-20250812    gcc-12.5.0
hexagon               randconfig-002-20250811    clang-16
hexagon               randconfig-002-20250812    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
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
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-001-20250812    gcc-12.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
nios2                 randconfig-002-20250812    gcc-12.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-001-20250812    gcc-12.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc                randconfig-002-20250812    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
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
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
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
um                               allyesconfig    clang-19
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
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-001-20250812    clang-18
xtensa                randconfig-002-20250811    gcc-9.5.0
xtensa                randconfig-002-20250812    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

