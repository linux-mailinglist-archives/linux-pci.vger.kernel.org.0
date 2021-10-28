Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4943DDD3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJ1Jh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhJ1JhZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 05:37:25 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA63C061570;
        Thu, 28 Oct 2021 02:34:59 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id b125so1859612vkb.9;
        Thu, 28 Oct 2021 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+X3RRqVMAFWzFiG8bOlA6agMfMr/xts6DAFOgovCf4=;
        b=JTrFeJUi1nHcWED+XsqnURqNpZwQ7ZvwmqNNFoThgBT97Dpjuas3HaRqH4GJ9PoSBd
         6evPn7983wvEENN4ryzgQA5SK4msKBe8cGtEUeGYfSVGeuedfEtXUgDr37WDP4rOUN1t
         4ZI+zJOXxivIeXJvcbl25az99WE6Yjb9ZyBH8f6aA2ZFJjKdQ2u2xNPQihZeBPWocYwX
         vOF9HT/f0pVlv62uZoqYK581JU8xPshIDixzCbyWUW1tftSeEImbEKy1XQdfwySt8GIQ
         rc1aXRlpoKD0hUS+IqXLvFgdNHt/wEZKM3/y32oYBtMS8b0lbpUZW5yxZ4y9ZxwNQkfr
         GLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+X3RRqVMAFWzFiG8bOlA6agMfMr/xts6DAFOgovCf4=;
        b=B64d3Zm4eW4S9LEqx4KZ/uWReVOUEM/hKxcwAoSn0DqWJek3pdqqko2VkEb0ZFOEU3
         uo0Or3V9gaUUeVotaOF01tUPzWgU9YYOg9FGM3VAUcr4kFuCRFt3kmtVyRxTO3dzC6XL
         d2W1ouPpKEU4pp2XZsubEKeWvF6NIEoYE6pzmcup/uCbbUvReeKQw0vdxpVeasLUYONx
         Py66D34k95Oh9l7mJnmY1a/BdwyTs5UoGVNID1ydrljqHWurnSDwz3U8+LqKwqGVf1bZ
         jtXx6ssJcBcbbS+wpUjZ5KtU76yAHWwkT3OMgvzmF7dZ6idFsj4gqzLT+3cpiL9Cr5Is
         MHZQ==
X-Gm-Message-State: AOAM531Kndr2PGnrXvJuHJgarRKfytxcTlPSbMxUmBHhFNK3kU0vAcnX
        roCiN5m19RwTWua86uBql755sv15Lxl0zoC3dXE=
X-Google-Smtp-Source: ABdhPJy42PPbm+KO5MLNI28m5oZ+izDUecmCX+TSlGTpkOI3PIrrDzuMz7h98PQza+7LTvOwvEoMWYTXPrpMsLlcJck=
X-Received: by 2002:a05:6122:da7:: with SMTP id bc39mr2462108vkb.22.1635413698180;
 Thu, 28 Oct 2021 02:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635390750.git.siyanteng@loongson.cn> <112fea0c8c1b65a762ac98412216239160721263.1635390750.git.siyanteng@loongson.cn>
 <CAMhs-H9LUQ6Km=sA992LH=+E0MbGuMf9YhM6w2HoyeqE0QbzJQ@mail.gmail.com> <20211028092318.GA6574@alpha.franken.de>
In-Reply-To: <20211028092318.GA6574@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 28 Oct 2021 11:34:47 +0200
Message-ID: <CAMhs-H_m=pz4jU_cY-A6PRjR3OYy2zKH0=HN=vFDF2XOk60xBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] MIPS: cm/cpc: export some missing symbols to be
 able to use them from driver code
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Yanteng Si <siyanteng01@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yanteng Si <siyanteng@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        chenhuacai@kernel.org, sterlingteng@gmail.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Thu, Oct 28, 2021 at 11:24 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Thu, Oct 28, 2021 at 06:11:18AM +0200, Sergio Paracuellos wrote:
> > On Thu, Oct 28, 2021 at 6:05 AM Yanteng Si <siyanteng01@gmail.com> wrote:
> > >
> > > Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> > > the MT7621 PCIe host controller driver is built as a module but modpost complains once these
> > > drivers become modules.
> > >
> > > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > >
> > > Let's just export them.
> > >
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > ---
> > >  arch/mips/kernel/mips-cm.c  | 5 +++++
> > >  arch/mips/kernel/mips-cpc.c | 1 +
> > >  2 files changed, 6 insertions(+)
> > >
> >
> > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> could we instead make the pcie-mt761 driver non modular ? Exporting
> all MIPS specific stuff for just making an essential driver modular
> doesn't IMHO make much sense.

The driver is modular because I have been advised other times that new
drivers should be able to be compiled as modules and we should avoid
using 'bool' in Kconfig for new drivers. That's the only reason. I am
also always including as 'y' the driver since for me not having pci in
my boards has no sense... I am ok in changing Kconfig to be 'bool'
instead of 'tristate', but I don't know what should be the correct
thing to do in this case. Thoughts?

Best regards,
    Sergio Paracuellos

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
