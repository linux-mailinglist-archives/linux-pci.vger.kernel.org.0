Return-Path: <linux-pci+bounces-20011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53697A14266
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 20:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3CD18851D5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E78230981;
	Thu, 16 Jan 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8+tE+0C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6422E409
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056332; cv=none; b=GGt+b/9lUmjABxn9ObnkKVR+ZnYJhFANxJb/KTS2OyI5oaUAYzsyLoOgNTg/NTYbsa0UwA7FayiYdE8PuO1/HC7/EijPCb+hBxtouY8rkyCJ0kqc121MtftzNlBUaqbksqHcfwtwcI8nZO25sn8L78V392L3eI2B2cUcRpehzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056332; c=relaxed/simple;
	bh=P/0gycqkVWcvJmw16yxJm7lF6pPIKpak9zEkqunehwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=plASaUJyDTQ2F1WrS3HFR7UOO7cxMNRw5b8ihGGpU5TLQLWyi8uRoH8DGU3Zb1Ty+hZwo9cXVGbxFn5xUNFXXD6Ni8cfvgXEmA7eYMElESpSZw7HL0jUSWo2octWSHo70QKfi1vpK2sdlenRpG6Rq99zh9pvVVTd1WtAYSqiiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8+tE+0C; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737056331; x=1768592331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P/0gycqkVWcvJmw16yxJm7lF6pPIKpak9zEkqunehwo=;
  b=F8+tE+0CdlXK7hN9w0jEW6KJWxjWkO8br7vxLOko74Y7I2wG1rUvsfM8
   ew7WqDisQTidqXTeCpahZF794fNnahUfXO9GwG7Mj20u2OaAotkEXWrXz
   +3HLQIWCEndxDav9RzmqZJBgZicvktO9pMqoiaO262uvrJFroNsZkohrM
   Mp/1hhcu8DYyatfVjE5w7jgT74Zgc1GioyswUex8ERnGoKOfi13JOVB8M
   cNOUo4lBpW/OrlgyICO+hZCufmNODkp7sNzKQZNdQ6p5fRhMVsqJpB8G4
   8jjTxx4Yhu+Z41ACADYngl3XaPv6ggSIBA98BJtopozWW3eg+5a18P/wx
   w==;
X-CSE-ConnectionGUID: lRMA/SnCT/aH/y4VDAZntA==
X-CSE-MsgGUID: VPursjBCRtiZ/DplEDdB0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48465848"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="48465848"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 11:38:51 -0800
X-CSE-ConnectionGUID: 5/xEZsH5Q/q5bSkDAI9fJQ==
X-CSE-MsgGUID: cXk2RWHFSA6YkvUfgA1XBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105420893"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jan 2025 11:38:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYVhX-000SKJ-0X;
	Thu, 16 Jan 2025 19:38:47 +0000
Date: Fri, 17 Jan 2025 03:38:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 041375bd32561cabcf457b5ed91ddd2965de79ac
Message-ID: <202501170304.hkCtVrpc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 041375bd32561cabcf457b5ed91ddd2965de79ac  arm64: dts: imx95: Add ref clock for i.MX95 PCIe

elapsed time: 1453m

configs tested: 57
configs skipped: 0

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

