Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5756DA4E0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 23:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDFVu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 17:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDFVuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 17:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E783CE
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 14:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11281646B5
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 21:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E869C433EF;
        Thu,  6 Apr 2023 21:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680817851;
        bh=Iny1JWzRXL7Tcpqe/FXdvXkodoqQ/DnblWoEFuwrhEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hXf9QiLxE7GPD990/s6YdkiCZ3oRt2/k7//vzV187J2q1dNDUC9WK127hRdyIl51T
         nUycKC8EHZ80CF93geMyMpa7rKgli44P2CLaYYG3Dj+y0b5DRA22aix+PSjULBCQCs
         ikx7aNAv6canzs2MIsHdog0GRIWwj/32v3TjH61JWA3jMi/B3NSwcDGLmSwvQp8DjK
         PR/gi14KJMkzmuBb1E09Vc47BAkDx56Dp+bevyqnXdga6LWvdjpxYXOyxNQkH5IT6Z
         rzkVQR1gGZ3RjHrZMQLNWJfaxBgulcw/iOjBzh445OZSvHqltrw8PBoze5XROrcMbk
         nsGDEE+7gqwug==
Date:   Thu, 6 Apr 2023 16:50:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, abhsahu@nvidia.com, targupta@nvidia.com,
        zhguo@redhat.com, Sajid Dalvi <sdalvi@google.com>
Subject: Re: [RFC PATCH] PCI: Extend D3hot delay for NVIDIA HDA controllers
Message-ID: <20230406215049.GA3741554@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168004421186.935858.12296629041962399467.stgit@omen>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sajid, author of 3e347969a577]

On Tue, Mar 28, 2023 at 04:59:30PM -0600, Alex Williamson wrote:
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
> below commit has been shown to resolve the issue.

Interesting.  This sounds like it was a hassle to track down.  I guess
we knew there was some risk in reducing those delays.

Did you by chance notice whether the actual delay when the device gets
wedged is sufficient per spec?

If there's a case where the usleep_range() doesn't quite wait the
spec-mandated time, we should adjust that in case we have the same
problem with other devices.

> I'm looking for input from NVIDIA whether this issue is unique to
> Ampere-based HDA controllers or should be assumed to linger in both older
> and newer controllers as well.  Currently we've not been able to reproduce
> the issue other than on Ampere HDA controllers, however the implementation
> here includes all NVIDIA HDA controllers based on PCI vendor and device
> class.
> 
> If we were to limit the quirk to Ampere HDA controllers, I think that would
> include:
> 
> 1aef	GA102 High Definition Audio Controller
> 228b	GA104 High Definition Audio Controller
> 228e	GA106 High Definition Audio Controller
> 
> Cc: Abhishek Sahu <abhsahu@nvidia.com>
> Cc: Tarun Gupta <targupta@nvidia.com>
> Fixes: 3e347969a577 ("PCI/PM: Reduce D3hot delay with usleep_range()")
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/quirks.c |   13 +++++++++++++
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
> 
> 
