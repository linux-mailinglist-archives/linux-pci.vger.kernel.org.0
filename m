Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7882DDA4B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 21:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgLQUsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 15:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLQUsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Dec 2020 15:48:41 -0500
Date:   Thu, 17 Dec 2020 14:47:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608238080;
        bh=4X8F9x3ljh3MDX4MqHj97C2FZKGQV12NTt2ftUE7w8o=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=inIz06YLRd6eaX6XrPBD7m6G1K90blUzTzMrEUSBhgIBfAx5eCbp2694BaCIR5Ih0
         OJns15t3YLPObXayLJlIfqHCoFf3iIxuUOXAFBiyPbVFZ1lOfQrN3dJk1YzTAjM/DB
         JjXgkzI6k+Ygonecvrg1KX3Zavi92Xnl4DdfvfZNFWpQ8j9MsnO+h0pivTtihAk25o
         sS11KeAWmEdhafGuAhVu0FldKUXq3DY+gFP0NgnEE3YRVVUp5Hc6if1zIOBP65pNBY
         d8+8z0nhoCtCctwMAddv89tQz8zP4I02u/B5i9ue+MghV8dODE1huxgSCL9f+ZLtZB
         WbEdoJG/OetzQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Remove not any longer needed Broadcom NIC quirk
Message-ID: <20201217204759.GA21701@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c0c94d1-37bd-442f-a93e-6e2fa202526b@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 17, 2020 at 09:29:19PM +0100, Heiner Kallweit wrote:
> This quirk was added in 2008 when we didn't have the logic yet to
> determine VPD size based on checking for the VPD end tag. Now that we
> have this logic and don't read beyond the end tag this quirk can be
> removed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> This is basically the same as what you're currently discussing
> for the Marvell / QLogic 1077 quirk.

We need to reference the commit that makes the quirk unnecessary so
people can tell how far it is safe to backport this patch.

> ---
>  drivers/pci/vpd.c | 46 ----------------------------------------------
>  1 file changed, 46 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 7915d10f9..ef5165eb3 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -578,52 +578,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
>  
> -/*
> - * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
> - * VPD end tag will hang the device.  This problem was initially
> - * observed when a vpd entry was created in sysfs
> - * ('/sys/bus/pci/devices/<id>/vpd').   A read to this sysfs entry
> - * will dump 32k of data.  Reading a full 32k will cause an access
> - * beyond the VPD end tag causing the device to hang.  Once the device
> - * is hung, the bnx2 driver will not be able to reset the device.
> - * We believe that it is legal to read beyond the end tag and
> - * therefore the solution is to limit the read/write length.
> - */
> -static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
> -{
> -	/*
> -	 * Only disable the VPD capability for 5706, 5706S, 5708,
> -	 * 5708S and 5709 rev. A
> -	 */
> -	if ((dev->device == PCI_DEVICE_ID_NX2_5706) ||
> -	    (dev->device == PCI_DEVICE_ID_NX2_5706S) ||
> -	    (dev->device == PCI_DEVICE_ID_NX2_5708) ||
> -	    (dev->device == PCI_DEVICE_ID_NX2_5708S) ||
> -	    ((dev->device == PCI_DEVICE_ID_NX2_5709) &&
> -	     (dev->revision & 0xf0) == 0x0)) {
> -		if (dev->vpd)
> -			dev->vpd->len = 0x80;
> -	}
> -}
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> -			PCI_DEVICE_ID_NX2_5706,
> -			quirk_brcm_570x_limit_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> -			PCI_DEVICE_ID_NX2_5706S,
> -			quirk_brcm_570x_limit_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> -			PCI_DEVICE_ID_NX2_5708,
> -			quirk_brcm_570x_limit_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> -			PCI_DEVICE_ID_NX2_5708S,
> -			quirk_brcm_570x_limit_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> -			PCI_DEVICE_ID_NX2_5709,
> -			quirk_brcm_570x_limit_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> -			PCI_DEVICE_ID_NX2_5709S,
> -			quirk_brcm_570x_limit_vpd);
> -
>  static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>  {
>  	int chip = (dev->device & 0xf000) >> 12;
> -- 
> 2.29.2
> 
