Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6565A1FF70C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFRPjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgFRPji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 11:39:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF9CC06174E;
        Thu, 18 Jun 2020 08:39:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so2587786plr.4;
        Thu, 18 Jun 2020 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZJ6zrh+Y1Vsbn8ruHOrvITbkoXuvzfrfxu58pe7Zzk=;
        b=nOpCbbD6xUCyUz1YyRFpYFHK9LWD7cjvIZxDiH+RHDIqnZOql6/HyXntIMdZRBmh6W
         qpWKCdPmcmhXmDldMKpyNVRtvcF65untSTh7b5p1WI9usEorDqyqWi+2CMlzv8bzHvnL
         dqwHRgzMvBKGZNXW3AWDlFOGQE2zB0mmd0nG8fJ7sq2Mbb/5W1+6ARarXpTXZ/T5Z7Fh
         NNczurvr+OGHWixUQ43EDkmzuyUQu7NgUxXcjGQunTlZxsMEkwffmiWHpAJiBmVQMQ+O
         PL8u/pNkmfjNg6/x1GGhte/FJXNgJRRoFUgl+zVauVs2zGcOpfx5XpLN7dEWqdjkSM8K
         B3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZJ6zrh+Y1Vsbn8ruHOrvITbkoXuvzfrfxu58pe7Zzk=;
        b=p17BIvnREAJDft6OnMGhhl5yA7MAuAjLZZCv6agajTzQq2ZSdsqn3WCRPlG6DZAaXS
         r8353+3fuCPFLV0oRdXrHzcdvCooJEtKFKDJb5Q9r8AZEZ18tbWnnQhpUBL1MOtuqxTe
         c4c6qn9f8pi0Au98ngPNZjFqwbYqJ0aDza2RTk6rH5sEiYS7k9hGsy9wrzRM5ovzM/w2
         VCypvOQhpxeVo114Pqw/gfMOJ3SaK60v6nN/XADbkXIm2PoUMONPjbjYqblVp4WW7d0q
         mdCRZ6EbvBgSCOkes4nX/28EA5dCs3Q4K/cmyeW06wI9+Z6pk0woTecteDm0sl3YweFS
         kzvw==
X-Gm-Message-State: AOAM533YO6q0ZDC1Vn/hboYnWQm/z/gFHV0GNzzYR7PQQAA+Zt41w9JJ
        eSmjv/QHOrP3jjkNb2CpbbRdMsOzeS51pIeD/bQ=
X-Google-Smtp-Source: ABdhPJxoaHYDZlEj8QJ3QkP/ek5K5pisD5wHKUkE1aXeH10OjnRC6dr0cGbGHcW/Er3YFyoGris7X1yJzT3Uyu0wy+o=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr5004682pjq.228.1592494778159;
 Thu, 18 Jun 2020 08:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org> <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org> <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com> <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
 <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
In-Reply-To: <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Jun 2020 18:39:25 +0300
Message-ID: <CAHp75Vf_gheXBZh-Mm7ME_eVWc5gPcwY98oCH1-QD920mK7gZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     Rajat Jain <rajatja@google.com>
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

On Thu, Jun 18, 2020 at 6:04 PM Rajat Jain <rajatja@google.com> wrote:
> On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> To clarify, the attribute exposed by the firmware today is
> "ExternalFacingPort" and "external-facing" respectively:
>
> 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> 9cb30a71ac45d("PCI: OF: Support "external-facing" property")
>
> The kernel flag was named "untrusted" though, hence the assumption
> that "external=untrusted" is currently baked into the kernel today.
> IMHO, using "external" would fix that (The assumption can thus be
> contained in the IOMMU drivers) and at the same time allow more use of
> this attribute.

That discussion had been held, IIRC, during introduction of the
untrusted member in struct pci_dev...

> > > Trust is different, yes, don't get the two mixed up please.  That should
> > > be a different sysfs attribute for obvious reasons.
> >
> > Yes, as a bottom line that's what I meant as well.
>
> So what is the consensus here? I don't have a strong opinion - but it
> seemed to me Greg is saying "external" and Andy is saying "untrusted"?

...and a conclusion has been made as you may see. So, I would highly
recommend to speak to the author(s) of the patch that introduced /
adopted 'untrusted' member.

-- 
With Best Regards,
Andy Shevchenko
