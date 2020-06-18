Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C791FF623
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgFRPEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgFRPE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 11:04:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B1C0613ED
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 08:04:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so7650028ljc.8
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3AaxzkJKvuJF6KN/5uB+HjzXUCfsnMRb9K1Yv0qPEs=;
        b=QIP0WJ0pNtpLo2KJbUw4+wbBhH7Nnk4+ZwOpPnliesoYCCasWqpMx0mMvynxG60m+Z
         u9PE+P5aKkxeVIOwcEMeLon6Vxu0ScvNx/Niy7Yn8ML9ty8p1K5Wm8ci57YEPFHfrR4P
         nuNnTB8kCWrogjZzQY7mXYIRdfoRzg01usyn60SP5OxOh7iWQEaYWfIvSZ3N8Zte4yZC
         Rmwzx1CddNdJNUqFG/N0Uke9o/ae2SSRn86wCciYZsKbVFC/U3vXdqP1N9vMXMDCRKEZ
         nivk6Tb2mzWBW2DcZpP2cyo8FA3tGarbAyFlHjAkABu/Oq6U36aYxnJ+PE3wuHAxS/BG
         aYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3AaxzkJKvuJF6KN/5uB+HjzXUCfsnMRb9K1Yv0qPEs=;
        b=gPuEv+DPOCmcdbKOu6A6xjJSOn7rsoNCEVHI+r4W62X314jfrIvOZCJBjZzd3hAKro
         83WzqFbyRuJwNoUn1w24rE48sOVZK7FLS5Z+YwihvsDC2w5HbNjNFFV58kSM1SjzdyJC
         hENIYvsxgXok2k2tO5ZcO/lrfBX5F3+2UBn54/vUzGBrgrKwr6/UU9exiL+0pvjk5Fr3
         AO3XYsuiV5f656TIQUlxxOZtUb/I8YWgnRTGyAQifd6EnQZVwkFVtu5DNvOLd0U+OvHi
         YJ/6so1U+5/f5ZzduMMTosNgenuwuvQcNEF7Fl7VSm+xlND44JjUd31/OpJZtMU5rw8B
         Pcfw==
X-Gm-Message-State: AOAM530GlGEFYnwlbW7D6CE65Y5Pta+asGoRknukGP3KQUuNhPld11F3
        2OWC2z6VWury+QXNDwoRTGUbtXvjjPz8K2gXqIP8QA==
X-Google-Smtp-Source: ABdhPJwvN0DsAWY3KYiObhTJs8ezFwVTnlVqyM1Aw6aFgxEL3CC4+lrTUDtkDUUgYpMKr67ZSTWxedjAX6xltpaE9DI=
X-Received: by 2002:a2e:908f:: with SMTP id l15mr2330895ljg.307.1592492665864;
 Thu, 18 Jun 2020 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org> <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org> <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com> <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 18 Jun 2020 08:03:49 -0700
Message-ID: <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > ...
> > >
> > > > (and likely call it "external" instead of "untrusted".
> > >
> > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > chosen by the meaning of it.
> > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > tables, but I can replace it.
> >
> > Then your ACPI tables should show this, there is an attribute for it,
> > right?
>
> There is a _PLD() method, but it's for the USB devices (or optional
> for others, I don't remember by heart). So, most of the ACPI tables,
> alas, don't show this.
>
> > > This is only one example. Or if firmware of some device is altered,
> > > and it's internal (whatever it means) is it trusted or not?
> >
> > That is what people are using policy for today, if you object to this,
> > please bring it up to those developers :)
>
> > > So, please leave it as is (I mean name).
> >
> > firmware today exports this attribute, why do you not want userspace to
> > also know it?

To clarify, the attribute exposed by the firmware today is
"ExternalFacingPort" and "external-facing" respectively:

617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
9cb30a71ac45d("PCI: OF: Support "external-facing" property")

The kernel flag was named "untrusted" though, hence the assumption
that "external=untrusted" is currently baked into the kernel today.
IMHO, using "external" would fix that (The assumption can thus be
contained in the IOMMU drivers) and at the same time allow more use of
this attribute.

> >
> > Trust is different, yes, don't get the two mixed up please.  That should
> > be a different sysfs attribute for obvious reasons.
>
> Yes, as a bottom line that's what I meant as well.

So what is the consensus here? I don't have a strong opinion - but it
seemed to me Greg is saying "external" and Andy is saying "untrusted"?

Thanks,
Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
