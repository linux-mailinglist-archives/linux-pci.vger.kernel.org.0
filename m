Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6778C794
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 16:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjH2OcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjH2OcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 10:32:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6837CC
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693319532; x=1724855532;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bKbUC7frJEONdCr40wx4Z/CyLzHeBQhegSW+hMKs8Ss=;
  b=kEfCw6XUB45DAm4Ai8fptklI45IZBaHYM+rStyGqINCLd2Bo1UXfEZ50
   MSWXZSZMJAEwJVDLnpW1WnDgc63pU4/2cA2UJSAZAVNu++vyI/17LF4l8
   ngyrbsYz9th/UlWvKfyHnWkg9b1bUjip0cB8zmUYcURwjOOGAmxrxcGgz
   VFrCF0kkZd7V4dUb3qDpM3eABmyVEXkuna2xXTTnKXiAyOc6cNGCfHkSj
   kp5xCsy83ID4BuXYsu4FSRomcGC+zlkaGfT7+1/HwLcIgSaZCe7Ik7LQN
   +xJX5uEC/8nyTkuQ+orL/crDUFSnhM8qqpQn/tKVtZ7IqzjG8EAaFkWgT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355703396"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="355703396"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="1069481405"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1069481405"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2023 07:31:34 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qazkL-0008oD-0p;
        Tue, 29 Aug 2023 14:31:14 +0000
Date:   Tue, 29 Aug 2023 22:30:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [pci:controller/qcom-ep 3/3]
 drivers/pci/controller/dwc/pcie-qcom-ep.c:198: warning: Function parameter
 or member 'icc_mem' not described in 'qcom_pcie_ep'
Message-ID: <202308292252.HNCCTM4u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom-ep
head:   0c104996e6a856536e311c6fee66d8099c5c6c7b
commit: 0c104996e6a856536e311c6fee66d8099c5c6c7b [3/3] PCI: qcom-ep: Add ICC bandwidth voting support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230829/202308292252.HNCCTM4u-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308292252.HNCCTM4u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308292252.HNCCTM4u-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom-ep.c:198: warning: Function parameter or member 'icc_mem' not described in 'qcom_pcie_ep'


vim +198 drivers/pci/controller/dwc/pcie-qcom-ep.c

f55fee56a63103 Manivannan Sadhasivam     2021-09-20  150  
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  151  /**
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  152   * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  153   * @pci: Designware PCIe controller struct
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  154   * @parf: Qualcomm PCIe specific PARF register base
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  155   * @elbi: Designware PCIe specific ELBI register base
6dbba2b53c3bcb Manivannan Sadhasivam     2022-09-14  156   * @mmio: MMIO register base
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  157   * @perst_map: PERST regmap
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  158   * @mmio_res: MMIO region resource
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  159   * @core_reset: PCIe Endpoint core reset
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  160   * @reset: PERST# GPIO
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  161   * @wake: WAKE# GPIO
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  162   * @phy: PHY controller block
6dbba2b53c3bcb Manivannan Sadhasivam     2022-09-14  163   * @debugfs: PCIe Endpoint Debugfs directory
e2efd31465b1d9 Manivannan Sadhasivam     2022-09-14  164   * @clks: PCIe clocks
e2efd31465b1d9 Manivannan Sadhasivam     2022-09-14  165   * @num_clks: PCIe clocks count
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  166   * @perst_en: Flag for PERST enable
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  167   * @perst_sep_en: Flag for PERST separation enable
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  168   * @link_status: PCIe Link status
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  169   * @global_irq: Qualcomm PCIe specific Global IRQ
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  170   * @perst_irq: PERST# IRQ
f1bfbd000f3bc4 Manivannan Sadhasivam     2022-09-14  171   */
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  172  struct qcom_pcie_ep {
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  173  	struct dw_pcie pci;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  174  
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  175  	void __iomem *parf;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  176  	void __iomem *elbi;
6dbba2b53c3bcb Manivannan Sadhasivam     2022-09-14  177  	void __iomem *mmio;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  178  	struct regmap *perst_map;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  179  	struct resource *mmio_res;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  180  
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  181  	struct reset_control *core_reset;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  182  	struct gpio_desc *reset;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  183  	struct gpio_desc *wake;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  184  	struct phy *phy;
6dbba2b53c3bcb Manivannan Sadhasivam     2022-09-14  185  	struct dentry *debugfs;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  186  
0c104996e6a856 Krishna chaitanya chundru 2023-07-19  187  	struct icc_path *icc_mem;
0c104996e6a856 Krishna chaitanya chundru 2023-07-19  188  
e2efd31465b1d9 Manivannan Sadhasivam     2022-09-14  189  	struct clk_bulk_data *clks;
e2efd31465b1d9 Manivannan Sadhasivam     2022-09-14  190  	int num_clks;
e2efd31465b1d9 Manivannan Sadhasivam     2022-09-14  191  
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  192  	u32 perst_en;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  193  	u32 perst_sep_en;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  194  
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  195  	enum qcom_pcie_ep_link_status link_status;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  196  	int global_irq;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  197  	int perst_irq;
f55fee56a63103 Manivannan Sadhasivam     2021-09-20 @198  };
f55fee56a63103 Manivannan Sadhasivam     2021-09-20  199  

:::::: The code at line 198 was first introduced by commit
:::::: f55fee56a631032969480e4b0ee5d79734fe3c69 PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver

:::::: TO: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
