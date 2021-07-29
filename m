Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FAA3D9B93
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 04:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhG2CGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 22:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG2CGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 22:06:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E504C061757;
        Wed, 28 Jul 2021 19:06:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x7so860155ilh.10;
        Wed, 28 Jul 2021 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gw638gPEElf7gPsZoaSODOIPFTTqrPgexZer8ynjLek=;
        b=I38YYBpI9kUB85qSrUEOHLs4oZ5hBshAMGMSoHCBvCtMg3Frrpqek7sFDoaq6lCyjt
         rO6VLyfYuzWMWb5bWh6wA4Qv/huiiHGfHyUzxEzm0U5Lcrsf1gzA3yx5pnbafP3PYL+H
         4OV1dT/w1PDDDw9Tax09yRbqHxaH48OrNSDF4FHKcEa7Tan4tnBt3LAyTImwr2nrti4A
         LszDNG/ZZVxqCi9Jq95+D08yzQlUXmrarYxdvLFEENlkHx3NUlrBmaXX1NS2ieAE5A4W
         dWtgM5J/diQ9cEkmR+x3S7k6mSpPl4JM2JWDvuPtihX4zysQuQYz0lAGg470deylF5J6
         qVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gw638gPEElf7gPsZoaSODOIPFTTqrPgexZer8ynjLek=;
        b=R881H2QdC52Us4JBHZ7Ldc9t0K4CDbX9EN2VwVadhUQPoOP/HNGzYC0lJ1F7Dn0upW
         uCU9HK/b5gQ86xqgVAh7gsn0fdrPmHNLUNwZW5j0USJGL5nBQdY0deKXw7O8zIs1hlse
         Ozr2nWY9yiSMB6TCg7J3QzqwFdXldI5xldFsBlATGaf130ggwl+ZIvcz19rOb8OsUo0T
         dmnYUM8Fkbj7eJpLvSow/fvx/dEEeoW2cIErXhmeuydTyW6e/QU57BLvzvpH2n1iHl0Z
         4rINSxhAqfxuF5p3CIgyhp5HSkvRsCIUjddE/oee9ZVDyvP2fIfIPxnhcc/qkyo/bsy/
         iDrg==
X-Gm-Message-State: AOAM530Qmdqa2FfWabP5Kn5cxwo8EZfhKDDGip2brtdNIh385le2RkyA
        R9fuSo3OZD8SEJz4ExfvohujXCdrc1cHguTtZ5c=
X-Google-Smtp-Source: ABdhPJweTQMZMOJZhsoSA6X0MeGnEy5oVheg7f7rSBxVhp24LiURAoMneyjr65xHD8o3c6MnGXmb40ia8HnNWPc3sro=
X-Received: by 2002:a05:6e02:68d:: with SMTP id o13mr1965269ils.150.1627524378676;
 Wed, 28 Jul 2021 19:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210727194323.GA725763@bjorn-Precision-5520> <63838b21-3073-0b07-53d3-b85d6e89f0eb@baylibre.com>
In-Reply-To: <63838b21-3073-0b07-53d3-b85d6e89f0eb@baylibre.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Thu, 29 Jul 2021 10:06:06 +0800
Message-ID: <CAKaHn9+rEBTm3DfdSBXhMuark=4YvXqv1YoEQdo43f=gOFnwCg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: DWC: meson: add 256 bytes MRRS quirk
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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

> The fun part is that the pci=pcie_bus_perf kerne cmdline solves this already,

yes pci=pcie_bus_perf works only because setup same MRRS=256 in this case
same like in this patch pcie_set_readrq(dev, 256 )

some details about pci=pcie_bus_perf

[    4.665327] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    4.671166] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    4.677793] pci 0000:00:00.0: supports D1
[    4.683028] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    4.691667] pci 0000:01:00.0: [2646:2263] type 00 class 0x010802
[    4.697469] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    4.704218] pci 0000:01:00.0: pcie_get_mps - 128
[    4.709607] pci 0000:00:00.0: pcie_get_mps - 256
[    4.715145] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth,
limited by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    4.748582] pci 0000:00:00.0: BAR 14: assigned [mem 0xfc700000-0xfc7fffff]
[    4.755575] pci 0000:00:00.0: BAR 6: assigned [mem
0xfc800000-0xfc80ffff pref]
[    4.762731] pci 0000:01:00.0: BAR 0: assigned [mem
0xfc700000-0xfc703fff 64bit]
[    4.769849] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    4.775195] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    4.781741] pci 0000:00:00.0: pcie_get_mps - 256
[    4.787118] pci 0000:00:00.0: pcie_set_mps - 256 (32)
[    4.792404] pci 0000:00:00.0: pcie_get_mps - 256
[    4.797637] pci 0000:00:00.0: pcie_get_mps - 256
[    4.802674] pci 0000:00:00.0: Max Payload Size set to  256/ 256
(was  256), Max Read Rq  256
[    4.810602] pci 0000:01:00.0: pcie_get_mps - 128
[    4.815590] pci 0000:00:00.0: pcie_get_mps - 256
[    4.820422] pci 0000:01:00.0: pcie_set_mps - 256 (32)
[    4.825274] pci 0000:01:00.0: pcie_get_mps - 256
[    4.829946] pci 0000:01:00.0: pcie_set_readrq - 256
[    4.834609] pci 0000:01:00.0: pcie_get_mps - 256
[    4.839174] pci 0000:01:00.0: pcie_get_mps - 256
[    4.843582] pci 0000:01:00.0: Max Payload Size set to  256/ 256
(was  128), Max Read Rq  256

