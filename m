Return-Path: <linux-pci+bounces-26725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD79A9BE4C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 08:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BFB464B97
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 06:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA422B8A9;
	Fri, 25 Apr 2025 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoEZom0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C5144304;
	Fri, 25 Apr 2025 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560905; cv=none; b=FyPl1W01WEB4b7wD5neDGMMdZx62TURS3aMVz9XRiSmlU7xwtgLVBYYgb6hZJvWiAP+5bMug8q0JvpEN9HVtMYVT3nRE1EziQoND858wN8vGeph5wopHvFwtFbAM94vT3L4lUlYmF+tZU+lsnmMexFz4vaJDTfKErHldTVAMn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560905; c=relaxed/simple;
	bh=xU2b+Zi/jPAOs/dygu9xP99GyeH/dv9p6nxAqx+d9P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO/sfSC0inYwLvbFq5s9m0qs0r7DXRnGEDeNkc4FP8EKAdy+COnwA67ITWKOzEDfv4wDpLihJcVsgms+c2CogtujswLzDzrT+LQF/tb0SoA35S88LWZRCcYUecLJxMD3l1L1nYeEQLZQUXfBnH10/NiYxvrcf0N5667l+X7f+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoEZom0U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745560904; x=1777096904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xU2b+Zi/jPAOs/dygu9xP99GyeH/dv9p6nxAqx+d9P0=;
  b=NoEZom0UCVuE1xRMG/PCgQ+ZiwK6TIaLEXWt71mdolo9g73frEYmQkB5
   AGpex7oZYtlM9zC7e0tCaBWZQdzwueey6Jbz14vamXPBr8P35H0p3zwDJ
   c8BCFSIXTOXYOEwFFX8lZfWb91Jhw+uLWLxwZeClFvZtkaIbgYHAO1+aM
   JA+1QYrtHQNZIs348x+ZWxMQSrtXQXC8pv40sLuRXx/PFElUrONi1adR1
   NB3k+tiwGrwGPMTVpt78UXeZjw/8SneG1sMvTojI/54uQjozKr5TrTa+F
   /MLxXjK51hAkndU8gcUYa35TnVGCfbDfGynOV2fsTJp2xRTts3q++MCe0
   g==;
X-CSE-ConnectionGUID: FQELhwl5QGCN8o3sq6CzzA==
X-CSE-MsgGUID: D+JqdKCjR/W2JAkgXQ8hpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="69707059"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="69707059"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 23:01:43 -0700
X-CSE-ConnectionGUID: b6S8IAIaR/+e7M6jn6Vibg==
X-CSE-MsgGUID: 7oAiGe6PQ0idckOK5XqdLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132707322"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Apr 2025 23:01:39 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8C80-0004rV-0Y;
	Fri, 25 Apr 2025 06:01:36 +0000
Date: Fri, 25 Apr 2025 14:01:31 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	peter.chen@cixtech.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and
 EP controller
Message-ID: <202504251312.YvKIAjMl-lkp@intel.com>
References: <20250424010445.2260090-6-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424010445.2260090-6-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/dt-bindings-pci-cadence-Extend-compatible-for-new-RP-configuration/20250424-090651
base:   fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
patch link:    https://lore.kernel.org/r/20250424010445.2260090-6-hans.zhang%40cixtech.com
patch subject: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and EP controller
config: i386-buildonly-randconfig-003-20250425 (https://download.01.org/0day-ci/archive/20250425/202504251312.YvKIAjMl-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250425/202504251312.YvKIAjMl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504251312.YvKIAjMl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/cadence/pcie-cadence-plat.c:13:
   drivers/pci/controller/cadence/pcie-cadence.h:851:8: error: expected ')'
     851 |                                                  int where)
         |                                                  ^
   drivers/pci/controller/cadence/pcie-cadence.h:850:49: note: to match this '('
     850 | static inline void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn
         |                                                 ^
>> drivers/pci/controller/cadence/pcie-cadence-plat.c:35:25: error: use of undeclared identifier 'cdns_pcie_host_init_root_port'; did you mean 'cdns_pcie_hpa_host_init_root_port'?
      35 |         .host_init_root_port = cdns_pcie_host_init_root_port,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                cdns_pcie_hpa_host_init_root_port
   drivers/pci/controller/cadence/pcie-cadence.h:855:19: note: 'cdns_pcie_hpa_host_init_root_port' declared here
     855 | static inline int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
         |                   ^
>> drivers/pci/controller/cadence/pcie-cadence-plat.c:36:24: error: use of undeclared identifier 'cdns_pcie_host_bar_ib_config'; did you mean 'cdns_pcie_hpa_host_bar_ib_config'?
      36 |         .host_bar_ib_config = cdns_pcie_host_bar_ib_config,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                               cdns_pcie_hpa_host_bar_ib_config
   drivers/pci/controller/cadence/pcie-cadence.h:859:19: note: 'cdns_pcie_hpa_host_bar_ib_config' declared here
     859 | static inline int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
         |                   ^
>> drivers/pci/controller/cadence/pcie-cadence-plat.c:37:35: error: use of undeclared identifier 'cdns_pcie_host_init_address_translation'; did you mean 'cdns_pcie_hpa_host_init_address_translation'?
      37 |         .host_init_address_translation = cdns_pcie_host_init_address_translation,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          cdns_pcie_hpa_host_init_address_translation
   drivers/pci/controller/cadence/pcie-cadence.h:866:19: note: 'cdns_pcie_hpa_host_init_address_translation' declared here
     866 | static inline int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
         |                   ^
   4 errors generated.


vim +35 drivers/pci/controller/cadence/pcie-cadence-plat.c

    31	
    32	static const struct cdns_pcie_ops cdns_plat_ops = {
    33		.link_up = cdns_pcie_linkup,
    34		.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
  > 35		.host_init_root_port = cdns_pcie_host_init_root_port,
  > 36		.host_bar_ib_config = cdns_pcie_host_bar_ib_config,
  > 37		.host_init_address_translation = cdns_pcie_host_init_address_translation,
    38		.detect_quiet_min_delay_set = cdns_pcie_detect_quiet_min_delay_set,
    39		.set_outbound_region = cdns_pcie_set_outbound_region,
    40		.set_outbound_region_for_normal_msg =
    41						    cdns_pcie_set_outbound_region_for_normal_msg,
    42		.reset_outbound_region = cdns_pcie_reset_outbound_region,
    43	};
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

