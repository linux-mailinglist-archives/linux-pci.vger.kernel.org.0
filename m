Return-Path: <linux-pci+bounces-14911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43919A51C5
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 02:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CD61C2087C
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 00:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35B7E1;
	Sun, 20 Oct 2024 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEKArd2b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AF1372
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729383910; cv=none; b=KTBFhG7IgDBBf/y0YR3xzRqGHMj9Ui4aoyQPcwmBttMd1vRyaAH/VwRQeDIKv5uwrEi9epFK30a2hMQr1GZivk7+W4EgJz5t5uScDUrDsvFpAMP8at/5o1S3oiKj3TSYdRJ0A7wurCTH9VRZIyHNYwRygSx2kZ+kXc0B6ZbL3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729383910; c=relaxed/simple;
	bh=viMU9xQoA+IGEw+b2jCdZgtCGOS6j/VfnB8PgeN/XyM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gGkT2Zf57mCdyalgcGJFUYkp6SW6KU2vsvsPB0sUQAo21N+SJQxkbAc0TnT2A/vLMMh9bs2VBHzDzUwISrBykRBXJi6/LKUHWNo5Q4c3HSGJ2vPTBQVqSBA6IvVV5O8CsZlfzaIyB7DGxf1w7kh5SEzMlFjb3tiBpvRELGTcrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEKArd2b; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729383909; x=1760919909;
  h=date:from:to:cc:subject:message-id;
  bh=viMU9xQoA+IGEw+b2jCdZgtCGOS6j/VfnB8PgeN/XyM=;
  b=SEKArd2bn6Epkaq/nrCfjwQSahQ3N+7fuWK6zeBqjMXkW/0yW6Waf4L3
   cCoj0k3t/xI7gvKB3PNctTAWkW0KrQTf1e77zmoBv4+L/K23cX8giyMeQ
   N7ptB+k3yP6nIIsYTf9p6Qc4+HSbBW8EPISCXQxURHD9Jtd3BgRDhamYY
   hqTnGuUMzSZ9v0XajfUI0ppjyJawfJO6/afFUFitBlIvvxS91RR9xdzKA
   I5EUaouI5SqMrx8nRPpsZRrw72AG3fdcL9GGIuYlyMJ3j6acsOjE0tqbB
   /wY0k53UCd5sD8ReI49ZNuXZAdb7o9G3weXSKpjdGA1WLldKT5pR/mlME
   w==;
X-CSE-ConnectionGUID: L9MWqEvVR1itBjNPtbQU3A==
X-CSE-MsgGUID: 9riDFrxXQ5qI5XXi4vi4zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="54304447"
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="54304447"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 17:25:08 -0700
X-CSE-ConnectionGUID: zG7XcQZURoOlu6zYwNm1sQ==
X-CSE-MsgGUID: ZXuGLFuLTMumtjzrMm/AXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="83753494"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Oct 2024 17:25:07 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2Jkn-000Php-0y;
	Sun, 20 Oct 2024 00:25:05 +0000
Date: Sun, 20 Oct 2024 08:24:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 19f73e938df2b8edfa2e93e0280bd26fd4df5b92
Message-ID: <202410200810.bI8AIY7x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 19f73e938df2b8edfa2e93e0280bd26fd4df5b92  PCI: Improve pdev_sort_resources() warning message

elapsed time: 1481m

configs tested: 89
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.1.0
alpha                  allyesconfig    clang-20
alpha                     defconfig    gcc-14.1.0
arc                    allmodconfig    clang-20
arc                     allnoconfig    gcc-14.1.0
arc                    allyesconfig    clang-20
arc                       defconfig    gcc-14.1.0
arm                    allmodconfig    clang-20
arm                     allnoconfig    gcc-14.1.0
arm                    allyesconfig    clang-20
arm               at91_dt_defconfig    gcc-14.1.0
arm                       defconfig    gcc-14.1.0
arm                gemini_defconfig    gcc-14.1.0
arm                 sama5_defconfig    gcc-14.1.0
arm                 stm32_defconfig    gcc-14.1.0
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.1.0
arm64                     defconfig    gcc-14.1.0
csky                    allnoconfig    gcc-14.1.0
csky                      defconfig    gcc-14.1.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    gcc-14.1.0
hexagon                allyesconfig    clang-20
hexagon                   defconfig    gcc-14.1.0
i386                   allmodconfig    clang-18
i386                    allnoconfig    clang-18
i386                   allyesconfig    clang-18
i386                      defconfig    clang-18
loongarch              allmodconfig    gcc-14.1.0
loongarch               allnoconfig    gcc-14.1.0
loongarch                 defconfig    gcc-14.1.0
m68k                   allmodconfig    gcc-14.1.0
m68k                    allnoconfig    gcc-14.1.0
m68k                   allyesconfig    gcc-14.1.0
m68k                      defconfig    gcc-14.1.0
m68k                 sun3_defconfig    gcc-14.1.0
microblaze             allmodconfig    gcc-14.1.0
microblaze              allnoconfig    gcc-14.1.0
microblaze             allyesconfig    gcc-14.1.0
microblaze                defconfig    gcc-14.1.0
mips                    allnoconfig    gcc-14.1.0
mips                 ci20_defconfig    gcc-14.1.0
mips                 mtx1_defconfig    gcc-14.1.0
nios2               3c120_defconfig    gcc-14.1.0
nios2                   allnoconfig    gcc-14.1.0
nios2                     defconfig    gcc-14.1.0
openrisc                allnoconfig    clang-20
openrisc               allyesconfig    gcc-14.1.0
openrisc                  defconfig    gcc-12
parisc                 allmodconfig    gcc-14.1.0
parisc                  allnoconfig    clang-20
parisc                 allyesconfig    gcc-14.1.0
parisc                    defconfig    gcc-12
parisc      generic-32bit_defconfig    gcc-14.1.0
parisc64                  defconfig    gcc-14.1.0
powerpc                allmodconfig    gcc-14.1.0
powerpc                 allnoconfig    clang-20
powerpc                allyesconfig    gcc-14.1.0
powerpc         bluestone_defconfig    gcc-14.1.0
powerpc        mpc866_ads_defconfig    gcc-14.1.0
powerpc           taishan_defconfig    gcc-14.1.0
riscv                  allmodconfig    gcc-14.1.0
riscv                   allnoconfig    clang-20
riscv                  allyesconfig    gcc-14.1.0
riscv                     defconfig    gcc-12
s390                   allmodconfig    gcc-14.1.0
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.1.0
s390                      defconfig    gcc-12
sh                     allmodconfig    gcc-14.1.0
sh                      allnoconfig    gcc-14.1.0
sh                     allyesconfig    gcc-14.1.0
sh               apsh4a3a_defconfig    gcc-14.1.0
sh                        defconfig    gcc-12
sh              sh7785lcr_defconfig    gcc-14.1.0
sparc                  allmodconfig    gcc-14.1.0
sparc64                   defconfig    gcc-12
um                     allmodconfig    clang-20
um                      allnoconfig    clang-20
um                     allyesconfig    clang-20
um                        defconfig    gcc-12
um                   i386_defconfig    gcc-12
um                 x86_64_defconfig    gcc-12
x86_64                  allnoconfig    clang-18
x86_64                 allyesconfig    clang-18
x86_64                    defconfig    clang-18
x86_64                        kexec    gcc-12
x86_64                     rhel-8.3    gcc-12
xtensa                  allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

