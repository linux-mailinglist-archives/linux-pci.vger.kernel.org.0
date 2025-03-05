Return-Path: <linux-pci+bounces-22963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DEAA4FE14
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 12:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D9D1893434
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DBB241693;
	Wed,  5 Mar 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="js2/mik1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DF241662
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175797; cv=none; b=mqTIzPzIV9PvxP4jKnCZscIJyOMxSizzH3ypt48071j8Pfxzsz1+rmVPbk/B1XHVzxoUu2xWJ+cLnLQy5vridl4tLzKTdC3X5nfKCKggN6ZQum36QWtqmTvyilXHYO7UL5RVhr2FjPmtn6dvmzA7wPFDFvUZ97nDtKqztC9C/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175797; c=relaxed/simple;
	bh=rCDz6mzZEA45tL4DxP6IYn00MICZ3KSIKIgNPy93/XY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X+L0AGkNXo0Xq5t+fcKarkKrHGDNpYcaQSlYmp7erDZq6VDWCpL2iUt8siqQvpCBT0G8LUzAUQZM2Qw+Is3NnD62XMm21ap2hAeIxrTifkJPMDxx6X4ksuFg2A3Y9f6deKi7fqHW/Tv5AFPTAlsZTwyy5oLxuUbwTwQ3Lsfmz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=js2/mik1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741175796; x=1772711796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rCDz6mzZEA45tL4DxP6IYn00MICZ3KSIKIgNPy93/XY=;
  b=js2/mik1o+DE+iwQ11D4lh7yBDCtAm/t0BL6wj4341YJWiB+Te/AluOz
   TKOyGcobMpd9URWozCH0EM9n1Hmw529Mjjcg7VwUpfWbjrcuWaKtOO6kg
   X3P0kAZGYbWD5CAYhYL/M+1fCEk2ZTDsisryg/QN9jfq/WhkX+pQNa4cm
   ck2rEgvnbyBmQgLMIL6WAk9Frw/QR6B/cO/AR5EP3XmnTU0oeWYxktYzc
   cSu0jllTKdHolk7LrmvUX5pByUjGKg3Jg19+F4yL2SHUn8iskIZzaL9T+
   qtb50jUl/Ab2NjPAOVVGKeTYmVzWDvlYkfV6zKJI+YABGQ78AyGJmmGk0
   w==;
X-CSE-ConnectionGUID: K4Nf2HCWThitT9kHDeLKgA==
X-CSE-MsgGUID: s0DRtZa4RhyQIE9rhjlo3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41997403"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="41997403"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 03:56:35 -0800
X-CSE-ConnectionGUID: fogEGCSvTImcYBjGadQYHg==
X-CSE-MsgGUID: OSXC80RET2GBaw4p5CEEhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118383491"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 05 Mar 2025 03:56:35 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpnMM-000Kv6-0b;
	Wed, 05 Mar 2025 11:56:26 +0000
Date: Wed, 05 Mar 2025 19:56:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 3ac47fbf4f6e8c3a7c3855fac68cc3246f90f850
Message-ID: <202503051954.FJwAs3bC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 3ac47fbf4f6e8c3a7c3855fac68cc3246f90f850  PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload

elapsed time: 1466m

configs tested: 120
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              alldefconfig    gcc-13.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250304    gcc-13.2.0
arc                   randconfig-002-20250304    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250304    clang-21
arm                   randconfig-002-20250304    gcc-14.2.0
arm                   randconfig-003-20250304    clang-21
arm                   randconfig-004-20250304    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250304    clang-21
arm64                 randconfig-002-20250304    gcc-14.2.0
arm64                 randconfig-003-20250304    gcc-14.2.0
arm64                 randconfig-004-20250304    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250304    gcc-14.2.0
csky                  randconfig-002-20250304    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250304    clang-21
hexagon               randconfig-002-20250304    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250304    clang-19
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-002-20250304    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-003-20250304    gcc-12
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-004-20250304    gcc-11
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-005-20250304    gcc-11
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-006-20250304    gcc-12
i386        buildonly-randconfig-006-20250305    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250304    gcc-14.2.0
loongarch             randconfig-002-20250304    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250304    gcc-14.2.0
nios2                 randconfig-002-20250304    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250304    gcc-14.2.0
parisc                randconfig-002-20250304    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250304    gcc-14.2.0
powerpc               randconfig-002-20250304    gcc-14.2.0
powerpc               randconfig-003-20250304    clang-21
powerpc64             randconfig-001-20250304    gcc-14.2.0
powerpc64             randconfig-002-20250304    gcc-14.2.0
powerpc64             randconfig-003-20250304    clang-21
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
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250304    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-002-20250304    gcc-12
x86_64      buildonly-randconfig-002-20250305    clang-19
x86_64      buildonly-randconfig-003-20250304    gcc-12
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-004-20250304    gcc-12
x86_64      buildonly-randconfig-004-20250305    clang-19
x86_64      buildonly-randconfig-005-20250304    gcc-12
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-006-20250304    gcc-12
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-071-20250305    clang-19
x86_64                randconfig-072-20250305    clang-19
x86_64                randconfig-073-20250305    clang-19
x86_64                randconfig-074-20250305    clang-19
x86_64                randconfig-075-20250305    clang-19
x86_64                randconfig-076-20250305    clang-19
x86_64                randconfig-077-20250305    clang-19
x86_64                randconfig-078-20250305    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

