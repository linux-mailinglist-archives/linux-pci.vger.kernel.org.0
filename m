Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D641D1A3249
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDIKNM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 06:13:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40861 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKNM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 06:13:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id q2so7152727otk.7;
        Thu, 09 Apr 2020 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gCZP4VOAtxv93Dwz8G9N+IxG+FH0dYZBABiIJGbG7E=;
        b=pmVUwiuIMo0kmUMLq83grnGCpTZklP8SCBR+TQ0joTcBm9AdV7SNA755dETA8L+Pdt
         DzxF9SQnuqzRpS6Zuba4psevWLsUbUlJNwtBafNnKqn/Aotbj94l0LlSi4GT3g5DlVhB
         OKWju+K39+glkV6ifSt70XgUC7ZnddEWJhetY0iRyBxZ3y35yYzI60Ampi0S8ft6AaS1
         hqg/S/6o/4BjWjNsCF5Nrdho4hifNBodl4bRcFM8TQ6IiP3xsaBnSlFbsp1Nqp/GEFnf
         rKL+Xf7yLQV5ibq9Nv9zNwFAbzgSRGFTHpae+q2CtJf1JczXReXdtTl5M2Q33wblHM7o
         zMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gCZP4VOAtxv93Dwz8G9N+IxG+FH0dYZBABiIJGbG7E=;
        b=WA8cRMX/bHOTcw0WV20DjcxvEemXbyuEIrB/8eCDw5DnJ+1lj61S+LeIOxS8nw20zF
         A7WlLGvkL8iG10umc+rT28qDqb5+yLZ3qMhRrElSGb+OCj2JgUfqJUwOWxEfQc33gGje
         +kyCi8EO4mmDu90yprkyy5fAkyVprXqT1MWEGKPfsumY6JvooCQQXJyeSHV0SQkFM585
         Otjx1OzgzL1DPhStO1eDGa5vBft9frtRwn5MpAv8mSC4pi5TIeJokXkcW97PgGIVNmAP
         Q67FoC0XUqpB7kck2ZsXoqJk8zYqegoIxHGbzcxo2kR2w1NfcAeCJcUuXrheMn3dOu2C
         IPLA==
X-Gm-Message-State: AGi0PubyGT1UhCRT/TpHmy+q6aGVQJQVBRBBkWtiZwcEEAvjpSfTkgLW
        iwTUgdyUieWZy9RM3chT+j+tWTvZcqO3IwCXfYg=
X-Google-Smtp-Source: APiQypLhsQeYzwoUhGLE9gEJNuYaBxMBYdOrDBfS/DVmEFxN0Im6t1IiIy0qzEuA2Wmozs97BahlPiYaYmuzaWQ47b8=
X-Received: by 2002:a9d:798e:: with SMTP id h14mr6693794otm.88.1586427191253;
 Thu, 09 Apr 2020 03:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <1586360280-10956-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200408234622.GA150772@google.com>
In-Reply-To: <20200408234622.GA150772@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Apr 2020 11:12:45 +0100
Message-ID: <CA+V-a8te28Ji5HYV-QAmd28x-ACshCkVmUUkMYu1KSt0RRdJgQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review.

On Thu, Apr 9, 2020 at 12:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 08, 2020 at 04:37:56PM +0100, Lad Prabhakar wrote:
> > R-Car PCIe controller has support to map multiple memory regions for
> > mapping the outbound memory in local system also the controller limits
> > single allocation for each region (that is, once a chunk is used from the
> > region it cannot be used to allocate a new one). This features inspires to
> > add support for handling multiple memory bases in endpoint framework.
> >
> > With this patch pci_epc_mem_init() initializes address space for endpoint
> > controller which support single window and whereas __pci_epc_mem_init()
> > now accepts pointer to multiple windows supported by endpoint controller.
>
> Adding a double underscore prefix usually indicates an internal
> function that skips some checking.
>
> It doesn't seem like quite the right thing for this external interface
> that adds functionality.  Maybe the name could include something like
> "multi"?
>
Agreed. how about pci_epc_mem_multi_init() ?

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This needs an ack from Kishon, of course.
>
Yes waiting for Kishon to review it.

> This patch seems like it does several things that could possibly be
> split into separate patches?
>
>   - Change pci_epc_mem_init() interface to add page_size argument (the
>     only one that touches cadence & rockchip; it would be nice if this
>     were a tiny patch)
>
Can be done.

>   - Add struct pci_epc_mem_window
>
>   - Add a pci_epc_multi_mem_init() or similar, implement
>     pci_epc_mem_init() in terms of it (as you already do)
>
The above two needs to be single patch. Is that OK with you ?

Cheers,
--Prabhakar
