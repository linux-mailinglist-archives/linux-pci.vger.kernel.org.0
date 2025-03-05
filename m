Return-Path: <linux-pci+bounces-23008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F2A50AD7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B33175BD3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74F016426;
	Wed,  5 Mar 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0HsdyNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177341A317E
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201439; cv=none; b=LRnp2hS9XOGv8sg/olinj8I6blqnQF648f998cUCDzBpR5+8r/e5hJUYp+pVlQayzcwR7PZFyKq9xyKKXuhh4z1nyqyeF4vhVRFO5P7bHWcsL7kdCn91GIAaIMLqqF0/sgbRmbsgJH78HUErXiRign44xQ8lXafaFfe5zbmVQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201439; c=relaxed/simple;
	bh=dTTS61CT0hoesJp0cgKaIN+rDVuJeuIZqps4QJ/49cs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LcULNnUifRrXySZtj5XFcpiBa0f4ruOecaCsrHRUKPgB2EW4rUecncyX537/KP0FFdZD5zWjyv+PZZSETC9fcTfPsATVWNeycVvzxcO9uhIMswHuAIGErWQn4EevZDab7mS1f3o0ncOSEaKDv7dbTYq4o4+C1NhlVGWd+MBAnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0HsdyNg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741201438; x=1772737438;
  h=date:from:to:cc:subject:message-id;
  bh=dTTS61CT0hoesJp0cgKaIN+rDVuJeuIZqps4QJ/49cs=;
  b=G0HsdyNgJRiZjNTbDuCJCfHKLfzb1wrH4FyTKh4hiDjErxCi4BiOZxk1
   15qIEVXNl053ug8OX5qVacLs8ZikT9qpechjA9VJ0Z1AWBLLDI4+U92eo
   w3ANCrRSTrTP+OE15eqlrJQ1VORJqdhIf7pGglZW3Zc2bQwZY9MM9kWPd
   XZj50SGkqj9JAxGd1A3c89+IDoWX5EQxNmZS9TUjf0Q4z5p1E+StyOsdY
   I7TRT0SzrtAiJiAvlfZLh5hGwdg4fKICDFpmfg4gGbbvd4WKprhOUS2Qz
   OtcwTnvyMcrryVLX5GxfUIR47TyObTYS+JBVDMp+GhmzVVO0MGRZb1LtV
   w==;
X-CSE-ConnectionGUID: AbSbd2IlTWiLGz+gbp2qLA==
X-CSE-MsgGUID: 4PmKYqK9SpqejSXgvGpmPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53592926"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53592926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:03:57 -0800
X-CSE-ConnectionGUID: Yfde/io+R3KaAAzFXsMJzw==
X-CSE-MsgGUID: 7ctP1tpkSgaIrG9Y28VTzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123982296"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 05 Mar 2025 11:03:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpu25-000M4M-2z;
	Wed, 05 Mar 2025 19:03:53 +0000
Date: Thu, 06 Mar 2025 03:03:43 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 2cade109daca05a7dd25547a57e8350d94dc133d
Message-ID: <202503060337.qTHNiYjJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 2cade109daca05a7dd25547a57e8350d94dc133d  Merge branch 'pci/misc'

elapsed time: 1450m

configs tested: 86
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250305    gcc-13.2.0
arc                  randconfig-002-20250305    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250305    gcc-14.2.0
arm                  randconfig-002-20250305    clang-19
arm                  randconfig-003-20250305    gcc-14.2.0
arm                  randconfig-004-20250305    gcc-14.2.0
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
i386                               defconfig    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250305    gcc-14.2.0
loongarch            randconfig-002-20250305    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                            allnoconfig    gcc-14.2.0
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
sh                               allnoconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250305    gcc-14.2.0
sh                   randconfig-002-20250305    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                            allnoconfig    gcc-14.2.0
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
xtensa                           allnoconfig    gcc-14.2.0
xtensa               randconfig-001-20250305    gcc-14.2.0
xtensa               randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

