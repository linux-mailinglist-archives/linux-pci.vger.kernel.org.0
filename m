Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B859CE4B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 04:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiHWCH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiHWCH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 22:07:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9031811C10;
        Mon, 22 Aug 2022 19:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661220447; x=1692756447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4cmZW6Vu98JaUut+RBH8civw9HwCH7BhKgrjabJJBRo=;
  b=L8UpMC4VqWZA4FSBImjHRXH3ychD4rNc4f1CWqZQ0q0igLuG6lcnV6ag
   PmHQzEIfrju+6edMQXORTECgHXJFYnWI/3JSaiWDwNC9CtES5jf+spEQx
   0JfRnKTNHgXhed8OL3uEQqg8a2FhV+fZochFKg5zawKjnvgRfi3mX0ERp
   rn+7BlLmGYqZrVH3tYfbqyJH8Qepn+jx8R9thrCS5R1qAgmeY5nLLdrPI
   A9ECU7bNn92htWQ/7VAxtVDzidVAiBBFs0PwR+btLd4I2QDQMslRiZ8Cd
   dOmSeA2+dqw8c5/hOJAvr2U8B47lV+lGlluEHVD0jMG/0F4vavavDErJJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379858758"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="379858758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 19:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698506673"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 19:07:23 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQJK6-00012F-2y;
        Tue, 23 Aug 2022 02:07:22 +0000
Date:   Tue, 23 Aug 2022 10:07:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/20] PCI: dwc: Introduce generic resources getter
Message-ID: <202208230934.dgkY2hhH-lkp@intel.com>
References: <20220822184701.25246-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822184701.25246-18-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on robh/for-next linus/master v6.0-rc2 next-20220822]
[cannot apply to krzk-dt/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/PCI-dwc-Add-generic-resources-and-Baikal-T1-support/20220823-025041
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: openrisc-randconfig-r001-20220821 (https://download.01.org/0day-ci/archive/20220823/202208230934.dgkY2hhH-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/224f55689ef22eddaeb641cf793de934a60e1be9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/PCI-dwc-Add-generic-resources-and-Baikal-T1-support/20220823-025041
        git checkout 224f55689ef22eddaeb641cf793de934a60e1be9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_init':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:734:35: error: 'np' undeclared (first use in this function); did you mean 'ep'?
     734 |         ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
         |                                   ^~
         |                                   ep
   drivers/pci/controller/dwc/pcie-designware-ep.c:734:35: note: each undeclared identifier is reported only once for each function it appears in


vim +734 drivers/pci/controller/dwc/pcie-designware-ep.c

e966f7390da935e drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  678  
e966f7390da935e drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  679  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
e966f7390da935e drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  680  {
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  681  	int ret;
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  682  	void *addr;
47a062609a30d82 drivers/pci/controller/dwc/pcie-designware-ep.c Xiaowei Bao            2020-09-18  683  	u8 func_no;
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  684  	struct resource *res;
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  685  	struct pci_epc *epc;
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  686  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  687  	struct device *dev = pci->dev;
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  688  	struct platform_device *pdev = to_platform_device(dev);
e966f7390da935e drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  689  	const struct pci_epc_features *epc_features;
47a062609a30d82 drivers/pci/controller/dwc/pcie-designware-ep.c Xiaowei Bao            2020-09-18  690  	struct dw_pcie_ep_func *ep_func;
47a062609a30d82 drivers/pci/controller/dwc/pcie-designware-ep.c Xiaowei Bao            2020-09-18  691  
47a062609a30d82 drivers/pci/controller/dwc/pcie-designware-ep.c Xiaowei Bao            2020-09-18  692  	INIT_LIST_HEAD(&ep->func_list);
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  693  
224f55689ef22ed drivers/pci/controller/dwc/pcie-designware-ep.c Serge Semin            2022-08-22  694  	ret = dw_pcie_get_resources(pci);
224f55689ef22ed drivers/pci/controller/dwc/pcie-designware-ep.c Serge Semin            2022-08-22  695  	if (ret)
224f55689ef22ed drivers/pci/controller/dwc/pcie-designware-ep.c Serge Semin            2022-08-22  696  		return ret;
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  697  
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  698  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  699  	if (!res)
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  700  		return -EINVAL;
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  701  
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  702  	ep->phys_base = res->start;
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  703  	ep->addr_size = resource_size(res);
a0fd361db8e508b drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  704  
13e9d3900c20247 drivers/pci/controller/dwc/pcie-designware-ep.c Serge Semin            2022-06-24  705  	dw_pcie_version_detect(pci);
13e9d3900c20247 drivers/pci/controller/dwc/pcie-designware-ep.c Serge Semin            2022-06-24  706  
e3dc79adfac96d7 drivers/pci/controller/dwc/pcie-designware-ep.c Serge Semin            2022-06-24  707  	dw_pcie_iatu_detect(pci);
e3dc79adfac96d7 drivers/pci/controller/dwc/pcie-designware-ep.c Serge Semin            2022-06-24  708  
6be6f8529bd7f3e drivers/pci/controller/dwc/pcie-designware-ep.c Christophe JAILLET     2022-07-09  709  	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
ad4a5becc689c3f drivers/pci/dwc/pcie-designware-ep.c            Niklas Cassel          2017-12-14  710  					       GFP_KERNEL);
ad4a5becc689c3f drivers/pci/dwc/pcie-designware-ep.c            Niklas Cassel          2017-12-14  711  	if (!ep->ib_window_map)
ad4a5becc689c3f drivers/pci/dwc/pcie-designware-ep.c            Niklas Cassel          2017-12-14  712  		return -ENOMEM;
ad4a5becc689c3f drivers/pci/dwc/pcie-designware-ep.c            Niklas Cassel          2017-12-14  713  
6be6f8529bd7f3e drivers/pci/controller/dwc/pcie-designware-ep.c Christophe JAILLET     2022-07-09  714  	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
ad4a5becc689c3f drivers/pci/dwc/pcie-designware-ep.c            Niklas Cassel          2017-12-14  715  					       GFP_KERNEL);
ad4a5becc689c3f drivers/pci/dwc/pcie-designware-ep.c            Niklas Cassel          2017-12-14  716  	if (!ep->ob_window_map)
ad4a5becc689c3f drivers/pci/dwc/pcie-designware-ep.c            Niklas Cassel          2017-12-14  717  		return -ENOMEM;
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  718  
9ca17af552bcd28 drivers/pci/controller/dwc/pcie-designware-ep.c Rob Herring            2020-11-05  719  	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  720  			    GFP_KERNEL);
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  721  	if (!addr)
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  722  		return -ENOMEM;
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  723  	ep->outbound_addr = addr;
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  724  
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  725  	epc = devm_pci_epc_create(dev, &epc_ops);
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  726  	if (IS_ERR(epc)) {
b4a8a51caf7de47 drivers/pci/dwc/pcie-designware-ep.c            Gustavo Pimentel       2018-05-14  727  		dev_err(dev, "Failed to create epc device\n");
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  728  		return PTR_ERR(epc);
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  729  	}
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  730  
4e965ede1856ed6 drivers/pci/controller/dwc/pcie-designware-ep.c Gustavo Pimentel       2018-07-19  731  	ep->epc = epc;
4e965ede1856ed6 drivers/pci/controller/dwc/pcie-designware-ep.c Gustavo Pimentel       2018-07-19  732  	epc_set_drvdata(epc, ep);
4e965ede1856ed6 drivers/pci/controller/dwc/pcie-designware-ep.c Gustavo Pimentel       2018-07-19  733  
f8aed6ec624fb43 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27 @734  	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
