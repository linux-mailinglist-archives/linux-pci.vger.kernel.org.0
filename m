Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B3A1FED45
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgFRINL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgFRINK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 04:13:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2D7C06174E;
        Thu, 18 Jun 2020 01:13:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s135so2586092pgs.2;
        Thu, 18 Jun 2020 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ene5uMUm+upAXA9BJzuffmYO6Vv0lNnhNcaEqAS2hRI=;
        b=oMlIb0FoGBOJsgrNjpyA6usrw+ThWjyOMCmvPw99IwyYIB9ip/U9QzQHM7FRRCUyVa
         k34zw3yY6VYyswqz9FW7UYIj/4DmuvGwkZ6M2Sty2biD7jPkTJa1jEwgALUm1GfCim3D
         XKrA7g31mdNnR/gZy1pgwqzhrqnfzJ41FhSygGWHtmdBqIp5FvDh+5lrCQhdsYgSozBR
         4P63nnZI4qWxo2ZZh1o3UxJluffSonG0U0VdlUfB6sgRVIWElBaQjWnyc8szcFsPdHk/
         cLslW6W/v55tZ6UkbptbmR4NGzT9n6kIjKALMasirBmP2nutJjYj7WeTdQlj/mW9chfC
         yKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ene5uMUm+upAXA9BJzuffmYO6Vv0lNnhNcaEqAS2hRI=;
        b=JlHQa+4IdAH6T22zyOQW1GqdPIspzcnQaMWAquq3UA4taKkSolJj9c2YFrqj+X3IfC
         G1HGDK/eqKMSFvroPOb4gkmfja2wm2BOIKs19L3M2Z9gBWHrw044CjHRMTkNddW9xSNf
         NuuUoV3zsmwNfYZ91Wt5m0yDn8p32sPp5G4ftZECvbLyCsksdgQoQaP+wPcBb3UX2HjF
         oGq0CxpfBEBYUdvcqVPyJj1d4T2TeQznjaJLnGMrdwebXCXh/cmXzPVhyg64Cw+SGcb5
         RXHi6qBE/jsBXOZ30mAkK13hC7Hsb2/50PFdXoojPC04Z78z2eLZCv/rSUcfag1iTOXj
         h2dA==
X-Gm-Message-State: AOAM533Yu+1WggqxiOeVXSiehu/iGccvLb+NjsfvEqZ8Imr3YyuWFWhw
        AE+jGpGtoaBo7Q0LY8k1BWoOUUCahKlbn+LyBOw=
X-Google-Smtp-Source: ABdhPJzn2cN3ofWkUgWLzA5Vs/OEjLvfC75aOifXK9Wv9zVyHGJzQXPmA/pTNu8thNBvmrN+azQmzx37a2Glr4j49IE=
X-Received: by 2002:a62:1c46:: with SMTP id c67mr2533442pfc.170.1592467988587;
 Thu, 18 Jun 2020 01:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org> <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org> <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
In-Reply-To: <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Jun 2020 11:12:56 +0300
Message-ID: <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     Rajat Jain <rajatja@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:

...

> (and likely call it "external" instead of "untrusted".

Which is not okay. 'External' to what? 'untrusted' has been carefully
chosen by the meaning of it.
What external does mean for M.2. WWAN card in my laptop? It's in ACPI
tables, but I can replace it.
This is only one example. Or if firmware of some device is altered,
and it's internal (whatever it means) is it trusted or not?

So, please leave it as is (I mean name).

-- 
With Best Regards,
Andy Shevchenko
