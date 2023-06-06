Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB9723E48
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFFJu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFFJuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:50:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C9083;
        Tue,  6 Jun 2023 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686045052; x=1717581052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3cNnMr81VZ0I0o8WZIbb8MszLRP+Xq3U1TWFpdzHIS8=;
  b=TqWVUj855BxdguVSNtAtDqd29wz81yxZCN+FHRjy4YaNo6bImsxc/8Tu
   WR3C5L7EAjNn95xLF0Zzv3bY7PzH1z1SngpJ5h+TCQ+9dozne1xPNr9MF
   xIGfv7cQnTlHKPBW6Tj9WlRscD53xhyKlgAXT3G8tf+khEZGtfO0y2h29
   tNzMqxU6W0NsUjcWtAeOTMspihXCriGc99gJx/3fGFt4/t1Ln9T6NxrpW
   pV5DJitpqgYobRAM0rQhXZcdlcDYSUlNxvzjj3doRpRWGV9qShz4t+Ctz
   6kCaCLKtCXt8b0CyIjYRVa69QABztOgLoxHcmkF+yJGqF0L1OK1MNylJg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356630043"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="356630043"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="709016088"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="709016088"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2023 02:50:13 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6TKP-00056l-0o;
        Tue, 06 Jun 2023 09:50:13 +0000
Date:   Tue, 6 Jun 2023 17:49:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O 'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCHv3 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
Message-ID: <202306061710.tDjm3jHD-lkp@intel.com>
References: <20230606035442.2886343-2-grundler@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606035442.2886343-2-grundler@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
config: x86_64-randconfig-x051-20230606 (https://download.01.org/0day-ci/archive/20230606/202306061710.tDjm3jHD-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
        git fetch pci next
        git checkout pci/next
        b4 shazam https://lore.kernel.org/r/20230606035442.2886343-2-grundler@chromium.org
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/pcie/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306061710.tDjm3jHD-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pci/pcie/aer.c:717:30: error: expected ';' after expression
                   pci_err(dev, "%s", aer_msg):
                                              ^
                                              ;
>> drivers/pci/pcie/aer.c:746:28: warning: data argument not used by format string [-Wformat-extra-args]
                           aer_error_layer[layer], aer_agent_string[agent],
                           ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2600:65: note: expanded from macro 'pci_err'
   #define pci_err(pdev, fmt, arg...)      dev_err(&(pdev)->dev, fmt, ##arg)
                                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^
   1 warning and 1 error generated.


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
   722	void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
   723	{
   724		int layer, agent;
   725		int id = ((dev->bus->number << 8) | dev->devfn);
   726	
   727		if (!info->status) {
   728			pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
   729				aer_error_severity_string[info->severity]);
   730			goto out;
   731		}
   732	
   733		layer = AER_GET_LAYER_ERROR(info->severity, info->status);
   734		agent = AER_GET_AGENT(info->severity, info->status);
   735	
   736		if (info->severity == AER_CORRECTABLE) {
   737			pci_info_ratelimited(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n"
   738					"  device [%04x:%04x] error status/mask=%08x/%08x\n",
   739					     aer_error_severity_string[info->severity],
   740					     aer_error_layer[layer], aer_agent_string[agent],
   741					     dev->vendor, dev->device, info->status, info->mask);
   742		} else {
   743			pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
   744				"  device [%04x:%04x] error status/mask=%08x/%08x\n",
   745				aer_error_severity_string[info->severity],
 > 746				aer_error_layer[layer], aer_agent_string[agent],
   747				dev->vendor, dev->device, info->status, info->mask);
   748		}
   749	
   750		__aer_print_error(dev, info);
   751	
   752		if (info->tlp_header_valid)
   753			__print_tlp_header(dev, &info->tlp);
   754	
   755	out:
   756		if (info->id && info->error_dev_num > 1 && info->id == id)
   757			pci_err(dev, "  Error of this Agent is reported first\n");
   758	
   759		trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
   760				info->severity, info->tlp_header_valid, &info->tlp);
   761	}
   762	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
