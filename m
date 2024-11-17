Return-Path: <linux-pci+bounces-17009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B39D0713
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 00:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD19B2190F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E083AC2B;
	Sun, 17 Nov 2024 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qm1374kd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA022309A7
	for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2024 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731887254; cv=none; b=OcVG9um/WM2Temdd6vcfNoLT0KIoHQMeZUF7pENw/QRat1h+BWCAiJpORFhhSFVFgHXke/j80yRtuGZdthR9/BdP2zFRxBoDzBkK8ix8uCQhcSMQGrdKgojcESGJhKptT2hT1GQWvnzrMt1epWO4HyRwQuucdMc36HGMO7LaPIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731887254; c=relaxed/simple;
	bh=03eqD9+vuYfHgdckPUvdDoMMYbVKgPoFP3UBeAWf6Ec=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MhOTHDGTEZSeWBCHuTP9WnPydwywgoT5yQRu1IfGyTnEjjrvmpyA4IevNutLkKpEDhdFoACf6GHN/55Ac8F4Hdju+1BjESUUgH+VAj/WJvcTkGHuyYcnHXpjNgnMqwBwAgZdvakBMSICf/I2r9OeC4SPWG/fLax0i5f5T8WdEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qm1374kd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731887253; x=1763423253;
  h=date:from:to:cc:subject:message-id;
  bh=03eqD9+vuYfHgdckPUvdDoMMYbVKgPoFP3UBeAWf6Ec=;
  b=Qm1374kdIWlxQPzfronlIib6QvQ7Uqv6b0aIE8er8dakQ15DXK1rbLkV
   F7r2UiYFhQQ6W2CwcqB9Lwa2tGsQNK37F1g+SAL4HMIMN/F52cwHsoAcK
   KzvxbvHKuhDlqfuRnvxzD3puwgcO4dDwmsXZx6lBAsUiXXwgw6RgN0POz
   Wdh+U9UP2aAdWrqdkpQCOP1Qlzl8FKa7RR/tsoqSKtGz6g1bqNK6433+n
   MhJ/Q6GvW37A2kNP+yioU+q2IHvEXf3aV/XFBKQxoAfUOSnOh61CCG5yI
   COdS6Iv0k3m91k4Vm0lRRkfnG6zreRNRU5Q04fStnl6Y3vtNRIvppvxzO
   Q==;
X-CSE-ConnectionGUID: egLqZ1avQ/uMJ4ct7AQ8WQ==
X-CSE-MsgGUID: bpt03OxVRj+i5VshRHgu9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31747017"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="31747017"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 15:47:32 -0800
X-CSE-ConnectionGUID: cgt08xfpQ1aaYo/0r50RQg==
X-CSE-MsgGUID: HeqWt/8BS6+9RSDR4owNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="89178927"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Nov 2024 15:47:31 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCozI-00027n-2P;
	Sun, 17 Nov 2024 23:47:28 +0000
Date: Mon, 18 Nov 2024 07:46:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctl] BUILD SUCCESS
 e826ea4c7f26fac8198e6a7cfaa38b39f3296c9a
Message-ID: <202411180738.s4p5JvfB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctl
branch HEAD: e826ea4c7f26fac8198e6a7cfaa38b39f3296c9a  PCI/pwrctrl: Rename pwrctrl functions and structures

elapsed time: 1923m

configs tested: 102
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20241118    gcc-13.2.0
arc                   randconfig-002-20241118    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-16
arm                   randconfig-001-20241118    gcc-14.2.0
arm                   randconfig-002-20241118    gcc-14.2.0
arm                   randconfig-003-20241118    gcc-14.2.0
arm                   randconfig-004-20241118    clang-20
arm                           tegra_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241118    clang-14
arm64                 randconfig-002-20241118    gcc-14.2.0
arm64                 randconfig-003-20241118    gcc-14.2.0
arm64                 randconfig-004-20241118    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241118    gcc-14.2.0
csky                  randconfig-002-20241118    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241118    clang-20
hexagon               randconfig-002-20241118    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-003-20241118    clang-19
i386        buildonly-randconfig-004-20241118    clang-19
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-006-20241118    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-003-20241118    gcc-12
i386                  randconfig-004-20241118    clang-19
i386                  randconfig-005-20241118    gcc-12
i386                  randconfig-006-20241118    gcc-12
i386                  randconfig-011-20241118    clang-19
i386                  randconfig-012-20241118    gcc-12
i386                  randconfig-013-20241118    gcc-12
i386                  randconfig-014-20241118    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241118    gcc-14.2.0
loongarch             randconfig-002-20241118    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241118    gcc-14.2.0
nios2                 randconfig-002-20241118    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20241118    gcc-14.2.0
parisc                randconfig-002-20241118    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc               randconfig-002-20241118    gcc-14.2.0
powerpc               randconfig-003-20241118    gcc-14.2.0
powerpc64             randconfig-001-20241118    clang-14
powerpc64             randconfig-002-20241118    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241118    clang-14
riscv                 randconfig-002-20241118    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                                defconfig    clang-20
s390                  randconfig-001-20241118    gcc-14.2.0
s390                  randconfig-002-20241118    clang-20
sh                                allnoconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241118    gcc-14.2.0
sh                    randconfig-002-20241118    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241118    gcc-14.2.0
sparc64               randconfig-002-20241118    gcc-14.2.0
um                                allnoconfig    clang-17
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241118    clang-16
um                    randconfig-002-20241118    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241118    clang-19
x86_64      buildonly-randconfig-002-20241118    clang-19
x86_64      buildonly-randconfig-003-20241118    gcc-12
x86_64      buildonly-randconfig-004-20241118    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241118    gcc-14.2.0
xtensa                randconfig-002-20241118    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

