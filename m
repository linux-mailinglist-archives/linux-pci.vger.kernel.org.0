Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4150B3BC49F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 03:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhGFBjT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 21:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhGFBjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 21:39:18 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02FFC061574;
        Mon,  5 Jul 2021 18:36:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so18930958ilu.4;
        Mon, 05 Jul 2021 18:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B582vdrs46kitJpA3JaiMzIr2mncrXCNua47i7ErJFI=;
        b=f+GfAJAAKpgZuIxD67wH2PCJ1VkbUs8feFPpWpgdRr7htZIKUPG+8rxaSQOJoecrVU
         6m4pG8SWFK/Kn/6nX2FtwzENX/6Q4LVwvXVTRSMBM6DtY4lsaGiXqBDRPKwm1ET2R7L1
         GFfnOVpuvkdJA8VoqM+CsGbI+eH4mOajiQrWXTetHW6XmUU3EG77PqC263xKXspOKi4M
         vwuvngSNLXaU+5fC3sEMvi8Nj0AP+6hdGYddVt8TGGDQqxJXQT8SCu3IVCL2xaH/Xxj+
         ZZACC0uWXxnDj5q3BHyRQyB4GnCLhMhR9n0UzmXTu4uKyuPuL27oX44UgrQIDem3IRwY
         V2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B582vdrs46kitJpA3JaiMzIr2mncrXCNua47i7ErJFI=;
        b=nKFquxsBrzG2cpUJ8Jwwh1c8f4DEmSID0hcrURtrF7Uj6+eD9VCxNvn6RWuphYVHrN
         I4HQvA7Dz8NMrAQfOUr1nYpQ1DS2+yiuIdqKQB8W8PfIo891QKIk04ty2uxSqQoJ3yWn
         rrZjB/+vcKUNBohW2yBY2zdz7CZ9BYx+7bgQHQQUFVRUW1PEe0eXYpYWXToFE2Va9Ztl
         cBVEvuukaqxWq4b7nrmdcGMR4DV50ParDOo6xHrcWfUqsmMCoX4yuD4RqV+diPZfdHDe
         u/nhAVMVdfgpT5kdRxeLmr7UjEkjFnmqmAUdh8XBsbyQ+doegE1niGunG1VZ/GL3hpDq
         3hHw==
X-Gm-Message-State: AOAM531tVLTo6glQ7ZlM+B3F++efJFSH93X5GXllt2ifruqS9oMeRDkq
        Yqr97bwdFg4pkbuvh5yD4mIQEqylXbWg1+99uL0=
X-Google-Smtp-Source: ABdhPJxlXOvVM4cC+roK2GgPflu1PaK7vbyn6QRobwuGWJTCMPSrJ2tYUOwj5zNnMiZ1PYgZRVumsAeRiUclsv5Nopg=
X-Received: by 2002:a05:6e02:1d12:: with SMTP id i18mr12892359ila.97.1625535400201;
 Mon, 05 Jul 2021 18:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210701154634.GA60743@bjorn-Precision-5520> <67a9e1fa.81a9.17a64c8e7f7.Coremail.chenhuacai@loongson.cn>
 <CAKaHn9KxRrBsn4b9fSO1eDzM3XdV2GzfwVX+cGw9uS_eKg75dw@mail.gmail.com>
In-Reply-To: <CAKaHn9KxRrBsn4b9fSO1eDzM3XdV2GzfwVX+cGw9uS_eKg75dw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 6 Jul 2021 09:36:28 +0800
Message-ID: <CAAhV-H5M5Qf01DTD8ULGGGnv2kc2exRgXCLyNOOaqRL=dZ77xQ@mail.gmail.com>
Subject: Re: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
To:     Art Nikpal <email2tema@gmail.com>
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

Hi, Art,

On Mon, Jul 5, 2021 at 4:35 PM Art Nikpal <email2tema@gmail.com> wrote:
>
> > Does that means keystone and Loongson has the same MRRS problem? And wh=
at should I do now?
>
> Look like yes ! and  amlogic has the same problem.
> I think somebody need to rewrite it all to one common quirk for this prob=
lem.
>
> If no one has any objection, I can try to remake it again.
But, Loongson platform has newer revision of hardware, and the MRRS
quirk has changed, please see:
https://patchwork.kernel.org/project/linux-pci/list/?series=3D509497

