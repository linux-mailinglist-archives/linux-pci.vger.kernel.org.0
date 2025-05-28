Return-Path: <linux-pci+bounces-28512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F928AC6E6E
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 18:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BBD7ACF5F
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91828D8C6;
	Wed, 28 May 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOH9/yWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8F28CF5D
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451212; cv=none; b=J6vdi+4/8/XDhJ+TiJq7UwnckBC4Phc4j/pwLyDrmNgiaICkmP/OddKHvvLye3j7lWj0WykOxgkhrvP08/eqd5CrpTZW1t3dfXAxVeL7MRGBswSDVLjw8rqw3HJ426vC1qHTiRxs9qskciQeCiQ+Nrzog0ABr/uGgOAT50Gmj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451212; c=relaxed/simple;
	bh=XAun80Fn8vtg/Yjs5qtgwxA62FKTT2PXOc6pVCSfH44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Rzir/lNzsGhI1fpjY2j5rF3vTUD1MT3kGtV9yqA/fx+yAH8jAGCQbNM+i4n5zVISPLqWQ7HIPveY/UXqGlVU0nj9f/yEm/gXd34gL/ZXH6OzPoHCJiwsPnzPKjL1yFtQAWBPRRiJPDjgtMA9ZBO+NBxj9KzZGD8jYjDF2iBeSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOH9/yWi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748451211; x=1779987211;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XAun80Fn8vtg/Yjs5qtgwxA62FKTT2PXOc6pVCSfH44=;
  b=YOH9/yWi7KwsVew8zoQ9XkO4DY4ssHzeIIN+S58lEFzyvIM0BQrz0xU5
   EPpelHUJ4T9KptxepYkaFKIZrrme3FDhHX5IEzGmjQQFW8lb+gce5apGj
   vWgi8j3wNKCwwpRLQI8ji1G0Za3x1ulKICzGAGl9rtSdyXkDL8SgMr9I8
   rwWz4ZuilOsuGASLV/UPylZW1oGtrJ6xgIVrKH0g+QSnpP5GTEHLQQVvY
   dL9a5KgGJIAIv6OR553ANezFQdnMA/FNDLP6TAi9PhVwY6pjtYFQHyUXL
   s+MWerf0yUXciHp4no2Q5udkVs0jbLuQTzjS+HlB/7vpD2cfjlOgZp7Sq
   w==;
X-CSE-ConnectionGUID: bHU4fIA0QI6Mo/VtIZOmuw==
X-CSE-MsgGUID: y+IUHLnNT2OZ0ou2/G8Y+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61147610"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="61147610"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 09:53:30 -0700
X-CSE-ConnectionGUID: cbeFKx+xTsGcweBNXye3cw==
X-CSE-MsgGUID: GEEHQ3MOQ9CPB/HoVdQvNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="174178662"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 May 2025 09:53:29 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKK1u-000VuL-2L;
	Wed, 28 May 2025 16:53:26 +0000
Date: Thu, 29 May 2025 00:53:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 a0dfd2cbadc27aa698d525e4cfcfa36ea7c46da6
Message-ID: <202505290056.J45mLl9s-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git mi=
sc
branch HEAD: a0dfd2cbadc27aa698d525e4cfcfa36ea7c46da6  MAINTAINERS: Update =
Krzysztof Wilczy=C5=84ski email address

elapsed time: 1118m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.3.0
arc                   randconfig-001-20250528    gcc-15.1.0
arc                   randconfig-002-20250528    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-21
arm                           omap1_defconfig    gcc-14.3.0
arm                   randconfig-001-20250528    clang-21
arm                   randconfig-002-20250528    clang-17
arm                   randconfig-003-20250528    clang-19
arm                   randconfig-004-20250528    clang-21
arm                           sama5_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250528    gcc-9.5.0
arm64                 randconfig-002-20250528    gcc-7.5.0
arm64                 randconfig-003-20250528    gcc-7.5.0
arm64                 randconfig-004-20250528    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250528    gcc-15.1.0
csky                  randconfig-002-20250528    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250528    clang-21
hexagon               randconfig-002-20250528    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250528    gcc-12
i386        buildonly-randconfig-002-20250528    clang-20
i386        buildonly-randconfig-003-20250528    clang-20
i386        buildonly-randconfig-004-20250528    clang-20
i386        buildonly-randconfig-005-20250528    gcc-12
i386        buildonly-randconfig-006-20250528    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250528    gcc-15.1.0
loongarch             randconfig-002-20250528    gcc-13.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250528    gcc-13.3.0
nios2                 randconfig-002-20250528    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.3.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.3.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250528    gcc-6.5.0
parisc                randconfig-002-20250528    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.3.0
powerpc               randconfig-001-20250528    clang-21
powerpc               randconfig-002-20250528    gcc-7.5.0
powerpc               randconfig-003-20250528    gcc-7.5.0
powerpc                    socrates_defconfig    gcc-14.3.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250528    gcc-7.5.0
powerpc64             randconfig-002-20250528    clang-21
powerpc64             randconfig-003-20250528    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250528    gcc-9.3.0
riscv                 randconfig-002-20250528    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250528    clang-21
s390                  randconfig-002-20250528    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.3.0
sh                            hp6xx_defconfig    gcc-14.3.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250528    gcc-9.3.0
sh                    randconfig-002-20250528    gcc-5.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250528    gcc-14.2.0
sparc                 randconfig-002-20250528    gcc-14.2.0
sparc64                             defconfig    gcc-14.3.0
sparc64               randconfig-001-20250528    gcc-8.5.0
sparc64               randconfig-002-20250528    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250528    clang-21
um                    randconfig-002-20250528    gcc-11
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250528    clang-20
x86_64      buildonly-randconfig-002-20250528    clang-20
x86_64      buildonly-randconfig-003-20250528    gcc-12
x86_64      buildonly-randconfig-004-20250528    gcc-12
x86_64      buildonly-randconfig-005-20250528    gcc-12
x86_64      buildonly-randconfig-006-20250528    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250528    gcc-14.2.0
xtensa                randconfig-002-20250528    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

