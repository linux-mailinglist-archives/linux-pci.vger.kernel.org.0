Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD54F2851F5
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgJFS5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFS5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 14:57:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C93C061755;
        Tue,  6 Oct 2020 11:57:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602010660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9RVExHAFhfiLD/J+tya2zETyut3wnRGwzyKv5m9r0Q=;
        b=jv+gXVUlsJ2a5b7kNJ/46oVI0DInRlarp1cObzbzRZyIxvdzl3pABixQJt2ENsg2pvR86F
        v6np9S6suu7lgyAKCbqCtDhL5wlMmnRxRGlc4LNgX7ecGEYETsiRjbvQ6Xd86DlQ7zjS9O
        D5RR9bNOZIhBwTcaETE/gQRDkooU4rkeOFP6Hw69w2iec1YwK2PRr103foBIJ5bskO1sEn
        KxPbXN+fMOxL6vnxLvg2ernpjxxCii4suZCrG0NuWd2r+W3i1v46JoagDWAy9NI3a0uvd8
        +hnbxD/djtxxGd25eHQmC9VKAXifpNP584XZaI2SFMt8CcMigI+8XXpDI2qkEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602010660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9RVExHAFhfiLD/J+tya2zETyut3wnRGwzyKv5m9r0Q=;
        b=S2uj2/iyNS9jNMg+CSSI8CiNzw2BEPY8b1rXgzS+ckoj0G4crizVGNlCGBxDesTJoIs9iE
        cRzvpLLglUC76FAA==
To:     Dexuan Cui <decui@microsoft.com>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: irq_build_affinity_masks() allocates improper affinity if num_possible_cpus() > num_present_cpus()?
In-Reply-To: <KU1P153MB0120D20BC6ED8CF54168EEE6BF0D0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
References: <KU1P153MB0120D20BC6ED8CF54168EEE6BF0D0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
Date:   Tue, 06 Oct 2020 20:57:39 +0200
Message-ID: <87lfgj6v30.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 06 2020 at 06:47, Dexuan Cui wrote:
> I'm running a single-CPU Linux VM on Hyper-V. The Linux kernel is v5.9-rc7
> and I have CONFIG_NR_CPUS=256.
>
> The Hyper-V Host (Version 17763-10.0-1-0.1457) provides a guest firmware,
> which always reports 128 Local APIC entries in the ACPI MADT table. Here
> only the first Local APIC entry's "Processor Enabled" is 1 since this
> Linux VM is configured to have only 1 CPU. This means: in the Linux kernel,
> the "cpu_present_mask" and " cpu_online_mask " have only 1 CPU (i.e. CPU0),
> while the "cpu_possible_mask" has 128 CPUs, and the "nr_cpu_ids" is 128.
>
> I pass through an MSI-X-capable PCI device to the Linux VM (which has
> only 1 virtual CPU), and the below code does *not* report any error
> (i.e. pci_alloc_irq_vectors_affinity() returns 2, and request_irq()
> returns 0), but the code does not work: the second MSI-X interrupt is not
> happening while the first interrupt does work fine.
>
> int nr_irqs = 2;
> int i, nvec, irq;
>
> nvec = pci_alloc_irq_vectors_affinity(pdev, nr_irqs, nr_irqs,
>                 PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, NULL);

Why should it return an error?

> for (i = 0; i < nvec; i++) {
>         irq = pci_irq_vector(pdev, i);
>         err = request_irq(irq, test_intr, 0, "test_intr", &intr_cxt[i]);
> }

And why do you expect that the second interrupt works?

This is about managed interrupts and the spreading code has two vectors
to which it can spread the interrupts. One is assigned to one half of
the possible CPUs and the other one to the other half. Now you have only
one CPU online so only the interrupt with has the online CPU in the
assigned affinity mask is started up.

That's how managed interrupts work. If you don't want managed interrupts
then don't use them.

Thanks,

        tglx
