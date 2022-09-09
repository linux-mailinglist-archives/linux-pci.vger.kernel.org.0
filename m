Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75AA5B4328
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIIXpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 19:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIIXpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 19:45:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B64F3B9;
        Fri,  9 Sep 2022 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662767102; x=1694303102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qibUas8M4LKstHIxFpwhzFLKeKh7lGdHjYN36A8LgWY=;
  b=EizHyk2OHTmVCPUYmfPcFN6hLKeuFP29LHPCVxiDiAyZX2anCR4FcIpD
   jbg27NPcvkDkmPjEMVn1ZI1JfJ5MwK5jKQ0av29evw1EwvJF0ve005nok
   4UmSX6W1XrSqnqWTKllA3dQNLZ7IcltoiPOKLSyHC0blxVPvfpK/igwG/
   Bo04GrnpWgtA30n7dyjVAIcBsa5CWZ1PQ4RpC0bOQXmEpf3Z7/Lf7rOYH
   BOurE2qXMkIVQjK47umiJCptbiNk6lRrC3GoWYRoiA2DyQwDHYWJPXgJs
   n4cw2nkIShYLx2xtCzBX0rks4m6oAjjt3RqXktmFjv75njjmXG3wu3ubE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="359316113"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="359316113"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:44:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677365338"
