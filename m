Return-Path: <linux-pci+bounces-30844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F284AEA95F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D028643E97
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F6B20C024;
	Thu, 26 Jun 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APsZaKhd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598723B634
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975855; cv=none; b=rIHn5gaVVnq83sd4RvwQ3ocVoj2pKZAQK8twOYJcUWsITIY1aftiYNV50ilrb1OFUmvBUglDv62ClvXk5MdqoV86SsBPJ9ksBHiocSA21xfj/lZWmFXj+CTNfruNWDosh2rAXP6dglfbwTLmdIfZ4BcVDjjuamEY413JNXbBNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975855; c=relaxed/simple;
	bh=qdIhInJM6cxia+iEC5e84PyTmDJvCV3bBvmRe6VVA84=;
	h=Date:From:To:Cc:Subject:Message-ID; b=biJVLAA2bxzCTCSnQKgSGDxUem6cCth9Z4+iWC9oWLpQdxcgguKEZS3UxZsJEvMKhq4jUmwas9qDtRTO2I+MbdVi09cS1zWrcFBRYkD8rvrktrOeytkEuNuGT9KbIfv5p/pPOTxn4fCl+ix+6DpkXdBWrcLo4K9HHAQcmNophEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APsZaKhd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750975853; x=1782511853;
  h=date:from:to:cc:subject:message-id;
  bh=qdIhInJM6cxia+iEC5e84PyTmDJvCV3bBvmRe6VVA84=;
  b=APsZaKhdEEMKbd8q5e+/TXv6cAxCet6T+pRg5MFVadSbNx06hRKHU3Wz
   6WUdZSWl+FMyWxypIjErgGPauf8J9/0raIFjkUwhWxZh2t5gx4t0GdvNd
   +jWWGZ7Na0werVJLdZlMwnDmVBc0woGQY4LLCkgfoCThfFVZB+odowUNF
   7S3718LS4xtSDQofJ5oHeCf/bTqPs055UW+9Oz7INikI5Ye+xYd/aaGxy
   Tv5TbgjlSugDdD91wpLgzZTGVk1X2Yw51FzkK/4UhMgmbqba3X8mSX6Ta
   yEZIZ5KmiNwXNHRuX6CnhtuiXdGhDpdxQzN5ztP2K7VT4j/8ObYsiDwji
   A==;
X-CSE-ConnectionGUID: micOjLj+Tz+HxMTpWdDm8Q==
X-CSE-MsgGUID: PKT1Uf/6R0iqd89JRK159Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="55908789"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="55908789"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 15:10:53 -0700
X-CSE-ConnectionGUID: iXeAie4XRnKTDW3//UkzGQ==
X-CSE-MsgGUID: 9HBIV4uTR8SW/gejfDHkJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="183672434"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Jun 2025 15:10:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUunx-000VZi-17;
	Thu, 26 Jun 2025 22:10:49 +0000
Date: Fri, 27 Jun 2025 06:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-stm32] BUILD REGRESSION
 5a972a01e24b278f7302a834c6eaee5bdac12843
Message-ID: <202506270620.sf6EApJY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-stm32
branch HEAD: 5a972a01e24b278f7302a834c6eaee5bdac12843  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com

    drivers/pci/controller/dwc/pcie-stm32.c:96:23: error: incomplete definition of type 'struct dev_pin_info'
    drivers/pci/controller/dwc/pcie-stm32.c:96:30: error: invalid use of undefined type 'struct dev_pin_info'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-stm32.c:error:invalid-use-of-undefined-type-struct-dev_pin_info
`-- um-allmodconfig
    `-- drivers-pci-controller-dwc-pcie-stm32.c:error:incomplete-definition-of-type-struct-dev_pin_info

elapsed time: 1952m

configs tested: 124
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250626    clang-20
arc                   randconfig-001-20250626    gcc-12.4.0
arc                   randconfig-002-20250626    clang-20
arc                   randconfig-002-20250626    gcc-13.3.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250626    clang-20
arm                   randconfig-001-20250626    clang-21
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250626    clang-20
arm                   randconfig-003-20250626    gcc-10.5.0
arm                   randconfig-004-20250626    clang-20
arm                   randconfig-004-20250626    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250626    clang-20
arm64                 randconfig-001-20250626    clang-21
arm64                 randconfig-002-20250626    clang-17
arm64                 randconfig-002-20250626    clang-20
arm64                 randconfig-003-20250626    clang-20
arm64                 randconfig-003-20250626    gcc-8.5.0
arm64                 randconfig-004-20250626    clang-20
arm64                 randconfig-004-20250626    clang-21
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250626    clang-20
i386        buildonly-randconfig-001-20250627    gcc-12
i386        buildonly-randconfig-002-20250626    clang-20
i386        buildonly-randconfig-002-20250627    gcc-12
i386        buildonly-randconfig-003-20250626    clang-20
i386        buildonly-randconfig-003-20250627    gcc-12
i386        buildonly-randconfig-004-20250626    clang-20
i386        buildonly-randconfig-004-20250627    gcc-12
i386        buildonly-randconfig-005-20250626    clang-20
i386        buildonly-randconfig-005-20250627    gcc-12
i386        buildonly-randconfig-006-20250626    clang-20
i386        buildonly-randconfig-006-20250627    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-001-20250627    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-002-20250627    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-003-20250627    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-004-20250627    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-005-20250627    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64      buildonly-randconfig-006-20250627    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

