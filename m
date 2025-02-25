Return-Path: <linux-pci+bounces-22357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32FDA44743
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EB17AED36
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27DC192D86;
	Tue, 25 Feb 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNXPYH2q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A0192B75
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502244; cv=none; b=KggDxdws9JcMISfL6DBiCqWYr9goJOXn8dOAVZKFFRcP6d0yx2vEmCxJlILc6VcaoP+P9s9pRHR4kYrPzAaxD0HtWUT6uxxwLUDUDZ5Ud0XaqkKmlJ+Q9qcLIMKLbm5p8IQNJ7QKoeMwq4V3lELMhP+wSDYnXuil09xDJIobD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502244; c=relaxed/simple;
	bh=93YRs9oXTJGWSG//+MSuYb+o43flW0SPpXWPbsu3W1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Znzf6EwgPsUSkn62nG3HTrGIN+SXqxd8K+dU2fEZpN66V8iGzZAd7IV1uAKk6ubLowG0gZ+fsYZoB/3GfMIeBfvHFYBNthROKbxPTfrcG4jV9ypZiv3Mh1eE5Q2aGmtAFcScQZLsAPjIl1Qki1Ja5RZlwdCeJTtoggu2VseEE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNXPYH2q; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740502243; x=1772038243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=93YRs9oXTJGWSG//+MSuYb+o43flW0SPpXWPbsu3W1k=;
  b=UNXPYH2qhF+vFNBXsOyOnxaS5cXcGnkWMhoY/MtjSAeRdy68r/Xg0wGH
   i3Ay7XcyyknjcxEck6wNYPhli/iIb7VW1mF/gqoWKL/DnRkFEjiUOlmuN
   LNU9nBGT0Ksv2/fd9IbRvmKpp0AZQmXDFOAmo6mY/F5V0Z3ndJ9qfLaCy
   Pv38KtCFPnpcmx2wBL0fpJJQnzIxMn2uNcT6qywrBdLYqKviUNCh2Qjai
   XdrrBOPtDgLjaNv//id+Qv5vQ9ECDfx0ajPIqrdN2UNlo+qHQndglPmnL
   Idq2nzo53vvFokdHCeo3t8ECSGlaIhfuEe5nmGrk08SgSms018Hm4Ry5T
   w==;
X-CSE-ConnectionGUID: Yh1DYcXvT82nsnUwkO+09Q==
X-CSE-MsgGUID: BlKzk6UxSeOaQsItFQlHRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41197865"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41197865"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 08:50:42 -0800
X-CSE-ConnectionGUID: CViOYyNNQSGr7PF6AywnJg==
X-CSE-MsgGUID: 6HDC36HTSauVhivdVOcZ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147337388"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 08:50:41 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmy8L-000AVJ-2w;
	Tue, 25 Feb 2025 16:50:21 +0000
Date: Wed, 26 Feb 2025 00:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 42c812d07088777a3439e51bd1461d215151150e
Message-ID: <202502260012.0jBCQVTe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 42c812d07088777a3439e51bd1461d215151150e  PCI: qcom-ep: Enable EP mode support for SAR2130P

elapsed time: 1280m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250225    gcc-13.2.0
arc                   randconfig-002-20250225    gcc-13.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250225    gcc-14.2.0
arm                   randconfig-002-20250225    gcc-14.2.0
arm                   randconfig-003-20250225    gcc-14.2.0
arm                   randconfig-004-20250225    clang-15
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250225    clang-19
arm64                 randconfig-002-20250225    clang-17
arm64                 randconfig-003-20250225    clang-15
arm64                 randconfig-004-20250225    clang-21
csky                  randconfig-001-20250225    gcc-14.2.0
csky                  randconfig-002-20250225    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250225    clang-21
hexagon               randconfig-002-20250225    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250225    clang-19
i386        buildonly-randconfig-002-20250225    gcc-11
i386        buildonly-randconfig-003-20250225    clang-19
i386        buildonly-randconfig-004-20250225    clang-19
i386        buildonly-randconfig-005-20250225    gcc-12
i386        buildonly-randconfig-006-20250225    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250225    gcc-14.2.0
loongarch             randconfig-002-20250225    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250225    gcc-14.2.0
nios2                 randconfig-002-20250225    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250225    gcc-14.2.0
parisc                randconfig-002-20250225    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250225    gcc-14.2.0
powerpc               randconfig-002-20250225    clang-19
powerpc               randconfig-003-20250225    clang-21
powerpc64             randconfig-001-20250225    gcc-14.2.0
powerpc64             randconfig-002-20250225    gcc-14.2.0
powerpc64             randconfig-003-20250225    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250225    clang-15
riscv                 randconfig-002-20250225    clang-21
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250225    clang-15
s390                  randconfig-002-20250225    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250225    gcc-14.2.0
sh                    randconfig-002-20250225    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250225    gcc-14.2.0
sparc                 randconfig-002-20250225    gcc-14.2.0
sparc64               randconfig-001-20250225    gcc-14.2.0
sparc64               randconfig-002-20250225    gcc-14.2.0
um                               allmodconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250225    clang-21
um                    randconfig-002-20250225    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250225    gcc-12
x86_64      buildonly-randconfig-002-20250225    clang-19
x86_64      buildonly-randconfig-003-20250225    clang-19
x86_64      buildonly-randconfig-004-20250225    gcc-11
x86_64      buildonly-randconfig-005-20250225    gcc-12
x86_64      buildonly-randconfig-006-20250225    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250225    gcc-14.2.0
xtensa                randconfig-002-20250225    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

