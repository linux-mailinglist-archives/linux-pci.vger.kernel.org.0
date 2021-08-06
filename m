Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B713E2E4B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhHFQYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 12:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhHFQYF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 12:24:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A633611C6;
        Fri,  6 Aug 2021 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628267029;
        bh=ty09/fANA+AaGrdFgiDJV6XUc9mA5WlqFGlxLtHeCkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nh1X7AYI2SpnDgYGEGdB308YJJC2wKemKrWUG/4GpawrksGQk/WWgEqQfsnkiIbPg
         ni2K6Ws3qYLGZqFR7ioShg1lQufUlkX9iN74koEamayIxMgEBJ2sqENQx0YvNUGhcB
         arkxFo/RTUWmbE2GZwHAVUH+zouylzowoHRJ6XjRtOWy403qzHIjihyyS7Slbq4xga
         HLZ5PaVzNdCceISnS5RN/TJ4+0gidvAqEkClXY4fcUFwC5T/X26Kj35D9lE0Q11+VH
         ahJ4aoGavzVWAOfOI9FecvaGbPNrz91ozlkvUZv8xe294IvxUcQZ/HIXWBM8kSBV18
         Svoc4ZvFn07bw==
Received: by mail-ej1-f50.google.com with SMTP id o5so15948577ejy.2;
        Fri, 06 Aug 2021 09:23:49 -0700 (PDT)
X-Gm-Message-State: AOAM532Ia08jOU2bvbGWXosaIT1FVWho7L/nXRmsF2PkGREQfX7HxnIp
        Zo9co0j5s2bczGVe6U3H8YJ4uZhocyx1lVxOMg==
X-Google-Smtp-Source: ABdhPJwuUx8QjZdGDDM7P5slP1wzk+qqeyMJSv+CHKKN77QK/ubEn42xQa4s0696lJ4xkH4ylKUBy7+/jIXhiQ/49jk=
X-Received: by 2002:a17:906:d287:: with SMTP id ay7mr10250474ejb.360.1628267027568;
 Fri, 06 Aug 2021 09:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
 <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
 <20210804085045.3dddbb9c@coco.lan> <YQrARd7wgYS1nywt@robh.at.kernel.org>
 <20210805094612.2bc2c78f@coco.lan> <20210805095848.464cf85c@coco.lan>
In-Reply-To: <20210805095848.464cf85c@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Aug 2021 10:23:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKso=z8LG3ViaggyS1k+1T2F5aAhP3_RNhumQoUUD+bbg@mail.gmail.com>
Message-ID: <CAL_JsqKso=z8LG3ViaggyS1k+1T2F5aAhP3_RNhumQoUUD+bbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to work
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 5, 2021 at 1:58 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Thu, 5 Aug 2021 09:46:12 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>
> > Em Wed, 4 Aug 2021 10:28:53 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >
> > > On Wed, Aug 04, 2021 at 08:50:45AM +0200, Mauro Carvalho Chehab wrote:
> > > > Em Tue, 3 Aug 2021 16:11:42 -0600
> > > > Rob Herring <robh+dt@kernel.org> escreveu:
> > > >
> > > > > On Mon, Aug 2, 2021 at 10:39 PM Mauro Carvalho Chehab
> > > > > <mchehab+huawei@kernel.org> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > That's the third version of the DT bindings for Kirin 970 PCIE and its
> > > > > > corresponding PHY.
> > > > > >
> > > > > > It is identical to v2, except by:
> > > > > >         -          pcie@7,0 { // Lane 7: Ethernet
> > > > > >         +          pcie@7,0 { // Lane 6: Ethernet
> > > > >
> > > > > Can you check whether you have DT node links in sysfs for the PCI
> > > > > devices? If you don't, then something is wrong still in the topology
> > > > > or the PCI core is failing to set the DT node pointer in struct
> > > > > device. Though you don't rely on that currently, we want the topology
> > > > > to match. It's possible this never worked on arm/arm64 as mainly
> > > > > powerpc relied on this.
> > > > >
> > > > > I'd like some way to validate the DT matches the PCI topology. We
> > > > > could have a tool that generates the DT structure based on the PCI
> > > > > topology.
> > > >
> > > > The of_node node link is on those places:
> > > >
> > > >   $ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> > > >   /sys/devices/platform/soc/f4000000.pcie/of_node
> > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node
> > >
> > > Looks like we're missing some...
> > >
> > > It's not immediately obvious to me what's wrong here. Only the root
> > > bus is getting it's DT node set. The relevant code is pci_scan_device(),
> > > pci_set_of_node() and pci_set_bus_of_node(). Give me a few days to try
> > > to reproduce and debug it.
> >
> > I added a printk on both pci_set_*of_node() functions:
> >
> >       [    4.872991]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> >       [    4.913806]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000
> >       [    4.978102] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> >       [    4.990622]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> >       [    5.052383] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)
> >       [    5.059263]  (null): pci_set_of_node: of_node: (null)
> >       [    5.085552]  (null): pci_set_of_node: of_node: (null)
> >       [    5.112073]  (null): pci_set_of_node: of_node: (null)
> >       [    5.138320]  (null): pci_set_of_node: of_node: (null)
> >       [    5.164673]  (null): pci_set_of_node: of_node: (null)
> >       [    5.233759] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
> >       [    5.240539]  (null): pci_set_of_node: of_node: (null)
> >       [    5.310545] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
> >       [    5.324719] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
> >       [    5.338914] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
> >       [    5.345516]  (null): pci_set_of_node: of_node: (null)
> >       [    5.415795] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)
>
> The enclosed patch makes the above a clearer:
>
>         [    4.800975]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
>         [    4.855983] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
>         [    4.879169] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
>         [    4.900602] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
>         [    4.953086] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)

I believe the issue is we need another bridge node in the DT
hierarchy. What we have is:

Bus 0 is node /soc/pcie@f4000000
Bus 1 is device 0 on bus 0 is node /soc/pcie@f4000000/pcie@0,0
Bus 2 is device 0 on bus 1 in node ... whoops, there's no device 0
under /soc/pcie@f4000000/pcie@0,0

So we need the hierarchy to be: /soc/pcie@f4000000/pcie@0/pcie@0/pcie@{1,5,7}

Rob
