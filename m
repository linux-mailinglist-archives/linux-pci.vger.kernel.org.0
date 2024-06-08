Return-Path: <linux-pci+bounces-8492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED26901372
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 22:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D393AB21083
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447C1C2A3;
	Sat,  8 Jun 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsX1hMDC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B739E57D
	for <linux-pci@vger.kernel.org>; Sat,  8 Jun 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717878444; cv=none; b=QhSo91JryvXR3y2+haeNjKhZnM+CuA2JUZww83GUQgh+DmCB67BjFZO6MaXaQRreS3VC/l15CUO9lMogb0YZYRSadvbiXIRn+68GDb/7j0vrG1+BWlXnD0SLFvrU7wkNVeHepJF8yWwVbHpAAJom4jplHLcJ4d/xSfy4uIzkv90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717878444; c=relaxed/simple;
	bh=/NvTFBrBDsb8L1vAJqMwhhmgR7DSGpumHcVZ1ypJa+E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FukxVIFf2Gc+bLkJRn7HrKNt74YC/4u1SeNdZ46Xey8J3MwxB6MsTBRGIOgLH7na/aI49bKXcwynEwzlYG/MQIAnFoYjGJ9yKNPe9LYkrn1SeTn5Btn/9Te0uEHhltUfzbDGJlklMRCMTxxH2jmozr6Ti8hMnw3n1qzGYE3ieTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsX1hMDC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717878443; x=1749414443;
  h=date:from:to:cc:subject:message-id;
  bh=/NvTFBrBDsb8L1vAJqMwhhmgR7DSGpumHcVZ1ypJa+E=;
  b=GsX1hMDCagl9WjaQFJxRpidWRuJxmA5tVkn+WKJPoSfRI2u74g4xpOft
   18Dq8LwENg7NUvbY/AFFLYEcy+ANvVN7PvytYFOGb1yQf+kdCUO6XO3dr
   /RrTXdxBNvLIdBTnkqqv2DT21INLSD+Hkt8d/Sr4Ze0kCJb41MihHNk1d
   oo/MFcppNxct3jWI9xpZtWPk1/Fi+Wol+qxX7FW8YRff00TLbUN5xRbH2
   eRqw53EcMFMtNMQcR0/egvUre4YRogTwT2Pi6XutcAIL2AUI9k+PSE+IU
   ojL1bF2NiIlmyD1dfYyxMaFnYHplQFNfjAEtjHUkRYIo4Z2eR1VQjnqZA
   Q==;
X-CSE-ConnectionGUID: TC4YTxQ3Q2iw0DmDbjzh3A==
X-CSE-MsgGUID: 3U/G9NOvQ4aRYAOBfyb0hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="18439776"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="18439776"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 13:27:22 -0700
X-CSE-ConnectionGUID: 8gyOS/XUQ4ieppElk1RWLQ==
X-CSE-MsgGUID: CfbyHrPuR2OqBNKVFLhldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="43085722"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jun 2024 13:27:22 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sG2el-0000Qk-2L;
	Sat, 08 Jun 2024 20:27:19 +0000
Date: Sun, 09 Jun 2024 04:26:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 7d2ebbc33d9f65a492d8a41fd33036e411366341
Message-ID: <202406090454.uyOPadR8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 7d2ebbc33d9f65a492d8a41fd33036e411366341  PCI: Use array for .id_table consistently

elapsed time: 1454m

configs tested: 20
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

