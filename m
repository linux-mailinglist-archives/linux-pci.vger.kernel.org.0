Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAABF14701D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAWR4U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 12:56:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34394 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgAWR4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 12:56:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so3028604lfc.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2020 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbUt6go+kLuXKXQ0VzJ6Mhyl0zSlPzgGsNDFNiXJt7g=;
        b=NK4+dXDpNBbzPh3b80IEDt5inscQTCvjYG7+GPJ5WUbiU+W/8YhHNLVwGhxs57FIS4
         fK7JN1NswFF2h0zIXnkR7Xk+qgzuLlEZVN6S32B+6w20Ygvnm09GYcbJgAJZKjeKpTGc
         792wHEdxRwurEfdqWJVhjVFcefHoQJugA+IyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbUt6go+kLuXKXQ0VzJ6Mhyl0zSlPzgGsNDFNiXJt7g=;
        b=Y16GEYoWIFxrJaw9MufTYdRsaRUhfiJfWSqmmYGV4Pwf7VDplezU+s9eaWiJY0unJV
         kiFN89IgmkbpCXiCQkGm5PI9vsSX9ZCvYac2klR9wl0DzHzwLjBCiuPkhu/O8vhph6f8
         KbR3Y7p7bZwa4vbFkf5x6hiUXypLBpYxYCvyJykSc1a4EzkOTvqjLnTPa05agFM8WNjO
         A4Wxtf8tGPW3u9LHe4B17PbJ7wTq2721xgsnAnBdotrqTpXv1lElO+InJUX+Opm9yZ03
         TWdq1Mls4BWxnkl9LZAcft6Qau5SsN1M1lCR6nWMvhEn1ttiSLXSoNDEz9eCyixmnYZs
         cVYA==
X-Gm-Message-State: APjAAAX0uVfyT0VSgsd70tFumA5HmSV8W1PLYh3YbWWjA0IevVZ8wnAM
        hYv8drQJnY0rpVPzuZC4rotIQSB8ufM=
X-Google-Smtp-Source: APXvYqxfnraROHGiApdKE3Hkgtf8DbEllKN1kHwY1xuw4mb5l1PPseM0uVIghNZE1r8nyJWUT9v+kQ==
X-Received: by 2002:a19:6d13:: with SMTP id i19mr5171798lfc.6.1579802177472;
        Thu, 23 Jan 2020 09:56:17 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i4sm1640602ljg.102.2020.01.23.09.56.16
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:56:16 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id h23so4557542ljc.8
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2020 09:56:16 -0800 (PST)
X-Received: by 2002:a2e:b017:: with SMTP id y23mr24733117ljk.229.1579802175831;
 Thu, 23 Jan 2020 09:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <20200122172816.GA139285@google.com> <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
 <875zh3ukoy.fsf@nanos.tec.linutronix.de> <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com>
 <871rrqva0t.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rrqva0t.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Jan 2020 09:55:39 -0800
X-Gmail-Original-Message-ID: <CAE=gft77xmkc6-4+h3WAp_4C7ra8XKSxcsqrVkBrYgXE0JPeSw@mail.gmail.com>
Message-ID: <CAE=gft77xmkc6-4+h3WAp_4C7ra8XKSxcsqrVkBrYgXE0JPeSw@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 23, 2020 at 12:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan Green <evgreen@chromium.org> writes:
> > On Wed, Jan 22, 2020 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > One other way you could avoid torn MSI writes would be to ensure that
> >> > if you migrate IRQs across cores, you keep the same x86 vector number.
> >> > That way the address portion would be updated, and data doesn't
> >> > change, so there's no window. But that may not actually be feasible.
> >>
> >> That's not possible simply because the x86 vector space is limited. If
> >> we would have to guarantee that then we'd end up with a max of ~220
> >> interrupts per system. Sufficient for your notebook, but the big iron
> >> people would be not amused.
> >
> > Right, that occurred to me as well. The actual requirement isn't quite
> > as restrictive. What you really need is the old vector to be
> > registered on both the old CPU and the new CPU. Then once the
> > interrupt is confirmed to have moved we could release both the old
> > vector both CPUs, leaving only the new vector on the new CPU.
>
> Sure, and how can you guarantee that without reserving the vector on all
> CPUs in the first place? If you don't do that then if the vector is not
> available affinity setting would fail every so often and it would pretty
> much prevent hotplug if a to be migrated vector is not available on at
> least one online CPU.
>
> > In that world some SMP affinity transitions might fail, which is a
> > bummer. To avoid that, you could first migrate to a vector that's
> > available on both the source and destination CPUs, keeping affinity
> > the same. Then change affinity in a separate step.
>
> Good luck with doing that at the end of the hotplug routine where the
> CPU is about to vanish.
>
> > Or alternatively, you could permanently designate a "transit" vector.
> > If an interrupt fires on this vector, then we call all ISRs currently
> > in transit between CPUs. You might end up calling ISRs that didn't
> > actually need service, but at least that's better than missing edges.
>
> I don't think we need that. While walking the dogs I thought about
> invoking a force migrated interrupt on the target CPU, but haven't
> thought it through yet.

Yeah, I think the Intel folks did that in some tree of theirs too.

>
> >> 'lscpci -vvv' and 'cat /proc/interrupts'
> >
> > Here it is:
> > https://pastebin.com/YyxBUvQ2
>
> Hrm:
>
>         Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
>
> So this is weird. We mask it before moving it, so the tear issue should
> not happen on MSI-X. So the tearing might be just a red herring.

Mmm... sorry what? This is the complete entry for xhci:

00:14.0 USB controller: Intel Corporation Device 02ed (prog-if 30 [XHCI])
        Subsystem: Intel Corporation Device 7270
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 124
        Region 0: Memory at d1200000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
        Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
                Address: 00000000fee10004  Data: 402a
        Capabilities: [90] Vendor Specific Information: Len=14 <?>
        Kernel driver in use: xhci_hcd


>
> Let me stare into the code a bit.

Thanks, I appreciate the help.

-Evan