and pci=pcie_bus_perf works for whole system and i think its not good
idea use or adoptate this option for this case

Artem

On Wed, Jul 28, 2021 at 11:08 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
>
> On 27/07/2021 21:43, Bjorn Helgaas wrote:
> > On Tue, Jul 27, 2021 at 10:30:00AM +0800, Artem Lapkin wrote:
> >> 256 bytes maximum read request size. They can't handle
> >> anything larger than this. So force this limit on
> >> any devices attached under these ports.
> >
> > This needs to say whether this is a functional or a performance issue.
> >
> > If it's a functional issue, i.e., if meson signals an error or abort
> > when it receives a read request for > 256 bytes, we need to explain
> > exactly what happens.
> >
> > If it's a performance issue, we need to explain why MRRS affects
> > performance and that this is an optimization.
> >
> >> Come-from: https://lkml.org/lkml/2021/6/18/160
> >> Come-from: https://lkml.org/lkml/2021/6/19/19
> >
> > Please use lore.kernel.org URLs instead.  The lore URLs are a little
> > uglier, but are more functional, more likely to continue working, and
> > avoid the ads.  These are:
> >
> >   https://lore.kernel.org/r/20210618230132.GA3228427@bjorn-Precision-5520
> >   https://lore.kernel.org/r/20210619063952.2008746-1-art@khadas.com
> >
> >> It only affects PCIe in P2P, in non-P2P is will certainly affect
> >> transfers on the internal SoC/Processor/Chip internal bus/fabric.
> >
> > This needs to explain how a field in a PCIe TLP affects transfers on
> > these non-PCIe fabrics.
> >
> >> These quirks are currently implemented in the
> >> controller driver and only applies when the controller has been probed
> >> and to each endpoint detected on this particular controller.
> >>
> >> Continue having separate quirks for each controller if the core
> >> isn't the right place to handle MPS/MRRS.
> >
> > I see similar code in dwc/pci-keystone.c.  Does this problem actually
> > affect *all* DesignWare-based controllers?
> >
> > If so, we should put the workaround in the common dwc code, e.g.,
> > pcie-designware.c or similar.
> >
> > It also seems to affect pci-loongson.c (not DesignWare-based).  Is
> > there some reason it has the same problem, e.g., does loongson contain
> > DesignWare IP, or does it use the same non-PCIe fabric?
>
> As my reply on the previous thread, the Synopsys IP can be configured with a
> maximum TLP packet to AXI transaction size, which is hardcoded AFAIK Amlogic
> doesn't explicit it. And it doesn't seem we can read the value.
>
> This means is a TPL size if higher than this maximum packet size, the IP will
> do multiple AXI transactions, and this can reduce the system overall performance.
>
> The problem is that it affects the P2P transactions aswell, which can support any MPS/MRRS.
> But honestly, it's not a big deal on a PCIe 2.0 1x system only designed for NVMe and basic
> PCIe devices.
>
> The fun part is that the pci=pcie_bus_perf kerne cmdline solves this already,
> isn't there any possibility to force pcie_bus_perf for a particular root port ?
>
> Neil
>
> >
> >>>> Neil
> >>
> >> Signed-off-by: Artem Lapkin <art@khadas.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-meson.c | 31 ++++++++++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> >> index 686ded034..1498950de 100644
> >> --- a/drivers/pci/controller/dwc/pci-meson.c
> >> +++ b/drivers/pci/controller/dwc/pci-meson.c
> >> @@ -466,6 +466,37 @@ static int meson_pcie_probe(struct platform_device *pdev)
> >>      return ret;
> >>  }
> >>
> >> +static void meson_mrrs_limit_quirk(struct pci_dev *dev)
> >> +{
> >> +    struct pci_bus *bus = dev->bus;
> >> +    int mrrs, mrrs_limit = 256;
> >> +    static const struct pci_device_id bridge_devids[] = {
> >> +            { PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },
> >
> > I don't really believe that PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 is the
> > only device affected here.  Is this related to the Meson root port, or
> > is it related to a PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 on a plug-in card?
> > I guess the former, since you're searching upward for a root port.
> >
> > So why is this limited to PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3?
> >
> >> +            { 0, },
> >> +    };
> >> +
> >> +    /* look for the matching bridge */
> >> +    while (!pci_is_root_bus(bus)) {
> >> +            /*
> >> +             * 256 bytes maximum read request size. They can't handle
> >> +             * anything larger than this. So force this limit on
> >> +             * any devices attached under these ports.
> >> +             */
> >> +            if (!pci_match_id(bridge_devids, bus->self)) {
> >> +                    bus = bus->parent;
> >> +                    continue;
> >> +            }
> >> +
> >> +            mrrs = pcie_get_readrq(dev);
> >> +            if (mrrs > mrrs_limit) {
> >> +                    pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
> >> +                    pcie_set_readrq(dev, mrrs_limit);
> >> +            }
> >> +            break;
> >> +    }
> >> +}
> >> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_mrrs_limit_quirk);
> >> +
> >>  static const struct of_device_id meson_pcie_of_match[] = {
> >>      {
> >>              .compatible = "amlogic,axg-pcie",
> >> --
> >> 2.25.1
> >>
>
