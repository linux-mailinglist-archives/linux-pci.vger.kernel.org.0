Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410443C59EB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbhGLJQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 05:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386665AbhGLJP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 05:15:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F6FC061797;
        Mon, 12 Jul 2021 02:08:37 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h190so21705691iof.12;
        Mon, 12 Jul 2021 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U59PeowZNhh2OhvXIbjaI4juvWI/pRnlYgNB+mwdJpo=;
        b=L0xh0mEflI8DgLY9QTqU19xTsXqqizSWvkI/4omJpoe8x7otTPRVRVmo5XiOPskuZW
         S+2sh37QGlqJMFFsca7HTyNXgxBfSetWS5gJ0kcl5nwD3qPSQsmd1CbCuJdfXccS7izq
         o3iGM/Fm8JYvgjvR5eG60NVtkxObrmzxVZNNT9H0/g8wf1Gy5nM3BKEgHHtMahTWmhwf
         a+BfeuziEPQX8uwHXlx2A5BUZ4GhfNCOb1ifDkSNYppve1jA3QQLcHywmzkWRO1eS90I
         3Ycaj2NGgInrD+Jb75x1iEPXYo+9Ml/VZQ819z/N1MjkMZlpouA9qPqglrIzKM3ckOqo
         YyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U59PeowZNhh2OhvXIbjaI4juvWI/pRnlYgNB+mwdJpo=;
        b=RObWrlOoPKHVZUgA3h6pDYGbaaApi8bDuXjekojc86qUoFlALE1GD5VcUhF4IQM8VB
         I6M+/vU2TL/Mz6jcAcfIs7Qop1zsdC+dD4upTiNHlO4KWH1fwkgSbqirY+51zVSvNpQw
         BxvKz3V6I6ZN6S2E/vsAyf7xgyKzOzhkrg7dP6QOq6YIYaB84Di/jltQG3yHH78xM5pT
         toOHOqo/jPQgpnFbBtQwzN2eia2h0sw9Vxin6pOP3lKOfiIYXhCWWXJhUD9yIq6OEZ7k
         F93+mZzhzyKjmGeELGMl2WvH47IJutS6fKG+zidCXifSjhT6WnmpmadhSuNoiwJkYxBd
         6LeQ==
X-Gm-Message-State: AOAM533UacWzCoOwVoJcICweDJafqWjJtdDH+e0UReQg3e6XG7beJVUv
        ensQrIipBEqetkc4tzNuGRtce92B1Ze3wSovCWk=
X-Google-Smtp-Source: ABdhPJwn9EhcfVBqG/Ji30rbZu4T7eDBpsXWxSwTi6MejqeaTdxa04bjHMwNsghwzPByOpCek548LLiiOJGLHelDhjs=
X-Received: by 2002:a02:c806:: with SMTP id p6mr30443857jao.19.1626080915112;
 Mon, 12 Jul 2021 02:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <aab7db4a-df1f-280b-73d7-799161528fa2@baylibre.com> <20210707165735.GA905464@bjorn-Precision-5520>
In-Reply-To: <20210707165735.GA905464@bjorn-Precision-5520>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Mon, 12 Jul 2021 17:08:23 +0800
Message-ID: <CAKaHn9L4wLeVrFC7M05zr4enexU9_g=0y4dAbwu6BS+FBVicSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> The PCI core is the correct place to handle MPS/MRRS because their> behavior is defined by the PCIe spec.
>Quirks are the way to work around this defect in the Synopsys PCIe IP.

> don't want it to make
> maintenance of the generic MPS/MRRS code harder.

Trying summarize ( every one must use separate quirk )

which file is right place for for meson_mrrs_limit_quirk()

- pci/controller/dwc/pci-meson.c or
- pci/quirks.c

rewrited quirk just for meson:

