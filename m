Return-Path: <linux-pci+bounces-24243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A9A6AC3E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3534E1890FEE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47983224231;
	Thu, 20 Mar 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j//XmriG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06D2253A7
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492452; cv=none; b=Tr0Nu1Mn/qR1GfifycwSZCJHlu7ti+f+vB8SVog8VhYKkz0yp8hY02R2B5oJI8yCv7OeVPZ+ws94W10Zios0gfSNctklTGnIoxA3yD8ngRZ3IxM+EVIy6ptNo9caIvJBkvIdhwqTgq7/uDs0H2nia+jRm8wamZSd8F68ibA6hW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492452; c=relaxed/simple;
	bh=NztWI47GOzCr2h2uvBOVRktULfAUCg5T9+yccdebFDg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=suExt2lCETFRGsJB2dV8z7PpsLHjxYRQhUtgp4VZrgqzgLy4PgUAm5VmKmceg3NANbpfrqPmw1NRTMNBS3nLZVyL6bzYmmJXHtA3YWtVxjR51uXnMhgjU7axoaqau/QTkcO/GWbEGOuYvF2TpHu9/VWdgaQ9oxj7qvDj0LdYCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j//XmriG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742492450; x=1774028450;
  h=date:from:to:cc:subject:message-id;
  bh=NztWI47GOzCr2h2uvBOVRktULfAUCg5T9+yccdebFDg=;
  b=j//XmriGzrjlpQy8z/JKRvUMLkLCXPaMyh2srLuOvSdULgkBamrxiGu7
   mVlvCQSuaNzKxOOZmD/uesocGZKc+e5ujEIBOd05lci/1lWSMvs5I+58M
   mPlRcw3fLSNvKx9WEEOOTP8p5oL4AktmXKXX+78xcN9QFXkUjyqvdF7ya
   S9zDAKX1FKjFPMIL9kzRCyAg7jsQV/exqBQ90Q0NAqCcK9diJ6Ucbf5c9
   2/y/ovr61Hp6eI+hfRB7cbEW/OZ1kZHVcomksOiXwafcYa5ohmznE2Qye
   eNpzwQAGQH5sNGRolyRDYA3yf1RnUljUBWE3WRjLEOBe1BT7WyUr7HPDh
   Q==;
X-CSE-ConnectionGUID: rbuhNjqtQnCaoh0TH//Osg==
X-CSE-MsgGUID: 930XKUCSSMy9Xzm7K1daiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="46495771"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="46495771"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:40:49 -0700
X-CSE-ConnectionGUID: FeSbMuaBR3604CqcOywKTQ==
X-CSE-MsgGUID: bwjuH3p1RhK4++Pn4tvXCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="122970965"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 20 Mar 2025 10:40:48 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvJsp-0000dr-1I;
	Thu, 20 Mar 2025 17:40:44 +0000
Date: Fri, 21 Mar 2025 01:40:31 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-cpu-addr-fixup] BUILD SUCCESS
 757e87a91fabb73910bae44f1a1ada53ad6360a2
Message-ID: <202503210119.eFtCi1v3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-cpu-addr-fixup
branch HEAD: 757e87a91fabb73910bae44f1a1ada53ad6360a2  PCI: imx6: Remove cpu_addr_fixup()

elapsed time: 1444m

configs tested: 129
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-9.3.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-002-20250320    gcc-8.5.0
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-6.5.0
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-004-20250320    gcc-6.5.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250320    clang-21
arm64                 randconfig-002-20250320    clang-21
arm64                 randconfig-003-20250320    clang-19
arm64                 randconfig-004-20250320    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-002-20250320    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-002-20250320    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250320    gcc-12
i386        buildonly-randconfig-002-20250320    clang-20
i386        buildonly-randconfig-003-20250320    clang-20
i386        buildonly-randconfig-004-20250320    clang-20
i386        buildonly-randconfig-005-20250320    gcc-12
i386        buildonly-randconfig-006-20250320    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-12.4.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250320    gcc-14.2.0
loongarch             randconfig-002-20250320    gcc-12.4.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-6.5.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-9.3.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-10.5.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250320    gcc-13.3.0
parisc                randconfig-002-20250320    gcc-11.5.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    clang-21
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250320    gcc-6.5.0
powerpc               randconfig-002-20250320    clang-21
powerpc               randconfig-003-20250320    clang-21
powerpc64             randconfig-001-20250320    clang-21
powerpc64             randconfig-002-20250320    gcc-8.5.0
powerpc64             randconfig-003-20250320    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-002-20250320    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-8.5.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-002-20250320    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-002-20250320    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-006-20250320    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-002-20250320    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

