Return-Path: <linux-pci+bounces-28320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88271AC2198
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 12:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E287B60BC
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827B22A4E9;
	Fri, 23 May 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIiezokW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC222A7ED
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997744; cv=none; b=qrSocoa1h5Hvkz/bOA38Gs04LYbRu+fdUgAE3ytftwpjkjBatiyTqNc5kTFfrdbqY0yspZ5vEZEuyNzgAuN4L+e21qKVNCaNvRbLn9MQ/v1AFNmAKhcpGcLC1q9a5htH0VnUp69b2JFnYDtADooKxlylWUhyrjZajdzoabkaQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997744; c=relaxed/simple;
	bh=zIipuQRntw6cGC0S2eE+n/AFtMTMuU9Dytn3hwuEtNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mB37WFL0RafDvXRtN7r3pbgEiy0cQzUf4EGEI8E00m8r2QBKxs9D1Tc36MsfHKH9IlCAlnzJAbLfDL4KgCJ9tI73htp+7+j90s5JFDJKFCSTHWp1JhnXBYGBtwczt2L5RjPY9+RR/kuqFnN8cESraCMfQFSfW4mSS4W5YGu3tAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIiezokW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747997743; x=1779533743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zIipuQRntw6cGC0S2eE+n/AFtMTMuU9Dytn3hwuEtNg=;
  b=hIiezokWwtMQACgNZF0H3KtcYS1KT6xzS925Y1Beizk9/eTVS5JSAJiO
   o4WXfCAt10N/WpTJttfJYmH+KAH5guFsVRlPDAaf/3EG/pph/liJmZFCx
   DH8wuNPYYctUG5r+Ss6AOW6xFgvJlbOa85MgarwjsxUrrp08bUXT3ZTgW
   +MI4vyuAPGWV45XyL8592JyhSmqV/iPfbDECk4MzMfysoygWTLpUpVCMF
   j0evI1HDdzc0Off3jWFcKr4zA013OmkDX5khoREeL8CbcigYmv7ZvTJ1j
   Hs9/4oXo2COR72svTtd8MgQCcXVWco+CTpzik+x+8zdinzo/tcK8n15bF
   w==;
X-CSE-ConnectionGUID: +LpV2iUKRbaNEbBFxqKCyg==
X-CSE-MsgGUID: vsRksepDTA6xORYAg8o3xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53713224"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="53713224"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 03:55:42 -0700
X-CSE-ConnectionGUID: EqYgUd5QTaKVxEXj8VckLg==
X-CSE-MsgGUID: NiCWGOWCQ0eUZ1qtUXZjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="172069734"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 May 2025 03:55:41 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIQ3v-000QJT-0V;
	Fri, 23 May 2025 10:55:39 +0000
Date: Fri, 23 May 2025 18:55:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pci-acpi] BUILD SUCCESS
 631b2af2f35737750af284be22e63da56bf20139
Message-ID: <202505231811.xbDtYigh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-acpi
branch HEAD: 631b2af2f35737750af284be22e63da56bf20139  PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()

elapsed time: 1393m

