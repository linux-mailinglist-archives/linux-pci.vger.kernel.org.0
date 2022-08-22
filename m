Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA80C59CADF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbiHVVdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiHVVdT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 17:33:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F6259;
        Mon, 22 Aug 2022 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661203995; x=1692739995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KAwOGc5/RlMiec7gexR6wehKS1gvBgI3uejZUSQuJmc=;
  b=n2ZrkOv+IbtOJRCBASy2ucqN+pYxo4S07sQr0hOS9ylMzjU5Xpwoc4VY
   ygZMf8+/ztmev/XoFBgujat1L4fO2gltKWXdf9UKs+IlE9n9Q/HlifKFZ
   Paqjh/XRhbD8/+62xEsRWdkZuOx7trd4LUahwCIpL7DHWGca2Kuqi8O4O
   TpslBXRxaBmOHf7RyLV69rbGLkcM7xi0CsGEecK779MKP0an8lHKR/2gG
   Z2njnsdMq7NRuF1c9WIlbH4J/hS3Iv5vOJyu0PS5RjMkoQxkPyzhHAuFe
   qNNYjKvdig6HkN3KSOo/R9NO9UiX0w9nbT/583QGX01aMOAiLaVEB41RV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355254843"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="355254843"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698435678"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 14:33:09 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQF2i-0000jv-2J;
        Mon, 22 Aug 2022 21:33:08 +0000
Date:   Tue, 23 Aug 2022 05:32:54 +0800
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
Message-ID: <202208230543.fAaLXJy7-lkp@intel.com>
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

I love your patch! Yet something to improve:

[auto build test ERROR on jonmason-ntb/ntb-next]
[also build test ERROR on robh/for-next linus/master v6.0-rc2 next-20220822]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220822-235323
base:   https://github.com/jonmason/ntb ntb-next
config: microblaze-randconfig-r005-20220821 (https://download.01.org/0day-ci/archive/20220823/202208230543.fAaLXJy7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d98704aefa5b57814d7b9b1b40160df34977b2b6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support-MSI-doorbell-from-host/20220822-235323
        git checkout d98704aefa5b57814d7b9b1b40160df34977b2b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/pci/endpoint/functions/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-vntb.c: In function 'epf_ntb_epc_msi_init':
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:786:13: error: implicit declaration of function 'platform_msi_domain_alloc_irqs' [-Werror=implicit-function-declaration]
     786 |         if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/platform_msi_domain_alloc_irqs +786 drivers/pci/endpoint/functions/pci-epf-vntb.c

   771	
   772	static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
   773	{
   774		struct device *dev = &ntb->epf->dev;
   775		struct irq_domain *domain;
   776		int virq;
   777		int ret;
   778		int i;
   779	
   780		domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
   781		if (!domain)
   782			return;
   783	
   784		dev_set_msi_domain(dev, domain);
   785	
 > 786		if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
   787			ntb->db_count,
   788			epf_ntb_write_msi_msg)) {
   789			dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
   790			return;
   791		}
   792	
   793		dev_info(dev, "vntb use MSI as doorbell\n");
   794	
   795		for (i = 0; i < ntb->db_count; i++) {
   796			virq = msi_get_virq(dev, i);
   797			ret = devm_request_irq(dev, virq,
   798				       epf_ntb_interrupt_handler, 0,
   799				       "ntb", ntb);
   800	
   801			if (ret) {
   802				dev_err(dev, "devm_request_irq() failure, fall back to poll mode\n");
   803				ntb->epf_db_phy = 0;
   804				break;
   805			}
   806	
   807			if (!i)
   808				ntb->msi_virqbase = virq;
   809		}
   810	}
   811	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
