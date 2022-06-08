Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC3543B81
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiFHS3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiFHS3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:29:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4E2FA62D;
        Wed,  8 Jun 2022 11:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AB0AB8298A;
        Wed,  8 Jun 2022 18:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D18C34116;
        Wed,  8 Jun 2022 18:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654712948;
        bh=HYG+RSUHEe202eThGL3tifGGvhcS6ub6SBS6uXFskrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F46fCgORYegHbfQdJoq1w/kwHZ+uYt+QvSgx0xYR4dWMJPAlttvwAR5GbVN3B/VUo
         QB/Q1UHR4X/jdwtLFVfXUoEV/t2TOJqC7BlwFWtG1PoVrZ/ct3KNnFsH8gmPq43bq4
         knXqwwAC8JV3FAz6pg8hUI4s5fL+oGXL7DcamSI5o1ovBYclDMm6Z/Pi/9z3c+cZXN
         8Zm1st++AH7UIQ+3XtNQd15TsVmfYHCRHMGdVktR1x5H67OLpWusf9vYOFmgot7Fo4
         zlzgj3+XhDxGkBc8b5AsAwD5gJ2xOejmXDs18x4yJASR+wDKB/SceAsmp5zWTed7z3
         grmedL/XYzPAQ==
Date:   Wed, 8 Jun 2022 13:29:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        rafael.j.wysocki@intel.com, bhelgaas@google.com,
        kbuild-all@lists.01.org, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI/PM: disable PTM on all devices
Message-ID: <20220608182906.GA409220@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206090155.uxFOFYd0-lkp@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 09, 2022 at 02:14:32AM +0800, kernel test robot wrote:
> Hi Rajvi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on helgaas-pci/next]
> [also build test ERROR on linus/master v5.19-rc1 next-20220608]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

I'll wait for the v7 to fix the warning.

At the same time, please capitalize the subject lines per convention,
and also the "set ptm_enabled" in 2/2 commit log.

> url:    https://github.com/intel-lab-lkp/linux/commits/Rajvi-Jingar/PCI-PM-refactor-pci_pm_suspend_noirq/20220608-092412
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220609/202206090155.uxFOFYd0-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/1bf4649d5fa01aa9d1ce606461791344adfaa2ab
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Rajvi-Jingar/PCI-PM-refactor-pci_pm_suspend_noirq/20220608-092412
>         git checkout 1bf4649d5fa01aa9d1ce606461791344adfaa2ab
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/pci.c: In function 'pci_save_state':
> >> drivers/pci/pci.c:1677:18: error: 'struct pci_dev' has no member named 'ptm_enabled'; did you mean 'ats_enabled'?
>     1677 |         if (dev->ptm_enabled)
>          |                  ^~~~~~~~~~~
>          |                  ats_enabled
> 
> 
> vim +1677 drivers/pci/pci.c
> 
>   1644	
>   1645	/**
>   1646	 * pci_save_state - save the PCI configuration space of a device before
>   1647	 *		    suspending
>   1648	 * @dev: PCI device that we're dealing with
>   1649	 */
>   1650	int pci_save_state(struct pci_dev *dev)
>   1651	{
>   1652		int i;
>   1653		/* XXX: 100% dword access ok here? */
>   1654		for (i = 0; i < 16; i++) {
>   1655			pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
>   1656			pci_dbg(dev, "saving config space at offset %#x (reading %#x)\n",
>   1657				i * 4, dev->saved_config_space[i]);
>   1658		}
>   1659		dev->state_saved = true;
>   1660	
>   1661		i = pci_save_pcie_state(dev);
>   1662		if (i != 0)
>   1663			return i;
>   1664	
>   1665		i = pci_save_pcix_state(dev);
>   1666		if (i != 0)
>   1667			return i;
>   1668	
>   1669		pci_save_ltr_state(dev);
>   1670		pci_save_dpc_state(dev);
>   1671		pci_save_aer_state(dev);
>   1672		/*
>   1673		 * PCI PM core disables PTM during suspend and saves PTM state before
>   1674		 * that to be able to restore the ptm state restored later. So PCI core
>   1675		 * needs this check to avoid double save.
>   1676		 */
> > 1677		if (dev->ptm_enabled)
>   1678			pci_save_ptm_state(dev);
>   1679		return pci_save_vc_state(dev);
>   1680	}
>   1681	EXPORT_SYMBOL(pci_save_state);
>   1682	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
