Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF63BC642
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 08:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGFGJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 02:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhGFGJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 02:09:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD0C061574;
        Mon,  5 Jul 2021 23:06:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b18so47775ilf.8;
        Mon, 05 Jul 2021 23:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BicthPpw23y2FsF1UbR3mzfkLh5Y7sZt9zqncg+I7ps=;
        b=sVmzWWAzvnnLrxV6pwBJ7JMhtpIixamWBz1xFudMY62uK7EJSaI+5TNwuKaUsohDX7
         030CmvMQsn7CCRraXAKGB9RkYiZUON6C2fFp6Bff49Hifd8mwey7Cag0kFwcI43Ajg3c
         rKiJxJIr6UGvaKA/u6Y+H0UC3ylveS3s4cc2qXdraJyudJqXPmdWmjDfQB0A+MUjc97B
         efPBZ7mTPNWqaEiiSMyCbmhHbCkWEYpLh0RAPpnzByBREgoC3x/0Lwi6Rh4KuhVIVKhC
         1S9oOCc5ICDX9u9Gi1H0OsfS0AzikQsi3eqSoCIzI6/8dAkA+d5/AYwwgm0bUpYua9+V
         buCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BicthPpw23y2FsF1UbR3mzfkLh5Y7sZt9zqncg+I7ps=;
        b=e23ltipYaz7vZ92+TI7PN8x/DGrp0ZlpzxI/yDU1QSOhQuuukfqLRg8FeP+JFbLlCB
         YUjzfIVeKEsapqGFB8rSK6UEJBuNOzAulj/KwgmY0439/JM6x2jruYlzP8JQCQdEcGeF
         v79Gi+YqTTtgUnhsE8bAW0dtzMhXPExiuZfpAcjFSv0WYzr5cw/xWbn8p9cUWZHPtYrU
         sVNXjW2lFzXkU8M3pTxD2F3UU33seXVju4ZCgEIj3ctUjz9AOlDBdWMih9MGu1sIqdvu
         q+MFkpLWePz6rZxFvz9yYl6tGutLmvlOeaVsu5GVr3xjFgzx+/DoDFsvOplErWht5sPU
         Pfvg==
X-Gm-Message-State: AOAM532QVI9dZYDe4wFQlvvoUb5X36K98oNubMIbpJz79O0Jbmb26rjV
        X6kJY4V9uU4Po7QVPq+/Q+jsNrouKLQkXElcqJI=
X-Google-Smtp-Source: ABdhPJxbRcQORWzcrJgZIlSqssNrhFbRyAgtL2B1hru9OfHsOWeWi4cfZjXFj3cZb6l+Wd71rzJbjvUOVa043ywVeOs=
X-Received: by 2002:a92:d4d0:: with SMTP id o16mr10065139ilm.153.1625551591404;
 Mon, 05 Jul 2021 23:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210701154634.GA60743@bjorn-Precision-5520> <67a9e1fa.81a9.17a64c8e7f7.Coremail.chenhuacai@loongson.cn>
 <CAKaHn9KxRrBsn4b9fSO1eDzM3XdV2GzfwVX+cGw9uS_eKg75dw@mail.gmail.com> <CAAhV-H5M5Qf01DTD8ULGGGnv2kc2exRgXCLyNOOaqRL=dZ77xQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5M5Qf01DTD8ULGGGnv2kc2exRgXCLyNOOaqRL=dZ77xQ@mail.gmail.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Tue, 6 Jul 2021 14:06:19 +0800
Message-ID: <CAKaHn9+iHk3UtovWU+WE2mXD9oTZD9UdxrYuLB2Odgbr91Gs-Q@mail.gmail.com>
Subject: Re: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>But, Loongson platform has newer revision of hardware, and the MRRS
> quirk has changed, please see:
> https://patchwork.kernel.org/project/linux-pci/list/?series=3D509497
> Huacai

OK! tnx for information ! maybe we can cooperate and make one
universal quirk for all

