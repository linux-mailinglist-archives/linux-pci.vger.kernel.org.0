Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9C471332
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 10:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhLKJud (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 04:50:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53446 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhLKJud (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 04:50:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639216231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/a9ql3I2sdNmHx2PX3R/ThT0IPk+Ge9rowpnTQvrSA8=;
        b=I31i5uFcnLH0wkpqcicq7ZxVf1EPWfkoxsqAtqkAioWrZ7dD5aq/OuDcuammrPiJdX7xcF
        zgw6CGwgLXO8YMzLWGFCFN91y4swD2Li6osuwklXHzGO3KqkDXmF6azDpCRT/cBdWyWoGA
        um4XMHPksX7dTeu4b1Ck0ASdyBEzhgunTPpAomTcptSYZ3MCTLIPmXncoAZEMvw2xL0eRK
        SJnC0fsAJ6VfjjjrwwfiP+bmbnnj2u/tQwuers3S1e5rfZXXljrxusrsMrjdKsZjc5gJK+
        fx5+gz0gw5pUsp3aXV1teqPLtgoPhJTyeR4nrmUkkPNg1w+04Jxlh6DXcin8NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639216231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/a9ql3I2sdNmHx2PX3R/ThT0IPk+Ge9rowpnTQvrSA8=;
        b=GfRS9WhU9Z/VbaLI6Rh04RczizgLC5aiga3WmrXpjDCkBYv5yM9jFeKja2xNaw+9rJkh29
        KVX4w7jlb7bmuTAA==
To:     Marc Zyngier <maz@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, lorenzo.pieralisi@arm.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [RFC] PCI/MSI: Warning observed for NVMe with ACPI
In-Reply-To: <874k7g1yf2.wl-maz@kernel.org>
References: <47833bde-a89a-988a-6350-6e6ec90048b4@nvidia.com>
 <874k7g1yf2.wl-maz@kernel.org>
Date:   Sat, 11 Dec 2021 10:50:30 +0100
Message-ID: <87fsqzwjvd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 10 2021 at 11:39, Marc Zyngier wrote:
> On Fri, 10 Dec 2021 10:48:22 +0000,
> Jon Hunter <jonathanh@nvidia.com> wrote:
>> +       select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
>>         select POWER_RESET
>>         select POWER_SUPPLY
>>         select SPARSE_IRQ
>
> +Thomas, as he's neck-deep in the MSI rework.
>
> No, this definitely is the wrong solution.

Correct.

> arm64 doesn't need any arch fallback (I actually went out of my way to
> kill them on this architecture), and requires the individual MSI
> controller drivers to do the right thing by using MSI domains.  Adding
> this config option makes the warning disappear, but the core issue is
> that you have a device that doesn't have a MSI domain associated with
> it.
>
> So either your device isn't MSI capable (odd), your host bridge
> doesn't make the link with the MSI controller to advertise the MSI
> domain (this should normally be dealt with via IORT), or there is a
> bug of a similar sort somewhere else.

What's even more odd is:

>> [    2.725479] WARNING: CPU: 0 PID: 94 at include/linux/msi.h:264 free_msi_irqs+0x84/0x188
>> [    2.825275]  free_msi_irqs+0x84/0x188
>> [    2.825288]  __pci_enable_msix_range+0x380/0x530
>> [    2.825299]  pci_alloc_irq_vectors_affinity+0x158/0x168

From __pci_enable_msix_range() there are two ways to reach free_msi_irqs():

1) pci_alloc_irq_vectors_affinity()
     __pci_enable_msix_range()
       __pci_enable_msix()
         msix_capability_init()
           msix_setup_entries()
             alloc_msi_entry(()      -> allocation fail

2) pci_alloc_irq_vectors_affinity()
     __pci_enable_msix_range()
       __pci_enable_msix()
         msix_capability_init()
           pci_msi_setup_msi_irqs(); -> any failure after this succeeded

#1 is unlikely

#2 is odd because if the irqdomain of the device is not hierarchical,
   then the same warning should trigger already in
   pci_msi_setup_msi_irqs() via arch_setup_msi_irqs().

Strange.

Thanks,

        tglx



