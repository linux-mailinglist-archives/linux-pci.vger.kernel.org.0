Return-Path: <linux-pci+bounces-20013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F6A1426F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 20:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2068B1888563
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7222F825;
	Thu, 16 Jan 2025 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1kntkt/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69622E409
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056393; cv=none; b=bn9CYHM7HKK1xXl08aeVIOY7soeUAOkwUjIl48m2MkguEIDm/8SuADiGjjDDGT46Y/2fTxlFeL4DF4CYCF7c7/tQtJQJwkgYDelKlslktxkeT0xTiBhQGv47fTudFJ2cPXaERGNav7klwKxeQgIVQw9ma/gGELzuLm+V17dg+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056393; c=relaxed/simple;
	bh=teLkuolP6ynN/buDXG6ZuFL79/yHkQVPo52kj/cxpws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qsZQZfflyrrkZySBm0Zu0mXC2GKg00vEGR56CDVco31ieAawVbxEwbIT701gWBELIMSS9LqImVx2vX03bcsqGg3Qq93fA/Cvn9lne3MUOn6ZudT2rTFgknbeVXNW7BJD65QSaThdeBQYYx3fQbad3/kNBvF9Lw+bP8srQYQs6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1kntkt/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737056391; x=1768592391;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=teLkuolP6ynN/buDXG6ZuFL79/yHkQVPo52kj/cxpws=;
  b=P1kntkt/68EwYkZ1vsEsQKRGEdvEPz14oBZrsvJ0RfwY+SjfH3LfQJCI
   JVroCBSt+q28s1hYBx5IyYSBJ8q8tsUukBfcPlryK9kNZ2zERqQvzzTwO
   LKp2vn2W8+t5S1/iGUIbq/4RfJnQwGrceFrXtXl6D+lMQcE7uH52BO1tR
   qzccBpjSaAUG41bBb4I+hS+J4YHAiIf9znIu84qlK+b51SORxRHpZ7+hY
   qemD8kA/6isbl9q9uEmV40HWEJT4H+opkK565EiXzw8PftFYxyn48uzCd
   kQnVH5vMHtZhvk54v2nkG+YIp8av9DHN/iKkqgmSOFHgh32pnxJ7AosiI
   w==;
X-CSE-ConnectionGUID: xZpnYMaAT5u5QaT/9y9eag==
X-CSE-MsgGUID: xGoTR3KgRyS5CAtIhw2tBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37492479"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37492479"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 11:39:51 -0800
X-CSE-ConnectionGUID: B78ExyeXS66vcw0UiORbfw==
X-CSE-MsgGUID: 3TN2vBrFRh+MXM7HuYOFiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110705073"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Jan 2025 11:39:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYViV-000SKU-1l;
	Thu, 16 Jan 2025 19:39:47 +0000
Date: Fri, 17 Jan 2025 03:39:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 0333f56dbbf7ef6bb46d2906766c3e1b2a04a94d
Message-ID: <202501170357.HzDs1WYu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 0333f56dbbf7ef6bb46d2906766c3e1b2a04a94d  Merge branch 'resource'

elapsed time: 1453m

configs tested: 57
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250116    gcc-13.2.0
arc                  randconfig-002-20250116    gcc-13.2.0
arm                  randconfig-001-20250116    gcc-14.2.0
arm                  randconfig-002-20250116    clang-15
arm                  randconfig-003-20250116    gcc-14.2.0
arm                  randconfig-004-20250116    gcc-14.2.0
arm64                randconfig-001-20250116    gcc-14.2.0
arm64                randconfig-002-20250116    gcc-14.2.0
arm64                randconfig-003-20250116    clang-15
arm64                randconfig-004-20250116    clang-20
csky                 randconfig-001-20250116    gcc-14.2.0
csky                 randconfig-002-20250116    gcc-14.2.0
hexagon              randconfig-001-20250116    clang-20
hexagon              randconfig-002-20250116    clang-20
i386       buildonly-randconfig-001-20250116    clang-19
i386       buildonly-randconfig-002-20250116    clang-19
i386       buildonly-randconfig-003-20250116    clang-19
i386       buildonly-randconfig-004-20250116    clang-19
i386       buildonly-randconfig-005-20250116    clang-19
i386       buildonly-randconfig-006-20250116    clang-19
loongarch            randconfig-001-20250116    gcc-14.2.0
loongarch            randconfig-002-20250116    gcc-14.2.0
nios2                randconfig-001-20250116    gcc-14.2.0
nios2                randconfig-002-20250116    gcc-14.2.0
parisc               randconfig-001-20250116    gcc-14.2.0
parisc               randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-001-20250116    clang-20
powerpc              randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-003-20250116    clang-20
powerpc64            randconfig-001-20250116    clang-19
powerpc64            randconfig-002-20250116    clang-20
powerpc64            randconfig-003-20250116    clang-15
riscv                randconfig-001-20250116    gcc-14.2.0
riscv                randconfig-002-20250116    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250116    gcc-14.2.0
s390                 randconfig-002-20250116    clang-18
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250116    gcc-14.2.0
sh                   randconfig-002-20250116    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250116    gcc-14.2.0
sparc                randconfig-002-20250116    gcc-14.2.0
sparc64              randconfig-001-20250116    gcc-14.2.0
sparc64              randconfig-002-20250116    gcc-14.2.0
um                   randconfig-001-20250116    clang-19
um                   randconfig-002-20250116    gcc-12
x86_64     buildonly-randconfig-001-20250116    gcc-12
x86_64     buildonly-randconfig-002-20250116    gcc-12
x86_64     buildonly-randconfig-003-20250116    gcc-12
x86_64     buildonly-randconfig-004-20250116    clang-19
x86_64     buildonly-randconfig-005-20250116    clang-19
x86_64     buildonly-randconfig-006-20250116    clang-19
xtensa               randconfig-001-20250116    gcc-14.2.0
xtensa               randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

