Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E7758A4EB
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 05:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiHEDOR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 23:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiHEDOQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 23:14:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2782127A;
        Thu,  4 Aug 2022 20:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659669254; x=1691205254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=em9d5nkk91eNJNYUWeeKE/vxo3/VpN9Fz85Yl8KbRSM=;
  b=jPW0SkGb8mjQMbbY1L1kzjgq7laJyZliIIBr49pd9vkN2G60FGRQP/HL
   51blIQhZ8mruC8ndsa4efgwbn50r3Bx6sz1VV7Pt670uObDWmng2Qfdtb
   l5TKTEqu8IdsHDSxRgd6Gtt+7YTUrZB84vcDRQJ4/RmA/q++MhnPU3Ls+
   XoWrWm9XNjMtyg4ZdU8R7K1/NRuuhHg8/tXFa6Gt/TE4bj/KZWEnG/nQJ
   vLy2qCog5lx4/4W7241/tFTrbU+lQbS2PJ5UkHXIFgjTVYV2+rRMWhb92
   IcSlvwDRCWNgFB0VHc7WyWo27talXWcvepdToQd6MrkvaeKPd+wnEdR9J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="291332220"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="291332220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 20:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636347985"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2022 20:14:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJnmp-000J5s-39;
        Fri, 05 Aug 2022 03:14:07 +0000
Date:   Fri, 5 Aug 2022 11:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v5 3/3] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Message-ID: <202208051112.qnLsiuff-lkp@intel.com>
References: <1659526134-22978-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659526134-22978-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on next-20220804]
[cannot apply to linus/master v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-Restrict-pci-transactions-after-pci-suspend/20220803-193033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm64-randconfig-r024-20220804 (https://download.01.org/0day-ci/archive/20220805/202208051112.qnLsiuff-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/64b4ad561ad4a28aa8840303f29669bf7af77757
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-chaitanya-chundru/PCI-Restrict-pci-transactions-after-pci-suspend/20220803-193033
        git checkout 64b4ad561ad4a28aa8840303f29669bf7af77757
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom.c:1847:6: warning: format specifies type 'int' but the argument has type 's64' (aka 'long long') [-Wformat]
                                           ktime_to_ms(ktime_get() - start));
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +1847 drivers/pci/controller/dwc/pcie-qcom.c

  1827	
  1828	static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
  1829	{
  1830		struct qcom_pcie *pcie = dev_get_drvdata(dev);
  1831		u32 val;
  1832		ktime_t timeout, start;
  1833	
  1834		if (!pcie->cfg->supports_system_suspend)
  1835			return 0;
  1836	
  1837		start = ktime_get();
  1838		/* Wait max 100 ms */
  1839		timeout = ktime_add_ms(start, 100);
  1840		while (1) {
  1841			bool timedout = ktime_after(ktime_get(), timeout);
  1842	
  1843			/* if the link is not in l1ss don't turn off clocks */
  1844			val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
  1845			if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
  1846				dev_info(dev, "Link enters L1ss after %d ms\n",
> 1847						ktime_to_ms(ktime_get() - start));
  1848				break;
  1849			}
  1850	
  1851			if (timedout) {
  1852				dev_warn(dev, "Link is not in L1ss\n");
  1853				return 0;
  1854			}
  1855			usleep_range(1000, 1200);
  1856		}
  1857	
  1858		if (pcie->cfg->ops->suspend)
  1859			pcie->cfg->ops->suspend(pcie);
  1860	
  1861		pcie->is_suspended = true;
  1862	
  1863		return 0;
  1864	}
  1865	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
