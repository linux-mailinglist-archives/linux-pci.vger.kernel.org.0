Return-Path: <linux-pci+bounces-15038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF49AB70E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87331F2409A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720311CB50A;
	Tue, 22 Oct 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgKxENgb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B4145A1C;
	Tue, 22 Oct 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626128; cv=none; b=ojqHbsSXC0/75s7ljorJlg74+7/0OzkPyi7mlJ7oid7zhMayZtvgNvBMG3vVeFrEhp8SgJpFgRMYpQaTzPIaQbCwyINnReCXZ9rXb34g2mPd38w0ZGUFfpzLHoGUtI29FOjSbvIuRBFUxwMyxWErQiZnZipK2hL+NBop7qyxqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626128; c=relaxed/simple;
	bh=QQc7sW7+SBjdpzhiB9fl4wHUT1zzT8I+K0VfEb+0Hro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvSRkqgWcY1eRtff96FW5bItVFboKuLzuzT0mNAtHR0butp4sSPAzunCrxLYBWCQyBMjqp7Vc4XvvTUxWnMSoiMoPRtteH+IaCKIRiWG0ysfeAsb6TEjGKd9E3kPrAj35EI27Oq8nkdMDM6c/+bEpZR8hLV/0CH2NU3lKXS8MqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgKxENgb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729626127; x=1761162127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QQc7sW7+SBjdpzhiB9fl4wHUT1zzT8I+K0VfEb+0Hro=;
  b=XgKxENgb8l/LR/Sf6BrpSHwd1TCDAhT2X4ZawOG3ZYx8hPhTmLzeTwT/
   mOvpKSfTeZv6J5Fs4svd8gJ2oQJyh/i5Eruk2z8HEiUzDp29oX2HgwXi0
   mC0hVPEgbNgFMmkn02n3Ryftwo94VvLPjS5RV2g4g9W7bZZtJJc2PcCiC
   o2JaVPR1DApSW1SHbWY+GfXxb5cb4hMZ6vE/GHsFhe65LwcJXLONEamYv
   UX7DwU5HmohnVX66lKzbIZpSlWq+0Am4HD6jb9MUdtKqY77bf0R7XopUI
   g52wivQoR/9Z4T84TPTBteWaAatGlNNlcEWy3iKz0ncrx1lUCCXVkkhnQ
   w==;
X-CSE-ConnectionGUID: XnwDqs9YQeqDUkZA+zARxg==
X-CSE-MsgGUID: PtkygznMR1mrpG7zl7N2Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28964358"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28964358"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:42:06 -0700
X-CSE-ConnectionGUID: 2NPEaIm3TUqbE4Fuzm0g3Q==
X-CSE-MsgGUID: zh7g0qZTSpKyd6aucQOrKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84567463"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Oct 2024 12:42:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3KlS-000U1g-1I;
	Tue, 22 Oct 2024 19:41:58 +0000
Date: Wed, 23 Oct 2024 03:41:08 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/4] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <202410230328.BTHareG1-lkp@intel.com>
References: <20241021-pcie_ep_range-v3-1-b13526eb0089@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-pcie_ep_range-v3-1-b13526eb0089@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on afb15ca28055352101286046c1f9f01fdaa1ace1]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-dwc-ep-Add-bus_addr_base-for-outbound-window/20241022-041043
base:   afb15ca28055352101286046c1f9f01fdaa1ace1
patch link:    https://lore.kernel.org/r/20241021-pcie_ep_range-v3-1-b13526eb0089%40nxp.com
patch subject: [PATCH v3 1/4] PCI: dwc: ep: Add bus_addr_base for outbound window
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20241023/202410230328.BTHareG1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230328.BTHareG1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_init':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:885:49: error: passing argument 3 of 'of_property_read_reg' from incompatible pointer type [-Wincompatible-pointer-types]
     885 |                 of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
         |                                                 ^~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 phys_addr_t * {aka unsigned int *}
   In file included from drivers/pci/controller/dwc/pcie-designware-ep.c:12:
   include/linux/of_address.h:75:64: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'phys_addr_t *' {aka 'unsigned int *'}
      75 | int of_property_read_reg(struct device_node *np, int idx, u64 *addr, u64 *size);
         |                                                           ~~~~~^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/of_property_read_reg +885 drivers/pci/controller/dwc/pcie-designware-ep.c

   846	
   847	/**
   848	 * dw_pcie_ep_init - Initialize the endpoint device
   849	 * @ep: DWC EP device
   850	 *
   851	 * Initialize the endpoint device. Allocate resources and create the EPC
   852	 * device with the endpoint framework.
   853	 *
   854	 * Return: 0 if success, errno otherwise.
   855	 */
   856	int dw_pcie_ep_init(struct dw_pcie_ep *ep)
   857	{
   858		int ret;
   859		struct resource *res;
   860		struct pci_epc *epc;
   861		struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
   862		struct device *dev = pci->dev;
   863		struct platform_device *pdev = to_platform_device(dev);
   864		struct device_node *np = dev->of_node;
   865		int index;
   866	
   867		INIT_LIST_HEAD(&ep->func_list);
   868	
   869		ret = dw_pcie_get_resources(pci);
   870		if (ret)
   871			return ret;
   872	
   873		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
   874		if (!res)
   875			return -EINVAL;
   876	
   877		ep->phys_base = res->start;
   878		ep->bus_addr_base = ep->phys_base;
   879	
   880		if (pci->using_dtbus_info) {
   881			index = of_property_match_string(np, "reg-names", "addr_space");
   882			if (index < 0)
   883				return -EINVAL;
   884	
 > 885			of_property_read_reg(np, index, &ep->bus_addr_base, NULL);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

