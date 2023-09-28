Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E27B2394
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjI1RRq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjI1RRm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 13:17:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06A1AD
        for <linux-pci@vger.kernel.org>; Thu, 28 Sep 2023 10:17:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D903AC433C8;
        Thu, 28 Sep 2023 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695921461;
        bh=0Y/q0fF3HChSAV7VSVV/Miaw5mCFfti5GmZY5d/6qSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n2r3FNo/k6diwETgcOKz9vGr//v0wZM8XayNHXaq4cFH7ArSPgWybFoUnFlR5M2uZ
         qUWl00UB53Hf1out9nir8TamQ3jfEXjXxDWEfiWARIlliNGkOneBgt+JUXoIwHZt7o
         FzbxHCYqlX+QE2ZCZ9txzo2rFhuCKoYq2dXsAmbCvDmO7MW34m1bpw7sn5N/u3jQG1
         dQ72HXGF+xcll/J4kdFCcsaFwaXeWzQ375EtfA3g2HISb/1Kq+H2ZF3Ic+r0ZKtK6r
         wcCP7hLZAkvzoNKOu/wYGVcnVP9CVZU1Ciq3wqxIwSHwNLDsTOe3Av9RTguwvIJ3pI
         gSCJkncuoCUtQ==
Date:   Thu, 28 Sep 2023 12:17:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vicki Pfau <vi@endrift.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Prevent xHCI driver from claiming AMD VanGogh USB3
 DRD device
Message-ID: <20230928171738.GA489583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927202212.2388216-1-vi@endrift.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 01:22:12PM -0700, Vicki Pfau wrote:
> The AMD VanGogh SoC contains a DesignWare USB3 Dual-Role Device that can be
> operated as either a USB Host or a USB Device, similar to on the AMD Nolan
> platform. A quirk was previously added to let the dwc3 driver claim the device
> since it provides more specific support. This commit extends that quirk to
> include the equivalent PID for the VanGogh SoC.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>

Applied to misc for v6.7, thanks!

> ---
>  drivers/pci/quirks.c    | 8 +++++---
>  include/linux/pci_ids.h | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..e3e915329510 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -690,7 +690,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
>  /*
>   * In the AMD NL platform, this device ([1022:7912]) has a class code of
>   * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
> - * claim it.
> + * claim it. The same applies on the VanGogh platform device ([1022:163a]).
>   *
>   * But the dwc3 driver is a more specific driver for this device, and we'd
>   * prefer to use it instead of xhci. To prevent xhci from claiming the
> @@ -698,7 +698,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
>   * defines as "USB device (not host controller)". The dwc3 driver can then
>   * claim it based on its Vendor and Device ID.
>   */
> -static void quirk_amd_nl_class(struct pci_dev *pdev)
> +static void quirk_amd_dwc_class(struct pci_dev *pdev)
>  {
>  	u32 class = pdev->class;
>  
> @@ -708,7 +708,9 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
>  		 class, pdev->class);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
> -		quirk_amd_nl_class);
> +		quirk_amd_dwc_class);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
> +		quirk_amd_dwc_class);
>  
>  /*
>   * Synopsys USB 3.x host HAPS platform has a class code of
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 5fb3d4c393a9..3a8e24e9a93f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -579,6 +579,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
> +#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.42.0
> 
