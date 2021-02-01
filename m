Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCF30B1FF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 22:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBAVU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 16:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhBAVU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 16:20:59 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F8DC061756
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 13:20:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id i8so10178440ejc.7
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 13:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKV8tfXM/P2yr23U8IrmSV+OjOgK46IvUPsK7p0jMgk=;
        b=jZLlF1BLcZiQNvZuriBZtAzF6XOXuBz6zZN01Lb11NP+6NRYwxYB0ZMdTbEIExzDKb
         r/gC0LbZUA18tkBHhoxigMtqVYDxB4j+RWtLlmqHfDvcPVcvDdr3AUlNiqW2LxbOfb3O
         +V+GSB9O1BjCxxSnLTCxG8gvlUz2B5Itq3vnR+d9KT98zWWMdBnlW1/DAzbz4ulPCc4G
         nq+Wrn51F//JFhDa2w3l398dovOGhgDJhWKfhYV/ofnLxv7doKXgn3rI+ESCn2v5Ofq9
         ZecFkI5v7FgvOkds/8sJojnO2M7YKnUAbPpdVdFqGTVqquOyo2GU3ijaFXNzoa5HRNf0
         nLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKV8tfXM/P2yr23U8IrmSV+OjOgK46IvUPsK7p0jMgk=;
        b=kSymrqkgwsF+8soTcApVB6Y44fGniPhxSRUDNgzZLHCVL9cNz5jj8OCaZpImrwJEXM
         2pi+k/Jz1fVG/10jbaxbscpQNZxdG0wXd5L1ij3ezOsozYVFyL2qMEk5BXy2ij6ToyRL
         TsQu0IOG/ys79UWJF0jRGTRIORJxwdjxi8XVWGZv1PbXZe67EmYYnYUIB8drxn0CPH1L
         YJujpbS21EmNJp/lDkDSFZsRIyo38kpvlBnGrRS7ERZpA7mRgPfNPaYJa5CQEp5dVT+z
         0KmbQaFiDev/ItOBMmUKfK6vSJgYi6ZLSfGBAu/LG2r96l48YchP/HqskKrIbVHbsSh3
         HpBA==
X-Gm-Message-State: AOAM531M8V84VanxLj5WPvdyWvSZcdfngZ9HGr5WTYzDvhmRrBUaIsFK
        dxDu1a8sW5NKE3M8A6v2OBaQ1dBCrR1g5NtZeBQYdw==
X-Google-Smtp-Source: ABdhPJwA3l0e3MUGip6gEtrbLA1M+onIFo5pqjzQ23LyigVAMvz9JEe/SBsagHRrDaseCVuas2GfBzS5C8qSA8H7dF0=
X-Received: by 2002:a17:906:f919:: with SMTP id lc25mr20142627ejb.323.1612214417615;
 Mon, 01 Feb 2021 13:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-10-ben.widawsky@intel.com> <20210201182400.GK197521@fedora>
 <20210201192708.5cvyecbcdrwx77de@intel.com> <20210201193453.GA308086@fedora>
In-Reply-To: <20210201193453.GA308086@fedora>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Feb 2021 13:20:14 -0800
Message-ID: <CAPcyv4hivzQh=rresymO+fRP2g1LLJzEr2d7Or6Pha7V_1L6Pg@mail.gmail.com>
Subject: Re: [PATCH 09/14] cxl/mem: Add a "RAW" send command
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Mon, Feb 1, 2021 at 11:36 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Mon, Feb 01, 2021 at 11:27:08AM -0800, Ben Widawsky wrote:
> > On 21-02-01 13:24:00, Konrad Rzeszutek Wilk wrote:
> > > On Fri, Jan 29, 2021 at 04:24:33PM -0800, Ben Widawsky wrote:
> > > > The CXL memory device send interface will have a number of supported
> > > > commands. The raw command is not such a command. Raw commands allow
> > > > userspace to send a specified opcode to the underlying hardware and
> > > > bypass all driver checks on the command. This is useful for a couple of
> > > > usecases, mainly:
> > > > 1. Undocumented vendor specific hardware commands
> > > > 2. Prototyping new hardware commands not yet supported by the driver
> > >
> > > This sounds like a recipe for ..
> > >
> > > In case you really really want this may I recommend you do two things:
> > >
> > > - Wrap this whole thing with #ifdef
> > >   CONFIG_CXL_DEBUG_THIS_WILL_DESTROY_YOUR_LIFE
> > >
> > >  (or something equivalant to make it clear this should never be
> > >   enabled in production kernels).
> > >
> > >  - Add a nice big fat printk in dmesg telling the user that they
> > >    are creating a unstable parallel universe that will lead to their
> > >    blood pressure going sky-high, or perhaps something more professional
> > >    sounding.
> > >
> > > - Rethink this. Do you really really want to encourage vendors
> > >   to use this raw API instead of them using the proper APIs?
> >
> > Again, the ideal is proper APIs. Barring that they get a WARN, and a taint if
> > they use the raw commands.
>
> Linux upstream is all about proper APIs. Just don't do this.
> >
> > >
> > > >
> > > > While this all sounds very powerful it comes with a couple of caveats:
> > > > 1. Bug reports using raw commands will not get the same level of
> > > >    attention as bug reports using supported commands (via taint).
> > > > 2. Supported commands will be rejected by the RAW command.
> > > >
> > > > With this comes new debugfs knob to allow full access to your toes with
> > > > your weapon of choice.
> > >
> > > Problem is that debugfs is no longer "debug" but is enabled in
> > > production kernel.
> >
> > I don't see this as my problem. Again, they've been WARNed and tainted. If they
>
> Right not your problem, nice.
>
> But it is going to be the problem of vendor kernel engineers who don't have this luxury.
>
> > want to do this, that's their business. They will be asked to reproduce without
> > RAW if they file a bug report.
>
>
> This is not how customers see the world. "If it is there, then it is
> there to used right? Why else would someone give me the keys to this?"
>
> Just kill this. Or better yet, make it a seperate set of patches for
> folks developing code but not have it as part of this patchset.

In the ACPI NFIT driver, the only protection against vendor
shenanigans is the requirement that any and all DSM functions be
described in a public specification, so there is no unfettered access
to the DSM interface However, multiple vendors just went ahead and
included a "vendor passthrough" as a DSM sub-command in their
implementation. The driver does have the "disable_vendor_specific"
module parameter, however that does not amount to much more than a
stern look from the kernel at vendors shipping functionality through
that path rather than proper functions. It has been a source of bugs.

The RAW command proposal Ben has here is a significant improvement on
that status quo. It's built on the observation that customers pick up
the phone whenever their kernel backtraces, and makes it is easy to
spot broken tooling. That said, I think it is reasonable to place the
RAW interface behind a configuration option and let distribution
policy decide the availability.
