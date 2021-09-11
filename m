Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2F4075B9
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhIKJSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhIKJSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Sep 2021 05:18:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CCCC061574
        for <linux-pci@vger.kernel.org>; Sat, 11 Sep 2021 02:17:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j6so3845493pfa.4
        for <linux-pci@vger.kernel.org>; Sat, 11 Sep 2021 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jYPYjFRA5wuoy9RamHkzaNPf8cATvQqYmJLqP3S7VA=;
        b=X7Ky12ExT/P2JV8aswObI49tudifiYFsHPgRxDrDpriliPXOKGziHwt8pVSwi6vAYS
         9j20T5JamulrwxOssJWwHQnwu3IHeU0uaWNiUDmIsI9WdgHDHNGF1c7yav/2P5enDNAK
         ZWA/W8PfQksfZGMumTIXRepxiwS8co2yBnXsTkkDBkvGiLdReV11x4olpAS+lq1W+ofp
         r8NkF+dQe5EUteBRYAJcp/51vleOy4JciwCWVILtoPDd+OJfg7J++rmS2IN/eRo2XSgi
         Q9JqFMhkQt6BcT4OHTjftvvr7Xmv0ngf86Qduh9CLYqbDtmHxkDpNsWVJJFJO0pOIF8b
         w1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jYPYjFRA5wuoy9RamHkzaNPf8cATvQqYmJLqP3S7VA=;
        b=oLrceU3VTZcgoZJrQetZkMi5WBCYILQXQCQVDrM7z2NRcdb6F1gex227rM459NzgNq
         VGyTjGDu5AO4szPHNtHMwGujpdJhfj0jj5xkYwPa6GMLb/8fNqAoZh7JwclewJcbOcnj
         oQh8UCYM1jehZVpQi7ZCm5KkqkYN6TAe0Y5u63yV7Emf8mY+i2eS7IkttsBshXF8YtF5
         pxL1K+1p46grdfzVlxzH80a8/mIHL3/Wc3OrXymckqfqPRAhtxtoGE05NH+OhzoZlOBy
         S+wZHj8gd60/G54CceQNoEYSKpzvDTaNrcQEE4k7ndOfcZJtM9MCtkfiCambJheY6YU8
         dcvQ==
X-Gm-Message-State: AOAM530aSFQZZT5ctGpRU/G9aD+v1UgdAIe6YrlOs38Q5W9pcjkFH+Hi
        ocL6LOyi9Y6hM9lhHbOyG6bdxLJ+VXHn7cZZ6J+nOD1KVww=
X-Google-Smtp-Source: ABdhPJyRfimAI4F756W90mL+dqkMiPkECWcx4omyoeFOWXhxhbQ64yPUuvZbAK71BCOzlQhS9xY2UzZZ6RB25IB44K0=
X-Received: by 2002:a05:6a00:14c4:b0:412:444e:f600 with SMTP id
 w4-20020a056a0014c400b00412444ef600mr1650033pfu.83.1631351847849; Sat, 11 Sep
 2021 02:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210827083129.2781420-1-chenhuacai@loongson.cn> <20210909175926.GA996660@bjorn-Precision-5520>
In-Reply-To: <20210909175926.GA996660@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 11 Sep 2021 17:17:13 +0800
Message-ID: <CAAhV-H4J004jitgFBa5C4AMjMWNONuB4hF5tNUKDmKemfvF=Jw@mail.gmail.com>
Subject: Re: [PATCH V4 00/10] PCI/VGA: Rework default VGA device selection
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Fri, Sep 10, 2021 at 1:59 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 27, 2021 at 04:31:19PM +0800, Huacai Chen wrote:
> > My original work is at [1].
> >
> > Bjorn do some rework and extension in V2. It moves the VGA arbiter to
> > the PCI subsystem, fixes a few nits, and breaks a few pieces to make
> > the main patch a little smaller.
> >
> > V3 rewrite the commit log of the last patch (which is also summarized
> > by Bjorn).
> >
> > V4 split the last patch to two steps.
> >
> > All comments welcome!
>
> I'm hoping to apply something like this for v5.16.
>
> BUT as I mentioned in [2], I want the very first patch to be the very
> simple 2-line change to vga_arb_update_default_device() that actually
> fixes your problem.
>
> It makes no sense for that change to be at the very end, hidden in the
> middle of a bigger restructuring patch.
I think I should split the restructuring patch again, and sort the
series to move important things to earlier patches. Let me try...

Huacai
>
> [2] https://lore.kernel.org/r/20210825201704.GA3600046@bjorn-Precision-5520
>
> > [1] https://lore.kernel.org/dri-devel/20210705100503.1120643-1-chenhuacai@loongson.cn/
> >
> > Bjorn Helgaas (4):
> >   PCI/VGA: Move vgaarb to drivers/pci
> >   PCI/VGA: Replace full MIT license text with SPDX identifier
> >   PCI/VGA: Use unsigned format string to print lock counts
> >   PCI/VGA: Remove empty vga_arb_device_card_gone()
> >
> > Huacai Chen (6):
> >   PCI/VGA: Move vga_arb_integrated_gpu() earlier in file
> >   PCI/VGA: Prefer vga_default_device()
> >   PCI/VGA: Split out vga_arb_update_default_device()
> >   PCI/VGA: Log bridge control messages when adding devices
> >   PCI/VGA: Rework default VGA device selection (Step 1)
> >   PCI/VGA: Rework default VGA device selection (Step 2)
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/gpu/vga/Kconfig           |  19 ---
> >  drivers/gpu/vga/Makefile          |   1 -
> >  drivers/pci/Kconfig               |  19 +++
> >  drivers/pci/Makefile              |   1 +
> >  drivers/{gpu/vga => pci}/vgaarb.c | 269 ++++++++++++------------------
> >  5 files changed, 126 insertions(+), 183 deletions(-)
> >  rename drivers/{gpu/vga => pci}/vgaarb.c (90%)
> > --
> > 2.27.0
> >
