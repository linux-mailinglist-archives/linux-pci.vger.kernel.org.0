Return-Path: <linux-pci+bounces-20076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938BA15851
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 20:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AB416936A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4941A256B;
	Fri, 17 Jan 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7IyyTjq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3C1AA1D9
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143191; cv=none; b=Ai9x724RjYawkYEwJem4MpAVfJcho2Bo/Lr4tGg9Wu2xf/87YfeIe42dUkLNEl8C44eYVCC20ISx0rqITDkaylzCrtIqm5et62iaPW+ofvSVuCwbmcsyjczPaalLZCyckz4+a3fDiiwYJ99EvdY90ulIrNjv7OLla6xJlWBrNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143191; c=relaxed/simple;
	bh=Y8V7mtSIQeyd07dzWvIWxWVeo6ngdM75uydTelnwycc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BjxzpGvla8cxVpmoEqYxd0jjk/tQBkCrWQ50r69sI8+1HFs34vnvLSBsHjXRsBbS6q1P71NrPv/5/w5TbatMiLBLCJzZy8JDXjWNFhlcs7Jl7GGPJqctteMeo5hUS9brkgMuzgYUxq86VXYFLzznAcDP+G8YfotPNigN0Kg9e2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7IyyTjq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737143190; x=1768679190;
  h=date:from:to:cc:subject:message-id;
  bh=Y8V7mtSIQeyd07dzWvIWxWVeo6ngdM75uydTelnwycc=;
  b=c7IyyTjqEg4H99hLWU3oD9hfByFs8mIuJeu/23Iv+8Fl/MQSDAGGN+qU
   xa0RJFZEwiyrXT9JZw+I7S70ywSeP44yUnhEZVDsazMK30aQVm46NThGt
   FBoDIu3HKYvi6K5T5uU8aE06zpzh8cVl0kDJ/4oB7qBqBZaobiFdok/sy
   dxYPXpVDieKuI4HxM4GT1HZATOTP3UZ79hsy2VSjfryoLPsveifihSsaZ
   SZsdiipsAPHn1R4cLZywh8rtadsQv2VRCtU9bZGqogf6N6BBL+loZTnKs
   cbIT68mGGIXT1eSQWkl+WPAojTHPfHjYCFxvzbf/ed65Ahz1n96pjo7AA
   g==;
X-CSE-ConnectionGUID: hL4NL2xeQrm9BPttQAT+5A==
X-CSE-MsgGUID: WY6EFYV6Q2ybvd1J7R8uQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37610936"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37610936"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 11:46:28 -0800
X-CSE-ConnectionGUID: KCvmKUzYTPKVGVjDwvkKkQ==
X-CSE-MsgGUID: zqh86dfHSiWVY9vINAgcMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109951707"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jan 2025 11:46:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYsIS-000TeJ-28;
	Fri, 17 Jan 2025 19:46:24 +0000
Date: Sat, 18 Jan 2025 03:45:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 1f60c9019f044c529961c2983e03a12fe9ebde1d
Message-ID: <202501180318.cWEqrUbG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 1f60c9019f044c529961c2983e03a12fe9ebde1d  PCI: Remove devres from pci_intx()

elapsed time: 1444m

