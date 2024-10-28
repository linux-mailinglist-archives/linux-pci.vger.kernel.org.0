Return-Path: <linux-pci+bounces-15437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CC9B2AA2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FA9B21476
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC371925B7;
	Mon, 28 Oct 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9Uhjx/G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF119066B
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104968; cv=none; b=QOmYcqpdTlkjhGzm0LdBqY71zmwM8Yp/T2Z7KO55vyKpb+frQPyT5QdKhcHSCP9MtphR3dEV3z3UGZZh30x+lHCuM8Bvl//JO5VdTyBVwCxbHWyLUpwncbEkqS6pad1QmFvLTb9w/4yiorPkgKYhlakDyT3SpNLT3GZHSaV+kpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104968; c=relaxed/simple;
	bh=YIu1HP4sI50Z5aHvOjfhEQqOsFYfFhCeUCs9hX3X5PM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YnyEbd8iVKmMCiVJYnKLBpHhaaNs/hq2hhylEi5ULXem9B4bE7uzSUk+k5SiqKYBkRBBkETL1Br9CBM9O4csj5SxOtMmFHWnqHeWbGCmjzg3HbYVJ/F9Q4FxYY0d1X0oM3kZZFgXiYvqwVSefSkPadqFs0YwamOlnjxVXjooTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9Uhjx/G; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730104965; x=1761640965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YIu1HP4sI50Z5aHvOjfhEQqOsFYfFhCeUCs9hX3X5PM=;
  b=B9Uhjx/GsE9gU1CnkMSqZkAn1SGc4rP2Be1XNS8WbNxUgLIWcJ/Vsoc5
   74qFcoKkSTh+5DPA0xy1wFSS9FodZBscyKeFPs+iw3I2y/jxB1M2AE1z0
   NOhWDYmeX8ofCI6eXUm4oOAIuuRYKYZUISOgT/nHityzjYFZsrv1Qn5pQ
   Usryi1to4x/W/bEL6iyhmYPZSPOU/AKFi0Vd84gL59svqwIxZ/rEKK6Nf
   KzuuuigHg1rwOmfqOwQktUlTvTlJkIrDirCgGwc2GATQw7mmtsKruzTHS
   4U4tSpbmLMXE2cJPS8o0/4gvF0KhAWE8Ab0LznqWyleeWO/T5nksLNv/H
   A==;
X-CSE-ConnectionGUID: /n8Bow6sTuuoG1HsMh/p9A==
X-CSE-MsgGUID: x1y/SlcUTZGoh5+zmq+mOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29467604"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29467604"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 01:42:44 -0700
X-CSE-ConnectionGUID: /eanFjL/RUqD1EfLf0UTUg==
X-CSE-MsgGUID: kv7ZBU7PQZekXfGw1bY4fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="82363703"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 28 Oct 2024 01:42:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5LKj-000cDY-0T;
	Mon, 28 Oct 2024 08:42:41 +0000
Date: Mon, 28 Oct 2024 16:42:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 12dd12821f1eb2755643914df2cc900c5e8c9d12
Message-ID: <202410281619.evviDlvJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 12dd12821f1eb2755643914df2cc900c5e8c9d12  PCI: dwc: endpoint: Clear outbound address on unmap

elapsed time: 726m

configs tested: 156
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.2.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                         s5pv210_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241028    gcc-12
i386        buildonly-randconfig-002-20241028    clang-19
i386        buildonly-randconfig-003-20241028    clang-19
i386        buildonly-randconfig-004-20241028    clang-19
i386        buildonly-randconfig-005-20241028    clang-19
i386        buildonly-randconfig-006-20241028    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241028    clang-19
i386                  randconfig-002-20241028    gcc-12
i386                  randconfig-003-20241028    gcc-12
i386                  randconfig-004-20241028    clang-19
i386                  randconfig-005-20241028    clang-19
i386                  randconfig-006-20241028    clang-19
i386                  randconfig-011-20241028    gcc-11
i386                  randconfig-012-20241028    clang-19
i386                  randconfig-013-20241028    clang-19
i386                  randconfig-014-20241028    clang-19
i386                  randconfig-015-20241028    gcc-12
i386                  randconfig-016-20241028    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    clang-20
m68k                        m5407c3_defconfig    clang-20
m68k                            q40_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    clang-20
mips                        bcm63xx_defconfig    clang-20
mips                   sb1250_swarm_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     ksi8560_defconfig    gcc-13.2.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         apsh4a3a_defconfig    gcc-13.2.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    clang-20
sh                            migor_defconfig    clang-20
sh                          rsk7264_defconfig    clang-20
sh                          sdk7780_defconfig    clang-20
sh                          sdk7786_defconfig    gcc-13.2.0
sh                           se7206_defconfig    gcc-13.2.0
sh                           se7343_defconfig    clang-20
sh                           se7343_defconfig    gcc-13.2.0
sh                   sh7770_generic_defconfig    gcc-13.2.0
sh                        sh7785lcr_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-13.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241028    gcc-12
x86_64      buildonly-randconfig-002-20241028    gcc-12
x86_64      buildonly-randconfig-003-20241028    gcc-12
x86_64      buildonly-randconfig-004-20241028    gcc-12
x86_64      buildonly-randconfig-005-20241028    gcc-12
x86_64      buildonly-randconfig-006-20241028    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241028    gcc-12
x86_64                randconfig-002-20241028    gcc-12
x86_64                randconfig-003-20241028    gcc-12
x86_64                randconfig-004-20241028    gcc-12
x86_64                randconfig-005-20241028    gcc-12
x86_64                randconfig-006-20241028    gcc-12
x86_64                randconfig-011-20241028    gcc-12
x86_64                randconfig-012-20241028    gcc-12
x86_64                randconfig-013-20241028    gcc-12
x86_64                randconfig-014-20241028    gcc-12
x86_64                randconfig-015-20241028    gcc-12
x86_64                randconfig-016-20241028    gcc-12
x86_64                randconfig-071-20241028    gcc-12
x86_64                randconfig-072-20241028    gcc-12
x86_64                randconfig-073-20241028    gcc-12
x86_64                randconfig-074-20241028    gcc-12
x86_64                randconfig-075-20241028    gcc-12
x86_64                randconfig-076-20241028    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

