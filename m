Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D0E5AFBC2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 07:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIGFah (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 01:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGFag (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 01:30:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EFE8049B;
        Tue,  6 Sep 2022 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662528635; x=1694064635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bF+8IT1BFqWyJxCMSBM2Y1bUZqSOdpxP8X6RhJI5J6g=;
  b=c/dakrruI2J++W4HrlqEDAdXpbj+mj4LiPgv5a7o6tGYW0Lwm8YV+HAI
   NLxA/1KfYB2ec9lYMNF9a7MELCMNC1Zbi1XFi6uQiLj0AcLyHNVdfWCOw
   JaZkGJS74O06xFqOEm2vRN0c0tqACnpYWipx7HFEgCEnPEccTt9DZLa7X
   rfIHw2Hj/SHqJhFV+i1eIpibrYLLQaBtXuajfgboDuFaRY9q2beEAbIqO
   laxp91dMGT/IEq/kLR9a7EHpNJF7KW9J4UZEjMYGbNsNHzKXl8QxGJfaf
   Hd5+fh2Ixm+RZK4PpU2LtoltwzkimmT+Cf4d/alc8TQQDAtdF9PSJKQMM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276523370"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="276523370"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="591548216"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 22:30:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B4674F7; Wed,  7 Sep 2022 08:30:47 +0300 (EEST)
Date:   Wed, 7 Sep 2022 08:30:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 07/10] PCI/PTM: Add suspend/resume
Message-ID: <YxgshzycVe5HGymH@black.fi.intel.com>
References: <20220906222351.64760-1-helgaas@kernel.org>
 <20220906222351.64760-8-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906222351.64760-8-helgaas@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 05:23:48PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 

I think it is good to explain here why this patch is needed. Even if
just one sentence.

> ---
>  drivers/pci/pci.c      |  4 ++--
>  drivers/pci/pci.h      |  4 ++++
>  drivers/pci/pcie/ptm.c | 15 +++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
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
> index 91a465460d0f..ce4a277e3f41 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -507,9 +507,13 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>  #ifdef CONFIG_PCIE_PTM
>  void pci_save_ptm_state(struct pci_dev *dev);
>  void pci_restore_ptm_state(struct pci_dev *dev);
> +void pci_suspend_ptm(struct pci_dev *dev);
> +void pci_resume_ptm(struct pci_dev *dev);
>  #else
>  static inline void pci_save_ptm_state(struct pci_dev *dev) { }
>  static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
> +static inline void pci_suspend_ptm(struct pci_dev *dev) { }
> +static inline void pci_resume_ptm(struct pci_dev *dev) { }
>  #endif
>  
>  unsigned long pci_cardbus_resource_alignment(struct resource *);
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 4a9f045126ca..8ac844212436 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -198,6 +198,21 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  }
>  EXPORT_SYMBOL(pci_enable_ptm);
>  
> +/*
> + * Disable PTM, but leave dev->ptm_enabled so we silently re-enable it on
> + * resume.
> + */

Proper kernel-doc for both.

> +void pci_suspend_ptm(struct pci_dev *dev)
> +{
> +	__pci_disable_ptm(dev);
> +}
> +
> +void pci_resume_ptm(struct pci_dev *dev)
> +{
> +	if (dev->ptm_enabled)
> +		__pci_enable_ptm(dev);
> +}
> +
>  bool pcie_ptm_enabled(struct pci_dev *dev)
>  {
>  	if (!dev)
> -- 
> 2.25.1
