Return-Path: <linux-pci+bounces-9343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15995919B70
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 01:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908081F234DA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92448194147;
	Wed, 26 Jun 2024 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrunAY7g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB641940B1
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446084; cv=none; b=XndgUI7rhZGgC1rXJUfQ4YDW0o7DcuHbGWIMF9SkO/zaE48XGf6oXzcStTeSOjVdOOin0Ay44T9zQb1Rv++OKVb8ruvyy7mdVdaexh5NyXsH/0vY0GDiXJaTddVqtgi8lvBNv0XCEuKdKvaM2PqRN/dqFLqi0x+uO6Qd+DKgjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446084; c=relaxed/simple;
	bh=amqNXX4jeKLOLHOVQ5Dx1ljXHzJqEo2sG7Xg6glLmSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RXkq6cKbmQkLv72yZUMc5lJzECtnB6URz8/y2M79iVxfBCYUjPKUyIq2+BAxctY/SV+qP4bZQn1suD9fpW5GD0kFmxsBhHeM68x6uxBOCsGPynOOx6KNV2f7fJb7E4J+2H9sKu8xlKaZN49TFYXvJqd03cBzyq0o0K8eewzOE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrunAY7g; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719446083; x=1750982083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=amqNXX4jeKLOLHOVQ5Dx1ljXHzJqEo2sG7Xg6glLmSM=;
  b=XrunAY7g1m93Rd+3hZcZhVpTXn0P04g6O3shQDkiSXlIcRoPsDy5ORck
   qn3f9IS+znR99HolrpiPwIEO5GmTqISHdcISM51k3qGnhmw3pLPUx+tse
   WXbTGoVte/WB4hYmKfGJ1AlgGOYg9/AN5YTeNw4SMklKGmrh4FxqgTMs3
   j59ThHcx0OjXAVJCFaIEdxm9836fRx1hCUr/uYKUpLcRvfPrgowp/vT3m
   QNgrDr8r36e3LpH+Kd4pDdqhJZpBnDQj1fBd4HCKUlk/U4BGgSjrS0dw5
   5jeseeVdC8F+mdvUaNAQtKjnKk6iqigpB32CAJSJCbw9t+3iApet9MXGi
   w==;
X-CSE-ConnectionGUID: GGh/gxgARSqi0uhd3HS3uQ==
X-CSE-MsgGUID: L6ZkVRHcTL+/gw+Dv6P5Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="20370886"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="20370886"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 16:54:43 -0700
X-CSE-ConnectionGUID: YkgBcilAT5W3fKKJS2/QmA==
X-CSE-MsgGUID: 0E/iwxQ/Rw6B9Oon4Cjkfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="48793026"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Jun 2024 16:54:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMcTG-000FgI-1H;
	Wed, 26 Jun 2024 23:54:38 +0000
Date: Thu, 27 Jun 2024 07:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [pci:controller/rockchip 11/11]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:491:undefined reference to
 `pci_epc_init_notify'
Message-ID: <202406270721.a8SQi2hn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
head:   246afbe0f6fca433d8d918b740719170b1b082cc
commit: 246afbe0f6fca433d8d918b740719170b1b082cc [11/11] PCI: dw-rockchip: Use pci_epc_init_notify() directly
config: loongarch-randconfig-r081-20240626 (https://download.01.org/0day-ci/archive/20240627/202406270721.a8SQi2hn-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270721.a8SQi2hn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406270721.a8SQi2hn-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init_notify':
   drivers/pci/controller/dwc/pcie-designware-ep.c:26:(.text+0x1e4): undefined reference to `pci_epc_init_notify'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_deinit':
   drivers/pci/controller/dwc/pcie-designware-ep.c:640:(.text+0x83c): undefined reference to `pci_epc_mem_free_addr'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:643:(.text+0x854): undefined reference to `pci_epc_mem_exit'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_linkup':
   drivers/pci/controller/dwc/pcie-designware-ep.c:811:(.text+0x924): undefined reference to `pci_epc_linkup'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_linkdown':
   drivers/pci/controller/dwc/pcie-designware-ep.c:836:(.text+0x964): undefined reference to `pci_epc_linkdown'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init':
   drivers/pci/controller/dwc/pcie-designware-ep.c:875:(.text+0xe90): undefined reference to `__devm_pci_epc_create'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:888:(.text+0xf20): undefined reference to `pci_epc_mem_init'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:895:(.text+0xf54): undefined reference to `pci_epc_mem_alloc_addr'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:906:(.text+0xf74): undefined reference to `pci_epc_mem_exit'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-dw-rockchip.o: in function `rockchip_pcie_configure_ep':
>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:491:(.text+0x7cc): undefined reference to `pci_epc_init_notify'


vim +491 drivers/pci/controller/dwc/pcie-dw-rockchip.c

   441	
   442	static int rockchip_pcie_configure_ep(struct platform_device *pdev,
   443					      struct rockchip_pcie *rockchip)
   444	{
   445		struct device *dev = &pdev->dev;
   446		int irq, ret;
   447		u32 val;
   448	
   449		if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_EP))
   450			return -ENODEV;
   451	
   452		irq = platform_get_irq_byname(pdev, "sys");
   453		if (irq < 0) {
   454			dev_err(dev, "missing sys IRQ resource\n");
   455			return irq;
   456		}
   457	
   458		ret = devm_request_threaded_irq(dev, irq, NULL,
   459						rockchip_pcie_ep_sys_irq_thread,
   460						IRQF_ONESHOT, "pcie-sys", rockchip);
   461		if (ret) {
   462			dev_err(dev, "failed to request PCIe sys IRQ\n");
   463			return ret;
   464		}
   465	
   466		/* LTSSM enable control mode */
   467		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
   468		rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
   469	
   470		rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
   471					 PCIE_CLIENT_GENERAL_CONTROL);
   472	
   473		rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
   474		rockchip->pci.ep.page_size = SZ_64K;
   475	
   476		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
   477	
   478		ret = dw_pcie_ep_init(&rockchip->pci.ep);
   479		if (ret) {
   480			dev_err(dev, "failed to initialize endpoint\n");
   481			return ret;
   482		}
   483	
   484		ret = dw_pcie_ep_init_registers(&rockchip->pci.ep);
   485		if (ret) {
   486			dev_err(dev, "failed to initialize DWC endpoint registers\n");
   487			dw_pcie_ep_deinit(&rockchip->pci.ep);
   488			return ret;
   489		}
   490	
 > 491		pci_epc_init_notify(rockchip->pci.ep.epc);
   492	
   493		/* unmask DLL up/down indicator and hot reset/link-down reset */
   494		rockchip_pcie_writel_apb(rockchip, 0x60000, PCIE_CLIENT_INTR_MASK_MISC);
   495	
   496		return ret;
   497	}
   498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

