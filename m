Return-Path: <linux-pci+bounces-8497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F2F901444
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 04:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FE71F21E7F
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 02:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE77A3F;
	Sun,  9 Jun 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4Kel+2k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6F5223
	for <linux-pci@vger.kernel.org>; Sun,  9 Jun 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900901; cv=none; b=DyV8rdKfcWfUrdDYfyH6mq2rKIbOZIdgvkDswgyFdDlEBl2uenG55QTq3W11vun9zIGOAht+fDhgXytB4wYLNmihxXyKRlYiGSnbJgNgRcOhgjomt1hTveBXID4NO6+1jtNoxSBfyRjo1vBf6Y/46go+D8ffeol0/iXt9ePz0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900901; c=relaxed/simple;
	bh=dnsnE/cFeBqTZm+7dDNLXjWjN2dN4cXJ2NegCKzGr9M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hluF7yPEDTZ43a1UQH8UneW1KLchudOAlM2IxbzW8h1lFIuAHoQMvooRdPoqCwaOLY2S3ay7zg9ELvGmQ/Gjgeonmi+eAWW9vg+Yg6a85g7Vc6xs7usV59lF3YwyHHs7jfcDWxaE/7HJCifHp4NdXWr9ytYt3mGCBcOI3VQhpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4Kel+2k; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717900899; x=1749436899;
  h=date:from:to:cc:subject:message-id;
  bh=dnsnE/cFeBqTZm+7dDNLXjWjN2dN4cXJ2NegCKzGr9M=;
  b=c4Kel+2kaajfzYy8R/y2r3S328T0JOO0YrDIyrKvo7WGAiI6laWnSZLD
   2BdqUBz6Gqw1lwT4cEKOqXLVcj+Sw69UUlHeaBG0N4TQZdaDfvyzUu0ni
   j+ymS4JVGh0szPkjmC9T0tadSraGz2fO99YzQmaFIFi3tSEi2awdkaLTh
   cxZFQzmrGT6lbi+2ykbth2LdoP5vT6SBfFTIu6BcszvDLItd9A44PbYqE
   Eb5u67+bkrZ9qELth0EJ73db1q8zSLjC9lDzNEdnMyhd0sz3+dSv+VkHK
   o9mQ7PESGCLUrWESAKJ9eNZcr7AgOJs+rBQ81bjZuxRkgXP7qU2qAZ8O+
   g==;
X-CSE-ConnectionGUID: JOA/Zb01RguWeS/X/nPv3A==
X-CSE-MsgGUID: Dkuy9u+vRFyilzAgyartaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="14826400"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="14826400"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 19:41:39 -0700
X-CSE-ConnectionGUID: jYbMG47TRzeBRToqOW9emA==
X-CSE-MsgGUID: D+l6o+m6QuuCbqNBRXGeSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="43650577"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Jun 2024 19:41:38 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sG8Ux-0000ma-1I;
	Sun, 09 Jun 2024 02:41:35 +0000
Date: Sun, 09 Jun 2024 10:40:46 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 e150a8a6fb76fb4aa860abf320691dd4860049a3
Message-ID: <202406091045.GgJou8jd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: e150a8a6fb76fb4aa860abf320691dd4860049a3  Merge branch 'pci/misc'

elapsed time: 2106m

configs tested: 48
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386         buildonly-randconfig-001-20240609   gcc  
i386         buildonly-randconfig-002-20240609   gcc  
i386         buildonly-randconfig-003-20240609   gcc  
i386         buildonly-randconfig-004-20240609   gcc  
i386         buildonly-randconfig-005-20240609   clang
i386         buildonly-randconfig-006-20240609   gcc  
i386                  randconfig-001-20240609   clang
i386                  randconfig-002-20240609   clang
i386                  randconfig-003-20240609   gcc  
i386                  randconfig-004-20240609   gcc  
i386                  randconfig-005-20240609   clang
i386                  randconfig-006-20240609   clang
i386                  randconfig-011-20240609   clang
i386                  randconfig-012-20240609   clang
i386                  randconfig-013-20240609   clang
i386                  randconfig-014-20240609   clang
i386                  randconfig-015-20240609   gcc  
i386                  randconfig-016-20240609   clang
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
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64       buildonly-randconfig-001-20240609   clang
x86_64       buildonly-randconfig-002-20240609   clang
x86_64       buildonly-randconfig-003-20240609   clang
x86_64       buildonly-randconfig-004-20240609   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

