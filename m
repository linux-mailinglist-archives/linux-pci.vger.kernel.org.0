Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55075BD21B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiISQXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiISQXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 12:23:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31BD31DE7;
        Mon, 19 Sep 2022 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663604631; x=1695140631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=534SCdyVoi3Nta37uvVFYzfWLs7UOtcQZUJoddoJMi4=;
  b=kX2t1GvDAtFNJDkGfFMgVo+lQ09041NK2Z0ZwOzxyhMtkw8NYBBhbw5x
   SDbZ8KMRiCanm9W8MBdCUngzkS7j99YOYeBFx7Ww1mcDMxg+FmY1vrZkZ
   lW8i7ZF7lMPnFRnSXoRcis1hLgjGIkEOtvP6OzJg02l7sCf4XPMAzBkRf
   i9fYMjpmkaizuvtyyi6/qW/5XCvvEP9FUfWpHMPzxIvPHj02TlhjCL4QJ
   aKMs0noQ+6Jcr36TJtTTI67EAairCkku4EZSAd4fN8AbaujCYOt0naDEY
   jUIokWrC5FSxpvHDrLmr0ZPLslCPDyw9yijImz8jka3FoAOPxmc9jSQht
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361185512"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="361185512"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="947285801"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 09:23:45 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaJYf-00025Z-03;
        Mon, 19 Sep 2022 16:23:45 +0000
Date:   Tue, 20 Sep 2022 00:23:10 +0800
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
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v6 2/5] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Message-ID: <202209200020.ASFgBZac-lkp@intel.com>
References: <1662713084-8106-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662713084-8106-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test WARNING on next-20220919]
[cannot apply to clk/clk-next linus/master v6.0-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-qcom-Add-system-suspend-resume-support/20220909-164906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm64-randconfig-r002-20220919 (https://download.01.org/0day-ci/archive/20220920/202209200020.ASFgBZac-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/629a2c707a31ccfdf891d6b580cf3e8c62ab9169
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-chaitanya-chundru/PCI-qcom-Add-system-suspend-resume-support/20220909-164906
        git checkout 629a2c707a31ccfdf891d6b580cf3e8c62ab9169
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom.c:1834:6: warning: format specifies type 'int' but the argument has type 's64' (aka 'long long') [-Wformat]
                                           ktime_to_ms(ktime_get() - start));
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:158:46: note: expanded from macro 'dev_dbg'
           dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                               ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +1834 drivers/pci/controller/dwc/pcie-qcom.c

  1808	
  1809	static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
  1810	{
  1811		u32 val;
  1812		ktime_t timeout, start;
  1813		struct dw_pcie *pci = pcie->pci;
  1814		struct device *dev = pci->dev;
  1815	
  1816		if (!pcie->cfg->supports_system_suspend)
  1817			return 0;
  1818	
  1819		start = ktime_get();
  1820		/* Wait max 200 ms */
  1821		timeout = ktime_add_ms(start, 200);
  1822	
  1823		while (1) {
  1824	
  1825			if (!dw_pcie_link_up(pci)) {
  1826				dev_warn(dev, "Link is not active\n");
  1827				break;
  1828			}
  1829	
  1830			/* if the link is not in l1ss don't turn off clocks */
  1831			val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
  1832			if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
  1833				dev_dbg(dev, "Link enters L1ss after %d  ms\n",
> 1834						ktime_to_ms(ktime_get() - start));
  1835				break;
  1836			}
  1837	
  1838			if (ktime_after(ktime_get(), timeout)) {
  1839				dev_warn(dev, "Link is not in L1ss\n");
  1840				return 0;
  1841			}
  1842	
  1843			udelay(1000);
  1844		}
  1845	
  1846		if (pcie->cfg->ops->suspend)
  1847			pcie->cfg->ops->suspend(pcie);
  1848	
  1849		pcie->is_suspended = true;
  1850	
  1851		return 0;
  1852	}
  1853	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
