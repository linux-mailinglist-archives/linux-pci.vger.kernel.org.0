Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86E543B3C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiFHSQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiFHSOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:14:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41192BD3;
        Wed,  8 Jun 2022 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654712089; x=1686248089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0ECl+EWbM69BrzAUjYPqWXAVEVzjHSeQH722Tvg6qo=;
  b=Qy8839QXgbOJAjDsVNAeoncsewLy5ovCgYCLYC7+ANTLkOo6P0lEUH3D
   lbvHdMODNFPkp9b5kUxiZ7qXMPc7nQ/Nk6KFs8Pj29wjIrrZAypH282Af
   iLxmHR77cMBZtTZxBHiMTUfJu18RVcXc5YkRCjgUUAsDtzvLII2O6iwSD
   a1RU+3c+YQAD7LU9aqhBqNMNf0jIaqaTjBvkEUJZtNR3cJRQ2bCbPYvGp
   7/VAYs60NRUZsfB0UN7cvKiBrY6dgVu4ypG3+8NiSmzbJaB/OQl78BERa
   EQqoznerY1oqiG+lXjZuAl3NcSbzsadfU7Bx4QgtynM/VjmpTkXZTVAhK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="338776156"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="338776156"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 11:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="683478062"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2022 11:14:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz0CY-000Esr-LR;
        Wed, 08 Jun 2022 18:14:42 +0000
Date:   Thu, 9 Jun 2022 02:14:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     kbuild-all@lists.01.org, rajvi.jingar@linux.intel.com,
        david.e.box@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI/PM: disable PTM on all devices
Message-ID: <202206090155.uxFOFYd0-lkp@intel.com>
References: <20220607210852.475863-2-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607210852.475863-2-rajvi.jingar@linux.intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rajvi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on linus/master v5.19-rc1 next-20220608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Rajvi-Jingar/PCI-PM-refactor-pci_pm_suspend_noirq/20220608-092412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220609/202206090155.uxFOFYd0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/1bf4649d5fa01aa9d1ce606461791344adfaa2ab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rajvi-Jingar/PCI-PM-refactor-pci_pm_suspend_noirq/20220608-092412
        git checkout 1bf4649d5fa01aa9d1ce606461791344adfaa2ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/pci.c: In function 'pci_save_state':
>> drivers/pci/pci.c:1677:18: error: 'struct pci_dev' has no member named 'ptm_enabled'; did you mean 'ats_enabled'?
    1677 |         if (dev->ptm_enabled)
         |                  ^~~~~~~~~~~
         |                  ats_enabled


vim +1677 drivers/pci/pci.c

  1644	
  1645	/**
  1646	 * pci_save_state - save the PCI configuration space of a device before
  1647	 *		    suspending
  1648	 * @dev: PCI device that we're dealing with
  1649	 */
  1650	int pci_save_state(struct pci_dev *dev)
  1651	{
  1652		int i;
  1653		/* XXX: 100% dword access ok here? */
  1654		for (i = 0; i < 16; i++) {
  1655			pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
  1656			pci_dbg(dev, "saving config space at offset %#x (reading %#x)\n",
  1657				i * 4, dev->saved_config_space[i]);
  1658		}
  1659		dev->state_saved = true;
  1660	
  1661		i = pci_save_pcie_state(dev);
  1662		if (i != 0)
  1663			return i;
  1664	
  1665		i = pci_save_pcix_state(dev);
  1666		if (i != 0)
  1667			return i;
  1668	
  1669		pci_save_ltr_state(dev);
  1670		pci_save_dpc_state(dev);
  1671		pci_save_aer_state(dev);
  1672		/*
  1673		 * PCI PM core disables PTM during suspend and saves PTM state before
  1674		 * that to be able to restore the ptm state restored later. So PCI core
  1675		 * needs this check to avoid double save.
  1676		 */
> 1677		if (dev->ptm_enabled)
  1678			pci_save_ptm_state(dev);
  1679		return pci_save_vc_state(dev);
  1680	}
  1681	EXPORT_SYMBOL(pci_save_state);
  1682	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
