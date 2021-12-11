Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1691D471347
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhLKKRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 05:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhLKKRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 05:17:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E878C061714
        for <linux-pci@vger.kernel.org>; Sat, 11 Dec 2021 02:17:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639217848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zF5LHx7x2tOpNqYkGjNc50ZeRPsDgTaSxTXAj7n+hSw=;
        b=A8cTyDFMXlhYnI6B3NfsBMAxefkeiJnLgOW1/GBiHI99NL9OBLSG84AJGG1PYqV7mEeKwE
        VRhT1zQbEZ/FZRBe6ld+2wAArIPM+CwCb+zQsuMW94weHaekC2jEmXixlujsQB9LJ1Nrgg
        JLRgHukUx3BHM0351RvwiwfaofZww7cC62gmHSc8SxqJ12oZm3eHo31BHhtKPQ/XoTJzIw
        hqIZJ4NH9Bp57f/B8s7JQZmrFGUeMqrMIOqVyXVZghZLndtJDakVrEctAS6sSaz9e7af3c
        xVTUQTxK+aRtwGXCok/w3Lbl3ud16zwhfEojlPSMgIVrw81Z9rLbHl/LKkH80Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639217848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zF5LHx7x2tOpNqYkGjNc50ZeRPsDgTaSxTXAj7n+hSw=;
        b=ACad5hEt143jYIhX0XLN83oVIUaY7VurG3iZq26MwIOVgTPlyzzQ4Z19M+dQR+w7fDMTsh
        lLxvRgLzBVCoGwBg==
To:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>
Subject: Re: [RFC PATCH] PCI/MSI: Only mask all MSI-X entries when MSI-X is
 used
In-Reply-To: <20211210161025.3287927-1-sr@denx.de>
References: <20211210161025.3287927-1-sr@denx.de>
Date:   Sat, 11 Dec 2021 11:17:28 +0100
Message-ID: <87czm3wimf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stefan,

On Fri, Dec 10 2021 at 17:10, Stefan Roese wrote:
> I've debugged the MSI integration of the ZynqMP PCIe rootport driver
> (pcie-xilinx-nwl.c) and found no issues there. Also the MSI framework
> in the Kernel did not reveal any problems - at least for me. Looking
> a bit deeper into the lspci output, I found an interesting difference
> between v5.4 and v5.10 (or later).
>
> v5.4:
> 04:00.0 Non-Volatile memory controller: Marvell Technology Group Ltd. Device 1321 (rev 02) (prog-if 02 [NVM Express])
>         ...
> 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> 		Address: 00000000fd480000  Data: 0004
> 		Masking: 00000000  Pending: 00000000
> 	Capabilities: [70] Express (v2) Endpoint, MSI 00
> 	...
> 	Capabilities: [b0] MSI-X: Enable- Count=67 Masked-
> 		Vector table: BAR=0 offset=00002000
> 		PBA: BAR=0 offset=00003000
> 	...
>
> v5.10:
> 04:00.0 Non-Volatile memory controller: Marvell Technology Group Ltd. Device 1321 (rev 02) (prog-if 02 [NVM Express])
>         ...
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>                 Address: 00000000fd480000  Data: 0004
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>         ...
>         Capabilities: [b0] MSI-X: Enable- Count=67 Masked+
>                 Vector table: BAR=0 offset=00002000
>                 PBA: BAR=0 offset=00003000
>         ...
>
> So the only difference here being the "Masked+" compared to the
> "Masked-" in the working v5.4 Kernel. Testing in this area has shown,
> that the root cause for the masked bit being set was the call to
> msix_mask_all() in msix_capability_init(). Without this, all works just
> fine and the MSI interrupts are received again by the NVMe driver.

Not really. The Masked+ in the capabilities entry has nothing to do with
the entries in the table being masked. The Masked+ reflects the
PCI_MSIX_FLAGS_MASKALL bit in the MSI-X control register.

That is set early on and not cleared in the error handling path. The
error handling just clears the MSIX_FLAGS_ENABLE bit.

Can you try the patch below?

It might still be that this Marvell part really combines the per entry
mask bits from MSI-X with MSI, then we need both.

Thanks,

        tglx
---
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -777,7 +777,7 @@ static int msix_capability_init(struct p
 	free_msi_irqs(dev);
 
 out_disable:
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
 
 	return ret;
 }
