Return-Path: <linux-pci+bounces-23075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A3A5590C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 22:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95B23B2DE1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC1B206F37;
	Thu,  6 Mar 2025 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3SolubG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3837DDA8
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297600; cv=none; b=fes+fOgXyzR6geNnvuGZiBXH4329La1ZzqpNyV2qQADyI4xw7MGR86A1ltyP4ihdRMRIxG7Q/2EGrPH2a+87sS2Vb0cTRU0i3c38Is2RWoKd99VD4S56ti7HlFn1OQymDyIF/nZNA0s5wpsXmkAsp65ObI5954XUM6NawNVMhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297600; c=relaxed/simple;
	bh=C2g3APSxGmjfGB5zxN3heM8cjOQya3/6WSZT50jwlUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a54+t1Uvb8EMBYdsUs27SjnS//LxuWgtgG9h2yt+h8jY3NuYyTKYqz3pWWFTTVEl4b1C+/9oRkTKLm4ix/MFOErEK9tXYI0TqmYKlALjYrQRlCHrguASav22noClSDxDON0W509l32Svu2m/K+WTyqbH8ZApbi5EUYGpuyJQVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3SolubG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741297598; x=1772833598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C2g3APSxGmjfGB5zxN3heM8cjOQya3/6WSZT50jwlUU=;
  b=G3SolubGf6rC95V2ivLXAUxp9WYk7W1gbSj7xQ/1bLOku8Qwr1rqLAu7
   9YkDS8TMjvakVzMmG/xP9UTvfXvQangp7F4QeFuRWJ7ZJKZ4NQVhHN5bi
   BoyFVoW/VDct5eBCkB59ifp9fBWCUdDIhMu/t/MRlvHDSzKkbjgpy1XbA
   TBsmmzurwypCMT62l98MN92K1ozfO3+LdwPNL+/3/ONdv4RXDkV+Hk31/
   LonmSX6EZJQhMSdRyvHBzcBQN+MVnd3awF2txHDBLGVhLpt0Nc33zQZ8q
   bHVD6IQgS3DFppDCWS8n+bMwriFlwRBUOEU++xUuYGEeQ94mZ3u+5GHVc
   w==;
X-CSE-ConnectionGUID: Vtf896BkSy6oWuAcjun7AA==
X-CSE-MsgGUID: T2WMGwUYTrice3gBJJe7ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53320604"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="53320604"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:46:38 -0800
X-CSE-ConnectionGUID: jlbqU7gKSn2mTqzrJ0WWxw==
X-CSE-MsgGUID: oVE+fz6aRRK516t/umOTEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="124078154"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Mar 2025 13:46:37 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqJ35-000Neu-0F;
	Thu, 06 Mar 2025 21:46:35 +0000
Date: Fri, 07 Mar 2025 05:46:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 98e87cc501c1018f11815e3e2fb20e4801243031
Message-ID: <202503070520.qvinkAdf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 98e87cc501c1018f11815e3e2fb20e4801243031  PCI: mediatek-gen3: Fix inconsistent indentation

elapsed time: 1448m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250306    gcc-13.2.0
arc                  randconfig-002-20250306    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250306    gcc-14.2.0
arm                  randconfig-002-20250306    gcc-14.2.0
arm                  randconfig-003-20250306    gcc-14.2.0
arm                  randconfig-004-20250306    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250306    gcc-14.2.0
arm64                randconfig-002-20250306    gcc-14.2.0
arm64                randconfig-003-20250306    gcc-14.2.0
arm64                randconfig-004-20250306    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250306    gcc-14.2.0
csky                 randconfig-002-20250306    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250306    clang-21
hexagon              randconfig-002-20250306    clang-19
i386       buildonly-randconfig-001-20250306    clang-19
i386       buildonly-randconfig-002-20250306    clang-19
i386       buildonly-randconfig-003-20250306    clang-19
i386       buildonly-randconfig-004-20250306    gcc-12
i386       buildonly-randconfig-005-20250306    gcc-12
i386       buildonly-randconfig-006-20250306    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250306    gcc-14.2.0
loongarch            randconfig-002-20250306    gcc-14.2.0
m68k                      m5275evb_defconfig    gcc-14.2.0
m68k                       m5407c3_defconfig    gcc-14.2.0
nios2                           alldefconfig    gcc-14.2.0
nios2                randconfig-001-20250306    gcc-14.2.0
nios2                randconfig-002-20250306    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250306    gcc-14.2.0
parisc               randconfig-002-20250306    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250306    clang-21
powerpc              randconfig-002-20250306    clang-18
powerpc              randconfig-003-20250306    gcc-14.2.0
powerpc64            randconfig-001-20250306    clang-18
powerpc64            randconfig-002-20250306    clang-21
powerpc64            randconfig-003-20250306    clang-18
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250306    clang-18
riscv                randconfig-002-20250306    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250306    gcc-14.2.0
s390                 randconfig-002-20250306    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250306    gcc-14.2.0
sh                   randconfig-002-20250306    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250306    gcc-14.2.0
sparc                randconfig-002-20250306    gcc-14.2.0
sparc64              randconfig-001-20250306    gcc-14.2.0
sparc64              randconfig-002-20250306    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250306    gcc-12
um                   randconfig-002-20250306    clang-16
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250306    gcc-11
x86_64     buildonly-randconfig-002-20250306    clang-19
x86_64     buildonly-randconfig-003-20250306    clang-19
x86_64     buildonly-randconfig-004-20250306    clang-19
x86_64     buildonly-randconfig-005-20250306    clang-19
x86_64     buildonly-randconfig-006-20250306    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250306    gcc-14.2.0
xtensa               randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

