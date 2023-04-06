Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5F6DA4AA
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 23:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjDFVaW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDFVaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 17:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B16161B0
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 14:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20EA760FC8
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4334BC433EF;
        Thu,  6 Apr 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680816619;
        bh=JAVSKJkY9Gt7kplbiePii++v1kVgdkRvJvn/R2o1pv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OZrzxJam4j6Ymwkh7lwAeBKS+MyWInebQ+ebrYlahcaAUJFIgHqa/x+KxrR6bhLNK
         4QLfoSPB5fogBZA3EOnxw8UGaGeBblsyHesvEd2KKKYSNJ77Wlb+bClYxZbcEM6v1C
         EsWTS2Na8LY/S+0oIFB2VZrDAMNCzji1XkZRcZYWuHanBpMKsMtHD7as3JPl8w4xms
         j40Y5m3ckyThDeaHoWq3W7rLDsePj7ML/7vDS85uPvxff0o9mvGoXLJZuowOUIVwfB
         AlTUMQRxfn+GyyMy88xt88GmXQAyg+UMAdorXJKBV23A+w27ay4aE6xcxqID8YO2r5
         yH5m/NSXXekdA==
Date:   Thu, 6 Apr 2023 16:30:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-pci@vger.kernel.org,
        mario.limonciello@amd.com, thomas@glanzmann.de
Subject: Re: [PATCH] PCI: Add quirk to clear AMD strap_15B8 NO_SOFT_RESET
 dev2 f0
Message-ID: <20230406213017.GA3739450@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329172859.699743-1-Basavaraj.Natikar@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 10:58:59PM +0530, Basavaraj Natikar wrote:
> The AMD [1022:15b8] USB controller loses some internal functional
> MSI-X context when transitioning from D0 to D3hot. BIOS normally
> traps D0->D3hot and D3hot->D0 transitions so it can save and restore
> that internal context,

> but some firmware in the field lacks due to
> AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit is set.

This part doesn't have quite enough words in it.  Does the following
sound right?

  ... but some firmware in the field can't do this because it fails to
  clear the AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit.

If not, let me know and I can update it.

> Hence add quirk to clear AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET
> bit before USB controller initialization during boot.
> 
> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
> Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to for-linus for v6.3, thank you for all your work on this!

I updated the subject to:

  x86/PCI: Add quirk for AMD XHCI controller that loses MSI-X state in D3hot

so it has a little bit of context.

I also added a stable tag since I assume the same problem will occur
on older kernels.  Let me know if that's not appropriate.

Bjorn

> ---
>  arch/x86/pci/fixup.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 615a76d70019..bf5161dcf89e 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -7,6 +7,7 @@
>  #include <linux/dmi.h>
>  #include <linux/pci.h>
>  #include <linux/vgaarb.h>
> +#include <asm/amd_nb.h>
>  #include <asm/hpet.h>
>  #include <asm/pci_x86.h>
>  
> @@ -824,3 +825,23 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
>  
>  #endif
> +
> +#ifdef CONFIG_AMD_NB
> +
> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
> +
> +static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
> +{
> +	u32 data;
> +
> +	if (!amd_smn_read(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, &data)) {
> +		data &= ~AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK;
> +		if (amd_smn_write(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, data))
> +			pci_err(dev, "Failed to write data 0x%x\n", data);
> +	} else {
> +		pci_err(dev, "Failed to read data\n");
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
> +#endif
> -- 
> 2.25.1
> 
