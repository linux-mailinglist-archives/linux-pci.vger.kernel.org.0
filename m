Return-Path: <linux-pci+bounces-29033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95EACF11F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35579188B266
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE525F968;
	Thu,  5 Jun 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCl9i1bU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312025F960
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131016; cv=none; b=Bexhb0cUnrveQIo88u+cT1HJ7W+XxxPE3O2m3UCUFHxD6ib3xjrjDXUnF6yAfyFMwGPsoogitRNP3uALNFQnQHfwFcSbjAueO4vzOJtb+czwckjd9ySJjAz8OxQbRwDaxKjnlvHAA1Sevl8G0je17YCvoh5VlBlY3f5l7x5lHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131016; c=relaxed/simple;
	bh=8ERtCECkCNDBG9p+9T0rKmRn5wuUOTszJy6stNd7ngU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qugmo751ptZjgWr4POAHtBv66bqOhxB1wcX+9SxCQYjLzToui089KSPpcN702hNe71aSDMbv6uEjV3Yb2tSlVW7SbpgqR0xGmO5yDuvj26I5IQeRtad2zKUYBPURv+q8qh92z4iH8ou7WhhxviRXg/8ebXGzRx1nGPgNMhFTqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCl9i1bU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749131015; x=1780667015;
  h=date:from:to:cc:subject:message-id;
  bh=8ERtCECkCNDBG9p+9T0rKmRn5wuUOTszJy6stNd7ngU=;
  b=hCl9i1bUvJl9E3C5TV+CbQ1oP/S6v/WMkbWX+RMfksIC65UrLMp8mXvt
   ypxsZwLs38Wp86XlIsJBGgAvVQWMJxSHACvH1/n6XMwxJ4tMumdRjwPH+
   fmWwfmEYFsr16G3pn90+s0wqLfEhtGQVSZik8aNFAH1iUX37zeyOPDCnR
   rl/uL/3Ckm+jtHQyyVhIvTpftGykaBMwxg3v9MzV91vggOipvPq6yQ0Rz
   D1gJI0fo6NM/xNgafmqRPcWn3gAhqeSjiODul5r3DyUG17K4p9Lsz/cot
   FZr1WF9eh36xsHefUfcT+RvvLoei4wky40KlF3epBsF0IqgU7aX7+Ig1N
   A==;
X-CSE-ConnectionGUID: R3LMcPmgT0W6YSv8O/XxYw==
X-CSE-MsgGUID: Ss/oupXcTFusnCgIjHiF5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="61914073"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="61914073"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:43:27 -0700
X-CSE-ConnectionGUID: M2vjcOlWSPye6CQbyMoyjg==
X-CSE-MsgGUID: 2u71NkbfSue/kLPQ+MmLhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="168685446"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Jun 2025 06:43:26 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNAsO-00048t-0d;
	Thu, 05 Jun 2025 13:43:24 +0000
Date: Thu, 05 Jun 2025 21:43:00 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 308f8c7a626ecd5b9be67181ae67660e165a29b5
Message-ID: <202506052150.xADYILM5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 308f8c7a626ecd5b9be67181ae67660e165a29b5  MAINTAINERS: Update Manivannan Sadhasivam email address

elapsed time: 1338m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250605    gcc-15.1.0
arc                   randconfig-002-20250605    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                     davinci_all_defconfig    clang-19
arm                          gemini_defconfig    clang-20
arm                      integrator_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250605    clang-21
arm                   randconfig-002-20250605    clang-17
arm                   randconfig-003-20250605    clang-21
arm                   randconfig-004-20250605    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250605    clang-21
arm64                 randconfig-002-20250605    clang-21
arm64                 randconfig-003-20250605    clang-21
arm64                 randconfig-004-20250605    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250605    gcc-10.5.0
csky                  randconfig-002-20250605    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250605    clang-21
hexagon               randconfig-002-20250605    clang-20
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250605    gcc-12
i386        buildonly-randconfig-002-20250605    clang-20
i386        buildonly-randconfig-003-20250605    gcc-12
i386        buildonly-randconfig-004-20250605    clang-20
i386        buildonly-randconfig-005-20250605    clang-20
i386        buildonly-randconfig-006-20250605    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250605    gcc-12.4.0
loongarch             randconfig-002-20250605    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250605    gcc-14.2.0
nios2                 randconfig-002-20250605    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250605    gcc-9.3.0
parisc                randconfig-002-20250605    gcc-11.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      bamboo_defconfig    clang-21
powerpc                        icon_defconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-21
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250605    clang-21
powerpc               randconfig-002-20250605    clang-21
powerpc               randconfig-003-20250605    clang-21
powerpc64             randconfig-001-20250605    clang-18
powerpc64             randconfig-002-20250605    clang-21
powerpc64             randconfig-003-20250605    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250605    clang-21
riscv                 randconfig-002-20250605    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250605    clang-21
s390                  randconfig-002-20250605    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250605    gcc-12.4.0
sh                    randconfig-002-20250605    gcc-12.4.0
sh                           se7619_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250605    gcc-11.5.0
sparc                 randconfig-002-20250605    gcc-7.5.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250605    gcc-12.4.0
sparc64               randconfig-002-20250605    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250605    clang-21
um                    randconfig-002-20250605    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250605    clang-20
x86_64      buildonly-randconfig-002-20250605    gcc-12
x86_64      buildonly-randconfig-003-20250605    clang-20
x86_64      buildonly-randconfig-004-20250605    clang-20
x86_64      buildonly-randconfig-005-20250605    gcc-12
x86_64      buildonly-randconfig-006-20250605    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250605    gcc-7.5.0
xtensa                randconfig-002-20250605    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

