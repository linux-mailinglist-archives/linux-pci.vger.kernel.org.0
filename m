Return-Path: <linux-pci+bounces-43656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 265EECDBE5E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E942A300C286
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C31330B34;
	Wed, 24 Dec 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPHqjs99"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6E4086A
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766570819; cv=none; b=UfIoCVeAHKygJG7Xem/5qxCOSDfkKA7epRawL+rq15RYsMVUecp9pwqZt2hDhL3u/xU6LDBnwfOw0T08Q+gBwN5ZxkZcew6/jRXKxWt7+zynyvcVt1zAjaUyY1UT/5kQnpuJjKITSlpp+Fmx68zfNVz05DhBv5TI6i36uQNOyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766570819; c=relaxed/simple;
	bh=9E17KS2fUVMfnIWHw5+f1k7i4604uMZ7c7M4Mv1PXtI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mcQt9xf9vPGMpo0ufoQ8GjCV+dwns0TjZgbcVctkG+gFRnD204SpCMhANeNS3CH5Uv9aUZpx4wu5B26/MafcU5XT0F2rEOkHW/M/PAfooOGWf2ycsmZK0ezN+PwLv9s+mjvmLgWYpDVy8e+M2xrtJTOoWp4x3qMRvccVf3HWq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPHqjs99; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766570818; x=1798106818;
  h=date:from:to:cc:subject:message-id;
  bh=9E17KS2fUVMfnIWHw5+f1k7i4604uMZ7c7M4Mv1PXtI=;
  b=EPHqjs99vPc2/1MjOtkUdgksUpvNPZ/RlZ1MwrP/RhSRxs3PCb8xeQ5u
   R+2IYQPOkcemhYNYU1Srlcy7CA5sNHzikPU6rUPq57pbQr9gHPJsq5eCs
   8ZF6UIPpxU8Q/EyjXHQW0WyE285nViPm3N8tBdG/zxfN9S7mBhnKzzm09
   HVtmGTGep9FDf3hI8HIcXxRYu2v3JgrZQoEmwDzj6lLz7t0lHIOU3v++I
   Qv/YVV4D7QrWJN+zaBtu3mCO6l3ggpKPlBNdB26oMDve6DfZedqaUrrAG
   oFwiXkaowrJUQaKrGupjXBQODBsk/iRvWdgcSnV41c3HfOfVoaIhBJURm
   w==;
X-CSE-ConnectionGUID: Oq5KAtYPTiG/saMcAJR+Qg==
X-CSE-MsgGUID: C6psOsrkSk6K9hX+c5grGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79044802"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="79044802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 02:06:57 -0800
X-CSE-ConnectionGUID: ZHhkpJiEReWa6jxPDL/wwA==
X-CSE-MsgGUID: DwufUKQlSCu1XfDf4GewWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="199127591"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Dec 2025 02:06:55 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYLld-000000002v9-0t88;
	Wed, 24 Dec 2025 10:06:53 +0000
Date: Wed, 24 Dec 2025 18:06:30 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-imx6] BUILD SUCCESS
 d8574ce57d760a958623c8f6bc3c55b5187a7bd7
Message-ID: <202512241826.UDguyc9a-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: d8574ce57d760a958623c8f6bc3c55b5187a7bd7  PCI: imx6: Add external reference clock input mode support

elapsed time: 1290m

configs tested: 206
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251224    gcc-10.5.0
arc                   randconfig-002-20251224    gcc-10.5.0
arm                              alldefconfig    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20251224    gcc-10.5.0
arm                   randconfig-002-20251224    gcc-10.5.0
arm                   randconfig-003-20251224    gcc-10.5.0
arm                   randconfig-004-20251224    gcc-10.5.0
arm                           sama5_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251224    gcc-15.1.0
arm64                 randconfig-002-20251224    gcc-15.1.0
arm64                 randconfig-003-20251224    gcc-15.1.0
arm64                 randconfig-004-20251224    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251224    gcc-15.1.0
csky                  randconfig-002-20251224    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251224    gcc-15.1.0
hexagon               randconfig-002-20251224    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251224    gcc-14
i386        buildonly-randconfig-002-20251224    gcc-14
i386        buildonly-randconfig-003-20251224    gcc-14
i386        buildonly-randconfig-004-20251224    gcc-14
i386        buildonly-randconfig-005-20251224    gcc-14
i386        buildonly-randconfig-006-20251224    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251224    clang-20
i386                  randconfig-002-20251224    clang-20
i386                  randconfig-003-20251224    clang-20
i386                  randconfig-004-20251224    clang-20
i386                  randconfig-005-20251224    clang-20
i386                  randconfig-006-20251224    clang-20
i386                  randconfig-007-20251224    clang-20
i386                  randconfig-011-20251224    clang-20
i386                  randconfig-012-20251224    clang-20
i386                  randconfig-013-20251224    clang-20
i386                  randconfig-014-20251224    clang-20
i386                  randconfig-015-20251224    clang-20
i386                  randconfig-016-20251224    clang-20
i386                  randconfig-017-20251224    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251224    gcc-15.1.0
loongarch             randconfig-002-20251224    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251224    gcc-15.1.0
nios2                 randconfig-002-20251224    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251224    clang-22
parisc                randconfig-001-20251224    gcc-8.5.0
parisc                randconfig-002-20251224    clang-22
parisc                randconfig-002-20251224    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251224    clang-22
powerpc               randconfig-002-20251224    clang-22
powerpc                     skiroot_defconfig    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20251224    clang-22
powerpc64             randconfig-001-20251224    gcc-8.5.0
powerpc64             randconfig-002-20251224    clang-22
powerpc64             randconfig-002-20251224    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251224    gcc-15.1.0
riscv                 randconfig-002-20251224    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251224    gcc-15.1.0
s390                  randconfig-002-20251224    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    clang-22
sh                    randconfig-001-20251224    gcc-15.1.0
sh                    randconfig-002-20251224    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251224    gcc-14
sparc                 randconfig-002-20251224    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251224    gcc-14
sparc64               randconfig-002-20251224    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251224    gcc-14
um                    randconfig-002-20251224    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251224    gcc-14
x86_64      buildonly-randconfig-002-20251224    gcc-14
x86_64      buildonly-randconfig-003-20251224    gcc-14
x86_64      buildonly-randconfig-004-20251224    gcc-14
x86_64      buildonly-randconfig-005-20251224    gcc-14
x86_64      buildonly-randconfig-006-20251224    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251224    gcc-14
x86_64                randconfig-002-20251224    gcc-14
x86_64                randconfig-003-20251224    gcc-14
x86_64                randconfig-004-20251224    gcc-14
x86_64                randconfig-005-20251224    gcc-14
x86_64                randconfig-006-20251224    gcc-14
x86_64                randconfig-011-20251224    gcc-14
x86_64                randconfig-012-20251224    gcc-14
x86_64                randconfig-013-20251224    gcc-14
x86_64                randconfig-014-20251224    gcc-14
x86_64                randconfig-015-20251224    gcc-14
x86_64                randconfig-016-20251224    gcc-14
x86_64                randconfig-071-20251224    clang-20
x86_64                randconfig-072-20251224    clang-20
x86_64                randconfig-073-20251224    clang-20
x86_64                randconfig-074-20251224    clang-20
x86_64                randconfig-075-20251224    clang-20
x86_64                randconfig-076-20251224    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251224    gcc-14
xtensa                randconfig-002-20251224    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

