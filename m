Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3F6E53B9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDQVOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 17:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDQVOS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 17:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463D4232
        for <linux-pci@vger.kernel.org>; Mon, 17 Apr 2023 14:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B351962203
        for <linux-pci@vger.kernel.org>; Mon, 17 Apr 2023 21:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5115C433EF;
        Mon, 17 Apr 2023 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681766056;
        bh=UOKOIKCTRXkWeMQss4c9ZwEsxGzv8ZPsQifyhgZnsCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o65YI3FRbxNfyPsh4BY83o58jFEFiw52eHFwo1RGO86Jd9wLzaq7Z9UZjzvYjOt/d
         vKA5wtkFzz5XYqoaDeUnSP0a8tnwXudlcw9OMy0YIva93n8rrv9j5qzh9J2jYwRc/E
         mfdGqx2QPl1NeB5NvTAm2inAi+0PR0eKdQEKpmEJKszYN4CCusE7TbdNH6v5aaJs8v
         2+jM2hMl0XkkTE/NSk3H9GdTdbUR9R5NUyO+mznkier1pEBUVfH8qM/kzV9MKvuH18
         u8YcjrDQt1v41Jqm99XnEpmyXyFy2v9951nKiFAf4vyis8f2DOkUVeBivJt4l0lG+9
         qrC4OPPXbG6ZA==
Date:   Mon, 17 Apr 2023 16:14:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, abhsahu@nvidia.com, targupta@nvidia.com,
        zhguo@redhat.com, sdalvi@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Extend D3hot delay for NVIDIA HDA controllers
Message-ID: <20230417211414.GA48587@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413194042.605768-1-alex.williamson@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, Sathy, Lukas since they've been looking at similar delays]

On Thu, Apr 13, 2023 at 01:40:42PM -0600, Alex Williamson wrote:
> Assignment of NVIDIA Ampere-based GPUs have seen a regression since the
> below referenced commit, where the reduced D3hot transition delay appears
> to introduce a small window where a D3hot->D0 transition followed by a bus
> reset can wedge the device.  The entire device is subsequently unavailable,
> returning -1 on config space read and is unrecoverable without a host reset.
> 
> This has been observed with RTX A2000 and A5000 GPU and audio functions
> assigned to a Windows VM, where shutdown of the VM places the devices in
> D3hot prior to vfio-pci performing a bus reset when userspace releases the
> devices.  The issue has roughly a 2-3% chance of occurring per shutdown.
> 
> Restoring the HDA controller d3hot_delay to the effective value before the
> below commit has been shown to resolve the issue.  NVIDIA confirms this
> change should be safe for all of their HDA controllers.
> 
> Cc: Abhishek Sahu <abhsahu@nvidia.com>
> Cc: Tarun Gupta <targupta@nvidia.com>
> Fixes: 3e347969a577 ("PCI/PM: Reduce D3hot delay with usleep_range()")
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Reviewed-by: Tarun Gupta <targupta@nvidia.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/reset for v6.4, thanks, Alex!

I guess there's no real risk here since we're waiting *longer*.  It
only makes NVIDIA GPU resets take longer.

Mika has some patches in flight that increase delays generically in
some cases, but I think that applies to D3cold -> D0 transitions,
which I don't *think* you're doing here.

> ---
> 
> Unfortunately Tarun's reply with confirmation doesn't show up on lore,
> possibly due to html email, or else I'd provide that as a Link:.
> 
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..f4e2a88729fd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1939,6 +1939,19 @@ static void quirk_radeon_pm(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
>  
> +/*
> + * NVIDIA Ampere-based HDA controllers can wedge the whole device if a bus
> + * reset is performed too soon after transition to D0, extend d3hot_delay
> + * to previous effective default for all NVIDIA HDA controllers.
> + */
> +static void quirk_nvidia_hda_pm(struct pci_dev *dev)
> +{
> +	quirk_d3hot_delay(dev, 20);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8,
> +			      quirk_nvidia_hda_pm);
> +
>  /*
>   * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
>   * https://bugzilla.kernel.org/show_bug.cgi?id=205587
> -- 
> 2.39.2
> 
