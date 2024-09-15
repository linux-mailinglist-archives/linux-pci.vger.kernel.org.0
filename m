Return-Path: <linux-pci+bounces-13220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6439794B6
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 08:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251761C212D1
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339981B85D6;
	Sun, 15 Sep 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZU37vhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCE17BBE
	for <linux-pci@vger.kernel.org>; Sun, 15 Sep 2024 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726380878; cv=none; b=qCm9BxkFB2FyvvdFMtJgux3GzxL8wSnE2wdLPRHUTvePAQCy2dxxelUszXkebAfYu09SfvBZ/dr/k8nJoKClfndsXsnKInsnjWNk5Sd54gKPZSOneDJengGbQIwum7SPRouf8A2FQ8LNIAqskhOeY6TtYVYAy+kj4jpY5+rtAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726380878; c=relaxed/simple;
	bh=6+Y79+OrQELj+Y0DkAjpoXjkbuRjeGiW8xfAET1voK0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t7kx44CVh9qfItYnUxnp4Icl0BymU8bdaYzyfTU51zw7nFZsXPvYMttqDV1GPqCcftRJPr6ezMjeywT0Mjre479HuZXXfQ10uZSPxTIEhW7R5H0sqm7BGEzZDWO6bsfliOvrKSE9goFs8bfjqtEvF3rNP+mDXt8hsI1PCotVZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZU37vhC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726380876; x=1757916876;
  h=date:from:to:cc:subject:message-id;
  bh=6+Y79+OrQELj+Y0DkAjpoXjkbuRjeGiW8xfAET1voK0=;
  b=gZU37vhCJApy1FwPgYsA3rlMDuvjiV+aKdSMTHyVI+zlgvlJJUurN/xE
   ca3yFVGASqxkECMF+LA7NaVd0PBjp+UOn+8lyJDLwIyCvimEI9i7gpTIR
   rbu2ZY8+ECQe/6Ibe0sY+NmxcYZKye9G78B4RFS0hpZ2qLj7hm/aKadnG
   Uk15bv4BhUF/d81Nv45AZDCWik02neqviUikAu69jDXKGZC35DuZMWP8B
   8jd/KTPOzBNSKxRCS/+5J5FQr+oG7vgPA7skxFCsQEXcCk4dfrbhZ2Dmn
   tUQxy9BJc1SvVArr7CNTxIDcYlWFs7tRmK0w1iEgxPrrbUX1Dyl6WJj0H
   g==;
X-CSE-ConnectionGUID: vG1aXS58R4qGE4zZrIUUiw==
X-CSE-MsgGUID: KSCWovQ2QnmUg2HBiG8AjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="35917323"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="35917323"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 23:14:35 -0700
X-CSE-ConnectionGUID: 0Xfv1MBJS7OtG/vs9yJ4Uw==
X-CSE-MsgGUID: Ps3Eygw7R2+02vdG3hj+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="99399653"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Sep 2024 23:14:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spiWm-0008Ss-1P;
	Sun, 15 Sep 2024 06:14:32 +0000
Date: Sun, 15 Sep 2024 14:13:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 2374573159edb97630d45dd7dc22a527e0bd215f
Message-ID: <202409151454.axxlD5JJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 2374573159edb97630d45dd7dc22a527e0bd215f  Merge branch 'pci/tools'

elapsed time: 1754m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20240915    gcc-13.2.0
arc                   randconfig-002-20240915    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20240915    gcc-14.1.0
arm                   randconfig-002-20240915    clang-17
arm                   randconfig-003-20240915    clang-20
arm                   randconfig-004-20240915    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240915    clang-20
arm64                 randconfig-002-20240915    gcc-14.1.0
arm64                 randconfig-003-20240915    clang-20
arm64                 randconfig-004-20240915    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240915    gcc-14.1.0
csky                  randconfig-002-20240915    gcc-14.1.0
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20240915    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240915    gcc-12
i386        buildonly-randconfig-002-20240915    clang-18
i386        buildonly-randconfig-003-20240915    clang-18
i386        buildonly-randconfig-004-20240915    gcc-12
i386        buildonly-randconfig-005-20240915    clang-18
i386        buildonly-randconfig-006-20240915    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240915    clang-18
i386                  randconfig-002-20240915    clang-18
i386                  randconfig-003-20240915    clang-18
i386                  randconfig-004-20240915    clang-18
i386                  randconfig-005-20240915    clang-18
i386                  randconfig-006-20240915    clang-18
i386                  randconfig-011-20240915    clang-18
i386                  randconfig-012-20240915    gcc-12
i386                  randconfig-013-20240915    gcc-12
i386                  randconfig-014-20240915    clang-18
i386                  randconfig-015-20240915    gcc-12
i386                  randconfig-016-20240915    gcc-12
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240915    gcc-14.1.0
loongarch             randconfig-002-20240915    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240915    gcc-14.1.0
nios2                 randconfig-002-20240915    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240915    gcc-14.1.0
parisc                randconfig-002-20240915    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc               randconfig-001-20240915    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
um                                allnoconfig    clang-17
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240915    gcc-12
x86_64      buildonly-randconfig-002-20240915    gcc-12
x86_64      buildonly-randconfig-003-20240915    clang-18
x86_64      buildonly-randconfig-004-20240915    clang-18
x86_64      buildonly-randconfig-005-20240915    clang-18
x86_64      buildonly-randconfig-006-20240915    gcc-12
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20240915    clang-18
x86_64                randconfig-002-20240915    gcc-12
x86_64                randconfig-003-20240915    gcc-12
x86_64                randconfig-004-20240915    clang-18
x86_64                randconfig-005-20240915    clang-18
x86_64                randconfig-006-20240915    clang-18
x86_64                randconfig-011-20240915    gcc-12
x86_64                randconfig-012-20240915    clang-18
x86_64                randconfig-013-20240915    gcc-12
x86_64                randconfig-014-20240915    gcc-12
x86_64                randconfig-015-20240915    gcc-12
x86_64                randconfig-016-20240915    clang-18
x86_64                randconfig-071-20240915    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

