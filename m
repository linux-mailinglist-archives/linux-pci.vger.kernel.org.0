Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B596CC97A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjC1Rm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC1RmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 13:42:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED8E1A7
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 10:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D4C7B80D6E
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 17:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6428C433D2;
        Tue, 28 Mar 2023 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680025342;
        bh=8Fm1l7GXYYjjxLzoo6yFTYvKhSFdMGVw/AkZglA1c7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lWBIf1Q5GLQnMaxPxnCaEyi8SBTri7skAX0Qq6Ekh6Ks4kREflRuZqPgHP6yjWuaj
         YTzdWeag3tdIsOIU2+h+6uqDd+v/19sG7tWgoQlS9xGYCZvJloJSsXgzubHh9laU2p
         2cLdoVVWB0ZJofaAPPQr2I5tqSnsr04Pbr530dNBXCe8jnIGMHYK+YiMJCmX4TV7bx
         LtmY5CBupmKeR0/RMJ/ysRx7LI6RhV7QcR/U6cw/mnhzskuQAkxEUUcd/TFc7H5AhU
         gbBnU/ERU1t4gLo0f09TjhTMXqBXWZYAxj1EFwj9DIGVRGonW9kULnzTzOoct/1BCD
         TtgpoUP+/CZhw==
Date:   Tue, 28 Mar 2023 12:42:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Basavaraj Natikar <bnatikar@amd.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230328174220.GA2953131@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0829b5-09fa-54ec-f441-1bd7bd93b791@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 28, 2023 at 06:45:48PM +0530, Basavaraj Natikar wrote:
> 
> On 3/21/2023 4:37 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 20, 2023 at 05:52:58PM -0500, Mario Limonciello wrote:
> >>> If Linux *could* do this one-time initialization, and subsequent
> >>> D0/D3hot transitions worked per spec, that would be awesome
> >>> because we wouldn't have to worry about making sure we run the
> >>> quirk at every possible transition.
> >> It can be changed again at runtime.
> >>
> >> That's exactly what we did in amdgpu for the case that the user
> >> didn't disable integrated GPU.
> >>
> >> We did the init for the IP block during amdgpu's HW init phase.
> >>
> >> I see 3 ways to address this:
> >>
> >> 1) As submitted or similar (on every D state transition work around
> >> the issue).
> >>
> >> 2) Mimic the Windows behavior in Linux by disabling MSI-X during D3
> >> entry and re-enabling on D0.
> >>
> >> 3) Look for a way to get to and program that register outside of
> >> amdgpu.
> >>
> >> There are merits to all those approaches, what do you think?
> > Without knowing anything about the difficulty of 3), that seems the
> > most attractive to me because we never have to worry about catching
> > every D state transition.
> 
> Sure Bjron we came up with below solution without worrying much on very D state
> transition and works perfectly fine.
> 
> PCI: Add quirk to clear AMD strap_15B8 NO_SOFT_RESET dev 2 f0
> 
> The AMD [1022:15b8] USB controller loses some internal functional
> MSI-X context when transitioning from D0 to D3hot. BIOS normally
> traps D0->D3hot and D3hot->D0 transitions so it can save and restore
> that internal context, but some firmware in the field lacks due to
> AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit is set.
> 
> Hence add quirk to clear AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET
> bit before USB controller initialization during boot.

I LOVE this, thank you so much for working this out!  This is SO much
better than something we have to do on every power state transition.

Can you please post again with your Signed-off-by?

I suspect this should also be moved to arch/x86/pci/fixup.c since only
x86 has <asm/amd_nb.h>.  Similarly, you might need some #ifdefs or
stubs for amd_smn_read()/amd_smn_write(), because it looks like those
only exist when CONFIG_AMD_NB=y so amd_nb.c is compiled.

> ---
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..0c088fa58ad7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -12,6 +12,7 @@
>   * file, where their drivers can use them.
>   */
>  
> +#include <asm/amd_nb.h>
>  #include <linux/bitfield.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> @@ -6023,3 +6024,21 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
> +
> +static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
> +{
> +	u32 data;
> +
> +	if (!amd_smn_read(0 , AMD_15B8_RCC_DEV2_EPF0_STRAP2, &data)) {
> +		data &= ~AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK;
> +		if (amd_smn_write(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, data))
> +			pci_err(dev, "Failed to write data 0x%x\n", data);
> +	} else {
> +		pci_err(dev, "Failed to read data 0x%x\n", data);
> +	}
> +
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
> 
>  
> 
> >
> 
