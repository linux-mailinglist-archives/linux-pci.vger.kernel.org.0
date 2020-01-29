Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482EC14D342
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 23:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA2Wx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 17:53:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41061 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2Wx4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2020 17:53:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so1190654ljc.8
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOj9kLL9OKVQ4bW9RaNCXxV8jEQPASFBUj6KpH5YEho=;
        b=ZhvTsaxyumUnK5Lu8sLn5DccXNEakQ95xz2a5jJgoALEIjbzYMz+4NuzN5D0bwSDAZ
         ZUxe18Sf15dIFiwptjxYt4tad25GXwWuCR0g5arQP9n5P5K+RmXgEeO23cOuZYzu2YBx
         3B334rQ7Kc4A2unostW515ssokqI5D0CdGCL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOj9kLL9OKVQ4bW9RaNCXxV8jEQPASFBUj6KpH5YEho=;
        b=HYJDiWlNKdPt/vOOTTl3umk2NFWdmycl6PMqlnAtajtwfd3i36zJBj56Xchj2qmCGu
         lkjaM7QMT8twrVf+YpRz5rnQ35wm/zHBrYkgmG3prawnYzaoPkCuCJ2aTuKu081qZe5E
         to+/ZaHOhfMq8HUXX1MJNBzTMoJG9mZCMk58gFc/7+f3/HF7rRX6xwlulJJS08jX2kPU
         QMzEDk8vqbyjeq0D8mUMjzq7Jma6ZHD/rGbnpRKdzB3M7eUIXA3UY94w0Ys8qGBay4LA
         PsaWbjObEjnEeLfIYdF5XQidBFpTxGzUOq5fPTwCUDnLBJGMrqkqf/skMZL9MddK2uXe
         MCmg==
X-Gm-Message-State: APjAAAXMQsdDtXmycXONZchfvcroKLyM0eghw5puzBWIWF4E9jW/p/dE
        q1lW0mn4nn0DrNjHD4dZUpqFwA2/pTc=
X-Google-Smtp-Source: APXvYqxsETtKVlDn8MRTOt5UYoOoU0T4626J3DkRYEafoNJTnKXkCc3CaNGAHMGccgmZ8xRP80v3/A==
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr911930lji.50.1580338433792;
        Wed, 29 Jan 2020 14:53:53 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y11sm2100264lfc.27.2020.01.29.14.53.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 14:53:52 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id x14so1154033ljd.13
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 14:53:52 -0800 (PST)
X-Received: by 2002:a2e:8702:: with SMTP id m2mr596560lji.278.1580338432116;
 Wed, 29 Jan 2020 14:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de>
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
 <87pnf342pr.fsf@nanos.tec.linutronix.de> <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
 <877e1a2d11.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877e1a2d11.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 29 Jan 2020 14:53:15 -0800
X-Gmail-Original-Message-ID: <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
Message-ID: <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 1:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Evan Green <evgreen@chromium.org> writes:
> > On Tue, Jan 28, 2020 at 2:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Bah. I'm sure I looked at that call chain, noticed the double vector
> >> lock and then forgot. Delta patch below.
> >
> > It's working well with the delta patch, been running for about an hour
> > with no issues.
>
> thanks for the info and for testing!
>
> Could you please add some instrumentation to see how often this stuff
> actually triggers spurious interrupts?

In about 10 minutes of this script running, I got 142 hits. My script
can toggle the HT cpus on and off about twice per second.
Here's my diff (sorry it's mangled by gmail). If you're looking for
something else, let me know, or I can run a patch.

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 90baf2c66bd40..f9c46fc30d658 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -61,6 +61,8 @@ static void irq_msi_update_msg(struct irq_data
*irqd, struct irq_cfg *cfg)
        irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
 }

+int evanpending;
+
 static int
 msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 {
@@ -155,8 +157,10 @@ msi_set_affinity(struct irq_data *irqd, const
struct cpumask *mask, bool force)

        unlock_vector_lock();

-       if (pending)
+       if (pending) {
+               printk("EVAN pending %d", ++evanpending);
                irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+       }

        return ret;
 }

-Evan
