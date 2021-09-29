Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65B41C57E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 15:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbhI2N0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 09:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242801AbhI2N0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 09:26:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F78861407;
        Wed, 29 Sep 2021 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632921866;
        bh=GLt7VhAYc3+Bn7horZOtUw2Z07v1yUgEk1KG/o2u/SI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pj4/sQqa/LQxfTtZWbZu55CJBbFO7vLy1gx7I3r3W5KRNY3naMRp23xoTDTe6ElXA
         ISCWmiPeFyG493Garv3lou+laNSAIVW0nxw2doPD47spv/mCpgXyLcUMBKrHAW6VqH
         9QnsWxjizrYqCDgQCh6UFuChYoNVoKjjYCc0abe5V2xENBZ6ZFTCg/uE6c8V/zdUR0
         5P23yKlnD8HwItgZqaXWAV2JmmMmRu5Mb0hKx1g8TdcCgZlYVGF2K8ccncJIU0Qa04
         TjfxFr3Jr6uNCfZwA90lKhbrOhiUf1apQufovMQYbceIqbIuSjp5UwYwJHkylzrPjr
         p09pjTNWruWYg==
Received: by mail-ed1-f54.google.com with SMTP id dn26so8574046edb.13;
        Wed, 29 Sep 2021 06:24:26 -0700 (PDT)
X-Gm-Message-State: AOAM530EUKe7bv5YeZN2nXgcLx4wZpUfcr1WfTu3E1oZTLyMxDBA0kF4
        NUKZfmcd/13Q4k/RT3nGG7hcMJYqE566biiwRA==
X-Google-Smtp-Source: ABdhPJwq2f2qqfxXyFWkrWV3iifrJPv7KPWiqgVnZABgA1XBRfQrTxVeJvSAOJe1XySYmstxhXFKpr+rq0wzORzGlmI=
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr13411369ejk.466.1632921849241;
 Wed, 29 Sep 2021 06:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210927103321.v4kod7xfiv5sreet@lony.xyz> <20210927153128.GA646260@bhelgaas>
In-Reply-To: <20210927153128.GA646260@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Sep 2021 08:23:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLjpe94EGx2fmVmcoXniRMnQ16+RKcYATub4cm0TPF0gw@mail.gmail.com>
Message-ID: <CAL_JsqLjpe94EGx2fmVmcoXniRMnQ16+RKcYATub4cm0TPF0gw@mail.gmail.com>
Subject: Re: About the "__refdata" tag in pci-keystone.c
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Sergio M. Iglesias" <sergio@lony.xyz>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 27, 2021 at 10:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 27, 2021 at 12:33:21PM +0200, Sergio M. Iglesias wrote:
> > Hello!
> >
> > I have checked the "__refdata" tag that appears in the file
> > "drivers/pci/controller/dwc/pci-keystone.c" and it is needed. The tag has
> > been there since the creation of the file on commit 6e0832fa432e and
> > nothing has changed since that would make it redundant.
> >
> > The reason it is needed is because the struct references "ks_pcie_probe",
> > which is a function tagged as "__init", so the compiler will most likely
> > complain about the "__refdata" being removed.
> >
> > Should I send a patch to add a comment explaining why it is a necessary
> > tag as recommended in "include/linux/init.h"?
> > > [...] so optimally document why the __ref is needed and why it's OK).
>
> Thanks a lot for looking into this.
>
> I'm not yet convinced that either the __init or the __refdata is
> necessary.  If there is a reason, it would not be "to silence a
> compiler complaint"; it would be something like "the keystone platform
> is different from all the other platforms because the other platforms
> support X but keystone does not."
>
> Also, there are a couple other .probe() functions that are marked
> __init:
>
>   $ git grep "static int .*_pci.*_probe" drivers/pci | grep __init
>   drivers/pci/controller/dwc/pci-keystone.c:static int __init ks_pcie_probe(struct platform_device *pdev)
>   drivers/pci/controller/dwc/pci-layerscape-ep.c:static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>   drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c:static int __init ls_pcie_g4_probe(struct platform_device *pdev)
>   drivers/pci/controller/pci-ixp4xx.c:static int __init ixp4xx_pci_probe(struct platform_device *pdev)
>
> and their platform_driver structs are not marked __refdata:
>
>   $ git grep "static struct platform_driver" drivers/pci | grep __refdata
>   drivers/pci/controller/dwc/pci-keystone.c:static struct platform_driver ks_pcie_driver __refdata = {
>
> I think this should all be more consistent: either all these __init
> and __refdata annotations should be removed, or they should be used by
> many more drivers.

__init should definitely be removed. There's no guarantee that probe
completes before init memory is freed even for built-in drivers.

Rob
