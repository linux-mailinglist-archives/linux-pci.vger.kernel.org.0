Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07B1FEE6B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFRJOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgFRJOy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 05:14:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E83C06174E;
        Thu, 18 Jun 2020 02:14:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so2204122ple.0;
        Thu, 18 Jun 2020 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8nLtniSUTwDDfd3xamrlaMHNc2J6LLLxRRAmrLugfc=;
        b=WUiFmMizj/e43QF9f4A66+T2uWZtKintH+n9ALWbkqK9xh+j7F8ZiQgw9pxlheUeGH
         t3Oi01AlXPbcpdZ0puHr4Khua7Rh8QX/l/Da8aBvz2upfYTo+WDUJYpUx6nvti10A9RY
         pPFrour+Wkan5hwTVsHSegYeG3TD1ki5Qcqy46mKt9GV25ybvb7aDLlMDYc59xXSfSph
         nje/NsQPFrHQp/aKc4YOKpgdQ2kn5OolMEBD3obDZvJeCKYMLfyVSeS0DUTaLDRh9l2J
         dvTzSlFKPYnuDUGIqjOTZlVjJXNth4e7FCH2uT2N7yUUzoYRlaY858tGJ2yCw8HNco+Q
         nuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8nLtniSUTwDDfd3xamrlaMHNc2J6LLLxRRAmrLugfc=;
        b=RtOiHKHC0QYs0wFMepD1tzEPK4AW4CotR6a48KsOi8uRGgpzcXMFrdYXNdAykMHxP+
         3ErctfdjKdM3W8KKDdgVa/XAIHBdgvSLXHetdyX/hGO+tptsCVYC4g0AQ2SZdmbEMMYk
         m6Wg/hi3h8AK9zLftEaYkdnlEnbb/PUZ7ihtKJZysgoEr3UjW0Gn6m1RYgDqXpjf1XRZ
         PucyZ28CzA63PpnwmwMkgLV3ah+nqM3bNFjp9D/KIGWxv029SSAi31YdkvC1fVSKoffp
         h6A69l21zIgMgmWTdKgiJzpGjpzU8vzpL5jHngUtVMKWZD28RpnZQxK4d8nRsUz1L2gl
         9v8g==
X-Gm-Message-State: AOAM5323r4e8V6RFiJpN0dgYQrx/f/wd67FA8lg2zO/lgGJDiAyLkgX7
        tU1UUGUtCvkDHcunkLy3/8u/MxYvm90lFNMd9hI23BjrK6Y=
X-Google-Smtp-Source: ABdhPJy19VeWbUl1qm2WmtP0kQGdDEXszOr6FW5/f3pi9L1oha0kncME731SjRkGY9uycpokgvt/SCosojgEDUDVq64=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr3418248pje.129.1592471693834;
 Thu, 18 Jun 2020 02:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org> <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org> <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com> <20200618083646.GA1066967@kroah.com>
In-Reply-To: <20200618083646.GA1066967@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Jun 2020 12:14:41 +0300
Message-ID: <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>,
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

On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > ...
> >
> > > (and likely call it "external" instead of "untrusted".
> >
> > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > chosen by the meaning of it.
> > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > tables, but I can replace it.
>
> Then your ACPI tables should show this, there is an attribute for it,
> right?

There is a _PLD() method, but it's for the USB devices (or optional
for others, I don't remember by heart). So, most of the ACPI tables,
alas, don't show this.

> > This is only one example. Or if firmware of some device is altered,
> > and it's internal (whatever it means) is it trusted or not?
>
> That is what people are using policy for today, if you object to this,
> please bring it up to those developers :)

> > So, please leave it as is (I mean name).
>
> firmware today exports this attribute, why do you not want userspace to
> also know it?
>
> Trust is different, yes, don't get the two mixed up please.  That should
> be a different sysfs attribute for obvious reasons.

Yes, as a bottom line that's what I meant as well.

-- 
With Best Regards,
Andy Shevchenko
