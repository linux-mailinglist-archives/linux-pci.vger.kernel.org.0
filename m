Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D916E0431
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 14:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfJVMwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 08:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388890AbfJVMwG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 08:52:06 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C216D37E80
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2019 12:52:05 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id t16so1144291qtp.11
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2019 05:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yeQelJTclqqXcJSeLCRYJucLdCvZTdooL8LQ/VknXg=;
        b=U0iVwimDNk5cMaCfK//XX38tT/GlhZ7O9ORvkuSZux54rfCGp1c8OOJ7OaE46ZxwOD
         dCuTtUCg4MVvkW6B/+wKTteFXIMUFx91MJHIxdpcSaz8olmwM0OxAm9WR0V13SbQts3l
         WPmxiB8otXz2R6XmbVRpsIG/ptYa4zVXhbq+ERLZINALBxX1t6kymTRR0jRurn5FWNUZ
         BYfPWXC4bxRoaK4qeuSAzpS/kC97nCx1C2pdu7+tLYxGYQVq6k/t4BM720fFWTAv0foN
         g5IPnFGphpkSd7GlcHDELvK0D5f/QqDUCD97ZvZu9KhMB6fehu4Rs+M4jpcamZjTS/eA
         RQ8w==
X-Gm-Message-State: APjAAAWcLVbzUCJCZmLY/2Acg+FVyGnBbyAOarguLAcvyOnG9rLsW1cH
        GbATgU9bItN+VODCJki/02Ew8NWXEe2sCWHi/Afl1cJBFJU2ZFbZiyzrvfK6hg6XyKiwtP6V36Y
        AOoLFQ0dOTY7ze4o87bvJde2Sm/uEElbdctNM
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr2853223qke.62.1571748725000;
        Tue, 22 Oct 2019 05:52:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTSf/89W7mLASTE6fmyhuNivQ1p+xmXUQgPgY57L2MD0+HVVER/VSyOJiIJsiIDyT24Z8QmXi/IjC27y0EsqE=
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr2853196qke.62.1571748724699;
 Tue, 22 Oct 2019 05:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com> <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com> <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
 <20191021140852.GM2819@lahna.fi.intel.com> <CACO55tvp6n2ahizwhc70xRJ1uTohs2ep962vwtHGQK-MkcLmsw@mail.gmail.com>
 <20191021154606.GT2819@lahna.fi.intel.com> <CACO55tsGhvG1qapRkdu_j7R534cFa5o=Gv2s4VZDrWUrxjBFwA@mail.gmail.com>
 <CACO55ts7hivYgN7=3bcAjWx2h8FfbR5UiKiOOExYY9m-TGRNfw@mail.gmail.com> <20191022124453.GK2819@lahna.fi.intel.com>
In-Reply-To: <20191022124453.GK2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 22 Oct 2019 14:51:53 +0200
Message-ID: <CACO55tvxvwUqzg=jLoO6bhmcaXQwRaTv9S4pt2t0V5TUi+HsEw@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 2:45 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Tue, Oct 22, 2019 at 11:16:14AM +0200, Karol Herbst wrote:
> > I think there is something I totally forgot about:
> >
> > When there was never a driver bound to the GPU, and if runtime power
> > management gets enabled on that device, runtime suspend/resume works
> > as expected (I am not 100% sure on if that always works, but I will
> > recheck that).
>
> AFAIK, if there is no driver bound to the PCI device it is left to D0
> regardless of the runtime PM state which could explain why it works in
> that case (it is never put into D3hot).
>
> I looked at the acpidump you sent and there is one thing that may
> explain the differences between Windows and Linux. Not sure if you were
> aware of this already, though. The power resource PGOF() method has
> this:
>
>    If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV == 0x05)))) {
>       ...
>    }
>

I think this is the fallback to some older method of runtime
suspending the device, and I think it will end up touching different
registers on the bridge controller which do not show the broken
behaviour.

You'll find references to following variables which all cause a link
to be powered down: Q0L2 (newest), P0L2, P0LD (oldest, I think).

Maybe I remember incorrectly and have to read the code again... okay,
the fallback path uses P0LD indeed. That's actually the only register
of those being documented by Intel afaik.

> If I read it right, the later condition tries to detect Linux which
> fails nowadays but if you have acpi_rev_override in the command line (or
> the machine is listed in acpi_rev_dmi_table) this check passes and does
> some magic which is not clear to me. There is similar in PGON() side
> which is used to turn the device back on.
>
> You can check what actually happens when _ON()/_OFF() is called by
> passing something like below to the kernel command line:
>
>   acpi.trace_debug_layer=0x80 acpi.trace_debug_level=0x10 acpi.trace_method_name=\_SB.PCI0.PEG0.PG00._ON acpi.trace_state=method
>
> (See also Documentation/firmware-guide/acpi/method-tracing.rst).
>
> Trace goes to system dmesg.

This sounds to be very helpful, I'll give it a try.