configs tested: 250
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250522    gcc-15.1.0
arc                   randconfig-001-20250523    clang-16
arc                   randconfig-002-20250522    gcc-15.1.0
arc                   randconfig-002-20250523    clang-16
arc                           tb10x_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-21
arm                      jornada720_defconfig    clang-21
arm                   randconfig-001-20250522    clang-21
arm                   randconfig-001-20250523    clang-16
arm                   randconfig-002-20250522    clang-21
arm                   randconfig-002-20250523    clang-16
arm                   randconfig-003-20250522    clang-18
arm                   randconfig-003-20250523    clang-16
arm                   randconfig-004-20250522    gcc-7.5.0
arm                   randconfig-004-20250523    clang-16
arm                       spear13xx_defconfig    clang-21
arm                           stm32_defconfig    clang-21
arm                         wpcm450_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250522    clang-21
arm64                 randconfig-001-20250523    clang-16
arm64                 randconfig-002-20250522    gcc-7.5.0
arm64                 randconfig-002-20250523    clang-16
arm64                 randconfig-003-20250522    clang-21
arm64                 randconfig-003-20250523    clang-16
arm64                 randconfig-004-20250522    gcc-5.5.0
arm64                 randconfig-004-20250523    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250522    gcc-15.1.0
csky                  randconfig-001-20250523    gcc-10.5.0
csky                  randconfig-002-20250522    gcc-15.1.0
csky                  randconfig-002-20250523    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250522    clang-17
hexagon               randconfig-001-20250523    gcc-10.5.0
hexagon               randconfig-002-20250522    clang-21
hexagon               randconfig-002-20250523    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250522    clang-20
i386        buildonly-randconfig-001-20250523    clang-20
i386        buildonly-randconfig-002-20250522    gcc-12
i386        buildonly-randconfig-002-20250523    clang-20
i386        buildonly-randconfig-003-20250522    gcc-12
i386        buildonly-randconfig-003-20250523    clang-20
i386        buildonly-randconfig-004-20250522    gcc-12
i386        buildonly-randconfig-004-20250523    clang-20
i386        buildonly-randconfig-005-20250522    gcc-12
i386        buildonly-randconfig-005-20250523    clang-20
i386        buildonly-randconfig-006-20250522    clang-20
i386        buildonly-randconfig-006-20250523    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250523    gcc-12
i386                  randconfig-002-20250523    gcc-12
i386                  randconfig-003-20250523    gcc-12
i386                  randconfig-004-20250523    gcc-12
i386                  randconfig-005-20250523    gcc-12
i386                  randconfig-006-20250523    gcc-12
i386                  randconfig-007-20250523    gcc-12
i386                  randconfig-011-20250523    gcc-12
i386                  randconfig-012-20250523    gcc-12
i386                  randconfig-013-20250523    gcc-12
i386                  randconfig-014-20250523    gcc-12
i386                  randconfig-015-20250523    gcc-12
i386                  randconfig-016-20250523    gcc-12
i386                  randconfig-017-20250523    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250522    gcc-15.1.0
loongarch             randconfig-001-20250523    gcc-10.5.0
loongarch             randconfig-002-20250522    gcc-15.1.0
loongarch             randconfig-002-20250523    gcc-10.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    clang-21
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-21
microblaze                       alldefconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
mips                          rb532_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250522    gcc-9.3.0
nios2                 randconfig-001-20250523    gcc-10.5.0
nios2                 randconfig-002-20250522    gcc-9.3.0
nios2                 randconfig-002-20250523    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    clang-21
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250522    gcc-6.5.0
parisc                randconfig-001-20250523    gcc-10.5.0
parisc                randconfig-002-20250522    gcc-12.4.0
parisc                randconfig-002-20250523    gcc-10.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       ebony_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250522    gcc-9.3.0
powerpc               randconfig-001-20250523    gcc-10.5.0
powerpc               randconfig-002-20250522    clang-21
powerpc               randconfig-002-20250523    gcc-10.5.0
powerpc               randconfig-003-20250522    gcc-7.5.0
powerpc               randconfig-003-20250523    gcc-10.5.0
powerpc                         wii_defconfig    clang-21
powerpc64             randconfig-001-20250522    clang-21
powerpc64             randconfig-001-20250523    gcc-10.5.0
powerpc64             randconfig-002-20250522    gcc-10.5.0
powerpc64             randconfig-002-20250523    gcc-10.5.0
powerpc64             randconfig-003-20250522    gcc-7.5.0
powerpc64             randconfig-003-20250523    gcc-10.5.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250522    gcc-9.3.0
riscv                 randconfig-001-20250523    gcc-11.5.0
riscv                 randconfig-002-20250522    clang-18
riscv                 randconfig-002-20250523    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250522    clang-19
s390                  randconfig-001-20250523    gcc-11.5.0
s390                  randconfig-002-20250522    clang-18
s390                  randconfig-002-20250523    gcc-11.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    clang-21
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250522    gcc-13.3.0
sh                    randconfig-001-20250523    gcc-11.5.0
sh                    randconfig-002-20250522    gcc-13.3.0
sh                    randconfig-002-20250523    gcc-11.5.0
sh                           se7780_defconfig    clang-21
sh                              ul2_defconfig    clang-21
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250522    gcc-14.2.0
sparc                 randconfig-001-20250523    gcc-11.5.0
sparc                 randconfig-002-20250522    gcc-6.5.0
sparc                 randconfig-002-20250523    gcc-11.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250522    gcc-14.2.0
sparc64               randconfig-001-20250523    gcc-11.5.0
sparc64               randconfig-002-20250522    gcc-12.4.0
sparc64               randconfig-002-20250523    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250522    gcc-12
um                    randconfig-001-20250523    gcc-11.5.0
um                    randconfig-002-20250522    gcc-12
um                    randconfig-002-20250523    gcc-11.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250522    clang-20
x86_64      buildonly-randconfig-001-20250523    gcc-12
x86_64      buildonly-randconfig-002-20250522    gcc-12
x86_64      buildonly-randconfig-002-20250523    gcc-12
x86_64      buildonly-randconfig-003-20250522    gcc-12
x86_64      buildonly-randconfig-003-20250523    gcc-12
x86_64      buildonly-randconfig-004-20250522    gcc-12
x86_64      buildonly-randconfig-004-20250523    gcc-12
x86_64      buildonly-randconfig-005-20250522    gcc-12
x86_64      buildonly-randconfig-005-20250523    gcc-12
x86_64      buildonly-randconfig-006-20250522    gcc-12
x86_64      buildonly-randconfig-006-20250523    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250523    clang-20
x86_64                randconfig-002-20250523    clang-20
x86_64                randconfig-003-20250523    clang-20
x86_64                randconfig-004-20250523    clang-20
x86_64                randconfig-005-20250523    clang-20
x86_64                randconfig-006-20250523    clang-20
x86_64                randconfig-007-20250523    clang-20
x86_64                randconfig-008-20250523    clang-20
x86_64                randconfig-071-20250523    clang-20
x86_64                randconfig-072-20250523    clang-20
x86_64                randconfig-073-20250523    clang-20
x86_64                randconfig-074-20250523    clang-20
x86_64                randconfig-075-20250523    clang-20
x86_64                randconfig-076-20250523    clang-20
x86_64                randconfig-077-20250523    clang-20
x86_64                randconfig-078-20250523    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250522    gcc-14.2.0
xtensa                randconfig-001-20250523    gcc-11.5.0
xtensa                randconfig-002-20250522    gcc-10.5.0
xtensa                randconfig-002-20250523    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

