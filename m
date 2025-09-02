Return-Path: <linux-pci+bounces-35333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C8B40965
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE91554543A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C32DECA7;
	Tue,  2 Sep 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGGWKeCQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05502DC353
	for <linux-pci@vger.kernel.org>; Tue,  2 Sep 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827744; cv=none; b=tIOjk9GUMuirYLFxLkxB4u+AUbBAdwp+ZlZDV6czvINOhXyHpEVJASyxCfChMnbRxUPCwm4kxQz7bHGTRMl01WR+fFUV9g2qstv3mYpC14XK78Fg06r2odLVoZLf+jLSGC3tAR4/S93tvJweenfCXckuDJb1T0VJBucNO8I0p7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827744; c=relaxed/simple;
	bh=VNY1hb0+9WBgQkpH7TTcDw8DF97qiuW0B5pJLm4Eus8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HhT0PE1tcUex4lVGmprGEOuHOaCgXHgkcfgOxQuNMdrtyNcjBZu57nmKCI8FN4IBoHDTlysdFuVtGW755FJNBMCYq3fLxJ4tBsIGPSrmm0DuQCGyDK57YMhxSFHy4Djx18sgwVNWSVivokhj75X38/wRx+uZJOJqDcQpwklyAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGGWKeCQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756827743; x=1788363743;
  h=date:from:to:cc:subject:message-id;
  bh=VNY1hb0+9WBgQkpH7TTcDw8DF97qiuW0B5pJLm4Eus8=;
  b=mGGWKeCQgSihTci/0dVcsZ64RInh8YvNbOBwQ1kj33yygpEh97L9dyq3
   NpLzf4+KMCfDN7D7dnL93ICA6LC0IiqS2YHjWWKT3TIP+HrL7j6Sc7wcD
   vIKovUEdKDQp7fStKwwKiVZ6/2uxymwTya711svup+1F5SVJGNU/uGw36
   /fD/cf9Q/9xety5mDrS3mNO9g80jGC4fz2QcF5G/Pk+e915mk/URgLz6P
   qE0c/+Dx0pgQjAh9XNSzPoYAFs/4yD3yUGRaqg2Lg4M2z5egw/PAJzKJ+
   h7ZgiSjgA1nbExGaWPCuYMM69tXH9DtyyFbe3c8pqf1EmUWfDD1PC3cKB
   w==;
X-CSE-ConnectionGUID: 5E4TieSKQ3mQtRmB/5RqMQ==
X-CSE-MsgGUID: hD6sYdhKTq6NtQaNUgqCVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59219113"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59219113"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:42:22 -0700
X-CSE-ConnectionGUID: rOFzDyxpSKSYbKLA092nZw==
X-CSE-MsgGUID: wjC6q2G3R9KgKH1CSVfHcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171277686"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2025 08:42:21 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utT9H-0002ha-0p;
	Tue, 02 Sep 2025 15:42:19 +0000
Date: Tue, 02 Sep 2025 23:39:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 dab104c81cbaf9677d367ca1ae8cd3ec8cc3d5bf
Message-ID: <202509022313.ek6EY47h-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: dab104c81cbaf9677d367ca1ae8cd3ec8cc3d5bf  PCI/AER: Print TLP Log for errors introduced since PCIe r1.1

elapsed time: 1415m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250902    gcc-11.5.0
arc                   randconfig-002-20250902    gcc-9.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                     davinci_all_defconfig    clang-19
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250902    gcc-15.1.0
arm                   randconfig-002-20250902    gcc-8.5.0
arm                   randconfig-003-20250902    clang-22
arm                   randconfig-004-20250902    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250902    gcc-8.5.0
arm64                 randconfig-002-20250902    clang-22
arm64                 randconfig-003-20250902    gcc-12.5.0
arm64                 randconfig-004-20250902    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250902    gcc-14.3.0
csky                  randconfig-002-20250902    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250902    clang-18
hexagon               randconfig-002-20250902    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250902    clang-20
i386        buildonly-randconfig-002-20250902    clang-20
i386        buildonly-randconfig-003-20250902    gcc-12
i386        buildonly-randconfig-004-20250902    clang-20
i386        buildonly-randconfig-005-20250902    gcc-12
i386        buildonly-randconfig-006-20250902    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250902    clang-22
loongarch             randconfig-002-20250902    clang-22
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
nios2                 randconfig-001-20250902    gcc-9.5.0
nios2                 randconfig-002-20250902    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250902    gcc-8.5.0
parisc                randconfig-002-20250902    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250902    gcc-9.5.0
powerpc               randconfig-002-20250902    gcc-8.5.0
powerpc               randconfig-003-20250902    gcc-11.5.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20250902    gcc-12.5.0
powerpc64             randconfig-002-20250902    clang-22
powerpc64             randconfig-003-20250902    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250902    gcc-13.4.0
riscv                 randconfig-002-20250902    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250902    clang-22
s390                  randconfig-002-20250902    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250902    gcc-12.5.0
sh                    randconfig-002-20250902    gcc-12.5.0
sh                           se7343_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250902    gcc-14.3.0
sparc                 randconfig-002-20250902    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250902    clang-20
sparc64               randconfig-002-20250902    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250902    gcc-12
um                    randconfig-002-20250902    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250902    clang-20
x86_64      buildonly-randconfig-002-20250902    clang-20
x86_64      buildonly-randconfig-003-20250902    clang-20
x86_64      buildonly-randconfig-004-20250902    gcc-12
x86_64      buildonly-randconfig-005-20250902    gcc-12
x86_64      buildonly-randconfig-006-20250902    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250902    gcc-9.5.0
xtensa                randconfig-002-20250902    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

