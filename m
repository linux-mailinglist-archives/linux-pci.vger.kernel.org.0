Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A173B93DD
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhGAP1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 11:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhGAP1p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 11:27:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A1B0613FB;
        Thu,  1 Jul 2021 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625153114;
        bh=oy7CS2cC73Awck4LkRDJSbx3cjVglQSbDgobfA6G/PE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=unv6bliIX8ll7yFsd7MslKmvessqaWgwsv7q2W3KttFTfdzEhwkYH9jZmMPRRsem0
         AD1lep5Iybwzp1ymLloldrE/l0mgPBR3dIM8ddk6ly3T1cpVM6BkhvvZFctcmURQvv
         WaM02aOuCiz76D54FE6ahcMpFzq6jYv0XnJIlje8ftucSzThZpgsjRm9wgjHjyRgW+
         H6lTYpJucWyME/BbLbpvd/GIiKAigHKiEHZ2e8eASMublXz2Z+jzGSqqLIWaQttHoz
         HK6mFzve0XNvW0nL4rJ8rF4Z+tSWLCCcSFruNJ5xbNiN+t1/HkgZPcUkjjEEUiUBhh
         K8RgE7ZIcP9+Q==
Date:   Thu, 1 Jul 2021 10:25:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        =?iso-8859-1?Q?R=F6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>,
        Zachary Zhang <zhangzg@marvell.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Ben Hutchings <ben.hutchings@essensium.com>
Subject: Re: [PATCH 1/2] PCI: Call MPS fixup quirks early
Message-ID: <20210701152512.GA55520@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624171418.27194-1-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Edward, Martin (SFC maintainers), Ben, Keith (just FYI)]

On Thu, Jun 24, 2021 at 07:14:17PM +0200, Marek Behún wrote:
> The pci_device_add() function calls header fixups only after
> pci_configure_device(), which configures MPS.

This makes good sense; the call graph looks like:

  pci_device_add
    pci_configure_device
      pci_configure_mps
        pcie_get_mps(dev)
        pcie_get_mps(bridge)
 +      pcie_set_mps(dev)             # added by 27d868b5e6cfa
    pci_fixup_device(pci_fixup_header)

> So in order to have MPS fixups working, they need to be called early.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Fixes: 27d868b5e6cfa ("PCI: Set MPS to match upstream bridge")

Before 27d868b5e6cfa, pci_configure_device() really didn't *do*
anything [1].  It read the MPS settings from the device and upstream
bridge and possibly printed a warning, but didn't change anything.

After 27d868b5e6cfa, pci_configure_device() did actually call
pcie_set_mps(), which updates the Device Control register (possibly
restricted by dev->pcie_mpss, which is set by this quirk).

The fixup_mpss_256() quirk was added in 2011 by a94d072b2023 ("PCI:
Add quirk for known incorrect MPSS").  Interesting that 27d868b5e6cfa
was merged in 2015 but apparently nobody noticed until now.  I guess
those Solarflare devices aren't widely used?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?id=27d868b5e6cfa^#n1278

> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/quirks.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 22b2bb1109c9..4d9b9d8fbc43 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3233,12 +3233,12 @@ static void fixup_mpss_256(struct pci_dev *dev)
>  {
>  	dev->pcie_mpss = 1; /* 256 bytes */
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
> -			 PCI_DEVICE_ID_SOLARFLARE_SFC4000A_0, fixup_mpss_256);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
> -			 PCI_DEVICE_ID_SOLARFLARE_SFC4000A_1, fixup_mpss_256);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
> -			 PCI_DEVICE_ID_SOLARFLARE_SFC4000B, fixup_mpss_256);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLARFLARE,
> +			PCI_DEVICE_ID_SOLARFLARE_SFC4000A_0, fixup_mpss_256);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLARFLARE,
> +			PCI_DEVICE_ID_SOLARFLARE_SFC4000A_1, fixup_mpss_256);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLARFLARE,
> +			PCI_DEVICE_ID_SOLARFLARE_SFC4000B, fixup_mpss_256);
>  
>  /*
>   * Intel 5000 and 5100 Memory controllers have an erratum with read completion
> -- 
> 2.31.1
> 
