Return-Path: <linux-pci+bounces-40577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FBC3FD55
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 13:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2447E4E5987
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09272326D6F;
	Fri,  7 Nov 2025 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+IUB+zl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C51FF1B5
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516880; cv=none; b=uy87UiSRyqUavXlM3/9xhUzjh8RUniy3wdkbmYdGYXBuS1P7/Rq9AVg7B0F3gfdwa/tt1hRzY2DYlpX5SX1SQNFpEbyUA0dAqoBGsGIZNWjKDOFQSFkChnHjyyrx5U92a1By68y7g8t1WU1guzGNA142OYQyUIFErQ6QbnKXmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516880; c=relaxed/simple;
	bh=aJwdi7CY/I/v0UxGH70HKupUKGu5FXByJo7qSHCv0gs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mKniAPHxpW6BKK0IaE27zAiTvaKqIce61MbnV/dTuGa7N5HHoNtiqa4uGTMCE8T1PY/pw/uwxBTJkRnnXpCFQpaSuEkFek/EWL6SAw0oW6tKN26RKQPGboIiYhaSAkZUPJwtzuEL9dgeR+gRpUoBvYJrll0jB7sHgHClRkW2bgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+IUB+zl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762516879; x=1794052879;
  h=date:from:to:cc:subject:message-id;
  bh=aJwdi7CY/I/v0UxGH70HKupUKGu5FXByJo7qSHCv0gs=;
  b=Z+IUB+zlzLdd1U3W9etduhdI+Cqwwvcg12KGF5kemtPYLwPolqIZjASI
   MdAt2gg5FDFX3izdcCXo4ahEKuttt7YglhArmI44/nLCLY6pa/fUBTxWg
   jjADTuoSSrlZMcxoKE2tkd1getIDCoN5IBRZtBt9g4zZxpUpqmIHu3x7t
   ULc4VQ6qmHShqufYe6bXKt6Z3X3Ic59iTHQkGqJ6RKKoIqJrbuztVJz9i
   XQ0eXjnBH1803cCt8YyjQiT3PMaoQ/n6kqnY9oBtpo8i+PWtHs6Kmkzyr
   RX0wN0C+MilHcesM+iOiWDsnofXFt/yl99R5GWd6lyoRH+SoNI7gZYJH/
   A==;
X-CSE-ConnectionGUID: dEq+NqX8SeqKHsnLeErG4Q==
X-CSE-MsgGUID: x7kJE+fISK6jCRBqEDcKkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75778055"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="75778055"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 04:01:19 -0800
X-CSE-ConnectionGUID: 2t0ubvFhR4u32rQ5gd0pAg==
X-CSE-MsgGUID: MEfuVpRXTxuBouzQGpM05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192283597"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2025 04:01:17 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHL9X-000V48-24;
	Fri, 07 Nov 2025 12:01:15 +0000
Date: Fri, 07 Nov 2025 20:00:28 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/ti] BUILD SUCCESS
 041c2f0e34ba4823101bf307d6a6d41d98f5dac3
Message-ID: <202511072022.JtuTa4yg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/ti
branch HEAD: 041c2f0e34ba4823101bf307d6a6d41d98f5dac3  PCI: keystone: Add support to build as a loadable module

elapsed time: 1613m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20251107    clang-17
arm                   randconfig-002-20251107    gcc-13.4.0
arm                   randconfig-003-20251107    clang-22
arm                   randconfig-004-20251107    gcc-8.5.0
arm                        realview_defconfig    clang-16
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251107    gcc-8.5.0
arm64                 randconfig-002-20251107    clang-22
arm64                 randconfig-003-20251107    gcc-8.5.0
arm64                 randconfig-004-20251107    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251107    gcc-12.5.0
csky                  randconfig-002-20251107    gcc-13.4.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251107    clang-22
hexagon               randconfig-002-20251107    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251107    clang-20
i386        buildonly-randconfig-002-20251107    clang-20
i386        buildonly-randconfig-003-20251107    gcc-13
i386        buildonly-randconfig-004-20251107    gcc-14
i386        buildonly-randconfig-005-20251107    clang-20
i386        buildonly-randconfig-006-20251107    clang-20
i386                  randconfig-001-20251107    clang-20
i386                  randconfig-002-20251107    gcc-13
i386                  randconfig-003-20251107    clang-20
i386                  randconfig-004-20251107    clang-20
i386                  randconfig-005-20251107    gcc-14
i386                  randconfig-006-20251107    clang-20
i386                  randconfig-011-20251107    gcc-14
i386                  randconfig-014-20251107    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251107    gcc-11.5.0
sparc                 randconfig-002-20251107    gcc-15.1.0
sparc64                          alldefconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251107    gcc-8.5.0
sparc64               randconfig-002-20251107    gcc-9.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251107    clang-22
um                    randconfig-002-20251107    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-003-20251107    gcc-14
x86_64      buildonly-randconfig-005-20251107    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251107    clang-20
x86_64                randconfig-072-20251107    gcc-14
x86_64                randconfig-073-20251107    clang-20
x86_64                randconfig-074-20251107    clang-20
x86_64                randconfig-075-20251107    clang-20
x86_64                randconfig-076-20251107    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251107    gcc-10.5.0
xtensa                randconfig-002-20251107    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

