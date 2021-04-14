Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C368E35FCF1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 23:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhDNVET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 17:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhDNVEO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 17:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C30060240;
        Wed, 14 Apr 2021 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618434232;
        bh=cgcS4OT2OQ9yztrLDGKDqC6WZcpOr+I4kBHjkeeifHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RyyQi/TmEIUBU+HOZ21LdL23oaLp2hBjZuOmAPFhhbi8qfzcfRIBmL6v1bCTQArTY
         coseRP6wrzY78lz0d9FYncNFhxNPVvXo+7KuJWIGGJsJt2e4lMfvKuHXJ0CY/OIBz5
         afSssNEzxZjBR0nEBGWAzZ0OhZRrCypnVzy6z3AH0nQROcwvILiTdGgEm/5e/RGFWs
         hdAKI+cBjORjkgsJ3MM05L6PWYIo+mjU0tzfFU0/QWGKVZm3AFj+iZo7PhyKOjy+lH
         SEUZ4clOsj/5gZGs3oPzTOqzfhvL1rJl8KJpjm4kc7BYYEC6iU1el7OKYSLshEMRvk
         64bdHZhw9OMJA==
Date:   Wed, 14 Apr 2021 16:03:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ingmar Klein <ingmar_klein@web.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210414210350.GA2537653@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
> Edit: Retry, as I did not consider, that my mail-client would make this
> party html.
> 
> Dear maintainers,
> I recently encountered an issue on my Proxmox server system, that
> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
> 
> On system boot and subsequent virtual machine start (with passed-through
> QCA6174), the VM would just freeze/hang, at the point where the ath10k
> driver loads.
> Quick search in the proxmox related topics, brought me to the following
> discussion, which suggested a PCI quirk entry for the QCA6174 in the kernel:
> https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.27513/
> 
> I then went ahead, got the Proxmox kernel source (v5.4.106) and applied
> the attached patch.
> Effect was as hoped, that the VM hangs are now gone. System boots and
> runs as intended.
> 
> Judging by the existing quirk entries for Atheros, I would think, that
> my proposed "fix" could be included in the vanilla kernel.
> As far as I saw, there is no entry yet, even in the latest kernel sources.

This would need a signed-off-by; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361

This is an old issue, and likely we'll end up just applying this as
yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark Atheros
AR93xx to avoid bus reset"), where it started, it seems to be
connected to 425c1b223dac ("PCI: Add Virtual Channel to save/restore
support").

I'd like to dig into that a bit more to see if there are any clues.
AFAIK Linux itself still doesn't use VC at all, and 425c1b223dac added
a fair bit of code.  I wonder if we're restoring something out of
order or making some simple mistake in the way to restore VC config.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 706f27a86a8e..ecfe80ec5b9c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3584,6 +3584,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
>  
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus

