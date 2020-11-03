Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2002A41EB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 11:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCKbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 05:31:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgKCKbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 05:31:19 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YPfyThdfqh+Ek0aAZOjucScX+kZFKAkhTa4zTnlBMU=;
        b=cJmsOmPV8GxzrObsOJzXJvTYMLL9xzFykDdEjxeqVusW8aVOVPJKjwbe7RH/Qi4KGazgb6
        EXRzP0xXM42TRoQIjBOjqlb6E6IJNMg5Uj8mAc5cqfbHJfnhvPpar3uOMOKW8ezN121T8a
        SZhNsRibqapisx5f/5weainDJpjip7on3mdg+F9fcAxJ8oPkKlaYWreRU8WbB5JD6pr4qJ
        F07XA3El6TMzHtEVCrcFtl5Mfsj+eyD8kEiVd6Zd3AuGeEJN8dVA/THmr8KCllF2pe5+Dw
        I2o5pQOvke7qTwY4QNIw/OC1C03cMdbGZqpZ5ly8lJw41X8M2mgMCZ2GC3DoNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YPfyThdfqh+Ek0aAZOjucScX+kZFKAkhTa4zTnlBMU=;
        b=k7tiSTzpqGHQ8uDde18bylPddN7ucdzaebd1+q9xcVIWj2XjHe6Ebn2vilYBp7//HFtXyS
        9Q9mwA+dO8xE2cDA==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de> <df5565a2f1e821041c7c531ad52a3344@kernel.org> <87h7q791j8.fsf@nanos.tec.linutronix.de> <877dr38kt8.fsf@nanos.tec.linutronix.de> <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
Date:   Tue, 03 Nov 2020 11:31:17 +0100
Message-ID: <87k0v27mve.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03 2020 at 09:54, Marc Zyngier wrote:
> On 2020-11-02 22:18, Thomas Gleixner wrote:
>> So we really need some other solution and removing the warning is not 
>> an option. If MSI is enabled then we want to get a warning when a PCI
>> device has no MSI domain associated. Explicitly expressing the PCIE
>> brigde misfeature of not supporting MSI is way better than silently
>> returning an error code which is swallowed anyway.
>
> I don't disagree here, though the PCI_MSI_ARCH_FALLBACKS mechanism
> makes it more difficult to establish.

Only for the few leftovers which implement msi_controller, i.e.

drivers/pci/controller/pci-hyperv.c
drivers/pci/controller/pci-tegra.c
drivers/pci/controller/pcie-rcar-host.c
drivers/pci/controller/pcie-xilinx.c

The architectures which select PCI_MSI_ARCH_FALLBACKS are:

arch/ia64/Kconfig:      select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
arch/mips/Kconfig:      select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
arch/powerpc/Kconfig:   select PCI_MSI_ARCH_FALLBACKS           if PCI_MSI
arch/s390/Kconfig:      select PCI_MSI_ARCH_FALLBACKS   if PCI_MSI
arch/sparc/Kconfig:     select PCI_MSI_ARCH_FALLBACKS if PCI_MSI

implement arch_setup_msi_irq() which makes it magically work :)

>> Whatever the preferred way is via flags at host probe time or flagging
>> it post probe I don't care much as long as it is consistent.
>
> Host probe time is going to require some changes in the core PCI api,
> as everything that checks for a MSI domain is based on the pci_bus
> structure, which is only allocated much later.

Yeah, it's nasty. One possible solution is to add flags or a callback to
pci_ops, but it's not pretty either.

I think we should go with the 'mark it after pci_host_probe()' hack for
5.10-rc. The real fix will be larger and go into 5.11.

Thoughts?

Thanks,

        tglx

