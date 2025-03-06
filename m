Return-Path: <linux-pci+bounces-23025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B5A53EDE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 01:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE18616F33F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 00:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43D463D;
	Thu,  6 Mar 2025 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hh65mGzW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5406139D
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219654; cv=none; b=dsVDFK7l52nTwbhormw4pNVXQwk7/dwzaQFRWO1FQbp+1z7W1hxUW8iXBsV+tYb8+vlgx7e/7XfTmS/qTzpXoVm+PR7+xe1HIGGsKMWHqhfDXmfCpA4W9IuUlfMAiN/iRcEBY/cjOjE2jFxn7ERMWgKV/v0Vf7QQumKv2Zrna5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219654; c=relaxed/simple;
	bh=L434WGx7Y1oLeUIrRvzh6iVFOhXS7mzY1rTqUhGBfBk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=knW1aItrkYM5TMlnr6h2lFcXP89OryCIbHhELWctiHdUJkVaaWl9vum7Yd94gEdbPyDvgA6U13Y4TcQjCku4Ffs0Hrf6SGlsOxzAJfCaM+Zytbk9khLqse5Nxt/losdvh/6g4HdJJFitBuJ+ZLXC660eeLBEupn55eGvfnMBGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hh65mGzW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741219654; x=1772755654;
  h=date:from:to:cc:subject:message-id;
  bh=L434WGx7Y1oLeUIrRvzh6iVFOhXS7mzY1rTqUhGBfBk=;
  b=Hh65mGzWLLKdNFM5W5hWP82nvuhZ288viq9+upSUv8jNB28whQ7ko75J
   ndEv4pO9gopxvHCDsiXTyDWy1C+5Ss8jDNizU2b5mw5VpCNi6FbuplPoH
   hF4htb4nPYS2FW9K12foJNn5jqfgUZBMztxBdK06vHeTojwZVHluHpW+2
   TdixbtsRi/0/Ug7rXCyNXVkL4rkZFgljRsHJHNr5b8JCXfrrxmb9w9aRG
   VHF3PVyaJwOvtBf7Iozjons6qiEvZdOYsRk/tMeAfquWH2shNtOeE5ZdC
   EUX8x2d9gNULFRueDiSt9ZRVDroky77XqEWtHsnq8gd6NQwoCC5ApA70Y
   g==;
X-CSE-ConnectionGUID: ME47MIKnSJee1vZSKD/wVQ==
X-CSE-MsgGUID: l9+jFLSRSSei6Yoq9o0tJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45863100"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="45863100"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 16:07:32 -0800
X-CSE-ConnectionGUID: /JHb+nseRpm1H1Txc3G2rw==
X-CSE-MsgGUID: 0o5CvvxkTTGinxumeXdmtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123944101"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 16:07:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpylO-000MLK-32;
	Thu, 06 Mar 2025 00:07:12 +0000
Date: Thu, 06 Mar 2025 08:06:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 9d7db4db19827380e225914618c0c1bf435ed2f5
Message-ID: <202503060804.yx8uUziv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 9d7db4db19827380e225914618c0c1bf435ed2f5  PCI/portdrv: Only disable pciehp interrupts early when needed

elapsed time: 1461m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-004-20250305    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250305    gcc-14.2.0
csky                  randconfig-002-20250305    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250305    clang-21
hexagon               randconfig-002-20250305    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-006-20250305    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250305    gcc-14.2.0
loongarch             randconfig-002-20250305    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250305    gcc-14.2.0
nios2                 randconfig-002-20250305    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250305    gcc-14.2.0
parisc                randconfig-002-20250305    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250305    clang-17
powerpc               randconfig-002-20250305    gcc-14.2.0
powerpc               randconfig-003-20250305    gcc-14.2.0
powerpc64             randconfig-001-20250305    clang-19
powerpc64             randconfig-002-20250305    clang-17
powerpc64             randconfig-003-20250305    clang-19
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-002-20250305    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-002-20250305    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

