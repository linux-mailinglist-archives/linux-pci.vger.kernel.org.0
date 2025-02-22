Return-Path: <linux-pci+bounces-22069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F174AA40524
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 03:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2767427C6A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1A1FC0F9;
	Sat, 22 Feb 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIl69QI7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4221FBEB3
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192269; cv=none; b=Rqyh71S7hH1GI54A9j38G5aU53SHSiVwwzsbuKlkTc9POYUVlAts7FBusi7B008yaES3Jaw5FEQw0MHaVH3/vtcGU3l7GINxwoyw7/cEuzYGhF/mDZAgRUEmtsqQ4fJzXQYjaUwUHWNNQm0rMnzEyH2mWY0RQhGQfj8xgJTCN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192269; c=relaxed/simple;
	bh=i7Cwdx5FNL2Pw9Mx9jX414ukiRZjyhwrYxaaV0G2D3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hijfwq9oFV7So1qZMdBbPvfhlsFU2lZN+KFR4C1JN8HaWhPZPyMJ6Slj2S7Bexvk4vW3k79gdXSf0nIWVE0ac5o2DHAFR9Xn4ntvqXcfFpLhoNzL92Ooiyee8gyYwu1LZDnOKZ8uZd11nKw4yaFzkfN+lsBfUOc5HIFdHNMdS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIl69QI7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740192268; x=1771728268;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i7Cwdx5FNL2Pw9Mx9jX414ukiRZjyhwrYxaaV0G2D3g=;
  b=JIl69QI7QdkcKC1XFpmI/O4TOfSJIJau2q65Qxf2wa9m9TxvldJQQQ3J
   xuhO0N5tP9vIKi17OS81rSL4NQRNtASw8XQf1ck6CmafigujGk7jeZRev
   Mid8GIT/fwTFqfIa4obew2PcTTlip1EiTKEB1syYyBIv+5oP3v9SOeRo9
   bRQicnhEPf33ig9jnGONLzSeZNPwyz4r2dKZ6pVsczEeqsLJNLtWP4i7q
   FNEBQVYdC0F1Mg1DP27TOwtVIWu2tTFh+/KYpqAGp8qoKXe99VevuMwQN
   v7ZfmiBifdZV3ardAZq6DpCWDA8sdCOhFAwymwXKbVVr6BjJ4xw0HYmyc
   A==;
X-CSE-ConnectionGUID: A3Lpe/5LTguo+1fVdcb9Jw==
X-CSE-MsgGUID: IGSxkZPOTiyRGI00/XnuIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="52009323"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="52009323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 18:44:27 -0800
X-CSE-ConnectionGUID: /pu4vdHsQKqBpdtF623zlA==
X-CSE-MsgGUID: yKk+nGvCRc6LtkgJWXFNSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="115248412"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 21 Feb 2025 18:44:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlfV9-0006Ev-2j;
	Sat, 22 Feb 2025 02:44:23 +0000
Date: Sat, 22 Feb 2025 10:43:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 69995e6c92361dfcabbe95b79ceb6ed1f55db3c4
Message-ID: <202502221013.qCgaTlHn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 69995e6c92361dfcabbe95b79ceb6ed1f55db3c4  PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type

elapsed time: 1458m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250221    gcc-13.2.0
arc                  randconfig-002-20250221    gcc-13.2.0
arm                  randconfig-001-20250221    gcc-14.2.0
arm                  randconfig-002-20250221    clang-19
arm                  randconfig-003-20250221    gcc-14.2.0
arm                  randconfig-004-20250221    clang-21
arm64                randconfig-001-20250221    clang-15
arm64                randconfig-002-20250221    clang-21
arm64                randconfig-003-20250221    clang-21
arm64                randconfig-004-20250221    gcc-14.2.0
csky                 randconfig-001-20250221    gcc-14.2.0
csky                 randconfig-002-20250221    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250221    clang-21
hexagon              randconfig-002-20250221    clang-21
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
loongarch            randconfig-001-20250221    gcc-14.2.0
loongarch            randconfig-002-20250221    gcc-14.2.0
nios2                randconfig-001-20250221    gcc-14.2.0
nios2                randconfig-002-20250221    gcc-14.2.0
parisc               randconfig-001-20250221    gcc-14.2.0
parisc               randconfig-002-20250221    gcc-14.2.0
powerpc              randconfig-001-20250221    clang-21
powerpc              randconfig-002-20250221    clang-21
powerpc              randconfig-003-20250221    clang-17
powerpc64            randconfig-001-20250221    clang-21
powerpc64            randconfig-002-20250221    clang-21
powerpc64            randconfig-003-20250221    clang-19
riscv                randconfig-001-20250221    clang-21
riscv                randconfig-002-20250221    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250221    gcc-14.2.0
s390                 randconfig-002-20250221    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250221    gcc-14.2.0
sh                   randconfig-002-20250221    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250221    gcc-14.2.0
sparc                randconfig-002-20250221    gcc-14.2.0
sparc64              randconfig-001-20250221    gcc-14.2.0
sparc64              randconfig-002-20250221    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250221    gcc-12
um                   randconfig-002-20250221    gcc-12
x86_64     buildonly-randconfig-001-20250221    gcc-12
x86_64     buildonly-randconfig-002-20250221    clang-19
x86_64     buildonly-randconfig-003-20250221    clang-19
x86_64     buildonly-randconfig-004-20250221    clang-19
x86_64     buildonly-randconfig-005-20250221    clang-19
x86_64     buildonly-randconfig-006-20250221    clang-19
xtensa               randconfig-001-20250221    gcc-14.2.0
xtensa               randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

