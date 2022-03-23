Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E034E4AE4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 03:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbiCWC2W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 22:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbiCWC2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 22:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2CD70849;
        Tue, 22 Mar 2022 19:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A8B614A8;
        Wed, 23 Mar 2022 02:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC59C340F3;
        Wed, 23 Mar 2022 02:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648002410;
        bh=I0pEfglO0yt0xCKf2wZmloRgsww6wV2diAt8iOVavzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UqDZT02mq2UVYAxkEODaMI7jLFRlVDRq2NZ53Z5b3DcpqNKSzyYHqI3y9UW0mRwq2
         gY+ZaA6HvhmsNUyGhcKkulP/G8DHWBVEFVFLQRKs8qTDadV2f1wg1yxEvRHl7e4ZWP
         JNiU5GnCUDp0hy7fwdlohqfpL1CP/0QfZd9JBFTjGyLIbXc1JNuYYJ8dvSUQNVcFk9
         kI8XexkuIIb5Ptkr7pNl5A3pVA+DyzGs16BM4EVqYfH/vmjnC3kMks3ZlDb/e3yAqd
         vib8vTzlroMRYgS63ey5NTCPJ7zfOvCwCB8tVh6hjj4mZ0VbI+Fn1EOLLhVrKfslC0
         CJbj9AiTN+UkA==
Date:   Tue, 22 Mar 2022 21:26:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org,
        Mick Lorain <micklorain@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Avoid broken MSI on SB600 USB devices
Message-ID: <20220323022648.GA1243295@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321183446.1108325-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 01:34:46PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some ATI SB600 USB adapters advertise MSI, but if INTx is disabled by
> setting PCI_COMMAND_INTX_DISABLE, MSI doesn't work either.  The PCI/PCIe
> specs do not require software to set PCI_COMMAND_INTX_DISABLE when enabling
> MSI, but Linux has done that for many years.
> 
> Mick reported that 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI
> devices") broke these devices.  Prior to 306c54d0edb6, they used INTx.
> Starting with 306c54d0edb6, they use MSI, and and the fact that Linux sets
> PCI_COMMAND_INTX_DISABLE means both INTx and MSI are disabled on these
> devices.
> 
> Avoid this SB600 defect by disabling MSI so we use INTx as before.
> 
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215690
> Link: https://lore.kernel.org/all/PxIByDyBRcsbpcmVhGSNDFAoUcMmb78ctXCkw6fbpx25TGlCHvA6SJjjFkNr1FfQZMntYPTNyvEnblxzAZ8a6jP9ddLpKeCN6Chi_2FuexU=@protonmail.com/
> BugLink: https://lore.kernel.org/all/20200702143045.23429-1-andriy.shevchenko@linux.intel.com/
> Link: https://lore.kernel.org/r/20220314101448.90074-1-andriy.shevchenko@linux.intel.com
> Reported-by: Mick Lorain <micklorain@protonmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Unless there's objection, I plan to include this in the v5.18 pull
request in the next few days.

It was in the 20220322 linux-next tree:
https://lore.kernel.org/linux-next/20220322203829.2bb0166c@canb.auug.org.au/

> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d2dd6a6cda60..5f46fed01e6c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1811,6 +1811,18 @@ static void quirk_alder_ioapic(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic);
>  #endif
>  
> +static void quirk_no_msi(struct pci_dev *dev)
> +{
> +	pci_info(dev, "avoiding MSI to work around a hardware defect\n");
> +	dev->no_msi = 1;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4386, quirk_no_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4387, quirk_no_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4388, quirk_no_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4389, quirk_no_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438a, quirk_no_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438b, quirk_no_msi);
> +
>  static void quirk_pcie_mch(struct pci_dev *pdev)
>  {
>  	pdev->no_msi = 1;
> -- 
> 2.25.1
> 
