Return-Path: <linux-pci+bounces-8981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AAD90EF6A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 15:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F56F1C20D98
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AE414EC42;
	Wed, 19 Jun 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blqEOqXz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119514E2D7
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805123; cv=none; b=Jba3vTrqaeGGMSMtpykb8ej1ku16SX0J5a+j/aWlimgufg0L7EIsig0fz888xNSNKCLqm7Z54znQB0PBdA47PI35a90U/fqR2A8gLdEgPiLtLYuupmVXHszFOc05BmnmwFv8XB27T51ZmyiGLnUhq6FYwCI1Pfy6w5FLFUakQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805123; c=relaxed/simple;
	bh=Ne4dJOs6adSB2/UchB2CxvXGXprEWZmbqLcksNHoLig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fXM5TrgOFHONhX8Df5DVKE3IMhG3SxxgA9lTy7XhYyoGdw/nOoHjn0NAjadFztdcS8q2t0iQ51AlwkuT9SV21QuK/A9m2g9k1XtiuodqFwJOQAxcFAEHT571jNLDiM47UmWiIk7Kxk3FAd9RW47QWzcsTVj/+2jEc+6Fh/oujLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blqEOqXz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718805121; x=1750341121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ne4dJOs6adSB2/UchB2CxvXGXprEWZmbqLcksNHoLig=;
  b=blqEOqXz7nyO9T2RKJqvOByyNSdGhmKqakpUdFH4Hw/17zG3g4+3w4g9
   bk0zJAzghReqs1W4Mg6PG1ARhFinKetyypBO7xUP23Xcu+yKOmfpn9w5t
   JRQppXkbr1zOHcoj4NWAP5pFMiLYXDzFamNyCi3owcV7pvB0xYxT3hSbW
   godaxbFGclH1AqS2Op05dgg0qEU5eA0zeLZnOjlXPCUJHZsQ04EpMT7wB
   akRTRaSy7mB00Yfb5CMVslz/bbwdf/gjFd8taRgzLRyqChrjUlMdYxrVA
   fywe7yBKu3Ae7J5J+nRaUigGzRaosvVyPxK2mJLkyO8Byrpu9mv+7Pvmx
   w==;
X-CSE-ConnectionGUID: AFWl5G+2R4+BPLzMDjOj/Q==
X-CSE-MsgGUID: +Ac5XsSPQ4SqipPhy2VlgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26424062"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="26424062"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:46:15 -0700
X-CSE-ConnectionGUID: qTop81ZFSTedgk5nuV4yXA==
X-CSE-MsgGUID: RHvdy3ndTrS7evbWUYFWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="42023292"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Jun 2024 06:46:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJvdX-0006eI-2Z;
	Wed, 19 Jun 2024 13:46:07 +0000
Date: Wed, 19 Jun 2024 21:45:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/sysfs-static-resource-attributes] BUILD
 REGRESSION 7f395964ea2fe94ad5099688ff13d6ba89c68f97
Message-ID: <202406192151.KLjfRFBB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/sysfs-static-resource-attributes
branch HEAD: 7f395964ea2fe94ad5099688ff13d6ba89c68f97  PCI/sysfs: Limit pci_sysfs_init() late initcall compile time scope

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202406191615.C3UP7pEc-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202406191749.Tjh9cRdX-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/pci-sysfs.c:971:10: error: 'struct pci_bus' has no member named 'legacy_io'
drivers/pci/pci-sysfs.c:971:5: error: no member named 'legacy_io' in 'struct pci_bus'
drivers/pci/pci-sysfs.c:992:10: error: 'struct pci_bus' has no member named 'legacy_mem'
drivers/pci/pci-sysfs.c:992:5: error: no member named 'legacy_mem' in 'struct pci_bus'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_io
|   `-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_mem
|-- alpha-allyesconfig
|   |-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_io
|   `-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_mem
|-- powerpc-allmodconfig
|   |-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_io
|   `-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_mem
|-- powerpc-randconfig-001-20240619
|   |-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_io
|   `-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_mem
|-- powerpc-randconfig-003-20240619
|   |-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_io
|   `-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_mem
|-- powerpc64-randconfig-001-20240619
|   |-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_io
|   `-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_mem
`-- powerpc64-randconfig-002-20240619
    |-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_io
    `-- drivers-pci-pci-sysfs.c:error:struct-pci_bus-has-no-member-named-legacy_mem
clang_recent_errors
|-- powerpc-allyesconfig
|   |-- drivers-pci-pci-sysfs.c:error:no-member-named-legacy_io-in-struct-pci_bus
|   `-- drivers-pci-pci-sysfs.c:error:no-member-named-legacy_mem-in-struct-pci_bus
|-- powerpc-randconfig-002-20240619
|   |-- drivers-pci-pci-sysfs.c:error:no-member-named-legacy_io-in-struct-pci_bus
|   `-- drivers-pci-pci-sysfs.c:error:no-member-named-legacy_mem-in-struct-pci_bus
`-- powerpc64-randconfig-003-20240619
    |-- drivers-pci-pci-sysfs.c:error:no-member-named-legacy_io-in-struct-pci_bus
    `-- drivers-pci-pci-sysfs.c:error:no-member-named-legacy_mem-in-struct-pci_bus

