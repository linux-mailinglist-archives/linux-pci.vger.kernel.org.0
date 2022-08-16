Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1130596523
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiHPWIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 18:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbiHPWIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 18:08:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05275617A;
        Tue, 16 Aug 2022 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660687695; x=1692223695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CIVvTEuUy1sRWasLTycmVZNGrzKlq4n4vwoqF5i72BU=;
  b=h5yUXPthzn08HprYI+j62rf6Kqh2mw2QOLcc96ECQKACJjEw1V5yP2yn
   /zn7sDh+kWY7wNLgQjxLmcJPfZdUFlFtMIXFHlvJK32kMlwmWzs8pgLmu
   W0jlASM6Q0b/TIWPUc8gpJZAfuUXu1JAXjR/OyKjeZUqcQF13aXvtNMtc
   +7teHcRHLYWwnkUH1pjm+svdNrCyTtTo0OEAE7Y8lH0yKPNrgmY3lWmTb
   z7AkUmgSByq6AP0pRJGowT15JLlZWQ758jWjLQbSXl54zRN36veogPM8l
   V38Nk8er1xBbmgNK+QMJxFtCDW1Ct1gGH7vIEFI8Fj9srapRpVFPS0u4y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293614659"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293614659"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 15:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="675393543"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 15:08:02 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO4jC-0000Gr-0r;
        Tue, 16 Aug 2022 22:08:02 +0000
