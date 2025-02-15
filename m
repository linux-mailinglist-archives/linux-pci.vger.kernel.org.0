Return-Path: <linux-pci+bounces-21552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2555FA370DE
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 22:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA37A16FFB1
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF431F4172;
	Sat, 15 Feb 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/adXDWS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA1151991
	for <linux-pci@vger.kernel.org>; Sat, 15 Feb 2025 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739654557; cv=none; b=OiL7QKfN+mtZLwk1jP1EyT4hb6GJdpranJmHtADcWLGzzwleGk9XyduMb9Y4IbfZ09O065iIsC22vzqHhvdi3jCz9TunM3D1vkdKZHTWdBEohAlg9CCtC2XDzXOv1s2qWJTI0pjKhiAVZu8WXyIme/myYky2F5Pw0aj2PPCd84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739654557; c=relaxed/simple;
	bh=SdYHsDWSpHL377KGur0FkvzpjTudTqmF5jZtQBjcfjM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kAQxULc8aYvnQ/KznS0yLZq/eBcW3mOhP5yEcT9w9ztwofuyre4ebr3U2D7SGIpcyJl1lLzC5ulLjWJp9MUOEuT0KnjRvawyA2xd6qvnKziCR64XVCk4f48Xr8gNmBm8q7NA3rTktDl05rJNfMA/3gIDQ3n3A/FkB8rilbNNGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/adXDWS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739654555; x=1771190555;
  h=date:from:to:cc:subject:message-id;
  bh=SdYHsDWSpHL377KGur0FkvzpjTudTqmF5jZtQBjcfjM=;
  b=l/adXDWSdz0GfHJbl00UW/dh495REiF1270UMG06Mq/OLWUYUkIZBmdV
   euCok63o/ZjsKr57CXN8uyy11AOiEqqCdMO4w/eH6SiSKhme77M7EZyiL
   TolS+qOzwMRStexnmj3TTx/eGow2x7Uzfmei+/pEzIyQFS7fZO3oWbPCM
   +WiIZvhnYO2yW/OrJSoREHbamAMzGTxovzzXjIb8mq0yJvwCL2pRivzcJ
   Zn25Gkllmn9KO3nWzO8y0bMRFnaFbVIg8bL4+a/sce0UrH9BsHk4Gbz0P
   VUU+LftHgjlvOenmxjBru7QTiO+x1POqN3HD1Fu2obWN8GwfAjzqHCCzZ
   g==;
X-CSE-ConnectionGUID: QAxPn8wgR1ib5PRhfObw3w==
X-CSE-MsgGUID: 0hYGh6zDQySQXrAhilpi5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="51027399"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="51027399"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 13:22:35 -0800
X-CSE-ConnectionGUID: Kfa/lCKiSCmRvBizvse/ng==
X-CSE-MsgGUID: 17b0AZGVSMChoTXU99oMeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114247829"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Feb 2025 13:22:34 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjPcN-001BBs-1M;
	Sat, 15 Feb 2025 21:22:31 +0000
Date: Sun, 16 Feb 2025 05:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 28d3871db7ef8ad0112f195c48a72d8638af89d1
Message-ID: <202502160555.TKQfBjWQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 28d3871db7ef8ad0112f195c48a72d8638af89d1  PCI: Descope pci_printk() to aer_printk()

elapsed time: 1443m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250215    gcc-13.2.0
arc                   randconfig-002-20250215    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250215    clang-15
arm                   randconfig-002-20250215    clang-17
arm                   randconfig-003-20250215    gcc-14.2.0
arm                   randconfig-004-20250215    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250215    clang-21
arm64                 randconfig-002-20250215    gcc-14.2.0
arm64                 randconfig-003-20250215    clang-17
arm64                 randconfig-004-20250215    gcc-14.2.0
csky                  randconfig-001-20250215    gcc-14.2.0
csky                  randconfig-002-20250215    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250215    clang-21
hexagon               randconfig-002-20250215    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250215    gcc-12
i386        buildonly-randconfig-002-20250215    clang-19
i386        buildonly-randconfig-003-20250215    clang-19
i386        buildonly-randconfig-004-20250215    gcc-12
i386        buildonly-randconfig-005-20250215    clang-19
i386        buildonly-randconfig-006-20250215    clang-19
i386                                defconfig    clang-19
loongarch             randconfig-001-20250215    gcc-14.2.0
loongarch             randconfig-002-20250215    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250215    gcc-14.2.0
nios2                 randconfig-002-20250215    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                randconfig-001-20250215    gcc-14.2.0
parisc                randconfig-002-20250215    gcc-14.2.0
powerpc               randconfig-001-20250215    gcc-14.2.0
powerpc               randconfig-002-20250215    clang-21
powerpc               randconfig-003-20250215    clang-19
powerpc64             randconfig-001-20250215    gcc-14.2.0
powerpc64             randconfig-002-20250215    clang-21
powerpc64             randconfig-003-20250215    gcc-14.2.0
riscv                 randconfig-001-20250215    clang-17
riscv                 randconfig-002-20250215    clang-19
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250215    gcc-14.2.0
s390                  randconfig-002-20250215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250215    gcc-14.2.0
sh                    randconfig-002-20250215    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250215    gcc-14.2.0
sparc                 randconfig-002-20250215    gcc-14.2.0
sparc64               randconfig-001-20250215    gcc-14.2.0
sparc64               randconfig-002-20250215    gcc-14.2.0
um                               allmodconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250215    clang-21
um                    randconfig-002-20250215    clang-19
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250215    gcc-12
x86_64      buildonly-randconfig-002-20250215    clang-19
x86_64      buildonly-randconfig-003-20250215    gcc-12
x86_64      buildonly-randconfig-004-20250215    clang-19
x86_64      buildonly-randconfig-005-20250215    clang-19
x86_64      buildonly-randconfig-006-20250215    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250215    gcc-14.2.0
xtensa                randconfig-002-20250215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

