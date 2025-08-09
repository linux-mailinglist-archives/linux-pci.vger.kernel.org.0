Return-Path: <linux-pci+bounces-33655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CCDB1F1E6
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 04:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C155A57AE
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3292223DD1;
	Sat,  9 Aug 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzZqsIUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD81401B;
	Sat,  9 Aug 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754704850; cv=none; b=ctvxCTIKoCm6bp2Kh9u4SE393FERIgG0gRbR5RfUC/jpIgs0FpQFWGegbvihhlDN53NmkYuB0+OihJKbIY7UglUyRBDWMwTX4M5i6/BL7d5Ui5GlDjQzQJC6KPYPEgVDxkL0S42KUu78JSV0quMIgYZfPI86MUQ9ArXA+XyMPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754704850; c=relaxed/simple;
	bh=U7N8SvBKFsep1X+GGgH7xn+OmcWtHlCezIcmne4AlDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUFzWQ7knlS+3Wi2zq1j9XFZUz7qW0sS/NWOav1TfEkQxRs5asQeejdfUcu5w9SHNNbXTOuAU+E8hllZ25AcGWPSUerg5rWcSc4Uh4C6tb2ETGSFvJIXRRbmzglY5ihOvA/Koi0OyfElcJW2XARG0G9kYjnBoGqa4F/GQPPiTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzZqsIUa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754704849; x=1786240849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U7N8SvBKFsep1X+GGgH7xn+OmcWtHlCezIcmne4AlDY=;
  b=KzZqsIUaV2sPL61yrzbSkkOhWeuxLhNFBEra4tjbNtuOwvLHpWbhG4co
   TZKPCsg/ntvxBsnG0kYd3Wgi3pUzWOHp+eOA2AoEYJPueu74uHK+cDZbw
   uwZdxHj3GzplZljpMH2slULnPb/PFYDrSTBX/OCz3jZekuArawArIx36T
   KkzCDMiN+RM+LgH6yf21kR8SRfTFoiltBBdgS+YJ9OheOqch7OD++kXjQ
   b0gZv6XRH5bCMCtXhU6HoN7d3uemuWVq++3tX6Ap2xbwphM92Cj5pMVw3
   BmhEkFgDcG+nAerFHmF4pBK9+1uS9PX207KUXAM0sDsir7i970cSFAZxF
   A==;
X-CSE-ConnectionGUID: gAuxruRuRhWr4WxTgLD1GA==
X-CSE-MsgGUID: m1ebJ5knScSlIcOCBgZPKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68509855"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68509855"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 19:00:49 -0700
X-CSE-ConnectionGUID: pzn0sm/NQ5WOOoTuOGgzTg==
X-CSE-MsgGUID: CPv93rPoS4uSrRdjp2LTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170822641"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 08 Aug 2025 19:00:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukYt0-0004S6-06;
	Sat, 09 Aug 2025 02:00:42 +0000
Date: Sat, 9 Aug 2025 09:59:11 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, robh@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v6 06/12] PCI: cadence: Add support for High Performance
 Arch(HPA) controller
Message-ID: <202508090915.VpyifVYr-lkp@intel.com>
References: <20250808072929.4090694-7-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808072929.4090694-7-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 37816488247ddddbc3de113c78c83572274b1e2e]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Split-PCIe-controller-header-file/20250808-154018
base:   37816488247ddddbc3de113c78c83572274b1e2e
patch link:    https://lore.kernel.org/r/20250808072929.4090694-7-hans.zhang%40cixtech.com
patch subject: [PATCH v6 06/12] PCI: cadence: Add support for High Performance Arch(HPA) controller
config: sparc-randconfig-001-20250809 (https://download.01.org/0day-ci/archive/20250809/202508090915.VpyifVYr-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090915.VpyifVYr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090915.VpyifVYr-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/cadence/pcie-cadence-host-hpa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/cadence/pcie-cadence-host-hpa.o
ERROR: modpost: "cdns_pcie_host_start_link" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
ERROR: modpost: "cdns_pcie_host_dma_ranges_cmp" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
ERROR: modpost: "bar_max_size" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
ERROR: modpost: "cdns_pcie_host_find_min_bar" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
ERROR: modpost: "cdns_pcie_host_find_max_bar" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>> ERROR: modpost: "cdns_pcie_host_wait_for_link" [drivers/pci/controller/cadence/pcie-cadence-host-hpa.ko] undefined!
>> ERROR: modpost: "cdns_pcie_retrain" [drivers/pci/controller/cadence/pcie-cadence-host-hpa.ko] undefined!
>> ERROR: modpost: "cdns_pcie_hpa_set_outbound_region_for_normal_msg" [drivers/pci/controller/cadence/pcie-cadence-host-hpa.ko] undefined!
>> ERROR: modpost: "cdns_pcie_hpa_set_outbound_region" [drivers/pci/controller/cadence/pcie-cadence-host-hpa.ko] undefined!
>> ERROR: modpost: "cdns_pcie_host_dma_ranges_cmp" [drivers/pci/controller/cadence/pcie-cadence-host-hpa.ko] undefined!
WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

