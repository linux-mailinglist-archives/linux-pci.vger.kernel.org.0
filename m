Return-Path: <linux-pci+bounces-20020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B009EA14454
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 23:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300993A0F9C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948B158520;
	Thu, 16 Jan 2025 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CI14VsnZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FD7D07D
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064867; cv=none; b=JPtq5xgtZoEHtwhLnOid9irAImYOya4/l13gS4HkAAUks7uU+iKkq8n/KEO4wVBvdj10rZBG4sfypRd/obKhJusu8s0kuQp/Lcd3wUPu+6uSERMfdb6ADgI2Hliy/2W0OLg5UCV7XCVha4LPL/otTeLQK58thBcP6/kWzZmab6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064867; c=relaxed/simple;
	bh=26kQYRqwFgJuIjwsFjBzj/6PxIyZl3WsA0ZL5s78buI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z83RDcqiCp1apKEloHOXsZjcg5jdUVS6PLFNSMTKAtbACI3bpKgP6ZckVvRqi/dHc3osFIpomUAt46SyQT2VnHOLYBVWfhCyhdPM2V9f89WnGrbOkn+e/OGKiIBYRalRaen+KED2AkZygt+cyMQmiLLL+yc8qOhREkpPXu+MDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CI14VsnZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737064865; x=1768600865;
  h=date:from:to:cc:subject:message-id;
  bh=26kQYRqwFgJuIjwsFjBzj/6PxIyZl3WsA0ZL5s78buI=;
  b=CI14VsnZxR8jpKdnvDyDhAOAJecbnFUiGi9dJjjytIOhgHWXsDe56wR9
   ykmZi6n1PK1neQtm6dBgJ9xdDPN+2mqHljLoC0/XoicDjpJRVPiTFtwGc
   JjIaqiu7xtm/3tdLXvqbpPMAsID0/n1tVdH3yCw8yRNpkougVfBpZWmad
   Tm7bfuX6SKg9EfEYqRF33sBWsslTDFIWcVbpkDB/TezFceKDE82dDnIGu
   zN4Cg7mGQYKmZq2dyb+Mi+XcmJwi1BYq3zwIO+d7HFQqkU0VB8QL+huf6
   yd0qLleDc5QhvMaiEugGwhKmS0BNZjybhOjSa1Rd4NT2BSUy0rxlMsGtT
   w==;
X-CSE-ConnectionGUID: GJRl9Hi4Sm+IgZdd5TYumw==
X-CSE-MsgGUID: w5JVoyk3Tu6myiO06ZK76g==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37392858"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37392858"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 14:01:04 -0800
X-CSE-ConnectionGUID: trNfG3uzRVO0cyfIvf8yYg==
X-CSE-MsgGUID: ZlpivWnfQp28TiGRJXZOuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105465421"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Jan 2025 14:01:03 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYXvB-000SQx-03;
	Thu, 16 Jan 2025 22:01:01 +0000
Date: Fri, 17 Jan 2025 06:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:of] BUILD SUCCESS
 d117b196981755a7757849fd4676e029afb43bca
Message-ID: <202501170600.lPp0oldX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git of
branch HEAD: d117b196981755a7757849fd4676e029afb43bca  sparc/PCI: Update reference to devm_of_pci_get_host_bridge_resources()

elapsed time: 1444m

configs tested: 90
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250116    gcc-13.2.0
arc                   randconfig-002-20250116    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                         mv78xx0_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                   randconfig-001-20250116    gcc-14.2.0
arm                   randconfig-002-20250116    clang-15
arm                   randconfig-003-20250116    gcc-14.2.0
arm                   randconfig-004-20250116    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250116    gcc-14.2.0
arm64                 randconfig-002-20250116    gcc-14.2.0
arm64                 randconfig-003-20250116    clang-15
arm64                 randconfig-004-20250116    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250116    gcc-14.2.0
csky                  randconfig-002-20250116    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250116    clang-20
hexagon               randconfig-002-20250116    clang-20
i386        buildonly-randconfig-001-20250116    clang-19
i386        buildonly-randconfig-002-20250116    clang-19
i386        buildonly-randconfig-003-20250116    clang-19
i386        buildonly-randconfig-004-20250116    clang-19
i386        buildonly-randconfig-005-20250116    clang-19
i386        buildonly-randconfig-006-20250116    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250116    gcc-14.2.0
loongarch             randconfig-002-20250116    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250116    gcc-14.2.0
nios2                 randconfig-002-20250116    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250116    gcc-14.2.0
parisc                randconfig-002-20250116    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    clang-18
powerpc               randconfig-001-20250116    clang-20
powerpc               randconfig-002-20250116    gcc-14.2.0
powerpc               randconfig-003-20250116    clang-20
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250116    clang-19
powerpc64             randconfig-002-20250116    clang-20
powerpc64             randconfig-003-20250116    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250116    gcc-14.2.0
riscv                 randconfig-002-20250116    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250116    gcc-14.2.0
s390                  randconfig-002-20250116    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250116    gcc-14.2.0
sh                    randconfig-002-20250116    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250116    gcc-14.2.0
sparc                 randconfig-002-20250116    gcc-14.2.0
sparc64               randconfig-001-20250116    gcc-14.2.0
sparc64               randconfig-002-20250116    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250116    clang-19
um                    randconfig-002-20250116    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250116    gcc-12
x86_64      buildonly-randconfig-002-20250116    gcc-12
x86_64      buildonly-randconfig-003-20250116    gcc-12
x86_64      buildonly-randconfig-004-20250116    clang-19
x86_64      buildonly-randconfig-005-20250116    clang-19
x86_64      buildonly-randconfig-006-20250116    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250116    gcc-14.2.0
xtensa                randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

