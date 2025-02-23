Return-Path: <linux-pci+bounces-22119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2399A40C61
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 01:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4E7A7677
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E385383;
	Sun, 23 Feb 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZG24swcY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A85223
	for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740270239; cv=none; b=CTve9SUE4DUm9oinOY/DNEWd1UWe3cqPr0E6O0KnQIpm3fgNJSeY98q3dZ4BvL3Lbby4SKQ9TRQeoTLtgPMOMgYZshBMGHBIlkvAWUmqAvBmpDpg3u91BB4C5QdvVIHNXHXfJ6vitsBYqS1sRtUfR2RvqRCQykoK8bArOyjlyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740270239; c=relaxed/simple;
	bh=6vooT0+ZERfSF0WM/NS/TVos+QrmeVBXuyA+x33BP0U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Elsfh0Md29dj6Se50hvZkd4mMUjJLqXGCPYUor4XLgrMGhkOiWQFYvZkGICxaayKfvZp8AcUL+e3BJPCcmIIbjnfEevm5IKvLtme48olgiVcmx49TKhzVqOP02bOlO02+sK6HogNG/LUP4l1iN3win/pxTWMTgdl/RjQ2B0yg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZG24swcY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740270238; x=1771806238;
  h=date:from:to:cc:subject:message-id;
  bh=6vooT0+ZERfSF0WM/NS/TVos+QrmeVBXuyA+x33BP0U=;
  b=ZG24swcYI2etom578HpElsDYg1ZJ/pLg1OaUA8/CVW8/bXzzZbPHOxh2
   0rfSptqVoLndfuzELyKN7GloFzY+QMhO6Stl73BNQyOKAL4AO9m0wBewb
   zQGqgfXejIZ5EIeBuT3BJyQ6XtsCnoqZSLXHHh5VZNDpOxeWb28IY0Lzv
   ntE+y89tcDA/ZWKJW3kD2a8tE5ccR0Bi9EL3i71nCJ+4Q0EUSLLVLqEEM
   TOCcedk0qi4UC1SjZ9/lKT3hGIMKgtHJ+FSh5wearj0o34NLW325fGDnJ
   v8j1vPa7c9JwNPPXoEUiEUaem27N0Ae7oCmSJfBEFHyRZaskOCSPh/yu4
   g==;
X-CSE-ConnectionGUID: G/c56BydTSOLdzicT1UflQ==
X-CSE-MsgGUID: Mn/h1+wBSLCGA7WOxa+haQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="58474223"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="58474223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 16:23:58 -0800
X-CSE-ConnectionGUID: mqTDrZWMSWmbsEvg9HmOOw==
X-CSE-MsgGUID: kvga0TkdR8C8AdHq2AcbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="120627581"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2025 16:23:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlzmk-00070P-06;
	Sun, 23 Feb 2025 00:23:54 +0000
Date: Sun, 23 Feb 2025 08:23:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 7e077e6707b3428562ba30d883ff8f54e98dc18b
Message-ID: <202502230801.92ZbngVo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 7e077e6707b3428562ba30d883ff8f54e98dc18b  PCI/ERR: Handle TLP Log in Flit mode

elapsed time: 1449m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250222    gcc-13.2.0
arc                   randconfig-002-20250222    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250222    gcc-14.2.0
arm                   randconfig-002-20250222    gcc-14.2.0
arm                   randconfig-003-20250222    clang-16
arm                   randconfig-004-20250222    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250222    gcc-14.2.0
arm64                 randconfig-002-20250222    clang-21
arm64                 randconfig-003-20250222    clang-18
arm64                 randconfig-004-20250222    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250222    gcc-14.2.0
csky                  randconfig-002-20250222    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250222    clang-17
hexagon               randconfig-002-20250222    clang-19
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250222    clang-19
i386        buildonly-randconfig-002-20250222    gcc-12
i386        buildonly-randconfig-003-20250222    gcc-12
i386        buildonly-randconfig-004-20250222    clang-19
i386        buildonly-randconfig-005-20250222    gcc-12
i386        buildonly-randconfig-006-20250222    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250222    gcc-14.2.0
loongarch             randconfig-002-20250222    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250222    gcc-14.2.0
nios2                 randconfig-002-20250222    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250222    gcc-14.2.0
parisc                randconfig-002-20250222    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-21
powerpc               randconfig-001-20250222    gcc-14.2.0
powerpc               randconfig-002-20250222    gcc-14.2.0
powerpc               randconfig-003-20250222    gcc-14.2.0
powerpc64             randconfig-001-20250222    gcc-14.2.0
powerpc64             randconfig-002-20250222    clang-16
powerpc64             randconfig-003-20250222    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250222    clang-21
riscv                 randconfig-002-20250222    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250222    gcc-14.2.0
s390                  randconfig-002-20250222    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250222    gcc-14.2.0
sh                    randconfig-002-20250222    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250222    gcc-14.2.0
sparc                 randconfig-002-20250222    gcc-14.2.0
sparc64               randconfig-001-20250222    gcc-14.2.0
sparc64               randconfig-002-20250222    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250222    gcc-12
um                    randconfig-002-20250222    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250222    clang-19
x86_64      buildonly-randconfig-002-20250222    gcc-12
x86_64      buildonly-randconfig-003-20250222    gcc-12
x86_64      buildonly-randconfig-004-20250222    clang-19
x86_64      buildonly-randconfig-005-20250222    clang-19
x86_64      buildonly-randconfig-006-20250222    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250222    gcc-14.2.0
xtensa                randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

