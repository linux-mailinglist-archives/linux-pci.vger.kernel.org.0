Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F43B96A7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhGATl3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 15:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhGATl3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 15:41:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F3A8613FC;
        Thu,  1 Jul 2021 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625168338;
        bh=UhAkGKW7cUMVGHA+DcsBA8sSxLionOWYHd2rVJtcjk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PXK1ZWkVa9VIqewj4n7yVblpP5YFnxC+g06A3vNwYtdDHDGdCMxviMlpoEYpxntLu
         RBYE27Td7Lkf4mBpE3DX+TbYuqpN1JTpDj+J0wI1nXl23zy8NMI+L2SIjoHm8jj6nD
         0avcNv8aGuTXpnF4zWpMdiJaZUIQEsiXBrA9sbohWdtA/r8JlX02gelvBk8AGSffNd
         9E/3l+ngXdbWG+7gEhFux9YypWXQoQnu2NNB42ZvJDFzeiLiXp775AXSRzHpG8tppn
         aMfJXPnUG3KFTIiOjUcscyvkC2SBtnluvJdJTovG+lqj+r/p+VHhhThabV76aZSdfT
         l0NgWZvSQBpiw==
Date:   Thu, 1 Jul 2021 14:38:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Straw <drbawb@fatalsyntax.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Disable Samsung SM951/PM951 NVMe before FLR
Message-ID: <20210701193856.GA82535@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430230119.2432760-1-drbawb@fatalsyntax.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 06:01:19PM -0500, Robert Straw wrote:
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
> 
> Signed-off-by: Robert Straw <drbawb@fatalsyntax.com>

Applied to pci/virtualization for v5.14, thanks!

> ---
> changes in v2:
>   - update subject to match style of ffb0863426eb 
> 
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
