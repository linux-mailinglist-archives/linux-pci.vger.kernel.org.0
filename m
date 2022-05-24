Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4848531FC7
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiEXATr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 20:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiEXATj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 20:19:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4547D95A0D;
        Mon, 23 May 2022 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653351533; x=1684887533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZriWVXpTBb1rmEbtXs+vi59sS36pz9Vpa0z2W2c2tv0=;
  b=bfyEsH6V+ToixvQRGecfsTvH7kAOFOf5LGmW3RwPKuIGsW8Pf11JChiD
   61Z8cNyh4HWnkF4h8cfEA+MwZXB/bonfchHZ9VGvHFQnwhXR/Jd7LAjRB
   Fj2EPcN4pSm4TaAZR1u+zDW1KUxE5xBRI7D7UgGOhxBpJiWht5vRUer/M
   9hQkyjqfmcPt3qmTwGDwXf6LwKHHNkA/BQAO3zXPZ54N8KajcHKgqy6Of
   SQuGQ0apTRD7qqKK9K0ciVtuMuEp8mhcCCnzCcT/QvjwdL6j4hzdy8Ihx
   FD/jKxXahncCC9i2DTS/1ksIN15YGIIFkgqOy7qgTynGGzS2QFS8Ekwmi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273387786"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273387786"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="558909749"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2022 17:18:48 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntIG7-0001XK-ED;
        Tue, 24 May 2022 00:18:47 +0000
Date:   Tue, 24 May 2022 08:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v12 6/8] PCI: dwc: Implement special ISR handler for
 split MSI IRQ setup
Message-ID: <202205240801.7l6SF2Hv-lkp@intel.com>
References: <20220523181836.2019180-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-7-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[cannot apply to robh/for-next v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/PCI-qcom-Fix-higher-MSI-vectors-handling/20220524-024956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220524/202205240801.7l6SF2Hv-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/35aa0471e2ee4f0f21b01fbcfe6a4a425e968596
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Baryshkov/PCI-qcom-Fix-higher-MSI-vectors-handling/20220524-024956
        git checkout 35aa0471e2ee4f0f21b01fbcfe6a4a425e968596
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware-host.c: In function 'dw_split_msi_isr':
>> drivers/pci/controller/dwc/pcie-designware-host.c:116:25: warning: variable 'pci' set but not used [-Wunused-but-set-variable]
     116 |         struct dw_pcie *pci;
         |                         ^~~


vim +/pci +116 drivers/pci/controller/dwc/pcie-designware-host.c

   108	
   109	static void dw_split_msi_isr(struct irq_desc *desc)
   110	{
   111		struct irq_chip *chip = irq_desc_get_chip(desc);
   112		int irq = irq_desc_get_irq(desc);
   113		struct pcie_port *pp;
   114		int i;
   115		u32 num_ctrls;
 > 116		struct dw_pcie *pci;
   117	
   118		chained_irq_enter(chip, desc);
   119	
   120		pp = irq_desc_get_handler_data(desc);
   121		pci = to_dw_pcie_from_pp(pp);
   122	
   123		/*
   124		 * Unlike generic dw_handle_msi_irq(), we can determine which group of
   125		 * MSIs triggered the IRQ, so process just that group.
   126		 */
   127		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
   128	
   129		for (i = 0; i < num_ctrls; i++) {
   130			if (pp->msi_irq[i] == irq) {
   131				dw_handle_single_msi_group(pp, i);
   132				break;
   133			}
   134		}
   135	
   136		WARN_ON_ONCE(i == num_ctrls);
   137	
   138		chained_irq_exit(chip, desc);
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
