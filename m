Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA459CD4D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 02:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiHWAq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 20:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbiHWAqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 20:46:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448154B4BF;
        Mon, 22 Aug 2022 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661215583; x=1692751583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k4k4gsNd5k3zq1HDQ+xAymdp/CfQzCncB8UUoV7WRQw=;
  b=FFNOzbxUQ58HC+wTgqDroaFV2yMgfI+3jMwV8bSlsMDzTpr1xsquy4CX
   kqr0uBQ6v1jTPY3H97AgYnMYWDrWd1n03HCf4oDwm2vk4pkDxki/M5PAr
   sQNE5AHRMiB/KBLulBhWtMZdpNJ6oU1Ig4TRnIIncFGP9beRjHrkO2FAf
   LYLiKvHKFd63bsHqPMtHCWhOgZswDrW1KtpalQ0vCV1dQrYjfVMhe/TG5
   Qeemuxrz9eSViWxHxyDbhK8k0uEfdd/LesRZX+BdohCiDGA5mT9JqFQ4c
   w0Z/8E3toxtI/7Z6KWnit34pNSDVW/d+7CFedYfGBOXpaz4RMF4x2tf92
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357538089"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="357538089"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 17:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="751491576"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 17:46:18 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQI3d-0000vD-12;
        Tue, 23 Aug 2022 00:46:17 +0000
Date:   Tue, 23 Aug 2022 08:45:38 +0800
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
        ntb@lists.linux.dev, lznuaa@gmail.com
Subject: Re: [PATCH v7 4/4] PCI: endpoint: Add NTB MSI support
Message-ID: <202208230844.D25Fw8sg-lkp@intel.com>
References: <20220822155130.2491006-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822155130.2491006-5-Frank.Li@nxp.com>
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
[also build test WARNING on robh/for-next linus/master v6.0-rc2 next-20220822]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220822-235323
base:   https://github.com/jonmason/ntb ntb-next
config: s390-randconfig-s053-20220821 (https://download.01.org/0day-ci/archive/20220823/202208230844.D25Fw8sg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d98704aefa5b57814d7b9b1b40160df34977b2b6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220822-235323
        git checkout d98704aefa5b57814d7b9b1b40160df34977b2b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/endpoint/functions/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:567:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] mw_addr @@     got void * @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:567:25: sparse:     expected void [noderef] __iomem *[assigned] mw_addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:567:25: sparse:     got void *
   drivers/pci/endpoint/functions/pci-epf-vntb.c:600:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *epf_db @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:600:41: sparse:     expected void *addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:600:41: sparse:     got void [noderef] __iomem *epf_db
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1201:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1201:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1201:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1212:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1212:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1212:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1223:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1223:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1223:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1235:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1235:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1235:33: sparse:     got struct epf_ntb_ctrl *reg

vim +567 drivers/pci/endpoint/functions/pci-epf-vntb.c

d98704aefa5b578 Frank Li 2022-08-22  536  
e35f56bb03304ab Frank Li 2022-02-22  537  /**
e35f56bb03304ab Frank Li 2022-02-22  538   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
e35f56bb03304ab Frank Li 2022-02-22  539   * @ntb: NTB device that facilitates communication between HOST and vHOST
e35f56bb03304ab Frank Li 2022-02-22  540   */
e35f56bb03304ab Frank Li 2022-02-22  541  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
e35f56bb03304ab Frank Li 2022-02-22  542  {
e35f56bb03304ab Frank Li 2022-02-22  543  	const struct pci_epc_features *epc_features;
e35f56bb03304ab Frank Li 2022-02-22  544  	u32 align;
e35f56bb03304ab Frank Li 2022-02-22  545  	struct device *dev = &ntb->epf->dev;
e35f56bb03304ab Frank Li 2022-02-22  546  	int ret;
e35f56bb03304ab Frank Li 2022-02-22  547  	struct pci_epf_bar *epf_bar;
e35f56bb03304ab Frank Li 2022-02-22  548  	void __iomem *mw_addr;
e35f56bb03304ab Frank Li 2022-02-22  549  	enum pci_barno barno;
d98704aefa5b578 Frank Li 2022-08-22  550  	size_t size;
e35f56bb03304ab Frank Li 2022-02-22  551  
e35f56bb03304ab Frank Li 2022-02-22  552  	epc_features = pci_epc_get_features(ntb->epf->epc,
e35f56bb03304ab Frank Li 2022-02-22  553  					    ntb->epf->func_no,
e35f56bb03304ab Frank Li 2022-02-22  554  					    ntb->epf->vfunc_no);
e35f56bb03304ab Frank Li 2022-02-22  555  	align = epc_features->align;
d98704aefa5b578 Frank Li 2022-08-22  556  	size = epf_ntb_db_size(ntb);
e35f56bb03304ab Frank Li 2022-02-22  557  
e35f56bb03304ab Frank Li 2022-02-22  558  	barno = ntb->epf_ntb_bar[BAR_DB];
d98704aefa5b578 Frank Li 2022-08-22  559  	epf_bar = &ntb->epf->bar[barno];
e35f56bb03304ab Frank Li 2022-02-22  560  
d98704aefa5b578 Frank Li 2022-08-22  561  	if (ntb->epf_db_phy) {
d98704aefa5b578 Frank Li 2022-08-22  562  		mw_addr = NULL;
d98704aefa5b578 Frank Li 2022-08-22  563  		epf_bar->phys_addr = ntb->epf_db_phy;
d98704aefa5b578 Frank Li 2022-08-22  564  		epf_bar->barno = barno;
d98704aefa5b578 Frank Li 2022-08-22  565  		epf_bar->size = size;
d98704aefa5b578 Frank Li 2022-08-22  566  	} else {
e35f56bb03304ab Frank Li 2022-02-22 @567  		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
e35f56bb03304ab Frank Li 2022-02-22  568  		if (!mw_addr) {
e35f56bb03304ab Frank Li 2022-02-22  569  			dev_err(dev, "Failed to allocate OB address\n");
e35f56bb03304ab Frank Li 2022-02-22  570  			return -ENOMEM;
e35f56bb03304ab Frank Li 2022-02-22  571  		}
d98704aefa5b578 Frank Li 2022-08-22  572  	}
e35f56bb03304ab Frank Li 2022-02-22  573  
e35f56bb03304ab Frank Li 2022-02-22  574  	ntb->epf_db = mw_addr;
e35f56bb03304ab Frank Li 2022-02-22  575  
e35f56bb03304ab Frank Li 2022-02-22  576  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
e35f56bb03304ab Frank Li 2022-02-22  577  	if (ret) {
e35f56bb03304ab Frank Li 2022-02-22  578  		dev_err(dev, "Doorbell BAR set failed\n");
e35f56bb03304ab Frank Li 2022-02-22  579  			goto err_alloc_peer_mem;
e35f56bb03304ab Frank Li 2022-02-22  580  	}
e35f56bb03304ab Frank Li 2022-02-22  581  	return ret;
e35f56bb03304ab Frank Li 2022-02-22  582  
e35f56bb03304ab Frank Li 2022-02-22  583  err_alloc_peer_mem:
e35f56bb03304ab Frank Li 2022-02-22  584  	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
e35f56bb03304ab Frank Li 2022-02-22  585  	return -1;
e35f56bb03304ab Frank Li 2022-02-22  586  }
e35f56bb03304ab Frank Li 2022-02-22  587  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
