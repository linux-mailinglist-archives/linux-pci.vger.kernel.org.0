Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870F65914D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 20:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiL2Tzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 14:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiL2Tzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 14:55:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AF5FCD
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 11:55:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE6561655
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 19:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E989EC433EF;
        Thu, 29 Dec 2022 19:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672343749;
        bh=URFFj4jkFc+tFnghQDARsWaYCBYiol/xBKnP7FN6/Q0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V2bB3UvZN3+azSoguJpMn3xZZjMVTh5Yh79CHkrbGYG0H+bc9p5AR1RZ5mQI66Mxp
         FeD1v9Ky9vQhX0cMURVClvlze8i6GAXkEVKZO9A7ez5ilq7pO7G7WF1IxaCBvtzZSw
         ArIR6Qv3acKKMjXSHUsJG2YqeID+wqcAkgds+PnpU443tLukKsxtwvAtKlU6BIx5Cx
         RMdzn8wld/nqP8mN2lp0cGzgMouHFGRp52ONYAC0c+LBrJlXXFRFafy3hYDATtwpzO
         RaNkU2I6iaVs6E/7QvhXJNTapW7hHwrNB8AVu9VJ1B5jwy2NfR5sKq7DK4di8Y9GUi
         2e88hZ/XOABjw==
Date:   Thu, 29 Dec 2022 13:55:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RESEND PATCH 2/3] New PCI quirk for SolidRun SNET DPU.
Message-ID: <20221229195547.GA625927@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219083511.73205-3-alvaro.karsz@solid-run.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alvaro,

Thanks for the patch!

On Mon, Dec 19, 2022 at 10:35:10AM +0200, Alvaro Karsz wrote:
> The DPU advertises FLR, but it may cause the device to hang.
> This only happens with revision 0x1.

Please update the subject line to:

  PCI: Avoid FLR for SolidRun SNET DPU rev 1

This makes the subject meaningful by itself and is similar to previous
quirks:

  5727043c73fd ("PCI: Avoid FLR for AMD Starship USB 3.0")
  0d14f06cd665 ("PCI: Avoid FLR for AMD Matisse HD Audio & USB 3.0")
  f65fd1aa4f98 ("PCI: Avoid FLR for Intel 82579 NICs")

Also, update the commit log so it says what this patch does, instead
of simply describing the current situation.

https://chris.beams.io/posts/git-commit/ is a good reference.

With the above changes,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
>  drivers/pci/quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 285acc4aacc..809d03272c2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5343,6 +5343,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  
> +/* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
> +static void quirk_no_flr_snet(struct pci_dev *dev)
> +{
> +	if (dev->revision == 0x1)
> +		quirk_no_flr(dev);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
> +
>  static void quirk_no_ext_tags(struct pci_dev *pdev)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> -- 
> 2.32.0
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
