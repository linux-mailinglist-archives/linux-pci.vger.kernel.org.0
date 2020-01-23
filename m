Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0E147442
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 00:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgAWXAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 18:00:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46041 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgAWXAH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 18:00:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so181592ljc.12
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2020 15:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nS7ocb5jumTWRAIkSgB97xnkdSH5hp40IMpcRwtHcbY=;
        b=QHKBwjvIIEDpjKu390N/gc1f9Q6gVEAklPmkY+Ok83BmjLFPgsYimIPaB7w1N5KOuB
         XmXHjgtDrWaV/cu4fniFp9KuQKOAKHB3BEC222MdEkfvQhSskR8IVqks1DjwMdbuZaG6
         5ceBFph6PeI4oRJXdzPwLHMoChv0YMYyEP4vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nS7ocb5jumTWRAIkSgB97xnkdSH5hp40IMpcRwtHcbY=;
        b=ii5bmYaBUJRvKFiSnhlPEhW+rVdeFeO/gYs0uGf0eMLIXJI22IIQruQ8JtOCP8q820
         bn+S7sSyRQgClBsMKOIhyvpK+IN+XVPw7Y2KG/zXqeBHG3hZGz81qZ30HCyW0t86Zvip
         LgBBRg5W7g6SOdiJEmGUkLhRX3xLd7Uc8ENRROwXmZUP2ebjJ+sDXiiAZfR/0tYqAMc7
         Pcm/VKjWXv/XGJnIk/wu3KWD60AatoUDL4t1N8mr5Z4Fel1oJlyaBF/OZ6/lCiyKPtwP
         uODIMfu/Pr8jiTfPTDdnfbOj0Sj8omzA4vHXTt6Z7WC6axd9DMCR5b8CojyCseC11Moj
         FRkQ==
X-Gm-Message-State: APjAAAU2BChk7cwqpkq3JaXF4snbzh5YcAZNK0t+ZzxTOXHQ6w6vZZ7A
        J0jEL4zsKpj7kJn5sWijQTqsJDapee8=
X-Google-Smtp-Source: APXvYqx/v9x9mmQRgsgepSA+t/eRcDdK+1KDz7V61S2vaPMIuQ8dktv8vvnxgsrpOBlrA8WbJQJNHw==
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr404437ljj.97.1579820403940;
        Thu, 23 Jan 2020 15:00:03 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b17sm2001365ljd.5.2020.01.23.15.00.02
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 15:00:03 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id r14so3600223lfm.5
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2020 15:00:02 -0800 (PST)
X-Received: by 2002:a19:e011:: with SMTP id x17mr44398lfg.59.1579820402396;
 Thu, 23 Jan 2020 15:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
In-Reply-To: <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Jan 2020 14:59:25 -0800
X-Gmail-Original-Message-ID: <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
Message-ID: <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 23, 2020 at 12:59 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Thu, Jan 23, 2020 at 10:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Evan,
> >
> > Thomas Gleixner <tglx@linutronix.de> writes:
> > > This is not yet debugged fully and as this is happening on MSI-X I'm not
> > > really convinced yet that your 'torn write' theory holds.
> >
> > can you please apply the debug patch below and run your test. When the
> > failure happens, stop the tracer and collect the trace.
> >
> > Another question. Did you ever try to change the affinity of that
> > interrupt without hotplug rapidly while the device makes traffic? If
> > not, it would be interesting whether this leads to a failure as well.
>
> Thanks for the patch. Looks pretty familiar :)
> I ran into issues where trace_printks on offlined cores seem to
> disappear. I even made sure the cores were back online when I
> collected the trace. So your logs might not be useful. Known issue
> with the tracer?
>
> I figured I'd share my own debug chicken scratch, in case you could
> glean anything from it. The LOG entries print out timestamps (divide
> by 1000000) that you can match up back to earlier in the log (ie so
> the last XHCI MSI change occurred at 74.032501, the last interrupt
> came in at 74.032405). Forgive the mess.
>
> I also tried changing the affinity rapidly without CPU hotplug, but
> didn't see the issue, at least not in the few minutes I waited
> (normally repros easily within 1 minute). An interesting datapoint.

One additional datapoint. The intel guys suggested enabling
CONFIG_IRQ_REMAP, which does seem to eliminate the issue for me. I'm
still hoping there's a smaller fix so I don't have to add all that in.
-Evan
