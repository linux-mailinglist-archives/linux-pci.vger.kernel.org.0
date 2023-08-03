Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0D76F392
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHCTkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjHCTkw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 15:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDC3C3E;
        Thu,  3 Aug 2023 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691091650; x=1722627650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J5BmdgRwqzUiKNIDnRcFwp1joEXUv/AmCXQNT0e8s+s=;
  b=GFY5cwLu7ZSK4PNbo9FmUx951h1wkSWm4CjbtMrRS40+MigXjB5pMh/d
   zBr737Xqpn03MtXjVh82vkvCkt+C2pY7ZjN60rHsGvtrGtqS6tQHfbiQW
   ybnKGH1hYYcB0UkxmGNFKtS76eq31QXS4TgoXwOrx0/1TnjBhu6oROTA8
   bDMbKCYfnTJ+i2eou5o3WbuzhNuNwp+pJeqGJxZAFflyeYg4O2UYGwEle
   Npr6dTeBIq5dqrRDQvB5zSOaqyw2ExE1fJUSdbLYrEM0is8ziYnCGd2wg
   gLKKfvU3HXtmimQ9NgVdIAZsjdG5BOU/cPpJRCI6YlWs9GJkgEw6C+dQB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368881704"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="368881704"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 12:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060437128"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="1060437128"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2023 12:40:46 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qReBh-0002Jj-34;
        Thu, 03 Aug 2023 19:40:45 +0000
Date:   Fri, 4 Aug 2023 03:39:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski@linaro.org,
        lpieralisi@kernel.org, bharat.kumar.gogada@amd.com,
        michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: Re: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating
 ecam default value.
Message-ID: <202308040330.eMTjX3tF-lkp@intel.com>
References: <20230803115016.4266-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803115016.4266-1-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thippeswamy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.5-rc4 next-20230803]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thippeswamy-Havalige/PCI-xilinx-nwl-Remove-unnecessary-code-and-updating-ecam-default-value/20230803-195228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230803115016.4266-1-thippeswamy.havalige%40amd.com
patch subject: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating ecam default value.
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230804/202308040330.eMTjX3tF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230804/202308040330.eMTjX3tF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308040330.eMTjX3tF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/pcie-xilinx-nwl.c: In function 'nwl_pcie_bridge_init':
>> drivers/pci/controller/pcie-xilinx-nwl.c:628:33: warning: unused variable 'first_busno' [-Wunused-variable]
     628 |         u32 breg_val, ecam_val, first_busno = 0;
         |                                 ^~~~~~~~~~~


vim +/first_busno +628 drivers/pci/controller/pcie-xilinx-nwl.c

ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  623  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  624  static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  625  {
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  626  	struct device *dev = pcie->dev;
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  627  	struct platform_device *pdev = to_platform_device(dev);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06 @628  	u32 breg_val, ecam_val, first_busno = 0;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  629  	int err;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  630  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  631  	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  632  	if (!breg_val) {
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  633  		dev_err(dev, "BREG is not present\n");
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  634  		return breg_val;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  635  	}
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  636  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  637  	/* Write bridge_off to breg base */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  638  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_breg_base),
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  639  			  E_BREG_BASE_LO);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  640  	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_breg_base),
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  641  			  E_BREG_BASE_HI);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  642  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  643  	/* Enable BREG */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  644  	nwl_bridge_writel(pcie, ~BREG_ENABLE_FORCE & BREG_ENABLE,
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  645  			  E_BREG_CONTROL);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  646  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  647  	/* Disable DMA channel registers */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  648  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX0) |
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  649  			  CFG_DMA_REG_BAR, BRCFG_PCIE_RX0);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  650  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  651  	/* Enable Ingress subtractive decode translation */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  652  	nwl_bridge_writel(pcie, SET_ISUB_CONTROL, I_ISUB_CONTROL);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  653  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  654  	/* Enable msg filtering details */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  655  	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  656  			  BRCFG_PCIE_RX_MSG_FILTER);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  657  
213e1220523288 drivers/pci/controller/pcie-xilinx-nwl.c Bharat Kumar Gogada  2021-02-22  658  	/* This routes the PCIe DMA traffic to go through CCI path */
213e1220523288 drivers/pci/controller/pcie-xilinx-nwl.c Bharat Kumar Gogada  2021-02-22  659  	if (of_dma_is_coherent(dev->of_node))
213e1220523288 drivers/pci/controller/pcie-xilinx-nwl.c Bharat Kumar Gogada  2021-02-22  660  		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
213e1220523288 drivers/pci/controller/pcie-xilinx-nwl.c Bharat Kumar Gogada  2021-02-22  661  				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
213e1220523288 drivers/pci/controller/pcie-xilinx-nwl.c Bharat Kumar Gogada  2021-02-22  662  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  663  	err = nwl_wait_for_link(pcie);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  664  	if (err)
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  665  		return err;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  666  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  667  	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) & E_ECAM_PRESENT;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  668  	if (!ecam_val) {
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  669  		dev_err(dev, "ECAM is not present\n");
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  670  		return ecam_val;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  671  	}
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  672  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  673  	/* Enable ECAM */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  674  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  675  			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  676  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  677  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  678  			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  679  			  E_ECAM_CONTROL);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  680  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  681  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  682  			  E_ECAM_BASE_LO);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  683  	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  684  			  E_ECAM_BASE_HI);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  685  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  686  	if (nwl_pcie_link_up(pcie))
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  687  		dev_info(dev, "Link is UP\n");
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  688  	else
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  689  		dev_info(dev, "Link is DOWN\n");
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  690  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  691  	/* Get misc IRQ number */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  692  	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
caecb05c800081 drivers/pci/controller/pcie-xilinx-nwl.c Krzysztof Wilczyński 2020-08-02  693  	if (pcie->irq_misc < 0)
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  694  		return -EINVAL;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  695  
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  696  	err = devm_request_irq(dev, pcie->irq_misc,
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  697  			       nwl_pcie_misc_handler, IRQF_SHARED,
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  698  			       "nwl_pcie:misc", pcie);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  699  	if (err) {
adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas        2016-10-06  700  		dev_err(dev, "fail to register misc IRQ#%d\n",
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  701  			pcie->irq_misc);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  702  		return err;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  703  	}
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  704  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  705  	/* Disable all misc interrupts */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  706  	nwl_bridge_writel(pcie, (u32)~MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  707  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  708  	/* Clear pending misc interrupts */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  709  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_MISC_STATUS) &
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  710  			  MSGF_MISC_SR_MASKALL, MSGF_MISC_STATUS);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  711  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  712  	/* Enable all misc interrupts */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  713  	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  714  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  715  	/* Disable all legacy interrupts */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  716  	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  717  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  718  	/* Clear pending legacy interrupts */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  719  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  720  			  MSGF_LEG_SR_MASKALL, MSGF_LEG_STATUS);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  721  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  722  	/* Enable all legacy interrupts */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  723  	nwl_bridge_writel(pcie, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  724  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  725  	/* Enable the bridge config interrupt */
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  726  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_INTERRUPT) |
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  727  			  BRCFG_INTERRUPT_MASK, BRCFG_INTERRUPT);
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  728  
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  729  	return 0;
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  730  }
ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada  2016-03-06  731  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
