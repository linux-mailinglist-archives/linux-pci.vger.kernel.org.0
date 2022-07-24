Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3BC57F3DA
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jul 2022 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiGXICy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jul 2022 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXICx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jul 2022 04:02:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533715706;
        Sun, 24 Jul 2022 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658649772; x=1690185772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAUlyqlmn8DRqlIwM/F0ha25qVFV/n8XQ56UArsr3MI=;
  b=bdVr9buzqMzA6Y9cOztPH21ilT0sqCXjMXlPELRdfmqkGSONlC/+Sq4F
   mxmcpx44O0oqv2LbBy1OYOkYV2D3mqbfcwNpQobALyuXKY7wTlYtT3Bxi
   FGOrE9b7SpdHsYNSmvkorwFsLdsq5ux/kqGC2vG2RSOz9GEp8a1A1HU1d
   Y+IQ9+NZBIk5Uxd2jPI/2RkkY32PBrL9SPGrCulVWGybinPTwSW+2xGDs
   uA3ZPRNa5juG+eb+rIT20rv8vHODsufk54B0wZLndOk2sglmXImcpPume
   wTvnivFGau34vwK+Hz8QQYKAK2yvLPtCw+Pbl90E9YjwIlIS+ZBVkWgY8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267298194"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="267298194"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="549631966"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2022 01:02:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFWZb-0003hl-1q;
        Sun, 24 Jul 2022 08:02:47 +0000
Date:   Sun, 24 Jul 2022 16:01:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        shawnguo@kernel.org, kishon@ti.com, kw@linux.com, frank.li@nxp.com
Cc:     kbuild-all@lists.01.org, hongxing.zhu@nxp.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v1 09/10] PCI: imx6: Add iMX8MM PCIe EP mode
Message-ID: <202207241506.pe2RsQWk-lkp@intel.com>
References: <1658223939-25478-10-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658223939-25478-10-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220718]
[cannot apply to helgaas-pci/next robh/for-next char-misc/char-misc-testing v5.19-rc7 v5.19-rc6 v5.19-rc5 linus/master v5.19-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Zhu/Add-iMX-PCIe-EP-mode-support/20220719-180421
base:    036ad6daa8f0fd357af7f50f9da58539eaa6f68c
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220724/202207241506.pe2RsQWk-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1ebd36a42f9836f97d60b714e8ae000135c68576
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Zhu/Add-iMX-PCIe-EP-mode-support/20220719-180421
        git checkout 1ebd36a42f9836f97d60b714e8ae000135c68576
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pci-imx6.c: In function 'imx6_add_pcie_ep':
>> drivers/pci/controller/dwc/pci-imx6.c:1069:32: error: initialization of 'struct pcie_port *' from incompatible pointer type 'struct dw_pcie_rp *' [-Werror=incompatible-pointer-types]
    1069 |         struct pcie_port *pp = &pci->pp;
         |                                ^
   drivers/pci/controller/dwc/pci-imx6.c:1072:29: error: passing argument 1 of 'imx6_pcie_host_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1072 |         imx6_pcie_host_init(pp);
         |                             ^~
         |                             |
         |                             struct pcie_port *
   drivers/pci/controller/dwc/pci-imx6.c:925:51: note: expected 'struct dw_pcie_rp *' but argument is of type 'struct pcie_port *'
     925 | static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
         |                                ~~~~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors


vim +1069 drivers/pci/controller/dwc/pci-imx6.c

  1060	
  1061	static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
  1062				   struct platform_device *pdev)
  1063	{
  1064		int ret;
  1065		unsigned int pcie_dbi2_offset;
  1066		struct dw_pcie_ep *ep;
  1067		struct resource *res;
  1068		struct dw_pcie *pci = imx6_pcie->pci;
> 1069		struct pcie_port *pp = &pci->pp;
  1070		struct device *dev = pci->dev;
  1071	
  1072		imx6_pcie_host_init(pp);
  1073		ep = &pci->ep;
  1074		ep->ops = &pcie_ep_ops;
  1075	
  1076		switch (imx6_pcie->drvdata->variant) {
  1077		case IMX8MM_EP:
  1078			pcie_dbi2_offset = SZ_1M;
  1079			break;
  1080		default:
  1081			pcie_dbi2_offset = SZ_4K;
  1082			break;
  1083		}
  1084		pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
  1085		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
  1086		if (!res)
  1087			return -EINVAL;
  1088	
  1089		ep->phys_base = res->start;
  1090		ep->addr_size = resource_size(res);
  1091		ep->page_size = SZ_64K;
  1092	
  1093		ret = dw_pcie_ep_init(ep);
  1094		if (ret) {
  1095			dev_err(dev, "failed to initialize endpoint\n");
  1096			return ret;
  1097		}
  1098		/* Start LTSSM. */
  1099		imx6_pcie_ltssm_enable(dev);
  1100	
  1101		return 0;
  1102	}
  1103	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
