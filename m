Return-Path: <linux-pci+bounces-9437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48391CC00
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E161C20FD8
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B287722086;
	Sat, 29 Jun 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2vJp5qL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB83803
	for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655407; cv=none; b=SI7F9AcadsGNKF8UjywRmJ+U5dSQyhaLGvbF4BL6hcpmaGVgaEIWf5G1rBKXGmEFp/G6Hp+7swkPZKEvjR9qrCChb6yphL95mZG1rzYGm2bQfiGP1cX17aGm2zzpPAkyFM2GMwoYA/GtyyC5q92oruggsswVRXSqQGHBXEZms2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655407; c=relaxed/simple;
	bh=eakfhzO2d467dvHW+0kHgNVYfGxRfa2Fz5BekvqW1n4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fKts8rCyjJw9T4ZV898/KQzcOUqZJ8qXtggr2lCLDwea63ubT9Tyi/SbsEZ+prT+6MI1QxjQDQ418gAzAIxmDB4qr4HDC79V/iamMiRYdUFyY+Y1V5jW1nk58ikZM76cWIORyYKKDvu8jfVZms7H0feME8Y1qLZwnolYdToxIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2vJp5qL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719655406; x=1751191406;
  h=date:from:to:cc:subject:message-id;
  bh=eakfhzO2d467dvHW+0kHgNVYfGxRfa2Fz5BekvqW1n4=;
  b=i2vJp5qLWlpvASHvSoM+3F75Sgcdor//fHPmYV4pAmlwI5JHlmKtfzIR
   B94td/Dy4qV+G1/zj7PCrNTCBszk0LN60g8mi9VQqXH28HX+6Wk61fchC
   KMtTkU7pZ1Ir/zevLSiaCvuGd4G3ZI+A8nx4mjA5PY2D0kMGrk/MMVzto
   xHBkmXQo+x8J4SjS6vzc4t3m+zxd0ShQYzZCFa7/DvltxvIHTzyR8mtPt
   +6niq67FWRqLNZnbaqsKgVpm/6dbtvetOI5NQv8oyQ9j7iCqQdj+/rE/S
   1NRXAjHzX2xTdwvqFoetyl6Bj2c8lbTkYDKLnkRcmGV1aylne+erSx23Y
   A==;
X-CSE-ConnectionGUID: qZ2iEqc5SLiDh7PHZs6KMQ==
X-CSE-MsgGUID: HTV+/8jPR3+Pxndn89gs/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="34372663"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="34372663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 03:03:25 -0700
X-CSE-ConnectionGUID: Por91wCNSVGeiicRNpwcxg==
X-CSE-MsgGUID: BUxci5/QSfqBAxIxvAIADQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="82526428"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Jun 2024 03:03:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNUvR-000JBe-2o;
	Sat, 29 Jun 2024 10:03:21 +0000
Date: Sat, 29 Jun 2024 18:03:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:err] BUILD SUCCESS
 75c47c790f43c438761fc049fb9d438144a9db45
Message-ID: <202406291800.MOMPABra-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git err
branch HEAD: 75c47c790f43c438761fc049fb9d438144a9db45  PCI/DPC: Disable DPC service on suspend

elapsed time: 15230m

configs tested: 55
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

