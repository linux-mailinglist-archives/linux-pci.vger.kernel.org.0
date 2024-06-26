Return-Path: <linux-pci+bounces-9342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636A919952
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 22:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1166A1F21708
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 20:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075E194096;
	Wed, 26 Jun 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEmOAJ4C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBA9183083
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434425; cv=none; b=HMur7Xtnykd/ZCjSZDUXnCD7OOiOx83pERJXskoUDaNFx6BvZnvFU1ye9j5wsh7y0alEeT5Qp6bTWhCCAz5A8pkjyCAXVHqmqHfVx9PUauYVo2atdNjz2/hFp6PQ1bDRPhoa7eJLpPRCBMDU2K37Ft/QgxbQAfVQ0T5nkLpcCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434425; c=relaxed/simple;
	bh=prx96gDz5lHXts7ymWvbIjnx0m5y2fFKh/zF9s3vrtc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tcmoVTy/4q2qqLN3N5GmdC58IriQoj1V6dwwAG2zhI46ICcDcFGkkSYED97K+h9fZ0aZAIcubEiZuCFcVSxc2MRCnEGrdhmM1A39a8s/+/jCGhp9Q3Lkv637zIDsDEsnTFydc8oi0XoZlS9WEK3TlSR6ASnbpDYGNUmVOT3mycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEmOAJ4C; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719434424; x=1750970424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=prx96gDz5lHXts7ymWvbIjnx0m5y2fFKh/zF9s3vrtc=;
  b=aEmOAJ4C8YGMRdaNaZH6t37J35Y+hD/BIAGCwwA8VivJOIhgXPEPY44h
   oH4nNAvP+6vgmHbO5B5H/aTABnCSgHYHmlW1zmLiJJ5zmbaYrRjI5Ze7E
   5E8hl2v9IZ7vU9mN8jmU6oW2nqYEVPX+2zGsdApPnANFfQo0WVPO5G5DZ
   8rfxhgOeWiIGJfXGCkCyJdr3iMvKkHrLXC4cRfZCqxtOw4BXWgSCkFK2D
   ggah7xjVhA0NCorPt7xA8QPOcUsAo0xA95AzrZaz9flK6J1yFJYVVg4z6
   jYnoc/dCWDm/GMB1Xq/75WAf5NZ4PmXJ4kWimwKXwQhwb06dpB5z6DYc8
   Q==;
X-CSE-ConnectionGUID: RH039vk0ReKMAkO+YXYkEQ==
X-CSE-MsgGUID: iGFRP8LcTlmy0urjlaHZKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16415973"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16415973"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 13:40:23 -0700
X-CSE-ConnectionGUID: PL31qhj5SA2n3UnTz1xQoQ==
X-CSE-MsgGUID: 8rlJHDE8SW64uvwWhXq6qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="48582016"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2024 13:40:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMZRE-000FXo-1x;
	Wed, 26 Jun 2024 20:40:20 +0000
Date: Thu, 27 Jun 2024 04:40:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD REGRESSION
 246afbe0f6fca433d8d918b740719170b1b082cc
Message-ID: <202406270459.JXtYsIVE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 246afbe0f6fca433d8d918b740719170b1b082cc  PCI: dw-rockchip: Use pci_epc_init_notify() directly

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202406270250.k2esVVnL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/controller/dwc/pcie-designware-ep.c:26:(.text+0x1e4): undefined reference to `pci_epc_init_notify'
drivers/pci/controller/dwc/pcie-designware-ep.c:640:(.text+0x83c): undefined reference to `pci_epc_mem_free_addr'
drivers/pci/controller/dwc/pcie-designware-ep.c:811:(.text+0x924): undefined reference to `pci_epc_linkup'
drivers/pci/controller/dwc/pcie-designware-ep.c:836:(.text+0x964): undefined reference to `pci_epc_linkdown'
drivers/pci/controller/dwc/pcie-designware-ep.c:875:(.text+0xe90): undefined reference to `__devm_pci_epc_create'
loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:643:(.text+0x854): undefined reference to `pci_epc_mem_exit'
loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:888:(.text+0xf20): undefined reference to `pci_epc_mem_init'
loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:895:(.text+0xf54): undefined reference to `pci_epc_mem_alloc_addr'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-randconfig-r081-20240626
    |-- drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-__devm_pci_epc_create
    |-- drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-pci_epc_init_notify
    |-- drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-pci_epc_linkdown
    |-- drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-pci_epc_linkup
    |-- drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-pci_epc_mem_free_addr
    |-- loongarch64-linux-ld:drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-pci_epc_mem_alloc_addr
    |-- loongarch64-linux-ld:drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-pci_epc_mem_exit
    `-- loongarch64-linux-ld:drivers-pci-controller-dwc-pcie-designware-ep.c:(.text):undefined-reference-to-pci_epc_mem_init

elapsed time: 6017m

configs tested: 41
configs skipped: 0

tested configs:
arc                   randconfig-001-20240623   gcc-13.2.0
arc                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-001-20240623   gcc-13.2.0
arm                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-003-20240623   gcc-13.2.0
arm                   randconfig-004-20240623   gcc-13.2.0
csky                  randconfig-001-20240623   gcc-13.2.0
csky                  randconfig-002-20240623   gcc-13.2.0
i386         buildonly-randconfig-004-20240623   gcc-13
i386                  randconfig-001-20240623   gcc-9
i386                  randconfig-003-20240623   gcc-13
i386                  randconfig-005-20240623   gcc-7
i386                  randconfig-012-20240623   gcc-8
i386                  randconfig-015-20240623   gcc-8
loongarch             randconfig-001-20240623   gcc-13.2.0
loongarch             randconfig-002-20240623   gcc-13.2.0
nios2                 randconfig-001-20240623   gcc-13.2.0
nios2                 randconfig-002-20240623   gcc-13.2.0
parisc                randconfig-001-20240623   gcc-13.2.0
parisc                randconfig-002-20240623   gcc-13.2.0
powerpc               randconfig-001-20240623   gcc-13.2.0
powerpc64             randconfig-001-20240623   gcc-13.2.0
powerpc64             randconfig-003-20240623   gcc-13.2.0
s390                  randconfig-001-20240623   gcc-13.2.0
s390                  randconfig-002-20240623   gcc-13.2.0
sh                    randconfig-001-20240623   gcc-13.2.0
sh                    randconfig-002-20240623   gcc-13.2.0
sparc64               randconfig-001-20240623   gcc-13.2.0
sparc64               randconfig-002-20240623   gcc-13.2.0
um                    randconfig-001-20240623   gcc-7
x86_64                randconfig-001-20240623   gcc-13
x86_64                randconfig-002-20240623   gcc-13
x86_64                randconfig-004-20240623   gcc-13
x86_64                randconfig-005-20240623   gcc-8
x86_64                randconfig-012-20240623   gcc-13
x86_64                randconfig-015-20240623   gcc-13
x86_64                randconfig-071-20240623   gcc-13
x86_64                randconfig-072-20240623   gcc-13
x86_64                randconfig-075-20240623   gcc-13
xtensa                randconfig-001-20240623   gcc-13.2.0
xtensa                randconfig-002-20240623   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

