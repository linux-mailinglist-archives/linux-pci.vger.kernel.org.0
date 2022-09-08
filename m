Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2325D5B2782
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIHUPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIHUPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 16:15:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D199C217;
        Thu,  8 Sep 2022 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662668141; x=1694204141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dpmORDUkNjEtj5z4chtARUuiPmx8rWgwHKP5hgPuCLo=;
  b=MdTbxlS1sYXo8s65YlMTtkS3aTstflvhWOpQpWp0DVb2HV+ZK9QtiIBs
   PtlccpP6JJbievZ+QZpOvHYsT0OQeJTYcQASpFbhfzKcQxUYYJL0ZVLDn
   vArmuRYXGQNFOyE+J+5erV0K5w63IEpoLfUnrVMmxCduFR+cK9LdExvTK
   f4F68+ZVe0KZustjsh/GRShByi7t22yTHs3a2YlAUSJ5/qH4bEs4nH9Z3
   satE18niFYbZZV6XZEr9hkgMsmMt9P4TM7mXnRB+pY6/qGXAJfzEJWEre
   m0wJsrpFlMGg5F9IjPDVdfIQpd1MgdhQ6hpmKXKmuz4rHNSB0ziHGAjAT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284334414"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284334414"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:15:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740807787"
Received: from duttamou-mobl1.amr.corp.intel.com (HELO [10.209.109.184]) ([10.209.109.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:15:13 -0700
Message-ID: <efbe80b8-8da1-ec0c-f6c1-c5495dea1649@linux.intel.com>
Date:   Thu, 8 Sep 2022 13:15:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 09/10] PCI/PTM: Reorder functions in logical order
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
References: <20220906222351.64760-1-helgaas@kernel.org>
 <20220906222351.64760-10-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220906222351.64760-10-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/6/22 3:23 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_ptm() and pci_disable_ptm() were separated.
> pci_save_ptm_state() and pci_restore_ptm_state() dangled at the top.  Move
> them to logical places.
> 

Maybe add "No functional changes"? It will give clear meaning.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/ptm.c | 108 ++++++++++++++++++++---------------------
>  1 file changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index d65f5af9700d..6c09e00a7b51 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -9,60 +9,6 @@
>  #include <linux/pci.h>
>  #include "../pci.h"
>  
> -static void __pci_disable_ptm(struct pci_dev *dev)
> -{
> -	int ptm = dev->ptm_cap;
> -	u16 ctrl;
> -
> -	if (!ptm)
> -		return;
> -
> -	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> -	ctrl &= ~PCI_PTM_CTRL_ENABLE;
> -	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> -}
> -
> -void pci_disable_ptm(struct pci_dev *dev)
> -{
> -	__pci_disable_ptm(dev);
> -	dev->ptm_enabled = 0;
> -}
> -EXPORT_SYMBOL(pci_disable_ptm);
> -
> -void pci_save_ptm_state(struct pci_dev *dev)
> -{
> -	int ptm = dev->ptm_cap;
> -	struct pci_cap_saved_state *save_state;
> -	u16 *cap;
> -
> -	if (!ptm)
> -		return;
> -
> -	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> -	if (!save_state)
> -		return;
> -
> -	cap = (u16 *)&save_state->cap.data[0];
> -	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> -}
> -
> -void pci_restore_ptm_state(struct pci_dev *dev)
> -{
> -	int ptm = dev->ptm_cap;
> -	struct pci_cap_saved_state *save_state;
> -	u16 *cap;
> -
> -	if (!ptm)
> -		return;
> -
> -	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> -	if (!save_state)
> -		return;
> -
> -	cap = (u16 *)&save_state->cap.data[0];
> -	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> -}
> -
>  /*
>   * If the next upstream device supports PTM, return it; otherwise return
>   * NULL.  PTM Messages are local, so both link partners must support it.
> @@ -132,6 +78,40 @@ void pci_ptm_init(struct pci_dev *dev)
>  		pci_enable_ptm(dev, NULL);
>  }
>  
> +void pci_save_ptm_state(struct pci_dev *dev)
> +{
> +	int ptm = dev->ptm_cap;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!ptm)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> +}
> +
> +void pci_restore_ptm_state(struct pci_dev *dev)
> +{
> +	int ptm = dev->ptm_cap;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!ptm)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> +}
> +
>  static int __pci_enable_ptm(struct pci_dev *dev)
>  {
>  	int ptm = dev->ptm_cap;
> @@ -193,6 +173,26 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  }
>  EXPORT_SYMBOL(pci_enable_ptm);
>  
> +static void __pci_disable_ptm(struct pci_dev *dev)
> +{
> +	int ptm = dev->ptm_cap;
> +	u16 ctrl;
> +
> +	if (!ptm)
> +		return;
> +
> +	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> +	ctrl &= ~PCI_PTM_CTRL_ENABLE;
> +	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> +}
> +
> +void pci_disable_ptm(struct pci_dev *dev)
> +{
> +	__pci_disable_ptm(dev);
> +	dev->ptm_enabled = 0;
> +}
> +EXPORT_SYMBOL(pci_disable_ptm);
> +
>  /*
>   * Disable PTM, but leave dev->ptm_enabled so we silently re-enable it on
>   * resume.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
