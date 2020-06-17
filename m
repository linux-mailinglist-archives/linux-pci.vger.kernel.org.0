Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7573B1FD597
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFQTxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQTxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 15:53:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6CC0613ED
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 12:53:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d7so2048886lfi.12
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=652Df2r0/DgKireW06s96KgNYOn5wGhQAsXaGuNmXIU=;
        b=u3Wa8m8AA+KUbrW2ZJpwKkh5OV+uw6/tbYieNTCpV+g/fKZMa/424dnXDq9k1pZPsC
         R3FzepNEt9eHmKEZLsQB6039RHnI2oLz4CeV+LIiyjsGAuVvKHjPqJBF3Os+Yu3DAD8h
         eayE3aq6KDW1uRolK2PO0BBU19aNm/+f0ZClqWN+6CBGWa1oZWt3Q1ccsHsxPC9fP8Fo
         fRbkAnztmRQIhCW37CvRuaE6qD0vU9+o9o/RIpz49UZIQk8W128R+KBu/KuSbu6ST/8e
         pUQ0WdEBLZ+YsiIPD892IivctXxTZsc2P7241Yy2nkAjGpLCkDQM5X2GbJvBqr2rZVAY
         UQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=652Df2r0/DgKireW06s96KgNYOn5wGhQAsXaGuNmXIU=;
        b=MW0ivZHI7J8xPG7LqL7eylP66mqqHFiI7/EdFgRi7eq5xh0IsjBYGGw6s1VzZtLYw4
         RGfGaVwG7chhyvVgFSzyzzRWfR7QVsfXGiYuljtOBy79soSGluSs+Vjrmu2R22Es/Nel
         WegVzRjkT+g7aNaGtrGX4rXJebr86CZmHbZRzW4YgeQF043s5yBFQm/m+hN/sCgVZ/n6
         foheISKxsDC0UNUENBIYod003bDaAapU8fQhLmuoAJQ8mYPF0mdvwX4MYW7+y2rG7RBg
         u30506ptzphF0o1s3yJuptZ1RCOTCmbwfCRK4xxlUeIHJmRCJOZ9bvGP9G3rZr406rVC
         2orw==
X-Gm-Message-State: AOAM530EUu2jrNRs9/9pI/Wczy1SWhO88nnhNFjOC6DcpCzVgt4+l4gz
        u5+olv8Z2NSNfdLrVm6BHzWdtSstSsL0ZCtYbveBTA==
X-Google-Smtp-Source: ABdhPJyNvJoaAN28/Zg/o9OICE/84/JjfeagXh8bzJTkYAwiivCGPGUzVM1fri9Qg8kksG9nggUrDgCqrfFwoV4dkhw=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr299095lfi.204.1592423622439;
 Wed, 17 Jun 2020 12:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org> <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
In-Reply-To: <20200617073100.GA14424@infradead.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 17 Jun 2020 12:53:03 -0700
Message-ID: <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
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

Hi Greg, Christoph,

On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 16, 2020 at 12:27:35PM -0700, Rajat Jain wrote:
> > Need clarification. The flag "untrusted" is currently a part of
> > pci_dev struct, and is populated within the PCI subsystem.
>
> Yes, and that is the problem.
>
> >
> > 1) Is your suggestion to move this flag as well as the attribute to
> > device core (in "struct device")? This would allow other buses to
> > populate/use this flag if they want. By default it'll be set to 0 for
> > all devices (PCI subsystem will populate it based on platform info,
> > like it does today).
> >
> > OR
> >
> > 2) Are you suggesting to keep the "untrusted" flag within PCI, but
> > attach the sysfs attribute to the base device? (&pci_dev->dev)?
>
> (1).  As for IOMMUs and userspace policy it really should not matter
> what bus a device is on if it is external and not trustworthy.

Sure. I can move the flag to the "struct device" (and likely call
it "external" instead of "untrusted" so as to make it suitable for
more use cases later).  The buses can fill this up if they know which
devices are external and which ones are not (otherwise it will be 0 by
default). The PCI can fill this up like it does today, from platform
info (ACPI / Device tree). Greg, how does this sound?

Thanks,

Rajat
