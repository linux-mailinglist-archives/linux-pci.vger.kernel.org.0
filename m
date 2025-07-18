Return-Path: <linux-pci+bounces-32476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B8B098F7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 02:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6955A0140
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A11EF1D;
	Fri, 18 Jul 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbOKzEA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700985695
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798603; cv=none; b=e3qklagM0BF4jPbQ3ZXflKwaoJbNAZU2vPnwLuyCXSOk9GWb1//oJX9Ksm/CPdv6icjX03E0A1BBed5oIthwYjjHu5Ry7oIfrlRmDw+799uhTr4KRvGQQVr495kagjlKbtJDGltngWFSDdL8NlvLqRaWRbXnKzMhxlzcUJRDTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798603; c=relaxed/simple;
	bh=t0KiUCIPNtKBaA9RxQR179C6WLYfclLjjvB1W8lbLA4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dtUpB7sYqjTHUXxE8iBE+piQabULkRh2sfPPDp9deeQRF0OH9OCRbOCNNgTUfSMdgpArGp/23Tissuv8pO3I86sxJy1VK90wkIez6hOHXULUjOJnAucRqSIxh9cU1wmuP+Juexkuw+I6CkY74NcMyXfVMFyyKoPPkIjsx4LqpKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbOKzEA+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752798601; x=1784334601;
  h=date:from:to:cc:subject:message-id;
  bh=t0KiUCIPNtKBaA9RxQR179C6WLYfclLjjvB1W8lbLA4=;
  b=CbOKzEA+Fzf96WwKudar/sq3TqxVSosRrsOJtCigTiaIr1/zwRldhgGh
   oQjIowweZ1es/8XkOXF7GD4AvQ0QrmaybdgVHU8CTIiSb2v2RrS3FQOJX
   BQBVXvdRjeh+QZ7yazqOdfxowICPD3Etjo6mhxytXtfP+HaHJSBaalCv5
   wkKIRgknzo73CmoI+XDJ3ld3125USS6vmmwjAb4XHiNzJw2qXk2kbcvYP
   r7XPEeoE25D1ps8kByNFqCA0A+zvBNrz8b9tJTJH/MA5U2cTVx0ginMTW
   5LxOkM17Qln/FeI3yW0kHPDNJjZKbgm0W8vW/O8hvpFRzhNXb+Dw5GFvK
   A==;
X-CSE-ConnectionGUID: dPSSdv5lSGOP0+cjHr/IHQ==
X-CSE-MsgGUID: KFT5/WQyRRSPlc1hXh7KaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="72658087"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="72658087"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:29:59 -0700
X-CSE-ConnectionGUID: fPwRpmZbROS5tKz9e0aJRw==
X-CSE-MsgGUID: lUgSU8plSIaC6JVJjzY5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188879480"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Jul 2025 17:29:56 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucYz1-000EAI-11;
	Fri, 18 Jul 2025 00:29:51 +0000
Date: Fri, 18 Jul 2025 08:29:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:capability-search] BUILD SUCCESS
 8459dfeed1ab6f61a4ef14d77077a64b98151637
Message-ID: <202507180858.eC6f0aSM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git capability-search
branch HEAD: 8459dfeed1ab6f61a4ef14d77077a64b98151637  PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets

elapsed time: 1447m

configs tested: 111
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250717    gcc-8.5.0
arc                   randconfig-002-20250717    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250717    clang-21
arm                   randconfig-002-20250717    gcc-8.5.0
arm                   randconfig-003-20250717    gcc-8.5.0
arm                   randconfig-004-20250717    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250717    clang-18
arm64                 randconfig-002-20250717    clang-18
arm64                 randconfig-003-20250717    gcc-10.5.0
arm64                 randconfig-004-20250717    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250717    gcc-15.1.0
csky                  randconfig-002-20250717    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250717    clang-20
hexagon               randconfig-002-20250717    clang-19
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250717    gcc-12
i386        buildonly-randconfig-002-20250717    gcc-12
i386        buildonly-randconfig-003-20250717    clang-20
i386        buildonly-randconfig-004-20250717    clang-20
i386        buildonly-randconfig-005-20250717    clang-20
i386        buildonly-randconfig-006-20250717    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250717    gcc-15.1.0
loongarch             randconfig-002-20250717    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250717    gcc-8.5.0
nios2                 randconfig-002-20250717    gcc-9.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250717    gcc-9.3.0
parisc                randconfig-002-20250717    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-21
powerpc               randconfig-001-20250717    clang-21
powerpc               randconfig-002-20250717    gcc-13.4.0
powerpc               randconfig-003-20250717    clang-21
powerpc64             randconfig-001-20250717    clang-21
powerpc64             randconfig-002-20250717    clang-18
powerpc64             randconfig-003-20250717    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250717    gcc-14.3.0
riscv                 randconfig-002-20250717    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250717    gcc-8.5.0
s390                  randconfig-002-20250717    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250717    gcc-14.3.0
sh                    randconfig-002-20250717    gcc-9.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250717    gcc-14.3.0
sparc                 randconfig-002-20250717    gcc-8.5.0
sparc64               randconfig-001-20250717    gcc-12.4.0
sparc64               randconfig-002-20250717    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250717    gcc-12
um                    randconfig-002-20250717    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250717    clang-20
x86_64      buildonly-randconfig-002-20250717    clang-20
x86_64      buildonly-randconfig-003-20250717    clang-20
x86_64      buildonly-randconfig-004-20250717    gcc-12
x86_64      buildonly-randconfig-005-20250717    gcc-12
x86_64      buildonly-randconfig-006-20250717    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250717    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