On Tue, Jul 6, 2021 at 9:36 AM Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Hi, Art,
>
> On Mon, Jul 5, 2021 at 4:35 PM Art Nikpal <email2tema@gmail.com> wrote:
> >
> > > Does that means keystone and Loongson has the same MRRS problem? And =
what should I do now?
> >
> > Look like yes ! and  amlogic has the same problem.
> > I think somebody need to rewrite it all to one common quirk for this pr=
oblem.
> >
> > If no one has any objection, I can try to remake it again.
> But, Loongson platform has newer revision of hardware, and the MRRS
> quirk has changed, please see:
> https://patchwork.kernel.org/project/linux-pci/list/?series=3D509497
>
> Huacai
> >
> > On Fri, Jul 2, 2021 at 9:15 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@=
loongson.cn> wrote:
> > >
> > > Hi, Bjorn,
> > >
> > > &gt; -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > > &gt; =E5=8F=91=E4=BB=B6=E4=BA=BA: "Bjorn Helgaas" <helgaas@kernel.org=
>
> > > &gt; =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021-07-01 23:46:34 (=E6=
=98=9F=E6=9C=9F=E5=9B=9B)
> > > &gt; =E6=94=B6=E4=BB=B6=E4=BA=BA: "Artem Lapkin" <email2tema@gmail.co=
m>
> > > &gt; =E6=8A=84=E9=80=81: narmstrong@baylibre.com, yue.wang@Amlogic.co=
m, khilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@lin=
ux.com, jbrunet@baylibre.com, christianshewitt@gmail.com, martin.blumenstin=
gl@googlemail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infrad=
ead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, a=
rt@khadas.com, nick@khadas.com, gouwa@khadas.com, "Huacai Chen" <chenhuacai=
@loongson.cn>
> > > &gt; =E4=B8=BB=E9=A2=98: Re: [PATCH 0/4] PCI: replace dublicated MRRS=
 limit quirks
> > > &gt;
> > > &gt; [+cc Huacai]
> > > &gt;
> > > &gt; On Sat, Jun 19, 2021 at 02:39:48PM +0800, Artem Lapkin wrote:
> > > &gt; &gt; Replace dublicated MRRS limit quirks by mrrs_limit_quirk fr=
om core
> > > &gt; &gt; * drivers/pci/controller/dwc/pci-keystone.c
> > > &gt; &gt; * drivers/pci/controller/pci-loongson.c
> > > &gt;
> > > &gt; s/dublicated/duplicated/ (several occurrences)
> > > &gt;
> > > &gt; Capitalize subject lines.
> > > &gt;
> > > &gt; Use "git log --online" to learn conventions and follow them.
> > > &gt;
> > > &gt; Add "()" after function names.
> > > &gt;
> > > &gt; Capitalize acronyms appropriately (NVMe, MRRS, PCI, etc).
> > > &gt;
> > > &gt; End sentences with periods.
> > > &gt;
> > > &gt; A "move" patch must include both the removal and the addition an=
d make
> > > &gt; no changes to the code itself.
> > > &gt;
> > > &gt; Amlogic appears without explanation in 2/4.  Must be separate pa=
tch to
> > > &gt; address only that specific issue.  Should reference published er=
ratum
> > > &gt; if possible.  "Solves some issue" is not a compelling justificat=
ion.
> > > &gt;
> > > &gt; The tree must be consistent and functionally the same or improve=
d
> > > &gt; after every patch.
> > > &gt;
> > > &gt; Add to pci_ids.h only if symbol used more than one place.
> > > &gt;
> > > &gt; See
> > > &gt; https://lore.kernel.org/r/20210701074458.1809532-3-chenhuacai@lo=
ongson.cn,
> > > &gt; which looks similar.  Combine efforts if possible and cc Huacai =
so
> > > &gt; you're both aware of overlapping work.
> > > &gt;
> > > &gt; More hints in case they're useful:
> > > &gt; https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaa=
s-glaptop.roam.corp.google.com/
> > > &gt;
> > > &gt; &gt; Both ks_pcie_quirk loongson_mrrs_quirk was rewritten withou=
t any
> > > &gt; &gt; functionality changes by one mrrs_limit_quirk
> > > Does that means keystone and Loongson has the same MRRS problem? And =
what should I do now?
> > >
> > > Huacai
> > > &gt; &gt;
> > > &gt; &gt; Added DesignWare PCI controller which need same quirk for
> > > &gt; &gt; * drivers/pci/controller/dwc/pci-meson.c (PCI_DEVICE_ID_SYN=
OPSYS_HAPSUSB3)
> > > &gt; &gt;
> > > &gt; &gt; This quirk can solve some issue for Khadas VIM3/VIM3L(Amlog=
ic)
> > > &gt; &gt; with HDMI scrambled picture and nvme devices at intensive w=
riting...
> > > &gt; &gt;
> > > &gt; &gt; come from:
> > > &gt; &gt; * https://lore.kernel.org/linux-pci/20210618063821.1383357-=
1-art@khadas.com/
> > > &gt; &gt;
> > > &gt; &gt; Artem Lapkin (4):
> > > &gt; &gt;  PCI: move Keystone and Loongson device IDs to pci_ids
> > > &gt; &gt;  PCI: core: quirks: add mrrs_limit_quirk
> > > &gt; &gt;  PCI: keystone move mrrs quirk to core
> > > &gt; &gt;  PCI: loongson move mrrs quirk to core
> > > &gt; &gt;
> > > &gt; &gt; --
> > > &gt; &gt; 2.25.1
> > > &gt; &gt;
> > >
> > >
> > > </chenhuacai@loongson.cn></email2tema@gmail.com></helgaas@kernel.org>
