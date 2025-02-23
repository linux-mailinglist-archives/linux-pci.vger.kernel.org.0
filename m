Return-Path: <linux-pci+bounces-22133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A75A40F74
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF3188C0C9
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55FBE5E;
	Sun, 23 Feb 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQXJJhtp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258C22612
	for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740324773; cv=none; b=A+YRhWwCpZbqQngxeytnFAxXPU0QMXfyp4teJaQ68BKl3XLFn9NuJyqrcfjAWuUTrODgaoGZZJfAId2Y/zDIDrmN1dZ4moZRnw+EtEQUod2WhEauhHohHgNNBvEsVbffRHuDLI+IDGE3Jjzi4rwDxc0a7yEFoExvfhV30Bez78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740324773; c=relaxed/simple;
	bh=gSbiptAqSFAFFjHBuVF+3iG1525ehdUV35824A5Gl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BFxptr+35WfMUz6XhMLKr6Ds07V31ePTShnfw4m6OwciSTHmI67whQ7AnPThZ2vVlom91qXTCAQC/UdMqY9OBA75qvhywTYRkCMzucDi4wUV5PeupdHvx6ngRkvfI5OR2uRsmEGf8yPXjS3E8cXFsiY4cdcJHdTfRGm+6kFKUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQXJJhtp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740324771; x=1771860771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gSbiptAqSFAFFjHBuVF+3iG1525ehdUV35824A5Gl3s=;
  b=IQXJJhtpmSsTdWE40jGkqUuFZHHBZ7D+RaEwrg97jbJa+JIveroNLWSO
   Scg/THKIb65XSVgfEjHNeaxO09ykY+Vix6dN0vCKYPKj0pAkyg8MVQvPR
   Jx9awN3YS43nsAPnEOmQXWJjXnvcv+0J+oShwDOM9m4SkM+TLQm+gRZho
   8HlqKdsdyuUXplF8z4MENlDKQTdTHPyH2mVerBcS5sWl/s7I4ThRWLFlX
   i3Ay30Goe2EGysm8geJ10Q0oJbqf4aRySh7LwMTytoTNTV3gtBJujsIbm
   y62RNn3SXg6J1yCcgRqBSaxyLVd7p5gBA+dKNlS3m+8jtXjQ08C/B8lfI
   w==;
X-CSE-ConnectionGUID: B3maN5g9QluJC3foKP/ZKA==
X-CSE-MsgGUID: +dJqbNXtR4afe3O/iI6OiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41227498"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41227498"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 07:32:51 -0800
X-CSE-ConnectionGUID: ou0yBw57QCydmWai/3GaAQ==
X-CSE-MsgGUID: JM3+1Fq+RL2n0NyniGlTFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115640886"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2025 07:32:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmDyK-0007Pu-0a;
	Sun, 23 Feb 2025 15:32:48 +0000
Date: Sun, 23 Feb 2025 23:32:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 4b3d7afe86c01d926a7267ef27e0f4708fa9cd4f
Message-ID: <202502232332.AoS9dTop-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 4b3d7afe86c01d926a7267ef27e0f4708fa9cd4f  PCI: dwc: pcie-qcom-ep: Enable EP mode support for SAR2130P

elapsed time: 1446m

configs tested: 105
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250223    gcc-13.2.0
arc                   randconfig-002-20250223    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250223    gcc-14.2.0
arm                   randconfig-002-20250223    clang-21
arm                   randconfig-003-20250223    clang-19
arm                   randconfig-004-20250223    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250223    clang-21
arm64                 randconfig-002-20250223    gcc-14.2.0
arm64                 randconfig-003-20250223    clang-21
arm64                 randconfig-004-20250223    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250223    gcc-14.2.0
csky                  randconfig-002-20250223    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250223    clang-21
hexagon               randconfig-002-20250223    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250223    clang-19
i386        buildonly-randconfig-002-20250223    gcc-11
i386        buildonly-randconfig-003-20250223    gcc-12
i386        buildonly-randconfig-004-20250223    clang-19
i386        buildonly-randconfig-005-20250223    gcc-12
i386        buildonly-randconfig-006-20250223    gcc-11
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250223    gcc-14.2.0
loongarch             randconfig-002-20250223    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250223    gcc-14.2.0
nios2                 randconfig-002-20250223    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250223    gcc-14.2.0
parisc                randconfig-002-20250223    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250223    gcc-14.2.0
powerpc               randconfig-002-20250223    clang-17
powerpc               randconfig-003-20250223    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250223    gcc-14.2.0
powerpc64             randconfig-002-20250223    clang-21
powerpc64             randconfig-003-20250223    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250223    clang-17
riscv                 randconfig-002-20250223    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250223    clang-18
s390                  randconfig-002-20250223    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250223    gcc-14.2.0
sh                    randconfig-002-20250223    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250223    gcc-14.2.0
sparc                 randconfig-002-20250223    gcc-14.2.0
sparc64               randconfig-001-20250223    gcc-14.2.0
sparc64               randconfig-002-20250223    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250223    clang-21
um                    randconfig-002-20250223    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250223    clang-19
x86_64      buildonly-randconfig-002-20250223    gcc-12
x86_64      buildonly-randconfig-003-20250223    gcc-12
x86_64      buildonly-randconfig-004-20250223    gcc-12
x86_64      buildonly-randconfig-005-20250223    gcc-12
x86_64      buildonly-randconfig-006-20250223    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250223    gcc-14.2.0
xtensa                randconfig-002-20250223    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

