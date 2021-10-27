Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B033843C8D0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbhJ0LsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbhJ0LsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 07:48:13 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2956C061570;
        Wed, 27 Oct 2021 04:45:47 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id s4so4452980uaq.0;
        Wed, 27 Oct 2021 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQ6LftHs89BQpJKHjqVHxlnnH+4o6qbz+LFIxq6yG6E=;
        b=ogUDxO10xvloKPC+Hf85j94Qvm8ogBBD8/yv+VRUY97lCpB7EzHnFE+dcSM5TyFbm5
         gBWTouwmM401vrqLC3opOT3tpprKbV+GGSckO77pq41779sZCYpDvvxN/8xisVErcpUe
         3C0b/WCr5GfvddDU8yxq9d1nMfndDwrZ8OTK3ykFRik3WUrrr54+j77lY5Xn4V5JArlZ
         N8vwllzP4SjDc4DC/h1faJDScDug8sVAFRK/c4dfBGtrC15eCQJz6595orcEFIlYjPIX
         2GZeg2s5YfOdQo8urEwl5bKFJ8TYdFIkJFGgabGhsENGZPgxqKXnDlB45uQXb8PuOEmY
         EHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQ6LftHs89BQpJKHjqVHxlnnH+4o6qbz+LFIxq6yG6E=;
        b=Hrfh7joHVL+ukAZSM4DBBaD445AVDCCDShuiY5efPufnZOXztrhzbFA0CaR3BVS+dy
         qg8aYSOMUv0bAKwPwHnA/j86fBPQFmQaoTsfDbFfUoIBb9fkSvEmQ6vwU/FZnTOv/ovi
         RfiBMqj2GHfAr5qNns/vbX3+uoM1bvccntCyv2AnSHxy6lXfZkLcYTs8U9uZyKtuchjU
         +dUDs2U73ASnBdweg2xWGbUvIxkhU3N1s64GNrZsAX2tqJAAsSAXU76eYhYW+jtRoWjV
         BaELVpAJPnmrm6Y0s99lL7BvfpFleEHYSvdbPWqRotvnV+tA9I63MHpJPB1xFcWFX69g
         DxDA==
X-Gm-Message-State: AOAM5303pjfEGe/FlLEMxtJ1ZL6hp5mvFaUkvWKlhK+GjfNi9GRPu6HO
        xNI9+UJgiwZIOfWbMmnLU1Isbf7ITEfQWwFN3NI=
X-Google-Smtp-Source: ABdhPJz8JZLMiE3Wa18RA9pq8ebQfYTD7R+/tz/wvKkGhoLOLkXcVBwDI35Jn6X+cOkDX47JtQW57uxDGsRhExn06wY=
X-Received: by 2002:a67:ec57:: with SMTP id z23mr20876881vso.55.1635335147100;
 Wed, 27 Oct 2021 04:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635333327.git.siyanteng@loongson.cn> <abead7ae64e1a0cc96a09647a5facf30d03381aa.1635333327.git.siyanteng@loongson.cn>
In-Reply-To: <abead7ae64e1a0cc96a09647a5facf30d03381aa.1635333327.git.siyanteng@loongson.cn>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 27 Oct 2021 13:45:35 +0200
Message-ID: <CAMhs-H8m0Un+njhw0nZKUrxzMxqfpj8YwGb==7GAoV=Kq-ey=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mt7621: Export mips_cm/cpc/gcr_* to modules
To:     Yanteng Si <siyanteng01@gmail.com>
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
        chenhuacai@kernel.org, sterlingteng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Oct 27, 2021 at 1:32 PM Yanteng Si <siyanteng01@gmail.com> wrote:
>
> modpost complains once these drivers become modules.
>
> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>
> Let's just export them.
>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  arch/mips/kernel/mips-cm.c  | 5 +++++
>  arch/mips/kernel/mips-cpc.c | 1 +
>  2 files changed, 6 insertions(+)

This PATCH has the prefix "PCI: mt7621: " but the changes here are all
mips kernel things. So I guess it is better to have "MIPS: cm/cpc:
export some missing symbols to be able to use them from driver code"
or something similar. I am not the best with words :).

>
> diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
> index 90f1c3df1f0e..b07f20323132 100644
> --- a/arch/mips/kernel/mips-cm.c
> +++ b/arch/mips/kernel/mips-cm.c
> @@ -12,8 +12,11 @@
>  #include <asm/mipsregs.h>
>
>  void __iomem *mips_gcr_base;
> +EXPORT_SYMBOL(mips_gcr_base);

EXPORT_SYMBOL_GPL?

> +
>  void __iomem *mips_cm_l2sync_base;
>  int mips_cm_is64;
> +EXPORT_SYMBOL(mips_cm_is64);
>
>  static char *cm2_tr[8] = {
>         "mem",  "gcr",  "gic",  "mmio",
> @@ -353,6 +356,7 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
>          */
>         mb();
>  }
> +EXPORT_SYMBOL(mips_cm_lock_other);

ditto.

>
>  void mips_cm_unlock_other(void)
>  {
> @@ -369,6 +373,7 @@ void mips_cm_unlock_other(void)
>
>         preempt_enable();
>  }
> +EXPORT_SYMBOL(mips_cm_unlock_other);

ditto.

>
>  void mips_cm_error_report(void)
>  {
> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> index 8d2535123f11..dfd3d58fd412 100644
> --- a/arch/mips/kernel/mips-cpc.c
> +++ b/arch/mips/kernel/mips-cpc.c
> @@ -13,6 +13,7 @@
>  #include <asm/mips-cps.h>
>
>  void __iomem *mips_cpc_base;
> +EXPORT_SYMBOL(mips_cpc_base);

ditto.

>
>  static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
>
> --
> 2.27.0
>

Thanks,
    Sergio Paracuellos