elapsed time: 1635m

configs tested: 79
configs skipped: 0

tested configs:
arc                   randconfig-001-20240619   gcc-13.2.0
arc                   randconfig-002-20240619   gcc-13.2.0
arm                   randconfig-001-20240619   clang-19
arm                   randconfig-002-20240619   clang-19
arm                   randconfig-003-20240619   clang-19
arm                   randconfig-004-20240619   gcc-13.2.0
arm64                 randconfig-001-20240619   clang-19
arm64                 randconfig-002-20240619   clang-19
arm64                 randconfig-003-20240619   clang-19
arm64                 randconfig-004-20240619   clang-19
csky                  randconfig-001-20240619   gcc-13.2.0
csky                  randconfig-002-20240619   gcc-13.2.0
hexagon               randconfig-001-20240619   clang-15
hexagon               randconfig-002-20240619   clang-19
i386         buildonly-randconfig-001-20240619   clang-18
i386         buildonly-randconfig-002-20240619   clang-18
i386         buildonly-randconfig-003-20240619   clang-18
i386         buildonly-randconfig-004-20240619   clang-18
i386         buildonly-randconfig-005-20240619   gcc-7
i386         buildonly-randconfig-006-20240619   gcc-7
i386                  randconfig-001-20240619   gcc-7
i386                  randconfig-002-20240619   gcc-7
i386                  randconfig-003-20240619   clang-18
i386                  randconfig-004-20240619   gcc-7
i386                  randconfig-005-20240619   clang-18
i386                  randconfig-006-20240619   gcc-9
i386                  randconfig-011-20240619   clang-18
i386                  randconfig-012-20240619   clang-18
i386                  randconfig-013-20240619   gcc-13
i386                  randconfig-014-20240619   clang-18
i386                  randconfig-015-20240619   clang-18
i386                  randconfig-016-20240619   gcc-13
loongarch             randconfig-001-20240619   gcc-13.2.0
loongarch             randconfig-002-20240619   gcc-13.2.0
nios2                 randconfig-001-20240619   gcc-13.2.0
nios2                 randconfig-002-20240619   gcc-13.2.0
parisc                randconfig-001-20240619   gcc-13.2.0
parisc                randconfig-002-20240619   gcc-13.2.0
powerpc               randconfig-001-20240619   gcc-13.2.0
powerpc               randconfig-002-20240619   clang-15
powerpc               randconfig-003-20240619   gcc-13.2.0
powerpc64             randconfig-001-20240619   gcc-13.2.0
powerpc64             randconfig-002-20240619   gcc-13.2.0
powerpc64             randconfig-003-20240619   clang-19
riscv                 randconfig-001-20240619   clang-15
riscv                 randconfig-002-20240619   clang-19
s390                  randconfig-001-20240619   clang-19
s390                  randconfig-002-20240619   gcc-13.2.0
sh                    randconfig-001-20240619   gcc-13.2.0
sh                    randconfig-002-20240619   gcc-13.2.0
sparc64               randconfig-001-20240619   gcc-13.2.0
sparc64               randconfig-002-20240619   gcc-13.2.0
um                    randconfig-001-20240619   clang-19
um                    randconfig-002-20240619   clang-19
x86_64       buildonly-randconfig-001-20240619   clang-18
x86_64       buildonly-randconfig-002-20240619   clang-18
x86_64       buildonly-randconfig-003-20240619   gcc-11
x86_64       buildonly-randconfig-004-20240619   clang-18
x86_64       buildonly-randconfig-005-20240619   clang-18
x86_64       buildonly-randconfig-006-20240619   gcc-13
x86_64                randconfig-001-20240619   gcc-13
x86_64                randconfig-002-20240619   clang-18
x86_64                randconfig-003-20240619   gcc-8
x86_64                randconfig-004-20240619   clang-18
x86_64                randconfig-005-20240619   clang-18
x86_64                randconfig-006-20240619   gcc-13
x86_64                randconfig-011-20240619   gcc-13
x86_64                randconfig-012-20240619   gcc-13
x86_64                randconfig-013-20240619   gcc-13
x86_64                randconfig-014-20240619   clang-18
x86_64                randconfig-015-20240619   clang-18
x86_64                randconfig-016-20240619   gcc-11
x86_64                randconfig-071-20240619   clang-18
x86_64                randconfig-072-20240619   clang-18
x86_64                randconfig-073-20240619   gcc-9
x86_64                randconfig-074-20240619   gcc-9
x86_64                randconfig-075-20240619   clang-18
x86_64                randconfig-076-20240619   clang-18
xtensa                randconfig-002-20240619   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

