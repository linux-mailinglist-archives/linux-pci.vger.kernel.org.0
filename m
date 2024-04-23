Return-Path: <linux-pci+bounces-6600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A248AFC38
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 00:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E08281C45
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCF2E644;
	Tue, 23 Apr 2024 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kx4VgeKk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81DB1DFF5;
	Tue, 23 Apr 2024 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912716; cv=none; b=WodrYjJDlGwunCzi+H6CovYVqSbnyBZQeFO+UZ6KJgB2VSyiz7Xw3/OyTN8VeKOpiRtDfthhtORjZ9Gg2mGQ8a2SB1ot3mHubXapXemwPbx9WWSX8wbCO26T4cEfymqbWhOruGdDO5RUBHjnz5yQvsoksHRk/PgrpfbOFlbbEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912716; c=relaxed/simple;
	bh=mznsmpZGIdBKgMqGdAUj/EZ/hJtwZ06FnB1V1izwzhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBciHailmIM0kGV4e4uuKp30gSF1G59LV8rCYgGyAROUDwBpxVzzG1FnKOsiXI03SUNW5VmSgN0qCIEBWsiyW5r86391b08hONq1x4oKPjqkj8iJgY0zTz1PSYaJ/r+5JZa2iniZkkZogdJkbJb3KMkjIm/9jsAlsziizBnNvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kx4VgeKk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713912715; x=1745448715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mznsmpZGIdBKgMqGdAUj/EZ/hJtwZ06FnB1V1izwzhk=;
  b=Kx4VgeKkNxUDhwSSr1P5TK7L9c7iPhqght2SeA9sQy/5ZQ6zZ+kh7Azu
   1yWtY0sL8eTQjaOnquRCscduSsiSFTjsoXtBWFoOVDZk2UynHSBIPCZrG
   lWJMqlkxFvR1TMlvETCBoXrkgxMNYwFfAqAgtKqkxnQQIxEZyjREIsZh7
   bOk9kXSj06UoLLaZLvYX9SCVXPzCyVXBSLCuE6HuZ8XJnpLaiP1+T7EkM
   zVvFdjU14k4ZZ6zoqDn+9KeYvWmW9zHeuZu1I+YWYq7FsdUY0GCnkBbsQ
   BBTOdeiuj+QMPl8gGsTQzv+Ql8S8+TQsX3RiHQbu8sXNGvjIDRysYGJol
   g==;
X-CSE-ConnectionGUID: 0PEJLf4PQtOtPHCdbj5QSw==
X-CSE-MsgGUID: he7Yf4VqQKymEDjCFAqxpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20218389"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20218389"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 15:51:54 -0700
X-CSE-ConnectionGUID: 4vpTSJ/BT0WzosPs6zKsoA==
X-CSE-MsgGUID: lwCZffPLR/SpYCqnMxTVow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24557021"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Apr 2024 15:51:47 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzOzI-0000bA-2C;
	Tue, 23 Apr 2024 22:51:44 +0000
Date: Wed, 24 Apr 2024 06:51:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>
Subject: Re: [PATCH v2 2/4] PCI: dwc: Remove unused of_gpio.h
Message-ID: <202404240649.QgY8lto8-lkp@intel.com>
References: <20240423172208.2723892-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423172208.2723892-3-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.9-rc5 next-20240423]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/PCI-aardvark-Remove-unused-of_gpio-h/20240424-012448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240423172208.2723892-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 2/4] PCI: dwc: Remove unused of_gpio.h
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240424/202404240649.QgY8lto8-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404240649.QgY8lto8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404240649.QgY8lto8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pci-dra7xx.c:262:2: error: implicit declaration of function 'chained_irq_enter' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           chained_irq_enter(chip, desc);
           ^
>> drivers/pci/controller/dwc/pci-dra7xx.c:284:2: error: implicit declaration of function 'chained_irq_exit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           chained_irq_exit(chip, desc);
           ^
   drivers/pci/controller/dwc/pci-dra7xx.c:284:2: note: did you mean 'chained_irq_enter'?
   drivers/pci/controller/dwc/pci-dra7xx.c:262:2: note: 'chained_irq_enter' declared here
           chained_irq_enter(chip, desc);
           ^
   2 errors generated.


vim +/chained_irq_enter +262 drivers/pci/controller/dwc/pci-dra7xx.c

47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  252  
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  253  static void dra7xx_pcie_msi_irq_handler(struct irq_desc *desc)
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  254  {
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  255  	struct irq_chip *chip = irq_desc_get_chip(desc);
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  256  	struct dra7xx_pcie *dra7xx;
60b3c27fb9b92b drivers/pci/controller/dwc/pci-dra7xx.c Serge Semin            2022-06-24  257  	struct dw_pcie_rp *pp;
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  258  	struct dw_pcie *pci;
09b2d20349e37a drivers/pci/dwc/pci-dra7xx.c            Vignesh R              2017-12-29  259  	unsigned long reg;
d21faba11693c1 drivers/pci/controller/dwc/pci-dra7xx.c Marc Zyngier           2021-08-02  260  	u32 bit;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  261  
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27 @262  	chained_irq_enter(chip, desc);
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  263  
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  264  	pp = irq_desc_get_handler_data(desc);
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  265  	pci = to_dw_pcie_from_pp(pp);
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  266  	dra7xx = to_dra7xx_pcie(pci);
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  267  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  268  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  269  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  270  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  271  	switch (reg) {
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  272  	case MSI:
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27  273  		dra7xx_pcie_handle_msi_irq(pp);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  274  		break;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  275  	case INTA:
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  276  	case INTB:
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  277  	case INTC:
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  278  	case INTD:
d21faba11693c1 drivers/pci/controller/dwc/pci-dra7xx.c Marc Zyngier           2021-08-02  279  		for_each_set_bit(bit, &reg, PCI_NUM_INTX)
d21faba11693c1 drivers/pci/controller/dwc/pci-dra7xx.c Marc Zyngier           2021-08-02  280  			generic_handle_domain_irq(dra7xx->irq_domain, bit);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  281  		break;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  282  	}
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  283  
9a5595ab21a9d1 drivers/pci/controller/dwc/pci-dra7xx.c Vignesh Raghavendra    2020-03-27 @284  	chained_irq_exit(chip, desc);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  285  }
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

