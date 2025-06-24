Return-Path: <linux-pci+bounces-30501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6659AAE64D6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C5B5A238E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21F222599;
	Tue, 24 Jun 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGPSa4A0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835228C86C
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767798; cv=none; b=rDylKmSzkNzLMgkVmxIhJh7qW9eBJcKHO2xGgiX80ao8X/84XypzH97bwnxhNxkLNN7TQAKr3yW0GfRY6GOykeC7PdsA6Rskrp5ZJsJZTnEZfX34/AnJljbXlMvgoqT20Qbu7ReH8otNgOxxdq0i549eg30IugSRHGhahErCwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767798; c=relaxed/simple;
	bh=evk8/sosbDVMFVylFny9GS8SLiZdGMeQwT4SkxYr+eA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b4bu+d2Fg584vUNuqwYG9J4MAp/nkNfV2HsciiQMqJ//CJKbJs9+FbDGS7twdm9YiEpyZRNlWjrrQ/WNRya0Q9HAgQYftsrJ/k9zRQgR4HjC1qDO4PySQMhcnGIJfLsA7NOLLpNwbROglBD9a38rfye1pUU8qG3eSwW1YLrFR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGPSa4A0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750767796; x=1782303796;
  h=date:from:to:cc:subject:message-id;
  bh=evk8/sosbDVMFVylFny9GS8SLiZdGMeQwT4SkxYr+eA=;
  b=YGPSa4A0Bbmx+iZZ8TT6pY1Ny7yZO+pVAjdN50lSu6KLdKf1luugFbdx
   e1BhU5uaWun0QkOecmMWuvuZzqo4JPQMkIOSmkf56fc6M+tbU5LtxT7Rd
   UOA71rSIpOiFAGih6mKG1yhh5ayP+xyJFQCPMIS5SSocmyrFaYTEF9ZQv
   fPzFYM1Ix8SSOrx56qpScU7OdC6mrSAv7hb2m/+A06zmnNODUyV8v2Idf
   3ZtCFYyehM8LdMi+MKLaYCPZNHgkWoELQPUci28c86652qYA0p9/B6Pg3
   tPa0+NR0XG3cqG3LsdFSXH5uGtp3ue5hCRNk52hKMKmBoaBnL2BBtsxbd
   g==;
X-CSE-ConnectionGUID: ZrD1mIowRz++A3f/Y4Kckg==
X-CSE-MsgGUID: /Q35RH/+SSegyzBh1GK7KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53141185"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53141185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:23:15 -0700
X-CSE-ConnectionGUID: KyhHyK9YSambEFMtL4zFVA==
X-CSE-MsgGUID: ruRMcpTxRa+nInXPBvRKDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="157396136"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2025 05:23:13 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU2gB-000S6G-32;
	Tue, 24 Jun 2025 12:23:11 +0000
Date: Tue, 24 Jun 2025 20:22:12 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 e1cb67ab82aab44cda410616498d4749399da217
Message-ID: <202506242002.hge2yrBJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: e1cb67ab82aab44cda410616498d4749399da217  dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated clocks from PCIe hosts

elapsed time: 1450m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250623    gcc-10.5.0
arc                   randconfig-001-20250624    gcc-8.5.0
arc                   randconfig-002-20250623    gcc-8.5.0
arc                   randconfig-002-20250624    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250623    gcc-10.5.0
arm                   randconfig-001-20250624    gcc-8.5.0
arm                   randconfig-002-20250623    clang-21
arm                   randconfig-002-20250624    gcc-8.5.0
arm                   randconfig-003-20250623    gcc-8.5.0
arm                   randconfig-003-20250624    gcc-8.5.0
arm                   randconfig-004-20250623    gcc-10.5.0
arm                   randconfig-004-20250624    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250623    gcc-14.3.0
arm64                 randconfig-001-20250624    gcc-8.5.0
arm64                 randconfig-002-20250623    gcc-14.3.0
arm64                 randconfig-002-20250624    gcc-8.5.0
arm64                 randconfig-003-20250623    gcc-9.5.0
arm64                 randconfig-003-20250624    gcc-8.5.0
arm64                 randconfig-004-20250623    clang-16
arm64                 randconfig-004-20250624    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250623    clang-20
i386        buildonly-randconfig-001-20250624    gcc-12
i386        buildonly-randconfig-002-20250623    gcc-11
i386        buildonly-randconfig-002-20250624    gcc-12
i386        buildonly-randconfig-003-20250623    gcc-12
i386        buildonly-randconfig-003-20250624    gcc-12
i386        buildonly-randconfig-004-20250623    clang-20
i386        buildonly-randconfig-004-20250624    gcc-12
i386        buildonly-randconfig-005-20250623    gcc-12
i386        buildonly-randconfig-005-20250624    gcc-12
i386        buildonly-randconfig-006-20250623    gcc-11
i386        buildonly-randconfig-006-20250624    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250623    clang-20
x86_64      buildonly-randconfig-001-20250624    clang-20
x86_64      buildonly-randconfig-002-20250623    gcc-12
x86_64      buildonly-randconfig-002-20250624    clang-20
x86_64      buildonly-randconfig-003-20250623    gcc-12
x86_64      buildonly-randconfig-003-20250624    clang-20
x86_64      buildonly-randconfig-004-20250623    gcc-12
x86_64      buildonly-randconfig-004-20250624    clang-20
x86_64      buildonly-randconfig-005-20250623    gcc-12
x86_64      buildonly-randconfig-005-20250624    clang-20
x86_64      buildonly-randconfig-006-20250623    clang-20
x86_64      buildonly-randconfig-006-20250624    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