configs tested: 174
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250117    clang-20
arc                   randconfig-001-20250117    gcc-13.2.0
arc                   randconfig-002-20250117    clang-20
arc                   randconfig-002-20250117    gcc-13.2.0
arm                              alldefconfig    clang-20
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    clang-20
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250117    clang-18
arm                   randconfig-001-20250117    clang-20
arm                   randconfig-002-20250117    clang-20
arm                   randconfig-002-20250117    gcc-14.2.0
arm                   randconfig-003-20250117    clang-20
arm                   randconfig-003-20250117    gcc-14.2.0
arm                   randconfig-004-20250117    clang-16
arm                   randconfig-004-20250117    clang-20
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250117    clang-20
arm64                 randconfig-001-20250117    gcc-14.2.0
arm64                 randconfig-002-20250117    clang-18
arm64                 randconfig-002-20250117    clang-20
arm64                 randconfig-003-20250117    clang-20
arm64                 randconfig-004-20250117    clang-20
arm64                 randconfig-004-20250117    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250117    gcc-14.2.0
csky                  randconfig-002-20250117    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250117    clang-20
hexagon               randconfig-001-20250117    gcc-14.2.0
hexagon               randconfig-002-20250117    clang-20
hexagon               randconfig-002-20250117    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250117    clang-19
i386        buildonly-randconfig-002-20250117    clang-19
i386        buildonly-randconfig-003-20250117    gcc-12
i386        buildonly-randconfig-004-20250117    gcc-12
i386        buildonly-randconfig-005-20250117    clang-19
i386        buildonly-randconfig-006-20250117    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20250117    clang-19
i386                  randconfig-002-20250117    clang-19
i386                  randconfig-003-20250117    clang-19
i386                  randconfig-004-20250117    clang-19
i386                  randconfig-005-20250117    clang-19
i386                  randconfig-006-20250117    clang-19
i386                  randconfig-007-20250117    clang-19
i386                  randconfig-011-20250117    gcc-12
i386                  randconfig-012-20250117    gcc-12
i386                  randconfig-013-20250117    gcc-12
i386                  randconfig-014-20250117    gcc-12
i386                  randconfig-015-20250117    gcc-12
i386                  randconfig-016-20250117    gcc-12
i386                  randconfig-017-20250117    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250117    gcc-14.2.0
loongarch             randconfig-002-20250117    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250117    gcc-14.2.0
nios2                 randconfig-002-20250117    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250117    gcc-14.2.0
parisc                randconfig-002-20250117    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250117    gcc-14.2.0
powerpc               randconfig-002-20250117    gcc-14.2.0
powerpc               randconfig-003-20250117    gcc-14.2.0
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250117    clang-16
powerpc64             randconfig-001-20250117    gcc-14.2.0
powerpc64             randconfig-002-20250117    clang-20
powerpc64             randconfig-002-20250117    gcc-14.2.0
powerpc64             randconfig-003-20250117    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250117    gcc-14.2.0
riscv                 randconfig-002-20250117    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250117    gcc-14.2.0
s390                  randconfig-002-20250117    clang-20
s390                  randconfig-002-20250117    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250117    gcc-14.2.0
sh                    randconfig-002-20250117    gcc-14.2.0
sh                          sdk7786_defconfig    clang-20
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250117    gcc-14.2.0
sparc                 randconfig-002-20250117    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250117    gcc-14.2.0
sparc64               randconfig-002-20250117    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250117    clang-20
um                    randconfig-001-20250117    gcc-14.2.0
um                    randconfig-002-20250117    gcc-12
um                    randconfig-002-20250117    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250117    gcc-12
x86_64      buildonly-randconfig-002-20250117    gcc-12
x86_64      buildonly-randconfig-003-20250117    gcc-12
x86_64      buildonly-randconfig-004-20250117    gcc-12
x86_64      buildonly-randconfig-005-20250117    gcc-12
x86_64      buildonly-randconfig-006-20250117    clang-19
x86_64      buildonly-randconfig-006-20250117    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250117    clang-19
x86_64                randconfig-002-20250117    clang-19
x86_64                randconfig-003-20250117    clang-19
x86_64                randconfig-004-20250117    clang-19
x86_64                randconfig-005-20250117    clang-19
x86_64                randconfig-006-20250117    clang-19
x86_64                randconfig-007-20250117    clang-19
x86_64                randconfig-008-20250117    clang-19
x86_64                randconfig-071-20250117    clang-19
x86_64                randconfig-072-20250117    clang-19
x86_64                randconfig-073-20250117    clang-19
x86_64                randconfig-074-20250117    clang-19
x86_64                randconfig-075-20250117    clang-19
x86_64                randconfig-076-20250117    clang-19
x86_64                randconfig-077-20250117    clang-19
x86_64                randconfig-078-20250117    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250117    gcc-14.2.0
xtensa                randconfig-002-20250117    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

