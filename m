Return-Path: <linux-pci+bounces-22117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094DA40C14
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 00:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7C2173CEC
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 23:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61D1FBC9F;
	Sat, 22 Feb 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqzPT3/x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAB1A2397
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265710; cv=none; b=E8YUrJbHqIJtJ1Tihq99Fqb7iMffheNjDNBndbgirUA604tej+G3Ym76MLdQMxZLfbDVhZDw6VsTRL7dYj4K+igy51WgjuTnnONOu/kdzqocAjNTHE6o5SFWU6CVMmUU+ryd/0+GnqFbv7Nm66uj7snYn9V4Kh1SbwfiGP591yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265710; c=relaxed/simple;
	bh=bNbh8sZTWxKbvpgcIYq/XKfJF8iTmG8JJsnLeQvlGvY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vCUMFh0/b+X8W+yavlgdMjvRrOHjmXuI4XD3BGJDcizuyCJ4WQg95+bYdqavq2hKxhTNtDbqGW7W1JJerVOpdKh3z9+DzVHibO0Q9bwMVOdOAymkgKgIjf81ejlEvx89LgxImNf4ZdT0j7tyUZWMxaqQvKUJiyNlssxkLPMgYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqzPT3/x; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740265709; x=1771801709;
  h=date:from:to:cc:subject:message-id;
  bh=bNbh8sZTWxKbvpgcIYq/XKfJF8iTmG8JJsnLeQvlGvY=;
  b=MqzPT3/xkUXjvTiAK9PGsIfQkzZEBg5uviJoVwkCYb1MzdiE5v5UiC+U
   U8IJVmCyDEpOYR4n5dbttNqQ6IS6SvuNoQ0P91JSYKW9F3X9f4tQvvfU2
   LAUpEKJ/0vmIzdc3atFhK2fJ+6gMYrcilnmQdlCryuLLEiS0AkKMaYpjj
   o3C4ADe6bxi8EOKrRgXJH6EuviLIuvqggjif9TfhhJJTAgm2T//cwgDyN
   9tLLOc9bOntSiUimLnJMdPAiZ9CdWCugxDl3ARuQgHGLq0fe57Rz0fjZs
   CSOLeSA75+ak2Pd91OFq9NQVrf6p4kU23LFixGfHo7EmoAqUhHZuiP35b
   g==;
X-CSE-ConnectionGUID: kVZaWtDZTAm8gLIiQaViYA==
X-CSE-MsgGUID: LCf8djcxRY2zSHIH5N5PZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="41177963"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="41177963"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 15:08:29 -0800
X-CSE-ConnectionGUID: ZFBl0l9HS2yqMSVVWkPVCg==
X-CSE-MsgGUID: xkJBysHxRc+t6W67+RgPnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146600912"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Feb 2025 15:08:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlybg-0006yZ-23;
	Sat, 22 Feb 2025 23:08:24 +0000
Date: Sun, 23 Feb 2025 07:07:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:acs] BUILD SUCCESS
 9cf8a952d57b422d3ff8a9a0163f8adf694f4b2b
Message-ID: <202502230733.muFD60xp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git acs
branch HEAD: 9cf8a952d57b422d3ff8a9a0163f8adf694f4b2b  PCI/ACS: Fix 'pci=config_acs=' parameter

elapsed time: 1446m

configs tested: 73
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250222    clang-19
i386       buildonly-randconfig-002-20250222    gcc-12
i386       buildonly-randconfig-003-20250222    gcc-12
i386       buildonly-randconfig-004-20250222    clang-19
i386       buildonly-randconfig-005-20250222    gcc-12
i386       buildonly-randconfig-006-20250222    clang-19
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

