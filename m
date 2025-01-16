Return-Path: <linux-pci+bounces-20012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3176A14267
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 20:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CECD3A1F9A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F2231C9A;
	Thu, 16 Jan 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja1Drlfs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952222F387
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056332; cv=none; b=NG5sgo/eQ5qMpV9ldJOGLL//HpBInGOQP0h+uWcIuPg4f0ip5L3xfVNTyket8jxyM4yNVr8sBQNHd0acNegRl5GpLsoeu06cpWCh/oWp9ySRezlVS+u0I0I9OEeltg2Mkz7KH0cTQpLZfq8Cme4nm9/D6mvQy5VgYgmnbzN5Ec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056332; c=relaxed/simple;
	bh=0sR3uY/NIMxBn9XyZrzzakN9DDV1qBDwJKumSdhvOQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HbHHLuht3IgNi0Inxc8kMAV3eOQnjedqeAuTjCvqEj6i6ndYHbIC5n514/G2uSnizh6v6+sz0bf5SDZWrhW2njzgW21jAM5qx3VCooxx8wevf9XyqqnUrHGOyiV53eH5A7kR6NZYWHuqREJm5dwG9LpTzBBv8ifNlAzY4SMrzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja1Drlfs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737056331; x=1768592331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0sR3uY/NIMxBn9XyZrzzakN9DDV1qBDwJKumSdhvOQY=;
  b=ja1Drlfs+oKQqoCxQy5JbQMsqEKmebodCV+anCv7tye7SbjaPczZPWot
   YmA3rqJmxNvMYUksF7rtjYj8EmE6egXvKsXf3vTLZscq26lSVfdQqGnMw
   9drSbh1RfPYi7WnoOQoIBCUAuxb8yCILTMnqRPbXTMW2S+d4aG8g039nK
   6SJvJUYbV4Z+a81s5j2GdbqciZiGZFxCRb+E9xYLYMvfcCf/2u4828rPF
   lrOlqMSbkXH6AV70dONGKnMlXrhouJud4vh6zkU8bmxckCjhLHlvBbHJv
   UbIlAbi1fuO50lZM6oq930s3+umxo+kudF+LrOePhWgO8r8XPSZ56ejrq
   Q==;
X-CSE-ConnectionGUID: EE/hXtzASbONCHchyzDmcQ==
X-CSE-MsgGUID: rmiVgsiXR5ioIGxd68E5DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41145622"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="41145622"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 11:38:51 -0800
X-CSE-ConnectionGUID: mH8a8SeiRYuMa7Ffho3LwQ==
X-CSE-MsgGUID: VrV38XC7SEOQHoW4rtFrcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105552019"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jan 2025 11:38:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYVhX-000SKM-1F;
	Thu, 16 Jan 2025 19:38:47 +0000
Date: Fri, 17 Jan 2025 03:38:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 7ca288760007cab6588dc17f5b6fecf52c83a945
Message-ID: <202501170333.KdD1Ui3u-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 7ca288760007cab6588dc17f5b6fecf52c83a945  PCI: rockchip-ep: Fix error code in rockchip_pcie_ep_init_ob_mem()

elapsed time: 1453m

configs tested: 59
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250116    gcc-13.2.0
arc                  randconfig-002-20250116    gcc-13.2.0
arm                  randconfig-001-20250116    gcc-14.2.0
arm                  randconfig-002-20250116    clang-15
arm                  randconfig-003-20250116    gcc-14.2.0
arm                  randconfig-004-20250116    gcc-14.2.0
arm64                randconfig-001-20250116    gcc-14.2.0
arm64                randconfig-002-20250116    gcc-14.2.0
arm64                randconfig-003-20250116    clang-15
arm64                randconfig-004-20250116    clang-20
csky                 randconfig-001-20250116    gcc-14.2.0
csky                 randconfig-002-20250116    gcc-14.2.0
hexagon              randconfig-001-20250116    clang-20
hexagon              randconfig-002-20250116    clang-20
i386       buildonly-randconfig-001-20250116    clang-19
i386       buildonly-randconfig-002-20250116    clang-19
i386       buildonly-randconfig-003-20250116    clang-19
i386       buildonly-randconfig-004-20250116    clang-19
i386       buildonly-randconfig-005-20250116    clang-19
i386       buildonly-randconfig-006-20250116    clang-19
loongarch            randconfig-001-20250116    gcc-14.2.0
loongarch            randconfig-002-20250116    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250116    gcc-14.2.0
nios2                randconfig-002-20250116    gcc-14.2.0
parisc               randconfig-001-20250116    gcc-14.2.0
parisc               randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-001-20250116    clang-20
powerpc              randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-003-20250116    clang-20
powerpc64            randconfig-001-20250116    clang-19
powerpc64            randconfig-002-20250116    clang-20
powerpc64            randconfig-003-20250116    clang-15
riscv                randconfig-001-20250116    gcc-14.2.0
riscv                randconfig-002-20250116    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250116    gcc-14.2.0
s390                 randconfig-002-20250116    clang-18
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250116    gcc-14.2.0
sh                   randconfig-002-20250116    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250116    gcc-14.2.0
sparc                randconfig-002-20250116    gcc-14.2.0
sparc64              randconfig-001-20250116    gcc-14.2.0
sparc64              randconfig-002-20250116    gcc-14.2.0
um                   randconfig-001-20250116    clang-19
um                   randconfig-002-20250116    gcc-12
x86_64     buildonly-randconfig-001-20250116    gcc-12
x86_64     buildonly-randconfig-002-20250116    gcc-12
x86_64     buildonly-randconfig-003-20250116    gcc-12
x86_64     buildonly-randconfig-004-20250116    clang-19
x86_64     buildonly-randconfig-005-20250116    clang-19
x86_64     buildonly-randconfig-006-20250116    clang-19
xtensa               randconfig-001-20250116    gcc-14.2.0
xtensa               randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

