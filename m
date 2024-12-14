Return-Path: <linux-pci+bounces-18444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930089F208C
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 20:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0AB188805B
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1BB13C3F6;
	Sat, 14 Dec 2024 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxGbthpt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE641119A
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203504; cv=none; b=LeIHc2VDgctT+3V7PYsLZq3v1h5a5des4gn2KP6OUloNuO5wUMLT7AcwtnlqnisQ1bTtVR9YL89xbwQwH4mi1HDiO7ge5sm77nkEQrB+eUIGuB4157HJ6OVMzcQ3ougMFzjXSOnqS5JipkUssEJGLd6e0ViahBIAbd2qYJESozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203504; c=relaxed/simple;
	bh=mfs488wp/fRIY1wAjMkA/yBG2kW6I2RUGi+zzushf5c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ChhskrRh99i6n33rjodVd8eb3hlQ9kTmc026Xe+nxz14Bu7wNDNIjH8fnXhDewTrojxq47dYjWL33fjRAKsGMBoEEbDgZIB8xBAQcdWrug4xKcIlhSZ4uSUH1X60BZB9u8bY6DwpfS9kca0nhvbOjfwrM0/WP99DWmFTuu7ZKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxGbthpt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734203502; x=1765739502;
  h=date:from:to:cc:subject:message-id;
  bh=mfs488wp/fRIY1wAjMkA/yBG2kW6I2RUGi+zzushf5c=;
  b=AxGbthptlZarfaQUOYVrVycj/c+hrwjTWDJQGzgoT2hAExb34ntdRoxn
   ceu21Q50HGwuBcAvpH8shkwRtGnNvw9aBizxPvEY87JqYUvsyNeFBCMNf
   j62HNhz6pzwoPzB/60YcdX6JZ5epiiWDFrAJUz0dxJxP9pppwDFBliryo
   kXtXGv1Es3I7QA7VQl2jeoFN6p+WfMoel3dWn9hDyte84MguxsbF2N0oV
   4Dvh9a8HZ+fP3q+W/adpPZZM8Qy0h6MmxlnfR2pgTLPFZstm7pqI4gfPb
   XDpOLPGxPROMxd0F7ww1bZ90QjyVblb9atH6gnZfHn4ZXw/P7fPjz3Y91
   w==;
X-CSE-ConnectionGUID: Nekabr1NRYeC1rSz7uRzhA==
X-CSE-MsgGUID: F8OXTgbJTKScL/efp8BSGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45117718"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45117718"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 11:11:41 -0800
X-CSE-ConnectionGUID: PJrVkjh7R1aVb+Djt7JNpA==
X-CSE-MsgGUID: XBE6BO3JTPa9Acu9U2D4Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101413558"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Dec 2024 11:11:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMXY9-000D9z-2S;
	Sat, 14 Dec 2024 19:11:37 +0000
Date: Sun, 15 Dec 2024 03:10:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 1db806ec06b7c6e08e8af57088da067963ddf117
Message-ID: <202412150349.iShuIdBG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: 1db806ec06b7c6e08e8af57088da067963ddf117  PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()

elapsed time: 1445m

configs tested: 56
configs skipped: 1

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

