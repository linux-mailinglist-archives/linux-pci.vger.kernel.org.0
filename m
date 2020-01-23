Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFC145FAA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 01:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAWAIW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 19:08:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46658 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWAIV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 19:08:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so1075490ljc.13
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 16:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljR4qIScgnHlVgotRz5jvHzcfQpNvaV3xGDWeSwVuWI=;
        b=VlyKzP0aHglwI0D+fnQ6xSvab3aMMbG4BkNrmqROWoeBP1sfY1F+z/40Y6ZaJ9RRoS
         VMI1GSrctXZvVoV1+bCx+hEvKrzCoQ6AriVBgiSP9kt9mQkzCBExmT+f7c0T97GT4ufO
         twLmXNlfgnlTSMMciIYIpm4Rz/XgTauBDiaSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljR4qIScgnHlVgotRz5jvHzcfQpNvaV3xGDWeSwVuWI=;
        b=OlQsWRNCf92QthIHVWJNtK+1IiTOYUY7GDiwysGQ8gkJAZzRsxA1bc4hhH9aNpWxg8
         5En3PWNPmvMgv75VLLNBxyeESHJcjX14UXVLVB4TFyYqg5CucrA2+f0ZYHEIMFGvfRDS
         lAqHT6Irft7mNvnucQyhIDinceYA+yQt6kwAaqOxM/klfCJbz3oDY5Vm2fNuI21EjJrq
         Z2owWRd0hCUgq1Hte/gZsxdGoAk/5rvRAQaWz8sAWkAxyvsZ6XI+clL//JStphG524+/
         Pv6/aGdr3JRlsjEaSR8GrRhlPPDGcwTeHmNjQF1plSmvOt1gyMlNtk5TDo0jAVOpnAm1
         030Q==
X-Gm-Message-State: APjAAAUx9O4ldOB5vlhv9ssVZnmrxJi/WDGX94GiojYzCzygmyvqjCUC
        EPriCDM7FKMUnt6HlOw8o29fcETou6Y=
X-Google-Smtp-Source: APXvYqyKXJOuXgXWYpUDYj2XQ5KuyN8VKbumorEp+RvulsoUJcBYh1TxFZVXxahSXT/uVWcNGP+ugg==
X-Received: by 2002:a2e:b610:: with SMTP id r16mr18469761ljn.33.1579738098639;
        Wed, 22 Jan 2020 16:08:18 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i19sm95149lfj.17.2020.01.22.16.08.17
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 16:08:17 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id z18so982102lfe.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 16:08:17 -0800 (PST)
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr2832952lfs.99.1579738097075;
 Wed, 22 Jan 2020 16:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <20200122172816.GA139285@google.com> <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
 <875zh3ukoy.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zh3ukoy.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 22 Jan 2020 16:07:40 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com>
Message-ID: <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 22, 2020 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan Green <evgreen@chromium.org> writes:
> > On Wed, Jan 22, 2020 at 9:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> I suspect this *is* a problem because I think disabling MSI doesn't
> >> disable interrupts; it just means the device will interrupt using INTx
> >> instead of MSI.  And the driver is probably not prepared to handle
> >> INTx.
> >>
> >> PCIe r5.0, sec 7.7.1.2, seems relevant: "If MSI and MSI-X are both
> >> disabled, the Function requests servicing using INTx interrupts (if
> >> supported)."
>
> Disabling MSI is not an option. Masking yes, but MSI does not have
> mandatory masking. We already attempt masking on migration, which covers
> only MSI-X reliably, but not all MSI incarnations.
>
> So I assume that problem happens on a MSI interrupt, right?
>
> >> Maybe the IRQ guys have ideas about how to solve this?
>
> Maybe :)
>
> > But don't we already do this in __pci_restore_msi_state():
> >         pci_intx_for_msi(dev, 0);
> >         pci_msi_set_enable(dev, 0);
> >         arch_restore_msi_irqs(dev);
> >
> > I'd think if there were a chance for a line-based interrupt to get in
> > and wedge itself, it would already be happening there.
>
> That's a completely different beast. It's used when resetting a device
> and for other stuff like virt state migration. That's not a model for
> affinity changes of a live device.

Hm. Ok.

>
> > One other way you could avoid torn MSI writes would be to ensure that
> > if you migrate IRQs across cores, you keep the same x86 vector number.
> > That way the address portion would be updated, and data doesn't
> > change, so there's no window. But that may not actually be feasible.
>
> That's not possible simply because the x86 vector space is limited. If
> we would have to guarantee that then we'd end up with a max of ~220
> interrupts per system. Sufficient for your notebook, but the big iron
> people would be not amused.

Right, that occurred to me as well. The actual requirement isn't quite
as restrictive. What you really need is the old vector to be
registered on both the old CPU and the new CPU. Then once the
interrupt is confirmed to have moved we could release both the old
vector both CPUs, leaving only the new vector on the new CPU.

In that world some SMP affinity transitions might fail, which is a
bummer. To avoid that, you could first migrate to a vector that's
available on both the source and destination CPUs, keeping affinity
the same. Then change affinity in a separate step.

Or alternatively, you could permanently designate a "transit" vector.
If an interrupt fires on this vector, then we call all ISRs currently
in transit between CPUs. You might end up calling ISRs that didn't
actually need service, but at least that's better than missing edges.

>
> The real critical path here is the CPU hotplug path.
>
> For regular migration between two online CPUs we use the 'migrate when
> the irq is actually serviced ' mechanism. That might have the same issue
> on misdesigned devices which are firing the next interrupt before the
> one on the flight is serviced, but I haven't seen any reports with that
> symptom yet.
>
> But before I dig deeper into this, please provide the output of
>
> 'lscpci -vvv' and 'cat /proc/interrupts'
>

Here it is:
https://pastebin.com/YyxBUvQ2

This is a Comet Lake system. It has 8 HT cores, but 4 of those cores
have already been offlined.

At the bottom of the paste I also included the script I used that
causes a repro in a minute or two. I simply run this, then put some
stress on USB. For me that stress was "join a Hangouts meeting", since
that stressed both my USB webcam and USB ethernet. The script exits
when xhci dies.
-Evan
