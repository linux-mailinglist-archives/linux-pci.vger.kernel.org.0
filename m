Return-Path: <linux-pci+bounces-23689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD717A603D1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 23:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29CF17F8C3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 22:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E81F4634;
	Thu, 13 Mar 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp1/1C4c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD737FBAC
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903258; cv=none; b=b8gqU9FArgCRLvDeJvQsUvVj5p2uV82SCFVjLHgPmAkDZ1zmQo7DU0vOrkY4IBM+AnpAYfsp4ZhorKetEz3ijxd+uV4g0k2/DwBIWnbs0Abzfv+eEGwK6gUve+1SA5MaDXKxDKDw2sBkufmmRIfRA/JUU5VohcZ0TmgTn6kY3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903258; c=relaxed/simple;
	bh=U5Tg5xg7oPnSkdGd7Sduxr4Ry0EiVBXyUmSIKItYGXI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gF6rsuAHrrvtZPLibKphjpd6IpcZkYOMXi4bJIsTGG2LcbyFRpHLz7D0qSkW+kpJ36bbxnrFoqM+Ddi4FFgfsnczELYiFDJPdoPTmILHA++AlS9EkhjlyTpgCtdsQ1u6U8vkegc7Lu8NkUh9zlvfFNgDKevnwxpsapmwE5+cNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp1/1C4c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741903256; x=1773439256;
  h=date:from:to:cc:subject:message-id;
  bh=U5Tg5xg7oPnSkdGd7Sduxr4Ry0EiVBXyUmSIKItYGXI=;
  b=Vp1/1C4cyMkzOkcn92MVAlZuMB65qCc4bMfiI+efvrutBuL9lLySeJ/f
   TxU1qCrMZzoQ9wm3vdtHSRBZppvr8uGixEdhoBe89X5c2hCfki2xIXM5H
   N8an3LT+XlZKAfbkVU7Jzuy+sI3ijJTfefJv4RCPMU+eiA8fTBKCbJ9VG
   N5h+Q8trZp+O+60Cgm/O/PEFecjfCPtxoTqYiK+qn1LtuFlt54XK1uREM
   uPoa49QqLvTeInulI43bzRJWrBZFnTlW9g4v/J0yZTq1IEtZQY96LWrfN
   Jq7B9UYrfnBffZODa7KXXyXzdoeqtU81NUR4aS0tIAIqiWcv24iBp+9bK
   A==;
X-CSE-ConnectionGUID: XI1PEKC0RCe9fJSltESn5A==
X-CSE-MsgGUID: 6ZS9lzi4QvWpB/hOZCYGUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54418363"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="54418363"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:00:56 -0700
X-CSE-ConnectionGUID: qoPhiXxxQ9ikbzmKhZyazg==
X-CSE-MsgGUID: crPDexokRV+mwUOWBQJF4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="158231785"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 13 Mar 2025 15:00:55 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsqbk-0009wV-06;
	Thu, 13 Mar 2025 22:00:52 +0000
Date: Fri, 14 Mar 2025 06:00:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 18c6575230f695250f76952d91a5b93e6bc34f88
Message-ID: <202503140639.NyNJVzA2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 18c6575230f695250f76952d91a5b93e6bc34f88  PCI: Check BAR index for validity

elapsed time: 1450m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                   randconfig-001-20250313    gcc-13.2.0
arc                   randconfig-002-20250313    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-19
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250313    clang-16
arm                   randconfig-002-20250313    clang-18
arm                   randconfig-003-20250313    gcc-14.2.0
arm                   randconfig-004-20250313    clang-21
arm                           sama5_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250313    clang-18
arm64                 randconfig-002-20250313    clang-16
arm64                 randconfig-003-20250313    gcc-14.2.0
arm64                 randconfig-004-20250313    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250313    gcc-14.2.0
csky                  randconfig-002-20250313    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250313    clang-17
hexagon               randconfig-002-20250313    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250313    gcc-12
i386        buildonly-randconfig-002-20250313    gcc-12
i386        buildonly-randconfig-003-20250313    clang-19
i386        buildonly-randconfig-004-20250313    gcc-12
i386        buildonly-randconfig-005-20250313    clang-19
i386        buildonly-randconfig-006-20250313    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250313    gcc-14.2.0
loongarch             randconfig-002-20250313    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250313    gcc-14.2.0
nios2                 randconfig-002-20250313    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250313    gcc-14.2.0
parisc                randconfig-002-20250313    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250313    clang-16
powerpc               randconfig-002-20250313    clang-18
powerpc               randconfig-003-20250313    gcc-14.2.0
powerpc64             randconfig-001-20250313    gcc-14.2.0
powerpc64             randconfig-002-20250313    gcc-14.2.0
powerpc64             randconfig-003-20250313    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250313    clang-21
riscv                 randconfig-002-20250313    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250313    clang-15
s390                  randconfig-002-20250313    clang-15
s390                       zfcpdump_defconfig    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250313    gcc-14.2.0
sh                    randconfig-002-20250313    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250313    gcc-14.2.0
sparc                 randconfig-002-20250313    gcc-14.2.0
sparc64               randconfig-001-20250313    gcc-14.2.0
sparc64               randconfig-002-20250313    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250313    clang-21
um                    randconfig-002-20250313    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250313    clang-19
x86_64      buildonly-randconfig-002-20250313    clang-19
x86_64      buildonly-randconfig-003-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    gcc-12
x86_64      buildonly-randconfig-005-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250313    gcc-14.2.0
xtensa                randconfig-002-20250313    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

