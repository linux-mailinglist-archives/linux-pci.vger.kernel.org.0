Return-Path: <linux-pci+bounces-25683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29DDA86198
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC9116C89A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838D10A1E;
	Fri, 11 Apr 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSxHf7fR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C921F91F6
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384647; cv=none; b=ORvoilgYgq88BmiZRe2ExN/y8dYOA54a4jw9FpDWPcRIBBfxxYIlAdrWjOkdD6aqQFnWBkDtiYuq+i+2kgvla/Hv4cRzdTKsqUcfTGiyWssq44aCk93qo89M8SQuqbUTEQ0WlSjljFF3HryCdKsjO1ZAfnQ/nUZscSTHIta9tNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384647; c=relaxed/simple;
	bh=WQszYwkG3xdtb4HD27oHt8DPNN9BAAOiUT4thHkoB+k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gNWOGATSiWpVva1MT3L/YI6AvZSCM1AsgK1yK3C8WTRBla7BybtjWcxtQK96jKEpsws5ES0apeCnuX63np+0fqIIfB0YCb0ELBV3WBFL1FB6E5i4yY/B3zSG7zwARCPwgKHqBJzOy9Jh/hcA1txLbxbeGMbDAcAQW3ZjGG3KQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSxHf7fR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384646; x=1775920646;
  h=date:from:to:cc:subject:message-id;
  bh=WQszYwkG3xdtb4HD27oHt8DPNN9BAAOiUT4thHkoB+k=;
  b=mSxHf7fRf4a/JDlCUlsmoh+WosOVUhXjhCUR1C9sf2H2vTN4yNh9b40/
   FelXRZIk59jFQdimIzY+OW+6tXmgWyKfk/Ftwx24F6kxifNLsohSoy5mn
   LfDdf5BCcbihoz6gezhJJNmL8g0jxl9j/plYICGwmqfFQeU4kWaAkiGC9
   D4Ke6V6YEZh85l7v8ufkON3Fvfw3d1Md0m/xBIHAS6EE42l5P24SRXptd
   09MGqw1d5PFyV9wLrQZdSBHKMCnCMAiMa3FrHzjm1I5kALNalKZXjdNHP
   e7sxunbJzSTcO97ZgwSi43+I+Hs89E7dWZQHjUb8CLIdTapzgXQvXDQFN
   Q==;
X-CSE-ConnectionGUID: Cy8yRJmRSZ6eZAZoKW2ERA==
X-CSE-MsgGUID: NLGQLC+SR8iQ8toraC+EJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56604868"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56604868"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:17:25 -0700
X-CSE-ConnectionGUID: X1D0zwwHTUeCt4WElau8yg==
X-CSE-MsgGUID: EVILs2arS1WJ83dydo8KaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="130213576"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Apr 2025 08:17:25 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3G89-000BB3-30;
	Fri, 11 Apr 2025 15:17:21 +0000
Date: Fri, 11 Apr 2025 23:17:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 74a70e80daa993445a8f0be817f8152a3b9d3b41
Message-ID: <202504112305.fbkmVYjN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 74a70e80daa993445a8f0be817f8152a3b9d3b41  PCI: Remove pci_fixup_cardbus()

elapsed time: 1451m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250411    gcc-14.2.0
arc                   randconfig-002-20250411    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250411    clang-21
arm                   randconfig-002-20250411    clang-21
arm                   randconfig-003-20250411    gcc-6.5.0
arm                   randconfig-004-20250411    gcc-6.5.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250411    gcc-9.5.0
arm64                 randconfig-002-20250411    gcc-9.5.0
arm64                 randconfig-003-20250411    clang-21
arm64                 randconfig-004-20250411    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250411    gcc-14.2.0
csky                  randconfig-002-20250411    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250411    clang-21
hexagon               randconfig-002-20250411    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250411    gcc-12
i386        buildonly-randconfig-002-20250411    gcc-12
i386        buildonly-randconfig-003-20250411    gcc-12
i386        buildonly-randconfig-004-20250411    clang-20
i386        buildonly-randconfig-005-20250411    gcc-11
i386        buildonly-randconfig-006-20250411    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250411    gcc-14.2.0
loongarch             randconfig-002-20250411    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250411    gcc-9.3.0
nios2                 randconfig-002-20250411    gcc-7.5.0
parisc                randconfig-001-20250411    gcc-14.2.0
parisc                randconfig-002-20250411    gcc-8.5.0
powerpc               randconfig-001-20250411    gcc-9.3.0
powerpc               randconfig-002-20250411    clang-21
powerpc               randconfig-003-20250411    clang-21
powerpc64             randconfig-001-20250411    gcc-5.5.0
powerpc64             randconfig-002-20250411    gcc-5.5.0
powerpc64             randconfig-003-20250411    clang-21
riscv                 randconfig-001-20250411    gcc-9.3.0
riscv                 randconfig-002-20250411    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250411    clang-19
s390                  randconfig-002-20250411    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250411    gcc-11.5.0
sh                    randconfig-002-20250411    gcc-5.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250411    gcc-10.3.0
sparc                 randconfig-002-20250411    gcc-14.2.0
sparc64               randconfig-001-20250411    gcc-8.5.0
sparc64               randconfig-002-20250411    gcc-8.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250411    clang-17
um                    randconfig-002-20250411    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250411    gcc-11
x86_64      buildonly-randconfig-002-20250411    gcc-11
x86_64      buildonly-randconfig-003-20250411    clang-20
x86_64      buildonly-randconfig-004-20250411    gcc-12
x86_64      buildonly-randconfig-005-20250411    clang-20
x86_64      buildonly-randconfig-006-20250411    gcc-12
x86_64                              defconfig    gcc-11
xtensa                randconfig-002-20250411    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

