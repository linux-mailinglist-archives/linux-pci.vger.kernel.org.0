Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8839E1B7E88
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgDXTFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 15:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbgDXTFi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 15:05:38 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7390F20781;
        Fri, 24 Apr 2020 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587755137;
        bh=2LW2+5Tf6piUtKBA+zu56Phwir9j1mdmuZQUDUqTbto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eOrxIKqyOo7ejaDTs0ubssNSbAE20haMWbjGTGLc9rjd4DeVRi41+Xl6C582esdy2
         ZpS/iltG/og19WgPe1ZfRDE52u8P8iWD/llXmzNEcs2qRiPQhMmAa8KE7A9V1BCFtu
         RvSv1rLJDDWFKu14JdXAIDr4euM2BwDrwAThVJmU=
Received: by mail-qk1-f175.google.com with SMTP id l78so11299370qke.7;
        Fri, 24 Apr 2020 12:05:37 -0700 (PDT)
X-Gm-Message-State: AGi0PuaIML5xQc1Is39fwZvGoFDcfMeaI7GexAdASPs6IeCc+cCRzHWl
        dpaAI5hmD0pVYWFeqYMbPmFj0iKGkU4UjXDPUA==
X-Google-Smtp-Source: APiQypLgIU1HRvZ5lP4/zCnhpczaENuWMmeePklaGGio8tzLp6+kdqIoxkpjzRKcy3ZHEsU+f8KdIp18kSxYeLJS5QQ=
X-Received: by 2002:a37:cc1:: with SMTP id 184mr10738607qkm.254.1587755136520;
 Fri, 24 Apr 2020 12:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
 <20200424130847.328584-2-jiaxun.yang@flygoat.com> <CAL_JsqKsZrsnn92XHL4QdFkAgFKqVTBZXDz9wVv-_7oywOOsBQ@mail.gmail.com>
 <D5CC0902-F84F-43F1-88E5-C03018B25050@flygoat.com>
In-Reply-To: <D5CC0902-F84F-43F1-88E5-C03018B25050@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Apr 2020 14:05:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLEHZOZXkuW4_9KeUWjzahvP0OMtQUGVU_pASi9Ag=GAQ@mail.gmail.com>
Message-ID: <CAL_JsqLEHZOZXkuW4_9KeUWjzahvP0OMtQUGVU_pASi9Ag=GAQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] PCI: OF: Don't remap iospace on unsupported platform
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 1:03 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote=
:
>
>
>
> =E4=BA=8E 2020=E5=B9=B44=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
1:47:23, Rob Herring <robh+dt@kernel.org> =E5=86=99=E5=88=B0:
> >On Fri, Apr 24, 2020 at 8:09 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wr=
ote:
> >>
> >> There are some platforms that don't support I/O space remapping
> >> like MIPS. However, our PCI code will try to remap iospace
> >> unconditionally and reject io resources on these platforms.
> >>
> >> So we should remove I/O space remapping check and use a range
> >> check instead on these platforms.
> >>
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> --
> >> v4: Fix a typo in commit message.
> >> v5: Commit message massage
> >> ---
> >>  drivers/pci/of.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> >> index 81ceeaa6f1d5..36e8761b66c6 100644
> >> --- a/drivers/pci/of.c
> >> +++ b/drivers/pci/of.c
> >> @@ -547,12 +547,21 @@ int pci_parse_request_of_pci_ranges(struct devic=
e *dev,
> >>
> >>                 switch (resource_type(res)) {
> >>                 case IORESOURCE_IO:
> >> +#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
> >
> >We already have the same condition in pci_remap_iospace(). All this
> >does is suppress a WARN. If a WARN is not desired, then change it.
> >Perhaps just a single line rather than backtrace would be okay.
> >Whether to WARN or not shouldn't be a decision for firmware code.
> >
> >Though really, if I/O space can never be supported, then it's an error
> >in your DT to describe it.
>
> In MIPS world, we do have inb/oub family of I/O functions
> to support I/O space. But we're not using remap_iospace as it's breaking
> some of our assumptions.

I suspect that's largely because most MIPS drivers pre-date the common
iospace handling. Really MIPS should start using this.

> We have our own inb/outb implementation.

That's orthogonal to mapping the iospace.

> In that case, I think make a range check instead of remapping would
> be more practical.

Not the kernel's job to validate the DT especially if you aren't using
this data anywhere.

Just remove the WARN, make it a single line print, or add
!IS_ENABLED(CONFIG_MIPS) where the warning is.

Rob
