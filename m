Return-Path: <linux-pci+bounces-43763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97589CDFD14
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 14:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1C8D3004F2A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361D1E3DDE;
	Sat, 27 Dec 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DP21mfeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2351A9F9F
	for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766842512; cv=none; b=WP0sOGCn7Bm5f6a2Eu6j4AsuB8ffHkqLdv+3ln8+tVyNlZMPCfA4EPi207a5EIEUSrahwcpQD9C/qXUyS8DJ68oSGysDjxTK0N5qu2jT5A2dfmxAe2Kt0kZSwRq+OMfVz1QANsHBRErot/KF/mDJC7mX8IlWk4rQrEL5DoQyfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766842512; c=relaxed/simple;
	bh=YAX1Zxb+HlocRknnmFU+TzJ5xod8JZHRglba3Emk9tY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kHjx/QFHihe2XRB1yejQKiCeLkTYexE/NX8Av+esYLuSYXeMoio2pZzEvOzQt0dovjWBH80+lTQVXgNj0/cblpvX35e95IsBy73KRN9BpVBSBudaA27ikiK+A1HvmCsyvtGYGrDfiDTFLVnN7z5qfEzAHKMMPDXov94LuCjR1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DP21mfeT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766842510; x=1798378510;
  h=date:from:to:cc:subject:message-id;
  bh=YAX1Zxb+HlocRknnmFU+TzJ5xod8JZHRglba3Emk9tY=;
  b=DP21mfeTSJUEiI2c0qOomXHSks0ghJKbzKvMti+/30mZjfY3Byws8MmW
   nG5gi76VXGZv+vY81MF3KwIUkH582z4tuqDJKxRdxoF0y4iYWFWjPO7Q3
   TfpW+LKd9pGU64/bTZXoatloO81HT/sMF6+VMmw9UmgD71jealbXup7ug
   24C5B4xptRULezgA/LTC1qZiZbileuknSO68H/aLZZdRBpfBzdJwPv3pd
   aK+e6HEnrrKoMAO1rQVIvT5jYh8RiSdfw2JBfbGwgIVJ1FLK6KxWhBHtU
   0YBoNwjy4NGfCe6h21FWGEHhBl19yhkzaGP0KX3BWuQdeojEGGyA3Ixp4
   w==;
X-CSE-ConnectionGUID: h5wKeUevTcylsmYbKhW2EQ==
X-CSE-MsgGUID: S/AeqqJyR2uLJ3BCQm+MxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="79267622"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="79267622"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 05:35:08 -0800
X-CSE-ConnectionGUID: GiTTPKOqQge4PE56zABeTQ==
X-CSE-MsgGUID: jwmltHGdRA6CD6udvT3QTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="204680991"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 27 Dec 2025 05:35:06 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZURk-000000005rP-0hxt;
	Sat, 27 Dec 2025 13:35:04 +0000
Date: Sat, 27 Dec 2025 21:34:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 fcbe20b73fb4f723c160065dda2b31f86df215ba
Message-ID: <202512272100.mBIcqmfT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: fcbe20b73fb4f723c160065dda2b31f86df215ba  PCI: qcom: Parse PERST# from all PCIe bridge nodes

elapsed time: 812m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251227    gcc-11.5.0
arc                   randconfig-002-20251227    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20251227    gcc-8.5.0
arm                   randconfig-002-20251227    clang-22
arm                   randconfig-003-20251227    clang-22
arm                   randconfig-004-20251227    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251227    clang-19
arm64                 randconfig-002-20251227    gcc-15.1.0
arm64                 randconfig-003-20251227    clang-20
arm64                 randconfig-004-20251227    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251227    gcc-15.1.0
csky                  randconfig-002-20251227    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251227    clang-22
hexagon               randconfig-002-20251227    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251227    clang-20
i386        buildonly-randconfig-002-20251227    clang-20
i386        buildonly-randconfig-003-20251227    clang-20
i386        buildonly-randconfig-004-20251227    clang-20
i386        buildonly-randconfig-005-20251227    clang-20
i386        buildonly-randconfig-006-20251227    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251227    clang-20
i386                  randconfig-002-20251227    clang-20
i386                  randconfig-003-20251227    clang-20
i386                  randconfig-004-20251227    gcc-13
i386                  randconfig-005-20251227    gcc-14
i386                  randconfig-006-20251227    gcc-14
i386                  randconfig-007-20251227    clang-20
i386                  randconfig-011-20251227    gcc-14
i386                  randconfig-012-20251227    clang-20
i386                  randconfig-013-20251227    gcc-14
i386                  randconfig-014-20251227    gcc-14
i386                  randconfig-015-20251227    gcc-12
i386                  randconfig-016-20251227    clang-20
i386                  randconfig-017-20251227    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251227    clang-18
loongarch             randconfig-002-20251227    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      maltasmvp_defconfig    gcc-15.1.0
mips                           rs90_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251227    gcc-11.5.0
nios2                 randconfig-002-20251227    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251227    gcc-8.5.0
parisc                randconfig-002-20251227    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251227    gcc-8.5.0
powerpc               randconfig-002-20251227    clang-22
powerpc                     taishan_defconfig    clang-17
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251227    clang-22
powerpc64             randconfig-002-20251227    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251227    clang-22
riscv                 randconfig-002-20251227    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251227    clang-22
s390                  randconfig-002-20251227    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251227    gcc-15.1.0
sh                    randconfig-002-20251227    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251227    gcc-14.3.0
sparc                 randconfig-002-20251227    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251227    gcc-8.5.0
sparc64               randconfig-002-20251227    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251227    clang-22
um                    randconfig-002-20251227    clang-19
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251227    clang-20
x86_64      buildonly-randconfig-002-20251227    clang-20
x86_64      buildonly-randconfig-003-20251227    gcc-14
x86_64      buildonly-randconfig-004-20251227    clang-20
x86_64      buildonly-randconfig-005-20251227    clang-20
x86_64      buildonly-randconfig-006-20251227    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251227    gcc-14
x86_64                randconfig-002-20251227    gcc-12
x86_64                randconfig-003-20251227    gcc-14
x86_64                randconfig-004-20251227    clang-20
x86_64                randconfig-005-20251227    gcc-14
x86_64                randconfig-006-20251227    clang-20
x86_64                randconfig-011-20251227    gcc-14
x86_64                randconfig-012-20251227    clang-20
x86_64                randconfig-013-20251227    clang-20
x86_64                randconfig-014-20251227    gcc-14
x86_64                randconfig-015-20251227    gcc-13
x86_64                randconfig-016-20251227    gcc-14
x86_64                randconfig-071-20251227    clang-20
x86_64                randconfig-072-20251227    clang-20
x86_64                randconfig-073-20251227    clang-20
x86_64                randconfig-074-20251227    clang-20
x86_64                randconfig-075-20251227    clang-20
x86_64                randconfig-076-20251227    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251227    gcc-9.5.0
xtensa                randconfig-002-20251227    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

