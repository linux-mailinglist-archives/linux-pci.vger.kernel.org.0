Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA32D317F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgLHRxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 12:53:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44845 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgLHRxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 12:53:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id f16so16568433otl.11;
        Tue, 08 Dec 2020 09:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DtuTL0FxwT290gTl9AoRJ1ttUQTGS6Lfz9q2+uDAU8=;
        b=Bmg5BWw0PncLsJmUzor5mCG02dKgSt9bIH7hkLT7tLWtXfhDDHKQDF4TkeoXMpo3Jq
         KPLo11EKdp4JWoCMduNXDk4k3DTKxrezk3RiHjqodic2vpja20Eq9kC4E4XWCVs9TmZs
         rFgOZu0NU6T/j3Q/i2aTc/ntpy1aD7kbLwsK4VheWvq5ntlMlk3D53wcbwjACR0ewwR/
         8zpt0X8JUYPrFtfqFARUqHiMuhNtPBtDoX42BUoHmOoJvyMcv94qPn54/OPpBC8sMjuS
         vgXQYpC+0DsJkrRldDDAl/vU/LegkSBWu0fE4Ryk/26jl0+HkdUTetLNf0jAz9YbyRe9
         2arA==
X-Gm-Message-State: AOAM530CPiNmWFID07mFkZR7xpWo6wg4T09MG8YPyuwUfLSwY61X6IJ4
        QyPPb6Do/QF3sCz0VeDG6bHPzfpIGPlIPYHfrxg=
X-Google-Smtp-Source: ABdhPJzL+Jrpg7stR8UBH7MiZ+WgYPpegtz3OOWnaNTqLb3Ehz6MdkdV7PMo+LxMUf5KoSyIcBd6+YC1Gd1NxmWGleg=
X-Received: by 2002:a9d:2203:: with SMTP id o3mr17834818ota.107.1607449959142;
 Tue, 08 Dec 2020 09:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20201016120416.7008-1-marek.vasut@gmail.com> <20201119173553.GB23852@e121166-lin.cambridge.arm.com>
 <57358982-ef8c-ed91-c011-00b8a48c4ebd@gmail.com> <20201208101823.GA30579@e121166-lin.cambridge.arm.com>
 <529ff24a-dcb5-6c9e-2825-b2fbd0fbcd70@gmail.com>
In-Reply-To: <529ff24a-dcb5-6c9e-2825-b2fbd0fbcd70@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Dec 2020 18:52:27 +0100
Message-ID: <CAMuHMdUHdXqVaGnP7Zj097oLcqoyzG-MgLVneCfiuFOxMFDFtw@mail.gmail.com>
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 8, 2020 at 6:45 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 12/8/20 11:18 AM, Lorenzo Pieralisi wrote:
> [...]
> >>> I suppose a fault on multiple cores can happen simultaneously, if it
> >>> does this may not work well either - I assume all config/io/mem would
> >>> trigger a fault.
> >>>
> >>> As I mentioned in my reply to v1, is there a chance we can move
> >>> this quirk into config accessors (if the PM_ENTER_L1_DLLP is
> >>> subsequent to a write into PMCSR to programme a D state) ?
> >>
> >> I don't think we can, since the userspace can do such a config space write
> >> with e.g. setpci and then this fixup is still needed.
> >
> > Userspace goes via the kernel config accessors anyway, right ?
>
> As far as I can tell, you can just write the register with devmem, so
> no. You cannot assume everything will go through the accessors. I don't
> think setpci does either.
>
> > I would like to avoid having arch specific hooks in PCI drivers so
> > if we can work around it somehow it is much better.
>
> I think we had this discussion before, which ultimately led to hiding
> the workaround in ATF on Gen3. On Gen2, there is no ATF, so the work
> around must be in Linux.
>
> > I can still merge this patch this week but I would like to explore
> > alternatives before committing it.
>
> Please merge it as-is.

+1

This can be triggered easily, just insert a stock Intel Ethernet card,
s2ram, and boom.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
