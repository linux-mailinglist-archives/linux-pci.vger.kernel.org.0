Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CEE646427
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 23:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiLGWfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 17:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWfn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 17:35:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4C6D7C6
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 14:35:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 226E5B8212E
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 22:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F943C433D6;
        Wed,  7 Dec 2022 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670452538;
        bh=5/lmI7TZmz6kcrw7vmhxwqdTX8Ziiju7wzRSc40BlX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i3j755tz0MqIHFsnhfqohRuggnOrUBan5YGeB9bafV38HnSbQsVnYA/xTPd52pi2e
         o3fCHpCnwtDwsLxw+G6OBhVtZydXdOuaSmXp8eIvUvGhCdGyfgjExk54I3DHXM7dDj
         7BDyRRe8mKS7//QiLY9bIrbfa26ibi0qg9x3xSFQTg1BCXiJrOrmJy/PtN5RE8/M9P
         7jFWKvsUWwQl1pPw45WMU2uNpdhA6lPePo075NKDsWTIhA3olGaBZXL/7X7ZDMbQre
         f6ZTvd1RFPvqQhZ5XiVC9XdXr4gpVP1ZZSTMN5SAmamPuJ62oJgkdsixisEDpdiZ8g
         Nh2Fj/IazScVA==
Date:   Wed, 7 Dec 2022 16:35:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <20221207223537.GA1480175@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207084105.84947-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
> Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> or endpoints on the other hand only send messages (that get collected by
> the former). For this reason do not require PCIe switch ports and
> endpoints to use interrupt if they support AER.
> 
> This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
> discrete graphics cards. These do not declare MSI or legacy interrupts.

Help me understand more about this situation.  I guess we want portdrv
to attach not to a GPU itself, but to a switch port on the card that
*leads* to the GPU?

From the patch, it looks like the only PCIe port service this switch
port advertises is AER (not PME, DPC, hotplug, etc), and it doesn't
have MSI or MSI-X.

So aerdriver should be able to register for PCIE_PORT_SERVICE_AER, but
aer_probe() ignores everything except Root Ports and RCECs.  What's
the benefit then?  I must be missing something.

Bjorn

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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
> -- 
> 2.35.1
> 
