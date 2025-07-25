Return-Path: <linux-pci+bounces-32949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F39B123B1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 20:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E21CC7406
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD48F6E;
	Fri, 25 Jul 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxChTFJF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D66241682
	for <linux-pci@vger.kernel.org>; Fri, 25 Jul 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467716; cv=none; b=TV2qAp0g1hHIGafRmpgfvqOulwNikpIkhuBvbA7yi4BQVjhfa54smT60LQqdktEc3VK/xzVw5GCDGG5kui94Xr3s+LYVNOoVNvBffG6LEFrnN1CGjNvM6y6BzEtElIBpqsc0g+S4Wf2KBAyLdia7yoeYxo0AaZglRkF+6DrAh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467716; c=relaxed/simple;
	bh=swmn/t/x4Z6j9aJ6V19bWZrETxbl4nHej7QrTwG9lyQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AHpO6VRYy8aXENGWL3XlWtWi8veN4ShEbSPtqCFCfRy7QYIyuAfOt6lml6T8lvzFZI4tLa9S7t0oRYmB20W+7/tEYZNUqwoZWIzusfTgNBDa7prOTDDR/EsZu6jtPgjim/FYx+d29Qz65wZCMx1pDpPWwLjUa54Thzo5RaOnQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxChTFJF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753467715; x=1785003715;
  h=date:from:to:cc:subject:message-id;
  bh=swmn/t/x4Z6j9aJ6V19bWZrETxbl4nHej7QrTwG9lyQ=;
  b=CxChTFJFY34jzC+s3cvlESihYoGRlQo6htlxZWI5N/Ds6U6zmuNH2Upl
   WVsY5BXWhsbyagv7Wzz2GByAYwXLdyru3ZWFFYyS/YvIdJznWL0QBlins
   //sNEs2sNcX6PF1TBZ/IwywdiR2bTd/+Cxw110I//mCQ0gznRCzj4bwMT
   u0Ruba5BsKZqsxD73qM3X53errPSNC6128/IlSmmNSgPteuF3pGGL/vjr
   VUCVOHqR286p0dMOLKIOPtwE+sjFFcWzolA/SvlyO/iWvxRDtKWHl50tZ
   NsDJ92P42hMKPOyRmI3/aycLydTnc9fhW17DJH9McVrswllimOtAF+gS8
   w==;
X-CSE-ConnectionGUID: /rsUDaHdTvOEasQnvTDJcg==
X-CSE-MsgGUID: W8DaZ/2QQ/S3hAZjG1HtiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="58429372"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="58429372"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 11:21:54 -0700
X-CSE-ConnectionGUID: Znx5gzRgStSnzVNMH1cSPg==
X-CSE-MsgGUID: lPgUtwTxTae3rOTxOKjpUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="198238645"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Jul 2025 11:21:53 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufN3G-000LV1-1h;
	Fri, 25 Jul 2025 18:21:50 +0000
Date: Sat, 26 Jul 2025 02:21:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:boot-display] BUILD SUCCESS
 6642adf0c1fbe2977597ab277dfd507053a874ac
Message-ID: <202507260235.j7K3TZds-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git boot-display
branch HEAD: 6642adf0c1fbe2977597ab277dfd507053a874ac  ALSA: hda: Use pci_is_display()

elapsed time: 1376m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250725    gcc-13.4.0
arc                   randconfig-002-20250725    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250725    gcc-15.1.0
arm                   randconfig-002-20250725    clang-22
arm                   randconfig-003-20250725    clang-20
arm                   randconfig-004-20250725    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250725    clang-22
arm64                 randconfig-002-20250725    gcc-12.5.0
arm64                 randconfig-003-20250725    gcc-14.3.0
arm64                 randconfig-004-20250725    clang-22
csky                  randconfig-001-20250725    gcc-11.5.0
csky                  randconfig-002-20250725    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250725    clang-22
hexagon               randconfig-002-20250725    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250725    gcc-12
i386        buildonly-randconfig-002-20250725    clang-20
i386        buildonly-randconfig-003-20250725    clang-20
i386        buildonly-randconfig-004-20250725    clang-20
i386        buildonly-randconfig-005-20250725    clang-20
i386        buildonly-randconfig-006-20250725    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch             randconfig-001-20250725    gcc-15.1.0
loongarch             randconfig-002-20250725    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250725    gcc-9.5.0
nios2                 randconfig-002-20250725    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250725    gcc-15.1.0
parisc                randconfig-002-20250725    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250725    gcc-8.5.0
powerpc               randconfig-002-20250725    clang-22
powerpc               randconfig-003-20250725    gcc-8.5.0
powerpc64             randconfig-001-20250725    clang-22
powerpc64             randconfig-002-20250725    gcc-8.5.0
powerpc64             randconfig-003-20250725    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250725    gcc-10.5.0
riscv                 randconfig-002-20250725    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250725    gcc-8.5.0
s390                  randconfig-002-20250725    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250725    gcc-15.1.0
sh                    randconfig-002-20250725    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250725    gcc-8.5.0
sparc                 randconfig-002-20250725    gcc-11.5.0
sparc64               randconfig-001-20250725    gcc-8.5.0
sparc64               randconfig-002-20250725    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250725    clang-22
um                    randconfig-002-20250725    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250725    clang-20
x86_64      buildonly-randconfig-002-20250725    clang-20
x86_64      buildonly-randconfig-003-20250725    clang-20
x86_64      buildonly-randconfig-004-20250725    clang-20
x86_64      buildonly-randconfig-005-20250725    gcc-12
x86_64      buildonly-randconfig-006-20250725    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250725    gcc-13.4.0
xtensa                randconfig-002-20250725    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

