Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 838A811BFE0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 23:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfLKWem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 17:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfLKWel (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:41 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18B622527;
        Wed, 11 Dec 2019 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576103680;
        bh=EocFXRmX/mjk0xsYUnRG+hlnXXPwIbtsxS9M1s0KFkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eJ9YMs9lZbv1dGjmaMsBSohXu2qT/Kwf8VUr91LWNd/a7MN4nYjOpSYlIwbIXy3wi
         G3v/qZ9HeeS0btPfaGQ/uXf1u7fFL3jxnRBvEiaw2pm9/9HCjdbWiWzsV1gB+PJNDy
         7OBNA2GAENMG0h/SFKraVYlY+DEnrRpCnzR/ozhI=
Date:   Wed, 11 Dec 2019 16:34:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
Message-ID: <20191211223438.GA121846@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211174511.89713-1-wei.liu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
> The quirks were originally enclosed by ifdef. That made the quirks not
> to be applied when respective drivers were compiled as modules.
> 
> Move the quirks to driver code to fix the issue.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

This straddles the core and native driver boundary, so I applied it to
pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
always nice when we can encapsulate device-specific things in a
driver.

> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 24 ++++++++++++++++++
>  drivers/pci/quirks.c                         | 26 --------------------
>  2 files changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index ff0a81a632a1..4e6f7cdd9a25 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -19,6 +19,30 @@
>  #include "../pci.h"
>  #include "pcie-iproc.h"
>  
> +static void quirk_paxc_bridge(struct pci_dev *pdev)
> +{
> +	/*
> +	 * The PCI config space is shared with the PAXC root port and the first
> +	 * Ethernet device.  So, we need to workaround this by telling the PCI
> +	 * code that the bridge is not an Ethernet device.
> +	 */
> +	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +
> +	/*
> +	 * MPSS is not being set properly (as it is currently 0).  This is
> +	 * because that area of the PCI config space is hard coded to zero, and
> +	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
> +	 * so that the MPS can be set to the real max value.
> +	 */
> +	pdev->pcie_mpss = 2;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> +
>  static const struct of_device_id iproc_pcie_of_match_table[] = {
>  	{
>  		.compatible = "brcm,iproc-pcie",
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4937a088d7d8..202837ed68c9 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2381,32 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>  			 PCI_DEVICE_ID_TIGON3_5719,
>  			 quirk_brcm_5719_limit_mrrs);
>  
> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
> -static void quirk_paxc_bridge(struct pci_dev *pdev)
> -{
> -	/*
> -	 * The PCI config space is shared with the PAXC root port and the first
> -	 * Ethernet device.  So, we need to workaround this by telling the PCI
> -	 * code that the bridge is not an Ethernet device.
> -	 */
> -	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> -		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> -
> -	/*
> -	 * MPSS is not being set properly (as it is currently 0).  This is
> -	 * because that area of the PCI config space is hard coded to zero, and
> -	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
> -	 * so that the MPS can be set to the real max value.
> -	 */
> -	pdev->pcie_mpss = 2;
> -}
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> -#endif
> -
>  /*
>   * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
>   * hide device 6 which configures the overflow device access containing the
> -- 
> 2.20.1
> 
