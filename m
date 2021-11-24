Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D111A45B533
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 08:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhKXHVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 02:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhKXHVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 02:21:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD8C061714
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 23:18:05 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so1114131plf.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 23:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZsT1FSHDyaY9/s70Y47zUY48xSLAPgtV4eMnxuMyqM=;
        b=uCt+a/Ucg6WquOuyAI+fPlcKMN4FXIAAN6kj669vDgyIGgiS5z+al5mTiA2L5Fq82E
         jFUosGaT4ENUnyeuTADyEJ/n6YnCaTDQhhcmf1f6P92BRQYNGm2ZyYQjy2T9qJ17Cr6N
         K460qRMkhtDfj3FxutM5c3Zc24GdjUsQytvQx3lxztXyyTYPUA2bulLIWMkIY3Pe3ICL
         wvyputyAPmv9fPcNJkouQA9Jhakg4ecDCLtV0WJP5lSPwO5mQVPY6FrnP9Qa0qd1FHbX
         eEZSvKbrmWKRZFpAaJGQh2W4mJnSqdX0YQ8EFcuuOnGWJXr6syGhW7kQBH9sta2i7daw
         a6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZsT1FSHDyaY9/s70Y47zUY48xSLAPgtV4eMnxuMyqM=;
        b=Zhf3SGtoOHVo7zBdFTeRCdLKM6eo1gRgxbQPiFdPubpAIlCFWd2DaMFeCqfONaHpgR
         kuSPboXAuycdwbavRk24iKDNWF7uzLrNK0LIjst7y87VHIWYm/OYdYMENC+0uwgCWt0G
         pU2j59e6nDwrkGj4zM2fn2WGsCuacKuY/+gHaTCcDYGbdUSrlWjDO5HB8UY1x7JgKi4S
         jVUVvV39dcuj0ZOBkcczIIT1UQs/5yAqhW2Jmt/N4yqjuh6QpMuhDWZaYLe9ZqJFIskQ
         QsJI327ED38yeQhfzUnIG/0jyI/jllGgl0pxUxY4wyEyuF+iPdH1+cBLCfcDYUS05oFE
         AEeg==
X-Gm-Message-State: AOAM531EufUG/osesysWaUhqnxXtw7annjq86OjqnpvRZ/XMPCfZ1wli
        DdOlnyFLMA/3GhSSEwqABxbISZypv9/yS46/9G1xaA==
X-Google-Smtp-Source: ABdhPJyOSDeHeuNDH1xwGYaHeaEKuJ/wWe5ZmM/3Mc2d6QuQP7kRh27544PVv8e7C3uetKBIU8LjJtqEuf1yjNJQeWU=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr12320327pjb.8.1637738285436;
 Tue, 23 Nov 2021 23:18:05 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
 <20211123235557.GA2247853@bhelgaas> <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
 <20211124063316.GA6792@lst.de>
In-Reply-To: <20211124063316.GA6792@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 23:17:55 -0800
Message-ID: <CAPcyv4ii=bjKNQxoMLF-gscJy7Bh8CUn205_1GpCwfMyJ22+6g@mail.gmail.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Nov 23, 2021 at 04:40:06PM -0800, Dan Williams wrote:
> > Let me ask a clarifying question coming from the other direction that
> > resulted in the creation of the auxiliary bus architecture. Some
> > background. RDMA is a protocol that may run on top of Ethernet.
>
> No, RDMA is a concept.  Linux supports 2 and a half RDMA protocols
> that run over ethernet (RoCE v1 and v2 and iWarp).

Yes, I was being too coarse, point taken. However, I don't think that
changes the observation that multiple vendors are using aux bus to
share a feature driver across multiple base Ethernet drivers.

>
> > Consider the case where you have multiple generations of Ethernet
> > adapter devices, but they all support common RDMA functionality. You
> > only have the one PCI device to attach a unique Ethernet driver. What
> > is an idiomatic way to deploy a module that automatically loads and
> > attaches to the exported common functionality across adapters that
> > otherwise have a unique native driver for the hardware device?
>
> The whole aux bus drama is mostly because the intel design for these
> is really fucked up.  All the sane HCAs do not use this model.  All
> this attchment crap really should not be there.

I am missing the counter proposal in both Bjorn's and your distaste
for aux bus and PCIe portdrv?

> > Another example, the Native PCIe Enclosure Management (NPEM)
> > specification defines a handful of registers that can appear anywhere
> > in the PCIe hierarchy. How can you write a common driver that is
> > generically applicable to any given NPEM instance?
>
> Another totally messed up spec.  But then pretty much everything coming
> from the PCIe SIG in terms of interface tends to be really, really
> broken lately.

DVSEC and DOE is more of the same in terms of composing add-on
features into devices. Hardware vendors want to mix multiple hard-IPs
into a single device, aux bus is one response. Topology specific buses
like /sys/bus/cxl are another.

This CXL port driver is offering enumeration, link management, and
memory decode setup services to the rest of the topology. I see it as
similar to management protocol services offered by libsas.
