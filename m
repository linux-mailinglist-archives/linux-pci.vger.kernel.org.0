Return-Path: <linux-pci+bounces-16029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC09BC495
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 06:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CE01C2152F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 05:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1C3D9E;
	Tue,  5 Nov 2024 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnMASBkE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908971C9B81
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730783530; cv=none; b=RAXSWap2P3PE2BndhKHoaoNs7Kb4EEst8rg7s/++AqG+p0roFSXl37CZNcVk08NF6/egf7CeWq+C2cqUcuP+mQBGlijHJI2kH+6sekfTBcwBc0TGin6TWJve1uSAfkDyOxAvpm6n0Cxx3DAyHSF99VHF2eUvZHdkSrbRiz0LDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730783530; c=relaxed/simple;
	bh=3YGUzH7tNmMEZkqLyH+r/TOfsmqtoFQlYNy2VkJl97U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tPA7JCp5ntUWX/8ypqqv30jtQj4lz9x03Bqvr4qowBAIRdO2IOTm/XnW6hAm8z+lG7qff11e0FPVSBjXLhrV3wyL+r+sRlHPkxGOTeZKuzGnaUT7eF9TjeltxgluQNy1EhgszlgkQ4sef6WxQqMoT3jjKMtW2GU2q0u5Ut3JKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnMASBkE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730783528; x=1762319528;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3YGUzH7tNmMEZkqLyH+r/TOfsmqtoFQlYNy2VkJl97U=;
  b=hnMASBkEe/aA/N+UrWVsgzots+SCXu+fGKiMMo59V7nX0EpAbxvXMOt5
   +cxKdm+V5ZhLC9uKvcySzIhxE+uGFTBHk70qp1bmZphbvpjwZloif1UB/
   F+UOCmk/YrqrCzJf7tejJXPV5cryIRmCNWnwekTa4xYQp51Y/GAHNac2x
   F0tHynfi3iMiqOBls+/UyX4Zei6VoAF1wk7Ukxp9w76sTN5bv/Om2oLdZ
   O+Y1SIVz26boD9Gd4wFujewVYyBz0wxYJSoDAW56aLNbIvUCHhuoY+6W/
   55QXWtmoTasYClpmc9K9xjqJKVWHPKK/YcKqerHA0atwEMrIb5jIx6C2T
   w==;
X-CSE-ConnectionGUID: YFH4RQYGQTGrFAa74AELRg==
X-CSE-MsgGUID: EmB7yPoQT3mt0+3yff0RCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41884234"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="41884234"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:12:08 -0800
X-CSE-ConnectionGUID: fyHKay+VTu+HZ3HHCkxTwQ==
X-CSE-MsgGUID: ImvcOmswQ2yiG/ndOnDZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83973233"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 21:12:07 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8BrJ-000lep-0I;
	Tue, 05 Nov 2024 05:12:05 +0000
Date: Tue, 05 Nov 2024 13:11:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 6e73c5898973e630a659a93d913c8706fa454ebe
Message-ID: <202411051300.QPUr85DA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 6e73c5898973e630a659a93d913c8706fa454ebe  PCI: mediatek-gen3: Add support for restricting link width

elapsed time: 729m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                      footbridge_defconfig    gcc-14.1.0
arm                           imxrt_defconfig    gcc-14.1.0
arm                        shmobile_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241105    clang-19
i386        buildonly-randconfig-002-20241105    clang-19
i386        buildonly-randconfig-003-20241105    clang-19
i386        buildonly-randconfig-004-20241105    clang-19
i386        buildonly-randconfig-005-20241105    clang-19
i386        buildonly-randconfig-006-20241105    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241105    clang-19
i386                  randconfig-002-20241105    clang-19
i386                  randconfig-003-20241105    clang-19
i386                  randconfig-004-20241105    clang-19
i386                  randconfig-005-20241105    clang-19
i386                  randconfig-006-20241105    clang-19
i386                  randconfig-011-20241105    clang-19
i386                  randconfig-012-20241105    clang-19
i386                  randconfig-013-20241105    clang-19
i386                  randconfig-014-20241105    clang-19
i386                  randconfig-015-20241105    clang-19
i386                  randconfig-016-20241105    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7722_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241105    gcc-12
x86_64      buildonly-randconfig-002-20241105    gcc-12
x86_64      buildonly-randconfig-003-20241105    gcc-12
x86_64      buildonly-randconfig-004-20241105    gcc-12
x86_64      buildonly-randconfig-005-20241105    gcc-12
x86_64      buildonly-randconfig-006-20241105    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241105    gcc-12
x86_64                randconfig-002-20241105    gcc-12
x86_64                randconfig-003-20241105    gcc-12
x86_64                randconfig-004-20241105    gcc-12
x86_64                randconfig-005-20241105    gcc-12
x86_64                randconfig-006-20241105    gcc-12
x86_64                randconfig-011-20241105    gcc-12
x86_64                randconfig-012-20241105    gcc-12
x86_64                randconfig-013-20241105    gcc-12
x86_64                randconfig-014-20241105    gcc-12
x86_64                randconfig-015-20241105    gcc-12
x86_64                randconfig-016-20241105    gcc-12
x86_64                randconfig-071-20241105    gcc-12
x86_64                randconfig-072-20241105    gcc-12
x86_64                randconfig-073-20241105    gcc-12
x86_64                randconfig-074-20241105    gcc-12
x86_64                randconfig-075-20241105    gcc-12
x86_64                randconfig-076-20241105    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

