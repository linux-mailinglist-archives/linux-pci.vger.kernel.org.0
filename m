Return-Path: <linux-pci+bounces-20118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA18A16222
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 15:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABB71885FAF
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD42F3E;
	Sun, 19 Jan 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mj+LXnE1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CE7FD
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737296152; cv=none; b=PHjI6wEPw7NAheygN/wozWlAg5MXLk1FedLzjFoFGr439e0zJQgTR58/D9MUHVr/Ou6AD5Ic5uD6wUSyqWd31k+zlSbNh6KccfRa65w6aXshIp8289aWZRfccWaMEtA7vSjIJ4pFPFTyBHLLcg5nBKNs8VxS6EWNBUf3RScntwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737296152; c=relaxed/simple;
	bh=P64ZrqxKDel2l8UeqoRcrrM8x96veJpa79CCpNY7aiU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fuZuT9zvKyC1EsV03C5t7xonbKcq5FFHes57PDggzLE+uNqrYHwxX1QqCwiXnetL5AHndsQTVnraOwFyFjlKitkuEEdzC4itww5Sitgnr3xDaGxwG7Le2JMgfHBl8yuNMjSLM9mo64ipFAazxE4weTnQPSfWKZRtCMFP8xZ5PLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mj+LXnE1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737296150; x=1768832150;
  h=date:from:to:cc:subject:message-id;
  bh=P64ZrqxKDel2l8UeqoRcrrM8x96veJpa79CCpNY7aiU=;
  b=mj+LXnE1cet4BMX4sD0uJPXtYei9QW9s7LTs0UelxJ8tbrDqQtb9bFeW
   EMsowTIzWPIIDBgY7LTEDjjSK8IJK/JXG+ej6nVRfss1wfLtENcIuqkZm
   f47HBfOpJZD4gyV8yOvMbbErwY5bSPBog8kM7JDKn3KLyKp+K3tOx5nMA
   CS8uMr2Ym23W5PwAazgg6w6t95z7WrMiHu5dXSgHuRL3Ru7BszdRgE1wU
   S9UyHvISQj2uzsnTyE8DHxyuEq2zkj8lYVVyfxN9AHrHPJlcaKYbK3fvc
   R9f94diSRqsQuXCdmos5OMsEAerwtJb+2ejqwhAcPGJy0PPZoTrzO+Tll
   A==;
X-CSE-ConnectionGUID: P6Nd9Qv8SRWUkVShEtr90Q==
X-CSE-MsgGUID: 9yS/LVWfTwKOmFG7/7rAqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="63038059"
X-IronPort-AV: E=Sophos;i="6.13,217,1732608000"; 
   d="scan'208";a="63038059"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 06:15:50 -0800
X-CSE-ConnectionGUID: 7tMYEsP3Q922j6Sb/W9bNQ==
X-CSE-MsgGUID: 7jom+rkZQd2WvWJ3gNmFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,217,1732608000"; 
   d="scan'208";a="106272125"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Jan 2025 06:15:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZW5a-000VW3-0o;
	Sun, 19 Jan 2025 14:15:46 +0000
Date: Sun, 19 Jan 2025 22:14:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/microchip] BUILD SUCCESS
 5b637049a55f53fcd1a9a7ad8ef3c608b2169c10
Message-ID: <202501192242.iL28DBc9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/microchip
branch HEAD: 5b637049a55f53fcd1a9a7ad8ef3c608b2169c10  dt-bindings: PCI: microchip,pcie-host: Allow dma-noncoherent

elapsed time: 1024m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250119    gcc-13.2.0
arc                   randconfig-002-20250119    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                   randconfig-001-20250119    gcc-14.2.0
arm                   randconfig-002-20250119    clang-20
arm                   randconfig-003-20250119    clang-16
arm                   randconfig-004-20250119    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250119    clang-20
arm64                 randconfig-002-20250119    clang-20
arm64                 randconfig-003-20250119    gcc-14.2.0
arm64                 randconfig-004-20250119    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250119    gcc-14.2.0
csky                  randconfig-002-20250119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250119    clang-20
hexagon               randconfig-002-20250119    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250119    clang-19
i386        buildonly-randconfig-002-20250119    gcc-12
i386        buildonly-randconfig-003-20250119    gcc-12
i386        buildonly-randconfig-004-20250119    gcc-12
i386        buildonly-randconfig-005-20250119    clang-19
i386        buildonly-randconfig-006-20250119    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250119    gcc-14.2.0
loongarch             randconfig-002-20250119    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250119    gcc-14.2.0
nios2                 randconfig-002-20250119    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250119    gcc-14.2.0
parisc                randconfig-002-20250119    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      chrp32_defconfig    clang-20
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250119    clang-20
powerpc               randconfig-002-20250119    clang-20
powerpc               randconfig-003-20250119    clang-16
powerpc64             randconfig-001-20250119    clang-18
powerpc64             randconfig-002-20250119    clang-16
powerpc64             randconfig-003-20250119    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250119    gcc-14.2.0
riscv                 randconfig-002-20250119    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250119    clang-20
s390                  randconfig-002-20250119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250119    gcc-14.2.0
sh                    randconfig-002-20250119    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250119    gcc-14.2.0
sparc                 randconfig-002-20250119    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250119    gcc-14.2.0
sparc64               randconfig-002-20250119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250119    clang-18
um                    randconfig-002-20250119    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250119    clang-19
x86_64      buildonly-randconfig-002-20250119    gcc-12
x86_64      buildonly-randconfig-003-20250119    gcc-12
x86_64      buildonly-randconfig-004-20250119    clang-19
x86_64      buildonly-randconfig-005-20250119    gcc-12
x86_64      buildonly-randconfig-006-20250119    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250119    gcc-14.2.0
xtensa                randconfig-002-20250119    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

