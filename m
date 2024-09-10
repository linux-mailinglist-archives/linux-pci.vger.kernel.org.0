Return-Path: <linux-pci+bounces-12997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205DA973C19
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974741F26B9B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0CC6F2F4;
	Tue, 10 Sep 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOkB7npb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ACE4204D
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982550; cv=none; b=C7cX+BgUPtcSHK3orcRQqdeBeBvGEbfgXHwI7u+q5reUcSElyTHy56MswQsiPtfm8OH0hitHlBIZBZO71K+4k9BpxFmz6api7RTPXsSAAG5kwmnv3pJQLM/09fhlXe2QY394a11ERZYRqmUuXTQvG9xJf1Vzi0hMHk8zHQRY41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982550; c=relaxed/simple;
	bh=eUo0OnDbl/xJ/0dJDbTU85FPlQ/pmWeRuwY/xCaOqNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TFo/NY5FxTlkWcOLGK/ClePnzuSNbTsG6nl/OhVwkWERZuvNSEUmOZu19oOjLSt3FD0BQY3elzdUneSuJf2+q/P9VKI2tQ7QBK5g+fxr+Zc6X/sam+pRs7wioOquAqMuXgrxxoTyqyX1r1/wqaaeCSEr6K4+NIFUc10tGeTDVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOkB7npb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725982549; x=1757518549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eUo0OnDbl/xJ/0dJDbTU85FPlQ/pmWeRuwY/xCaOqNQ=;
  b=YOkB7npbK4l3pO9z7GhvlcSB5+TxBIG+ah7OMwRZpX2TzoVW8tP8ctn8
   MUS97+0yA1y1YBWWuLi+ebm4Xipu3L/jc+nzSKLSflhL9E/oJ3Gs0DUkC
   OTCQ+SEqnlm8EIHrAg1gvNPh3BQqgPDxNs2zoz6djYc+knbuQ2E84dQIT
   2J/utybqa2+QsVRpVzyqM26LlfA4BPXOe2lw89muh69CFUS3eK7WNarxS
   7hA4iAbjrBIxYVD5tdvKsNDmIMbqcdBDCHizjBoaOePeJPPGvkGf+fDjp
   a4cA8pZLdb5wynuav1laX9jerpuOWZAvPzkX0g75vxprhxCFTx9Gnaa3Z
   A==;
X-CSE-ConnectionGUID: wzI8AU1uQ1yF/y3H+9SybQ==
X-CSE-MsgGUID: LPjx5QI+RpWWjtHQarM9/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35405408"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="35405408"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 08:35:48 -0700
X-CSE-ConnectionGUID: LxVmtujnR0uOE1O9k+r+TA==
X-CSE-MsgGUID: uoIiKP9bSeeiAyHHGGfnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71833802"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Sep 2024 08:35:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so2u8-0002Gt-2N;
	Tue, 10 Sep 2024 15:35:44 +0000
Date: Tue, 10 Sep 2024 23:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 59100eb248c0b15585affa546c7f6834b30eb5a4
Message-ID: <202409102320.3AVJcraR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 59100eb248c0b15585affa546c7f6834b30eb5a4  PCI: Use an error code with PCIe failed link retraining

elapsed time: 1480m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.3.0
arc                   randconfig-001-20240910   gcc-13.2.0
arc                   randconfig-002-20240910   gcc-13.2.0
arm                   randconfig-001-20240910   clang-20
arm                   randconfig-002-20240910   gcc-14.1.0
arm                   randconfig-003-20240910   gcc-14.1.0
arm                   randconfig-004-20240910   clang-20
arm64                 randconfig-001-20240910   gcc-14.1.0
arm64                 randconfig-002-20240910   clang-20
arm64                 randconfig-003-20240910   gcc-14.1.0
arm64                 randconfig-004-20240910   gcc-14.1.0
csky                  randconfig-001-20240910   gcc-14.1.0
csky                  randconfig-002-20240910   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240910   clang-17
hexagon               randconfig-002-20240910   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240910   gcc-12
i386         buildonly-randconfig-002-20240910   gcc-12
i386         buildonly-randconfig-003-20240910   gcc-12
i386         buildonly-randconfig-004-20240910   clang-18
i386         buildonly-randconfig-005-20240910   clang-18
i386         buildonly-randconfig-006-20240910   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240910   gcc-12
i386                  randconfig-002-20240910   gcc-12
i386                  randconfig-003-20240910   gcc-12
i386                  randconfig-004-20240910   gcc-12
i386                  randconfig-005-20240910   gcc-12
i386                  randconfig-006-20240910   clang-18
i386                  randconfig-011-20240910   gcc-12
i386                  randconfig-012-20240910   clang-18
i386                  randconfig-013-20240910   clang-18
i386                  randconfig-014-20240910   gcc-12
i386                  randconfig-015-20240910   gcc-12
i386                  randconfig-016-20240910   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch             randconfig-001-20240910   gcc-14.1.0
loongarch             randconfig-002-20240910   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
nios2                 randconfig-001-20240910   gcc-14.1.0
nios2                 randconfig-002-20240910   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240910   gcc-14.1.0
parisc                randconfig-002-20240910   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240910   clang-20
powerpc               randconfig-002-20240910   gcc-14.1.0
powerpc               randconfig-003-20240910   gcc-14.1.0
powerpc64             randconfig-001-20240910   clang-14
powerpc64             randconfig-002-20240910   gcc-14.1.0
powerpc64             randconfig-003-20240910   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                 randconfig-001-20240910   gcc-14.1.0
riscv                 randconfig-002-20240910   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240910   clang-20
s390                  randconfig-002-20240910   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240910   gcc-14.1.0
sh                    randconfig-002-20240910   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64               randconfig-001-20240910   gcc-14.1.0
sparc64               randconfig-002-20240910   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240910   gcc-12
x86_64       buildonly-randconfig-002-20240910   gcc-12
x86_64       buildonly-randconfig-003-20240910   clang-18
x86_64       buildonly-randconfig-004-20240910   gcc-12
x86_64       buildonly-randconfig-005-20240910   gcc-11
x86_64       buildonly-randconfig-006-20240910   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240910   gcc-12
x86_64                randconfig-002-20240910   gcc-12
x86_64                randconfig-003-20240910   gcc-12
x86_64                randconfig-004-20240910   gcc-12
x86_64                randconfig-005-20240910   clang-18
x86_64                randconfig-006-20240910   clang-18
x86_64                randconfig-011-20240910   gcc-12
x86_64                randconfig-012-20240910   clang-18
x86_64                randconfig-013-20240910   clang-18
x86_64                randconfig-014-20240910   clang-18
x86_64                randconfig-015-20240910   gcc-12
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

