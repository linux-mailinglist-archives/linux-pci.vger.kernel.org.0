Return-Path: <linux-pci+bounces-22988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783AA5050E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05966188417F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30410BA27;
	Wed,  5 Mar 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EY/u56e2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF362E336E
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192469; cv=none; b=bwG6xwDhIWRoy/ZbKDTH6KQ38lEGo2ZfWap1JLRGiunAu5JHjj89CQ7LpmARMWDMECpyZF7M6OFmXMD1PPxtKPLQP93WlQFdH4CtWZWb6i0RKNHN64R6phsuo5PmYYFSEQ69TmWK3h/fYMcv9+EXIaWgPfQIv3lLtkxaydPbhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192469; c=relaxed/simple;
	bh=AymtKcT5W/jKWeM5ahcHpMxRKhfslIibyhua8lCl2jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DjIucxg1hNHabnxchat8rlgwdXfMbzzm4TAQkZzHZGz5OSKZ+VMg2ACYzfgiNmIezkkq3EMhX60JJ7Z8FcGVoeUDGEdlUAdlRCbzeeHROkTo1Redwx4znF4xBUTRJceP+X5whZOE0IlgvtUzvtqrWc45hA6iNQXu3f9w8zpIAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EY/u56e2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741192467; x=1772728467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AymtKcT5W/jKWeM5ahcHpMxRKhfslIibyhua8lCl2jw=;
  b=EY/u56e2xDvvejHuf0KwYss5zFELmY2I0bcJBGlQAWWhIROE5qezMYQI
   C46Dh4OMfCP3HigIU5jfHw6UBLAE+rPPqpGHhKAsCcXZBPGUrCpgoiADg
   BapT1HCY6d/xYbndQuCRDjap9wiQDNgoiWFU0MB1JE3ko+Vi1lN/dNekS
   yvovzlHHPVDi0upDicsREGr1kVdsDmrSh50oGKkI83iYK5+2/HKofrihy
   kWWdtP44o9Z/al8ezUAGxe+Pn4/2lOsO8oTi1VnHnrDnXEcnyRp1tS684
   iubQ5u68S1uuu97uRhc8UNw1tDIa3QNVo4eC6JaukiA4v57p9yQj75KHg
   A==;
X-CSE-ConnectionGUID: dVxYdULiSaqiwwqDhaeFqg==
X-CSE-MsgGUID: Ae3hCHk4TzqO6cGTQ7ZTfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42294975"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42294975"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:34:27 -0800
X-CSE-ConnectionGUID: hdXWvxCQRy6uVyJ7tqa4sw==
X-CSE-MsgGUID: u5Ipbo89QwC8Gos2/0ZSaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="119434665"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 05 Mar 2025 08:34:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tprhP-000LEU-15;
	Wed, 05 Mar 2025 16:34:23 +0000
Date: Thu, 06 Mar 2025 00:33:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 174cfcf13daf98bc4411a5a24a797d2b2f5546cd
Message-ID: <202503060020.c93KKlCL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 174cfcf13daf98bc4411a5a24a797d2b2f5546cd  PCI: brcmstb: Make irq_domain_set_info() parameter cast explicit

elapsed time: 1446m

configs tested: 83
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250305    gcc-13.2.0
arc                  randconfig-002-20250305    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250305    gcc-14.2.0
arm                  randconfig-002-20250305    clang-19
arm                  randconfig-003-20250305    gcc-14.2.0
arm                  randconfig-004-20250305    gcc-14.2.0
arm                        s3c6400_defconfig    gcc-14.2.0
arm                      versatile_defconfig    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250305    clang-15
arm64                randconfig-002-20250305    gcc-14.2.0
arm64                randconfig-003-20250305    clang-21
arm64                randconfig-004-20250305    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250305    gcc-14.2.0
csky                 randconfig-002-20250305    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250305    clang-21
hexagon              randconfig-002-20250305    clang-18
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250305    clang-19
i386       buildonly-randconfig-002-20250305    clang-19
i386       buildonly-randconfig-003-20250305    clang-19
i386       buildonly-randconfig-004-20250305    clang-19
i386       buildonly-randconfig-005-20250305    clang-19
i386       buildonly-randconfig-006-20250305    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250305    gcc-14.2.0
loongarch            randconfig-002-20250305    gcc-14.2.0
nios2                randconfig-001-20250305    gcc-14.2.0
nios2                randconfig-002-20250305    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250305    gcc-14.2.0
parisc               randconfig-002-20250305    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250305    clang-17
powerpc              randconfig-002-20250305    gcc-14.2.0
powerpc              randconfig-003-20250305    gcc-14.2.0
powerpc64            randconfig-001-20250305    clang-19
powerpc64            randconfig-002-20250305    clang-17
powerpc64            randconfig-003-20250305    clang-19
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250305    clang-19
riscv                randconfig-002-20250305    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250305    gcc-14.2.0
s390                 randconfig-002-20250305    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250305    gcc-14.2.0
sh                   randconfig-002-20250305    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250305    gcc-14.2.0
sparc                randconfig-002-20250305    gcc-14.2.0
sparc64              randconfig-001-20250305    gcc-14.2.0
sparc64              randconfig-002-20250305    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250305    clang-19
um                   randconfig-002-20250305    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250305    clang-19
x86_64     buildonly-randconfig-002-20250305    gcc-12
x86_64     buildonly-randconfig-003-20250305    clang-19
x86_64     buildonly-randconfig-004-20250305    gcc-12
x86_64     buildonly-randconfig-005-20250305    clang-19
x86_64     buildonly-randconfig-006-20250305    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250305    gcc-14.2.0
xtensa               randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