Huacai
>
> On Fri, Jul 2, 2021 at 9:15 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@lo=
ongson.cn> wrote:
> >
> > Hi, Bjorn,
> >
> > &gt; -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > &gt; =E5=8F=91=E4=BB=B6=E4=BA=BA: "Bjorn Helgaas" <helgaas@kernel.org>
> > &gt; =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021-07-01 23:46:34 (=E6=98=
=9F=E6=9C=9F=E5=9B=9B)
> > &gt; =E6=94=B6=E4=BB=B6=E4=BA=BA: "Artem Lapkin" <email2tema@gmail.com>
> > &gt; =E6=8A=84=E9=80=81: narmstrong@baylibre.com, yue.wang@Amlogic.com,=
 khilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux=
.com, jbrunet@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl=
@googlemail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradea=
d.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, art=
@khadas.com, nick@khadas.com, gouwa@khadas.com, "Huacai Chen" <chenhuacai@l=
oongson.cn>
> > &gt; =E4=B8=BB=E9=A2=98: Re: [PATCH 0/4] PCI: replace dublicated MRRS l=
imit quirks
> > &gt;
> > &gt; [+cc Huacai]
> > &gt;
> > &gt; On Sat, Jun 19, 2021 at 02:39:48PM +0800, Artem Lapkin wrote:
> > &gt; &gt; Replace dublicated MRRS limit quirks by mrrs_limit_quirk from=
 core
> > &gt; &gt; * drivers/pci/controller/dwc/pci-keystone.c
> > &gt; &gt; * drivers/pci/controller/pci-loongson.c
> > &gt;
> > &gt; s/dublicated/duplicated/ (several occurrences)
> > &gt;
> > &gt; Capitalize subject lines.
> > &gt;
> > &gt; Use "git log --online" to learn conventions and follow them.
> > &gt;
> > &gt; Add "()" after function names.
> > &gt;
> > &gt; Capitalize acronyms appropriately (NVMe, MRRS, PCI, etc).
> > &gt;
> > &gt; End sentences with periods.
> > &gt;
> > &gt; A "move" patch must include both the removal and the addition and =
make
> > &gt; no changes to the code itself.
> > &gt;
> > &gt; Amlogic appears without explanation in 2/4.  Must be separate patc=
h to
> > &gt; address only that specific issue.  Should reference published erra=
tum
> > &gt; if possible.  "Solves some issue" is not a compelling justificatio=
n.
> > &gt;
> > &gt; The tree must be consistent and functionally the same or improved
> > &gt; after every patch.
> > &gt;
> > &gt; Add to pci_ids.h only if symbol used more than one place.
> > &gt;
> > &gt; See
> > &gt; https://lore.kernel.org/r/20210701074458.1809532-3-chenhuacai@loon=
gson.cn,
> > &gt; which looks similar.  Combine efforts if possible and cc Huacai so
> > &gt; you're both aware of overlapping work.
> > &gt;
> > &gt; More hints in case they're useful:
> > &gt; https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-=
glaptop.roam.corp.google.com/
> > &gt;
> > &gt; &gt; Both ks_pcie_quirk loongson_mrrs_quirk was rewritten without =
any
> > &gt; &gt; functionality changes by one mrrs_limit_quirk
> > Does that means keystone and Loongson has the same MRRS problem? And wh=
at should I do now?
> >
> > Huacai
> > &gt; &gt;
> > &gt; &gt; Added DesignWare PCI controller which need same quirk for
> > &gt; &gt; * drivers/pci/controller/dwc/pci-meson.c (PCI_DEVICE_ID_SYNOP=
SYS_HAPSUSB3)
> > &gt; &gt;
> > &gt; &gt; This quirk can solve some issue for Khadas VIM3/VIM3L(Amlogic=
)
> > &gt; &gt; with HDMI scrambled picture and nvme devices at intensive wri=
ting...
> > &gt; &gt;
> > &gt; &gt; come from:
> > &gt; &gt; * https://lore.kernel.org/linux-pci/20210618063821.1383357-1-=
art@khadas.com/
> > &gt; &gt;
> > &gt; &gt; Artem Lapkin (4):
> > &gt; &gt;  PCI: move Keystone and Loongson device IDs to pci_ids
> > &gt; &gt;  PCI: core: quirks: add mrrs_limit_quirk
> > &gt; &gt;  PCI: keystone move mrrs quirk to core
> > &gt; &gt;  PCI: loongson move mrrs quirk to core
> > &gt; &gt;
> > &gt; &gt; --
> > &gt; &gt; 2.25.1
> > &gt; &gt;
> >
> >
> > </chenhuacai@loongson.cn></email2tema@gmail.com></helgaas@kernel.org>
