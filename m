Return-Path: <linux-pci+bounces-125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F07F3E92
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 08:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B262B20D2D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1580179B0;
	Wed, 22 Nov 2023 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdMAmDls"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8048490
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 23:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700636678; x=1732172678;
  h=date:from:to:cc:subject:message-id;
  bh=rjnU/GVDyPl+/lz0+hOS1gGHPnuBujhbccIfwZ+i3M4=;
  b=AdMAmDlso6KsIDbBqaXqVdENC8843gB1lMR2vLnUjwsfq/LGXHcYEQFT
   46Tfk/s3eK5naTu39Nm9yf/uCkSvQtEwLC3IEQXM0K/goteFg1P1e/Z19
   1tdFWXcZ2772lrYbF+b17uGQ6zHePbqP1EHLvpnixEiU3vkCbUMxK3/D6
   DXhRGPY395LvY0FnvQ5DOgEAZznfwniiJ5rYTcr9839Txo88swOG9hc4h
   uEwtwn157H4LE4qF8O5el6s03JnSSPyHOLUC/P2tloPyDxp3tcE/Y5nzT
   7sEPNJvjc8UOV+KbLd5ijm6jjYJlAOom0bZvqMIxB3dPtKO5xlN90zxwl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="371348013"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="371348013"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 23:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795995266"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="795995266"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2023 23:04:36 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5hHm-0000AZ-1q;
	Wed, 22 Nov 2023 07:04:34 +0000
Date: Wed, 22 Nov 2023 15:03:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:ecam] BUILD SUCCESS
 4de5ec48a79e3b0fca893d10138da6051042d796
Message-ID: <202311221551.GuYwNNRc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ecam
branch HEAD: 4de5ec48a79e3b0fca893d10138da6051042d796  x86/pci: Reorder pci_mmcfg_arch_map() definition before calls

elapsed time: 728m

configs tested: 39
configs skipped: 137

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                            allyesconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231122   gcc  
i386                  randconfig-012-20231122   gcc  
i386                  randconfig-013-20231122   gcc  
i386                  randconfig-014-20231122   gcc  
i386                  randconfig-015-20231122   gcc  
i386                  randconfig-016-20231122   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231122   clang
x86_64       buildonly-randconfig-002-20231122   clang
x86_64       buildonly-randconfig-003-20231122   clang
x86_64       buildonly-randconfig-004-20231122   clang
x86_64       buildonly-randconfig-005-20231122   clang
x86_64       buildonly-randconfig-006-20231122   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-011-20231122   clang
x86_64                randconfig-012-20231122   clang
x86_64                randconfig-013-20231122   clang
x86_64                randconfig-014-20231122   clang
x86_64                randconfig-015-20231122   clang
x86_64                randconfig-016-20231122   clang
x86_64                randconfig-071-20231122   clang
x86_64                randconfig-072-20231122   clang
x86_64                randconfig-073-20231122   clang
x86_64                randconfig-074-20231122   clang
x86_64                randconfig-075-20231122   clang
x86_64                randconfig-076-20231122   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

