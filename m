Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC862E7BE
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 00:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfE2WDL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 18:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfE2WDL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 18:03:11 -0400
Received: from localhost (15.sub-174-234-174.myvzw.com [174.234.174.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D61952424E;
        Wed, 29 May 2019 22:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559167390;
        bh=fywC8toFrESDrrYh35TvRBNvPlf9/gOTXdbWgRjed2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ri+Tn6WKpvYDCCxgrilYi0Lt5XvRlo2x3YPaaZXXMdCz/y2+nLLWcWnODDnxSNYqh
         kOnX1gML6oJM30NVko57RE2rqmmMHvx3swyKWqOVs+4M39meihRtXpk/wRvOfX/qAU
         Bg/ECvLN8PRevr3bKwZmYZMdb7WbQBQLNii9A1GQ=
Date:   Wed, 29 May 2019 17:03:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maik Broemme <mbroemme@libmpq.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        vfio-users <vfio-users@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Mark Intel bridge on SuperMicro Atom C3xxx
 motherboards to avoid bus reset
Message-ID: <20190529220307.GD28250@google.com>
References: <20190524153118.GA12862@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524153118.GA12862@libmpq.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Fri, May 24, 2019 at 05:31:18PM +0200, Maik Broemme wrote:
> The Intel PCI bridge on SuperMicro Atom C3xxx motherboards do not
> successfully complete a bus reset when used with certain child devices.
> After the reset, config accesses to the child may fail. If assigning
> such device via VFIO it will immediately fail with:
> 
>   vfio-pci 0000:01:00.0: Failed to return from FLR
>   vfio-pci 0000:01:00.0: timed out waiting for pending transaction;
>   performing function level reset anyway

I guess these messages are from v4.13 or earlier, since the "Failed to
return from FLR" text was removed by 821cdad5c46c ("PCI: Wait up to 60
seconds for device to become ready after FLR"), which appeared in
v4.14.

I suppose a current kernel would fail similarly, but could you try it?
I think a current kernel would give more informative messages like:

  not ready XXms after FLR, giving up
  not ready XXms after bus reset, giving up

I don't understand the connection here: the messages you quote are
related to FLR, but the quirk isn't related to FLR.  The quirk
prevents a secondary bus reset.  So is it the case that we try FLR
first, it fails, then we try a secondary bus reset (does this succeed?
you don't mention an error from it), and the device remains
unresponsive and VFIO assignment fails?

And with the quirk, I assume we still try FLR, and it still fails.
But we *don't* try a secondary bus reset, and the device magically
works?  That's confusing to me.

> Device will disappear from PCI device list:
> 
>   !!! Unknown header type 7f
>   Kernel driver in use: vfio-pci
>   Kernel modules: ddbridge
> 
> The attached patch will mark the root port as incapable of doing a
> bus level reset. After that all my tested devices survive a VFIO
> assignment and several VM reboot cycles.
> 
> Signed-off-by: Maik Broemme <mbroemme@libmpq.org>
> ---
>  drivers/pci/quirks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0f16acc323c6..86cd42872708 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3433,6 +3433,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Root port on some SuperMicro Atom C3xxx motherboards do not successfully
> + * complete a bus reset when used with certain child devices. After the
> + * reset, config accesses to the child may fail.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19a4, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> -- 
> 2.21.0
