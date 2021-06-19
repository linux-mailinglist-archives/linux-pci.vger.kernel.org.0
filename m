Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DDE3ADAEA
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhFSQhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 12:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232959AbhFSQhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 12:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624120510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYyzt4cNti3kmXkoi7E1mYGxs62FMf8+WgvjuaIB/pc=;
        b=PNJpJukrqsv+jVcYaF1OF0SIN0PxDNxHHFX0DBRe5FHzYs7OeMYAcxEHIO6Y8oKtJBpvXu
        bVX6hUS0oNNzkyx0UGeMf48yB5tZWd32K9xEAUPK5AI+wnLrnRrhLj2heWhzZZ5MgNYjXw
        arNunInn0xzWuB2i/gVzfOPmGVu3Mi4=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-XAhfcm95N4mLCRF9BOYbHw-1; Sat, 19 Jun 2021 12:35:08 -0400
X-MC-Unique: XAhfcm95N4mLCRF9BOYbHw-1
Received: by mail-vs1-f71.google.com with SMTP id s21-20020a67ce150000b0290272f5adc950so351966vsl.16
        for <linux-pci@vger.kernel.org>; Sat, 19 Jun 2021 09:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYyzt4cNti3kmXkoi7E1mYGxs62FMf8+WgvjuaIB/pc=;
        b=EBo8IzeZ/qU3R1EN4LarzqKT30wqdnwbHof4kAdksQcX22hzQm3mFnMvadqJAmn+Gm
         91LYvi5+aJ8gGsWGm3ttbu5qZmMDqDb5XfKWtnhKMIi4Hv5gmuvLU1fN+grQHTQH4IO1
         7B3+KYAFG+MnF1/QExES8s4BE3JiG05d1KFe15yFmMoYbgkJuMclkHeYzcjcKZmXGhfB
         h0R97gyKqv3CdBTz0fuyIl6CBag19HpesVwq5ZOPFtCEMwag19zqRnXlq44v80t7KNvm
         7Pe0Q0m7DxVa1K+nk1d2T6ICrA8PAZznWgdORgj/VRAIHjQ5cVDJP93w3dKAn4o01bGL
         jW6Q==
X-Gm-Message-State: AOAM530mBBrpnPDe8gVUwfgdK5iq8JmKxZFj7LJ5mVd4WJNXjdBUg8Eb
        qZQyFJ+kei6WhVJvajmgALHpB6ek6HmnMgD43UOAGLvx6ZdjhMu+FbUlExT8Sd+leIHHXMTKFIs
        UMT3d56L5t/Vd74CcnQ6oVMYuw5qP5Uqx5r0b
X-Received: by 2002:a9f:3743:: with SMTP id a3mr17073601uae.92.1624120508255;
        Sat, 19 Jun 2021 09:35:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7tsnZ19MELoFuTC7GgQpSNKhNWpByQDwABidkB3EP/eqY0EW9ZaDVMwk8IdppZOrEep7tC0lXUZAQFnyRFoE=
X-Received: by 2002:a9f:3743:: with SMTP id a3mr17073574uae.92.1624120508072;
 Sat, 19 Jun 2021 09:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck> <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com> <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com> <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com> <20210616173646.GA1840163@nvidia.com>
 <CA+kK7ZijdNERQSauEvAffR7JLbfZ512na2-9cJrU0vFbNnDGwQ@mail.gmail.com> <20210618140554.GD1002214@nvidia.com>
In-Reply-To: <20210618140554.GD1002214@nvidia.com>
From:   Jon Masters <jcm@redhat.com>
Date:   Sat, 19 Jun 2021 12:34:57 -0400
Message-ID: <CA+kK7ZhJ8+BhLZeZ5XtL2M_qDpOo823taFbM45DTV=H6L1EvhQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Eric Brower <ebrower@nvidia.com>, Grant.Likely@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,

On Fri, Jun 18, 2021 at 10:06 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Jun 18, 2021 at 09:21:54AM -0400, Jon Masters wrote:
> >    Hi Jason,
> >    On Wed, Jun 16, 2021 at 1:38 PM Jason Gunthorpe <[1]jgg@nvidia.com>
> >    wrote:
> >
> >      On Thu, Mar 25, 2021 at 01:12:31PM +0000, Lorenzo Pieralisi wrote:
> >      However, in modern server type systems the PCI config space is often
> >      a
> >      software fiction being created by firmware throughout the PCI
> >      space. This has become necessary as the config space has exploded in
> >      size and complexity and PCI devices themselves have become very,
> >      very
> >      complicated. Not just the config space of single devices, but even
> >      bridges and topology are SW created in some cases.
> >      HW that is doing this is already trapping the config cycles somehow,
> >      presumably with some very ugly way like x86's SMM. Allowing a
> >      designed
> >      in way to inject software into the config space cycles does sound a
> >      lot cleaner and better to me.
> >
> >    This is not required. SMM is terrible, indeed. But we don't have to
> >    relive it in Arm just because that's [EL3] the easy place to shove
> >    things :)
>
> "This is not required"? What does that mean?

It's not required to implement platform hacks in SMM-like EL3. The
correct place to do this kind of thing is behind the scenes in a
platform microcontroller (note that I do not necessarily mean Arm's
SCP approach, you can do much better than that).

> >      For instance it may solve other pain points if ARM systems had a
> >      cheap
> >      way to emulate up a "PCI device" to wrapper around some IP blob on
> >      chip. The x86 world has really driven this approach where everything
> >      on SOC is PCI discoverable, and it does seem to work well.
> >      IMHO SW emulation of config space is an important ingredient to do
> >      this.
> >
> >    There are certainly ways to build PCI configuration space in a
> >    programmable way that does not require software trapping into
> >    MM.
>
> Can you elaborate on what you'd like to see here? Where do you want to
> put the software then?

There are places other than EL3 where this should live. It should not
involve the AP at all in a correct configuration. It should (only)
appear to be done in hardware, but where you do it is up to an
implementation. Doing it correctly also accounts for others accessing
configuration space simultaneously. You don't want to have to stop the
world, or break PCI ordering semantics on access. There is a right way
(hardware) to do this, and a wrong way (EL3 hacks). But I'll leave
folks to figure out how to implement it. There are several possible
approaches to do this.

> >    I strongly agree with the value of an industry standard approach
> >    to this in hardware, particularly if the PCIe vendors would offer
> >    this as IP.  In a perfect world, ECAM would simply be an
> >    abstraction and never directly map to fixed hardware, thus one
> >    could correct defects in behavior in the field. I believe on the
> >    x86 side of the house, there is some interesting trapping support
> >    in the LPC/IOH already and this is absolutely what Arm should be
> >    doing.
>
> AFAIK x86 has HW that traps the read/writes to the ECAM and can
> trigger a FW flow to emulate them, maybe in SMM, I don't know the
> details. It ceratinly used to be like this when SMM could trap the
> config space io read/write registers.

They trap to something that isn't in SMM, but it is in firmware. That
is the correct (in my opinion) approach to this. It's one time where
I'm going to say that all the Arm vendors should be doing what Intel
is doing in their implementation today.

> Is that what you want to see for ARM? Is that better than a SMC?

Yes, because you preserve perfect ECAM semantics and correct it behind
the scenes. That's what people should be building.

> That is alot of special magic hardware to avoid a SMC call...

And it's the correct way to do it. Either that, or get ECAM perfect up
front and do pre-si testing under emulation to confirm.

</opinion>

Jon.

