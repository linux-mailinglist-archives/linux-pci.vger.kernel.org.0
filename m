Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CC5965F5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 01:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiHPXUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 19:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiHPXUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 19:20:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32957333A;
        Tue, 16 Aug 2022 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660692009; x=1692228009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJeN90HVF/ei3jDxKECmS++0CA+/54+qZwuC6Tfbrcs=;
  b=ZeJxfjPXQjRBWdU3iQtUFXfpHW5lU8FVxrlixf6GQ7D3zabQlwKChLZa
   AOUz7+btav4jwCfAOh/PJweH459kk3Nuns8Ai5Z2bhaE9Th9ka+ekVV23
   KJmSHzLzEgOy8muZyxzQSMdByxD14CPaZ/mXbp1K9sRhzJLOk8tmc16yx
   2igZ0YhhopxfOpjJaXVuaLLr+GPeO5CXfjWTrsEiDzrjoYlwtAfcEoP1P
   u1erECc2LSZheetfStMk3pQ/roO5U2X2VrWnfiDnqXdJNFSNL5IDeYm6o
   cyVFBFa+KASLkQ8baACh5rpQ8p42i66qsZsDpNqNfbv4LsJaQ4Ff4im4d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354096877"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="354096877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 16:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="640224507"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2022 16:20:04 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO5qt-0000KG-1Y;
        Tue, 16 Aug 2022 23:20:03 +0000
Date:   Wed, 17 Aug 2022 07:19:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, maz@kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
        bhelgaas@google.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: Re: [PATCH v5 2/4] irqchip: Add IMX MU MSI controller driver
Message-ID: <202208170756.pO5LueSf-lkp@intel.com>
References: <20220815213936.2380439-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815213936.2380439-3-Frank.Li@nxp.com>
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

I love your patch! Yet something to improve:

