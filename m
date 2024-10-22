Return-Path: <linux-pci+bounces-15037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3359AB6D8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB5C1C23395
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B71CC8A7;
	Tue, 22 Oct 2024 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIx8QETA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B71CB534;
	Tue, 22 Oct 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625468; cv=none; b=QPLEh8YVHFjWrPn2qFezDuDEbivtcg+oJte9yr+RjZx8JhgCuMYweCb0MAR1BLtgBcTmEbb3WAwCDlC1SShES4WS0r/R5RH4VvpP7f3hULacwhTD+4df6dQGyFuz6Aao+/x1xPTgpp8lkv4ehwKqvnPTlRRdYLDjcaPYM1fWr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625468; c=relaxed/simple;
	bh=I96gy9L2CueZ1inOdskqZYTcTAN8yiQLuBuZyuhO8bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH7fozmksIrrgvKaJ5E7d5fhV++RBCNEq6D81HK39c14hX0izFXBX9guG2iD+K36rIKjbMCbycEbJfpdpi617WdLlZTBS9208zL5JIJ/d/m9/xoPq9nmhIF8pfBFCOI6XMU5ego8ThTAEe6x4dm/5I0WSCS6SQXp6/Umf7HXTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIx8QETA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729625466; x=1761161466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I96gy9L2CueZ1inOdskqZYTcTAN8yiQLuBuZyuhO8bU=;
  b=CIx8QETAh1ixsce63wTxkx7dgsD1NQycVzTx9FaSPt9UyhE34Dd9YzNT
   EWNxhXOAnbVMpjSulNFLRVAMmjFQN8etgbbFvc5UrczuQlTc5mY5qmLwx
   fJuDqJug2BRPJt85plb20puR1+lzj4cG86vOgGM4KACDPusoHmxejb3ap
   p5zCUtUg3imODz5Wfnwhbq+f1b+W/SH9QtkaA1bV4MeaTIbKxcVSGI/6t
   NXCIsBA/cz+edwiNwud2izxqD5N+l6nC+zTqL7bwO8Jhgpkvy1cxkkeou
   wk6qa0hlPAbm6UpkVN9aYw1qDEZaNg2q+dvB5VvGDS7fg78bIzgAp/TA7
   w==;
X-CSE-ConnectionGUID: LUY8dnnsTsGF5vXTbHTv8Q==
X-CSE-MsgGUID: HM9BVib4TJ+U+YoagLXqCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29077405"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29077405"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:31:06 -0700
X-CSE-ConnectionGUID: K93RX3e4SKSLbeqw2r8gJA==
X-CSE-MsgGUID: l+lO5qg7TimnUo6kutzWnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84759781"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Oct 2024 12:30:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3Kan-000U0a-2E;
	Tue, 22 Oct 2024 19:30:57 +0000
Date: Wed, 23 Oct 2024 03:30:47 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/4] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <202410230325.DxAdrnbW-lkp@intel.com>
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
config: i386-buildonly-randconfig-002-20241023 (https://download.01.org/0day-ci/archive/20241023/202410230325.DxAdrnbW-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230325.DxAdrnbW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230325.DxAdrnbW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-ep.c:885:35: error: incompatible pointer types passing 'phys_addr_t *' (aka 'unsigned int *') to parameter of type 'u64 *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     885 |                 of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
         |                                                 ^~~~~~~~~~~~~~~~~~
   include/linux/of_address.h:75:64: note: passing argument to parameter 'addr' here
      75 | int of_property_read_reg(struct device_node *np, int idx, u64 *addr, u64 *size);
         |                                                                ^
   1 error generated.


vim +885 drivers/pci/controller/dwc/pcie-designware-ep.c

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

