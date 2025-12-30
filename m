Return-Path: <linux-pci+bounces-43849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1DDCE9E6F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 15:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CC57300AB36
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4409D22A4EB;
	Tue, 30 Dec 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k84qo1As"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA621A9F91
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104224; cv=none; b=IPNHlQXe2AjOhwPZ/8Y0YojGYFxlpvmVwo4O45kPnf0UF/dWAc4ra8y5V3tF525qvUQTZHSXE+aJpuS+E8ulKgIT67W9AqYDH1beUnBvQ+ejDll2ylKX905v9C1VzwbovklYKWLCCh0832b8R1qNB7TdDol707E2sfcQrGk9gf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104224; c=relaxed/simple;
	bh=RZUU/HkdKcOE1+R/IA34HtSEZ4Kj3IbU4sGFftWcuAc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tPGUEJToMV40adHzrWCcEbLlS6X/Or9CQCAkoM9yqZvG1HmDcJ4d4Pywm7INE9/eyOvUCFWgprfWe3p8Rgj1dVS27ObSDVZjp4zYDaRfefCiMh4XVASaDx7NPU4NwYY2DT/7bX9G8PW6qOqenQXNjeOfTWNmu7b5281ORVkTTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k84qo1As; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767104223; x=1798640223;
  h=date:from:to:cc:subject:message-id;
  bh=RZUU/HkdKcOE1+R/IA34HtSEZ4Kj3IbU4sGFftWcuAc=;
  b=k84qo1AsC/fAblncqjPa0zWXcGv/dZ1v8qHaIOF4O/5H+mNyI3ZLtop9
   vzWrKo6GSB+M+2Oy6B4kWBVq3u5TStPLukH/lDeILXDhqpZDZTV0McT3b
   efm9NEGy/lJRsS80dFnAPrKIvaj22wDcz5LLiplRAnsljtra8chiEA2Sc
   THzLqDj3BpeSUAiuX2/fOljKDX1ILyFOpfZjsC5ysehep5X9+Q0Pfnrsm
   l17sWnybeRR2IzTsKhY6PTyAA0c4Iz7VUXiyhZHj0fwEzZpyLkS2xwKCc
   N/QYXD5G12ifZ0lxrhcCONQRTSbRnhNaw4GI8fZ8gYpEWN8gmNASuaZ5j
   Q==;
X-CSE-ConnectionGUID: f0UrOcuKRayoEksEq9eVNA==
X-CSE-MsgGUID: 7rt1wI9XQ0GJTNypI4ZCnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="67696251"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="67696251"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 06:17:01 -0800
X-CSE-ConnectionGUID: yZbCKSyxQAe6N2cSL5If/g==
X-CSE-MsgGUID: phraXXeyTmim6VhpPVQQkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="224722081"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Dec 2025 06:17:01 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaaWw-000000000RZ-3PFN;
	Tue, 30 Dec 2025 14:16:58 +0000
Date: Tue, 30 Dec 2025 22:16:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:workqueue] BUILD SUCCESS
 03f336a869b3a3f119d3ae52ac9723739c7fb7b6
Message-ID: <202512302206.LpUNC67W-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git workqueue
branch HEAD: 03f336a869b3a3f119d3ae52ac9723739c7fb7b6  PCI: endpoint: Add missing NULL check for alloc_workqueue()

elapsed time: 1283m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