static void meson_mrrs_limit_quirk(struct pci_dev *dev)
{
    struct pci_bus *bus = dev->bus;
    int mrrs, mrrs_limit = 256;
    static const struct pci_device_id bridge_devids[] = {
        { PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },
        { 0, },
    };

    /* look for the matching bridge */
    while (!pci_is_root_bus(bus)) {
        /*
         * 256 bytes maximum read request size. They can't handle
         * anything larger than this. So force this limit on
         * any devices attached under these ports.
         */
        if (!pci_match_id(bridge_devids, bus->self)){
            bus = bus->parent;
            continue;
        }
        mrrs = pcie_get_readrq(dev);
        if (mrrs > mrrs_limit) {
            pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
            pcie_set_readrq(dev, mrrs_limit);
        }
        break;
    }
}
DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_mrrs_limit_quirk);


On Thu, Jul 8, 2021 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jul 07, 2021 at 06:43:13PM +0200, Neil Armstrong wrote:
> > On 07/07/2021 17:54, Bjorn Helgaas wrote:
> > > On Tue, Jul 06, 2021 at 11:54:05AM +0200, Neil Armstrong wrote:
> > >> In their Designware PCIe controller driver, amlogic sets the
> > >> Max_Payload_Size & Max_Read_Request_Size to 256:
> > >> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L260
> > >> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L276
> > >> in their root port PCIe Express Device Control Register.
> > >>
> > >> Looking at the Synopsys DW-PCIe Databook, Max_Payload_Size &
> > >> Max_Read_Request_Size are used to decompose into AXI burst, but it
> > >> seems the Max_Payload_Size & Max_Read_Request_Size are set by
> > >> default to 512 but the internal Max_Payload_Size_Supported is set to
> > >> 256, thus changing these values to 256 at runtime to match and
> > >> optimize bandwidth.
> > >>
> > >> It's said, "Reducing Outbound Decomposition" :
> > >>  - "Ensure that your application master does not generate bursts of
> > >>    size greater than or equal to Max_Payload_Size"
> > >>
> > >>  - "Program your PCIe system with a larger value of Max_Payload_Size
> > >>    without exceeding Max_Payload_Size_Supported"
> > >>
> > >>  - "Program your PCIe system with a larger value of Max_Read_Request
> > >>    without exceeding Max_Payload_Size_Supported:
> > >>
> > >> So leaving 512 in Max_Payload_Size & Max_Read_Request leads to
> > >> Outbound Decomposition which decreases PCIe link and degrades the
> > >> AXI bus by doubling the bursts, leading to this fix to avoid
> > >> overflowing the AXI bus.
> > >>
> > >> So it seems to be still needed, I assume this *should* be handled in
> > >> the core somehow to propagate these settings to child endpoints to
> > >> match the root port Max_Payload_Size & Max_Read_Request sizes.
> > >>
> > >> Maybe by adding a core function to set these values instead of using
> > >> the dw_pcie_find_capability() & dw_pcie_write/readl_dbi() helpers
> > >> and set a state on the root port to propagate the value ?
> > >
> > > I don't have the Synopsys DW-PCIe Databook, so I'm lacking any
> > > context.  The above *seems* to say that MPS/MRRS settings affect AXI
> > > bus usage.
> >
> > It does when the TLPs are directed to the RC.
>
> That's a defect in the RC.
>
> > > The MPS and MRRS registers are defined to affect traffic on *PCIe*.  If
> > > a platform uses MPS and MRRS values to optimize transfers on non-PCIe
> > > links, that's a problem because the PCI core code that manages MPS and
> > > MRRS has no knowledge of those non-PCIe parts of the system.
> >
> > Yes and no, it only affects PCIe in P2P, in non-P2P is will certainly affect
> > transfers on the internal SoC/Processor/Chip internal bus/fabric.
> >
> > > You might be able to deal with this in Synopsys-specific code somehow,
> > > but it's going to be a bit of a hassle because I don't want it to make
> > > maintenance of the generic MPS/MRRS code harder.
> >
> > I understand, but this is why these quirks are currently implemented in the
> > controller driver and only applies when the controller has been probed
> > and to each endpoint detected on this particular controller.
> >
> > So we may continue having separate quirks for each controller if the core
> > isn't the right place to handle MPS/MRRS.
>
> The PCI core is the correct place to handle MPS/MRRS because their
> behavior is defined by the PCIe spec.
>
> Quirks are the way to work around this defect in the Synopsys PCIe IP.
>
> Bjorn
