Return-Path: <linux-pci+bounces-22094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC1A408BA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479883B5D78
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A786325;
	Sat, 22 Feb 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J68FtcTI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126727453
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231314; cv=none; b=klsaxB0OCQpN3G8QV2k0hayTjJJCgAXnJ111njbF0eLx922tAomvJ2hk16Si+S9veKbx2W4Za9E+79an+LpJydPzAqTqHXv14Hpl4t9sQd80Kj/7vi2N+K4rp9GJw556iZ9jESAtc7cKwz/wnxVEYJS0ksahHi6PEJqwHZA9tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231314; c=relaxed/simple;
	bh=NBEVozTnUv6Z6LpnTIHV7W/SvjSx9K5mbVjC/VZvAdU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JUr1VWVoDsKqajrc0HX6XyGW1nfmnllgnfSeU0zEHXYGPDeBOjVJRTR5dUpohVo5kqZY/0JDS5ncXVc1jxrkzprth6+DWGqo133AxWYEwlIhzeXV6GXip7lKC0a7iHxBPTecgk18YGqt/MddnAYyG8iu8R1K6ns6nkaMx4DUVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J68FtcTI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740231312; x=1771767312;
  h=date:from:to:cc:subject:message-id;
  bh=NBEVozTnUv6Z6LpnTIHV7W/SvjSx9K5mbVjC/VZvAdU=;
  b=J68FtcTIwHhCQaiHdgPQPd4LfG0tDdsSDKJbbziyWkjZ01g+WiSy2ZC/
   tS4GNR8b8QVZsGOjS+uD0TMBiLwnPnQDACD12DJ2USbME7ubtoS4qwI5I
   5FrV5e1xIRvFfzgTEkFP5FuvVMX9SU/1EfwPsIiaOEMSsHT11i4efn/3g
   kE4xl85WJvl5Ol8cXPbD6rPmC6uWahKOlhc/zjFVuY48fpN8GG1h+jvGs
   jHaaIeagH9ZsH51B/AWGeuSDxrM0eRyVE2HiFPQOIjukFeRe64BI+blOT
   NDjBDI0p0A9W1H+oghZD/e1JNyG8N0ODPOrFYmITEDXAEBZg7UWkmKMnI
   A==;
X-CSE-ConnectionGUID: dTH+KH+AQ4Ks7jsj/AjQaA==
X-CSE-MsgGUID: hiPtsAWXROuKZC8h3+rKvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="40230538"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="40230538"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 05:35:11 -0800
X-CSE-ConnectionGUID: e4xi5O7IQqqsHyKxQrIo/g==
X-CSE-MsgGUID: Disl+5iMRVqoZuwGzjUTVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="120540096"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2025 05:35:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlpeu-0006c0-0r;
	Sat, 22 Feb 2025 13:35:08 +0000
Date: Sat, 22 Feb 2025 21:34:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 3bdee909e45ddeb798215801b19c7b8d125581df
Message-ID: <202502222121.Ch80I5Ce-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 3bdee909e45ddeb798215801b19c7b8d125581df  Merge branch 'pci/misc'

elapsed time: 1452m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

