Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9E370271
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhD3UwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 16:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhD3Uvz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 16:51:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B94D8613EF;
        Fri, 30 Apr 2021 20:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619815867;
        bh=425BKKf9d1upHtLcAyCMH6Ftd/hb03pDS4Y2KILynpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OTERdT9WtjZ9eJb63Jhk9+bIPcpKMIAehxtCv4FKI54U5WCZjqF44V4J0mDkgkER3
         +7os0kmxLtgAzDqSZzz27Bf8RK2cMt3702JKM7b7TvOVx43BLRiUxl2kpohVuJ7JzL
         jw6JjjJYjAIZlMzqihgYLfMsb4mSrPoIPZAeUhARaGEvs663ZupCA46Qyqx+jxSZ2D
         2F3gGVzDGGqc89yLT7DTL5Cw7MokLbBxbmsRcLXA7Ma8jaCe0KjSK0NiPPo3WcIPcH
         d1mYlltyGpcjQqXqdtF2J3Gtmp1pyGaTTQQG5eGqU+11UJwKRyNSKoAQrWqGKycf//
         CBCFywTJUX4fg==
Date:   Fri, 30 Apr 2021 15:51:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Straw <drbawb@fatalsyntax.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci: add NVMe FLR quirk to the SM951 SSD
Message-ID: <20210430205105.GA683965@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429230730.201266-1-drbawb@fatalsyntax.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, author of ffb0863426eb]

Please make your subject line match ffb0863426eb ("PCI: Disable
Samsung SM961/PM961 NVMe before FLR")

On Thu, Apr 29, 2021 at 06:07:30PM -0500, Robert Straw wrote:
> The SM951/PM951, when used in conjunction with the vfio-pci driver and
> passed to a KVM guest, can exhibit the fatal state addressed by the
> existing `nvme_disable_and_flr` quirk. If the guest cleanly shuts down
> the SSD, and vfio-pci attempts an FLR to the device while it is in this 
> state, the nvme driver will fail when it attempts to bind to the device 
> after the FLR due to the frozen config area, e.g:
> 
>   nvme nvme2: frozen state error detected, reset controller
>   nvme nvme2: Removing after probe failure status: -12
> 
> By including this older model (Samsung 950 PRO) of the controller in the
> existing quirk: the device is able to be cleanly reset after being used
> by a KVM guest.

I don't see anything in the PCIe spec about software being required to
do something special before initiating an FLR, so I assume this is a
hardware defect in the Samsung 950 PRO?  Has Samsung published an
erratum or at least acknowledged it?

There's always the possibility that we are doing something wrong in
Linux *after* the FLR, e.g., not waiting long enough, not
reinitializing something correctly, etc.

> Signed-off-by: Robert Straw <drbawb@fatalsyntax.com>
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3b..e339ca238 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3920,6 +3920,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_ivb_igd },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
>  		reset_ivb_igd },
> +	{ PCI_VENDOR_ID_SAMSUNG, 0xa802, nvme_disable_and_flr },
>  	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
>  	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> -- 
> 2.31.1
> 
