Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703DC645CA7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 15:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLGObS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 09:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLGObM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 09:31:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4124C36C73
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670423470; x=1701959470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VsrhTY5goZhHjTyeGaxSkMMRy6iwcgLp74JX8Kl0zH8=;
  b=jlbCnpopvQDAcOikFK/fMXWobw1jSSkjfFKgN3+xVdjEA0ns9/rPepOe
   3HuvgvyntFhJlzT10mMSAsKbgzUVPg5UXaxWTtwR89ESoZwJ4Xq64Zd5r
   0Go1rWYs/uBBS7wphtQ5/MJZZfUuMD2USFW9ynvBZIP1QRcvJef6a7/yk
   5vinFplGrjNLQlf2Pm89LVTcY5PuyHunEXArXp3TclcINn02gFmxeQjzf
   eITXVRe7Tq4GU9kprWQ3xTrPtf5MAMs4Se4fK4QO3rFcbf75zOFRHUXyJ
   sakM6ui6mJdjhI22UL+dtHs5qLFANS+cbm8MubPVPqHnIBv06Jdtp5KXn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343935641"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343935641"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 06:31:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="677381908"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="677381908"
Received: from gjalliso-mobl.amr.corp.intel.com (HELO [10.212.135.231]) ([10.212.135.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 06:31:05 -0800
Message-ID: <2d00e2f1-387d-ba78-76d4-d657a942ee5b@linux.intel.com>
Date:   Wed, 7 Dec 2022 06:31:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
References: <20221207084105.84947-1-mika.westerberg@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221207084105.84947-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/7/22 12:41 AM, Mika Westerberg wrote:
> Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> or endpoints on the other hand only send messages (that get collected by
> the former). For this reason do not require PCIe switch ports and
> endpoints to use interrupt if they support AER.
> 
> This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
> discrete graphics cards. These do not declare MSI or legacy interrupts.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
> Changes from v1:
> 
>  * Updated commit message to be more specific on which hardware this is
>    needed.
> 
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
