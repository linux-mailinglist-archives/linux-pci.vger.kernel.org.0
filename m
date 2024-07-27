Return-Path: <linux-pci+bounces-10872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3360293DE2A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5680B1C208B5
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA148CCC;
	Sat, 27 Jul 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Txiqlw/n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A71FB5
	for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072387; cv=none; b=R3I9IIQYlu3LKFJPY1FnMGaB0LQxNYA+dY3OklOffSEXR6VGWNRDGGNVcZZW2ThX1wrxO1Kr1G1aReg0KP3Q+vWMmORXLbdRrvAuoCiBVfjzjlbwC0pXKqq7s61guPV7wBaYguhhulYgMOTVx/v6Q06QByKMhxISoMUAqYNxxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072387; c=relaxed/simple;
	bh=SnWgJRg8oZNnFPg1YJaymgiznpM13K/rmkeC0LQsiK0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kV/G/yGAPEhnU7M0gBck++G+FI7klF+dG7h39hkmhaQ17c66vVILSYuDn9ehngLRJrGbFwo9CE5cfwmCgHDLGFqQJHGD9x0P+gpej4XJMjzocVZ+j+qtFZ/xi3g51N8SDSk4aBE1dxr7lcIqz3V25nl8CoToqigwYqjCeWYvlzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Txiqlw/n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722072385; x=1753608385;
  h=date:from:to:cc:subject:message-id;
  bh=SnWgJRg8oZNnFPg1YJaymgiznpM13K/rmkeC0LQsiK0=;
  b=Txiqlw/ndz0YhU5RVWdp8L2tha0XZEszfOBVb0XhTotIAlccI6WzxDJn
   MQJAPT3c8L259SftdW4emSdMHUhsETBgGTYbD6hlWsvsSo+o6VC9F880w
   CucfwCU8iVQSstZurKBReDPz+5ZudQLQ+kdIWx6bvLXkOxZiwcmzF1CrE
   ma3iUVpihvGJqnHi6wO+6A5wSllZ9DpoBYWk/MjcyOAZDuPYALE1C/fGo
   jl23i3C+pQRDevt6CuRzB3bUcQja7AVMtyNpru9CQH1AS51W1mqPb+XtB
   QPDKdp5YBT8m/nag5Chk/gXAx4N6fo6r9t42ExeGM/dAf2hdEECS+wg8s
   w==;
X-CSE-ConnectionGUID: YiVqUi9DTDybo7Q+FZFKUg==
X-CSE-MsgGUID: 5ma3uXUjSZKYSfebRU55QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="30458428"
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="30458428"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 02:26:24 -0700
X-CSE-ConnectionGUID: 0mBnwpY7RK+xEtjYtmAytA==
X-CSE-MsgGUID: 6fBQxZWBSr6/gpsopMfyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="58272794"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Jul 2024 02:26:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXdgy-000pob-05;
	Sat, 27 Jul 2024 09:26:20 +0000
Date: Sat, 27 Jul 2024 17:25:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/affinity] BUILD SUCCESS
 4dd7974cc1683211ccc3932b1f1c265220345e91
Message-ID: <202407271736.SxrfXJcl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/affinity
branch HEAD: 4dd7974cc1683211ccc3932b1f1c265220345e91  PCI: xilinx: Silence 'set affinity failed' warning

elapsed time: 826m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240727   gcc-13.2.0
arc                   randconfig-002-20240727   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240727   gcc-14.1.0
arm                   randconfig-002-20240727   gcc-14.1.0
arm                   randconfig-003-20240727   clang-17
arm                   randconfig-004-20240727   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240727   clang-20
arm64                 randconfig-002-20240727   gcc-14.1.0
arm64                 randconfig-003-20240727   gcc-14.1.0
arm64                 randconfig-004-20240727   clang-20
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240727   gcc-14.1.0
csky                  randconfig-002-20240727   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240727   clang-20
hexagon               randconfig-002-20240727   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240727   clang-18
i386         buildonly-randconfig-002-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-8
i386         buildonly-randconfig-004-20240727   gcc-10
i386         buildonly-randconfig-004-20240727   gcc-13
i386         buildonly-randconfig-005-20240727   clang-18
i386         buildonly-randconfig-005-20240727   gcc-13
i386         buildonly-randconfig-006-20240727   clang-18
i386         buildonly-randconfig-006-20240727   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240727   clang-18
i386                  randconfig-001-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-8
i386                  randconfig-003-20240727   clang-18
i386                  randconfig-003-20240727   gcc-13
i386                  randconfig-004-20240727   clang-18
i386                  randconfig-004-20240727   gcc-13
i386                  randconfig-005-20240727   clang-18
i386                  randconfig-005-20240727   gcc-13
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240727   gcc-11
i386                  randconfig-013-20240727   gcc-13
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240727   clang-18
i386                  randconfig-015-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-7
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240727   gcc-14.1.0
loongarch             randconfig-002-20240727   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240727   gcc-14.1.0
nios2                 randconfig-002-20240727   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240727   gcc-8
x86_64       buildonly-randconfig-002-20240727   gcc-13
x86_64       buildonly-randconfig-003-20240727   gcc-13
x86_64       buildonly-randconfig-004-20240727   gcc-13
x86_64       buildonly-randconfig-005-20240727   clang-18
x86_64       buildonly-randconfig-006-20240727   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240727   gcc-13
x86_64                randconfig-002-20240727   clang-18
x86_64                randconfig-003-20240727   clang-18
x86_64                randconfig-004-20240727   clang-18
x86_64                randconfig-005-20240727   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

