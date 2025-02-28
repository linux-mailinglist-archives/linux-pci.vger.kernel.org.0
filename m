Return-Path: <linux-pci+bounces-22636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66878A497DE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C0D173E8A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269341B4250;
	Fri, 28 Feb 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaeUMhxE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28D260A42
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740085; cv=none; b=r4TsirL1/a99Efcs4LgNqbIULNgT2gAqoluJnOHpfcUh73F2bPXvfup0/JBz2jhvUGJ11L3yOTA93oAQqxqEaDYOomK7OnESBSaIoIGNZSqAtbJZgANSeGjLeVaFfuoVeNMR6mfXCaI91iuMHPKS4xVeHSnKAdZHsQ6OQPiSy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740085; c=relaxed/simple;
	bh=H2slJtFmQHmtjLQ0+/qo3prvx6ubNgchrixcfJcM2Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ugsbwYYId1dcqTZk7Ttau8/vDnqH17P2UGUeIemil+crepdEOCl3STdT9XhIhgNZvNkcMYzk6ZMoAomZei4QD056vK3u0nNyMsgKUxmcHD7OQhU7Q+UDzepcqujSH3jLGOpt5N2gPqQBTDU4K36BY1DEQgOZLEFhVowsJjVIbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaeUMhxE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740740083; x=1772276083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H2slJtFmQHmtjLQ0+/qo3prvx6ubNgchrixcfJcM2Qw=;
  b=AaeUMhxECIHpbJdOPie8m20reBYjIHOAKS4RCYUucaO/zUlmGcBxl1PR
   u/syBHQ7pvW8IOv0+ETUup3MecAjh6FQNiHMF3H6CPwJJ1993m3hKpK3d
   NZDtMsgoZQuHLfCplW9aPB6y00kATAWk0Sxm3vqSEKwWPPyTb4WeP7b6f
   h9KH3c5iLcT1GP7zFKstpDKbwBpuygQoH5uBSQ2deo33gpWguuDgiDP2m
   HTgsBvsCb++AvmzE0MSd+UPCjau4ned92+vtbmiRRqdikCY1MHJeD8SeK
   LEO4NVhOdZ4AJTEwBd3wFtBRlKJaieFLnFyYXP6sIqv/CqY2aQZlELp6s
   w==;
X-CSE-ConnectionGUID: XuvAawnKQ2aMSin4Z7OZmg==
X-CSE-MsgGUID: ga+gwSkaT4e7Fyib1bF6bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41514358"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41514358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:54:41 -0800
X-CSE-ConnectionGUID: M2LAkHHTSISd71xL/pSPMQ==
X-CSE-MsgGUID: b5o6XYdNQNClrb7usDCExA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122439431"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2025 02:54:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tny0r-000Em6-20;
	Fri, 28 Feb 2025 10:54:37 +0000
Date: Fri, 28 Feb 2025 18:53:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 ffc475939e97133b640dc09ecc7f8909a2e3088a
Message-ID: <202502281841.DnNGmazS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: ffc475939e97133b640dc09ecc7f8909a2e3088a  PCI: dwc: Add Rockchip to the RAS DES allowed vendor list

elapsed time: 1460m

configs tested: 77
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250227    gcc-13.2.0
arc                  randconfig-002-20250227    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                  randconfig-001-20250227    gcc-14.2.0
arm                  randconfig-002-20250227    clang-17
arm                  randconfig-003-20250227    gcc-14.2.0
arm                  randconfig-004-20250227    clang-21
arm64                randconfig-001-20250227    gcc-14.2.0
arm64                randconfig-002-20250227    clang-19
arm64                randconfig-003-20250227    gcc-14.2.0
arm64                randconfig-004-20250227    gcc-14.2.0
csky                 randconfig-001-20250227    gcc-14.2.0
csky                 randconfig-002-20250227    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250227    clang-14
hexagon              randconfig-002-20250227    clang-16
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250227    gcc-12
i386       buildonly-randconfig-002-20250227    gcc-11
i386       buildonly-randconfig-003-20250227    clang-19
i386       buildonly-randconfig-004-20250227    gcc-12
i386       buildonly-randconfig-005-20250227    gcc-11
i386       buildonly-randconfig-006-20250227    clang-19
loongarch            randconfig-001-20250227    gcc-14.2.0
loongarch            randconfig-002-20250227    gcc-14.2.0
nios2                randconfig-001-20250227    gcc-14.2.0
nios2                randconfig-002-20250227    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250227    gcc-14.2.0
parisc               randconfig-002-20250227    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250227    clang-19
powerpc              randconfig-002-20250227    gcc-14.2.0
powerpc              randconfig-003-20250227    clang-19
powerpc64            randconfig-001-20250227    clang-17
powerpc64            randconfig-002-20250227    clang-21
powerpc64            randconfig-003-20250227    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250227    gcc-14.2.0
riscv                randconfig-002-20250227    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250227    clang-18
s390                 randconfig-002-20250227    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250227    gcc-14.2.0
sh                   randconfig-002-20250227    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250227    gcc-14.2.0
sparc                randconfig-002-20250227    gcc-14.2.0
sparc64              randconfig-001-20250227    gcc-14.2.0
sparc64              randconfig-002-20250227    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250227    clang-17
um                   randconfig-002-20250227    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250227    clang-19
x86_64     buildonly-randconfig-002-20250227    clang-19
x86_64     buildonly-randconfig-003-20250227    gcc-12
x86_64     buildonly-randconfig-004-20250227    gcc-12
x86_64     buildonly-randconfig-005-20250227    clang-19
x86_64     buildonly-randconfig-006-20250227    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250227    gcc-14.2.0
xtensa               randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

