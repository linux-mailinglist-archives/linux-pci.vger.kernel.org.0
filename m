Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F130B27D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 23:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBAWC6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 17:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBAWC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 17:02:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B853CC0613ED
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 14:02:15 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id rv9so26740552ejb.13
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 14:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=yRi8mguQqwGyP74Lz8HnidEorwfF7klt4qQMuE6uyPGrI0nnVf3UO1/tbJR+kWOOGR
         dWmIQcJgh8tUURN0ieUfGpl3soucjW0wrSDuKx6Y9XL66sU8opnIg7sxdwSNSWp0fLIr
         nQTxV7ahPPxceFtgJKNxCIJWgLTD7hfKHYxTCqUPpp1scoT0JWUDr3XWsuBhkaWsp2Ko
         ku9Jrb6DLqZ+8d/xmEcVgGxMbIkRA+sIynA/F4cTTRjVtBfrkLzvKwBPHtBFKCEVpHC4
         s94dtYIxVabjk/YTMSmQlvYnC5/uXpJNxnnYFAza3R9pXfMZNpwI9PbJpgEUEG7m6ZhM
         cCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=VhHGNJqOGnVej4Wp7d68ENHLNkKAcm79m8OEtohY+O6JfQE4AABRww9tG/W9fPEcbg
         UVdLnOmyGJQmNwLa3HJh9Hlxc8+r0TpEJJFMgGjwgc2ZsiJguWUEpu6DzmMF29VTFle5
         nWbA+ZyWOKChEd/Ys9HG0Nd+B7+fg6s5jD07OpDlD7ppIq+0RQcgmqbLuo2f/+GAJdxK
         Qwqy6TTv8tHkMDMHR/FpFnbuphaUOqK1N/NObm/5gpNNHQgI0M7HpLaU9DJQKLBJD8jK
         AoXtGWdab+YhPs6P9b7B/TEf1XdhM+cSa0pIVFA1Lseisc+uMUe14UkK6m2FM50V2izF
         tWww==
X-Gm-Message-State: AOAM532FcY4BUoo7pb2wDtvzGFaKCOS05/6rN3U1mQgwlKQX3sSuOpTz
        3LQpqsaAm9/OhEJkgZuEXd2l1KG4N6GdwLEEIjP+2g==
X-Google-Smtp-Source: ABdhPJwx5HQJkiYYzBPXX7BYLe1eriXrLIkYHDMYupmuWFH/I1Xqh4x+vyz3z88NdGsEK2HXTHd3EhXx58RQNYJdZQ8=
X-Received: by 2002:a17:906:af6b:: with SMTP id os11mr8117536ejb.472.1612216934397;
 Mon, 01 Feb 2021 14:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
In-Reply-To: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Feb 2021 14:02:11 -0800
Message-ID: <CAPcyv4jyojkRqkXPK=ZgMfUATVNUf71GZsgQuarygz4QEM1o-w@mail.gmail.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
To:     David Rientjes <rientjes@google.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
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

On Mon, Feb 1, 2021 at 1:51 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
>
> > On 21-01-30 15:51:49, David Rientjes wrote:
> > > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > >
> > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > +{
> > > > + const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > +
> > > > + cxlm->mbox.payload_size =
> > > > +         1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > +
> > > > + /* 8.2.8.4.3 */
> > > > + if (cxlm->mbox.payload_size < 256) {
> > > > +         dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > +                 cxlm->mbox.payload_size);
> > > > +         return -ENXIO;
> > > > + }
> > >
> > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and
> > > return ENXIO if true?
> >
> > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > driver not allow it?
> >
>
> Because the spec disallows it :)

Unless it causes an operational failure in practice I'd go with the
Robustness Principle and be liberal in accepting hardware geometries.
