Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D203D3ACD84
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhFROcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 10:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232052AbhFROcl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 10:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E13F861248;
        Fri, 18 Jun 2021 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624026631;
        bh=Z55SLbU8ZD5nUDrh8T99iwxmj76HXBy5zPcLuyKUE+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RnrkiZpe9q8B2Cg+xjqgeayELOfe8JGeBbnl2PONMDfxp9XwIAbvo775WBxcxHj9z
         fdtB6Mo6csKLCexqWsaHgnLkhyuP/SGlOAxUdRkGyYRWJ2KbJUEMhLgGZaxhw9Z+Tx
         L9ReImrcqoTfHIwXsXmZgVdfVNQdrL/LCA2mqoMW0bzpP4Rt0xnFBVmFg6f9j/mQY/
         6mS1QUzvQtJvu6fMXVhTuy1im2USzuuQUTzlGtkZy3J7k/YWt1fnLOZuvt4Ftq9GPD
         Fk3a0nRu1MSSHckSYLkTr/rJUfLK10u6YFfHKWpXmTovY5AUOJhAPTEnBxI+qu2pXa
         hKz9rD3josUbQ==
Received: by mail-ed1-f52.google.com with SMTP id s15so8893834edt.13;
        Fri, 18 Jun 2021 07:30:31 -0700 (PDT)
X-Gm-Message-State: AOAM5337JZyqub5K3EyXOy5Ul4AJ9ixB3WYfLh0Xs5O0PMS0WgleLlSj
        8enfgE8xWmBroTWRI0POZHgGJ8A+OxD9I7MRbw==
X-Google-Smtp-Source: ABdhPJxL9CaQPuY06jCjKdQITDNtB6+/Tex0AkJknZjnOdcaEnznF5fo8kfUkN0Y3H/xw1kcmv3KZ4ICsSup5WIpZBM=
X-Received: by 2002:aa7:cac9:: with SMTP id l9mr5255201edt.373.1624026630436;
 Fri, 18 Jun 2021 07:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210618063821.1383357-1-art@khadas.com> <CAFBinCB6bHy6Han0+oUcuGfccv1Rh_P0Gows1ezWdV4eA267tg@mail.gmail.com>
In-Reply-To: <CAFBinCB6bHy6Han0+oUcuGfccv1Rh_P0Gows1ezWdV4eA267tg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Jun 2021 08:30:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+zjf2r_Q9gE8JwJw+Emn+JB4wOyH7eQct=kBvpUKstw@mail.gmail.com>
Message-ID: <CAL_JsqK+zjf2r_Q9gE8JwJw+Emn+JB4wOyH7eQct=kBvpUKstw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: meson add quirk
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        art@khadas.com, Nick Xie <nick@khadas.com>, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 6:12 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Artem,
>
> On Fri, Jun 18, 2021 at 8:38 AM Artem Lapkin <email2tema@gmail.com> wrote:
> >
> > Device set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> > was find some issue with HDMI scrambled picture and nvme devices
> > at intensive writing...
> >
> > [    4.798971] nvme 0000:01:00.0: fix MRRS from 512 to 256
> >
> > This quirk setup same MRRS if we try solve this problem with
> > pci=pcie_bus_perf kernel command line param
> thank you for investigating this issue and for providing a fix!
>
> [...]
> > +static void meson_pcie_quirk(struct pci_dev *dev)
> > +{
> > +       int mrrs;
> > +
> > +       /* no need quirk */
> > +       if (pcie_bus_config != PCIE_BUS_DEFAULT)
> > +               return;
> > +
> > +       /* no need for root bus */
> > +       if (pci_is_root_bus(dev->bus))
> > +               return;
> > +
> > +       mrrs = pcie_get_readrq(dev);
> > +
> > +       /*
> > +        * set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> > +        * was find some issue with HDMI scrambled picture and nvme devices
> > +        * at intensive writing...
> > +        */
> > +
> > +       if (mrrs != MAX_READ_REQ_SIZE) {
> > +               dev_info(&dev->dev, "fix MRRS from %d to %d\n", mrrs, MAX_READ_REQ_SIZE);
> > +               pcie_set_readrq(dev, MAX_READ_REQ_SIZE);
> > +       }
> > +}
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_pcie_quirk);

Isn't this going to run for everyone if meson driver happens to be enabled?

> it seems that other PCIe controllers need something similar. in
> particular I found pci-keystone [0] and pci-loongson [1]
> while comparing your code with the two existing implementations two
> things came to my mind:
> 1. your implementation slightly differs from the two existing ones as
> it's not walking through the parent PCI busses (I think this would be
> relevant if there's another bridge between the host bridge and the
> actual device)
> 2. (this is a question towards the PCI maintainers) does it make sense
> to have this MRRS quirk re-usable somewhere?

Yes. Ideally, the max size could just be data in the bus or bridge
struct and perhaps some flags too, then the core can handle
everything.

Rob
