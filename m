Return-Path: <linux-pci+bounces-21852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEBFA3CD8F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 00:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBEF189A5A8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 23:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55F725E476;
	Wed, 19 Feb 2025 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5yC01oJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB525E475
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007789; cv=none; b=eQ1hgbARZFhytki/plC0IaXglL0F5oUoX5JoHe/ByEF14ztBBxNEYA62sZMjBo/WRbEKTcQRfrD79Rvf9YjrvSLh45tcAxzgp9dWelQqJfcUzIHDi3833Dhrv3xB/AgNv6VxRvmcoZSIZSBFeTQRK+O255nwfpAwU0UpJdQZtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007789; c=relaxed/simple;
	bh=idfCjxowDJelTpYsj5JHmpUTciobSiCF7nf8NAq8f+Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gySKX7TmRdZNBFmJRH2gVtrPJdi2AUw4d66orftuUZ8IFzLdlcHp2Ekcg5pt+E/Fz1LdvvstQi7XC4TSTK6/TQZ8n4HVLCJHjQQqlG6KyL4vx45H0T087jFs16h1IpLyoyqc1mzlIAZk6br37L0TkiUaWvhHc06SCNvalTH5NK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5yC01oJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740007788; x=1771543788;
  h=date:from:to:cc:subject:message-id;
  bh=idfCjxowDJelTpYsj5JHmpUTciobSiCF7nf8NAq8f+Q=;
  b=f5yC01oJDFsGZMPbmOMYOnGIGvQoEyEizbmGwqGiHwmyy8Fsuky7HNZD
   RfgvaoycQ0KjgtVCZUmhYT+ko6Ba7SqhWrE6gT8nasNUeScWHmUgL5fYc
   5NOYO2ZVKuoazEJETbRCQwJHFy0nLMjTdcuoRObj1B/Y84gin4+KCZFkL
   73vN+2BsQQpCQG4PBUYSICTttH2kOX8ByKJ3kVouBYn9yNhFCBXYM4Iip
   BFR7YrNqnYTMF/aImnMYLFzVGcXMyKtOw3eY9DoPm+cQ8F8VC94xxw8e0
   BlQiMSGXpmebozm1xbzZgub+7ad7ARLz+oZshtnv5iFdwv6YXGvaokmx2
   A==;
X-CSE-ConnectionGUID: YFeQnq+YRlKibXqdzLX2nA==
X-CSE-MsgGUID: iV8T9wSWQGuqb2ZO8Z69hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58311834"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58311834"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:29:47 -0800
X-CSE-ConnectionGUID: PkSSDHJRTMapY8AoDoTcbw==
X-CSE-MsgGUID: 1WkZwZkkTteaWsjVH34AKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120080012"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 19 Feb 2025 15:29:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tktVV-0003c7-27;
	Wed, 19 Feb 2025 23:29:41 +0000
Date: Thu, 20 Feb 2025 07:29:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 ce90c8108dffca139e7a1fc879f081f3a11ef6f0
Message-ID: <202502200758.U8B03SPm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: ce90c8108dffca139e7a1fc879f081f3a11ef6f0  PCI: Add Rockchip Vendor ID

elapsed time: 1458m

configs tested: 74
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250219    gcc-13.2.0
arc                  randconfig-002-20250219    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250219    gcc-14.2.0
arm                  randconfig-002-20250219    clang-17
arm                  randconfig-003-20250219    clang-15
arm                  randconfig-004-20250219    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250219    clang-21
arm64                randconfig-002-20250219    gcc-14.2.0
arm64                randconfig-003-20250219    gcc-14.2.0
arm64                randconfig-004-20250219    gcc-14.2.0
csky                 randconfig-001-20250219    gcc-14.2.0
csky                 randconfig-002-20250219    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250219    clang-14
hexagon              randconfig-002-20250219    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250219    clang-19
i386       buildonly-randconfig-002-20250219    clang-19
i386       buildonly-randconfig-003-20250219    gcc-12
i386       buildonly-randconfig-004-20250219    clang-19
i386       buildonly-randconfig-005-20250219    clang-19
i386       buildonly-randconfig-006-20250219    gcc-12
i386                               defconfig    clang-19
loongarch            randconfig-001-20250219    gcc-14.2.0
loongarch            randconfig-002-20250219    gcc-14.2.0
nios2                randconfig-001-20250219    gcc-14.2.0
nios2                randconfig-002-20250219    gcc-14.2.0
parisc               randconfig-001-20250219    gcc-14.2.0
parisc               randconfig-002-20250219    gcc-14.2.0
powerpc              randconfig-001-20250219    clang-15
powerpc              randconfig-002-20250219    clang-17
powerpc              randconfig-003-20250219    gcc-14.2.0
powerpc64            randconfig-001-20250219    gcc-14.2.0
powerpc64            randconfig-002-20250219    gcc-14.2.0
powerpc64            randconfig-003-20250219    gcc-14.2.0
riscv                randconfig-001-20250219    clang-21
riscv                randconfig-002-20250219    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250219    clang-18
s390                 randconfig-002-20250219    clang-21
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250219    gcc-14.2.0
sh                   randconfig-002-20250219    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250219    gcc-14.2.0
sparc                randconfig-002-20250219    gcc-14.2.0
sparc64              randconfig-001-20250219    gcc-14.2.0
sparc64              randconfig-002-20250219    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250219    clang-21
um                   randconfig-002-20250219    clang-21
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250219    gcc-12
x86_64     buildonly-randconfig-002-20250219    clang-19
x86_64     buildonly-randconfig-003-20250219    gcc-12
x86_64     buildonly-randconfig-004-20250219    clang-19
x86_64     buildonly-randconfig-005-20250219    gcc-12
x86_64     buildonly-randconfig-006-20250219    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250219    gcc-14.2.0
xtensa               randconfig-002-20250219    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

