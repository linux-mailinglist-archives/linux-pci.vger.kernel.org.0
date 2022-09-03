Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8455ABCC8
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 06:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiICETx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Sep 2022 00:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiICETw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Sep 2022 00:19:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1B2E9C8;
        Fri,  2 Sep 2022 21:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662178790; x=1693714790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/XdTWVITF6pH27tSJB4d8eknbMi4ORepldVdA6NqxSs=;
  b=cAQF5blAtX5gKvj9+Ssl6UJapHuAbZA6mkz22731qQkDHzwFN2s4VzDn
   N9pOE4cOyMRTwWGryu0zDshQ1pwRhwJUcRsq3auBHWKA0/UFkeORdy3B8
   m4ltKFJfzc610TKv92q7SzQTY5qZU2cv0L33iZUuCUaCSSvp+25CUnmwE
   xb5IIeqE0iOIz3FzwLzSZBJx7RWAASUGUjweNujiJdzYVZ5surqH4Jddn
   ZDD6lYmAjOCXpTjT3Aw/8GQtk28bCzReCQSBx200XH+4bhrUf4WATeR32
   i6ux2T+eNfDSfOwJhr5z5xD3pn5zeRzeg757ktXPFnkyWcD4/WcBITZCq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="360085431"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="360085431"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 21:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="702349342"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2022 21:19:47 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUKdG-00012f-2w;
        Sat, 03 Sep 2022 04:19:46 +0000
Date:   Sat, 3 Sep 2022 12:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kbuild-all@lists.01.org, Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 3/3] PCI/PM: Always disable PTM for all devices during
 suspend
Message-ID: <202209031256.McjuB8mz-lkp@intel.com>
References: <20220902233543.390890-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902233543.390890-4-helgaas@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-PM-Always-disable-PTM-for-all-devices-during-suspend/20220903-073808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220903/202209031256.McjuB8mz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/809e1c954b459ee37193c4ab9fa843243fbd7fa9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bjorn-Helgaas/PCI-PM-Always-disable-PTM-for-all-devices-during-suspend/20220903-073808
        git checkout 809e1c954b459ee37193c4ab9fa843243fbd7fa9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/pci-driver.c: In function 'pci_pm_runtime_resume':
>> drivers/pci/pci-driver.c:1350:22: error: 'struct pci_dev' has no member named 'ptm_enabled'; did you mean 'ats_enabled'?
    1350 |         if (pci_dev->ptm_enabled)
         |                      ^~~~~~~~~~~
         |                      ats_enabled


vim +1350 drivers/pci/pci-driver.c

  1335	
  1336	static int pci_pm_runtime_resume(struct device *dev)
  1337	{
  1338		struct pci_dev *pci_dev = to_pci_dev(dev);
  1339		const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
  1340		pci_power_t prev_state = pci_dev->current_state;
  1341		int error = 0;
  1342	
  1343		/*
  1344		 * Restoring config space is necessary even if the device is not bound
  1345		 * to a driver because although we left it in D0, it may have gone to
  1346		 * D3cold when the bridge above it runtime suspended.
  1347		 */
  1348		pci_pm_default_resume_early(pci_dev);
  1349	
> 1350		if (pci_dev->ptm_enabled)
  1351			pci_enable_ptm(pci_dev, NULL);
  1352	
  1353		if (!pci_dev->driver)
  1354			return 0;
  1355	
  1356		pci_fixup_device(pci_fixup_resume_early, pci_dev);
  1357		pci_pm_default_resume(pci_dev);
  1358	
  1359		if (prev_state == PCI_D3cold)
  1360			pci_pm_bridge_power_up_actions(pci_dev);
  1361	
  1362		if (pm && pm->runtime_resume)
  1363			error = pm->runtime_resume(dev);
  1364	
  1365		return error;
  1366	}
  1367	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
