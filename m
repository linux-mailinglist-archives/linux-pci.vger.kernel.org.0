Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0838C2C3414
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 23:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbgKXWfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 17:35:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgKXWfg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 17:35:36 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606257334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yRW3k8t/OUrpGW8c3MLXqEButobcfnyhEWJHhSJlBTM=;
        b=NEGAHRpROMitKtzsGdA4PHsRgObzoo/ECbp8sJI9Rgi7HN6KjVduYw/5NeXqp93ESkGzKJ
        PNFgwDL3avIq+ioErc1CzmZvwYcLKGFecXoXjUdzmb8wYNtTnLMSx8yVa/w4alNdnrzSYE
        nWDWvYMi8DQfRoa3+lSekcQ0eH/UvJHtdsaK6E5SzUki5v1D5Bck0u/Vw3MhdGnL3Hd9fI
        LO7uL1LV1HoWOFHUn5bqDTYRCsGkqELO/y8ogwMUU9rcsvYJDD4eHsY+L+Vy4xetWbXtzu
        UIMgaDCA+l49jKid+eKARRChyBgEmS3Ho66K879x+36wUwkCdl72cqFF3W5qPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606257334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yRW3k8t/OUrpGW8c3MLXqEButobcfnyhEWJHhSJlBTM=;
        b=ZMUN54SZWoEE76hGf7VoMwUkXmS7N4Qtkcet9EDtRmSHFQvarvQMcXjAwEc23CvP3GagUJ
        IrrQoVVzEFQgdWDQ==
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 2/2] powerpc/pseries: pass MSI affinity to irq_create_mapping()
In-Reply-To: <20201124200308.1110744-3-lvivier@redhat.com>
References: <20201124200308.1110744-1-lvivier@redhat.com> <20201124200308.1110744-3-lvivier@redhat.com>
Date:   Tue, 24 Nov 2020 23:35:34 +0100
Message-ID: <87eekil6x5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 24 2020 at 21:03, Laurent Vivier wrote:
> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>
> This problem cannot be shown on x86_64 for two reasons:

There is only _ONE_ reason why this is not a problem on x86. x86 uses
the generic PCI/MSI domain which supports this out of the box.

> - the call path traverses arch_setup_msi_irqs() that is arch specific:
>
>    virtscsi_probe()
>       virtscsi_init()
>          vp_modern_find_vqs()
>             vp_find_vqs()
>                vp_find_vqs_msix()
>                   pci_alloc_irq_vectors_affinity()
>                      __pci_enable_msix_range()
>                         pci_msi_setup_msi_irqs()
>                            arch_setup_msi_irqs()
>                               rtas_setup_msi_irqs()

This is a problem on _all_ variants of PPC MSI providers, not only for
pseries. It's not restricted to virtscsi devices either, that's just the
device which made you discover this.

Thanks,

        tglx





