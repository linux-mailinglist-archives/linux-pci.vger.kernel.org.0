Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D983BB96A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGEIiH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhGEIiH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 04:38:07 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C61C061574;
        Mon,  5 Jul 2021 01:35:31 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o10so16637920ils.6;
        Mon, 05 Jul 2021 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d/z0wdGwqo9fBiWvUKCHWb/kQLPqJkEvWOdgihFLsj8=;
        b=nnIo3J5eDnno109p9aSKDxVdvCbFHp1smIORXB6hZq5EJHpgLZSCO4qP5Zs/l1a6XV
         HB8E3gbb9zLBNY+M89JdThVHsIUMNs8YWeIVS3vgcwqOMSy34psw+1t/dNaHc+RgCpGt
         Ud6XtMDaWKU0aKQZlxLdbBKP71+N4ICCQyeG2NNdbYcPGjpJku68kl4nOv5pU62ibYT1
         oToGm7yNkp15taLIWju8i0ZO5Ry08JoF3LMatsVsrVh9gFMz/wdk400nt1P/xbtP3FaZ
         O5FMuRzJ/grWG1JJL08q+p47b8UrFJO14V+l+wjvzua9sliDAmZYOE0OQNatiTH03wr/
         zmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d/z0wdGwqo9fBiWvUKCHWb/kQLPqJkEvWOdgihFLsj8=;
        b=GCx5Ui9cjNUdP2ZZBX4mRYViR8JN3K+e04TAn7Zk2tCLEHpGFhPrkzk/Vvq8PhXhZC
         mepfEgzENJS1jwDYcBWi58tXVpNPgTuNOezfDax3vD5FX1ENJomG7jxKpwBuJAlTzIqe
         kDXYJoq1XJWbY69NDqZyD3UP0P9lS/Y+XPo5U5VLq8fW9zw3I1GGa8JAvk+RcitgXcZK
         EMsAFlYxvHMxi6T1GYZErwK1pqs5tZSlt0f4tpdb6ztvTIvW4vqEPsC1Bc/TdwTsshiU
         8n19CLv6SQjqxiRXOCp1fWxY5GAaNbVuT0wVgRcMoKNj9VcqVStmLZcH5vjGtLpPkhEv
         8UYg==
X-Gm-Message-State: AOAM5329s9oNhjasV606cFjZx/nzwa70DLA7ZDkaOSVgfyDl6vEnTYfH
        Dvjv2plxgN+jHcj0rRrZzKiAXQ0mbGXgpPWC3hE=
X-Google-Smtp-Source: ABdhPJz2XNkzxoMF2ciJoR4PMgzdzbrxMkwrN9p4oVhgaS5rrdQ8ctbDneqd2RHXne/ebOI01Evyw56XuTGLo2Wwkng=
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id i14mr3756014ila.150.1625474130559;
 Mon, 05 Jul 2021 01:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210701154634.GA60743@bjorn-Precision-5520> <67a9e1fa.81a9.17a64c8e7f7.Coremail.chenhuacai@loongson.cn>
In-Reply-To: <67a9e1fa.81a9.17a64c8e7f7.Coremail.chenhuacai@loongson.cn>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Mon, 5 Jul 2021 16:35:19 +0800
Message-ID: <CAKaHn9KxRrBsn4b9fSO1eDzM3XdV2GzfwVX+cGw9uS_eKg75dw@mail.gmail.com>
Subject: Re: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
        linux-kernel@vger.kernel.org, Artem Lapkin <art@khadas.com>,
        Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>,
        chenhuacai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Does that means keystone and Loongson has the same MRRS problem? And what=
 should I do now?

Look like yes ! and  amlogic has the same problem.
I think somebody need to rewrite it all to one common quirk for this proble=
m.

If no one has any objection, I can try to remake it again.

