Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C655444EED2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 22:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhKLVts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 16:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhKLVtr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 16:49:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D24D61073;
        Fri, 12 Nov 2021 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636753616;
        bh=MWc2jsxYe1597deB9/lwgCuOii0kKitFDvDvQtQbw84=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h1nUnBWqcNX9zFj8jIcKElqsmNLYZjSnxzWJv1o0BjeEi9IWlLyVv6SKagMskjMMP
         8D4V8a5eeA/hERUz/hqQNhrWxFQrCvGAGAPHzywbam9TPIXl5dPOjtMsik+yO3abVI
         f1MYXb3V3D/K3ytcb3IEd+yyVounGnpJZTl1TbKXb0x3NvQOVp6eOkvnzPkQxLjvnS
         rwfYXiuJDzTE6lbUZWrhZFdb92MSYU4olpyKqOI3+AcPXf1arU8/xsisWsL1lvt69J
         v7Wza+oqqePP7Jk9mCe0iXRBMTuZtVTEjk1fmJYS7tr1vdNlOM/ETrZhdCFzuarAVl
         vovvZQSn17lNA==
Received: by mail-ed1-f43.google.com with SMTP id x15so43123808edv.1;
        Fri, 12 Nov 2021 13:46:56 -0800 (PST)
X-Gm-Message-State: AOAM533snG5FawFe2bPfdanxLI8uO1UamGPm78nfQh4ziJ6mAX2mGppn
        TABZKEKE5D7jF5aBO8J1snK3i6D1Ob7w2Qagpg==
X-Google-Smtp-Source: ABdhPJz2sj87J9vsUh6n5hpj2yVJsnrONJYB2w5h4ZSZ55MSqVKR22BptNf8vVI7snv/2CopLAoeMaTCrMtL3IfAGRI=
X-Received: by 2002:aa7:d997:: with SMTP id u23mr17964290eds.164.1636753614437;
 Fri, 12 Nov 2021 13:46:54 -0800 (PST)
MIME-Version: 1.0
References: <CANCKTBun0MCiH5QWBMQqP+pxAN=+dX=ziB1ga39kdr5CmK=Gfw@mail.gmail.com>
 <20211112202051.GA1414166@bhelgaas>
In-Reply-To: <20211112202051.GA1414166@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Nov 2021 15:46:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhpmrmw=z=3JCVgBTJr531eqMhACht_j16Czv6Q+CQLA@mail.gmail.com>
Message-ID: <CAL_JsqLhpmrmw=z=3JCVgBTJr531eqMhACht_j16Czv6Q+CQLA@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 2:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 12, 2021 at 01:25:11PM -0500, Jim Quinlan wrote:
> > On Thu, Nov 11, 2021 at 5:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Nov 10, 2021 at 05:14:43PM -0500, Jim Quinlan wrote:
> > > > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > > > allows optional regulators to be attached and controlled by the PCIe RC
> > > > driver.  That being said, this driver searches in the DT subnode (the EP
> > > > node, eg pci-ep@0,0) for the regulator property.
> > > >
> > > > The use of a regulator property in the pcie EP subnode such as
> > > > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > > > file at
> > > >
> > > > https://github.com/devicetree-org/dt-schema/pull/63
> > >
> > > Can you use a lore URL here?  github.com is sort of outside the Linux
> > > ecosystem and this link is more likely to remain useful if it's to
> > > something in kernel.org.
> > Hi Bjorn,
> > I'm afraid I don't know how or if  this github repo transfers
> > information to Linux.  RobH, what should I be doing here?
>
> Does this change get posted to any mailing lists where people can
> review it?

devicetree-spec is where I direct folks to. It's not in lore, but we
could add it I guess. But I take PRs too. There's so few other
contributions I'm looking to make it as painless as possible for
contributors. I'd be happy for more reviewers other than me, but I
don't think where changes are posted is the problem there. :( Someone
should review all the crap Python code I write too.

Generally the flow is I redirect things submitted to the kernel to
dtschema instead. So that review happens first at least.

> Or would people have to watch the github devicetree-org
> repo if they wanted to do that?  I was assuming this pci-bus.yaml
> change was something that would eventually end up in the Linux kernel
> source tree, but dt-scheme doesn't seem to be based on Linus' tree, so
> I don't know if there's a connection.

It's more the other way around. The 'rule' is common bindings go in
dtschema and device specific bindings in the kernel tree. Reality is
some common bindings are in the kernel tree primarily because I want
everything in dtschema dual licensed and relicensing is a pain. That's
why we have pci.txt and pci-bus.yaml still.

Rob
