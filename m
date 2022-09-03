Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B40D5ABC5E
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 04:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiICChp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiICCho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 22:37:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67768E9900;
        Fri,  2 Sep 2022 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662172663; x=1693708663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBINxE2RmRTTnJion59Lq21Ezb2oZIYPD4zBMbfH++g=;
  b=ffpxRBevovi4KGrRpnofAPgzop3T4uVqmU6r7b30s1PnhYXuv2v0HUtP
   aw2IXlqnA2/9y30hY4zZJRAjj8KkQqek0FVEege5zEv+BCO7h21RsinEh
   VM4XDxVujM2pP6v4Cok84qzTMBbujT6c/w7TxFNI78qKHy/lWlM1ctOW3
   oYS5J3CzelRsVUAfyHIEbbGaMTrOPAsab9UdxVcYnbfNvUQFcONefJnhm
   tTGHEcqEDeTV5wqUJWXAOpU8uPZECXbqmuVf9gjy8S9rfbKQALwI8//U9
   TruUFDIon/9SVFeqWoC41G4OUh9QH1uzr/D2vhp8ecvWi3Ts+BfgscLVs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="360080007"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="360080007"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 19:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="646316339"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2022 19:37:39 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUJ2R-0000uM-0o;
        Sat, 03 Sep 2022 02:37:39 +0000
Date:   Sat, 3 Sep 2022 10:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kbuild-all@lists.01.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 04/11] PCI: qcom-ep: Add eDMA support
Message-ID: <202209031046.rOZKOVqT-lkp@intel.com>
References: <20220830165817.183571-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830165817.183571-5-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[cannot apply to helgaas-pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/Improvements-to-the-Qcom-PCIe-Endpoint-driver/20220831-010315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209031046.rOZKOVqT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dec4c93b2077408cecddd53950905bf2411019b0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manivannan-Sadhasivam/Improvements-to-the-Qcom-PCIe-Endpoint-driver/20220831-010315
        git checkout dec4c93b2077408cecddd53950905bf2411019b0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom-ep.c: In function 'qcom_pcie_ep_probe':
>> drivers/pci/controller/dwc/pcie-qcom-ep.c:672:21: error: 'struct dw_pcie' has no member named 'edma'
     672 |         pcie_ep->pci.edma.nr_irqs = 1;
         |                     ^


vim +672 drivers/pci/controller/dwc/pcie-qcom-ep.c

   658	
   659	static int qcom_pcie_ep_probe(struct platform_device *pdev)
   660	{
   661		struct device *dev = &pdev->dev;
   662		struct qcom_pcie_ep *pcie_ep;
   663		int ret;
   664	
   665		pcie_ep = devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
   666		if (!pcie_ep)
   667			return -ENOMEM;
   668	
   669		pcie_ep->pci.dev = dev;
   670		pcie_ep->pci.ops = &pci_ops;
   671		pcie_ep->pci.ep.ops = &pci_ep_ops;
 > 672		pcie_ep->pci.edma.nr_irqs = 1;
   673		platform_set_drvdata(pdev, pcie_ep);
   674	
   675		ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
   676		if (ret)
   677			return ret;
   678	
   679		ret = qcom_pcie_enable_resources(pcie_ep);
   680		if (ret) {
   681			dev_err(dev, "Failed to enable resources: %d\n", ret);
   682			return ret;
   683		}
   684	
   685		ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
   686		if (ret) {
   687			dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
   688			goto err_disable_resources;
   689		}
   690	
   691		ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
   692		if (ret)
   693			goto err_disable_resources;
   694	
   695		return 0;
   696	
   697	err_disable_resources:
   698		qcom_pcie_disable_resources(pcie_ep);
   699	
   700		return ret;
   701	}
   702	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
