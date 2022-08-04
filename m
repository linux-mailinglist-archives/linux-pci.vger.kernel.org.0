Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213ED589A63
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiHDKZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 06:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiHDKZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 06:25:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC939BB9;
        Thu,  4 Aug 2022 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659608709; x=1691144709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IS40OMJ59ildUV2BC52fslfsJVgIpVJ9nPZ8BK1lyVc=;
  b=C9fIzDiZhSkkJJS3rb4VpqdIIbUJQ7Fh2YJuDiLF326cjQtNFynfIRbO
   wSczxWCexbMYPCtFmvUJ59GnhTg+L5LqKu1JZLQs34KCs0VdsN13BU+Fd
   +PU2Mt5u8HPoB8hBfEegKij61efStmdmi6L0oOzP30CfZqhsEtyoSbQt3
   Uxt9qsBobT92XlXOHheAZ+Jfq48RBZ34COsaxIjApiSGcgd+yN4ZLjWpK
   pvsijZqlhBKAnXc6dMqY47rddY5oWIyL/2fhPFT7mc7drCbIq3pT1ok/G
   Ls8tBUkHhnLNtnhA3YFd7VCA+1E/5PqH6OTS6Qx8ymFoZKutIKK3tIrki
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351612101"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="351612101"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 03:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="553672251"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 03:25:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJY2J-000IIJ-0x;
        Thu, 04 Aug 2022 10:25:03 +0000
Date:   Thu, 4 Aug 2022 18:24:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
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
Message-ID: <202208041821.cik847re-lkp@intel.com>
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
[also build test WARNING on next-20220803]
[cannot apply to linus/master v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-Restrict-pci-transactions-after-pci-suspend/20220803-193033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220804/202208041821.cik847re-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/64b4ad561ad4a28aa8840303f29669bf7af77757
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-chaitanya-chundru/PCI-Restrict-pci-transactions-after-pci-suspend/20220803-193033
        git checkout 64b4ad561ad4a28aa8840303f29669bf7af77757
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/of_device.h:5,
                    from drivers/pci/controller/dwc/pcie-qcom.c:20:
   drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_pm_suspend':
>> drivers/pci/controller/dwc/pcie-qcom.c:1846:39: warning: format '%d' expects argument of type 'int', but argument 3 has type 's64' {aka 'long long int'} [-Wformat=]
    1846 |                         dev_info(dev, "Link enters L1ss after %d ms\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:1846:25: note: in expansion of macro 'dev_info'
    1846 |                         dev_info(dev, "Link enters L1ss after %d ms\n",
         |                         ^~~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:1846:64: note: format string is defined here
    1846 |                         dev_info(dev, "Link enters L1ss after %d ms\n",
         |                                                               ~^
         |                                                                |
         |                                                                int
         |                                                               %lld


vim +1846 drivers/pci/controller/dwc/pcie-qcom.c

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
> 1846				dev_info(dev, "Link enters L1ss after %d ms\n",
  1847						ktime_to_ms(ktime_get() - start));
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
