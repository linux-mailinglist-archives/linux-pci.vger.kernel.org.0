Return-Path: <linux-pci+bounces-12844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B126E96DF49
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324CD1F2277C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A319F49D;
	Thu,  5 Sep 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1Hv/+5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B381419F48B;
	Thu,  5 Sep 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552746; cv=none; b=Qji4XsfzVdAma1OVlTCJfGKlQQcaWCK7Z7yWoGcrAmirIzygAiF5kjVCXXqQ+0FrrCbqBLs9Zq+5TTvRP+Lw4BxYVy5Ux1a/L36Y1c1tBV5XyrH5qiI1e0/653Mvfsqn+nHHodUcpzu//cBIZaHfJyfpMSC/D1A2aaLacX3wAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552746; c=relaxed/simple;
	bh=K6RDaEN/MDPa23PcxNXoVHYubllWBbLL+J/L8CXUdyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx0IxNC5vIIWS9WmWbHOi+FUgaoEy12FcjQjMxKs/nBK76/01jW65/gu1Fu55eg3qrBYhRzGQnANIb/Ez1qbp/gCY8ZRoFl0/bhE2QuXni/ZLcPQr6HJKARU4rNLcyiIy634JjJBvXwsZbo4he850rxqurhxwkYW/19gN9eQbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1Hv/+5w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725552744; x=1757088744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6RDaEN/MDPa23PcxNXoVHYubllWBbLL+J/L8CXUdyw=;
  b=U1Hv/+5wOzmkUWwngYVqx9V6XEIsiAXChy/Ai6Pa2uPCTFVs0m7uRAfF
   oE9t4IzvDC00ORGAr9sK3ne0QqMI3wugGgAgKbJyWhWN01X75+CdVoTDk
   8XwPaXDySFsCpZhGZDghEMFRgTSeAXwqUsliC3pJDJr/Brc+06zG4NW7O
   dJP4rH/QTEGa9HH3O/HrkdaoGAk19ySZlZmPchEpWiN2i5jsdyDTDTdSq
   QJdG08RxJFNf4TsWmZ3xxBtOv9z+O37sDeM3H38lZp/Q5XwqmzPZo7wyH
   yThWWa6YTjCZ3Qi+sDdnDz2SExLKRTLA1lo0keSG8eTdMzLSDf4hPaEKR
   w==;
X-CSE-ConnectionGUID: QQALCeruTBq1gu0XaUDYZw==
X-CSE-MsgGUID: GGc8UxGDS5WOEowozJzQfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24473880"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24473880"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:12:21 -0700
X-CSE-ConnectionGUID: 1358xW9WSSGJaEZg2P8u+A==
X-CSE-MsgGUID: kJluJaoxTASmBFneGyt5dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65326967"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Sep 2024 09:12:16 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smF5h-000A6J-2M;
	Thu, 05 Sep 2024 16:12:13 +0000
Date: Fri, 6 Sep 2024 00:11:51 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 1/4] PCI: dwc: Rename 'dw_pcie::link_gen' to
 'dw_pcie::max_link_speed'
Message-ID: <202409060041.zY2BEBq7-lkp@intel.com>
References: <20240904-pci-qcom-gen4-stability-v6-1-ec39f7ae3f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-1-ec39f7ae3f62@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 47ac09b91befbb6a235ab620c32af719f8208399]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-dwc-Rename-dw_pcie-link_gen-to-dw_pcie-max_link_speed/20240904-151354
base:   47ac09b91befbb6a235ab620c32af719f8208399
patch link:    https://lore.kernel.org/r/20240904-pci-qcom-gen4-stability-v6-1-ec39f7ae3f62%40linaro.org
patch subject: [PATCH v6 1/4] PCI: dwc: Rename 'dw_pcie::link_gen' to 'dw_pcie::max_link_speed'
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240906/202409060041.zY2BEBq7-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240906/202409060041.zY2BEBq7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409060041.zY2BEBq7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-spear13xx.c:236:8: error: no member named 'link_gen' in 'struct dw_pcie'
     236 |                 pci->link_gen = 1;
         |                 ~~~  ^
   1 error generated.


vim +236 drivers/pci/controller/dwc/pcie-spear13xx.c

442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  190  
a43f32d6472730 drivers/pci/host/pcie-spear13xx.c           Matwey V. Kornilov     2015-02-19  191  static int spear13xx_pcie_probe(struct platform_device *pdev)
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  192  {
6a43a425a074af drivers/pci/host/pcie-spear13xx.c           Bjorn Helgaas          2016-10-06  193  	struct device *dev = &pdev->dev;
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  194  	struct dw_pcie *pci;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  195  	struct spear13xx_pcie *spear13xx_pcie;
6a43a425a074af drivers/pci/host/pcie-spear13xx.c           Bjorn Helgaas          2016-10-06  196  	struct device_node *np = dev->of_node;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  197  	int ret;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  198  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  199  	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
20f9ece101d879 drivers/pci/host/pcie-spear13xx.c           Jingoo Han             2014-11-12  200  	if (!spear13xx_pcie)
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  201  		return -ENOMEM;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  202  
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  203  	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  204  	if (!pci)
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  205  		return -ENOMEM;
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  206  
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  207  	pci->dev = dev;
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  208  	pci->ops = &dw_pcie_ops;
442ec4c04d1235 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  209  
c0464062bfea9c drivers/pci/dwc/pcie-spear13xx.c            Guenter Roeck          2017-02-25  210  	spear13xx_pcie->pci = pci;
c0464062bfea9c drivers/pci/dwc/pcie-spear13xx.c            Guenter Roeck          2017-02-25  211  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  212  	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  213  	if (IS_ERR(spear13xx_pcie->phy)) {
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  214  		ret = PTR_ERR(spear13xx_pcie->phy);
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  215  		if (ret == -EPROBE_DEFER)
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  216  			dev_info(dev, "probe deferred\n");
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  217  		else
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  218  			dev_err(dev, "couldn't get pcie-phy\n");
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  219  		return ret;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  220  	}
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  221  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  222  	phy_init(spear13xx_pcie->phy);
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  223  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  224  	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  225  	if (IS_ERR(spear13xx_pcie->clk)) {
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  226  		dev_err(dev, "couldn't get clk for pcie\n");
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  227  		return PTR_ERR(spear13xx_pcie->clk);
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  228  	}
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  229  	ret = clk_prepare_enable(spear13xx_pcie->clk);
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  230  	if (ret) {
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  231  		dev_err(dev, "couldn't enable clk for pcie\n");
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  232  		return ret;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  233  	}
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  234  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  235  	if (of_property_read_bool(np, "st,pcie-is-gen1"))
39bc5006501cc3 drivers/pci/controller/dwc/pcie-spear13xx.c Rob Herring            2020-08-20 @236  		pci->link_gen = 1;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  237  
9bcf0a6fdc5062 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  238  	platform_set_drvdata(pdev, spear13xx_pcie);
9bcf0a6fdc5062 drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  239  
ffe82fa66afb19 drivers/pci/host/pcie-spear13xx.c           Bjorn Helgaas          2016-10-06  240  	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  241  	if (ret < 0)
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  242  		goto fail_clk;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  243  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  244  	return 0;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  245  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  246  fail_clk:
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  247  	clk_disable_unprepare(spear13xx_pcie->clk);
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  248  
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  249  	return ret;
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  250  }
51b66a6ce12570 drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  251  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

