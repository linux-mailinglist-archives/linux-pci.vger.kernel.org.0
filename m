Return-Path: <linux-pci+bounces-42096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FBC87FDB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 04:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39A74EC0E7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 03:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D98F4A;
	Wed, 26 Nov 2025 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rz0oJcBx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2FC30E857
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129032; cv=none; b=lSayZnE1RczZAmNNO1UmdMz8H13tfPcymgM2gjyJ/O5dzjojNpFHxsSpYTzEjwo76ein7PIUHx8xFrDov29qLKRO5mvV1f5/dVhH1kBs53wxjPawj4a1c56S764+NF4dLX5R/sBj7hCF6Hb/IMEWOq31bttdSUCjVR4jWRNTKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129032; c=relaxed/simple;
	bh=2eUxMEJp+6wwq362R0GKfeceJXZDFMOsCfomHpNVI/0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FhDArSs7tPv4bRWZNCiGzPceyohrYzFTjJ8lXmzx2/Pejhim0vHNgr2+PO+Mr/cQCn40CqpiR6n6bD+Tazj8ER7snb5UJJRjStS30G5yxUPjvB11pyxo2Zdbz9QMyUkzd+QWmRpjZU9fyG8qvzj4QVMY+4hA26JXK6DEb4qQOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rz0oJcBx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764129031; x=1795665031;
  h=date:from:to:cc:subject:message-id;
  bh=2eUxMEJp+6wwq362R0GKfeceJXZDFMOsCfomHpNVI/0=;
  b=Rz0oJcBxkG3M6JU0oHhDUXRdCJ49SDZZmOj5CLxD/4A6z2p5+qgHldwa
   +j0Dz8vnHYHs3OkcxnwG+XZcLqUaL9tZImNj6k2oHZ4bYIt5g1Ffj1J5M
   beC8wsbMLfw1Hdtj31OXRAw6zzWTYyXbJEd5hBS5FYPqqTvJw9QeHfemR
   UNu+sgZ8aonZerzR55J0Sy+rqln5Sj8Imi4afje3XWAYU1+7AE7oh2T/A
   JpmDR8T6CH2HzvXFU7nZDFwpIZQ3lVnStqT7FW869uE//kQsQm5LUEzof
   CTXX+s7S4yW2najMmhA2nclAoJumA0QMFZpRq4PJEALcRVcJPrWfgCTZE
   w==;
X-CSE-ConnectionGUID: HCoC8U+ITgOsvx6favscEw==
X-CSE-MsgGUID: 9XNzZqMWQ5iwo82IUAfnaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77632503"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="77632503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 19:50:30 -0800
X-CSE-ConnectionGUID: pt+wE2kLTgSffQ778UUmAw==
X-CSE-MsgGUID: CLAV2vmVR66Ks/0SxDX7OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192845351"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2025 19:50:29 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO6Xy-000000002Sn-3b6V;
	Wed, 26 Nov 2025 03:50:26 +0000
Date: Wed, 26 Nov 2025 11:50:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 48f014356698a3525959a9eb343dc67b5a5c6842
Message-ID: <202511261113.SgmWKGhf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 48f014356698a3525959a9eb343dc67b5a5c6842  PCI: Validate pci_rebar_size_supported() input

elapsed time: 1686m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251125    gcc-9.5.0
arc                   randconfig-002-20251125    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251125    clang-22
arm                   randconfig-002-20251125    gcc-10.5.0
arm                   randconfig-003-20251125    gcc-10.5.0
arm                   randconfig-004-20251125    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251125    gcc-11.5.0
arm64                 randconfig-002-20251125    gcc-13.4.0
arm64                 randconfig-003-20251125    gcc-8.5.0
arm64                 randconfig-004-20251125    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251125    gcc-11.5.0
csky                  randconfig-002-20251125    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251125    clang-19
hexagon               randconfig-002-20251125    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251126    clang-20
i386        buildonly-randconfig-002-20251126    gcc-14
i386        buildonly-randconfig-003-20251126    clang-20
i386        buildonly-randconfig-004-20251126    clang-20
i386        buildonly-randconfig-005-20251126    clang-20
i386        buildonly-randconfig-006-20251126    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251125    gcc-12
i386                  randconfig-002-20251125    gcc-14
i386                  randconfig-003-20251125    gcc-14
i386                  randconfig-004-20251125    gcc-14
i386                  randconfig-005-20251125    gcc-14
i386                  randconfig-006-20251125    gcc-14
i386                  randconfig-007-20251125    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251125    gcc-15.1.0
loongarch             randconfig-002-20251125    gcc-12.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251125    gcc-8.5.0
nios2                 randconfig-002-20251125    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251125    gcc-13.4.0
parisc                randconfig-002-20251125    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251125    clang-19
powerpc               randconfig-002-20251125    gcc-8.5.0
powerpc64             randconfig-001-20251125    clang-16
powerpc64             randconfig-002-20251125    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251125    gcc-8.5.0
riscv                 randconfig-002-20251125    gcc-13.4.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251125    gcc-8.5.0
s390                  randconfig-002-20251125    gcc-14.3.0
s390                       zfcpdump_defconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251125    gcc-15.1.0
sh                    randconfig-002-20251125    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251125    gcc-14.3.0
sparc                 randconfig-002-20251125    gcc-13.4.0
sparc64                          alldefconfig    gcc-15.1.0
sparc64               randconfig-001-20251125    clang-22
sparc64               randconfig-002-20251125    gcc-8.5.0
um                                allnoconfig    clang-22
um                    randconfig-001-20251125    clang-22
um                    randconfig-002-20251125    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251126    clang-20
x86_64      buildonly-randconfig-002-20251126    gcc-14
x86_64      buildonly-randconfig-003-20251126    clang-20
x86_64      buildonly-randconfig-004-20251126    clang-20
x86_64      buildonly-randconfig-005-20251126    gcc-14
x86_64      buildonly-randconfig-006-20251126    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-013-20251126    gcc-14
x86_64                randconfig-071-20251126    clang-20
x86_64                randconfig-072-20251126    gcc-14
x86_64                randconfig-073-20251126    clang-20
x86_64                randconfig-074-20251126    gcc-14
x86_64                randconfig-075-20251126    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251125    gcc-8.5.0
xtensa                randconfig-002-20251125    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

