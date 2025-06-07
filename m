Return-Path: <linux-pci+bounces-29130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E6DAD0CF5
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 13:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC9C3B0BED
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B300E2206BF;
	Sat,  7 Jun 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBai1uWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DB21D3E6;
	Sat,  7 Jun 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294107; cv=none; b=cFKUydqq4OvnM38BuFQH4AE9K8QUotD1zK5CSpTwTYh/XNNDvFpdMOQQ+jJTV18t3az1GNOAYAwvqxB9HgzMFJh7DzV/x9PgY5DPCn+F/TnnXCTje58EgakJK3fkFvHW8kzWU/p96afZ8GgeGzCj8+lmIxyHZgKv79ENQhorBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294107; c=relaxed/simple;
	bh=oXRpziViexH8/fIeHAWT0i0ImnFtdOkJs/7hpOj+v+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Auco+Ygt7me8xZ6wJKE9wxGFTddeWvqgzphJr8DLxFzhuw70PDc8qiXFza+EYMDb+S0le6f9h1eWiaLdIK94u+TmfqfjGdhx5QwmxZMTWHlxriqKkWnx9dV6wIQU9g2i52aUCYO6AS3v2Q45eI6LF3lAxQV6Y4RIB4ENRWgH7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBai1uWJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749294106; x=1780830106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXRpziViexH8/fIeHAWT0i0ImnFtdOkJs/7hpOj+v+k=;
  b=SBai1uWJS/JZbLM0xK4aeRYSURvOVyLS/fgLkwoHp2VyRUFt9ZCyMWEM
   Wp9FQQNp0h7WbIg7iO1L2bDzqmWJeOrD6TK7nOKy6/z8jXcYVbn6qBATq
   W6fVBm+rh62nx6W13fYyo+3pqOpOhfmFWO2RmXH4VpPIsBiQ7mr1rkL04
   O96TAasOg53s9msBsou2KaL4sjCaCZsAlmLl9LxKP1se5Z+yED2PuAAxx
   iPLtcKV6rI0gxjfFpvzG8NSlLp1ukgGyeNwNchUo9lxIjkj5imroUAqlg
   p8aVzPO3bjUgDL1K+hD0/PSMbtyteTo7lKcQPlyXC6EpplowkEA2ecl79
   A==;
X-CSE-ConnectionGUID: jHw6AVbXTLeDdzfiB0Rkcg==
X-CSE-MsgGUID: P74h1IRtQfq/JfO9sPxy1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="54062162"
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="54062162"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 04:01:45 -0700
X-CSE-ConnectionGUID: GadTKGbxQgOwAieMHe6U0A==
X-CSE-MsgGUID: 9PPzAVzYRGWL7j+VBDs/7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="176950060"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jun 2025 04:01:42 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNrIw-0005k1-1j;
	Sat, 07 Jun 2025 11:01:38 +0000
Date: Sat, 7 Jun 2025 19:01:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Bruel <christian.bruel@foss.st.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/9] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
Message-ID: <202506071838.C54p5js2-lkp@intel.com>
References: <20250606120403.2964857-5-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606120403.2964857-5-christian.bruel@foss.st.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 911483b25612c8bc32a706ba940738cc43299496]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Bruel/dt-bindings-PCI-Add-STM32MP25-PCIe-Root-Complex-bindings/20250606-201204
base:   911483b25612c8bc32a706ba940738cc43299496
patch link:    https://lore.kernel.org/r/20250606120403.2964857-5-christian.bruel%40foss.st.com
patch subject: [PATCH v11 4/9] PCI: stm32: Add PCIe Endpoint support for STM32MP25
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20250607/202506071838.C54p5js2-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506071838.C54p5js2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506071838.C54p5js2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-stm32-ep.c: In function 'stm32_pcie_probe':
>> drivers/pci/controller/dwc/pcie-stm32-ep.c:339:79: warning: format '%d' expects a matching 'int' argument [-Wformat=]
     339 |                 return dev_err_probe(dev, ret, "Failed to request PERST IRQ: %d\n");
         |                                                                              ~^
         |                                                                               |
         |                                                                               int


vim +339 drivers/pci/controller/dwc/pcie-stm32-ep.c

   275	
   276	static int stm32_pcie_probe(struct platform_device *pdev)
   277	{
   278		struct stm32_pcie *stm32_pcie;
   279		struct device *dev = &pdev->dev;
   280		int ret;
   281	
   282		stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
   283		if (!stm32_pcie)
   284			return -ENOMEM;
   285	
   286		stm32_pcie->pci.dev = dev;
   287		stm32_pcie->pci.ops = &dw_pcie_ops;
   288	
   289		stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
   290		if (IS_ERR(stm32_pcie->regmap))
   291			return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
   292					     "No syscfg specified\n");
   293	
   294		stm32_pcie->phy = devm_phy_get(dev, NULL);
   295		if (IS_ERR(stm32_pcie->phy))
   296			return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
   297					     "failed to get pcie-phy\n");
   298	
   299		stm32_pcie->clk = devm_clk_get(dev, NULL);
   300		if (IS_ERR(stm32_pcie->clk))
   301			return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
   302					     "Failed to get PCIe clock source\n");
   303	
   304		stm32_pcie->rst = devm_reset_control_get_exclusive(dev, NULL);
   305		if (IS_ERR(stm32_pcie->rst))
   306			return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
   307					     "Failed to get PCIe reset\n");
   308	
   309		stm32_pcie->perst_gpio = devm_gpiod_get(dev, "reset", GPIOD_IN);
   310		if (IS_ERR(stm32_pcie->perst_gpio))
   311			return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
   312					     "Failed to get reset GPIO\n");
   313	
   314		ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
   315		if (ret)
   316			return ret;
   317	
   318		platform_set_drvdata(pdev, stm32_pcie);
   319	
   320		pm_runtime_get_noresume(dev);
   321	
   322		ret = devm_pm_runtime_enable(dev);
   323		if (ret < 0) {
   324			pm_runtime_put_noidle(&pdev->dev);
   325			return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
   326		}
   327	
   328		stm32_pcie->perst_irq = gpiod_to_irq(stm32_pcie->perst_gpio);
   329	
   330		/* Will be enabled in start_link when device is initialized. */
   331		irq_set_status_flags(stm32_pcie->perst_irq, IRQ_NOAUTOEN);
   332	
   333		ret = devm_request_threaded_irq(dev, stm32_pcie->perst_irq, NULL,
   334						stm32_pcie_ep_perst_irq_thread,
   335						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
   336						"perst_irq", stm32_pcie);
   337		if (ret) {
   338			pm_runtime_put_noidle(&pdev->dev);
 > 339			return dev_err_probe(dev, ret, "Failed to request PERST IRQ: %d\n");
   340		}
   341	
   342		ret = stm32_add_pcie_ep(stm32_pcie, pdev);
   343		if (ret)
   344			pm_runtime_put_noidle(&pdev->dev);
   345	
   346		return ret;
   347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

