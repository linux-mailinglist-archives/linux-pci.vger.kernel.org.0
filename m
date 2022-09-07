Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C25B0E67
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 22:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIGUoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 16:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIGUoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 16:44:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3BC1F614;
        Wed,  7 Sep 2022 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662583475; x=1694119475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AxE5PxZfcCUCqW1k3Km5XnS3tRDAQpDyRdVe5GhqX40=;
  b=Eis8AgHo7RN56XDKXupNsNfp7tgV1bNqJXrnl/D8w21+xXBA3kynGJIB
   SmvxiELu3VxSnsU94nZ1Kt/ez8j6boMPmrFbFmq0qEndzuWYyJcGiWY2M
   xk933tMxeWj9y95DI4UX0LZNf6+WVfmS2GR45eb/P+O3HfU5KCuqCqQDo
   Yrzepgpozr6pQaSdu//vVDSt/JaXeDKuyXn4F07gIBZaGuq6S2Ht4KETY
   l5yKU2BPxDrx6tQlvgANGo/zFhzSCGqfc3njLrqGnNCxPfEKJJj+qrT4/
   XcFEdzxy1y8Xz10m9x0KBa3+Wn3uB4qnuXIw70SRYtkGI9e0Qunbndr8y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="360956002"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="360956002"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 13:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="617228280"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2022 13:44:29 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW1uO-0006w5-1r;
        Wed, 07 Sep 2022 20:44:28 +0000
Date:   Thu, 8 Sep 2022 04:43:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, maz@kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
        bhelgaas@google.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com,
        jdmason@kudzu.us, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        ntb@lists.linux.dev, lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v9 4/4] PCI: endpoint: Add vNTB MSI support
Message-ID: <202209080437.cNpaoZXx-lkp@intel.com>
References: <20220907034856.3101570-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907034856.3101570-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jonmason-ntb/ntb-next]
[also build test WARNING on robh/for-next linus/master v6.0-rc4 next-20220907]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220907-115114
base:   https://github.com/jonmason/ntb ntb-next
config: loongarch-randconfig-s052-20220906 (https://download.01.org/0day-ci/archive/20220908/202209080437.cNpaoZXx-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/0fe017b7ce1e4748acce80d9ddb81b3cd456adbb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220907-115114
        git checkout 0fe017b7ce1e4748acce80d9ddb81b3cd456adbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:567:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] mw_addr @@     got void * @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:567:25: sparse:     expected void [noderef] __iomem *[assigned] mw_addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:567:25: sparse:     got void *
   drivers/pci/endpoint/functions/pci-epf-vntb.c:600:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *epf_db @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:600:41: sparse:     expected void *addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:600:41: sparse:     got void [noderef] __iomem *epf_db
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1206:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1206:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1206:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1217:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1217:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1217:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1228:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1228:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1228:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1240:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1240:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1240:33: sparse:     got struct epf_ntb_ctrl *reg

vim +567 drivers/pci/endpoint/functions/pci-epf-vntb.c

0fe017b7ce1e47 Frank Li 2022-09-06  536  
e35f56bb03304a Frank Li 2022-02-22  537  /**
e35f56bb03304a Frank Li 2022-02-22  538   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
e35f56bb03304a Frank Li 2022-02-22  539   * @ntb: NTB device that facilitates communication between HOST and vHOST
e35f56bb03304a Frank Li 2022-02-22  540   */
e35f56bb03304a Frank Li 2022-02-22  541  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
e35f56bb03304a Frank Li 2022-02-22  542  {
e35f56bb03304a Frank Li 2022-02-22  543  	const struct pci_epc_features *epc_features;
e35f56bb03304a Frank Li 2022-02-22  544  	u32 align;
e35f56bb03304a Frank Li 2022-02-22  545  	struct device *dev = &ntb->epf->dev;
e35f56bb03304a Frank Li 2022-02-22  546  	int ret;
e35f56bb03304a Frank Li 2022-02-22  547  	struct pci_epf_bar *epf_bar;
e35f56bb03304a Frank Li 2022-02-22  548  	void __iomem *mw_addr;
e35f56bb03304a Frank Li 2022-02-22  549  	enum pci_barno barno;
0fe017b7ce1e47 Frank Li 2022-09-06  550  	size_t size;
e35f56bb03304a Frank Li 2022-02-22  551  
e35f56bb03304a Frank Li 2022-02-22  552  	epc_features = pci_epc_get_features(ntb->epf->epc,
e35f56bb03304a Frank Li 2022-02-22  553  					    ntb->epf->func_no,
e35f56bb03304a Frank Li 2022-02-22  554  					    ntb->epf->vfunc_no);
e35f56bb03304a Frank Li 2022-02-22  555  	align = epc_features->align;
0fe017b7ce1e47 Frank Li 2022-09-06  556  	size = epf_ntb_db_size(ntb);
e35f56bb03304a Frank Li 2022-02-22  557  
e35f56bb03304a Frank Li 2022-02-22  558  	barno = ntb->epf_ntb_bar[BAR_DB];
0fe017b7ce1e47 Frank Li 2022-09-06  559  	epf_bar = &ntb->epf->bar[barno];
e35f56bb03304a Frank Li 2022-02-22  560  
0fe017b7ce1e47 Frank Li 2022-09-06  561  	if (ntb->epf_db_phys) {
0fe017b7ce1e47 Frank Li 2022-09-06  562  		mw_addr = NULL;
0fe017b7ce1e47 Frank Li 2022-09-06  563  		epf_bar->phys_addr = ntb->epf_db_phys;
0fe017b7ce1e47 Frank Li 2022-09-06  564  		epf_bar->barno = barno;
0fe017b7ce1e47 Frank Li 2022-09-06  565  		epf_bar->size = size;
0fe017b7ce1e47 Frank Li 2022-09-06  566  	} else {
e35f56bb03304a Frank Li 2022-02-22 @567  		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
e35f56bb03304a Frank Li 2022-02-22  568  		if (!mw_addr) {
0fe017b7ce1e47 Frank Li 2022-09-06  569  			dev_err(dev, "Failed to allocate door bell address\n");
e35f56bb03304a Frank Li 2022-02-22  570  			return -ENOMEM;
e35f56bb03304a Frank Li 2022-02-22  571  		}
0fe017b7ce1e47 Frank Li 2022-09-06  572  	}
e35f56bb03304a Frank Li 2022-02-22  573  
e35f56bb03304a Frank Li 2022-02-22  574  	ntb->epf_db = mw_addr;
e35f56bb03304a Frank Li 2022-02-22  575  
e35f56bb03304a Frank Li 2022-02-22  576  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
e35f56bb03304a Frank Li 2022-02-22  577  	if (ret) {
e35f56bb03304a Frank Li 2022-02-22  578  		dev_err(dev, "Doorbell BAR set failed\n");
e35f56bb03304a Frank Li 2022-02-22  579  			goto err_alloc_peer_mem;
e35f56bb03304a Frank Li 2022-02-22  580  	}
e35f56bb03304a Frank Li 2022-02-22  581  	return ret;
e35f56bb03304a Frank Li 2022-02-22  582  
e35f56bb03304a Frank Li 2022-02-22  583  err_alloc_peer_mem:
e35f56bb03304a Frank Li 2022-02-22  584  	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
e35f56bb03304a Frank Li 2022-02-22  585  	return -1;
e35f56bb03304a Frank Li 2022-02-22  586  }
e35f56bb03304a Frank Li 2022-02-22  587  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
