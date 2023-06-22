Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62667739C5D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 11:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjFVJNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjFVJNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 05:13:22 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B3576A2;
        Thu, 22 Jun 2023 02:04:04 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1D13B300097A8;
        Thu, 22 Jun 2023 11:04:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0FCF41EAE2C; Thu, 22 Jun 2023 11:04:03 +0200 (CEST)
Date:   Thu, 22 Jun 2023 11:04:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v3 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230622090403.GA21721@wunner.de>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 21, 2023 at 06:51:51PM +0000, Smita Koralahalli wrote:
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -292,10 +292,68 @@ void dpc_process_error(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +	u16 reg16;
> +	u32 reg32;
> +
> +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
> +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);

Make this read+write conditional on "if (pdev->dpc_rp_extensions)"
as the register otherwise doesn't exist.

Wrap to 80 chars per line.


> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
> +
> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
> +}

A code comment might be useful here saying that in practice,
Surprise Down errors have been observed to also set error bits
in the Status Register as well as the Fatal Error Detected bit
in the Device Status Register.


> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +{

I'm wondering if we also need

	if (!pcie_wait_for_link(pdev, false)) {
		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
		goto out;
	}

here, similar to dpc_reset_link() and in accordance with PCIe r6.1
sec 6.2.11:

	"To ensure that the LTSSM has time to reach the Disabled state
	or at least to bring the Link down under a variety of error
	conditions, software must leave the Downstream Port in DPC
	until the Data Link Layer Link Active bit in the Link Status
	Register reads 0b; otherwise, the result is undefined."


> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
> +		pci_err(pdev, "failed to retrieve DPC root port on async remove\n");
> +		goto out;
> +	}

I don't think pci_err() is needed here as dpc_wait_rp_inactive()
already emits a message.  (I think I mistakenly gave the advice
to emit an error here in an earlier review comment -- sorry!)


> +
> +	pci_aer_raw_clear_status(pdev);
> +	pci_clear_surpdn_errors(pdev);
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +
> +out:
> +	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +	wake_up_all(&dpc_completed_waitqueue);
> +}
> +
> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);

Wrap to 80 chars.


> +
> +	if (!pdev->is_hotplug_bridge)
> +		return false;

Move this if-clause to the beginning if the function so that
you omit the unnecessary register read if it's not a hotplug
bridge.


> +
> +	if (!(status & PCI_ERR_UNC_SURPDN))
> +		return false;
> +
> +	return true;
> +}
> +
>  static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct pci_dev *pdev = context;
>  
> +	/*
> +	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
> +	 * removal might be unexpected, errors might be reported as a side
> +	 * effect of the event and software should handle them as an expected
> +	 * part of this event.
> +	 */

I think the usual way to reference the spec is "PCIe r6.0 sec 6.7.6".

Maybe that's just me but I find the code comment a little difficult
to parse.  Maybe something like the following?

	/*
	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
	 * of async removal and should be ignored by software.
	 */

Thanks,

Lukas

> +	if (dpc_is_surprise_removal(pdev)) {
> +		dpc_handle_surprise_removal(pdev);
> +		return IRQ_HANDLED;
> +	}
> +
>  	dpc_process_error(pdev);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */
> -- 
> 2.17.1
> 
