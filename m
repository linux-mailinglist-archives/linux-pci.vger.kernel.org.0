Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A289D47164F
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 22:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhLKVCs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 16:02:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55600 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhLKVCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 16:02:48 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639256566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdNaPmn9F6G56FTGKCGEnmpOIaJzDmXbFBrEJvvwrio=;
        b=0tKE16dFBEc8E6YsBZj+rZGrOQlPLt1as9ODWymugrtlcmOekCFm2h/cq2b8f8p8E0I/1W
        bvHJ6lq3iwqzVTfngYF5F51EENiCchoeDzzSvHx47eW69tD129fnlMZImCIyr5r5pT4gTk
        tjQOEkpUortN+0nFbqwOocGBmOufUci3Pssw1wlxnwqmQh7l2OJlah86sx+jSSZ5qefkpH
        wZ4xAyP6Mp8osJMVb5Fa7Wl4AoXWenqkxQrhbQJsxt15PfxO6XQM2RaRakuEoqYrvT6wxE
        AJEPtbI4bAmdNJpz4TLrnLFuEB+DOJjz6wX+DPFiduV7SekICqJtt+Ks0tTvbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639256566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdNaPmn9F6G56FTGKCGEnmpOIaJzDmXbFBrEJvvwrio=;
        b=ql+xBv8yBTSQS0H6JUhh3/SPimjkvrZeYoQW5oi8wc+CQRF8xNe779rGl2dRgYODht1QSk
        MioR63/MnOWeE0AQ==
To:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] PCI/MSI: Only mask all MSI-X entries when MSI-X is
 used
In-Reply-To: <ee612558-18e6-1ef0-3a48-7a971fdd57f2@denx.de>
References: <20211210161025.3287927-1-sr@denx.de> <87czm3wimf.ffs@tglx>
 <ee612558-18e6-1ef0-3a48-7a971fdd57f2@denx.de>
Date:   Sat, 11 Dec 2021 22:02:46 +0100
Message-ID: <87tufevoqx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stefan,

On Sat, Dec 11 2021 at 14:58, Stefan Roese wrote:
> On 12/11/21 11:17, Thomas Gleixner wrote:
>> Can you try the patch below?
>
> Sure, please see below.
>
>> It might still be that this Marvell part really combines the per entry
>> mask bits from MSI-X with MSI, then we need both.
>
> With your patch applied only (mine not), the Masked+ is gone but still
> the MSI interrupts are not received in the system. So you seem to have
> guessed correctly, that we need both changes.

Groan. How is that device specification compliant?

Vector Control for MSI-X Table Entries
--------------------------------------

"00: Mask bit:  When this bit is set, the function is prohibited from
                sending a message using this MSI-X Table entry.
                ....
                This bit=E2=80=99s state after reset is 1 (entry is masked)=
."

So how can that work in the first place if that device is PCI
specification compliant? Seems that PCI/SIG compliance program is just
another rubberstamping nonsense.

Can someone who has access to that group please ask them what their
specification compliance stuff is actualy testing?

Sure, that went unnoticed so far on that marvelous device because the
kernel was missing a defense line, but sigh...

> How to continue? Should I integrate your patch into mine and send a new
> version? Or will you send it separately to the list for integration?

Your patch is incomplete. The function can fail later on, which results
in the same problem, no?

So we need something like the below.

Just to satisfy my curiosity:

  The device supports obviously MSI-X, which is preferred over MSI.

  So why is the MSI-X initialization failing in the first place on this
  platform?

Thanks,

        tglx
---
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -722,9 +722,6 @@ static int msix_capability_init(struct p
 		goto out_disable;
 	}
=20
-	/* Ensure that all table entries are masked. */
-	msix_mask_all(base, tsize);
-
 	ret =3D msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
 		goto out_disable;
@@ -751,6 +748,9 @@ static int msix_capability_init(struct p
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled =3D 1;
+
+	/* Ensure that all table entries are masked. */
+	msix_mask_all(base, tsize);
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
=20
 	pcibios_free_irq(dev);
@@ -777,7 +777,7 @@ static int msix_capability_init(struct p
 	free_msi_irqs(dev);
=20
 out_disable:
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_=
ENABLE, 0);
=20
 	return ret;
 }
