Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C15B10BA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 02:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIHADr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 20:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIHADq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 20:03:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCB8A7FA;
        Wed,  7 Sep 2022 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662595424; x=1694131424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=URLWQZsCNym3oVouZaO+x+X4zDWx8UYslRszx3tig5E=;
  b=QQTIfaAMXYib49gGuNLaf9LWjbnzKATpmVSPWBVt72oA/dBibUF23bfk
   Wm7IpjTmki0rhVcLKBtEzLOkbH6EDm0UD5IjA1kSVgIgZlMDIGmcpv2YG
   KN/PBQL/epQlmsWaDhABDnmuHgR41hpJVRuBQFRc3VxngyT76v8uYIcrm
   1ctjW9OlVL+NS2DihSESZLmk0uJcIdryS6IYElBvLBTT73CkUaHWTebJk
   FD/kW2IkpVokUqvKOfgjYR2069QV5tDyGD/8QBhcQso0bXnsAVg8t8Qt/
   /U329vW01fE1MH1ZSDLkWAKEAnBxNBUQw6505PPESZsxXXCzG7SLAa6AE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="294609877"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="294609877"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="683019230"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2022 17:03:39 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW518-00077D-1Z;
        Thu, 08 Sep 2022 00:03:38 +0000
Date:   Thu, 8 Sep 2022 08:03:27 +0800
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
Subject: Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller driver
Message-ID: <202209080757.hQMfrrfm-lkp@intel.com>
References: <20220907034856.3101570-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907034856.3101570-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test ERROR on robh/for-next linus/master v6.0-rc4 next-20220907]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220907-115114
base:   https://github.com/jonmason/ntb ntb-next
config: s390-randconfig-s033-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080757.hQMfrrfm-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/c1f079e633c10b4f2f1f3c8f52e447d13fda8ddb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220907-115114
        git checkout c1f079e633c10b4f2f1f3c8f52e447d13fda8ddb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-imx-mu-msi.o: in function `imx_mu_of_init':
>> drivers/irqchip/irq-imx-mu-msi.c:316: undefined reference to `devm_platform_ioremap_resource_byname'


vim +316 drivers/irqchip/irq-imx-mu-msi.c

   288	
   289	static int __init imx_mu_of_init(struct device_node *dn,
   290					 struct device_node *parent,
   291					 const struct imx_mu_dcfg *cfg
   292					)
   293	{
   294		struct platform_device *pdev = of_find_device_by_node(dn);
   295		struct device_link *pd_link_a;
   296		struct device_link *pd_link_b;
   297		struct imx_mu_msi *msi_data;
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
   310		msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
   311		if (!msi_data)
   312			return -ENOMEM;
   313	
   314		msi_data->cfg = cfg;
   315	
 > 316		msi_data->regs = devm_platform_ioremap_resource_byname(pdev, "processor-a-side");
   317		if (IS_ERR(msi_data->regs)) {
   318			dev_err(&pdev->dev, "failed to initialize 'regs'\n");
   319			return PTR_ERR(msi_data->regs);
   320		}
   321	
   322		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "processor-b-side");
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
   342		pd_a = dev_pm_domain_attach_by_name(dev, "processor-a-side");
   343		if (IS_ERR(pd_a))
   344			return PTR_ERR(pd_a);
   345	
   346		pd_b = dev_pm_domain_attach_by_name(dev, "processor-b-side");
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
