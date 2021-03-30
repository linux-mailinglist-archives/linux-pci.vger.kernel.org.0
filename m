Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C112F34F3C3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhC3Vwy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 17:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232495AbhC3Vwr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 17:52:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A091619CB;
        Tue, 30 Mar 2021 21:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617141167;
        bh=SOp20rkaIyGKU9ewpoqfFyEIAB3p+pboz1089sDQpGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oR1RNq9GjbuN9EpNK6sO3j7BVxyb5kaYO3Fr7hlWcbL0qoGN0/5j/RlGdfgQPLAdF
         Ur0VLwMtPKsRPYuwnDoGIVWETLBoBq3ezr/TISoupmeaYiU9X3RamxI+f2aC6jn1y+
         889NMaTGE/tNpdEW5C1BtfUeYvQaVlEjcT8C9HMnoYWdaoNBybE9fNuf1OfLC0L0Mw
         bmKuRASteBBPoXnfRb5oNiPD7ZzzHA++SK9QU+6w/cLk5nKx4x8whm3MER+pOGILU+
         LrRv0XP9OlAjnU5j1jC0E5JGtSncMWMNSHJDsAgImMtKJjHq3/uM3R/rhg2i+MMdNv
         SruLJp4DD7b0Q==
Date:   Tue, 30 Mar 2021 16:52:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/VPD: Remove not any longer needed Broadcom NIC
 quirk
Message-ID: <20210330215245.GA1320594@bjorn-Precision-5520>
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

Applied to pci/vpd for v5.13 with subject "PCI/VPD: Remove obsolete
Broadcom NIC quirk", thanks!

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
