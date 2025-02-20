Return-Path: <linux-pci+bounces-21922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D23A3E313
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE811884776
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716D5213248;
	Thu, 20 Feb 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6j8DBxd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830C2B9AA
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074009; cv=none; b=RM+Zds/CFfDJ/4UjRXlKnwjEVPrVvc1tiqnb+NCk5znVbq5RvjXFceHHuUT5QwXexsNYRJ3XIsD648t+7Dm166CgKQSGpVw95+7glmXm2g1zaYX2Ke6kAMEkgu9mpbCbC02S0THupoZsl3rtbWcaBDQFUAbsrySuAJAq0ZqQ0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074009; c=relaxed/simple;
	bh=Df8m+N3oKfw4dgnSl9KfNUUyYi8mNqDoLxwvdoxXu+I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l0ucaffOw39YC4YH/rPFaktGieMgqTjMBox7D84ifuhR252g/w8VlaMS267eQ2j3p+hxMuXCzh0KBe7X5+XZsr2w2WUQzT2yCVklr5QPQl4MDaHdgQy7orPEaAdfGP3JFkxPW8Ts06OI4+QuetEiO/sMa/2KTagm/Roubdf5UqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6j8DBxd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740074008; x=1771610008;
  h=date:from:to:cc:subject:message-id;
  bh=Df8m+N3oKfw4dgnSl9KfNUUyYi8mNqDoLxwvdoxXu+I=;
  b=a6j8DBxdNFp67ihzPzu1GpMt/fkpdFb+XqWAL1fBWYZTgUrVrs6I2unz
   mOKiD7qt8ElmOxWSoT7C43jCMFkfNZVtBmgxJv/Kd0ZsSJh7XU1V2wkhG
   1uOvRxygYhq/FgshzCzuV1hPrAyIUh1nm9J61Q1QhiA+r2vJzLQYGhrhr
   VYi31hcttM88eS/2YNKCjTrakeCrCmHpTdYXOCWUkp59RFTExHjG7rfK0
   I2sxH9BjpElxV44Ozlsj/PJ69mFfD4BgFgpJgUskkERjVBW87VdGiqXFp
   LaALrGXc6q1RIaVoHFYC/61EpmOc40bTWykTv6ZWH0H44rwr2aSVeoLAt
   A==;
X-CSE-ConnectionGUID: utG1iwS7ThecVK+tRpDopA==
X-CSE-MsgGUID: MbZBdMKLTJ62wQ9E6UORxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28468600"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="28468600"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:53:27 -0800
X-CSE-ConnectionGUID: 5bamARPFTZ6UBpayMC840A==
X-CSE-MsgGUID: KYMNVsbfSo2Ns+TF7XvgLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119224189"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 20 Feb 2025 09:53:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlAjk-0004bj-0Z;
	Thu, 20 Feb 2025 17:53:24 +0000
Date: Fri, 21 Feb 2025 01:53:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint-test] BUILD SUCCESS
 95bd01df1718bd6367b80e266d32e8c3ab1e2aaf
Message-ID: <202502210100.fDlb5adD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint-test
branch HEAD: 95bd01df1718bd6367b80e266d32e8c3ab1e2aaf  tools/Makefile: Remove pci target

elapsed time: 1449m

configs tested: 73
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250220    gcc-13.2.0
arc                  randconfig-002-20250220    gcc-13.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250220    gcc-14.2.0
arm                  randconfig-002-20250220    gcc-14.2.0
arm                  randconfig-003-20250220    gcc-14.2.0
arm                  randconfig-004-20250220    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250220    gcc-14.2.0
arm64                randconfig-002-20250220    gcc-14.2.0
arm64                randconfig-003-20250220    clang-21
arm64                randconfig-004-20250220    gcc-14.2.0
csky                 randconfig-001-20250220    gcc-14.2.0
csky                 randconfig-002-20250220    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250220    clang-21
hexagon              randconfig-002-20250220    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250220    gcc-12
i386       buildonly-randconfig-002-20250220    gcc-12
i386       buildonly-randconfig-003-20250220    gcc-12
i386       buildonly-randconfig-004-20250220    clang-19
i386       buildonly-randconfig-005-20250220    clang-19
i386       buildonly-randconfig-006-20250220    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250220    gcc-14.2.0
loongarch            randconfig-002-20250220    gcc-14.2.0
nios2                randconfig-001-20250220    gcc-14.2.0
nios2                randconfig-002-20250220    gcc-14.2.0
parisc               randconfig-001-20250220    gcc-14.2.0
parisc               randconfig-002-20250220    gcc-14.2.0
powerpc              randconfig-001-20250220    gcc-14.2.0
powerpc              randconfig-002-20250220    clang-16
powerpc              randconfig-003-20250220    clang-21
powerpc64            randconfig-001-20250220    clang-16
powerpc64            randconfig-002-20250220    clang-18
powerpc64            randconfig-003-20250220    gcc-14.2.0
riscv                randconfig-001-20250220    gcc-14.2.0
riscv                randconfig-002-20250220    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250220    clang-19
s390                 randconfig-002-20250220    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250220    gcc-14.2.0
sh                   randconfig-002-20250220    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250220    gcc-14.2.0
sparc                randconfig-002-20250220    gcc-14.2.0
sparc64              randconfig-001-20250220    gcc-14.2.0
sparc64              randconfig-002-20250220    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250220    gcc-12
um                   randconfig-002-20250220    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250220    gcc-12
x86_64     buildonly-randconfig-002-20250220    gcc-12
x86_64     buildonly-randconfig-003-20250220    gcc-12
x86_64     buildonly-randconfig-004-20250220    gcc-12
x86_64     buildonly-randconfig-005-20250220    gcc-12
x86_64     buildonly-randconfig-006-20250220    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250220    gcc-14.2.0
xtensa               randconfig-002-20250220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

