Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A282FF924
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 00:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhAUX4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 18:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAUX4b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 18:56:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91CBD20717;
        Thu, 21 Jan 2021 23:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611273350;
        bh=8QjqGxP5A6Zb7kZN/Tv3TiVVxYWmPX8SjmAedowBJDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m4bvqs+0i3f4ox47gYfFnDN2U326T9Dz6O4YEwqVKhHZHdmU+kBIv1NVixkddaprp
         g/X0epRNxLZf1txzHhyC8LtzAs8qA7ttbHLVfdTVl3DaeB502YUT1P2XHW/fAcu2QW
         /E2ITwi/SasMeNVGUIuILrXDHuxgj1vVkx9Ad69aYkw4NRt6EfN26mCzLwkdrumuoj
         pdmDzHz/+aSlAj/hcxUnMRVPZZ4CPDTCAyGjS4JE1qmlgfId6u5K7wyYOAW3S9jiH6
         0QNCUNFjOd5HUckqtZ29kN8mpvmArgyphsyro2bx9Jl/QpA2V8xsodToh+exGz8Z2H
         Fjio1iJ6G9k5A==
Date:   Thu, 21 Jan 2021 17:55:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Antti =?iso-8859-1?Q?J=E4rvinen?= <antti.jarvinen@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: quirk for preventing bus reset on TI C667X
Message-ID: <20210121235547.GA2705432@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112153643.17930-1-antti.jarvinen@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Murali, Kishon]

On Tue, Jan 12, 2021 at 03:36:43PM +0000, Antti Järvinen wrote:
> TI C667X does not support bus/hot reset.
> See https://e2e.ti.com/support/processors/f/791/t/954382

You can cite the URL as the source, but the URL will eventually become
stale, so let's include the relevant details here directly.  

From the forum, it looks like the device doesn't respond after a
reset (config accesses return ~0).  It seems somewhat surprising that
something as basic as a reset would be completely broken.  I wonder if
we're not doing the reset correctly.

It looks like we would probably be trying a Secondary Bus Reset using
the bridge leading to the C667X.  Can you confirm?  Wonder if you
could try doing what pci_reset_secondary_bus() does by hand:

  # BRIDGE=...                              # PCI address, e.g., 00:1c.0
  # C667X=...
  # setpci -s$C667X VENDOR_ID.w
  # setpci -s$BRIDGE BRIDGE_CONTROL.w       # prints "val"
  # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val | 0x40 (set SBR)
  # sleep 1
  # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val (clear SBR)
  # sleep 1
  # setpci -s$C667X VENDOR_ID.w=0
  # setpci -s$C667X VENDOR_ID.w

If we use this quirk and avoid the reset, I assume that means
assigning the device to VMs with VFIO will leak state between VMs?

> Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>
> ---
>  drivers/pci/quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..c8fcf24c5bd0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3578,6 +3578,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Some TI keystone C667X devices do no support bus/hot reset.
> + * https://e2e.ti.com/support/processors/f/791/t/954382
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> -- 
> 2.17.1
> 
