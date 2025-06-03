Return-Path: <linux-pci+bounces-28911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A08ACCE3A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 22:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEE73A4954
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DF1BA34;
	Tue,  3 Jun 2025 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG+z2k9q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC0AD23
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982762; cv=none; b=sycdfeZl1Akrmn7mOGQa5zr3E0IXzNq0WYGIr7qcnkcHVRru+JI/0+AwBCXL2CCc0HwkE+YyfF0X+7QiRqS2tuDV3nHe/TnRzJGx0GdlJhB0SWJvRMyXtrzcxYqhAIlftxeyHj5QAfqJwXy+KQuQUxVGVX93vLqmNqBSX743iBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982762; c=relaxed/simple;
	bh=X5TxqNBZXZo4clDgi67spW5gHlzYYn5IT5bd5nTI3U0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NfYURm9hHYmnjJSYGYDuu5CDF1TF0i3vg+k79pHtL0Sr3F3v7i+fwb5qNMSf3xQOegJ1qnoHk2j0XEwxGhm7yaCEik+te2cEKO28Qbb+od3sAx320b6ufOahk06m9E4risFxMLL5qn2IOdJ8i9VGLrdaIKLtQJqGaST8pGX65Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG+z2k9q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748982762; x=1780518762;
  h=date:from:to:cc:subject:message-id;
  bh=X5TxqNBZXZo4clDgi67spW5gHlzYYn5IT5bd5nTI3U0=;
  b=XG+z2k9qlzrLOjuZ/CtSBHn8KnUNpKy6v9j4lROS5op24PM97+VZBTub
   mxeGFKJP4CnHS9sFQsgpZk04B06JbgqmZUnBc6/4ThA5b5qIObTCj3zAM
   I6kphYvyNU6Qv2V8IYvTCimllEhJkBl53syCkUKzBUl/rEqYD16Y7eMGn
   Cy757tpT5hN9YkkXimL4ekd6HsZP56lxPKNGwk4srClbBMB74MTssvRDB
   dAg8WHT5zg+hGRVQjPwJt7FEsZ8viPSkapOl4oBr4xmmRc9sIPAzHEttG
   QRBLyHwYVFwj//NSus/tfzF2HBlM26MnKst7ZRoSixTQu21SJnJTDqaQ0
   w==;
X-CSE-ConnectionGUID: sb5qGISARU+ze38ZfJJUpQ==
X-CSE-MsgGUID: ahE7ITFHT5eTfhxwzxSwNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54704959"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="54704959"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 13:32:41 -0700
X-CSE-ConnectionGUID: Rusz74J8QeKsec6qKUOKnQ==
X-CSE-MsgGUID: wcA2pJeCTeet3qfbRTS4yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="148803810"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Jun 2025 13:32:40 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMYJJ-0002i9-1Z;
	Tue, 03 Jun 2025 20:32:37 +0000
Date: Wed, 04 Jun 2025 04:32:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 8fb7bccf507dcf6f5bc03bb7a7533a68c89785ff
Message-ID: <202506040410.97In0ZIQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 8fb7bccf507dcf6f5bc03bb7a7533a68c89785ff  Merge branch 'pci/misc'

elapsed time: 1025m

configs tested: 35
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm          allmodconfig    gcc-15.1.0
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
hexagon      allmodconfig    clang-17
hexagon      allyesconfig    clang-21
i386         allmodconfig    gcc-12
i386          allnoconfig    gcc-12
i386         allyesconfig    gcc-12
i386            defconfig    clang-20
loongarch    allmodconfig    gcc-15.1.0
m68k         allmodconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze   allmodconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
openrisc     allyesconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc      allyesconfig    clang-21
riscv        allmodconfig    clang-21
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc        allmodconfig    gcc-15.1.0
um           allmodconfig    clang-19
um           allyesconfig    gcc-12
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64          defconfig    gcc-11
x86_64      rhel-9.4-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

