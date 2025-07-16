Return-Path: <linux-pci+bounces-32327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E52B07ECF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05A71C26D71
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0E127EFEF;
	Wed, 16 Jul 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVj9fMhu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE556C2D1
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697405; cv=none; b=YoiQ5iasfsiB7o1HJ7bWdyx7ybvGotZ7AG03wZyXDIKav5TBTGXKogqTzzTYNPpu8JFjDDS+JTn5HeatH3F2GJzyNJ1RmICgbG4dm4f7TdUWVsD7s82/ZFPMllSStIzGqFcnuYAnXJQE7ZuCruyQRJSz+ScRF8xVY/k1Idxe1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697405; c=relaxed/simple;
	bh=o4CuCmZU45G6x+yTS5dS5f18nCXiHt3dPwpQd138a3U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gwZyI5nJdrXskwx06I+v59c6EbTRIrl1ZNAyhVOGI/5pKdHagU3Iy1PzwqjjN8YVABPqBU0eXHWsWQPCTbe64OqpBQNjfmwcxrkLVmzz0h3pBQRkTb3pRZB2PEjOlxxNy8Nta77q13R3O1gpFAYT0Kv2ZEekIzrQO9fRsMGDFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVj9fMhu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752697402; x=1784233402;
  h=date:from:to:cc:subject:message-id;
  bh=o4CuCmZU45G6x+yTS5dS5f18nCXiHt3dPwpQd138a3U=;
  b=NVj9fMhubnBZ9h47KGmxWzKqYGW4lwNx/KYY3h2WmIr6YyiGxezPhqll
   jgpoRNKmmtiV/XTkI5GfC6f+JizAy8UaI1z0gWzORFNUAZlbyXKvR3AQL
   U/JliUU7J3iMUa7E0zMw10AlnuHUSIOre1jUDn1NeYjRxZ97QpnXRLx8N
   yMqZeEZQP3+s6TdQra3vT+qM0SZZ8SCVNUmi5OrF9hFy2iE/pt8wA70w3
   q4zsft/dGU/1bOf64+LB01WRkTzL88ytKZ+NypPqYXnqjw4nwtYUg2lG9
   6pZ/6X+tcvs8T4QQDCtTUqgzrlR1mGL7avAshwq1caESPQirtap79fQVZ
   w==;
X-CSE-ConnectionGUID: S+lQaXfISUSPs4D2sXwUag==
X-CSE-MsgGUID: H2tjq6LtTHGZpmRHVBcUUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58768254"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="58768254"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:23:22 -0700
X-CSE-ConnectionGUID: ZhurbZTgSM+6pvxALHaQxA==
X-CSE-MsgGUID: itNOy/F9QoCOLP9obbX01A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="188589379"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jul 2025 13:23:21 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc8es-000Cnr-3B;
	Wed, 16 Jul 2025 20:23:18 +0000
Date: Thu, 17 Jul 2025 04:22:25 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 beedc9eb31140f0d2c673a69765384796b0b75ef
Message-ID: <202507170412.OOE5Kk4g-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: beedc9eb31140f0d2c673a69765384796b0b75ef  Merge branch 'pci/misc'

elapsed time: 1451m

configs tested: 96
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250716    gcc-13.4.0
arc                   randconfig-002-20250716    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250716    clang-20
arm                   randconfig-002-20250716    gcc-12.4.0
arm                   randconfig-003-20250716    gcc-8.5.0
arm                   randconfig-004-20250716    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250716    gcc-9.5.0
arm64                 randconfig-002-20250716    gcc-8.5.0
arm64                 randconfig-003-20250716    gcc-8.5.0
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250716    gcc-14.3.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250716    clang-21
hexagon               randconfig-002-20250716    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250716    clang-20
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250716    gcc-11
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250716    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250716    clang-18
loongarch             randconfig-002-20250716    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250716    gcc-14.2.0
nios2                 randconfig-002-20250716    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-8.5.0
parisc                randconfig-002-20250716    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250716    gcc-8.5.0
powerpc               randconfig-002-20250716    clang-21
powerpc               randconfig-003-20250716    gcc-14.3.0
powerpc64             randconfig-001-20250716    gcc-10.5.0
powerpc64             randconfig-003-20250716    gcc-13.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250716    gcc-8.5.0
riscv                 randconfig-002-20250716    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-002-20250716    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-15.1.0
sh                    randconfig-002-20250716    gcc-14.3.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-8.5.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-002-20250716    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-002-20250716    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250716    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250716    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

