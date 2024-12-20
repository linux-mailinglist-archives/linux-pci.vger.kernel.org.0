Return-Path: <linux-pci+bounces-18921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988219F9B19
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 21:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CF9169B98
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4E219A69;
	Fri, 20 Dec 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nG7TUIQ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A238DEC
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734726134; cv=none; b=GkmtbNSTrEx2oL0/xvs0fMqCGoTphgIkQNHTaT2+30rk/8Q21YcqbrksujkvMazeh1T5H5RNKEFxuQgze/g70Maoc8QDIAu58REgKoLNPZ8K4BRcWptVtw0ywFJaI8t7C5TjkBoL7np6iBFpQu5rnAod04hMEKUGjmNf1iSFYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734726134; c=relaxed/simple;
	bh=b9erl0cNeTw4UMnSVam0IGrkVO0XUgoo3b9KowtMYY0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q5GylBDElLKGmqrN+F7jz1cNf4kqGfts5Z1ADdqArk1xtqd4IZLzDBaYZp6aA12tH8aQIjnzUTFYq+RcVnvkdwjwSSxYvfXvTmsLSKajAtbLdswhNkvnx8V/pkH3ksZRu1rOE/yyOYoHORWVM1mbyY70Atgbdwpm5P7lLe/y5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nG7TUIQ8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734726134; x=1766262134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b9erl0cNeTw4UMnSVam0IGrkVO0XUgoo3b9KowtMYY0=;
  b=nG7TUIQ8dN2BHr2zrynIdl1xvgeZq/wlHo9tdTG4mu5Oo72dfCVZ6cL2
   exPJwdBFvmTVjuhsmuno//67gKI4nXNdgmxuUHS2WEImkb9CurnUyJEMM
   KINDBLlHkxmAKf9wDHQLmArGNRTWhAHBtN2rpCLHhYk/gSJQZXtP2/Ib4
   o7G14k/PiCXXNLkea345t2fyPlj6+OD51F3dMABxztYdAU/eGoeZc3NRB
   y1adWKxYVy1o2tqUTStrzYh5O0zUbM41kqDrmLBnWSsLm+KZ84MZKpyV/
   VVqOEP+aLKn0OczAqSbo+98SBo38FeMEbFXQjkuqdoatWsjebJTcyHYgV
   g==;
X-CSE-ConnectionGUID: 0lltYEYpSZqbhev036sBBA==
X-CSE-MsgGUID: VL6/Kc/QTiuJSkcAnTbA1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="34999197"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="34999197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:22:13 -0800
X-CSE-ConnectionGUID: pvZusHbnQ760/Y+z5Dnccg==
X-CSE-MsgGUID: rKPOnIhKRdyqYEOxnF4KkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="99123565"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Dec 2024 12:22:11 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOjVh-0001eV-12;
	Fri, 20 Dec 2024 20:22:09 +0000
Date: Sat, 21 Dec 2024 04:22:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 cd3e4149e2f60fe1abfdbe40cb64a9978922fd1c
Message-ID: <202412210458.rAVwr6HU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: cd3e4149e2f60fe1abfdbe40cb64a9978922fd1c  PCI: Don't include 'pm_wakeup.h' directly

elapsed time: 1446m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20241220    gcc-13.2.0
arc                  randconfig-002-20241220    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20241220    clang-19
arm                  randconfig-002-20241220    gcc-14.2.0
arm                  randconfig-003-20241220    gcc-14.2.0
arm                  randconfig-004-20241220    clang-20
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20241220    clang-17
arm64                randconfig-002-20241220    clang-19
arm64                randconfig-003-20241220    clang-20
arm64                randconfig-004-20241220    clang-19
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20241220    gcc-14.2.0
csky                 randconfig-002-20241220    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20241220    clang-20
hexagon              randconfig-002-20241220    clang-20
i386       buildonly-randconfig-001-20241220    gcc-12
i386       buildonly-randconfig-002-20241220    gcc-12
i386       buildonly-randconfig-003-20241220    gcc-12
i386       buildonly-randconfig-004-20241220    clang-19
i386       buildonly-randconfig-005-20241220    gcc-12
i386       buildonly-randconfig-006-20241220    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20241220    gcc-14.2.0
loongarch            randconfig-002-20241220    gcc-14.2.0
nios2                randconfig-001-20241220    gcc-14.2.0
nios2                randconfig-002-20241220    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20241220    gcc-14.2.0
parisc               randconfig-002-20241220    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20241220    clang-15
powerpc              randconfig-002-20241220    gcc-14.2.0
powerpc              randconfig-003-20241220    gcc-14.2.0
powerpc64            randconfig-001-20241220    gcc-14.2.0
powerpc64            randconfig-002-20241220    clang-19
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241220    gcc-14.2.0
riscv                randconfig-002-20241220    clang-19
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241220    gcc-14.2.0
s390                 randconfig-002-20241220    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241220    gcc-14.2.0
sh                   randconfig-002-20241220    gcc-14.2.0
sparc                randconfig-001-20241220    gcc-14.2.0
sparc                randconfig-002-20241220    gcc-14.2.0
sparc64              randconfig-001-20241220    gcc-14.2.0
sparc64              randconfig-002-20241220    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241220    clang-20
um                   randconfig-002-20241220    clang-20
x86_64     buildonly-randconfig-001-20241220    gcc-12
x86_64     buildonly-randconfig-002-20241220    clang-19
x86_64     buildonly-randconfig-003-20241220    gcc-12
x86_64     buildonly-randconfig-004-20241220    gcc-12
x86_64     buildonly-randconfig-005-20241220    clang-19
x86_64     buildonly-randconfig-006-20241220    gcc-12
xtensa               randconfig-001-20241220    gcc-14.2.0
xtensa               randconfig-002-20241220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

