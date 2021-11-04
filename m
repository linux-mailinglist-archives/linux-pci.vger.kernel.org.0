Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED344566E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKDPkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 11:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhKDPkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 11:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF9AA610FD;
        Thu,  4 Nov 2021 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636040245;
        bh=gOnpVuCJ6ZQWNS7FGa/CA1COrnFPwRd/hzU3ApMGZyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JZwFZOKmpNfhURWYZ4TQdgYUb+VQKyjRAKQmYJYhjgOe1biuhJ4YLmQ9jE6lQUsOW
         Fv9iEEfPInWsDuj6jYkOp1A2stbcC5GuuuMae3DieEIpC6tYkqFCt1+GUhhsomtGG4
         fkLCdUCJHYaDztHlv68bYm/JOiRe6wbe89TUX6KcpbwfvkIetYvYdj4qN3t4kXtrpj
         n58v41z4fhUThtl9Nl5F5H43rn9ZI2PovwnRhAjt3A27mENqynIBpCLx1oWLxdmaxJ
         UMGakn1aEWrcQrGqSA3vp0LsHXYL++M6NuXX0lNOdc/IEnYKBsvDnWCPK9/3tu2TQO
         6BrP5zWoLPHUA==
Received: by mail-ed1-f43.google.com with SMTP id o8so22795655edc.3;
        Thu, 04 Nov 2021 08:37:25 -0700 (PDT)
X-Gm-Message-State: AOAM531grwlA1v7EHkS6YluWLYzSICS/8w6ahbEN4EkaEFQWVSy4MIDD
        GCNcJVA1kztdlmVupRD0f/oaSdlYxMh3XBxe/A==
X-Google-Smtp-Source: ABdhPJzgf+kAjIm4iDIzrlnqYvjyg99MANJ0xmpgK/fg5fhwkRo5H2UD85PYjaLzFTaaJMbnd6k6RMV6adieRkIxfrM=
X-Received: by 2002:a50:da06:: with SMTP id z6mr70205630edj.355.1636040224963;
 Thu, 04 Nov 2021 08:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <bb391a0e0f0863b66e645048315fab1a4f63f277.1634812676.git.mchehab+huawei@kernel.org>
 <20211102160612.GA612467@bhelgaas> <20211102174415.58cd3d4f@sal.lan>
In-Reply-To: <20211102174415.58cd3d4f@sal.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Nov 2021 10:36:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+qyf=2dSgaVKGPccNGNYXbeyKMDC_yB=G8wg0_4_06Gw@mail.gmail.com>
Message-ID: <CAL_Jsq+qyf=2dSgaVKGPccNGNYXbeyKMDC_yB=G8wg0_4_06Gw@mail.gmail.com>
Subject: Re: [PATCH v15 04/13] PCI: kirin: Add support for bridge slot DT schema
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 2, 2021 at 12:44 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Bjorn,
>
> Em Tue, 2 Nov 2021 11:06:12 -0500
> Bjorn Helgaas <helgaas@kernel.org> escreveu:
>
> > > +
> > > +   /* Per-slot clkreq */
> > > +   int             n_gpio_clkreq;
> > > +   int             gpio_id_clkreq[MAX_PCI_SLOTS];
> > > +   const char      *clkreq_names[MAX_PCI_SLOTS];
> >
> > I think there's been previous discussion about this, but I didn't
> > follow it, so I'm just double-checking that this is what we want here.
> >
> > IIUC, this (MAX_PCI_SLOTS, "hisilicon,clken-gpios") applies to an
> > external PEX 8606 bridge, which seems a little strange to be
> > hard-coded into the kirin driver this way.
> >
> > I see that "hisilicon,clken-gpios" is optional, but what if some
> > platform connects all 6 lanes?  What if there's a different bridge
> > altogether?

Keep in mind this is HiKey. There's never been a 2nd board upstream
for the SoCs, the boards have a short lifespan in terms of both
support and availability. And yet Hikey manages to do multiple
complicated things on the board design. I have a hard time caring...

> >
> > I'll assume this is actually the way we want thing unless I hear
> > otherwise.
>
> Yes, there was past discussions about that with Rob, with regards
> to how the DT would represent it, which got reflected at the code.

At first I thought these were CLKREQ connections which absolutely
should be per port/bridge like PERST, but they are not. They are
simply enables for the refclk's and pretty specific to HiKey.

> At the end, it was decided to just add a single property inside PCIe:
>
>
>                 pcie@f4000000 {
>                         compatible = "hisilicon,kirin970-pcie";
> ...
>                         hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>,
>                                                 <&gpio20 6 0>;
>
> I don't think this is a problem, as, if some day another bridge would
> need a larger number of slots, it is just a matter of changing the
> number at the MAX_PCI_SLOTS, as this controls only the size of the array
> (and the check for array overflow when parsing the properties).

It is a problem that your host bridge driver has hardcoded board
specifics. That's not the first time you've heard that from me. But
given the board-to-soc ratio of Hikey is 1:1, I don't care that much.

Rob
