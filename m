Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376C7238DA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjFFHWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFFHWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 03:22:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3268CEC;
        Tue,  6 Jun 2023 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686036127; x=1717572127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=42Zq2VVVmL82oSxttVhxIe0JhaOWSJB60Dpa1lLTJ8c=;
  b=c6nFpNJRLnXZVBP595W3sEorDKwZ6fg1SdH8gIWMj4u2DoJ54iC+TpaB
   bTwPYFCxIK8X+vQM6slOrWlkcTDUAaKe+kxuJC0ZHFTjdZldJX0KDTx3b
   /vued+PnSJSad80knB7vrBfn9ROJ0mjJIlTWutXlnh0LVCAlzAwk+swcC
   Aj8Lx12ubvXjnObnn/pKQmr5yHGeBmJiETZ1T7yPQnxe+NuQyeh4myzmk
   FaYS0ARd5gw+eybpAeZKrOAS8qCyoHfnp5/vIqi1ItSERUq9nXHOyVcKN
   FB3CXvV4AgrlyIpQV2nRZKxFx14Kbi3GvjnfyaV1S7OtsfoqMrrEfJn1i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336214497"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="336214497"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821505090"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821505090"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2023 00:22:04 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6R11-0004xz-13;
        Tue, 06 Jun 2023 07:22:03 +0000
Date:   Tue, 6 Jun 2023 15:21:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O 'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCHv3 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
Message-ID: <202306061553.YXoBaXAM-lkp@intel.com>
References: <20230606035442.2886343-2-grundler@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606035442.2886343-2-grundler@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Grant,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.4-rc5 next-20230606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Grant-Grundler/PCI-AER-Rate-limit-the-reporting-of-the-correctable-errors/20230606-115515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230606035442.2886343-2-grundler%40chromium.org
patch subject: [PATCHv3 pci-next 2/2] PCI/AER: Rate limit the reporting of the correctable errors
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230606/202306061553.YXoBaXAM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
        git fetch pci next
        git checkout pci/next
        b4 shazam https://lore.kernel.org/r/20230606035442.2886343-2-grundler@chromium.org
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/pcie/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306061553.YXoBaXAM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/pci/pcie/aer.c: In function '__aer_print_error':
>> drivers/pci/pcie/aer.c:717:44: error: expected ';' before ':' token
     717 |                 pci_err(dev, "%s", aer_msg):
         |                                            ^
   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from drivers/pci/pcie/aer.c:20:
   drivers/pci/pcie/aer.c: In function 'aer_print_error':
>> drivers/pci/pcie/aer.c:15:21: warning: too many arguments for format [-Wformat-extra-args]
      15 | #define pr_fmt(fmt) "AER: " fmt
         |                     ^~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   drivers/pci/pcie/aer.c:16:17: note: in expansion of macro 'pr_fmt'
      16 | #define dev_fmt pr_fmt
         |                 ^~~~~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   include/linux/pci.h:2600:41: note: in expansion of macro 'dev_err'
    2600 | #define pci_err(pdev, fmt, arg...)      dev_err(&(pdev)->dev, fmt, ##arg)
         |                                         ^~~~~~~
   drivers/pci/pcie/aer.c:743:17: note: in expansion of macro 'pci_err'
     743 |                 pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
         |                 ^~~~~~~
   drivers/pci/pcie/aer.c: At top level:
   drivers/pci/pcie/aer.c:626:13: warning: 'pci_dev_aer_stats_incr' defined but not used [-Wunused-function]
     626 | static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +717 drivers/pci/pcie/aer.c

   684	
   685	static void __aer_print_error(struct pci_dev *dev,
   686				      struct aer_err_info *info)
   687	{
   688		const char **strings;
   689		char aer_msg[512];
   690		unsigned long status = info->status & ~info->mask;
   691		int i;
   692	
   693		memset(aer_msg, 0, sizeof(*aer_msg));
   694		snprintf(aer_msg, sizeof(*aer_msg), "aer_status: 0x%08x, aer_mask: 0x%08x\n",
   695				info->status, info->mask);
   696	
   697		strings = (info->severity == AER_CORRECTABLE) ?
   698			aer_correctable_error_string : aer_uncorrectable_error_string;
   699	
   700		for_each_set_bit(i, &status, 32) {
   701			const char *errmsg = strings[i];
   702			char bitmsg[64];
   703			memset(bitmsg, 0, sizeof(*bitmsg));
   704	
   705			if (!errmsg)
   706				errmsg = "Unknown Error Bit";
   707	
   708			snprintf(bitmsg, sizeof(*bitmsg), "   [%2d] %-22s%s\n", i, errmsg,
   709				    info->first_error == i ? " (First)" : "");
   710	
   711			strlcat(aer_msg, bitmsg, sizeof(*aer_msg));
   712		}
   713	
   714		if (info->severity == AER_CORRECTABLE)
   715			pci_info_ratelimited(dev, "%s", aer_msg);
   716		else
 > 717			pci_err(dev, "%s", aer_msg):
   718	
   719		pci_dev_aer_stats_incr(dev, info);
   720	}
   721	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
