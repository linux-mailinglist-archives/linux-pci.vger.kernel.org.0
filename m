Return-Path: <linux-pci+bounces-26724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A397AA9BD7B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 06:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4281BA18CD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC30E215F53;
	Fri, 25 Apr 2025 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dj3xELOr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984A1B0F11;
	Fri, 25 Apr 2025 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554777; cv=none; b=rqZpjtbE5eYGVRZ9V3qCYRb0hDlJU/7Nt872pD8EwMM1b9xOOwmmbs18AvEkVlfETrRwQcx3gGJBLC5w1JDN5ODmW2Pgw2ItfFvU7YWnPBA3V5fyIH57n2nBlWznnr5vBGfzpEWd+JztzDmlzte08L46Fv7NRjFFlSum6T/qLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554777; c=relaxed/simple;
	bh=HvUQ2jlkbOcoo0ZLx18H2YZfkCaqCX2iH2Clv+lgH08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJCFSA1MfSpNRA5EAciC5d7K7RKxtBQ1jg4WC0UHvtH9QZ/9+vySyq+o2Q+CTTiReGDt3ye1+XNjpMt7VJqkECg+z+keKABvK1SF9gue+VTCFfBdyGWs8AVzgHvLEo37oHhnry1EQPmOwAOQ/Jcf0lrxzadw1OcySEYRIl3GXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dj3xELOr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745554776; x=1777090776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvUQ2jlkbOcoo0ZLx18H2YZfkCaqCX2iH2Clv+lgH08=;
  b=dj3xELOraIB7aik0g0Oa+q8TG7lsShKJ9P5AsSAEqG8mdyTb6xBAmqmG
   qVPH75qNAP6W9SRgO1wARjqk5L0O7m+IoneYf/wWGUoUVMcCK0E32Qtnl
   9mcrog8MllCLsIa9gD9fjfefrjC32EyuafY1o3Et0k5Vn/s9xMBNLabFD
   +l1sp+Brmmszt0wOYdKcvIKRbP3ugVEV1XqjXFdf9v/QCoNK8ejhZvpGF
   P21RVEKAauvSTCehaqSJxIeWq5UMkEEj2F9MEbuhn1rvXU2O49Wn99+rc
   uHd1Qs9XNtflbgkQdwZ5+qboy5QJOLl2hMJZCBzz8JhWPXr9mREVr9lv1
   A==;
X-CSE-ConnectionGUID: XwfJqSOqQxG0t2Pv5Q3jmw==
X-CSE-MsgGUID: rkH/NgniRlmTsWsMvQ02nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47225238"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47225238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 21:19:35 -0700
X-CSE-ConnectionGUID: mud3aOYySRScxADNvob0ig==
X-CSE-MsgGUID: Uh0zV26bTnKghmeikkJV/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="170016448"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Apr 2025 21:19:31 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8AXB-0004pV-0L;
	Fri, 25 Apr 2025 04:19:29 +0000
Date: Fri, 25 Apr 2025 12:18:38 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	peter.chen@cixtech.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v4 3/5] PCI: cadence: Add header support for PCIe HPA
 controller
Message-ID: <202504251214.ngJwGxvn-lkp@intel.com>
References: <20250424010445.2260090-4-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424010445.2260090-4-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/dt-bindings-pci-cadence-Extend-compatible-for-new-RP-configuration/20250424-090651
base:   fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
patch link:    https://lore.kernel.org/r/20250424010445.2260090-4-hans.zhang%40cixtech.com
patch subject: [PATCH v4 3/5] PCI: cadence: Add header support for PCIe HPA controller
config: i386-buildonly-randconfig-003-20250425 (https://download.01.org/0day-ci/archive/20250425/202504251214.ngJwGxvn-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250425/202504251214.ngJwGxvn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504251214.ngJwGxvn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/cadence/pcie-cadence.c:9:
>> drivers/pci/controller/cadence/pcie-cadence.h:851:8: error: expected ')'
     851 |                                                  int where)
         |                                                  ^
   drivers/pci/controller/cadence/pcie-cadence.h:850:49: note: to match this '('
     850 | static inline void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn
         |                                                 ^
   1 error generated.


vim +851 drivers/pci/controller/cadence/pcie-cadence.h

   811	
   812	#ifdef CONFIG_PCIE_CADENCE_HOST
   813	int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc);
   814	int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
   815	int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
   816	void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
   817				       int where);
   818	int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc);
   819	int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
   820					 enum cdns_pcie_rp_bar bar,
   821					 u64 cpu_addr, u64 size,
   822					 unsigned long flags);
   823	int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc);
   824	void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn, int where);
   825	int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc);
   826	int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
   827					     enum cdns_pcie_rp_bar bar,
   828					     u64 cpu_addr, u64 size,
   829					     unsigned long flags);
   830	int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc);
   831	int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc);
   832	#else
   833	static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
   834	{
   835		return 0;
   836	}
   837	static inline int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
   838	{
   839		return 0;
   840	}
   841	static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
   842	{
   843		return 0;
   844	}
   845	static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
   846						     int where)
   847	{
   848		return NULL;
   849	}
   850	static inline void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn
 > 851							 int where)
   852	{
   853		return NULL;
   854	}
   855	static inline int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
   856	{
   857		return 0;
   858	}
   859	static inline int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
   860							   enum cdns_pcie_rp_bar bar,
   861							   u64 cpu_addr, u64 size,
   862							   unsigned long flags)
   863	{
   864		return 0;
   865	}
   866	static inline int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
   867	{
   868		return 0;
   869	}
   870	#endif
   871	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

