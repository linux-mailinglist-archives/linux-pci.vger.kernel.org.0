Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061916B156A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 23:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCHWoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 17:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCHWog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 17:44:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BD91B71
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 14:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5E3619B5
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 22:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F0CC433D2;
        Wed,  8 Mar 2023 22:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678315470;
        bh=ttgafphkS4FCReKlAT1M0gYqgA8+sa7vE0ZWdOuRaxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=syuMx63l3mzAHppPWB5L0ymARuYabwMd/L2smsw2zZiJx4d3SjtEmT507xhxQaJIL
         GBnxK+yZ1Ye28DcsiBYzUeqOkCOEtUueNl0xsPofLQKEate2q5OvXkNU1HOiV3P5CB
         ZYapGnabkY4XjQTtydVYain5b3pvA6QBFZ2frxQ4TTWUAyM6fvwKSNr+e5k4R+NiwG
         AgFw1oazQpAkQLcf6yinjWrgi6wOKLrhuls1vvibgUY+ie8A/ZpiTiruXuLqo7prOL
         ehOkRL2OxnZYrT0lD69ZbHyERV09guEKDHGsXWNY1puPO0ud4CFkqgJk03p6c5F6rQ
         6ukDWZdQZbp9w==
Date:   Wed, 8 Mar 2023 16:44:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        mario.limonciello@amd.com, thomas@glanzmann.de
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230308224428.GA1050977@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306072340.172306-1-Basavaraj.Natikar@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Let's mention the vendor and device name in the subject to make the
log more useful.

On Mon, Mar 06, 2023 at 12:53:40PM +0530, Basavaraj Natikar wrote:
> One of the AMD USB controllers fails to maintain internal functional
> context when transitioning from D3 to D0, desynchronizing MSI-X bits.
> As a result, add a quirk to this controller to clear the MSI-X bits
> on suspend.

Is this a documented erratum?  Please include a citation if so.

Are there any other AMD USB devices with the same defect?

The quick clears the Function Mask bit, so the MSI-X vectors may be
*unmasked* depending on the state of each vectors Mask bit.  I assume
the potential unmasking is safe because you also clear the MSI-X
Enable bit, so the function can't use MSI-X at all.

All state is lost in D3cold, so I guess this problem must occur during
a D3hot to D0 transition, right?  I assume this device sets
No_Soft_Reset, so the function is supposed to return to D0active with
all internal state intact.  But this device returns to D0active with
the MSI-X internal state corrupted?

I assume this relies on pci_restore_state() to restore the MSI-X
state.  Seems like that might be enough to restore the internal state
even without this quirk, but I guess it must not be.

> Note: This quirk works in all scenarios, regardless of whether the
> integrated GPU is disabled in the BIOS.

I don't know how the integrated GPU is related to this USB controller,
but I assume this fact is important somehow?

> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
> Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u

Apparently the symptom is one of these:

  xhci_hcd 0000:0c:00.0: Error while assigning device slot ID: Command Aborted
  xhci_hcd 0000:0c:00.0: Max number of devices this xHCI host supports is 64.
  usb usb1-port1: couldn't allocate usb_device
  xhci_hcd 0000:0c:00.0: WARN: xHC save state timeout
  xhci_hcd 0000:0c:00.0: PM: suspend_common(): xhci_pci_suspend+0x0/0x150 [xhci_pci] returns -110
  xhci_hcd 0000:0c:00.0: can't suspend (hcd_pci_runtime_suspend [usbcore] returned -110)

We should include the critical line or two in the commit log to help
users find the fix.

I see this must be xhci_suspend() returning -ETIMEDOUT after
xhci_save_registers(), but I don't see the connection from there to a
PCI_FIXUP_SUSPEND.  Can you connect the dots for me?

> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..ddf7100227d3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6023,3 +6023,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +static void quirk_clear_msix(struct pci_dev *dev)
> +{
> +	u16 ctrl;
> +
> +	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> +	ctrl &= ~(PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
> +	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +}
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_msix);
> -- 
> 2.25.1
> 
