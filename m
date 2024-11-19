Return-Path: <linux-pci+bounces-17073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E019D2715
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 14:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CF9283BF2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98511CC88A;
	Tue, 19 Nov 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp27Mj5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711B1CB32A
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023475; cv=none; b=nHMz2M/3YAuAAXKAZHa+1oE+k7dM1iNANYFBtE4VUNCEa7VL+peguRO+JQdR6n+F6nfviVWnkxXjTsbBA7TAjtNyI5eH8XWZGTlwKFVsRKTEHbjjS8lH4dgjl5mhL3PW4pXTYopeEcakhm7PGOG2gNCiuGBFXHEnYwG8laDBeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023475; c=relaxed/simple;
	bh=0ghehew1P7RxdPx/ZB8aawNKMGAy9d5NBZhWk9mrZFQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qHUxKQ0H3O6GjIq44+JILPXbZqwpQ9xjFBZtkyhbMHkZBO3gR6uabJkvKCh3EFw98vptHdh51O0a19DTdIeHcSqpbGMmVKiV9Es3mzGepu3O827h4DLJlZCYDzfhniwiNNvJLFlXEQ7DO+MfTT9JUOoL+bh/4bKXnVWpJmtxT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp27Mj5W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732023474; x=1763559474;
  h=date:from:to:cc:subject:message-id;
  bh=0ghehew1P7RxdPx/ZB8aawNKMGAy9d5NBZhWk9mrZFQ=;
  b=cp27Mj5W0eHsWh6MLpd2rv1MmjrWPUKux6NE7t+W5yZIZhmGUnOuz1WN
   Gv3Mnvlp+DkYccXiJyquhhaZfKymnH1nfe8SdsY4TrCoaiQxryXrVIV6v
   f9mhYC+MZf0Z1OLBy14pGgaG8IU/q+GE+9v3LI4k4Ir0glseaGI/rfW77
   COydc9ROXcpZfc+tCTkoiqpGdb6YMx8z+4fdInSAk1509TyIN4V78atjx
   TdqBFL8cw+2w4kkS9wvhor4T4Okzfc7GrAsnDTS9j2ab62HrHdI6S1G95
   x7v++bI3keNuBnNjG0tBmP/R25uYwST1/crJLSDreBibAouCXgKkWMe9Q
   w==;
X-CSE-ConnectionGUID: oiZGjRysQ9aETx5pEYXGaA==
X-CSE-MsgGUID: 6Smt42RlRQCjFZwOT5IRMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="43424367"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="43424367"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 05:37:54 -0800
X-CSE-ConnectionGUID: 7dM4nzy5QhCl8rPM2Doafw==
X-CSE-MsgGUID: af4D0kHSR82yq3kH5YDg0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="94010165"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Nov 2024 05:37:52 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDOQQ-00008C-2v;
	Tue, 19 Nov 2024 13:37:50 +0000
Date: Tue, 19 Nov 2024 20:25:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctl] BUILD SUCCESS
 3055f91478b6d65a98b0e73009e096c131834e58
Message-ID: <202411192011.hMPF09sM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctl
branch HEAD: 3055f91478b6d65a98b0e73009e096c131834e58  PCI/pwrctrl: Rename pwrctrl functions and structures

elapsed time: 923m

configs tested: 50
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.2.0
arc                     allnoconfig    gcc-13.2.0
arc         randconfig-001-20241119    gcc-13.2.0
arc         randconfig-002-20241119    gcc-13.2.0
arm                     allnoconfig    clang-20
arm         randconfig-001-20241119    clang-20
arm         randconfig-002-20241119    clang-15
arm         randconfig-003-20241119    clang-20
arm         randconfig-004-20241119    gcc-14.2.0
arm64                   allnoconfig    gcc-14.2.0
arm64       randconfig-001-20241119    gcc-14.2.0
arm64       randconfig-002-20241119    gcc-14.2.0
arm64       randconfig-003-20241119    clang-20
arm64       randconfig-004-20241119    gcc-14.2.0
csky                    allnoconfig    gcc-14.2.0
csky        randconfig-001-20241119    gcc-14.2.0
csky        randconfig-002-20241119    gcc-14.2.0
hexagon                 allnoconfig    clang-20
hexagon     randconfig-001-20241119    clang-16
hexagon     randconfig-002-20241119    clang-20
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch               allnoconfig    gcc-14.2.0
loongarch   randconfig-001-20241119    gcc-14.2.0
loongarch   randconfig-002-20241119    gcc-14.2.0
m68k                    allnoconfig    gcc-14.2.0
microblaze              allnoconfig    gcc-14.2.0
mips                    allnoconfig    gcc-14.2.0
nios2                   allnoconfig    gcc-14.2.0
nios2       randconfig-001-20241119    gcc-14.2.0
nios2       randconfig-002-20241119    gcc-14.2.0
openrisc                allnoconfig    gcc-14.2.0
parisc                  allnoconfig    gcc-14.2.0
parisc      randconfig-001-20241119    gcc-14.2.0
parisc      randconfig-002-20241119    gcc-14.2.0
powerpc                 allnoconfig    gcc-14.2.0
powerpc     randconfig-001-20241119    gcc-14.2.0
powerpc     randconfig-002-20241119    gcc-14.2.0
riscv                   allnoconfig    gcc-14.2.0
s390                    allnoconfig    clang-20
sh                      allnoconfig    gcc-14.2.0
um                      allnoconfig    clang-17
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-19
x86_64                     rhel-9.4    gcc-12
xtensa                  allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

