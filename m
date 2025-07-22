Return-Path: <linux-pci+bounces-32694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97270B0CFE9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 04:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4894F1AA7956
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 02:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CEA154BE2;
	Tue, 22 Jul 2025 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPcWu6oI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E53C463
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153078; cv=none; b=DPA7CbEFYJ8Pk5qE7uxp9dnryc7dk+R694hFQrtR6Rmo/KCnfEKGmaFgSHBiysgV/J+269zIuXwXWXP+mmf7pWsnjvICgY1v+xi0KVjbOHLBUdYeO+iC7Futd/5HhQI3za6LztE71LEyiBU1QqQMSqR0qS3s89P6gek2cg7pgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153078; c=relaxed/simple;
	bh=A2FH+NIDekvK3r//N5ipbGBUnQNT3RPBY3wIELrQ3Eo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HcP9m6d/eXslXpjt18pYQE98t8IrMFLPv8Y9ZcaCzmmzl3vp5h+guyNLSMazn5Nj9kOH7Q1reCUPA5IoPiuJT2y9G4ueujCmaFdXUjiIIdxCfATzvUHYU6pYPrQhuXOh21QgOb5Q+DS4NhxT/zX2m9jzKVck3+uFdH8LxEk6VRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPcWu6oI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753153076; x=1784689076;
  h=date:from:to:cc:subject:message-id;
  bh=A2FH+NIDekvK3r//N5ipbGBUnQNT3RPBY3wIELrQ3Eo=;
  b=cPcWu6oI+cMEFi6DM98oVd7XMHs6PSo0MUb7rY0ZactZJeHV0xYof8DX
   3ILQjlNEejvxGLxERgVbaswfKuc2FOn897Mr8/Jyk+t8hs6d40jFNJh/h
   Sh5buiTvf3+JB6ia9bsD5IGa/hkmLWGjnY6HaR4s3aWprGOGNQlkY2jqn
   gDYKnxOo56ifkf600VJp+ptomHZTysHF96x+3YQBU/mkMmhu2DVwCpQBC
   GB3BSQBhn7XLWgo9Mfd/8HFzqVYxqcr3ZMhD41TAlk3E1x1ubxpR9J5lP
   U6oBtM/Y4PBqeEgOKS13TRpgpz35E7wnyBq8ic0PfWZJwPNvY5PWWXCU4
   Q==;
X-CSE-ConnectionGUID: Kj+IP+f6SzKwOB8PXyHnog==
X-CSE-MsgGUID: JUS59l+yQLOehqcXXUxTaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55342700"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55342700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 19:57:56 -0700
X-CSE-ConnectionGUID: k3AttqOJR82OpctkPRGqyg==
X-CSE-MsgGUID: 40AxgYrATNWJVi8uMrFedw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="196087098"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Jul 2025 19:57:55 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ue3CS-000HNR-2p;
	Tue, 22 Jul 2025 02:57:52 +0000
Date: Tue, 22 Jul 2025 10:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 234b9258c6907cabbb2594ee366286d35ff056f3
Message-ID: <202507221042.tO5wagaQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 234b9258c6907cabbb2594ee366286d35ff056f3  PCI: imx6: Add LUT configuration for MSI/IOMMU in Endpoint mode

elapsed time: 757m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250721    gcc-11.5.0
arc                   randconfig-002-20250721    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20250721    clang-22
arm                   randconfig-002-20250721    gcc-13.4.0
arm                   randconfig-003-20250721    gcc-15.1.0
arm                   randconfig-004-20250721    clang-22
arm                        spear6xx_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250721    clang-22
arm64                 randconfig-002-20250721    clang-20
arm64                 randconfig-003-20250721    gcc-13.4.0
arm64                 randconfig-004-20250721    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250721    gcc-15.1.0
csky                  randconfig-002-20250721    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250721    clang-22
hexagon               randconfig-002-20250721    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250721    clang-20
i386        buildonly-randconfig-002-20250721    clang-20
i386        buildonly-randconfig-003-20250721    gcc-12
i386        buildonly-randconfig-004-20250721    gcc-12
i386        buildonly-randconfig-005-20250721    clang-20
i386        buildonly-randconfig-006-20250721    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250721    clang-18
loongarch             randconfig-002-20250721    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250721    gcc-8.5.0
nios2                 randconfig-002-20250721    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250721    gcc-15.1.0
parisc                randconfig-002-20250721    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250721    gcc-12.5.0
powerpc               randconfig-002-20250721    gcc-10.5.0
powerpc               randconfig-003-20250721    gcc-11.5.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250721    clang-22
powerpc64             randconfig-002-20250721    clang-22
powerpc64             randconfig-003-20250721    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250721    clang-22
riscv                 randconfig-002-20250721    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250721    clang-22
s390                  randconfig-002-20250721    clang-20
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250721    gcc-15.1.0
sh                    randconfig-002-20250721    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250721    gcc-15.1.0
sparc                 randconfig-002-20250721    gcc-13.4.0
sparc64               randconfig-001-20250721    clang-20
sparc64               randconfig-002-20250721    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250721    gcc-12
um                    randconfig-002-20250721    clang-17
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250721    clang-20
x86_64      buildonly-randconfig-002-20250721    gcc-12
x86_64      buildonly-randconfig-003-20250721    gcc-12
x86_64      buildonly-randconfig-004-20250721    gcc-12
x86_64      buildonly-randconfig-005-20250721    clang-20
x86_64      buildonly-randconfig-006-20250721    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250721    gcc-11.5.0
xtensa                randconfig-002-20250721    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

