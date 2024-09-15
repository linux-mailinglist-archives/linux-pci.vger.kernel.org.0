Return-Path: <linux-pci+bounces-13223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B03979512
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 09:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A851C20D9E
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7F200CD;
	Sun, 15 Sep 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNB3xvzZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D617C9B
	for <linux-pci@vger.kernel.org>; Sun, 15 Sep 2024 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726386640; cv=none; b=ofYq2iuFvLo5RWRd2O34lIY8MlPdszL4A2/Afak51jYv4ZRvknWKAW/X52or50NQQIckGba30Ph3FOtfIEw7QO6Is15VqBBM6UiOzvSzP1qHpzHwfJmW9ClbssERrX6Ww9An9o9NNe8GKJSHvPtZplXu34y2FeEj2vgMXSjSS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726386640; c=relaxed/simple;
	bh=itXnddQCu2fdm8RxwECLg68jNQGvyw1t2xGxweBt+JU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K03imxs3yIg258EfiIOvwm0xKLcM8AYF/2FePMiOff9rWGjG3oK9D+3TplMLzw8muwaakUr1o14VxrP9IsKOX9LLTMrufkzNqUNuT/nFazjezKbuJVK/gTwRBqi6dqJT67tDLIOoEleJEpZRhLzdADbU0dJdscRH6vL365aG/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNB3xvzZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726386638; x=1757922638;
  h=date:from:to:cc:subject:message-id;
  bh=itXnddQCu2fdm8RxwECLg68jNQGvyw1t2xGxweBt+JU=;
  b=GNB3xvzZSy5koSiADSRxL9RIGtfd1IbDPBpSUSbGvzo6y8TtIwKXHpUJ
   gcn7KVEtOG3Brv0+FCYIWGmX2gb8iDwOXIeqBMrt//wQEX3qyPnrIkDNT
   y+ap1wtLvIeLHGJGvJYtThWKUB3F+zksrtyojzJhP4nI7muYAzcvRzsu0
   F5H+N85xDI5FUbU0RrG0nH/rZIN88QrgoXIb5gWcPY6Woorcq2AxUq4Bm
   AbPQyH6pn9FM8ydBl/7gO1WLjl6E0DBIRYVj82lQp4KgPRyJ4IdYXKeAP
   VGymGq/exCwqa3YbxNA+NF9ePdqMUYqfejM5E/ntAn6B1/HUr4BNBpmjt
   A==;
X-CSE-ConnectionGUID: wF1XyXT9TZ20Ik1XcJBVBw==
X-CSE-MsgGUID: wBBvI1jVQPGpqJw1+xYo1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="42756992"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="42756992"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 00:50:37 -0700
X-CSE-ConnectionGUID: aGNQqE7RRFO1ggaa7U4Xcw==
X-CSE-MsgGUID: Vfy08APxSr+F5Hk16N8Gnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="106016615"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Sep 2024 00:50:37 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spk1h-0008VO-30;
	Sun, 15 Sep 2024 07:50:33 +0000
Date: Sun, 15 Sep 2024 15:49:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 3cd3b49989fef8556b018fb8038581195b253b8d
Message-ID: <202409151544.0AQBUwRP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 3cd3b49989fef8556b018fb8038581195b253b8d  dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again

elapsed time: 1850m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20240915    gcc-13.2.0
arc                   randconfig-002-20240915    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20240915    gcc-14.1.0
arm                   randconfig-002-20240915    clang-17
arm                   randconfig-003-20240915    clang-20
arm                   randconfig-004-20240915    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240915    clang-20
arm64                 randconfig-002-20240915    gcc-14.1.0
arm64                 randconfig-003-20240915    clang-20
arm64                 randconfig-004-20240915    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240915    gcc-14.1.0
csky                  randconfig-002-20240915    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20240915    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240915    gcc-12
i386        buildonly-randconfig-002-20240915    clang-18
i386        buildonly-randconfig-003-20240915    clang-18
i386        buildonly-randconfig-004-20240915    gcc-12
i386        buildonly-randconfig-005-20240915    clang-18
i386        buildonly-randconfig-006-20240915    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240915    clang-18
i386                  randconfig-002-20240915    clang-18
i386                  randconfig-003-20240915    clang-18
i386                  randconfig-004-20240915    clang-18
i386                  randconfig-005-20240915    clang-18
i386                  randconfig-006-20240915    clang-18
i386                  randconfig-011-20240915    clang-18
i386                  randconfig-012-20240915    gcc-12
i386                  randconfig-013-20240915    gcc-12
i386                  randconfig-014-20240915    clang-18
i386                  randconfig-015-20240915    gcc-12
i386                  randconfig-016-20240915    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240915    gcc-14.1.0
loongarch             randconfig-002-20240915    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240915    gcc-14.1.0
nios2                 randconfig-002-20240915    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240915    gcc-14.1.0
parisc                randconfig-002-20240915    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20240915    gcc-14.1.0
powerpc               randconfig-002-20240915    gcc-14.1.0
powerpc               randconfig-003-20240915    gcc-14.1.0
powerpc64             randconfig-001-20240915    clang-20
powerpc64             randconfig-002-20240915    clang-20
powerpc64             randconfig-003-20240915    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
um                                allnoconfig    clang-17
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

