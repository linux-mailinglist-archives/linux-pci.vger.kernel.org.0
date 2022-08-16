Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9557059572E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiHPJyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiHPJx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 05:53:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7571A3A1;
        Tue, 16 Aug 2022 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660639199; x=1692175199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RSEQvzyLuQNM7I4Q/O8zTlnKSg2x78+IvGBFvjba1ps=;
  b=ZJQhUY37KNj5BcnSIqxBhb8EGUC3gDMC6DNmGKTBctXxtM6z/SDEx3z9
   eFrPJE3ruj1U5jt/JCaVlAeXzElzr/4SX6l65EGFxhyfzOjCel1thYtcu
   Vnm5iR/KcNEW8w0dUOsc0wh23pgMtMSNvN/bcLY8xqknaUft6ByTeJ6T0
   DIvdxrM4vjfCfu45XPCcoFjStzSx4fW9EN9EsTmBzBGm080VrIwwYfxnL
   Ji+2SAnZnwsBxIxwJzKYOkoE88Wek4N239WIXOoVI+Jsmq87CrBP+T3f0
   s3FYHfqUnx+uXnh8zvt6PO9KTQ3eqzqsjybNLwZjdWIGZtPTmZdCqCMlM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279124302"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279124302"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="710058969"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2022 01:39:52 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNs74-0001dx-2Y;
        Tue, 16 Aug 2022 08:39:50 +0000
Date:   Tue, 16 Aug 2022 16:39:05 +0800
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
Message-ID: <202208161638.7Rn1SHT2-lkp@intel.com>
References: <20220815213936.2380439-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815213936.2380439-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jonmason-ntb/ntb-next]
[also build test WARNING on robh/for-next linus/master v6.0-rc1 next-20220816]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220816-131930
base:   https://github.com/jonmason/ntb ntb-next
config: arm64-randconfig-r025-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161638.7Rn1SHT2-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/71296e2ad757d90e870b2ab81f2b06b9c76e7c41
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220816-131930
        git checkout 71296e2ad757d90e870b2ab81f2b06b9c76e7c41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-imx-mu-msi.c:295:32: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
           struct imx_mu_msi *msi_data, *priv;
                                         ^
   1 warning generated.


vim +/priv +295 drivers/irqchip/irq-imx-mu-msi.c

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
