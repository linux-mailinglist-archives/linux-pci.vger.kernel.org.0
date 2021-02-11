Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC633194A3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 21:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhBKUlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 15:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhBKUli (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 15:41:38 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C00C061788
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 12:40:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so8372665edd.5
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+MkWSBkvC/UMwT/VgZJGycfyB5NFr4bsCioBd7cfA4=;
        b=coyflfwbCdbsJ3zzo0z6wSKT59iLTCQVdnZtGrbaNG8QIdR39uPo9V6tfCTRydcisL
         4k5JGnBJW2bwe/Y98Ay8kKjlpA7C1M7t5HKlvHlD2W0hs4hkrrX9jMaaFPooSlzZaqeb
         qnbKvbKvtFMP2Gcb2JhAqzQcRwHeCtf4BKRWIpIIHZen8wJEdzLIzoQePkCym3WVdGd/
         8amklPn5Y1DQDOGZ65J3q4g6AmlJfZBY5cUKedCA145v+34ax7wnmlls4kKFRLPdURDS
         HwZMs0P9MDREJORNNWoZRXavVtngNRUPbTJE6VBjR5mURUsu/qMEf25CUKIaBzJwIfJh
         67gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+MkWSBkvC/UMwT/VgZJGycfyB5NFr4bsCioBd7cfA4=;
        b=a6aAhD3mYUpOVLR2fgERPOsQSkLR4ibMW/Xu+lCAv4fGS61bqX7EG7iqLf08YkPytz
         abTSVSVlm8Me033rMayC8O9q82t0hJu20yOJH6oAmMdO/WbJvG0adFjRlMlYIaEJuGUu
         +qXNZIvC9L7jvlvn87u2TH8U2IWjtMeTOxP7X2LAlokBJn7fndNp2mP/dMmj0Fdv9Us/
         ApLx+fYpREslbpmUE0ymhAFv5/fun9wrs0g6/NMFhI8aRaLWPd67eJJbnvcrjZ85y3yw
         8dwgr1vWOc0TKGM900KRySHgHPwAQ27jXXZ79fguT4e8Ii0FtL/i+iVQ4n+NXS6eJWa1
         2sVQ==
X-Gm-Message-State: AOAM530t9Be+49OpSIZjjWjHP1Z96pa+EvF9PJpLo9TJLukKT9+46TAH
        i4rlphXPBciMrl8WplhLyBZROtGznk0PfQdDHbfOgA==
X-Google-Smtp-Source: ABdhPJwUwoQIw5/TCL2CLB2ZlTQ8uewrH9tgE5Yw4rRMQ6jMgq9i5WT/KqL+JKgKKFkIg69ICnqn7QI9yjjwV0IjT0U=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr9870835edc.97.1613076055992;
 Thu, 11 Feb 2021 12:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-4-ben.widawsky@intel.com> <20210210181725.00007865@Huawei.com>
 <20210211101746.00005e8c@Huawei.com>
In-Reply-To: <20210211101746.00005e8c@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Feb 2021 12:40:45 -0800
Message-ID: <CAPcyv4hgzv7B7sv85A3No-bAgeADqfrhRySBrQBx43HVEMfnzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] cxl/mem: Register CXL memX devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 2:19 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Feb 2021 18:17:25 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Tue, 9 Feb 2021 16:02:54 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Create the /sys/bus/cxl hierarchy to enumerate:
> > >
> > > * Memory Devices (per-endpoint control devices)
> > >
> > > * Memory Address Space Devices (platform address ranges with
> > >   interleaving, performance, and persistence attributes)
> > >
> > > * Memory Regions (active provisioned memory from an address space device
> > >   that is in use as System RAM or delegated to libnvdimm as Persistent
> > >   Memory regions).
> > >
> > > For now, only the per-endpoint control devices are registered on the
> > > 'cxl' bus. However, going forward it will provide a mechanism to
> > > coordinate cross-device interleave.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > One stray header, and a request for a tiny bit of reordering to
> > make it easier to chase through creation and destruction.
> >
> > Either way with the header move to earlier patch I'm fine with this one.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Actually thinking more on this, what is the justification for the
> complexity + overhead of a percpu_refcount vs a refcount

A typical refcount does not have the block and drain semantics of a
percpu_ref. I'm planning to circle back and make this a first class
facility of the cdev interface borrowing the debugfs approach [1], but
for now percpu_ref fits the bill locally.

> I don't think this is a high enough performance path for it to matter.
> Perhaps I'm missing a usecase where it does?

It's less about percpu_ref performance and more about the
percpu_ref_tryget_live() facility.

[1]: http://lore.kernel.org/r/CAPcyv4jEYPsyh0bhbtKGRbK3bgp=_+=2rjx4X0gLi5-25VvDyg@mail.gmail.com
