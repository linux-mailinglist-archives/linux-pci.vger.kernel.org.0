Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CBE30E4E5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBCVYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 16:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhBCVYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 16:24:13 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9413C0613ED
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 13:23:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jj19so1465247ejc.4
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 13:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VT23w92CT9zXGoB2xTF4DjGzC0MXKQMCiaO+54MJ7Ao=;
        b=kxpyxImNyl0PD+X1iGOdvaWlfhCG1TIKsHTUd3YIbtmQGOQN1d0MCUUHfIff4tHdHo
         4rkeo72QT5v52E7o4MSw6G5C9PFnkqsaxGiD2t6Z3g/nUDvrDKbVkRo0D9oUGce8xMd1
         D9WDuYQE1t98gpIh3hjVGZlF/tNPEAhtns2hDwk/fUXSf38hcGas8HbkZcDAaRURLGKV
         3RiAoKUv3nJWfMx/5VeciMGYvZKE2HYlJAAUd9sAwpDOwfKSbc1R0yNBFxbZNzr0+sYo
         /MDlatcZ7OcQ7mRVmkYp7bnDyKHd824Gp2Hb+fsrxrOX/ujxvWArT4kJDlSVwPhsHWbv
         WhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VT23w92CT9zXGoB2xTF4DjGzC0MXKQMCiaO+54MJ7Ao=;
        b=N7x0fAnY3tyq0oNA+47G3ezmwHSeWiTnlKGdvCbe4owp1xfZrTMmtWE1xY67hK7ENX
         WNjImB4Qml7ScwNadAA3VME62vO2M+UWvJKivqBj2/7xrdqqtzTQ4GKKs+v3ktvcUPHd
         im0FHrYpp9Ru1oWga/5o5xGhHuASqXbofj+KwFgc0wgY6yDF7Y538V92ZMK6Ydo95x6r
         LejdpcYppd0EdlBFQ/ifzhn85vap42qin/9uKvbarg53XIsVgf+JvAYqS3ZphU2cbjxx
         vXcujw2oClUkzQtUbjbHiov2GzWW/kYXCcoIjh30kaFGLBOnv9s0P+ChR4TGn/7EZvWL
         6Wrw==
X-Gm-Message-State: AOAM532BYHjpom6u6U7Z11F5Tx6kB0unrAtzg6HaPahwvXdc8gP+n92b
        Iwi7KbfwIxm7si7RUDVAuhQyoKnd4RQbnBvse0cqEQ==
X-Google-Smtp-Source: ABdhPJycsTuuO9WFxOwJr0uveWLDYX613Mw9CD4bctsoU/uYDmnrN/Izr6YTrrIN45yfo7Sw2Zt5lHunHYMWXjSffEI=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr5313759ejb.523.1612387411333;
 Wed, 03 Feb 2021 13:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com> <20210202181016.GD3708021@infradead.org>
 <20210202182418.3wyxnm6rqeoeclu2@intel.com> <20210203171534.GB4104698@infradead.org>
 <20210203172342.fpn5vm4xj2xwh6fq@intel.com>
In-Reply-To: <20210203172342.fpn5vm4xj2xwh6fq@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Feb 2021 13:23:31 -0800
Message-ID: <CAPcyv4hvFjs=QqmUYqPipuaLoFiZ-dr6qVhqbDupWuKTw3QDkg@mail.gmail.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 3, 2021 at 9:23 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-03 17:15:34, Christoph Hellwig wrote:
> > On Tue, Feb 02, 2021 at 10:24:18AM -0800, Ben Widawsky wrote:
> > > > > +       /* Cap 4000h - CXL_CAP_CAP_ID_MEMDEV */
> > > > > +       struct {
> > > > > +               void __iomem *regs;
> > > > > +       } mem;
> > > >
> > > > This style looks massively obsfucated.  For one the comments look like
> > > > absolute gibberish, but also what is the point of all these anonymous
> > > > structures?
> > >
> > > They're not anonymous, and their names are for the below register functions. The
> > > comments are connected spec reference 'Cap XXXXh' to definitions in cxl.h. I can
> > > articulate that if it helps.
> >
> > But why no simply a
> >
> >       void __iomem *mem_regs;
> >
> > field vs the extra struct?
> >
> > > The register space for CXL devices is a bit weird since it's all subdivided
> > > under 1 BAR for now. To clearly distinguish over the different subregions, these
> > > helpers exist. It's really easy to mess this up as the developer and I actually
> > > would disagree that it makes debugging quite a bit easier. It also gets more
> > > convoluted when you add the other 2 BARs which also each have their own
> > > subregions.
> > >
> > > For example. if my mailbox function does:
> > > cxl_read_status_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > >
> > > instead of:
> > > cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > >
> > > It's easier to spot than:
> > > readl(cxlm->regs + cxlm->status_offset + CXLDEV_MB_CAPS_OFFSET)
> >
> > Well, what I think would be the most obvious is:
> >
> > readl(cxlm->status_regs + CXLDEV_MB_CAPS_OFFSET);
> >
>
> Right, so you wrote the buggy version. Should be.
> readl(cxlm->mbox_regs + CXLDEV_MB_CAPS_OFFSET);
>
> Admittedly, "MB" for mailbox isn't super obvious. I think you've convinced me to
> rename these register definitions
> s/MB/MBOX.
>
> I'd prefer to keep the helpers for now as I do find them helpful, and so far
> nobody else who has touched the code has complained. If you feel strongly, I
> will change it.

After seeing the options, I think I'd prefer to not have to worry what
extra magic is happening with cxl_read_mbox_reg32()

cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);

readl(cxlm->mbox_regs + CXLDEV_MB_CAPS_OFFSET);

The latter is both shorter and more idiomatic.


>
> > > > > +       /* 8.2.8.4.3 */
> > > >
> > > > ????
> > > >
> > >
> > > I had been trying to be consistent with 'CXL2.0 - ' in front of all spec
> > > reference. I obviously missed this one.
> >
> > FYI, I generally find section names much easier to find than section
> > numbers.  Especially as the numbers change very frequently, some times
> > even for very minor updates to the spec.  E.g. in NVMe the numbers might
> > even change from NVMe 1.X to NVMe 1.Xa because an errata had to add
> > a clarification as its own section.
>
> Why not both?
>
> I ran into this in fact going from version 0.7 to 1.0 of the spec. I did call
> out the spec version to address this, but you're right. Section names can change
> too in theory.
>
> /*
>  * CXL 2.0 8.2.8.4.3
>  * Mailbox Capabilities Register
>  */
>
> Too much?

That seems like too many lines.

/* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */

...this looks ok.
