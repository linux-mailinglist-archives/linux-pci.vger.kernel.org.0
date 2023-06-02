Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697471F99A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 07:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjFBFSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 01:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFBFSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 01:18:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA941B0;
        Thu,  1 Jun 2023 22:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685683092; x=1717219092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AkE4DmguvzxUYQULl8hlVDhWYZ9BtM+PE9kSUOgXzs4=;
  b=LnIzkeB5EDJ0/groIMPB3RVAUhHIkld9wCCQ5vxegiKt5W4fRb4Krx77
   kYzmve5UDzO/ypnKsNRyD/y6zNUjWdGK6Hk3lEd+wUBsiPBdDgmVnhif/
   Kw7ghlAohuNb2mM/ZLmGMEX9CpMetJhDrsV5/5uiubA+QB8zFUcYRvEMI
   OZJb82sMKPUidxgMEgSh30z7yLfKfK8o6xvvSHHTxBG/bLewh+S9gPRkd
   Y1PxVEim3LVwYlr7VYUoXrWaQ6CN8Id2Sb5s87ffPNDkG5iniERogw+L+
   j6FS0fy4/1E+rs21bvVC1fl5k0MXKzgthQNWS1160FcBPaEFNlTffm/OP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421596306"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="421596306"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 22:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701821904"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="701821904"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Jun 2023 22:18:09 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4xAv-00006x-0c;
        Fri, 02 Jun 2023 05:18:09 +0000
Date:   Fri, 2 Jun 2023 13:17:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     oe-kbuild-all@lists.linux.dev, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5 9/9] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <202306021200.ndNlhtdv-lkp@intel.com>
References: <20230601145718.12204-10-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601145718.12204-10-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus jonmason-ntb/ntb-next linus/master v6.4-rc4 next-20230601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/MAINTAINERS-Add-entry-for-MHI-networking-drivers-under-MHI-bus/20230601-232444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230601145718.12204-10-manivannan.sadhasivam%40linaro.org
patch subject: [PATCH v5 9/9] PCI: endpoint: Add PCI Endpoint function driver for MHI bus
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230602/202306021200.ndNlhtdv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b6931b37d070b86af64eeb92c1d52b4a0c6d61e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manivannan-Sadhasivam/MAINTAINERS-Add-entry-for-MHI-networking-drivers-under-MHI-bus/20230601-232444
        git checkout b6931b37d070b86af64eeb92c1d52b4a0c6d61e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/endpoint/functions/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021200.ndNlhtdv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-mhi.c: In function 'pci_epf_mhi_link_down':
>> drivers/pci/endpoint/functions/pci-epf-mhi.c:307:43: warning: unused variable 'info' [-Wunused-variable]
     307 |         const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
         |                                           ^~~~
   drivers/pci/endpoint/functions/pci-epf-mhi.c: In function 'pci_epf_mhi_bme':
   drivers/pci/endpoint/functions/pci-epf-mhi.c:321:43: warning: unused variable 'info' [-Wunused-variable]
     321 |         const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
         |                                           ^~~~


vim +/info +307 drivers/pci/endpoint/functions/pci-epf-mhi.c

   303	
   304	static int pci_epf_mhi_link_down(struct pci_epf *epf)
   305	{
   306		struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
 > 307		const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
   308		struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
   309	
   310		if (mhi_cntrl->mhi_dev) {
   311			mhi_ep_power_down(mhi_cntrl);
   312			mhi_ep_unregister_controller(mhi_cntrl);
   313		}
   314	
   315		return 0;
   316	}
   317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
