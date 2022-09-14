Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924D85B8BB7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiINP0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiINP0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 11:26:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE47C32E;
        Wed, 14 Sep 2022 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663169178; x=1694705178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w2AVshTSG88TxCtziOS+qzrWEimtM+9ls56BMEl28zk=;
  b=kFD6pmFQapaAUZPYq1My+KTn2bhSpGFL/4E3X3rml+1//+/S/Rrw6XYX
   G9hJNg94Rg5G1tdoLv4AkhNlfIAhy0MQ3db6jwvONl2u6pCltG+L3cPj9
   0Wc3xhFfiWiZqt1tJwBZjg0goXI3QAwgnNhrfF8tWLCdybx/YP4yJFYk1
   1cw7xkxW1AvQNXgdbNRM2IX5nvhUOb4WvdlE0yfnSRVr7cPFAo0oyv2eY
   YLMSbGe1GvgILSb4iEaGKmPZVTko+GVs6ivTuxQ0W50p2AEPujR8VJeZc
   iJ3VfxHGtzUv9H2rs6iPp5ZqG4XA/Vb2N+kp9xSreQkjvf78MD1sOAT9s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362419807"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="362419807"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="742592762"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Sep 2022 08:26:11 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYUHD-0000Km-02;
        Wed, 14 Sep 2022 15:26:11 +0000
Date:   Wed, 14 Sep 2022 23:25:27 +0800
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
Subject: Re: [PATCH v10 5/6] PCI: endpoint: makeup pci-epf-vntb.c
Message-ID: <202209142334.YTRtjuFD-lkp@intel.com>
References: <20220913210957.3493826-6-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913210957.3493826-6-Frank.Li@nxp.com>
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
[also build test WARNING on driver-core/driver-core-testing linus/master v6.0-rc5 next-20220914]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/platform-msi-export-symbol-platform_msi_create_irq_domain/20220914-060955
base:   https://github.com/jonmason/ntb ntb-next
config: ia64-randconfig-s051-20220914 (https://download.01.org/0day-ci/archive/20220914/202209142334.YTRtjuFD-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/c0b811e4bf3a50a612ed143d284880e09790eff5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frank-Li/platform-msi-export-symbol-platform_msi_create_irq_domain/20220914-060955
        git checkout c0b811e4bf3a50a612ed143d284880e09790eff5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/endpoint/functions/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:258:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:258:47: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:258:47: sparse:     got void *
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:260:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:260:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:260:47: sparse:     got void *
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:560:66: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *virt_addr @@     got void *[assigned] mw_addr @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:560:66: sparse:     expected void [noderef] __iomem *virt_addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:560:66: sparse:     got void *[assigned] mw_addr
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1106:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1106:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1106:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1117:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1117:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1117:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1128:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1128:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1128:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1140:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct epf_ntb_ctrl *reg @@
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1140:33: sparse:     expected void [noderef] __iomem *base
   drivers/pci/endpoint/functions/pci-epf-vntb.c:1140:33: sparse:     got struct epf_ntb_ctrl *reg
   drivers/pci/endpoint/functions/pci-epf-vntb.c: note: in included file (through arch/ia64/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32

vim +258 drivers/pci/endpoint/functions/pci-epf-vntb.c

   236	
   237	/**
   238	 * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
   239	 * @work: work_struct for the epf_ntb_epc
   240	 *
   241	 * Workqueue function that gets invoked for the two epf_ntb_epc
   242	 * periodically (once every 5ms) to see if it has received any commands
   243	 * from NTB host. The host can send commands to configure doorbell or
   244	 * configure memory window or to update link status.
   245	 */
   246	static void epf_ntb_cmd_handler(struct work_struct *work)
   247	{
   248		struct epf_ntb_ctrl *ctrl;
   249		u32 command, argument;
   250		struct epf_ntb *ntb;
   251		struct device *dev;
   252		int ret;
   253		int i;
   254	
   255		ntb = container_of(work, struct epf_ntb, cmd_handler.work);
   256	
   257		for (i = 1; i < ntb->db_count; i++) {
 > 258			if (readl_relaxed(ntb->epf_db + i * ENTRY_SIZE)) {
   259				ntb_db_event(&ntb->ntb, i);
 > 260				writel(0, ntb->epf_db + i * ENTRY_SIZE);
   261			}
   262		}
   263	
   264		ctrl = ntb->reg;
   265		command = ctrl->command;
   266		if (!command)
   267			goto reset_handler;
   268		argument = ctrl->argument;
   269	
   270		ctrl->command = 0;
   271		ctrl->argument = 0;
   272	
   273		ctrl = ntb->reg;
   274		dev = &ntb->epf->dev;
   275	
   276		switch (command) {
   277		case COMMAND_CONFIGURE_DOORBELL:
   278			ctrl->command_status = COMMAND_STATUS_OK;
   279			break;
   280		case COMMAND_TEARDOWN_DOORBELL:
   281			ctrl->command_status = COMMAND_STATUS_OK;
   282			break;
   283		case COMMAND_CONFIGURE_MW:
   284			ret = epf_ntb_configure_mw(ntb, argument);
   285			if (ret < 0)
   286				ctrl->command_status = COMMAND_STATUS_ERROR;
   287			else
   288				ctrl->command_status = COMMAND_STATUS_OK;
   289			break;
   290		case COMMAND_TEARDOWN_MW:
   291			epf_ntb_teardown_mw(ntb, argument);
   292			ctrl->command_status = COMMAND_STATUS_OK;
   293			break;
   294		case COMMAND_LINK_UP:
   295			ntb->linkup = true;
   296			ret = epf_ntb_link_up(ntb, true);
   297			if (ret < 0)
   298				ctrl->command_status = COMMAND_STATUS_ERROR;
   299			else
   300				ctrl->command_status = COMMAND_STATUS_OK;
   301			goto reset_handler;
   302		case COMMAND_LINK_DOWN:
   303			ntb->linkup = false;
   304			ret = epf_ntb_link_up(ntb, false);
   305			if (ret < 0)
   306				ctrl->command_status = COMMAND_STATUS_ERROR;
   307			else
   308				ctrl->command_status = COMMAND_STATUS_OK;
   309			break;
   310		default:
   311			dev_err(dev, "UNKNOWN command: %d\n", command);
   312			break;
   313		}
   314	
   315	reset_handler:
   316		queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
   317				   msecs_to_jiffies(5));
   318	}
   319	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
