Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2C704A28
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjEPKKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjEPKK3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 06:10:29 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B63E4;
        Tue, 16 May 2023 03:10:03 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1D1CA30001199;
        Tue, 16 May 2023 12:10:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0F00D1CCAE8; Tue, 16 May 2023 12:10:01 +0200 (CEST)
Date:   Tue, 16 May 2023 12:10:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230516101001.GA18952@wunner.de>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:05:25PM +0000, Smita Koralahalli wrote:
> According to Section 6.7.6 of PCIe Base Specification [1], async removal
> with DPC and EDR may be unexpected and may result in a Surprise Down error.
> This error is just a side effect of hot remove. Most of the time, these
> errors will be abstract to the OS as current systems rely on Firmware-First
> model for AER and DPC, where the error handling (side effects of async
> remove) and other necessary HW sequencing actions is taken care by the FW
> and is abstract to the OS. However, FW-First model poses issues while
> rolling out updates or fixing bugs as the servers need to be brought down
> for firmware updates.
> 
> Add support for async hot-plug with native AER and DPC/EDR. Here, OS is
> responsible for handling async add and remove along with handling of AER
> and DPC events which are generated as a side-effect of async remove.

I think you can probably leave out the details about Firmware-First.
Pointing to 6.7.6 and the fact that Surprise Down Errors may occur as
an expected side-effect of surprise removal is sufficient.  They should
be treated as such.

You also want to point out what you're trying to achieve here, i.e. get
rid of irritating log messages and a 1 sec delay while pciehp waits for
DPC recovery.


> Please note that, I have provided explanation why I'm not setting the
> Surprise Down bit in uncorrectable error mask register in AER.
> https://lore.kernel.org/all/fba22d6b-c225-4b44-674b-2c62306135ed@amd.com/

Add an explanation to the commit message that masking Surprise Down Errors
was explored as an alternative approach, but scrapped due to the odd
behavior that masking only avoids the interrupt, but still records an
error per PCIe r6.0.1 sec 6.2.3.2.2.  That stale error is going to be
reported the next time some error other than Surprise Down is handled.


> Also, while testing I noticed PCI_STATUS and PCI_EXP_DEVSTA will be set
> on an async remove and will not be cleared while the device is brought
> down. I have included clearing them here in order to mask any kind of
> appearance that there was an error and as well duplicating our BIOS
> functionality. I can remove if its not necessary.

Which bits are set exactly?  Can you constrain the register write to
those bits?


> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +{
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> +		return;

Emit an error message here?


> +	/*
> +	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
> +	 * removal might be unexpected, errors might be reported as a side
> +	 * effect of the event and software should handle them as an expected
> +	 * part of this event.
> +	 */

I'd move that code comment to into dpc_handler() above the
"if (dpc_is_surprise_removal(pdev))" check.


> +	pci_aer_raw_clear_status(pdev);
> +	pci_clear_surpdn_errors(pdev);
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +}

Do you need a "wake_up_all(&dpc_completed_waitqueue);" at the end
of the function to wake up a pciehp handler waiting for DPC recovery?


> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
> +
> +	if (!(status & PCI_ERR_UNC_SURPDN))
> +		return false;
> +

You need an additional check for pdev->is_hotplug_bridge here.

And you need to read PCI_EXP_SLTCAP and check for PCI_EXP_SLTCAP_HPS.

Return false if either of them isn't set.


> +	dpc_handle_surprise_removal(pdev);
> +
> +	return true;
> +}

A function named "..._is_..." should not have any side effects.
So move the dpc_handle_surprise_removal() call down into dpc_handler()
before the "return IRQ_HANDLED;" statement.


What about ports which support AER but not DPC?  Don't you need to
amend aer.c in that case?  I suppose you don't have hardware without
DPC to test that?

Thanks,

Lukas
