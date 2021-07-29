Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34103D9BB1
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 04:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhG2CVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 22:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhG2CVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 22:21:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7AC0617A3;
        Wed, 28 Jul 2021 19:21:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id j21so5047282ioo.6;
        Wed, 28 Jul 2021 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R17HCftwnExVBITUL3vMzRaZWklHE7WTCzst6j3TZE0=;
        b=hdY7VFsi9N5o+MaERqFmJqM8rLDPtB24yNrw+m9uftYHjOvQS76KB/pQ/8oTN3TvTO
         03Lp9St5tVPVpSf8lsDb1oebdIOF0hxx2HfufdT6xzCCEUmQ6mub+5LmyHdYF9pvmgCS
         FH8eo6S3ndkglCahj1jXSXb+aGWYSKf1wadUkLEUM2uLvvYMKsnjFJt8ebATOnWMmaOQ
         YX/pjqSFvHPI3aL2EQZmmZW7fPRRAbGkrILXQwFBQBe60rvEGG4c1fMzd/w6f7aIsA40
         ihVvGtyc80KDt7UcbpWNaN04EY9Xn/5Q4C3Nacu/ER8xEExCKT3PqpWy3DXUn3AUZT7P
         ZObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R17HCftwnExVBITUL3vMzRaZWklHE7WTCzst6j3TZE0=;
        b=KjvEv+bUPZsFIqUlMgMig5xDY16MQLjXR/6m9sFC0KvBXLxd2U/G4nnhrLHHSTWFA1
         clVHokZdt9EYcaQHfoEvw5ZpghWlDUMcSTsEtJs/vAHFrzgjMYQN6qLR5MT31OyXB4MD
         MRfjRnaAvdl9IV+yq0jpllkt8bOUZgHhVhH1EXk42Z5NkS2wISJEsTsU/FEEJGWv1tB0
         NZnLQoAqDqU6fi3bY6iF2deNYCJrRSiWW5I9HZFjhQrf88fu8mTjmAHil/dwXVPCDPqA
         /GkbW685SNQF+YFbfcWihZPCgNNR2vxqZVMLHS+KUj3Rtuv/ZpQFi9S5NiIFfy80Serc
         NUMg==
X-Gm-Message-State: AOAM530u66pF+67JsjV933ut8k/TQ5ooIRWzmkp9xxu39FBhi1AxW6/8
        EIfQTImvvMS9POBVnY4W1Bd2Vs0voykwTS9+wuo=
X-Google-Smtp-Source: ABdhPJwhF+4ItV92GHowHGlYO3feVZkAERCaidqhU4S0KwkvIU5yRksnVUo6bOZR3DlFQmAQ2tsdJ6eNwSE4qqzCU0I=
X-Received: by 2002:a05:6602:2801:: with SMTP id d1mr2044245ioe.73.1627525291992;
 Wed, 28 Jul 2021 19:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210727023000.1030525-1-art@khadas.com> <20210727194323.GA725763@bjorn-Precision-5520>
In-Reply-To: <20210727194323.GA725763@bjorn-Precision-5520>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Thu, 29 Jul 2021 10:21:20 +0800
Message-ID: <CAKaHn9LxBey-BT4nLWDUS7ZOUSFrUhXsqe8zp9LYWceVr5vfgA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: DWC: meson: add 256 bytes MRRS quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
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

> This needs to say whether this is a functional or a performance issue.

Looks like not a performance issue , this is a functional issue.

We detect just one problem(may be exist another i dont know ) for
writing(reading works fine) any data to NVME devices with MRRS != 256
we have scrambled HDMI display

> Does this problem actually affect *all* DesignWare-based controllers?
> So why is this limited to PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3?

i can say only for VIM3 device which use this controller and have this problem

On Wed, Jul 28, 2021 at 3:43 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jul 27, 2021 at 10:30:00AM +0800, Artem Lapkin wrote:
> > 256 bytes maximum read request size. They can't handle
> > anything larger than this. So force this limit on
> > any devices attached under these ports.
>
> This needs to say whether this is a functional or a performance issue.
>
> If it's a functional issue, i.e., if meson signals an error or abort
> when it receives a read request for > 256 bytes, we need to explain
> exactly what happens.
>
> If it's a performance issue, we need to explain why MRRS affects
> performance and that this is an optimization.
>
> > Come-from: https://lkml.org/lkml/2021/6/18/160
> > Come-from: https://lkml.org/lkml/2021/6/19/19
>
> Please use lore.kernel.org URLs instead.  The lore URLs are a little
> uglier, but are more functional, more likely to continue working, and
> avoid the ads.  These are:
>
>   https://lore.kernel.org/r/20210618230132.GA3228427@bjorn-Precision-5520
>   https://lore.kernel.org/r/20210619063952.2008746-1-art@khadas.com
>
> > It only affects PCIe in P2P, in non-P2P is will certainly affect
> > transfers on the internal SoC/Processor/Chip internal bus/fabric.
>
> This needs to explain how a field in a PCIe TLP affects transfers on
> these non-PCIe fabrics.
>
> > These quirks are currently implemented in the
> > controller driver and only applies when the controller has been probed
> > and to each endpoint detected on this particular controller.
> >
> > Continue having separate quirks for each controller if the core
> > isn't the right place to handle MPS/MRRS.
>
> I see similar code in dwc/pci-keystone.c.  Does this problem actually
> affect *all* DesignWare-based controllers?
>
> If so, we should put the workaround in the common dwc code, e.g.,
> pcie-designware.c or similar.
>
> It also seems to affect pci-loongson.c (not DesignWare-based).  Is
> there some reason it has the same problem, e.g., does loongson contain
> DesignWare IP, or does it use the same non-PCIe fabric?
>
> > >> Neil
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
> > ---
> >  drivers/pci/controller/dwc/pci-meson.c | 31 ++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> > index 686ded034..1498950de 100644
> > --- a/drivers/pci/controller/dwc/pci-meson.c
> > +++ b/drivers/pci/controller/dwc/pci-meson.c
> > @@ -466,6 +466,37 @@ static int meson_pcie_probe(struct platform_device *pdev)
> >       return ret;
> >  }
> >
> > +static void meson_mrrs_limit_quirk(struct pci_dev *dev)
> > +{
> > +     struct pci_bus *bus = dev->bus;
> > +     int mrrs, mrrs_limit = 256;
> > +     static const struct pci_device_id bridge_devids[] = {
> > +             { PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },
>
> I don't really believe that PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 is the
> only device affected here.  Is this related to the Meson root port, or
> is it related to a PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 on a plug-in card?
> I guess the former, since you're searching upward for a root port.
>
> So why is this limited to PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3?
>
> > +             { 0, },
> > +     };
> > +
> > +     /* look for the matching bridge */
> > +     while (!pci_is_root_bus(bus)) {
> > +             /*
> > +              * 256 bytes maximum read request size. They can't handle
> > +              * anything larger than this. So force this limit on
> > +              * any devices attached under these ports.
> > +              */
> > +             if (!pci_match_id(bridge_devids, bus->self)) {
> > +                     bus = bus->parent;
> > +                     continue;
> > +             }
> > +
> > +             mrrs = pcie_get_readrq(dev);
> > +             if (mrrs > mrrs_limit) {
> > +                     pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
> > +                     pcie_set_readrq(dev, mrrs_limit);
> > +             }
> > +             break;
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_mrrs_limit_quirk);
> > +
> >  static const struct of_device_id meson_pcie_of_match[] = {
> >       {
> >               .compatible = "amlogic,axg-pcie",
> > --
> > 2.25.1
> >
