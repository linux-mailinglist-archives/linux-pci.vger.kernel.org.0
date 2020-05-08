Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE941CBA3D
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEHVzQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 17:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgEHVzQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 17:55:16 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD4D21655;
        Fri,  8 May 2020 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588974915;
        bh=QzBiIELkg1C+qDFWMGUMh1SR3/R1/Yv6WqMqgVBIMw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PMKrUzgFDjtNBU9HrXrsVp617PVUm9orMHSuuq4807RbSfVJg/pP84LUCmF0EDMD/
         +7mMUjLBgrvqVAsCOCqsJ9II0XPEgNlgIr05Ciuu8qRk9RrwANZ6U6NWe8U5Vj2vgw
         nM+OzpdZlxvIfaqlJv8unbqoN/vsCDft3UXFgKAY=
Date:   Fri, 8 May 2020 16:55:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Prevent Pericom USB controller OHCI/EHCI PME#
 defect
Message-ID: <20200508215514.GA93513@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508065343.32751-2-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 08, 2020 at 02:53:41PM +0800, Kai-Heng Feng wrote:
> Both Pericom OHCI and EHCI devices support PME# from all power states:
> 06:00.0 USB controller [0c03]: Pericom Semiconductor PI7C9X442SL USB OHCI Controller [12d8:400e] (rev 01) (prog-if 10 [OHCI])
> 	Subsystem: Pericom Semiconductor PI7C9X442SL USB OHCI Controller [12d8:400e]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 17
> 	Region 0: Memory at a5502000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [80] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> 
> 06:00.2 USB controller [0c03]: Pericom Semiconductor PI7C9X442SL USB EHCI Controller [12d8:400f] (rev 01) (prog-if 20 [EHCI])
> 	Subsystem: Pericom Semiconductor PI7C9X442SL USB EHCI Controller [12d8:400f]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin C routed to IRQ 19
> 	Region 0: Memory at a5500000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> 
> Though my original approach [1] appears to work, further testing shows
> that there is a 20% chance PME# won't be asserted when USB device is
> plugged.
> 
> So remove the PME support for both devices to make USB plugging works.
> 
> [1] https://lore.kernel.org/lkml/20191227092405.29588-1-kai.heng.feng@canonical.com/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205981
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied both with Greg's ack to pci/pm for v5.8, thanks!

I added stable tags to both; let me know if you don't want that.

> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ca9ed5774eb1..db2590243f0d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5568,6 +5568,18 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
>  
> +/*
> + * Device [12d8:0x400e] and [12d8:0x400f]
> + * PME# doesn't always get asserted on all power states claim to support PME#
> + */
> +static void pci_fixup_no_pme(struct pci_dev *dev)
> +{
> +	pci_info(dev, "PME# isn't reliable, disabling it\n");
> +	dev->pme_support = 0;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
> +
>  static void apex_pci_fixup_class(struct pci_dev *pdev)
>  {
>  	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
> -- 
> 2.17.1
> 
