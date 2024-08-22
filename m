Return-Path: <linux-pci+bounces-11998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BF695B34A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012B11C22B73
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAEC183CA0;
	Thu, 22 Aug 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQMoJo0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B59166F3D
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324346; cv=none; b=i523Qz+aimRSpeDW5iEoY3tGAdXfRGgzVbZVPbHe6cAwqBpiKddffialcCeDxXn5ciAX/T7Zo1P0fHJBRN4hvqqgOLftl3GjZ3dvK8yzZiAWcF4VmTJZ9oyuY7jcd50l30I+W0P9P61MBgoGA8iF/ZoHAvUC4UwPrAKSv/yYcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324346; c=relaxed/simple;
	bh=X2aDawbwMPIx4BXYK3siJFaIvVYE9aya68VEcb9AzqM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WUinBL5i/NXdkhJiH2se2a0D+qweNdw0nkZvxCYkdKNUeybcSQhrvzZ6QJu1oW5XlRzBscnBSK1xOuyX0NyjhmWMAGfhBTokMtOMvGIb+JqEPXlOpaGRDJNJVWL45TUlnf1b9WmdVny4A8ZxnPeP3e9169wKT7WEwcbVgvtvPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQMoJo0/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724324344; x=1755860344;
  h=date:from:to:cc:subject:message-id;
  bh=X2aDawbwMPIx4BXYK3siJFaIvVYE9aya68VEcb9AzqM=;
  b=FQMoJo0/omLO0CBqFhH+ncOh7TNppUaJvMKx8lSs01Q5k7iqnbh73kpg
   d5EGAHuzdTu6w6rbPxcW0Aj8WkxulPd9NNPLbHG43CcWDtByNbDerzuJ4
   z46ZKU8QKW1cAJjjYSJEVnJCOu9eyFeVGcdovODJzbtm0ywJLJgYpZGv8
   OPxBcf44E18gyIJeJmLDnhJrkDB55qIJFr2/90cmOUoE1k8CRa3nFyGsw
   MFrXKVN60Ja06tlXytVxt6Ncm+4TRbeDJ3Mb3J9LgleI2nZ+wIJUmtBLM
   tmTFGX9x4wa8fEL/3I+0cVYrwJZa6LMyd+CFwagoQAdmbYZvHRNgi1/Sk
   w==;
X-CSE-ConnectionGUID: BDASTvncTeeB5WOn7wmgwg==
X-CSE-MsgGUID: q7nVuCBhRz+MTxSqTWGzAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26481779"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="26481779"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 03:59:04 -0700
X-CSE-ConnectionGUID: svauxlCbRCak9RIZQuNkJw==
X-CSE-MsgGUID: w4jdgRmNTp6X0BJUl4iXag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61258390"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 22 Aug 2024 03:59:02 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh5Wt-000CgO-2z;
	Thu, 22 Aug 2024 10:58:59 +0000
Date: Thu, 22 Aug 2024 18:58:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 dbc3171194403d0d40e4bdeae666f6e76e428b53
Message-ID: <202408221857.yYLurFbz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: dbc3171194403d0d40e4bdeae666f6e76e428b53  x86/PCI: Check pcie_find_root_port() return for NULL

elapsed time: 845m

configs tested: 66
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.3.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240822   gcc-12
i386         buildonly-randconfig-002-20240822   gcc-12
i386         buildonly-randconfig-003-20240822   gcc-12
i386         buildonly-randconfig-004-20240822   gcc-12
i386         buildonly-randconfig-005-20240822   gcc-12
i386         buildonly-randconfig-006-20240822   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240822   gcc-12
i386                  randconfig-002-20240822   gcc-12
i386                  randconfig-003-20240822   gcc-12
i386                  randconfig-004-20240822   gcc-12
i386                  randconfig-005-20240822   gcc-12
i386                  randconfig-006-20240822   gcc-12
i386                  randconfig-011-20240822   gcc-12
i386                  randconfig-012-20240822   gcc-12
i386                  randconfig-013-20240822   gcc-12
i386                  randconfig-014-20240822   gcc-12
i386                  randconfig-015-20240822   gcc-12
i386                  randconfig-016-20240822   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240822   gcc-12
x86_64       buildonly-randconfig-002-20240822   gcc-12
x86_64       buildonly-randconfig-003-20240822   gcc-12
x86_64       buildonly-randconfig-004-20240822   gcc-12
x86_64       buildonly-randconfig-005-20240822   gcc-12
x86_64       buildonly-randconfig-006-20240822   gcc-12
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240822   gcc-12
x86_64                randconfig-002-20240822   gcc-12
x86_64                randconfig-003-20240822   gcc-12
x86_64                randconfig-004-20240822   gcc-12
x86_64                randconfig-005-20240822   gcc-12
x86_64                randconfig-006-20240822   gcc-12
x86_64                randconfig-011-20240822   gcc-12
x86_64                randconfig-012-20240822   gcc-12
x86_64                randconfig-013-20240822   gcc-12
x86_64                randconfig-014-20240822   gcc-12
x86_64                randconfig-015-20240822   gcc-12
x86_64                randconfig-016-20240822   gcc-12
x86_64                randconfig-071-20240822   gcc-12
x86_64                randconfig-072-20240822   gcc-12
x86_64                randconfig-073-20240822   gcc-12
x86_64                randconfig-074-20240822   gcc-12
x86_64                randconfig-075-20240822   gcc-12
x86_64                randconfig-076-20240822   gcc-12
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

