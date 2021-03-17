Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6FE33E65E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 02:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhCQBnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 21:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhCQBms (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 21:42:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D8C06175F
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 18:42:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c10so75260798ejx.9
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7/LGJ21YJO+iFucD9rDYt4XctUqizzW3vd6M6Od5hY=;
        b=mBd6zM+h30VvBCVo7YKbshWuCmLQwP6+CkVoCaF6k1Q+mjVxuDq2Lpr56oYu5tNvQv
         QENLsiIq88DdP8PnL8A9eKOxVDbxhzHuRaP7PZIXVuf7tBIMjSeGAx+DeYXq5LYEF1t9
         p2bz6YPuvwtBRo/2YUG2zl3DBV7oCIRmXPwpFBxR8T7RcyTo3uU6O0HRmXsuFwznXiUq
         hBsuImbVPkRNG9kBchYa3qrfYk3hSuIndbnLVyxMnzz91PC9PUnGW6SD0XXTzDnrvr0n
         F9KxlR8CSgrIs1ZI1n0FND7MX1AtaV2yFQGkpIDw9z9CMkrEoyzQ8vPyzEbhXbgm2Jdf
         RO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7/LGJ21YJO+iFucD9rDYt4XctUqizzW3vd6M6Od5hY=;
        b=pqDEfLrFLtWvjjBW/IXweEA2w9O0unuftl2+OaCbQ7WUcV4xJQlyJO0UfEt8zZIhWU
         fIq2HYPF53qVR1tFcGXunKqWj8NcrHEzXVLu2KIX6IsG4a0po7akvQBE7TZxyvoudeJv
         gvBWxnI2RKKSMALFqoGZw9K9wGC61CPRP5fjAG2ox7pISYjL1sZMteQzEqgKV1T2Us9r
         rn/TikVlEPQEEzQ/Cn++LAg5+SMMnweE8gpuvsev+75BQYjMomL7pk48qrTQdHKkw40k
         kyALty7k+7Ws0v38e24xb9XKdTk7lypJec/yGc4uNRiaFwEsAV23fq3smtKSbF0t3Bgs
         Q1pw==
X-Gm-Message-State: AOAM531jYHJ5JvcFSpNOa8aLpBd39F+bK0h9sKbO/CQBwM4BlVMhyXoS
        Ll7TAhytX6VUnH1a4P25bo6e1uPeO3dMrodDMIGlKA==
X-Google-Smtp-Source: ABdhPJzTz0Uox7DT2yEbQA5bjykjK5xvAEvf2V4VMxTqqm73jeFUZzjd5CyhqUNVsWi968pRxJhDI9eXhY4kVUUROP4=
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr22939142eje.472.1615945366315;
 Tue, 16 Mar 2021 18:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
 <20210310180306.1588376-3-Jonathan.Cameron@huawei.com> <20210310181459.000005c7@huawei.com>
 <CAPcyv4jq-KovQcEqesA=kCdzdDNtQ9y8g2aBCSXqQv7cvmABtg@mail.gmail.com> <20210316103647.00002f4b@Huawei.com>
In-Reply-To: <20210316103647.00002f4b@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Mar 2021 18:42:38 -0700
Message-ID: <CAPcyv4ikiWau7J-uc7yj85VCfPrc2ivnJ81fSnkEN0SXciDUyg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
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

On Tue, Mar 16, 2021 at 3:38 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 15 Mar 2021 15:00:08 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Wed, Mar 10, 2021 at 10:15 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Thu, 11 Mar 2021 02:03:06 +0800
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > > This patch simply provides some debug print outs of the entries
> > > > at probe time + a sysfs binary attribute to allow dumping of the
> > > > whole table.
> > > >
> > > > Binary dumping is modelled on /sys/firmware/ACPI/tables/
> > > >
> > > > The ability to dump this table will be very useful for emulation of
> > > > real devices once they become available as QEMU CXL type 3 device
> > > > emulation will be able to load this file in.
> > > >
> > > > Open questions:
> > > > * No support here for table updates. Worth including these from the
> > > >   start, or leave that complexity for later?
> > > > * Worth logging the reported info for debug, or is the binary attribute
> > > >   sufficient?  Larger open question of whether to expose this info to
> > > >   userspace or not left for another day!
> > > > * Where to put the CDAT file?  Is it worth a subdirectory?
> > > > * What is maximum size of the SSLBIS entry - I haven't quite managed
> > > >   to figure that out and this is the record with largest size.
> > > >   We could support dynamic allocation of the record size, but it
> > > >   would add complexity that seems unnecessary.
> > > >   It would not be compliant with the specification for a type 3 memory
> > > >   device to report this record anyway so I'm not that worried about this
> > > >   for now.  It will become relevant once we have support for reading
> > > >   CDAT from CXL switches.
> > > > * cdat.h is formatted in a similar style to pci_regs.h on basis that
> > > >   it may well be helpful to share this header with userspace tools.
> > > > * Move the generic parts of this out to driver/cxl/cdat.c or leave that
> > > >   until we have other CXL drivers wishing to use this?
> > >
> > > Naturally I remembered another open question within 10 seconds of sending :(
> > >
> > >   * Do we want to add any sort of header to the RAW dump of CDAT to aid
> > >     tooling?  Whilst it looks a little like an ACPI table it doesn't have
> > >     a signature.
> > >
> > > My gut feeling is no, because the CDAT specification doesn't define one but
> > > I can see that it might be very convenient to have something that identified
> > > the data once it was put in a file.
> >
> > I'm not yet convinced raw dumping is worth it for the same reason that
> > command payload logging was eliminated from the v5.12-rc1 submission.
> > There's not much userspace can do with the information besides debug
> > the kernel behavior. If the kernel assigns a numa node to target a
> > given CXL memory range with NUMA apis then HMEM_REPORTING should
> > enumerate the properties. In other words, don't expand the userspace
> > ABI problem, funnel users to the canonical source for such data.
>
> As someone who finds raw dumping of ACPI tables extremely helpful in every
> day use for debugging of some of our 'interesting' hardware, I know I'm going
> to end up carrying that element locally anyway.  I don't have a particular
> problem doing so if we decide to not to upstream it.
>
> Much like the ACPI table dumping, it's not an interface you expect userspace
> to ever use and I fully agree that we should expose things properly as you
> describe.
>
> Short term my interest here is to get the DOE code upstream as step 1 of
> moving to a full solution.  The printing and dumping is really just PoC element
> to prove out the interface.  Any issue with putting the prints under _dbg()?

debugfs_create_blob()? Although debugfs makes it annoying to support
per device blobs. I could get on board with a root-only sysfs
attribute, but using a static DEVICE_ATTR_ADMIN_RO()... more comments
incoming in a review of the patch.