Received: from gtpedreg-mobl.amr.corp.intel.com (HELO [10.209.57.19]) ([10.209.57.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:44:54 -0700
Message-ID: <e64438cf-16f1-227d-188a-56d6e7fea47b@linux.intel.com>
Date:   Fri, 9 Sep 2022 16:44:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 4/9] PCI/PTM: Add pci_suspend_ptm() and
 pci_resume_ptm()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20220909202505.314195-1-helgaas@kernel.org>
 <20220909202505.314195-5-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909202505.314195-5-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/9/22 1:25 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We disable PTM during suspend because that allows some Root Ports to enter
> lower-power PM states, which means we also need to disable PTM for all
> downstream devices.  Add pci_suspend_ptm() and pci_resume_ptm() for this
> purpose.
> 
> pci_enable_ptm() and pci_disable_ptm() are for drivers to use to enable or
> disable PTM.  They use dev->ptm_enabled to keep track of whether PTM should
> be enabled.
> 
> pci_suspend_ptm() and pci_resume_ptm() are PCI core-internal functions to
> temporarily disable PTM during suspend and (depending on dev->ptm_enabled)
> re-enable PTM during resume.
> 
> Enable/disable/suspend/resume all use internal __pci_enable_ptm() and
> __pci_disable_ptm() functions that only update the PTM Control register.
> Outline:
> 
>   pci_enable_ptm(struct pci_dev *dev)
>   {
>      __pci_enable_ptm(dev);
>      dev->ptm_enabled = 1;
>      pci_ptm_info(dev);
>   }
> 
>   pci_disable_ptm(struct pci_dev *dev)
>   {
>      if (dev->ptm_enabled) {
>        __pci_disable_ptm(dev);
>        dev->ptm_enabled = 0;
>      }
>   }
> 
>   pci_suspend_ptm(struct pci_dev *dev)
>   {
>      if (dev->ptm_enabled)
>        __pci_disable_ptm(dev);
>   }
> 
>   pci_resume_ptm(struct pci_dev *dev)
>   {
>      if (dev->ptm_enabled)
>        __pci_enable_ptm(dev);
>   }
> 
> Nothing currently calls pci_resume_ptm(); the suspend path saves the PTM

Is semicolon intentional ?

> state before disabling PTM, so the PTM state restore in the resume path
> implicitly re-enables it.  A future change will use pci_resume_ptm() to fix
> some problems with this approach.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c      |  4 +--
>  drivers/pci/pci.h      |  6 ++--
>  drivers/pci/pcie/ptm.c | 71 +++++++++++++++++++++++++++++++++---------
>  include/linux/pci.h    |  2 ++
>  4 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..83818f81577d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2714,7 +2714,7 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>  	 * lower-power idle state as a whole.
>  	 */
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> +		pci_suspend_ptm(dev);
>  
>  	pci_enable_wake(dev, target_state, wakeup);
>  
> @@ -2772,7 +2772,7 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>  	 * lower-power idle state as a whole.
>  	 */
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> +		pci_suspend_ptm(dev);
>  
>  	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 785f31086313..ce4a277e3f41 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -507,11 +507,13 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>  #ifdef CONFIG_PCIE_PTM
>  void pci_save_ptm_state(struct pci_dev *dev);
>  void pci_restore_ptm_state(struct pci_dev *dev);
> -void pci_disable_ptm(struct pci_dev *dev);
> +void pci_suspend_ptm(struct pci_dev *dev);
> +void pci_resume_ptm(struct pci_dev *dev);
>  #else
>  static inline void pci_save_ptm_state(struct pci_dev *dev) { }
>  static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
> -static inline void pci_disable_ptm(struct pci_dev *dev) { }
> +static inline void pci_suspend_ptm(struct pci_dev *dev) { }
> +static inline void pci_resume_ptm(struct pci_dev *dev) { }
>  #endif
>  
>  unsigned long pci_cardbus_resource_alignment(struct resource *);
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index ba1d50c965fa..70a28b74e721 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -29,7 +29,7 @@ static void pci_ptm_info(struct pci_dev *dev)
>  		 dev->ptm_root ? " (root)" : "", clock_desc);
>  }
>  
> -void pci_disable_ptm(struct pci_dev *dev)
> +static void __pci_disable_ptm(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
>  	u16 ctrl;
> @@ -42,6 +42,21 @@ void pci_disable_ptm(struct pci_dev *dev)
>  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
>  }
>  
> +/**
> + * pci_disable_ptm() - Disable Precision Time Measurement
> + * @dev: PCI device
> + *
> + * Disable Precision Time Measurement for @dev.
> + */
> +void pci_disable_ptm(struct pci_dev *dev)
> +{
> +	if (dev->ptm_enabled) {
> +		__pci_disable_ptm(dev);
> +		dev->ptm_enabled = 0;
> +	}
> +}
> +EXPORT_SYMBOL(pci_disable_ptm);
> +
>  void pci_save_ptm_state(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
> @@ -151,18 +166,8 @@ void pci_ptm_init(struct pci_dev *dev)
>  		pci_enable_ptm(dev, NULL);
>  }
>  
> -/**
> - * pci_enable_ptm() - Enable Precision Time Measurement
> - * @dev: PCI device
> - * @granularity: pointer to return granularity
> - *
> - * Enable Precision Time Measurement for @dev.  If successful and
> - * @granularity is non-NULL, return the Effective Granularity.
> - *
> - * Return: zero if successful, or -EINVAL if @dev lacks a PTM Capability or
> - * is not a PTM Root and lacks an upstream path of PTM-enabled devices.
> - */
> -int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> +/* Enable PTM in the Control register if possible */
> +static int __pci_enable_ptm(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
>  	struct pci_dev *ups;
> @@ -191,8 +196,29 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  		ctrl |= PCI_PTM_CTRL_ROOT;
>  
>  	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
> +	return 0;
> +}
> +
> +/**
> + * pci_enable_ptm() - Enable Precision Time Measurement
> + * @dev: PCI device
> + * @granularity: pointer to return granularity
> + *
> + * Enable Precision Time Measurement for @dev.  If successful and
> + * @granularity is non-NULL, return the Effective Granularity.
> + *
> + * Return: zero if successful, or -EINVAL if @dev lacks a PTM Capability or
> + * is not a PTM Root and lacks an upstream path of PTM-enabled devices.
> + */
> +int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> +{
> +	int rc;
> +
> +	rc = __pci_enable_ptm(dev);
> +	if (rc)
> +		return rc;
> +
>  	dev->ptm_enabled = 1;
> -
>  	pci_ptm_info(dev);
>  
>  	if (granularity)
> @@ -201,6 +227,23 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  }
>  EXPORT_SYMBOL(pci_enable_ptm);
>  
> +/*
> + * Disable PTM, but preserve dev->ptm_enabled so we silently re-enable it on
> + * resume if necessary.
> + */
> +void pci_suspend_ptm(struct pci_dev *dev)
> +{
> +	if (dev->ptm_enabled)
> +		__pci_disable_ptm(dev);
> +}
> +
> +/* If PTM was enabled before suspend, re-enable it when resuming */
> +void pci_resume_ptm(struct pci_dev *dev)
> +{
> +	if (dev->ptm_enabled)
> +		__pci_enable_ptm(dev);
> +}
> +
>  bool pcie_ptm_enabled(struct pci_dev *dev)
>  {
>  	if (!dev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 54be939023a3..cb5f796e3319 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1678,10 +1678,12 @@ bool pci_ats_disabled(void);
>  
>  #ifdef CONFIG_PCIE_PTM
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
> +void pci_disable_ptm(struct pci_dev *dev);
>  bool pcie_ptm_enabled(struct pci_dev *dev);
>  #else
>  static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  { return -EINVAL; }
> +static inline void pci_disable_ptm(struct pci_dev *dev) { }
>  static inline bool pcie_ptm_enabled(struct pci_dev *dev)
>  { return false; }
>  #endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
