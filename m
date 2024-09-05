Return-Path: <linux-pci+bounces-12823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59196D253
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 10:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04601284355
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF38197545;
	Thu,  5 Sep 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuuhuP0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C835194AD6;
	Thu,  5 Sep 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525445; cv=none; b=J5NL5kR9TsKBoGpz0r3oWDL9N7/KyRCdKu5a5R69IExZaQ9UGCzelA14RNNP5VnhvQFdbvj0a9pd1V9i7ym9lWdlgBFFoOl4QaszQCS1hYjYCHJ7l71Z97RKfATznFUut47GQfygPt20IQWEk6I3EZQ75BeKIWT6X27bbgRl4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525445; c=relaxed/simple;
	bh=F5C21PIoGFyLC+pKtL4lE/ToVZLQW4ZouSefyGjoU2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CscUONv8nYCExKbZdZI5r/qOSJGg13s2QoO55s3tlSJ5N2yByDlYPztI+/v2vRjSfoNKCBY+xNz8GmfhjGaLDi6NHWC5rvIhieoZbzch6VLOmBWif6VjkXynBiTr/rQIDrhIR5apAxd/RzIppTwVV4ePjIly89c9RoIu1OzRsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuuhuP0V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725525444; x=1757061444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F5C21PIoGFyLC+pKtL4lE/ToVZLQW4ZouSefyGjoU2c=;
  b=VuuhuP0V641OchdPRPl0Z215e8O23kVqaeg56FJW5RtwniTzuhf99Wv+
   0CqxCnNqV8elF6wgE58HqtqUGXCA/aNqMhMsL1MtQV8pukFG5Vy/4SonJ
   a52PHAs2AZvSeuwJha7MC8AVm4DY6iXXsgozW8GNhmOi4aKcJ0jATU7dU
   YJGHN120NrOmN661C61naaee3ObbQJ71S9TAuNa/7CxHAIcIEUIBTrKLa
   foLLO//b4fY461Ym0EKhARhpi7NCu0rhxnxiNw+ptgGkU28bOvDpMcnKi
   xHsHIrz56Jd+3iD52WgiFqem0BO7QT895dw+hAon6t6JTN3et5hDVi9UW
   g==;
X-CSE-ConnectionGUID: X7B/WBsiQWCjTwYjlA2eRg==
X-CSE-MsgGUID: Bjf964P7S1aCTV6SukQE4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28114418"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="28114418"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:37:23 -0700
X-CSE-ConnectionGUID: pCSgSKXsTdecISYNnEkeTw==
X-CSE-MsgGUID: 2PD3EamKQQWA/nMxb+0W+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65392071"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Sep 2024 01:37:17 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm7zO-00097V-0g;
	Thu, 05 Sep 2024 08:37:14 +0000
Date: Thu, 5 Sep 2024 16:36:23 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, abel.vesa@linaro.org,
	johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 1/4] PCI: dwc: Rename 'dw_pcie::link_gen' to
 'dw_pcie::max_link_speed'
Message-ID: <202409051650.UA8WoHFz-lkp@intel.com>
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
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20240905/202409051650.UA8WoHFz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051650.UA8WoHFz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051650.UA8WoHFz-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-spear13xx.c: In function 'spear13xx_pcie_probe':
>> drivers/pci/controller/dwc/pcie-spear13xx.c:236:20: error: 'struct dw_pcie' has no member named 'link_gen'
     236 |                 pci->link_gen = 1;
         |                    ^~


vim +236 drivers/pci/controller/dwc/pcie-spear13xx.c

442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  190  
a43f32d64727302 drivers/pci/host/pcie-spear13xx.c           Matwey V. Kornilov     2015-02-19  191  static int spear13xx_pcie_probe(struct platform_device *pdev)
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  192  {
6a43a425a074afc drivers/pci/host/pcie-spear13xx.c           Bjorn Helgaas          2016-10-06  193  	struct device *dev = &pdev->dev;
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  194  	struct dw_pcie *pci;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  195  	struct spear13xx_pcie *spear13xx_pcie;
6a43a425a074afc drivers/pci/host/pcie-spear13xx.c           Bjorn Helgaas          2016-10-06  196  	struct device_node *np = dev->of_node;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  197  	int ret;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  198  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  199  	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
20f9ece101d8793 drivers/pci/host/pcie-spear13xx.c           Jingoo Han             2014-11-12  200  	if (!spear13xx_pcie)
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  201  		return -ENOMEM;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  202  
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  203  	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  204  	if (!pci)
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  205  		return -ENOMEM;
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  206  
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  207  	pci->dev = dev;
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  208  	pci->ops = &dw_pcie_ops;
442ec4c04d1235f drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  209  
c0464062bfea9cd drivers/pci/dwc/pcie-spear13xx.c            Guenter Roeck          2017-02-25  210  	spear13xx_pcie->pci = pci;
c0464062bfea9cd drivers/pci/dwc/pcie-spear13xx.c            Guenter Roeck          2017-02-25  211  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  212  	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  213  	if (IS_ERR(spear13xx_pcie->phy)) {
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  214  		ret = PTR_ERR(spear13xx_pcie->phy);
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  215  		if (ret == -EPROBE_DEFER)
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  216  			dev_info(dev, "probe deferred\n");
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  217  		else
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  218  			dev_err(dev, "couldn't get pcie-phy\n");
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  219  		return ret;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  220  	}
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  221  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  222  	phy_init(spear13xx_pcie->phy);
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  223  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  224  	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  225  	if (IS_ERR(spear13xx_pcie->clk)) {
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  226  		dev_err(dev, "couldn't get clk for pcie\n");
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  227  		return PTR_ERR(spear13xx_pcie->clk);
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  228  	}
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  229  	ret = clk_prepare_enable(spear13xx_pcie->clk);
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  230  	if (ret) {
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  231  		dev_err(dev, "couldn't enable clk for pcie\n");
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  232  		return ret;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  233  	}
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  234  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  235  	if (of_property_read_bool(np, "st,pcie-is-gen1"))
39bc5006501cc31 drivers/pci/controller/dwc/pcie-spear13xx.c Rob Herring            2020-08-20 @236  		pci->link_gen = 1;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  237  
9bcf0a6fdc5062e drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  238  	platform_set_drvdata(pdev, spear13xx_pcie);
9bcf0a6fdc5062e drivers/pci/dwc/pcie-spear13xx.c            Kishon Vijay Abraham I 2017-02-15  239  
ffe82fa66afb19c drivers/pci/host/pcie-spear13xx.c           Bjorn Helgaas          2016-10-06  240  	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  241  	if (ret < 0)
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  242  		goto fail_clk;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  243  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  244  	return 0;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  245  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  246  fail_clk:
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  247  	clk_disable_unprepare(spear13xx_pcie->clk);
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  248  
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  249  	return ret;
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  250  }
51b66a6ce12570e drivers/pci/host/pcie-spear13xx.c           Pratyush Anand         2014-02-11  251  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

