Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0E43D90B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 03:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhJ1CBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 22:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhJ1CBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 22:01:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7461EC061570;
        Wed, 27 Oct 2021 18:58:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id g125so6149447oif.9;
        Wed, 27 Oct 2021 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7jA9hLIHv4laXHxexzSur1ceGmoR/SqF1PV4WEQNyWQ=;
        b=Z54xrm2gRnEUeTcTgy6Nkyf1v5dmkb0fpPRP2+0t1b699lLzBQS98XejaLKV5HKgRm
         H+f9/M1tAKy2S18OKxIGr2MbpPORPo5JIqUemrOPxZAKC/DcNypewcVe3VA5n9Wwhy7I
         5rqSsOtVDqFdYsMUpcUfa9XA1Vg1RTSNdqUPAUpaj5l8HCvm23MnLkhV2S32ODoBRXNa
         uhr3jtIr0ljqaNLH3c3HIZ3qoUfSFO8Ev4AI31BgJcwH6KC8baGgm/0nvd57THdQNwAa
         RUgvVWzHCVAzbz4tJ2mJD8HoCRSSJL2FjiNuxU9CVbqnWtmrSq3TsrNOAqKI4IYJ+ipf
         PIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jA9hLIHv4laXHxexzSur1ceGmoR/SqF1PV4WEQNyWQ=;
        b=Pg7F2cFkCIrBbE46iKzNWwUyTs1lO+5N2FuZ6T7dVGMp7EgY/UpTDypAlWnyQqgF7z
         FWlJifS+cB8/gKsrXS4+BE0dcTCrXz90BYzOxPy7HptPxAq0gq5//16I1u+YGhwUm+05
         QQS+MEHnEfZU9FBaTeoObDVSlAcwS6yWnt+bDekuRsfbJIFa/dxFRynGpk0I4P19u4KR
         3tMZIJi1Gvai1nV+43gLKAjcWf0nYQmh7NVNXkm0/W6uSyy0aPi2M/86HfcoTsXfYbFr
         ddM6itODOuFpLdx9pNBn3dUEdsByeDZvLs5stVhK98Z5Qc8hln+v94ZXUJ57E4PSsSx8
         bmxw==
X-Gm-Message-State: AOAM533PZfr6iHAgoXgEcwu4g5mZSx5NRU8OmVpolPiOyD87UooNsmV/
        CHilTg7TqOr8sJcpa05DvSgWYv9mdIh2azNQ7dg=
X-Google-Smtp-Source: ABdhPJzc4Eg531WD9FCIFPO/5/Z8QggwFWCwun14/4nZpu/HeSctOteECf6GvkujIih+6j1+vvTExofrv8BRz9dLyzo=
X-Received: by 2002:a05:6808:f13:: with SMTP id m19mr6332500oiw.37.1635386324816;
 Wed, 27 Oct 2021 18:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635333327.git.siyanteng@loongson.cn> <abead7ae64e1a0cc96a09647a5facf30d03381aa.1635333327.git.siyanteng@loongson.cn>
 <CAMhs-H8m0Un+njhw0nZKUrxzMxqfpj8YwGb==7GAoV=Kq-ey=w@mail.gmail.com>
In-Reply-To: <CAMhs-H8m0Un+njhw0nZKUrxzMxqfpj8YwGb==7GAoV=Kq-ey=w@mail.gmail.com>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Thu, 28 Oct 2021 09:58:32 +0800
Message-ID: <CAEensMx+veP1rWUQ0XZkOjveHU9P+2L_RXGBTc_YtOg0YN6-jA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mt7621: Export mips_cm/cpc/gcr_* to modules
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        sterling <sterlingteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sergio Paracuellos <sergio.paracuellos@gmail.com> =E4=BA=8E2021=E5=B9=B410=
=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:45=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Wed, Oct 27, 2021 at 1:32 PM Yanteng Si <siyanteng01@gmail.com> wrote:
> >
> > modpost complains once these drivers become modules.
> >
> > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7=
621.ko] undefined!
> > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko]=
 undefined!
> > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt762=
1.ko] undefined!
> > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] =
undefined!
> > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko]=
 undefined!
> >
> > Let's just export them.
> >
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  arch/mips/kernel/mips-cm.c  | 5 +++++
> >  arch/mips/kernel/mips-cpc.c | 1 +
> >  2 files changed, 6 insertions(+)
>
> This PATCH has the prefix "PCI: mt7621: " but the changes here are all
> mips kernel things. So I guess it is better to have "MIPS: cm/cpc:
> export some missing symbols to be able to use them from driver code"
OK,Thanks!
> or something similar. I am not the best with words :).
Me too. >_<
>
> >
> > diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
> > index 90f1c3df1f0e..b07f20323132 100644
> > --- a/arch/mips/kernel/mips-cm.c
> > +++ b/arch/mips/kernel/mips-cm.c
> > @@ -12,8 +12,11 @@
> >  #include <asm/mipsregs.h>
> >
> >  void __iomem *mips_gcr_base;
> > +EXPORT_SYMBOL(mips_gcr_base);
>
> EXPORT_SYMBOL_GPL?
OK. Thanks!
>
> > +
> >  void __iomem *mips_cm_l2sync_base;
> >  int mips_cm_is64;
> > +EXPORT_SYMBOL(mips_cm_is64);
> >
> >  static char *cm2_tr[8] =3D {
> >         "mem",  "gcr",  "gic",  "mmio",
> > @@ -353,6 +356,7 @@ void mips_cm_lock_other(unsigned int cluster, unsig=
ned int core,
> >          */
> >         mb();
> >  }
> > +EXPORT_SYMBOL(mips_cm_lock_other);
>
> ditto.
OK. Thanks!
>
> >
> >  void mips_cm_unlock_other(void)
> >  {
> > @@ -369,6 +373,7 @@ void mips_cm_unlock_other(void)
> >
> >         preempt_enable();
> >  }
> > +EXPORT_SYMBOL(mips_cm_unlock_other);
>
> ditto.
OK. Thanks!
>
> >
> >  void mips_cm_error_report(void)
> >  {
> > diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> > index 8d2535123f11..dfd3d58fd412 100644
> > --- a/arch/mips/kernel/mips-cpc.c
> > +++ b/arch/mips/kernel/mips-cpc.c
> > @@ -13,6 +13,7 @@
> >  #include <asm/mips-cps.h>
> >
> >  void __iomem *mips_cpc_base;
> > +EXPORT_SYMBOL(mips_cpc_base);
>
> ditto.
OK. Thanks!

Thanks,
yanteng
>
> >
> >  static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
> >
> > --
> > 2.27.0
> >
>
> Thanks,
>     Sergio Paracuellos
