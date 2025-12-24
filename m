Return-Path: <linux-pci+bounces-43637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F264CDB5B0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 05:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F8413026B13
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 04:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7B2F0C78;
	Wed, 24 Dec 2025 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdMXGBS4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A12F90DB
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766551989; cv=none; b=PrUk1tKiG6BZol9lEut7uF1Vkf//FH71eXQHZX5L1jQrW+iuIkShEqRSzo2+OrsxU6XdGSAFQVjgmy13sDNzvv/NWV84xFN91XBhRc9Omsmi5IjdYlSj0ojFXLWOTrChjMbTZFyaxGbcifRqO7f9m/F7RkPFolPCm2MiLjOekcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766551989; c=relaxed/simple;
	bh=XOQ0/2P6rBYp7+I4tW4BT8RA11hj8AApLVIAfDOVaeA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FtgVyRVBKXEOoPC9HVvqArh9iQEN/CT2XacoDeWkLMHREgVP8m6Uo1l978BpSpv2i/GlcST/1IeK/76OGso63cALcDpLubbxx91txrXkG6vBhG6w6dqfu37sL0UzjiGx7/Qnfz6tHRRtKg4/ElAvDxviKFj8BDTvownVm7KOvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdMXGBS4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766551983; x=1798087983;
  h=date:from:to:cc:subject:message-id;
  bh=XOQ0/2P6rBYp7+I4tW4BT8RA11hj8AApLVIAfDOVaeA=;
  b=jdMXGBS4TZ1DegGTPSaDVow9PotE2HY6Nk//s1mgCbBBJMJckAhNSTni
   WGrxZzhMIQ68LbvoWNJePkaUievJ4fJ8cgStltUqAyKQhLYPKJjPSh/7i
   gAbpcOPOu5PgBeVvtnkw4mBX63wcsIvRQkRKNyMhDdczr76JIva8y7SPH
   lQ56ZKoIv3dAlmGEwvZMNKoVak8fRvaDGMw/gfuEki0NhNlf7h5EqLFq8
   VPDRwH+Wj89bSDhQV11upTBITQY4IHH1+8a8Si4r943lGXuxK6nfyaFZT
   eTxoGUYe8k3JM9N+qhbBwRmp1Atq6P6DFjadWaLpIe2GDkUBTVuDk/O4s
   A==;
X-CSE-ConnectionGUID: IJYcuL7NQfyrO28Ifro0Zw==
X-CSE-MsgGUID: WAvurl/MQ2WiIfZxKacNKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="93868121"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="93868121"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 20:52:57 -0800
X-CSE-ConnectionGUID: 0KYVOvjYT4G74cHYbW1wuA==
X-CSE-MsgGUID: Vo9UOFZqTbyEMXFg9ybFgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="200435931"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 Dec 2025 20:52:56 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYGrl-000000002gn-2Tkl;
	Wed, 24 Dec 2025 04:52:53 +0000
Date: Wed, 24 Dec 2025 12:52:11 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 91f2fb5fe4735c6c99c000857f2e0bd7ebbddb95
Message-ID: <202512241206.zt36FD8W-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 91f2fb5fe4735c6c99c000857f2e0bd7ebbddb95  PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC

elapsed time: 1319m

configs tested: 166
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
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20251223    gcc-8.5.0
arc                   randconfig-002-20251223    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251223    clang-22
arm                   randconfig-002-20251223    gcc-10.5.0
arm                   randconfig-003-20251223    clang-20
arm                   randconfig-004-20251223    gcc-8.5.0
arm                             rpc_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251223    clang-17
arm64                 randconfig-002-20251223    clang-22
arm64                 randconfig-003-20251223    clang-18
arm64                 randconfig-004-20251223    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251223    gcc-11.5.0
csky                  randconfig-002-20251223    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251223    clang-22
hexagon               randconfig-002-20251223    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251224    clang-20
i386        buildonly-randconfig-002-20251224    gcc-14
i386        buildonly-randconfig-003-20251224    clang-20
i386        buildonly-randconfig-004-20251224    gcc-12
i386        buildonly-randconfig-005-20251224    gcc-14
i386        buildonly-randconfig-006-20251224    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251224    gcc-14
i386                  randconfig-002-20251224    gcc-14
i386                  randconfig-003-20251224    gcc-14
i386                  randconfig-004-20251224    gcc-12
i386                  randconfig-005-20251224    clang-20
i386                  randconfig-006-20251224    clang-20
i386                  randconfig-007-20251224    gcc-14
i386                  randconfig-011-20251223    gcc-12
i386                  randconfig-012-20251223    gcc-14
i386                  randconfig-013-20251223    gcc-12
i386                  randconfig-014-20251223    gcc-14
i386                  randconfig-015-20251223    gcc-14
i386                  randconfig-016-20251223    gcc-14
i386                  randconfig-017-20251223    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251223    gcc-15.1.0
loongarch             randconfig-002-20251223    clang-22
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
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251223    gcc-11.5.0
nios2                 randconfig-002-20251223    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251223    gcc-8.5.0
parisc                randconfig-002-20251223    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251223    clang-22
powerpc               randconfig-002-20251223    clang-22
powerpc64             randconfig-001-20251223    clang-17
powerpc64             randconfig-002-20251223    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251223    gcc-8.5.0
riscv                 randconfig-002-20251223    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251223    gcc-14.3.0
s390                  randconfig-002-20251223    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20251223    gcc-10.5.0
sh                    randconfig-002-20251223    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251223    gcc-15.1.0
sparc                 randconfig-002-20251223    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251223    gcc-8.5.0
sparc64               randconfig-002-20251223    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251223    clang-22
um                    randconfig-002-20251223    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251223    clang-20
x86_64      buildonly-randconfig-002-20251223    clang-20
x86_64      buildonly-randconfig-003-20251223    gcc-14
x86_64      buildonly-randconfig-004-20251223    gcc-14
x86_64      buildonly-randconfig-005-20251223    clang-20
x86_64      buildonly-randconfig-006-20251223    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251223    gcc-14
x86_64                randconfig-002-20251223    clang-20
x86_64                randconfig-003-20251223    gcc-14
x86_64                randconfig-004-20251223    clang-20
x86_64                randconfig-005-20251223    gcc-14
x86_64                randconfig-006-20251223    clang-20
x86_64                randconfig-011-20251223    gcc-14
x86_64                randconfig-012-20251223    clang-20
x86_64                randconfig-013-20251223    clang-20
x86_64                randconfig-014-20251223    clang-20
x86_64                randconfig-015-20251223    gcc-14
x86_64                randconfig-016-20251223    gcc-14
x86_64                randconfig-071-20251223    gcc-14
x86_64                randconfig-072-20251223    clang-20
x86_64                randconfig-073-20251223    clang-20
x86_64                randconfig-074-20251223    gcc-14
x86_64                randconfig-075-20251223    gcc-14
x86_64                randconfig-076-20251223    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251223    gcc-8.5.0
xtensa                randconfig-002-20251223    gcc-15.1.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

