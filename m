Return-Path: <linux-pci+bounces-37564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C02BB7DA7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E8347C98
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD415853B;
	Fri,  3 Oct 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hx47iPnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C512DD60E
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515288; cv=none; b=M0ZejvqSRwGFBfcaK7ZEFmi+/0vgai6yiesYkTIFCrbYQDzLtKxSl7VY3S/Jp+OM0hg3iN5KbLHWXf4aDg1l5f7udq4Di22dLSz56newihLsPheWvNMopdCaJ98/paGo3jBKXhi/ZZqXl85esp+cw90jzXYhaa6dpgqVd35KRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515288; c=relaxed/simple;
	bh=Ggc+m3YB9wcuSkSgHWOgWiVJAJ226PF5s51kNaN+sYY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tsypDYowVS+mGxoy3S9ZbM7pZRZC0kjS3oDQt9cY0KlwjMv8KxDf7/EDjfmtW+VXYFgM/Cqrw5TdulK+I2DVozwPsy7UaQHcguRe4/dsQmmF0asyUQc4HwAScSBeGN3n5imnIBExcc0bSCRCv7oZxD/c/nD3/CdldSKIYYxuvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hx47iPnR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759515287; x=1791051287;
  h=date:from:to:cc:subject:message-id;
  bh=Ggc+m3YB9wcuSkSgHWOgWiVJAJ226PF5s51kNaN+sYY=;
  b=hx47iPnRPhcmodfDfWRVrVYFdNmA+1VVWu21maDi33zKgpLho3QmWHCA
   DqYIvn0BA+szWvK4YVCiEAwFJLhOFq2B0ZUQpKa5FhNMB5PpKLAJdp94f
   eXXs5WabpuNFrMi1Y/vtAsvPosPfotMVR8bt5oaiob20w6zGVq75tBMtc
   oinZh6EbZqUeImkdcddPcr8ZO5HUoavNtLhE4II12O6SvSlfqceCBMY/o
   33auqtAA9L8TPNUaznIyPl6LQcmJO7Q39qg7NsWyYUD/zka6nuPeImEW/
   oAPhDIoJyrYj9kXdGfJOQ6V/Zt+XifSgHuhOKj7kvnM1g80kkHbFrwHNS
   Q==;
X-CSE-ConnectionGUID: 4iE4QP3MSOu9De2cuGqqaw==
X-CSE-MsgGUID: JWQ4Yp+gS5e55ol+x+egvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61710748"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="61710748"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 11:14:46 -0700
X-CSE-ConnectionGUID: KYqdhlDDRrCtP6+056c32A==
X-CSE-MsgGUID: iSg70SigQiiN/W7Z/YPgFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="179776563"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Oct 2025 11:14:45 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4kIl-0004nm-0R;
	Fri, 03 Oct 2025 18:14:43 +0000
Date: Sat, 04 Oct 2025 02:14:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd
Message-ID: <202510040218.bRoZTjch-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd  PCI: Set up bridge resources earlier

elapsed time: 1451m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251003    gcc-11.5.0
arc                   randconfig-002-20251003    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251003    gcc-12.5.0
arm                   randconfig-002-20251003    clang-22
arm                   randconfig-003-20251003    gcc-13.4.0
arm                   randconfig-004-20251003    gcc-13.4.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251003    gcc-13.4.0
arm64                 randconfig-002-20251003    clang-22
arm64                 randconfig-003-20251003    gcc-10.5.0
arm64                 randconfig-004-20251003    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251003    gcc-15.1.0
csky                  randconfig-002-20251003    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251003    clang-22
hexagon               randconfig-002-20251003    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251003    gcc-14
i386        buildonly-randconfig-002-20251003    gcc-12
i386        buildonly-randconfig-003-20251003    clang-20
i386        buildonly-randconfig-004-20251003    gcc-12
i386        buildonly-randconfig-005-20251003    clang-20
i386        buildonly-randconfig-006-20251003    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251003    gcc-15.1.0
loongarch             randconfig-002-20251003    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                   sb1250_swarm_defconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-22
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251003    gcc-8.5.0
nios2                 randconfig-002-20251003    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251003    gcc-9.5.0
parisc                randconfig-002-20251003    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251003    clang-22
powerpc               randconfig-002-20251003    gcc-8.5.0
powerpc               randconfig-003-20251003    clang-22
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20251003    gcc-12.5.0
powerpc64             randconfig-002-20251003    gcc-10.5.0
powerpc64             randconfig-003-20251003    clang-18
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251003    gcc-11.5.0
riscv                 randconfig-002-20251003    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251003    clang-22
s390                  randconfig-002-20251003    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251003    gcc-10.5.0
sh                    randconfig-002-20251003    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251003    gcc-14.3.0
sparc                 randconfig-002-20251003    gcc-13.4.0
sparc64               randconfig-001-20251003    clang-20
sparc64               randconfig-002-20251003    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251003    clang-22
um                    randconfig-002-20251003    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251003    clang-20
x86_64      buildonly-randconfig-002-20251003    gcc-14
x86_64      buildonly-randconfig-003-20251003    gcc-14
x86_64      buildonly-randconfig-004-20251003    gcc-14
x86_64      buildonly-randconfig-005-20251003    clang-20
x86_64      buildonly-randconfig-006-20251003    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251003    gcc-13.4.0
xtensa                randconfig-002-20251003    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

