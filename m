Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720BE3AD6E6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 05:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhFSDER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 23:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhFSDEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 23:04:16 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580CCC061574;
        Fri, 18 Jun 2021 20:02:05 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id p14so3489757ilg.8;
        Fri, 18 Jun 2021 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyPYkkSvMyYVEkMIHpUhP4h40bSciy9qGvek1zjV32o=;
        b=hl7p5r9hd+XZvulOZ1jnVte4vowXCqxDrUCk7I82uif5A6EbofWobMvM3MMwv3c2hX
         DbHqNTPPWtKtjukyEWnWCVwBx9ezt5LSdFwJTsa7ojEDGbRcqgFYOj9XdgonT/YrsDMc
         NNClnul4oOFPWWG6DW+kQF4xUF+0OQ1IsfXsLMNRBLQ4tpvJliSWEdAXbVaSrYnSwr4r
         7HFr2e/SDqQ2rKQSKxyJC8TWqZBUy2CiJtkby5iMvtubZxOJrR5JaMoFV/4lFFrpN58O
         JAvPof4tE5bYCEGqhsU1ojoMgTKRF6KUv4+8Vkpr2ulCitybquS6aHYDMd7y7Y8/IMA5
         C0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyPYkkSvMyYVEkMIHpUhP4h40bSciy9qGvek1zjV32o=;
        b=DRfJUW8WQK5h1H5MBTovDVZU5MYY9uky881WbG3LFGSgi1MR1HmKlpv+n9VGz+TkIn
         2qGUbpI2kmTObk1WD49lt13U7QYRHCKS3ETpbo6jwcnWTPYn78kLJAU8xFFaIsm6zFQR
         ZI7cIebRyKZnCK5C0oAhABgYT2sLSUl1xewKU8Sqzen5Uc1BVkDaAVf3+7Tt8xh/ogja
         32s/fnejP6mymDuiiWStbiDRpsfrODKXtL9UhN2H8mvA486FkMKme8BBPyN0pjojTO8p
         fFFvSiXXNebfIlNqqyxa8gAJ+V3ncmFxUq8RZp5onFwibURSWbkJoUm8R7p4r0z21ECt
         sxug==
X-Gm-Message-State: AOAM530bcUETa+nN22nvjov+JLS0Mp6I5ZeeLz0CIhR83KNn55qZlaBv
        V4gBxL6Gw6JjBgbaQMoyOlYNPs8/C8N4XJZP3fG4dPW4v2zMvciO
X-Google-Smtp-Source: ABdhPJxeBt4cianRkuXSqEDXxBTpxQiNIcHs/73YLkSBRGbVm/gZYYz3e32m9s80nyIMxBwKAI0S0vPZ7V+LQW8eZzo=
X-Received: by 2002:a92:7b0f:: with SMTP id w15mr9849020ilc.150.1624071724671;
 Fri, 18 Jun 2021 20:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210618063821.1383357-1-art@khadas.com> <CAFBinCB6bHy6Han0+oUcuGfccv1Rh_P0Gows1ezWdV4eA267tg@mail.gmail.com>
 <CAL_JsqK+zjf2r_Q9gE8JwJw+Emn+JB4wOyH7eQct=kBvpUKstw@mail.gmail.com> <9b27444c-ea13-0dd2-a671-cef27e03b35c@baylibre.com>
In-Reply-To: <9b27444c-ea13-0dd2-a671-cef27e03b35c@baylibre.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Sat, 19 Jun 2021 11:01:53 +0800
Message-ID: <CAKaHn9JK341ijN81kJyh32LksXVNGXTz-59QiGPxp0K6WGFN6g@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: meson add quirk
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Neil
> It should be enabled only when the Amlogic bridge is present, thus similar filtering as keystone & loongon
> is needed, but with such filtering we could reuse ks_pcie_quirk() and loongson_mrrs_quirk() as is.
> AFAIL Simply moving ks_pcie_quirk() and loongson_mrrs_quirk() to core with the amlogic pci IDS added would be sufficient here.

My patch was not a good solution! its was just example how to fix our
problem - need to remade it

Yes i'm agree with Neil , at this moment we can move (replace
duplicate functionalities)  ks_pcie_quirk() and loongson_mrrs_quirk()
to core  + add amlogic pci IDS PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS,
PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) - without other changes for everyone,
and after we can improve this quirk by next patches

i will send new patches variant soon

On Fri, Jun 18, 2021 at 11:08 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 18/06/2021 16:30, Rob Herring wrote:
> > On Fri, Jun 18, 2021 at 6:12 AM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> Hi Artem,
> >>
> >> On Fri, Jun 18, 2021 at 8:38 AM Artem Lapkin <email2tema@gmail.com> wrote:
> >>>
> >>> Device set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> >>> was find some issue with HDMI scrambled picture and nvme devices
> >>> at intensive writing...
> >>>
> >>> [    4.798971] nvme 0000:01:00.0: fix MRRS from 512 to 256
> >>>
> >>> This quirk setup same MRRS if we try solve this problem with
> >>> pci=pcie_bus_perf kernel command line param
> >> thank you for investigating this issue and for providing a fix!
> >>
> >> [...]
> >>> +static void meson_pcie_quirk(struct pci_dev *dev)
> >>> +{
> >>> +       int mrrs;
> >>> +
> >>> +       /* no need quirk */
> >>> +       if (pcie_bus_config != PCIE_BUS_DEFAULT)
> >>> +               return;
> >>> +
> >>> +       /* no need for root bus */
> >>> +       if (pci_is_root_bus(dev->bus))
> >>> +               return;
> >>> +
> >>> +       mrrs = pcie_get_readrq(dev);
> >>> +
> >>> +       /*
> >>> +        * set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> >>> +        * was find some issue with HDMI scrambled picture and nvme devices
> >>> +        * at intensive writing...
> >>> +        */
> >>> +
> >>> +       if (mrrs != MAX_READ_REQ_SIZE) {
> >>> +               dev_info(&dev->dev, "fix MRRS from %d to %d\n", mrrs, MAX_READ_REQ_SIZE);
> >>> +               pcie_set_readrq(dev, MAX_READ_REQ_SIZE);
> >>> +       }
> >>> +}
> >>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_pcie_quirk);
> >
> > Isn't this going to run for everyone if meson driver happens to be enabled?
>
> It should be enabled only when the Amlogic bridge is present, thus similar filtering as keystone & loongon
> is needed, but with such filtering we could reuse ks_pcie_quirk() and loongson_mrrs_quirk() as is.
>
> >
> >> it seems that other PCIe controllers need something similar. in
> >> particular I found pci-keystone [0] and pci-loongson [1]
> >> while comparing your code with the two existing implementations two
> >> things came to my mind:
> >> 1. your implementation slightly differs from the two existing ones as
> >> it's not walking through the parent PCI busses (I think this would be
> >> relevant if there's another bridge between the host bridge and the
> >> actual device)
> >> 2. (this is a question towards the PCI maintainers) does it make sense
> >> to have this MRRS quirk re-usable somewhere?
> >
> > Yes. Ideally, the max size could just be data in the bus or bridge
> > struct and perhaps some flags too, then the core can handle
> > everything.
>
> AFAIL Simply moving ks_pcie_quirk() and loongson_mrrs_quirk() to core with the amlogic pci IDS added would be sufficient here.
>
> Neil
>
> >
> > Rob
> >
>
