Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D54247F51
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHRHYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRHYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2020 03:24:18 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B959C061389;
        Tue, 18 Aug 2020 00:24:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x10so10824032ybj.13;
        Tue, 18 Aug 2020 00:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmoQCZpGaKbIsYS8+rvFpQeHNY5B2Hi6SrMeFT5bb98=;
        b=GLEHCiCChrPivNJbmyGftlp3kKltoTTqQa0tA2ZPntqqIrTYG5p5BC7XOo+bkkvFXc
         h07xzo32mFj+5EyR+HxvTynASwrNLzu29gqeCvFDgcfM6+fGXn7it8nyXfS1NOsSU2IE
         R7cpDqr2jKz3WLdS3niS1oE0D8lpn+G5scmCp2T0Q6cqbPEtOcXaqpVnPsU6xopZCNQ1
         /6LrtwfCBslzAlNMqz39FjY8c8anTv0oWKAWWyr4KofvMkZQOykKBDZqxu387ogYyZrC
         s5NcAdArrPTA0lu0Cd8apu/RdsvKz2QATaeZWXh9NxGeoddjFvjSvUfqzes7r6MzRCzH
         dV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmoQCZpGaKbIsYS8+rvFpQeHNY5B2Hi6SrMeFT5bb98=;
        b=bXgkQFSbvNWNEdjOeK96IyvdRHA4LkaCY2TS9PKktkOOQf0lWqLTSp9tcN9vKr9Snk
         ITDeH3IUsrLLMuNROiH9z6YN5tn3mUBQtJtqMsFa9OMhMPzi9bPqI3P6+lNQbuFkbaBd
         zjCpb3eKU7+FTRTutUX1+2KV2om25IrFlNV+3aH8n7jicIB7Sd9P6NwS2+ybyJ2UUl8h
         mIFLPBIdHsc+GTjk2Sjg14hJmwVl1/TQDJvrjxYKc+uGVDJtq/cIVaxa4+KTr71N4wz6
         LClWYQwDblEH62sTJZU8fauL6gbzNeQynb+alaJQzp2VQHqz4gFXiqRwAZUdM1prk5RZ
         MqRA==
X-Gm-Message-State: AOAM531ToJMUXJD2TgBYZgjcVtw6BMAkw2hQk6sP261fWoa200Zpl/ye
        g/pATTY7BbO18Qcjf2SotWWo9xS/AxlpbT3QdK0=
X-Google-Smtp-Source: ABdhPJzCDvUjiPWK649tyEh566910nzut2TlASPlTv0REFfFarykk7m1GFizATC9HgE6RSovRKmc3BBmUiq3wT1GcQU=
X-Received: by 2002:a25:5384:: with SMTP id h126mr6977055ybb.445.1597735456307;
 Tue, 18 Aug 2020 00:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200814173037.17822-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <fcabccab-54fb-8b8a-7034-9b0da9d32339@gmail.com>
In-Reply-To: <fcabccab-54fb-8b8a-7034-9b0da9d32339@gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 18 Aug 2020 08:23:49 +0100
Message-ID: <CA+V-a8v74fkzE8SYaaA5Wg=NT_mdgjNLTd0nha=UbHEC0pw0UA@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergei,

Thank you for the review.

On Sat, Aug 15, 2020 at 9:45 AM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
>
> Hello!
>
> On 14.08.2020 20:30, Lad Prabhakar wrote:
>
> > Add PCIe EP nodes to R8A774A1 (RZ/G2M) SoC dtsi.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >   arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 38 +++++++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > index a603d947970e..50e9ed16a36d 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > @@ -2369,6 +2369,44 @@
> >                       status = "disabled";
> >               };
> >
> > +             pciec0_ep: pcie_ep@fe000000 {
>
>     Hyphens are preferred over underscores in the node/prop names.
>
> [...]> +                pciec1_ep: pcie_ep@ee800000 {
>
>     Ditto, should be "pci-ep@ee800000".
>
My bad will fix that in v2.

Cheers,
Prabhakar

> [...]
>
> MBR, Sergei
