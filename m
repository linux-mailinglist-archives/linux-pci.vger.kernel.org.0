Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD336EA36
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhD2MRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhD2MRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 08:17:47 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A3C06138B;
        Thu, 29 Apr 2021 05:17:01 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so78188491ybi.12;
        Thu, 29 Apr 2021 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvKSWMA+h4VY1N/pm8V8CpfYjYpoN5VTSiX9cgYoepk=;
        b=F4D+bf3TUu0ExjDShsKGSlCLw9q5eqgc6LEUVOERxdD3UJbfGrucWcgAtNA7ZdScLT
         znkipL8joyRG1ux7QOfpI2fEYq1x+nuS2DAGm0KD3ZXruwiisRQVSzP1DZhPo82x3PII
         fhd9uPhTz4kt++jkW5HujLexy5D1bk043KoPWUcTy21KvY4AsVa+u6wBWcmNED6RC1AS
         dN/00Ls7ZrhVC+78kPKhuPt+34U6M9JupTV3tM/BiQtf7MmrFBUVPq8As/193AzfNqC6
         HsWUyD/fDH0Ai7JjH1CMK3zi+7SKjznsn8iSFNHjcR+dxjXjOa9ja4Ql5FLSYMvJxm/k
         03JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvKSWMA+h4VY1N/pm8V8CpfYjYpoN5VTSiX9cgYoepk=;
        b=GEGnvt7T22J4UnivmwBKs3QpO+zR8eQa7tdU2xlQI/bmTn2oDP60vdww/L4OTfQ/lG
         az2pl+E4pxV+GpVvnpBcN9aI542iKbr5Zx2Mr9hEHH0JlMDgNctrLjEA0+dZVDnlqutY
         nVJ3f0IhSAK7QLGkzVQ9KJP8i6KJyLd8WLW3Gx1J9U04hrYTGW2YmEIpirb/CjXfNwub
         DMabdfhdEK6RdJBt/LHbX44GI9NKTPshR+c2P++tGLWlya7RW7MXgjP2Y4jSqej+5Q9L
         x/DpCgpCKi1b4xwY60uTjUTjM0OSrOKBhelX/Z8xlqrT7B77Qg5eWaweFUgSU5F4tP1p
         wRLA==
X-Gm-Message-State: AOAM533vj9fx4d41V6CZ8xdYQFFYboG4SV37GHtGhe5WBeF8NN1BD9y7
        /G5akKfL+a2AL0ghgAp5thOCWeoBz7e6ZldIY+M=
X-Google-Smtp-Source: ABdhPJwn6bV0wQmK8I7sO2LuJG3UbMEjwgZXHROeUPEs6Mjuq4x7MUSg4zlwALybADmOp0QK7T5DsSTG00FGMVycQt4=
X-Received: by 2002:a25:4d56:: with SMTP id a83mr43509949ybb.437.1619698620408;
 Thu, 29 Apr 2021 05:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210414070325.924789-1-xxm@rock-chips.com> <CAMdYzYqf3FhYrFR1DGrP=_CbNpq5uB+J-m42Mv=c6Pu71Jcxww@mail.gmail.com>
 <5af0f6f8-bc29-f50e-ca14-94049b7d17ed@rock-chips.com> <CAMdYzYr=i7X22-38VyY-GQLWs+aV+ZcWwO_uDymFxmaNO8SpmA@mail.gmail.com>
 <20210429064117.GA2214470@infradead.org> <CAMdYzYrbfD-jFC3uPVPkhjXWZGeaUw5X=0w1Q=m-6OuhEGOKkQ@mail.gmail.com>
 <20210429115451.GA2287423@infradead.org>
In-Reply-To: <20210429115451.GA2287423@infradead.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 29 Apr 2021 08:16:48 -0400
Message-ID: <CAMdYzYobyyROToMXng25NQEgSC7OpYLmo=iM9eDuPbSfkKuKgA@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: rockchip: Add Rockchip RK356X host controller driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 7:55 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 29, 2021 at 07:26:40AM -0400, Peter Geis wrote:
> > Good Morning! I'm trying to implement the MSI workaround in as sane a
> > method as possible.
> > Do you have a better way to have the kernel only allocate memory in
> > the lower regions?
> > (Without disabling everything above 4G altogether)
> > This chip only supports a maximum of 8G.
> > (I know, why they did it while maintaining a 32bit bus is beyond me).
>
>
> Please use dma_alloc_coherent to allocate the memory, the dma_addr_t
> return value is the address to be fed to the hardware.  Before doing
> that set the desired mask.  DMA_BIT_MASK(33) would get your 8GB.

Thanks!
Unfortunately this isn't actually DMA allocation, they were using
GFP_DMA32 as a hack to allocate regular kernel memory in the 32 bit
range.
It's in drivers/irqchip/irq-gic-v3-its.c for reference.
The functions are simply kcalloc(), kzalloc(), kzalloc_node(),
alloc_pages_node(), and alloc_pages().
I'd prefer not to have to rewrite this driver's entire memory
allocation system for one errata.

I'm following the code path for dma_alloc_coherent to see if anything
sticks out to me though.
