Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E32F3DB6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436645AbhALVhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 16:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436668AbhALUHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 15:07:21 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9267BC061786
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 12:06:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id g20so5316564ejb.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/Bid2Bzf98jE1/ALAKGTMu2+XIpeX//lGOiyhOAPLE=;
        b=vhrrzDmitO32JAO3cpPHjbqdMSMUZDuwupYPaErRNdmyLCV9CGhPdYK6oTrgJG74+m
         I9dA7oEIptk1EhB30sBwuzhsn5ped+8hrj1SEpOIehrqgvt9hLGZusi5QYNsLyb0Ojr7
         B5CZvlBXkQak1yX5cCoTDYZjpURO/BDj90CBV2xV11nCqustJMw6QGBur7B+HWFMThJz
         1UOpx1uPYSC7PIQzDXmNwWVBl2xqVAawLUUMn5pIwD3C/PuDUKVuv9cePx/NSJz7tGiC
         JaIZx/W2kwjLwrF97+S1fQrkm406AotYB5qwe5dQ+9CSge06C4wEogikQR+XPc1DtPae
         9wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/Bid2Bzf98jE1/ALAKGTMu2+XIpeX//lGOiyhOAPLE=;
        b=TDRrlPU//QysJrrEXSvkSlgttSHjE19WWcHQ5GlQkw9EVdd85PNAIrFwSu8vWAomWU
         g3fr3pdmq3shu+v4nnuIOwlfFFG1WE6xMgbWGLqrYRvg+sFo8pLZ3t7uG1XeUHNKM4K8
         rqIRGjHmyLll2qHOUqZsTWXcY4Gc0KK0T8JAGoMIsA24Pzk696z6xMAvnL1ZcIv1eeTB
         lsC4SJY8gI1kB9LWiOs8LKaoP4AR5PKfa+giaRGP9Khn7MRij98j843lOJs6043ReVZU
         Sog1YS2MQUoL0OYirkZn4adXKT3DKt3sDCI+gBuwKuHVL4GpVFzgaIfEWQoTJFzeSco3
         GGvg==
X-Gm-Message-State: AOAM530kfkM82PwcnTURXGIzDOOV97NvnTW5SJRwURecQBcLEOxP+hsw
        MOhdoZu+EgHp3dF1UUJNxDKprSV8AB0z0z3tzs9o7g==
X-Google-Smtp-Source: ABdhPJyfN4mVkZqUgmpVifgODbiKiUV7zPHfN/mvTykoOz6wGwySd2pfuLRTAFzoWqiTJ14Yjd/67QsQSjvEqEh7UX8=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr357027ejc.418.1610481999273;
 Tue, 12 Jan 2021 12:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-5-ben.widawsky@intel.com> <20210112190103.00004644@Huawei.com>
In-Reply-To: <20210112190103.00004644@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 12:06:30 -0800
Message-ID: <CAPcyv4iGVPgu_c0GOYTuAQyFJgfMuU5S45Ukd968+DV--Y6miw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/16] cxl/mem: Introduce a driver for
 CXL-2.0-Type-3 endpoints
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 11:03 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 11 Jan 2021 14:51:08 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> >
> > The CXL.mem protocol allows a device to act as a provider of "System
> > RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> > was attached to the typical CPU memory controller.
> >
> > With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
> > device interface and give the operating system control over "Host
> > Managed Device Memory". See section 2.3 Type 3 CXL Device.
> >
> > The memory range exported by the device may optionally be described by
> > the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> > provision persistent memory capacity from one, or more, CXL.mem devices.
> >
> > A pre-requisite for Linux-managed memory-capacity provisioning is this
> > cxl_mem driver that can speak the mailbox protocol defined in section
> > 8.2.8.4 Mailbox Registers.
> >
> > For now just land the driver boiler-plate and fill it in with
> > functionality in subsequent commits.
> >
> > Link: https://www.computeexpresslink.org/download-the-specification
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> Just one passing comment inline.
>
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > new file mode 100644
> > index 000000000000..005404888942
> > --- /dev/null
> > +++ b/drivers/cxl/mem.c
> > @@ -0,0 +1,69 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/io.h>
> > +#include "acpi.h"
> > +#include "pci.h"
> > +
> > +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>
> Is it worth pulling this out to a utility library now as we are going
> to keep needing this for CXL devices?
> Arguably, with a vendor_id parameter it might make sense to have
> it as a utility function for pci rather than CXL alone.

Sure, cxl_mem_dvsec() can move to a central location, but I'd wait for
the first incremental user to split it out.
