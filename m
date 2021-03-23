Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D526F346839
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 19:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhCWS5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhCWS5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 14:57:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BCC061764
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 11:57:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ce10so28841675ejb.6
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ccyIWasdb6wjk9qd/GSKNuMErweE5kq6UtIF6wJrA0=;
        b=P55DV6kmPIjcTS2Mbm3kpmOPX6ArVTJIS7PT8ctxbXxxBpvCXA115nToQjURSt0gFE
         sZQYX1u2GUmrcU86ou11FUJBnCgpvCStFQGivJEvPU2d5HbW4EnRGFwCJSAU+D/lebqw
         rERZltSCprJiUKU3VulndADNMmVVQzPqBMM/ImBRObRk+79VZfwGuR5KqQzUr3S1nwBw
         wnYAfNBT6j/FIiNd8kzaZOyFWCkW3Z0cU50FFhdcjlciWsjbpizICBTAi7v2nGkhOuSN
         rQdHi0ncoFuNKOAG3oCjE2wfE/79jYya0UPtTo4G0mxlIu4T4tkLnu+ecYLYTvZdfHlR
         VO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ccyIWasdb6wjk9qd/GSKNuMErweE5kq6UtIF6wJrA0=;
        b=o5v1nUcuDGyw8WcmVcR8cat3sQwEhZLrCc7KPxRyhP9WV0qqXNWYUwdhf3AZGd52nl
         j4jXT8KtmvKwtuX3nfPjcmJW/d2/GRvTfjCRes5OBMlTrfc5ahqDBBGZ1Ayz6gKr89S/
         IG+Vn4XH0yAwQylmC4Wg1gOs6Bf6ZhODXsLNwT9UgvNh6sMitUEE1TPzdQ1qN1HyXOAV
         uPuXPO25HN4PLgQMZ4ZQeueFKVcBAN7Vg4wphdp6EwoV/LDn0HeGCXhSnU7dzhRP1ny2
         MT/iSk7OnLRaxAk6ZLdftxay4Yut+ipioUbuAV4tJehGmdoNooLX3iMZbFZBbdD71/F+
         5qaw==
X-Gm-Message-State: AOAM532L8ma035TCanV6BwIfdtb7aot1hao4uefeS+5ZEz5mFcurpd1d
        9kJ8SCRph5ts3VUv1/z/vvX/1Deq9H7mZ5+18iu8JA==
X-Google-Smtp-Source: ABdhPJwFAwxmGEHwKJvDYkbMkBlF5M5tkaZfVkQfvXBD9yItRSvGGNgfsv+ZJa/TEXJzcDBXb8Qce5lHjWwn6rttCN0=
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr6385132ejy.523.1616525830395;
 Tue, 23 Mar 2021 11:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
 <20210310180306.1588376-2-Jonathan.Cameron@huawei.com> <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
 <20210316162952.00001ab7@Huawei.com> <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
 <20210323182218.000049cf@Huawei.com>
In-Reply-To: <20210323182218.000049cf@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Mar 2021 11:57:01 -0700
Message-ID: <CAPcyv4j2gSKr2dPnk3Z9PeHDsJJjLVcWRkYbNpXy-R-6Az5KzA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object Exchange
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 23, 2021 at 11:25 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > I was thinking something like 'struct pcie_doe_object' pointers rather
> > than u32 arrays.
>
> Possibly... I'm not convinced that it doesn't end up being
> struct pcie_doe_object doe_obj;
> DOE_OBJ_INIT(&doe_obj, vid, type, request_pl, request_pl_sz,
>              response_pl, response_pl_sz)
>
> ret = pcie_doe_exchange(doe, &doe_obj);
>
> If that's the pattern we see, why split it?
> We might well have a struct pcie_doe_object internally but it doesn't
> seem like a sensible external interface to me simply because we'd
> just be filling it in and immediately passing it to a 'send' function.

I don't think there are going to be so many DOE users that would
justify DOE_OBJ_INIT(). I am thinking of a model where the payload
construction is open coded and typesafe similar to how
intel_bus_fwa_activate() [1] builds its mailbox payload.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/nfit/intel.c#n546


> > > The disadvantage is that at least some of the specs just have the
> > > header as their first few DW.  So there isn't a clear distinction
> > > between header and payload. May lead to people getting offsets wrong
> > > in a way they wouldn't do if driver was responsible for building the
> > > whole message.
> >
> > Aren't they more likely to get offsets wrong with u32 arrays rather
> > than data structures?
>
> I'm not sure what level you mean this at.  The CDAT patch review you
> followed this with suggested just breaking out vid and type which is
> fine because those are always packed the same and we can do appropriate
> special handling.
>
> If you meant the whole object as packed structure, then it is a whole
> different matter.
>
> Easy one to point is that u64 values are going to end up with their
> top and bottom halves swapped.  Things get even messier if we break
> up below the u32 level.
>
> We can do this at a higher level by having wrappers that deal with
> each protocol and do a serialize / deserialize for the protocol.
> I'm not sure if that will make sense or not yet though.

Again, I think the protocols to support are limited (CDAT and IDE/SPDM
are the only ones on the horizon), so not much value to having a rich
set of wrappers and macros to obfuscate payload generation.

>
> One thing I don't understand is why you proposed a delayed work queue
> above?  I'm not seeing that model in the libsas SMP for example.  As far
> as I can tell that just processes work items asap.
>
> Can you point to a more specific example if you thinks that we should
> use one?

For polling on a timeout a delayed workqueue can poll at an interval
without need for any explicit sleep calls. There are several examples
of queue_delayed_work() in drivers/ being used to advance a state
machine after a protocol relative timeout.