On Fri, Jul 2, 2021 at 9:15 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@loon=
gson.cn> wrote:
>
> Hi, Bjorn,
>
> &gt; -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> &gt; =E5=8F=91=E4=BB=B6=E4=BA=BA: "Bjorn Helgaas" <helgaas@kernel.org>
> &gt; =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021-07-01 23:46:34 (=E6=98=9F=
=E6=9C=9F=E5=9B=9B)
> &gt; =E6=94=B6=E4=BB=B6=E4=BA=BA: "Artem Lapkin" <email2tema@gmail.com>
> &gt; =E6=8A=84=E9=80=81: narmstrong@baylibre.com, yue.wang@Amlogic.com, k=
hilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.c=
om, jbrunet@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@g=
ooglemail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.=
org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, art@k=
hadas.com, nick@khadas.com, gouwa@khadas.com, "Huacai Chen" <chenhuacai@loo=
ngson.cn>
> &gt; =E4=B8=BB=E9=A2=98: Re: [PATCH 0/4] PCI: replace dublicated MRRS lim=
it quirks
> &gt;
> &gt; [+cc Huacai]
> &gt;
> &gt; On Sat, Jun 19, 2021 at 02:39:48PM +0800, Artem Lapkin wrote:
> &gt; &gt; Replace dublicated MRRS limit quirks by mrrs_limit_quirk from c=
ore
> &gt; &gt; * drivers/pci/controller/dwc/pci-keystone.c
> &gt; &gt; * drivers/pci/controller/pci-loongson.c
> &gt;
> &gt; s/dublicated/duplicated/ (several occurrences)
> &gt;
> &gt; Capitalize subject lines.
> &gt;
> &gt; Use "git log --online" to learn conventions and follow them.
> &gt;
> &gt; Add "()" after function names.
> &gt;
> &gt; Capitalize acronyms appropriately (NVMe, MRRS, PCI, etc).
> &gt;
> &gt; End sentences with periods.
> &gt;
> &gt; A "move" patch must include both the removal and the addition and ma=
ke
> &gt; no changes to the code itself.
> &gt;
> &gt; Amlogic appears without explanation in 2/4.  Must be separate patch =
to
> &gt; address only that specific issue.  Should reference published erratu=
m
> &gt; if possible.  "Solves some issue" is not a compelling justification.
> &gt;
> &gt; The tree must be consistent and functionally the same or improved
> &gt; after every patch.
> &gt;
> &gt; Add to pci_ids.h only if symbol used more than one place.
> &gt;
> &gt; See
> &gt; https://lore.kernel.org/r/20210701074458.1809532-3-chenhuacai@loongs=
on.cn,
> &gt; which looks similar.  Combine efforts if possible and cc Huacai so
> &gt; you're both aware of overlapping work.
> &gt;
> &gt; More hints in case they're useful:
> &gt; https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-gl=
aptop.roam.corp.google.com/
> &gt;
> &gt; &gt; Both ks_pcie_quirk loongson_mrrs_quirk was rewritten without an=
y
> &gt; &gt; functionality changes by one mrrs_limit_quirk
> Does that means keystone and Loongson has the same MRRS problem? And what=
 should I do now?
>
> Huacai
> &gt; &gt;
> &gt; &gt; Added DesignWare PCI controller which need same quirk for
> &gt; &gt; * drivers/pci/controller/dwc/pci-meson.c (PCI_DEVICE_ID_SYNOPSY=
S_HAPSUSB3)
> &gt; &gt;
> &gt; &gt; This quirk can solve some issue for Khadas VIM3/VIM3L(Amlogic)
> &gt; &gt; with HDMI scrambled picture and nvme devices at intensive writi=
ng...
> &gt; &gt;
> &gt; &gt; come from:
> &gt; &gt; * https://lore.kernel.org/linux-pci/20210618063821.1383357-1-ar=
t@khadas.com/
> &gt; &gt;
> &gt; &gt; Artem Lapkin (4):
> &gt; &gt;  PCI: move Keystone and Loongson device IDs to pci_ids
> &gt; &gt;  PCI: core: quirks: add mrrs_limit_quirk
> &gt; &gt;  PCI: keystone move mrrs quirk to core
> &gt; &gt;  PCI: loongson move mrrs quirk to core
> &gt; &gt;
> &gt; &gt; --
> &gt; &gt; 2.25.1
> &gt; &gt;
>
>
> </chenhuacai@loongson.cn></email2tema@gmail.com></helgaas@kernel.org>
