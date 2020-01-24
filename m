Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0337814907B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 22:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAXVx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 16:53:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41648 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgAXVx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 16:53:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so2186254lfp.8
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2020 13:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HJT7W/WRXdBhAlKmOBifhojKSqvdoUdaUmLJgJ9MdU=;
        b=Y6MEqGsh7k/zNskKHAS+ylILiPoWb+Xn+ki0mKYgKGyQMZ8ZE5YJRsYzhXQtKnZVBZ
         3Zn4D2XQ9BZp8C/u2g41Jwdldu0dMd0Y3uPzS9Un5bPlzINSi+NEETRD/7n90FMnOG+K
         A0WIHrq7VoC/sx/OV9KPfd6RS9XHnh+aubq88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HJT7W/WRXdBhAlKmOBifhojKSqvdoUdaUmLJgJ9MdU=;
        b=VKn9R6KklzkxK7+db54NSuPtyUKhz+J97kR9cAIPOYPpafuO6bw+fAR4UwOy55ZIGj
         LAYh4Jq/wt27JZzt5LkTNGJAosNZYkmZEaqoD6OchOlYn9R2xQDdKMfPID2RAS39EGlj
         5MT3tA95FnPEn2Gd73YuXt8qkTLK/HasrDLg6ONH6JpG7WaGJCvuGr40JS6BkV0lJJ78
         wBho4jCN/eT8W1sd4S32JK5hNg9Bo/v5/B8ufm1ZutjSs9yI/fr1+JTnKAzl7EN9NigY
         VCWrwzTBZswKfyH2L/lUmvhwGS/CoOVQ+VGfhSBwmksFtxLkLMbqvUIwmXzNK63JWm6f
         /5yQ==
X-Gm-Message-State: APjAAAUmgNsZ/splfgroOTgBz/R2BScxPr4+nnSFmIgphFHYymASK0h/
        uScHjIsdka21vWIR+yXlvZssM1zCFlU=
X-Google-Smtp-Source: APXvYqxpiO/w/df7mZOZc89HEFUAyhqT49Y3bdCyFWNnv+5F88F10EOl+LFSLCWyfpl7QZgzsLwJZg==
X-Received: by 2002:ac2:4c2b:: with SMTP id u11mr2384515lfq.46.1579902833792;
        Fri, 24 Jan 2020 13:53:53 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f26sm3665147ljn.104.2020.01.24.13.53.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 13:53:52 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id z18so2201653lfe.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2020 13:53:52 -0800 (PST)
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr2229303lfs.99.1579902831885;
 Fri, 24 Jan 2020 13:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com> <87d0b82a9o.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d0b82a9o.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 24 Jan 2020 13:53:15 -0800
X-Gmail-Original-Message-ID: <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
Message-ID: <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 24, 2020 at 6:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Evan Green <evgreen@chromium.org> writes:
> > I did another experiment that I think lends credibility to my torn MSI
> > hypothesis. I have the following change:
> >
> > And indeed, I get a machine check, despite the fact that MSI_DATA is
> > overwritten just after address is updated.
>
> I don't have to understand why a SoC released in 2019 still has
> unmaskable MSI especially as Inhell's own XHCI spec clearly documents
> and recommends MSI-X.
>
> While your workaround (disabling MSI) works in this particular case it's
> not really a good option:
>
>  1) Quite some devices have a bug where the legacy INTX disable does not
>     work reliably or is outright broken. That means MSI disable will
>     reroute to INTX.
>
>  2) I digged out old debug data which confirms that some silly devices
>     lose interrupts accross MSI disable/reenable if the INTX fallback is
>     disabled.
>
>     And no, it's not a random weird device, it's part of a chipset which
>     was pretty popular a few years ago. I leave it as an excercise for
>     the reader to guess the vendor.
>
> Can you please apply the patch below? It enforces an IPI to the new
> vector/target CPU when the interrupt is MSI w/o masking. It should
> cure the issue. It goes without saying that I'm not proud of it.

I'll feel just as dirty putting a tested-by on it :)

I don't think this patch is complete. As written, it creates "recovery
interrupts" for MSIs that are not maskable, however through the
pci_msi_domain_write_msg() path, which is the one I seem to use, we
make no effort to mask the MSI while changing affinity. So at the very
least it would need a follow-on patch that attempts to mask the MSI,
for MSIs that are maskable. __pci_restore_msi_state(), called in the
resume path, does have this masking, but for some reason not
pci_msi_domain_write_msg().

I'm also a bit concerned about all the spurious interrupts we'll be
introducing. Not just the retriggering introduced here, but the fact
that we never dealt with the torn interrupt. So in my case, XHCI will
be sending an interrupt on the old vector to the new CPU, which could
be registered to anything. I'm worried that not every driver in the
system is hardened to receiving interrupts it's not prepared for.
Perhaps the driver misbehaves, or perhaps it's a "bad" interrupt like
the MCE interrupt that takes the system down. (I realize the MCE
interrupt itself is not in the device vector region, but some other
bad interrupt then).

Now that you're on board with the torn write theory, what do you think
about my "transit vector" proposal? The idea is this:
 - Reserve a single vector number on all CPUs for interrupts in
transit between CPUs.
 - Interrupts in transit between CPUs are added to some sort of list,
or maybe the transit vector itself.
 - __pci_msi_write_msg() would, after proper abstractions, essentially
be doing this:
    pci_write(MSI_DATA, TRANSIT_VECTOR);
    pci_write(MSI_ADDRESS, new_affinity);
    pci_write(MSI_DATA, new_vector);
 - In the rare torn case I've found here, the interrupt will come in
on <new CPU, transit_vector>, or <old CPU, transit_vector>.
 - The ISR for TRANSIT_VECTOR would go through and call the ISR for
every IRQ in transit across CPUs. This does still result in a couple
extra ISR calls, since multiple interrupts might be in transit across
CPUs, but at least it's very rare.
 - CPU hotplug would keep the same logic it already has, retriggering
TRANSIT_VECTOR if it happened to land on <old CPU, old vector>.
 - When the interrupt is confirmed on <new CPU, new vector>, remove
the ISR from the TRANSIT_VECTOR list.

If you think it's a worthwhile idea I can try to code it up.

I've been running your patch for about 30 minutes, with no repro case.
-Evan