[auto build test ERROR on jonmason-ntb/ntb-next]
[also build test ERROR on robh/for-next linus/master v6.0-rc1 next-20220816]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220816-131930
base:   https://github.com/jonmason/ntb ntb-next
config: arm-imx_v4_v5_defconfig (https://download.01.org/0day-ci/archive/20220817/202208170756.pO5LueSf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/71296e2ad757d90e870b2ab81f2b06b9c76e7c41
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220816-131930
        git checkout 71296e2ad757d90e870b2ab81f2b06b9c76e7c41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-imx-mu-msi.c:124:13: error: use of undeclared identifier 'irq_chip_ack_parent'
           .irq_ack = irq_chip_ack_parent,
                      ^
>> drivers/irqchip/irq-imx-mu-msi.c:127:30: error: variable has incomplete type 'struct msi_domain_ops'
   static struct msi_domain_ops imx_mu_msi_irq_ops = {
                                ^
   drivers/irqchip/irq-imx-mu-msi.c:127:15: note: forward declaration of 'struct msi_domain_ops'
   static struct msi_domain_ops imx_mu_msi_irq_ops = {
                 ^
>> drivers/irqchip/irq-imx-mu-msi.c:131:12: error: use of undeclared identifier 'MSI_FLAG_USE_DEF_DOM_OPS'
           .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
                      ^
>> drivers/irqchip/irq-imx-mu-msi.c:131:39: error: use of undeclared identifier 'MSI_FLAG_USE_DEF_CHIP_OPS'
           .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
                                                 ^
>> drivers/irqchip/irq-imx-mu-msi.c:130:31: error: variable has incomplete type 'struct msi_domain_info'
   static struct msi_domain_info imx_mu_msi_domain_info = {
                                 ^
   drivers/irqchip/irq-imx-mu-msi.c:130:15: note: forward declaration of 'struct msi_domain_info'
   static struct msi_domain_info imx_mu_msi_domain_info = {
                 ^
>> drivers/irqchip/irq-imx-mu-msi.c:203:3: error: field designator 'alloc' does not refer to any field in type 'const struct irq_domain_ops'
           .alloc  = imx_mu_msi_domain_irq_alloc,
            ^
>> drivers/irqchip/irq-imx-mu-msi.c:204:3: error: field designator 'free' does not refer to any field in type 'const struct irq_domain_ops'
           .free   = imx_mu_msi_domain_irq_free,
            ^
>> drivers/irqchip/irq-imx-mu-msi.c:241:25: error: call to undeclared function 'platform_msi_create_irq_domain'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           msi_data->msi_domain = platform_msi_create_irq_domain(
                                  ^
   drivers/irqchip/irq-imx-mu-msi.c:295:32: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
           struct imx_mu_msi *msi_data, *priv;
                                         ^
   1 warning and 8 errors generated.


vim +/irq_chip_ack_parent +124 drivers/irqchip/irq-imx-mu-msi.c

   121	
   122	static struct irq_chip imx_mu_msi_irq_chip = {
   123		.name = "MU-MSI",
 > 124		.irq_ack = irq_chip_ack_parent,
   125	};
   126	
 > 127	static struct msi_domain_ops imx_mu_msi_irq_ops = {
   128	};
   129	
 > 130	static struct msi_domain_info imx_mu_msi_domain_info = {
 > 131		.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
   132		.ops	= &imx_mu_msi_irq_ops,
   133		.chip	= &imx_mu_msi_irq_chip,
   134	};
   135	
   136	static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
   137						  struct msi_msg *msg)
   138	{
   139		struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
   140		u64 addr = msi_data->msiir_addr + 4 * data->hwirq;
   141	
   142		msg->address_hi = upper_32_bits(addr);
   143		msg->address_lo = lower_32_bits(addr);
   144		msg->data = data->hwirq;
   145	}
   146	
   147	static int imx_mu_msi_parent_set_affinity(struct irq_data *irq_data,
   148					   const struct cpumask *mask, bool force)
   149	{
   150		return -EINVAL;
   151	}
   152	
   153	static struct irq_chip imx_mu_msi_parent_chip = {
   154		.name		= "MU",
   155		.irq_mask	= imx_mu_msi_parent_mask_irq,
   156		.irq_unmask	= imx_mu_msi_parent_unmask_irq,
   157		.irq_ack	= imx_mu_msi_parent_ack_irq,
   158		.irq_compose_msi_msg	= imx_mu_msi_parent_compose_msg,
   159		.irq_set_affinity = imx_mu_msi_parent_set_affinity,
   160	};
   161	
   162	static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
   163						unsigned int virq,
   164						unsigned int nr_irqs,
   165						void *args)
   166	{
   167		struct imx_mu_msi *msi_data = domain->host_data;
   168		unsigned long flags;
   169		int pos, err = 0;
   170	
   171		WARN_ON(nr_irqs != 1);
   172	
   173		spin_lock_irqsave(&msi_data->lock, flags);
   174		pos = find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
   175		if (pos < IMX_MU_CHANS)
   176			__set_bit(pos, &msi_data->used);
   177		else
   178			err = -ENOSPC;
   179		spin_unlock_irqrestore(&msi_data->lock, flags);
   180	
   181		if (err)
   182			return err;
   183	
   184		irq_domain_set_info(domain, virq, pos,
   185				    &imx_mu_msi_parent_chip, msi_data,
   186				    handle_edge_irq, NULL, NULL);
   187		return 0;
   188	}
   189	
   190	static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
   191					       unsigned int virq, unsigned int nr_irqs)
   192	{
   193		struct irq_data *d = irq_domain_get_irq_data(domain, virq);
   194		struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(d);
   195		unsigned long flags;
   196	
   197		spin_lock_irqsave(&msi_data->lock, flags);
   198		__clear_bit(d->hwirq, &msi_data->used);
   199		spin_unlock_irqrestore(&msi_data->lock, flags);
   200	}
   201	
   202	static const struct irq_domain_ops imx_mu_msi_domain_ops = {
 > 203		.alloc	= imx_mu_msi_domain_irq_alloc,
 > 204		.free	= imx_mu_msi_domain_irq_free,
   205	};
   206	
   207	static void imx_mu_msi_irq_handler(struct irq_desc *desc)
   208	{
   209		struct imx_mu_msi *msi_data = irq_desc_get_handler_data(desc);
   210		struct irq_chip *chip = irq_desc_get_chip(desc);
   211		u32 status;
   212		int i;
   213	
   214		status = imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
   215	
   216		chained_irq_enter(chip, desc);
   217		for (i = 0; i < IMX_MU_CHANS; i++) {
   218			if (status & IMX_MU_xSR_RFn(msi_data, i))
   219				generic_handle_domain_irq(msi_data->msi_domain, i);
   220		}
   221		chained_irq_exit(chip, desc);
   222	}
   223	
   224	static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
   225	{
   226		struct fwnode_handle *fwnodes = dev_fwnode(dev);
   227		struct irq_domain *parent;
   228	
   229		/* Initialize MSI domain parent */
   230		parent = irq_domain_create_linear(fwnodes,
   231						    IMX_MU_CHANS,
   232						    &imx_mu_msi_domain_ops,
   233						    msi_data);
   234		if (!parent) {
   235			dev_err(dev, "failed to create IRQ domain\n");
   236			return -ENOMEM;
   237		}
   238	
   239		irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
   240	
 > 241		msi_data->msi_domain = platform_msi_create_irq_domain(
   242					fwnodes,
   243					&imx_mu_msi_domain_info,
   244					parent);
   245	
   246		if (!msi_data->msi_domain) {
   247			dev_err(dev, "failed to create MSI domain\n");
   248			irq_domain_remove(parent);
   249			return -ENOMEM;
   250		}
   251	
   252		irq_domain_set_pm_device(msi_data->msi_domain, dev);
   253	
   254		return 0;
   255	}
   256	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
