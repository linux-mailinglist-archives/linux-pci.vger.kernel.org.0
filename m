Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E32A359C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 21:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBU6C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 15:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgKBU5y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 15:57:54 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE8AF206E5;
        Mon,  2 Nov 2020 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604350674;
        bh=xbZHn8i0jDfuSVEZ0Oksa2dOCGUBfV80Nzny1ZBkJT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=km9zzTo5pPmsKfzc8Mq1w+gaXmsX3YfR2RHRQP9ho/Sd03XOtOtlu2Zp0gJjJZSy8
         DHSlU4qPH9za2kgkK4I/718zibShYPbKnXGvLQz9JBsTWQAZydTChUGo0ZxpG1y34V
         eM1RFAadDdqM56bwCvGGJcehMt19uC85p2bceyJw=
Date:   Mon, 2 Nov 2020 14:57:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Thomas Krause <thomaskrause@posteo.de>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        Devin Bayer <dev@doubly.so>,
        Govind Singh <govinds@codeaurora.org>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
Message-ID: <20201102205752.GA34153@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rhbvbjk.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Govind, author of 5697a564d369 ("ath11k: pci: add MSI config
initialisation")]

On Mon, Nov 02, 2020 at 08:49:51PM +0200, Kalle Valo wrote:
> + linux-wireless, linux-pci, devin
> 
> Thomas Krause <thomaskrause@posteo.de> writes:
> 
> >> I had the same problem as well back in the days, for me enabling
> >> CONFIG_IRQ_REMAP helped. If it helps for you also I wonder if we should
> >> mention that in the ath11k warning above :)
> >
> > CONFIG_IRQ_REMAP did not do the trick. I noticed that the Wi-Fi card
> > is behind a PCI bridge which is also disabled, could this be a
> > problem?
> >
> > 00:1c.0 PCI bridge: Intel Corporation Device a0b8 (rev 20) (prog-if 00
> > [Normal decode])
> > 	Flags: bus master, fast devsel, latency 0, IRQ 123
> > 	Bus: primary=00, secondary=56, subordinate=56, sec-latency=0
> > 	I/O behind bridge: [disabled]
> > 	Memory behind bridge: 8c300000-8c3fffff [size=1M]
> > 	Prefetchable memory behind bridge: [disabled]
> > 	Capabilities: [40] Express Root Port (Slot+), MSI 00
> > 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > 	Capabilities: [90] Subsystem: Dell Device 0991
> > 	Capabilities: [a0] Power Management version 3
> > 	Capabilities: [100] Advanced Error Reporting
> > 	Capabilities: [220] Access Control Services
> > 	Capabilities: [150] Precision Time Measurement
> > 	Capabilities: [200] L1 PM Substates
> > 	Capabilities: [a00] Downstream Port Containment
> > 	Kernel driver in use: pcieport
> 
> I don't know enough about PCI to say if the bridge is a problem or not.

I don't think the bridge is an issue here.  AFAICT the bridge's I/O
and prefetchable memory windows are disabled, but the non-prefetchable
window *is* enabled and contains the space consumed by the ath11k
device:

  00:1c.0 PCI bridge: Intel Corporation Device a0b8 (rev 20)
	Bus: primary=00, secondary=56, subordinate=56, sec-latency=0
	Memory behind bridge: 8c300000-8c3fffff [size=1M]
  56:00.0 Network controller: Qualcomm Device 1101 (rev 01)
     Region 0: Memory at 8c300000 (64-bit, non-prefetchable) [size=1M]

> To summarise: Thomas is reporting[1] a problem with ath11k on QCA6390
> PCI device where he is not having enough MSI vectors. ath11k needs 32
> vectors but pci_alloc_irq_vectors() returns -ENOSPC. PCI support is new
> for ath11k and introduced in v5.10-rc1. The irq allocation code is in
> drivers/net/wireless/ath/ath11k/pci.c. [2]

This code is needlessly complicated.  If you absolutely need
msi_config.total_vectors and can't settle for any less, you can do
this:

  num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
                                      msi_config.total_vectors,
                                      msi_config.total_vectors,
                                      PCI_IRQ_MSI);

  if (num_vectors < 0) {
    ath11k_err(ab, "failed to get %d MSI vectors (%d)\n",
               msi_config.total_vectors, num_vectors);
    return num_vectors;
  }

But it seems a little greedy if the device can't operate at all unless
it gets 32 vectors.  Are you sure that's a hard requirement?  Most
devices can work with fewer vectors, even if it reduces performance.

> I would first try with a full distro kernel config, just in case there's
> some another important kernel config missing.
> 
> [1] http://lists.infradead.org/pipermail/ath11k/2020-October/000466.html

Tangent: have you considered getting this list archived on
https://lore.kernel.org/lists.html?

> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath11k/pci.c#n633
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
