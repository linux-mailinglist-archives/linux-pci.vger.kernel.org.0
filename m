Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE306AB822
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCFIWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 03:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCFIWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 03:22:40 -0500
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 00:22:37 PST
Received: from infra.glanzmann.de (infra.glanzmann.de [IPv6:2a01:4f8:b0:3ffe::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1121E5C2
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 00:22:37 -0800 (PST)
Received: by infra.glanzmann.de (Postfix, from userid 1000)
        id B9BA87A8007D; Mon,  6 Mar 2023 09:14:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
        s=infra26101010; t=1678090475;
        bh=osOdvfYRsj3TzBJmcCOYRXucd98axOnx53D0B1+7mS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHrLhdoI9DcEniayOkYv5XlKz3rItT3wd3LvlUtXNwDf+j2Yfhmz4wWjKpPwTtbyO
         Blz58jF7O6n1uvybCn64mZtyL9go6frl5aywN+trtQBoWb5Aq3GqtgYI+GFk7TP8oi
         1IBwj5Vp6w/Cvy1vYem+XRcm7UBgR8QXVf+3/RJZfC4Puq9eZ68p9K73da9B62irmv
         KMSHuqJ8kaIfbjH9fEXrjEEEzuciQfR0ql0meQoASoGzgDiQsDmVBKVLxmwxynYTgP
         r784VBOc+m+L7frUZrz43RkOmPDbLAKER+Ragok/Fnd7A1xJgHCLMxVJqPwSzHSl5D
         qrgY5aAYBVXBBiIrwIhscKQMZyk9OJ52o2wSPH3aBZVd+8GH4Wj2iy6OPhIAGEA+yR
         qepYv53BYYXgHUXkAT2GsFodPN6FVQHHpFPYjE0YFf3Xzwp+O4sWdCnf4DQ8ogchIs
         I4L1yaSjYDeo3PbTpxRf+4OVY115DMsn2Gv3EHAOcLXAxHv7wfetSwa1gygxLA1mxY
         jXrxjY9cMt9chH+mzJhNFLpopzEt747lpairiQy4OcK2uHcZP7tcKvcCzH1DMEeYd0
         n6edxhCwJrWvJzpeSPEE4Gzh0bXVfkwxki4ElEMzHF4Gi5z91wElGeMGOPO35io9mJ
         aWYAqkzVNoFN4pnWuzR5ED0w=
Date:   Mon, 6 Mar 2023 09:14:35 +0100
From:   Thomas Glanzmann <thomas@glanzmann.de>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        mario.limonciello@amd.com, Yulia Glanzmann <yulia@glanzmann.de>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <ZAWg60alY7D7g+em@glanzmann.de>
References: <20230306072340.172306-1-Basavaraj.Natikar@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306072340.172306-1-Basavaraj.Natikar@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

* Basavaraj Natikar <Basavaraj.Natikar@amd.com> [2023-03-06 08:24]:
> One of the AMD USB controllers fails to maintain internal functional
> context when transitioning from D3 to D0, desynchronizing MSI-X bits.
> As a result, add a quirk to this controller to clear the MSI-X bits
> on suspend.

> Note: This quirk works in all scenarios, regardless of whether the
> integrated GPU is disabled in the BIOS.

I tested the patch on top of v6.2.2 and USB hotplug works. Dmesg is here:

https://pbot.rmdir.de/H1BcUKbZUQQJ7NB6UylFEQ

> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>

Tested-by: Thomas Glanzmann <thomas@glanzmann.de>

> Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

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

Thank you for the patch.

Cheers,
        Thomas
