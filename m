Return-Path: <linux-pci+bounces-44284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F535D04042
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3904F301CA15
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687AE25F797;
	Thu,  8 Jan 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBEU8FHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00C50096B
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886857; cv=none; b=G+8Nf6mPMyU1W5+clNnnzkkx2Ejm5QJZNVOSCYzWtrOfEhIxF/z5WWpoqKXrcmHvqFRMb3P6Obnhlxp/VmiLIzoU7nQgiTNNHWS6VhETvmJB7ZJqXAxk6m2IKEVkaNncBnDN5/sS7/+HBlHNK5aiOhprlNVS1FtQx7udTeNb4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886857; c=relaxed/simple;
	bh=9Fi24xt7VJ7oslwng0uLAc5uAII/9UxE1v41ql9ffew=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jbnA4IWTy4EzJ8zdRfCi3dKqllUvKaV7vrq0Tt4Q6Nrua2a7mmKTKcaNUqMNj9+M4NexrRsjFgaEqjAyHNk93e1TS4qiMFW2ZrrMH3MemJZJpkyCAEB5cHk0/ekcCheuLy68nHYUs4P/Q454QlfWP3EOmNQ8g8BhKqIfNW5S8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBEU8FHo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767886855; x=1799422855;
  h=date:from:to:cc:subject:message-id;
  bh=9Fi24xt7VJ7oslwng0uLAc5uAII/9UxE1v41ql9ffew=;
  b=cBEU8FHocY/usPFmkMgRn59GIBxbr32Ee1YX9CUGpXCMuP+iGc2CPaLA
   0sWpucVHl5n3Asvzr+xTUDY7y7TO2WUJRt74Z7QBw554lbxwRJXfSuN0e
   87N6CFUPfatMZxy26TbWGBAnP/sC1oGDQcoq7fPZd9f8XgEhmca6Zn+H8
   EJue45m++0Bo6KyrIOgGns5msxGKfGS0Ft5FydP9gTDzIs9CP/PQipVX1
   pSGrK++/r2RaA6HyEOQFsBFCieTTofeBErpOsrKppVR7Jj71KgbAtHBJ0
   rLTrqX515LKnsvJK9jUFutzrX8XybHqEYdkYlM9SZHFKt5OPrt1h+AFHX
   A==;
X-CSE-ConnectionGUID: gxlxpKPtRy6djQw8qJIZ+g==
X-CSE-MsgGUID: I08LiCU5QqGPNWjF2GSAvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80631056"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="80631056"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 07:40:55 -0800
X-CSE-ConnectionGUID: JeyG2kDUQYGXrJVUeAVzlw==
X-CSE-MsgGUID: 93e5Gio/Q7KJg6dNmuVwgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="208297196"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Jan 2026 07:40:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vds83-000000004u4-2WiQ;
	Thu, 08 Jan 2026 15:40:51 +0000
Date: Thu, 08 Jan 2026 23:40:40 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 407cc7ff3e99f6bca9b4ca2561d3f9e7192652fe
Message-ID: <202601082332.9oF5hr1F-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 407cc7ff3e99f6bca9b4ca2561d3f9e7192652fe  dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible

elapsed time: 1603m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260107    gcc-14.3.0
arc                   randconfig-002-20260107    gcc-8.5.0
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    clang-22
arm                   randconfig-001-20260107    gcc-10.5.0
arm                   randconfig-002-20260107    clang-22
arm                   randconfig-003-20260107    clang-22
arm                   randconfig-004-20260107    gcc-10.5.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260107    clang-22
arm64                 randconfig-002-20260107    clang-22
arm64                 randconfig-003-20260107    gcc-8.5.0
arm64                 randconfig-004-20260107    clang-22
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260107    gcc-15.1.0
csky                  randconfig-002-20260107    gcc-9.5.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260107    clang-22
hexagon               randconfig-002-20260107    clang-22
i386        buildonly-randconfig-001-20260107    gcc-14
i386        buildonly-randconfig-002-20260107    gcc-14
i386        buildonly-randconfig-003-20260107    clang-20
i386        buildonly-randconfig-004-20260107    gcc-14
i386        buildonly-randconfig-005-20260107    clang-20
i386        buildonly-randconfig-006-20260107    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260107    gcc-14
i386                  randconfig-002-20260107    gcc-14
i386                  randconfig-003-20260107    gcc-14
i386                  randconfig-004-20260107    gcc-14
i386                  randconfig-005-20260107    gcc-14
i386                  randconfig-006-20260107    gcc-14
i386                  randconfig-007-20260107    clang-20
i386                  randconfig-011-20260107    gcc-13
i386                  randconfig-012-20260107    gcc-14
i386                  randconfig-013-20260107    clang-20
i386                  randconfig-014-20260107    gcc-14
i386                  randconfig-015-20260107    clang-20
i386                  randconfig-016-20260107    clang-20
i386                  randconfig-017-20260107    clang-20
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260107    gcc-15.1.0
loongarch             randconfig-002-20260107    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                     loongson2k_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-22
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260107    gcc-8.5.0
nios2                 randconfig-002-20260107    gcc-8.5.0
openrisc                            defconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260107    gcc-8.5.0
parisc                randconfig-002-20260107    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc               randconfig-001-20260107    clang-22
powerpc               randconfig-002-20260107    gcc-8.5.0
powerpc64             randconfig-001-20260107    gcc-14.3.0
powerpc64             randconfig-002-20260107    clang-22
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260107    clang-22
riscv                 randconfig-002-20260107    gcc-9.5.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260107    clang-22
s390                  randconfig-002-20260107    clang-22
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20260107    gcc-12.5.0
sh                    randconfig-002-20260107    gcc-12.5.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260107    gcc-8.5.0
sparc                 randconfig-002-20260107    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260107    clang-22
sparc64               randconfig-002-20260107    gcc-10.5.0
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260107    clang-16
um                    randconfig-002-20260107    clang-22
um                           x86_64_defconfig    clang-22
x86_64      buildonly-randconfig-001-20260107    gcc-14
x86_64      buildonly-randconfig-002-20260107    gcc-14
x86_64      buildonly-randconfig-003-20260107    gcc-14
x86_64      buildonly-randconfig-004-20260107    clang-20
x86_64      buildonly-randconfig-005-20260107    gcc-14
x86_64      buildonly-randconfig-006-20260107    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260107    clang-20
x86_64                randconfig-002-20260107    clang-20
x86_64                randconfig-003-20260107    clang-20
x86_64                randconfig-004-20260107    gcc-13
x86_64                randconfig-005-20260107    clang-20
x86_64                randconfig-006-20260107    clang-20
x86_64                randconfig-011-20260107    gcc-12
x86_64                randconfig-012-20260107    gcc-14
x86_64                randconfig-013-20260107    clang-20
x86_64                randconfig-014-20260107    clang-20
x86_64                randconfig-015-20260107    clang-20
x86_64                randconfig-016-20260107    clang-20
x86_64                randconfig-071-20260107    gcc-14
x86_64                randconfig-072-20260107    clang-20
x86_64                randconfig-073-20260107    gcc-14
x86_64                randconfig-074-20260107    gcc-14
x86_64                randconfig-075-20260107    clang-20
x86_64                randconfig-076-20260107    gcc-14
xtensa                randconfig-001-20260107    gcc-8.5.0
xtensa                randconfig-002-20260107    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

