Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD14575C627
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGULzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 07:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGULzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 07:55:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10D2130;
        Fri, 21 Jul 2023 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689940541; x=1721476541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K41ZT6FFbqsFq/4uR+fCJXln/yKHh9TKSrU4l6M1czk=;
  b=kLAcDJCX3fdaoF6usRt/4NDQfpoGz5oy85vwpM8+5pkOboXcJO+lU6rq
   AQwY71NibJKJYbFKNIDzQTKYswz1pQ8HxbasXJOFWtLqDxFewDrpoYUYO
   93AlVAEinVfaOt5M803/j8W9q46Ti/xsgWpYIv4uW4qjunIZFGYj3t8MO
   xRpqHrE2kvyVg14YFkHT3T6XYZUY7A2ltKkTMIex1a/633AOuAmA57sHA
   yOP+e4WN0LVr+SlhL46ayg6Z8waOy/EzG2il+f6zgvdGncjcoAgmoBDkR
   ufEwTXMdXDv3BwmLurub1LXCt9PEQzjQWkGxYxcNudh0V2+DFPxQn5xTL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453382117"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453382117"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898692805"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898692805"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 04:55:35 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMojO-0007Fx-2b;
        Fri, 21 Jul 2023 11:55:34 +0000
Date:   Fri, 21 Jul 2023 19:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, mani@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Frank.li@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, manivannan.sadhasivam@linaro.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v4 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <202307211904.zExw4Q8H-lkp@intel.com>
References: <20230720210914.2030897-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720210914.2030897-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.4]
[also build test WARNING on linus/master next-20230721]
[cannot apply to pci/next pci/for-linus v6.5-rc2 v6.5-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-layerscape-Add-power-management-support-for-ls1028a/20230721-051152
base:   v6.4
patch link:    https://lore.kernel.org/r/20230720210914.2030897-1-Frank.Li%40nxp.com
patch subject: [PATCH v4 1/2] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
config: mips-randconfig-r093-20230720 (https://download.01.org/0day-ci/archive/20230721/202307211904.zExw4Q8H-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307211904.zExw4Q8H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-designware-host.c:824:13: sparse: sparse: invalid assignment: |=
>> drivers/pci/controller/dwc/pcie-designware-host.c:824:13: sparse:    left side has type unsigned int
>> drivers/pci/controller/dwc/pcie-designware-host.c:824:13: sparse:    right side has type restricted pci_power_t

vim +824 drivers/pci/controller/dwc/pcie-designware-host.c

   811	
   812	/*
   813	 * This resemble the pci_set_power_state() interfaces, but these are for
   814	 * configuring host controllers, which are bridges *to* PCI devices but
   815	 * are not PCI devices themselves.
   816	 */
   817	static void dw_pcie_set_dstate(struct dw_pcie *pci, pci_power_t dstate)
   818	{
   819		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
   820		u32 val;
   821	
   822		val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
   823		val &= ~PCI_PM_CTRL_STATE_MASK;
 > 824		val |= dstate;
   825		dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
   826	}
   827	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
