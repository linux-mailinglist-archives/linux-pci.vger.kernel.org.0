Return-Path: <linux-pci+bounces-34494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C40B309A0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 00:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320AF620AD5
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D72D47FB;
	Thu, 21 Aug 2025 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8mYnTdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81550A95E
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816733; cv=none; b=rdKEfNxuijEUx9JMfdMdBDhOvnQ/7PoN0KbOcKDrYIinHw6mH5RmYlzSQtWSfLc72AwKTS9ONk4a890FV+Cg21i+f7g6rFpTUBowNINiufYNVWjYCb7AWFLLB8xtjSdxIaZ1qTyALUkRygy7ClN4R3dFo1Zc6liYnsIdmM8vrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816733; c=relaxed/simple;
	bh=PZvuG5pnX0NhJxDp/hyGeft4ywyGwD/BVHby0ZhV9+I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bleUA+CxwBN8kkvZ6Uaz3ZAccdboM6Cyqqv9tq/f6WB4JRTHZMY43HjbpE0yTSq6H3hPi1Vd7HLdlyuasiRL2mV0WUrN3DrjIV/GKiJT6tw/BiED9CNOvotPj8nzvHN7azsDZqOltV3thXWK69VawjV4AmTMsYNdvBgTYNW/Zi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8mYnTdD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755816732; x=1787352732;
  h=date:from:to:cc:subject:message-id;
  bh=PZvuG5pnX0NhJxDp/hyGeft4ywyGwD/BVHby0ZhV9+I=;
  b=T8mYnTdDeY2WkwiT9Tm5tPDUTBm1/PVPnJxor012iokWGNhEXwDSbOif
   lvyC6dniUj+0vIRcpQHMQWacMoCUoY+3ySGXahuAuh+RiH/ADlJGYuSx4
   rDcp2W22z2Pri77hpTRyJXf8GjkNY0Cy3tWgfflSacdkt1IiRlASAa7Ce
   yBQw2fOL6ct83a3qEC45paS+rZFT8RT8fzD0Jf9sG21p21enNC4TTWwIm
   98dMXk5ffDgdYiSGtavrDmbzxBUCihYm0vdnkM3bn+xt2xlFdeW8PNgmB
   vsDTP76VaAOP4maFqo9ZbGZguOMiGDivnnGTiyp1Naz1ylNPpZ7aIrc7n
   w==;
X-CSE-ConnectionGUID: kMx6b/WvQseCSVtiakgVuA==
X-CSE-MsgGUID: mNB4kKCPS/K4W+712L9qDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69493456"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69493456"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 15:52:11 -0700
X-CSE-ConnectionGUID: xBKpSTIVRIqqAr2Jz+kWsQ==
X-CSE-MsgGUID: /denfHIjQRKFYxhwn6yAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168951934"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Aug 2025 15:52:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upE8d-000Kjz-2N;
	Thu, 21 Aug 2025 22:52:07 +0000
Date: Fri, 22 Aug 2025 06:51:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:capability-search] BUILD SUCCESS
 907912c1daa7d87ec179ab35f6326e98233ae03a
Message-ID: <202508220649.MWjklNzG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git capability-search
branch HEAD: 907912c1daa7d87ec179ab35f6326e98233ae03a  PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets

elapsed time: 1451m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250821    gcc-9.5.0
arc                   randconfig-002-20250821    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250821    gcc-13.4.0
arm                   randconfig-002-20250821    clang-22
arm                   randconfig-003-20250821    clang-22
arm                   randconfig-004-20250821    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-003-20250821    gcc-11.5.0
arm64                 randconfig-004-20250821    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250821    gcc-13.4.0
csky                  randconfig-002-20250821    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250821    clang-20
hexagon               randconfig-002-20250821    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250821    gcc-12
i386        buildonly-randconfig-002-20250821    gcc-12
i386        buildonly-randconfig-003-20250821    clang-20
i386        buildonly-randconfig-004-20250821    gcc-12
i386        buildonly-randconfig-005-20250821    gcc-12
i386        buildonly-randconfig-006-20250821    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250821    gcc-14.3.0
loongarch             randconfig-002-20250821    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250821    gcc-9.5.0
nios2                 randconfig-002-20250821    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250821    gcc-12.5.0
parisc                randconfig-002-20250821    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250821    clang-17
powerpc               randconfig-002-20250821    clang-22
powerpc               randconfig-003-20250821    gcc-9.5.0
powerpc64             randconfig-002-20250821    clang-22
powerpc64             randconfig-003-20250821    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250821    clang-17
riscv                 randconfig-002-20250821    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250821    gcc-14.3.0
s390                  randconfig-002-20250821    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250821    gcc-15.1.0
sh                    randconfig-002-20250821    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250821    gcc-14.3.0
sparc                 randconfig-002-20250821    gcc-15.1.0
sparc64               randconfig-001-20250821    gcc-8.5.0
sparc64               randconfig-002-20250821    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250821    clang-19
um                    randconfig-002-20250821    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250821    clang-20
x86_64      buildonly-randconfig-002-20250821    clang-20
x86_64      buildonly-randconfig-003-20250821    clang-20
x86_64      buildonly-randconfig-004-20250821    gcc-12
x86_64      buildonly-randconfig-005-20250821    clang-20
x86_64      buildonly-randconfig-006-20250821    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250821    gcc-11.5.0
xtensa                randconfig-002-20250821    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

