Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0ED30CFC2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 00:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhBBXMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 18:12:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhBBXMx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 18:12:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7F5164DAF;
        Tue,  2 Feb 2021 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612307532;
        bh=1cFcuhcaesnBFy0/qCd7MCD2HQnvNFvQ5SvlzwgnZMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ndlZnU6AehLAsneE74C1Cx/1cN4LDKFhLa5BAca7kiTXcmw48BDjlJPH1RK5oU8rZ
         bkBhE/PJn8MHJJPzkP2z/5oZhXkczhOl9mGllubTTXn6c6ww4QxsnoDpsJOmDJtwgc
         Ua5Ua3yYMmLnqEiXPU7IOK7zx4k6N6qYV5I3Cya62ZrtAmTxZkdo6zyfYEx3sDeBqu
         k1fY1NF2AJ7/FdYLog84d3peYwsZ7sRTe/hhN4wvvx712ZyHzmk05KZuZA77Lt94yk
         1usmwc19baY07LBJfXfqp0gdJan/0BBiH/Kdy/rABG/7xBrJ/BP4SEiYbdowM6GDka
         nwQw9E/XAZ3Jw==
Date:   Tue, 2 Feb 2021 17:12:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/VPD: Remove not any longer needed Broadcom NIC
 quirk
Message-ID: <20210202231210.GA148198@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa6acdf-5027-62c8-e3fb-125411b018f5@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 17, 2020 at 09:59:03PM +0100, Heiner Kallweit wrote:
> This quirk was added in 2008 [0] when we didn't have the logic yet to
> determine VPD size based on checking for the VPD end tag. Now that we
> have this logic [1] and don't read beyond the end tag this quirk can
> be removed.
> 
> [0] 99cb233d60cb ("PCI: Limit VPD read/write lengths for Broadcom 5706, 5708, 5709 rev.")
> [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> This is basically the same as what you're currently discussing
> for the Marvell / QLogic 1077 quirk.
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

So was this comment supposed to say it's *illegal* to read beyond the
end tag?

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

And for these devices we just assume the valid VPD area is only 0x80
bytes long?

And we believe that whatever 104daa71b396 ("PCI: Determine actual VPD
size on first access") figures out is safe?  I'm guessing the actual
VPD size on these NICs is determined by something on the device and it
may not be 0x80.

So I guess the risk is that 104daa71b396 figures out the actual VPD
size is, e.g., 0x100, and we now read the [0x80-0xff] region that we
didn't read before, right?

If it works, great, but it is a potential change.  I'd love to remove
these quirks.  I'm just slightly hesitant because the 99cb233d60cb
commit log and comment seem to be exactly backwards.  Am I reading
something wrong?

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
