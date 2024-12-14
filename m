Return-Path: <linux-pci+bounces-18445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8D9F208E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4302B18880CD
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B81991C1;
	Sat, 14 Dec 2024 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHeuvMdB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CD194C61
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203565; cv=none; b=jzj6xrrbMgXjea8mGyOy3q5yPXCrud17KEvrNEnUnH7msLA+5uzCIh4Lsq5CNmBWpEpX6S93V/v2kkchqFTnej10bsQa6aG6TuJJGmxJfvzpnsc7qsUMszpTg6zHqjBihuUsT6xTh0nFiiRAYeHQRLooWYOamvUdxDMCI1rM4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203565; c=relaxed/simple;
	bh=UEfwqSpU6TuDn+qruFbfd2pr5FIbR+psAheXPiCwSAM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TYe1MRaz/OThiEfHiYxDJ7wIOAQqM/AppZsY9IRvNn9FnzuIZRZ51t9Fk+90/KXqZWndr79oDCYrTKYg0MSHcfp1Py7mH7rt1xeMK8gnZHdkhV+4YSq1komBshraXUBLKz9rIsePL++mHiQD7bTJkpmUBXkOO9Ar1SU9FQ9DRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHeuvMdB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734203564; x=1765739564;
  h=date:from:to:cc:subject:message-id;
  bh=UEfwqSpU6TuDn+qruFbfd2pr5FIbR+psAheXPiCwSAM=;
  b=FHeuvMdBo5GiyTvOYPw4WNtYy8/kx0LF3nCfDDTtv/EdA2vX0DrbwQTB
   4SJhjCysJ7h+6nNaOc0WaClqAW6uI450p7pbRiTFhrEK/tECmnIgZqwwr
   H2cum/sKkxXbXbnXKlPF08+9zG5QgsQhq2gALA2VQHJ92rcmMAeR6lVC2
   eWcMESt1yEiifUO1+xmKwBMgJJf36FoOt2t4qm/TGK6kOWz7IAjtpz79M
   UdeTI2/y0T3iLzt734QLaT/M/Ax5iCdE9Z9wZA4Ni5yhD7MzgmROZUrk+
   JjkeT6qBBAeRo9PI+Db3RTdyjTH3RkODL6RxD2sbq1/j3kfSMDHFZYNYF
   A==;
X-CSE-ConnectionGUID: NZRXtAWNR7ef5rQSwVXIQA==
X-CSE-MsgGUID: FMKW2l0MT6GyWUZP/ZIn3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="38415331"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="38415331"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 11:12:41 -0800
X-CSE-ConnectionGUID: Yg6F9IqFSjKgeaAlclchhg==
X-CSE-MsgGUID: QgRdxYazSYWwbnsd0rl8fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101922839"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Dec 2024 11:12:41 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMXZ8-000DA9-0T;
	Sat, 14 Dec 2024 19:12:38 +0000
Date: Sun, 15 Dec 2024 03:12:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 9b4bafd9517c9d084469314b4412bfa21466e29a
Message-ID: <202412150301.gMiBFLM3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 9b4bafd9517c9d084469314b4412bfa21466e29a  HID: amd_sfh: Use always-managed version of pcim_intx()

elapsed time: 1445m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241214    gcc-13.2.0
arc                  randconfig-002-20241214    gcc-13.2.0
arm                  randconfig-001-20241214    gcc-14.2.0
arm                  randconfig-002-20241214    clang-15
arm                  randconfig-003-20241214    gcc-14.2.0
arm                  randconfig-004-20241214    gcc-14.2.0
arm64                randconfig-001-20241214    clang-15
arm64                randconfig-002-20241214    clang-20
arm64                randconfig-003-20241214    clang-15
arm64                randconfig-004-20241214    gcc-14.2.0
csky                 randconfig-001-20241214    gcc-14.2.0
csky                 randconfig-002-20241214    gcc-14.2.0
hexagon              randconfig-001-20241214    clang-20
hexagon              randconfig-002-20241214    clang-14
i386       buildonly-randconfig-001-20241214    gcc-12
i386       buildonly-randconfig-002-20241214    gcc-12
i386       buildonly-randconfig-003-20241214    clang-19
i386       buildonly-randconfig-004-20241214    clang-19
i386       buildonly-randconfig-005-20241214    gcc-11
i386       buildonly-randconfig-006-20241214    gcc-12
loongarch            randconfig-001-20241214    gcc-14.2.0
loongarch            randconfig-002-20241214    gcc-14.2.0
nios2                randconfig-001-20241214    gcc-14.2.0
nios2                randconfig-002-20241214    gcc-14.2.0
parisc               randconfig-001-20241214    gcc-14.2.0
parisc               randconfig-002-20241214    gcc-14.2.0
powerpc              randconfig-001-20241214    clang-20
powerpc              randconfig-002-20241214    clang-15
powerpc              randconfig-003-20241214    clang-20
powerpc64            randconfig-001-20241214    gcc-14.2.0
powerpc64            randconfig-003-20241214    clang-20
riscv                randconfig-001-20241214    clang-20
riscv                randconfig-002-20241214    clang-20
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241214    gcc-14.2.0
s390                 randconfig-002-20241214    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241214    gcc-14.2.0
sh                   randconfig-002-20241214    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241214    gcc-14.2.0
sparc                randconfig-002-20241214    gcc-14.2.0
sparc64              randconfig-001-20241214    gcc-14.2.0
sparc64              randconfig-002-20241214    gcc-14.2.0
um                   randconfig-001-20241214    clang-20
um                   randconfig-002-20241214    clang-17
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20241214    gcc-11
x86_64     buildonly-randconfig-002-20241214    clang-19
x86_64     buildonly-randconfig-003-20241214    gcc-12
x86_64     buildonly-randconfig-004-20241214    gcc-12
x86_64     buildonly-randconfig-005-20241214    gcc-12
x86_64     buildonly-randconfig-006-20241214    clang-19
xtensa               randconfig-001-20241214    gcc-14.2.0
xtensa               randconfig-002-20241214    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

