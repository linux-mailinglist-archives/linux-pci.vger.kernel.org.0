Return-Path: <linux-pci+bounces-7759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE18CC692
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C6E1F219D4
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875E8143C5B;
	Wed, 22 May 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdic4XsX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4223CB
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404010; cv=none; b=kvjSaqKBJ6feior3mAnKvdm+jYWD1p5RsYVv8GrkfKhXfH4PInCI9aob299FHF1UfbtUjePuLggNZ8s4Ey4n+FssEkCBSijAWp5Ahz7hRb80DGxoInDyRnyZ24eeO0T7OGjkglPCt/Scxv3hmCvM64G+3fx4thQ7KX34aXsh1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404010; c=relaxed/simple;
	bh=KdjbjrB73RIDir+SmTLlsE7lC0D7mt5qqYzxrQvXvnw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=njo3WRUO++1/QkilIIKvZy75RVdS1xrBTjdMvEWgASNrOWQlI10ZCm3ElDvSUEhxk7eunCdx34EhcFyJ42vfnBIGxUo91fL2xDp32c7rAZ3qLRFntFyyD5Z2ogkMQ5Fn1ovhH7iKXolLZDE2E0ryzKxR3gx8DUNRip7fYDZvoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdic4XsX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716404008; x=1747940008;
  h=date:from:to:cc:subject:message-id;
  bh=KdjbjrB73RIDir+SmTLlsE7lC0D7mt5qqYzxrQvXvnw=;
  b=jdic4XsX2vsx7Fa4NN3bBIbtkN7jYIiP8wu1/ZF3BmKqEifJrlHNQ1Ux
   q6Qqi0ee0ZpSSbOMhdguWOwSblObnWYvTDZEUmBCSGyue8WsCjvgkT+EJ
   itvovLH6MXcd0qMrrmNdpJLnSzM3umOdTloglhBwAgBYvD31HP+V+ahb0
   B9Rj3gmNkRlQoyR+ELhRuVvkyevpDuJWkxdoE+q+64Ei3FR20lVPwTWpB
   ipotdDv34yIkkPu18oPqRSitpVQgWMB4bYp+vu+08dTbSTH337jaX4V7s
   /nWEU6bmyXtFNy/hYpAwXR+oZmVlM2DdAfEWlpIxvZ6iusrUfBk87pz1a
   Q==;
X-CSE-ConnectionGUID: Qt/jNr7iRI+I/ufwGjIDZg==
X-CSE-MsgGUID: mxdiwuwmQDOnNnI5vZH44A==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="24091703"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="24091703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 11:53:28 -0700
X-CSE-ConnectionGUID: eUrV5D1yR8edUabiIuujWw==
X-CSE-MsgGUID: hJQPUxMZRZ+a9NO2V3rIWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37774184"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 May 2024 11:53:27 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9r5Y-0001rS-2e;
	Wed, 22 May 2024 18:53:24 +0000
Date: Thu, 23 May 2024 02:53:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:defer/endpoint] BUILD SUCCESS
 ff9c034c89ac340fec1301b5441467cf17684093
Message-ID: <202405230217.hUsBfsBY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git defer/endpoint
branch HEAD: ff9c034c89ac340fec1301b5441467cf17684093  PCI: endpoint: pci-epf-test: Use 'msix_capable' flag directly in pci_epf_test_alloc_space()

elapsed time: 1331m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240522   gcc  
arc                   randconfig-002-20240522   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240522   clang
arm                   randconfig-002-20240522   gcc  
arm                   randconfig-003-20240522   clang
arm                   randconfig-004-20240522   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240522   clang
arm64                 randconfig-002-20240522   clang
arm64                 randconfig-003-20240522   gcc  
arm64                 randconfig-004-20240522   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240522   gcc  
csky                  randconfig-002-20240522   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240522   clang
hexagon               randconfig-002-20240522   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240522   clang
i386         buildonly-randconfig-002-20240522   clang
i386         buildonly-randconfig-003-20240522   gcc  
i386         buildonly-randconfig-004-20240522   clang
i386         buildonly-randconfig-005-20240522   clang
i386         buildonly-randconfig-006-20240522   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240522   clang
i386                  randconfig-002-20240522   clang
i386                  randconfig-003-20240522   clang
i386                  randconfig-004-20240522   clang
i386                  randconfig-005-20240522   clang
i386                  randconfig-006-20240522   clang
i386                  randconfig-011-20240522   clang
i386                  randconfig-012-20240522   gcc  
i386                  randconfig-013-20240522   gcc  
i386                  randconfig-014-20240522   gcc  
i386                  randconfig-015-20240522   gcc  
i386                  randconfig-016-20240522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240522   gcc  
loongarch             randconfig-002-20240522   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240522   gcc  
nios2                 randconfig-002-20240522   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240522   gcc  
parisc                randconfig-002-20240522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240522   gcc  
powerpc               randconfig-002-20240522   gcc  
powerpc               randconfig-003-20240522   clang
powerpc64             randconfig-001-20240522   clang
powerpc64             randconfig-002-20240522   clang
powerpc64             randconfig-003-20240522   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240522   gcc  
riscv                 randconfig-002-20240522   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240522   clang
s390                  randconfig-002-20240522   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240522   gcc  
sh                    randconfig-002-20240522   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240522   gcc  
sparc64               randconfig-002-20240522   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240522   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240522   clang
x86_64       buildonly-randconfig-002-20240522   gcc  
x86_64       buildonly-randconfig-003-20240522   clang
x86_64       buildonly-randconfig-004-20240522   gcc  
x86_64       buildonly-randconfig-005-20240522   clang
x86_64       buildonly-randconfig-006-20240522   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240522   gcc  
x86_64                randconfig-002-20240522   clang
x86_64                randconfig-003-20240522   gcc  
x86_64                randconfig-004-20240522   gcc  
x86_64                randconfig-005-20240522   gcc  
x86_64                randconfig-006-20240522   clang
x86_64                randconfig-011-20240522   gcc  
x86_64                randconfig-012-20240522   clang
x86_64                randconfig-013-20240522   gcc  
x86_64                randconfig-014-20240522   clang
x86_64                randconfig-015-20240522   gcc  
x86_64                randconfig-016-20240522   gcc  
x86_64                randconfig-071-20240522   clang
x86_64                randconfig-072-20240522   clang
x86_64                randconfig-073-20240522   gcc  
x86_64                randconfig-074-20240522   clang
x86_64                randconfig-075-20240522   clang
x86_64                randconfig-076-20240522   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

