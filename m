Return-Path: <linux-pci+bounces-9491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6F91D4C5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 01:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1671F21094
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 23:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF254CB23;
	Sun, 30 Jun 2024 23:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4pjAvkA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFB77F1B
	for <linux-pci@vger.kernel.org>; Sun, 30 Jun 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719790135; cv=none; b=QEookEXpxUTM5kF5XZ1FAaoGGuMRlRf0ZkVV8V77CAOrq/oHpKqtFmhuwaafsjz4/D16O07KWCcwTGBLPwPMigGXEnl3Ghb+neFZEMvnnBmifONz6sLck5v5x5ZSZfhkXYl/k4CAyrgxN1DvFaA9oBIjoNnyZpdy8SKsZ0msvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719790135; c=relaxed/simple;
	bh=8rPH243rvqFMmIcrQUQQXO+xZ5y4YEP1C+WExsP1F3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WgrHvffe+fFjsGprBECR+8JmpOHvIFMI/wozyBfEPjNnyKy4cld1DujB0cIPVv0BnUz7xPcPvkB8X3+3whGjFkJL8rGUL05qATYR7qJHd8XUAYXd8bMBBVBUtVkbbFtWy8p87DzEgtlU7ClcHyy6ppumjQxJN09DbBhkUEg/Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4pjAvkA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719790134; x=1751326134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8rPH243rvqFMmIcrQUQQXO+xZ5y4YEP1C+WExsP1F3M=;
  b=D4pjAvkAnN5AUha00G87SMuiW0hMxCU1uk0oxN18BSNAA7CzdiWpd4hg
   Z8SyAqcc9M2ZG34lDQYAgLeLxvTtKkY7GYN1kk9xyIo2yPodyEO/v8P+I
   wqyy1ulMTsDPKGYQdJQOi1fwxeSY0G+KohDXAFvZAHSLAK61bwrzWQS59
   2+3Fpg4BOz9r529f4UJzPTnYM0gTALSEBuG/QvCbajpA6xrGu90ZhvY/t
   YyPUPp4N8Tf25wJEla8kXkayUuJ30i+XN24D/FoLExSH+zIsz7onqpgge
   bCXwZ5Gsu/GtLQtXaMTtQIhEXV5hWa9b1XjWiIUUdYSAr2emSKIFIz2Wg
   w==;
X-CSE-ConnectionGUID: GvfOznpPRUaARIWAgNP8FQ==
X-CSE-MsgGUID: OkS1J+ZZQA+ZQdgEbI+NTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="34434267"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="34434267"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 16:28:53 -0700
X-CSE-ConnectionGUID: gIIVnCXZQYSpAFYwfVeeEA==
X-CSE-MsgGUID: At3QLEJWQ8KstSImkiQQcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45398784"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jun 2024 16:28:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sO3yT-000MB2-36;
	Sun, 30 Jun 2024 23:28:49 +0000
Date: Mon, 01 Jul 2024 07:28:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 1947ff399bb78278a4d91ea2cf32eedcf109b831
Message-ID: <202407010759.wyoS2Z1R-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 1947ff399bb78278a4d91ea2cf32eedcf109b831  misc: pci_endpoint_test: Document a policy about adding pci_device_id

elapsed time: 1620m

configs tested: 77
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240701   gcc-13.2.0
arc                   randconfig-002-20240701   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                             mxs_defconfig   clang-19
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240701   gcc-13.2.0
arm                   randconfig-002-20240701   gcc-13.2.0
arm                   randconfig-003-20240701   clang-19
arm                   randconfig-004-20240701   clang-15
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240701   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-004-20240630   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240630   clang-18
i386         buildonly-randconfig-006-20240630   gcc-13
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-001-20240630   gcc-13
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-002-20240630   gcc-13
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-004-20240630   gcc-13
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-011-20240630   gcc-13
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-013-20240630   gcc-8
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-014-20240630   gcc-8
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-015-20240630   gcc-10
i386                  randconfig-016-20240630   clang-18
i386                  randconfig-016-20240630   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           ci20_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                      bamboo_defconfig   clang-19
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-13.2.0
powerpc                      walnut_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                           se7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
xtensa                           alldefconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