Date:   Wed, 17 Aug 2022 06:07:29 +0800
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
Subject: Re: [PATCH v5 2/4] irqchip: Add IMX MU MSI controller driver
Message-ID: <202208170522.PGyjHgNg-lkp@intel.com>
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
config: arm-vf610m4_defconfig (https://download.01.org/0day-ci/archive/20220817/202208170522.PGyjHgNg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/71296e2ad757d90e870b2ab81f2b06b9c76e7c41
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220816-131930
        git checkout 71296e2ad757d90e870b2ab81f2b06b9c76e7c41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-imx-mu-msi.c:127:15: error: variable 'imx_mu_msi_irq_ops' has initializer but incomplete type
     127 | static struct msi_domain_ops imx_mu_msi_irq_ops = {
         |               ^~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:130:15: error: variable 'imx_mu_msi_domain_info' has initializer but incomplete type
     130 | static struct msi_domain_info imx_mu_msi_domain_info = {
         |               ^~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:131:10: error: 'struct msi_domain_info' has no member named 'flags'
     131 |         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
         |          ^~~~~
   drivers/irqchip/irq-imx-mu-msi.c:131:20: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
     131 |         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:131:47: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
     131 |         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:131:19: warning: excess elements in struct initializer
     131 |         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
         |                   ^
   drivers/irqchip/irq-imx-mu-msi.c:131:19: note: (near initialization for 'imx_mu_msi_domain_info')
   drivers/irqchip/irq-imx-mu-msi.c:132:10: error: 'struct msi_domain_info' has no member named 'ops'
     132 |         .ops    = &imx_mu_msi_irq_ops,
         |          ^~~
   drivers/irqchip/irq-imx-mu-msi.c:132:19: warning: excess elements in struct initializer
     132 |         .ops    = &imx_mu_msi_irq_ops,
         |                   ^
   drivers/irqchip/irq-imx-mu-msi.c:132:19: note: (near initialization for 'imx_mu_msi_domain_info')
   drivers/irqchip/irq-imx-mu-msi.c:133:10: error: 'struct msi_domain_info' has no member named 'chip'
     133 |         .chip   = &imx_mu_msi_irq_chip,
         |          ^~~~
   drivers/irqchip/irq-imx-mu-msi.c:133:19: warning: excess elements in struct initializer
     133 |         .chip   = &imx_mu_msi_irq_chip,
         |                   ^
   drivers/irqchip/irq-imx-mu-msi.c:133:19: note: (near initialization for 'imx_mu_msi_domain_info')
   drivers/irqchip/irq-imx-mu-msi.c: In function 'imx_mu_msi_domains_init':
   drivers/irqchip/irq-imx-mu-msi.c:241:32: error: implicit declaration of function 'platform_msi_create_irq_domain' [-Werror=implicit-function-declaration]
     241 |         msi_data->msi_domain = platform_msi_create_irq_domain(
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:241:30: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     241 |         msi_data->msi_domain = platform_msi_create_irq_domain(
         |                              ^
   drivers/irqchip/irq-imx-mu-msi.c: In function 'imx_mu_of_init':
>> drivers/irqchip/irq-imx-mu-msi.c:295:39: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
     295 |         struct imx_mu_msi *msi_data, *priv;
         |                                       ^~~~
   drivers/irqchip/irq-imx-mu-msi.c: At top level:
>> drivers/irqchip/irq-imx-mu-msi.c:127:30: error: storage size of 'imx_mu_msi_irq_ops' isn't known
     127 | static struct msi_domain_ops imx_mu_msi_irq_ops = {
         |                              ^~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:130:31: error: storage size of 'imx_mu_msi_domain_info' isn't known
     130 | static struct msi_domain_info imx_mu_msi_domain_info = {
         |                               ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/imx_mu_msi_irq_ops +127 drivers/irqchip/irq-imx-mu-msi.c

   126	
 > 127	static struct msi_domain_ops imx_mu_msi_irq_ops = {
   128	};
   129	
   130	static struct msi_domain_info imx_mu_msi_domain_info = {
   131		.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
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
   203		.alloc	= imx_mu_msi_domain_irq_alloc,
   204		.free	= imx_mu_msi_domain_irq_free,
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
   241		msi_data->msi_domain = platform_msi_create_irq_domain(
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
   257	/* Register offset of different version MU IP */
   258	static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
   259		.xTR    = 0x0,
   260		.xRR    = 0x10,
   261		.xSR    = {0x20, 0x20, 0x20, 0x20},
   262		.xCR    = {0x24, 0x24, 0x24, 0x24},
   263	};
   264	
   265	static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
   266		.xTR    = 0x20,
   267		.xRR    = 0x40,
   268		.xSR    = {0x60, 0x60, 0x60, 0x60},
   269		.xCR    = {0x64, 0x64, 0x64, 0x64},
   270	};
   271	
   272	static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
   273		.type   = IMX_MU_V2,
   274		.xTR    = 0x200,
   275		.xRR    = 0x280,
   276		.xSR    = {0xC, 0x118, 0x124, 0x12C},
   277		.xCR    = {0x110, 0x114, 0x120, 0x128},
   278	};
   279	
   280	static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
   281	
   282		.type   = IMX_MU_V2 | IMX_MU_V2_S4,
   283		.xTR    = 0x200,
   284		.xRR    = 0x280,
   285		.xSR    = {0xC, 0x118, 0x124, 0x12C},
   286		.xCR    = {0x110, 0x114, 0x120, 0x128},
   287	};
   288	
   289	static int __init imx_mu_of_init(struct device_node *dn,
   290					 struct device_node *parent,
   291					 const struct imx_mu_dcfg *cfg
   292					)
   293	{
   294		struct platform_device *pdev = of_find_device_by_node(dn);
 > 295		struct imx_mu_msi *msi_data, *priv;
   296		struct device_link *pd_link_a;
   297		struct device_link *pd_link_b;
   298		struct resource *res;
   299		struct device *pd_a;
   300		struct device *pd_b;
   301		struct device *dev;
   302		int ret;
   303		int irq;
   304	
   305		if (!pdev)
   306			return -ENODEV;
   307	
   308		dev = &pdev->dev;
   309	
   310		priv = msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
   311		if (!msi_data)
   312			return -ENOMEM;
   313	
   314		msi_data->cfg = cfg;
   315	
   316		msi_data->regs = devm_platform_ioremap_resource_byname(pdev, "processor a-facing");
   317		if (IS_ERR(msi_data->regs)) {
   318			dev_err(&pdev->dev, "failed to initialize 'regs'\n");
   319			return PTR_ERR(msi_data->regs);
   320		}
   321	
   322		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "processor b-facing");
   323		if (!res)
   324			return -EIO;
   325	
   326		msi_data->msiir_addr = res->start + msi_data->cfg->xTR;
   327	
   328		irq = platform_get_irq(pdev, 0);
   329		if (irq <= 0)
   330			return -ENODEV;
   331	
   332		platform_set_drvdata(pdev, msi_data);
   333	
   334		msi_data->clk = devm_clk_get(dev, NULL);
   335		if (IS_ERR(msi_data->clk)) {
   336			if (PTR_ERR(msi_data->clk) != -ENOENT)
   337				return PTR_ERR(msi_data->clk);
   338	
   339			msi_data->clk = NULL;
   340		}
   341	
   342		pd_a = dev_pm_domain_attach_by_name(dev, "processor a-facing");
   343		if (IS_ERR(pd_a))
   344			return PTR_ERR(pd_a);
   345	
   346		pd_b = dev_pm_domain_attach_by_name(dev, "processor b-facing");
   347		if (IS_ERR(pd_b))
   348			return PTR_ERR(pd_b);
   349	
   350		pd_link_a = device_link_add(dev, pd_a,
   351				DL_FLAG_STATELESS |
   352				DL_FLAG_PM_RUNTIME |
   353				DL_FLAG_RPM_ACTIVE);
   354	
   355		if (!pd_link_a) {
   356			dev_err(dev, "Failed to add device_link to mu a.\n");
   357			goto err_pd_a;
   358		}
   359	
   360		pd_link_b = device_link_add(dev, pd_b,
   361				DL_FLAG_STATELESS |
   362				DL_FLAG_PM_RUNTIME |
   363				DL_FLAG_RPM_ACTIVE);
   364	
   365	
   366		if (!pd_link_b) {
   367			dev_err(dev, "Failed to add device_link to mu a.\n");
   368			goto err_pd_b;
   369		}
   370	
   371		ret = imx_mu_msi_domains_init(msi_data, dev);
   372		if (ret)
   373			goto err_dm_init;
   374	
   375		irq_set_chained_handler_and_data(irq,
   376						 imx_mu_msi_irq_handler,
   377						 msi_data);
   378	
   379		pm_runtime_enable(dev);
   380	
   381		return 0;
   382	
   383	err_dm_init:
   384		device_link_remove(dev,	pd_b);
   385	err_pd_b:
   386		device_link_remove(dev, pd_a);
   387	err_pd_a:
   388		return -EINVAL;
   389	}
   390	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
