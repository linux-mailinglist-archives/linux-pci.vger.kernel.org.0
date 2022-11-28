Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B463A134
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 07:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK1G2q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 01:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiK1G2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 01:28:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67613DD7
        for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2022 22:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669616922; x=1701152922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zkwZLkfMUdBi8lPyzI/1AV2hqYyTmFrStkWtsyDLRUg=;
  b=UWga3pyt2kSPdx9zFwibEm6RuW0MwnLCCNNNNjVa5iYHk9i5oaiuIbVV
   jqx41RBwTI8AwulMoQrfCB5IFyt6yy8v6ef+aHHO8o+N47Rcyrw525dy7
   iLDtTzjzXYU0UbIY1XTKpn3zpiPE6Km3EHwH3sx+vvX4NnSDDP6oetscY
   TUtMCrfW8YcP8YcpOzGY2GKKYr6NwFROcTa+bkUF6sXUJVYePPB9gFTmD
   kjXYpVEc0uH7Q1UAZKBpVy5KFO0dc6MhsTmK6ptZPjbVckJsav32+wpIw
   KsOjIwHJtKCki/9xYYZ7FzLvWTgbtXcSy354qa3paKCgbtxqThcaFEsgE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="376898327"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="376898327"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:28:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="675940066"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="675940066"
Received: from sjahmed-mobl2.amr.corp.intel.com (HELO [10.209.65.248]) ([10.209.65.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:28:41 -0800
Message-ID: <07c7fcb0-80d5-b29e-2dd3-11fb9b73cfd7@linux.intel.com>
Date:   Sun, 27 Nov 2022 22:28:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
References: <20221124093519.85363-1-mika.westerberg@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221124093519.85363-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/24/22 1:35 AM, Mika Westerberg wrote:
> Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> or endpoints on the other hand only send messages (that get collected by
> the former). For this reason do not require PCIe switch ports and
> endpoints to use interrupt if they support AER.
> 
> This allows portdrv to attach to recent Intel PCIe switch ports that
> don't declare MSI or legacy interrupts.

"Recent" looks vague. Maybe you can be more specific here.

Otherwise, it looks good to me.


> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 1ac7fec47d6f..1b1c386e50c4 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -164,7 +164,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>   */
>  static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  {
> -	int ret, i;
> +	int ret, i, type;
>  
>  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
>  		irqs[i] = -1;
> @@ -177,6 +177,19 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
>  		goto legacy_irq;
>  
> +	/*
> +	 * Only root ports and event collectors use MSI for errors. Endpoints,
> +	 * switch ports send messages to them but don't use MSI for that (PCIe
> +	 * 5.0 sec 6.2.3.2).
> +	 */
> +	type = pci_pcie_type(dev);
> +	if ((mask & PCIE_PORT_SERVICE_AER) &&
> +	    type != PCI_EXP_TYPE_ROOT_PORT && type != PCI_EXP_TYPE_RC_EC)
> +		mask &= ~PCIE_PORT_SERVICE_AER;
> +
> +	if (!mask)
> +		return 0;
> +
>  	/* Try to use MSI-X or MSI if supported */
>  	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
>  		return 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
