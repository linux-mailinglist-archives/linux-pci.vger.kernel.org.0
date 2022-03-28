Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A854EA347
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 00:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiC1WpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiC1WpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 18:45:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4403AF1CC;
        Mon, 28 Mar 2022 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648507403; x=1680043403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=43i2ldLha0/YWAMiMHUcHxUpHyrhfZrIuZwK4n9t+sA=;
  b=bnVtTPJRthHdAgnuUeKx53O1kiSdgzWTnONWmeAL0rJSSqldxSD/LdEK
   J1N9nj3FcMuoj8GSr1nSHPCpCxBcp0vHOPE3WvWbe+eLp6+++kpbeGoEU
   oLhMXyq0Hvc4Q/bV4ajewWSDjLzoVE2pNwiaFkmJOZpDVMyu4xWIKMnFv
   Zwsy597Xwpixkk0acVyPeGJXhvtDvxJOxeKUZgg3ltFclbyTuQhYzJGwJ
   4GoohaD4cqK3dntc3yiH7YyJzWojl4uz5233y73mX66C3khNLcYc7YRpF
   Gaalv0s1yh8HYMarFdj35Invya26MxBgGdmh/Arvbe+bqCvObJOfkufjC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345543595"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="345543595"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 14:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="502664503"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 14:35:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYx1j-0002Kv-4R; Mon, 28 Mar 2022 21:35:51 +0000
Date:   Tue, 29 Mar 2022 05:34:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] PCI: dwc: Add unroll iATU space support to the
 regions disable method
Message-ID: <202203290527.iS9iplnr-lkp@intel.com>
References: <20220324012524.16784-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-4-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

I love your patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on v5.17 next-20220328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/PCI-dwc-Various-fixes-and-cleanups/20220328-231112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-randconfig-a013-20220328 (https://download.01.org/0day-ci/archive/20220329/202203290527.iS9iplnr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fb5c4386b8af12124d1e7b48bd7f538c12d85100
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/PCI-dwc-Various-fixes-and-cleanups/20220328-231112
        git checkout fb5c4386b8af12124d1e7b48bd7f538c12d85100
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware.c:508:14: warning: result of comparison of constant 2147483648 with expression of type 'int' is always false [-Wtautological-constant-out-of-range-compare]
                   if (region == PCIE_ATU_REGION_INBOUND) {
                       ~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/int +508 drivers/pci/controller/dwc/pcie-designware.c

   490	
   491	void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
   492				 enum dw_pcie_region_type type)
   493	{
   494		int region;
   495	
   496		switch (type) {
   497		case DW_PCIE_REGION_INBOUND:
   498			region = PCIE_ATU_REGION_INBOUND;
   499			break;
   500		case DW_PCIE_REGION_OUTBOUND:
   501			region = PCIE_ATU_REGION_OUTBOUND;
   502			break;
   503		default:
   504			return;
   505		}
   506	
   507		if (pci->iatu_unroll_enabled) {
 > 508			if (region == PCIE_ATU_REGION_INBOUND) {
   509				dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
   510							 ~(u32)PCIE_ATU_ENABLE);
   511			} else {
   512				dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
   513							 ~(u32)PCIE_ATU_ENABLE);
   514			}
   515		} else {
   516			dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
   517			dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
   518		}
   519	}
   520	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
