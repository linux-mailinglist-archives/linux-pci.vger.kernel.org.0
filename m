Return-Path: <linux-pci+bounces-22661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446AA4A28B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 20:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03443AAE57
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265DB192580;
	Fri, 28 Feb 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kfp0CF1d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A445277030
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770289; cv=none; b=LxzjUwm6bKsZuedpBRqx1UvqRQMRCHn7zybXIcBN2q2TJPWW4nO6LtaofDtV2aWfJIOQVRQUdoDd+kbuu4yJ8cMQ7czB8vkG8EbFgRNKCcWNWoPQLB1zIuBQRHj+7ZnEAL5PEwQbCUV6Zdt4nTWBvzB6/LT2y/BIKENknTSmKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770289; c=relaxed/simple;
	bh=4YBngPD2vySJi0vz+QpQF6avG/K3oJHoPsyqdR8azp4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UWywZpltlMt7uVnYucPZrl3ot7+iX8wezl67lqEvvz5eBfW/Qwyr4ntwLNF9INdTpo9jB1w47CNv0u2D7nDnU4BwBYgyckpxK19NYjgkFPnAlSDKpuHS+jMOSnx5wJH0fW2WgLGLUzaSGteVsZ7U36mGJXYfCgttnir0ABS+xHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kfp0CF1d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740770287; x=1772306287;
  h=date:from:to:cc:subject:message-id;
  bh=4YBngPD2vySJi0vz+QpQF6avG/K3oJHoPsyqdR8azp4=;
  b=Kfp0CF1d/txBxi51IQ1LaNFcyV0e4q5Wu96IPquvCueJTDKHlFAgZucD
   TXHSSyinHdQ1Z3uRtjDLYEkQTx4C8BSYCKHdZNEID5BcBmpXHhDafDc0P
   Tap4yO+1rmJjg0nYVpqxJiaHYlVLS6zRmXMH2v2+D4yb6MFfeFXPpSCZb
   KJvbCfeoTr/yLs8SeMQNQkOGi8AP/xAou+SAB9uMEp+slhGHnenACVu84
   Jmq2iGD6j0Li4rjK+Zc+YRaq8ARbifKib8cZz8HO1KjJrrElU4kQs8Mcw
   iuwUpmwJf0stzbn9rhrACX3V6bXUvrWi6KpZN58rd7y1crvkLrkDp13Z3
   Q==;
X-CSE-ConnectionGUID: TyJq5/4XRpGhAGPTD/YNiA==
X-CSE-MsgGUID: 691RwvaMRYWI8Hgk5Ek9yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52353268"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="52353268"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 11:18:06 -0800
X-CSE-ConnectionGUID: j8ziJN7HQWKXFr03ebHlQA==
X-CSE-MsgGUID: x1K97OSdQpa/9N4G7pUiCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148327773"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 11:18:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to5s3-000FOc-1w;
	Fri, 28 Feb 2025 19:18:03 +0000
Date: Sat, 01 Mar 2025 03:17:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devtree-create] BUILD SUCCESS
 8306ae4beff45d379f6635d0951b7de323cbb5e0
Message-ID: <202503010342.e7Zym1gi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devtree-create
branch HEAD: 8306ae4beff45d379f6635d0951b7de323cbb5e0  PCI: of: Create device-tree PCI host bridge node

elapsed time: 1474m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250228    gcc-13.2.0
arc                  randconfig-002-20250228    gcc-13.2.0
arm                  randconfig-001-20250228    clang-21
arm                  randconfig-002-20250228    gcc-14.2.0
arm                  randconfig-003-20250228    gcc-14.2.0
arm                  randconfig-004-20250228    gcc-14.2.0
arm64                randconfig-001-20250228    gcc-14.2.0
arm64                randconfig-002-20250228    clang-21
arm64                randconfig-003-20250228    clang-16
arm64                randconfig-004-20250228    gcc-14.2.0
csky                 randconfig-001-20250228    gcc-14.2.0
csky                 randconfig-002-20250228    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250228    clang-19
hexagon              randconfig-002-20250228    clang-21
i386       buildonly-randconfig-001-20250228    clang-19
i386       buildonly-randconfig-002-20250228    clang-19
i386       buildonly-randconfig-003-20250228    gcc-12
i386       buildonly-randconfig-004-20250228    clang-19
i386       buildonly-randconfig-005-20250228    clang-19
i386       buildonly-randconfig-006-20250228    clang-19
loongarch            randconfig-001-20250228    gcc-14.2.0
loongarch            randconfig-002-20250228    gcc-14.2.0
nios2                randconfig-001-20250228    gcc-14.2.0
nios2                randconfig-002-20250228    gcc-14.2.0
parisc               randconfig-001-20250228    gcc-14.2.0
parisc               randconfig-002-20250228    gcc-14.2.0
powerpc              randconfig-001-20250228    gcc-14.2.0
powerpc              randconfig-002-20250228    clang-16
powerpc              randconfig-003-20250228    clang-18
powerpc64            randconfig-001-20250228    clang-16
powerpc64            randconfig-002-20250228    clang-18
powerpc64            randconfig-003-20250228    gcc-14.2.0
riscv                randconfig-001-20250228    gcc-14.2.0
riscv                randconfig-002-20250228    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250228    gcc-14.2.0
s390                 randconfig-002-20250228    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250228    gcc-14.2.0
sh                   randconfig-002-20250228    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250228    gcc-14.2.0
sparc                randconfig-002-20250228    gcc-14.2.0
sparc64              randconfig-001-20250228    gcc-14.2.0
sparc64              randconfig-002-20250228    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250228    clang-21
um                   randconfig-002-20250228    clang-21
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250228    gcc-14.2.0
xtensa               randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

