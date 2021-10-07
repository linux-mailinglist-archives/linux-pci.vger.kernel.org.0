Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8628C42526D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbhJGMFe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbhJGMFd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 08:05:33 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F44C061746;
        Thu,  7 Oct 2021 05:03:40 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id f3so534588uap.6;
        Thu, 07 Oct 2021 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVcDs6bbL2O9asL/kMqUU5jJQKNfK27/hmjb5hU6Yr0=;
        b=DRNSKqR02DK/oG0s2OJi8uaXxbvdNBKaaVId+HcLS3ox/9AIJyH4bslaMHlbL/S/wy
         JmALCpu9S27iezO7HbVMwe9ZDVjfHUhqhi2b4wXCX6p7wguNgsWLdgnx95ue9bGeEhgc
         IsWVtutYqWZ9uCUIYqE4h653LwArJGzp5yKNd4BBgnWnf3vXHrn3LHgT0d9z02MChJ0o
         AazurHlOPVYaxg0WIdAykgVqrM8S3N0Og7C15vqIoimdMcyq8k29AYXoM1IXh7PDzn7X
         BXTD4qL4PNzrUL2ywVG9vk2Ou8d2DWQs9YugYALGTKL5oj7Xerw+66eJSvWe/y7HWkMZ
         tTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVcDs6bbL2O9asL/kMqUU5jJQKNfK27/hmjb5hU6Yr0=;
        b=iccuM+6FvpMq3yuPqtYJhmVysAnGqC7cpKV+6+r/2miIzESD6+pylquiT401myJ1sI
         gV49nh/3t91Z4qBcKeKouHiCyUoq06dH8CHiahjMJTkEMyJOrITBzB3bMi4cpZ1qeuyS
         WaGouU0jlYUF5uwTeJvm1PAVx81C0W9P4c21rIONpJZV+V/fDB0fxWPFkGzx1+yDkiuL
         05seDaCCk5lrUX7C43UzN0ONiJrbrDM9XhoAQxjPb/MKG2B9ZOiHzXda/4qZnOAZV07J
         o+YRj4/+zg6NHJ4e5I+pijPSZr870sNZ7GRXslZSgNOUkxcwlMqpVjbqdws+HKWLJe18
         PTaw==
X-Gm-Message-State: AOAM530OxVedJ6bzn4GcJzoeTrgLrqYDlO6Tu4tfzhWEe+6nkGPM/z1r
        GpI2v6EYM7s08W52memV3RWPfedX46jQ7IXHPCUDzJ8tjQ==
X-Google-Smtp-Source: ABdhPJwPOFXY4auLpePQoUCQ/QHcz1sLbVtPsumuTPpOZbkJFhn2hDxDQ5FS62P38SCaY54PspTqCF+rWn3OOgY4NFo=
X-Received: by 2002:ab0:5b17:: with SMTP id u23mr3765044uae.18.1633608219344;
 Thu, 07 Oct 2021 05:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <87ee8yquyi.wl-maz@kernel.org> <CALjTZvakX8Hz+ow3UeAuQiicVXtbkXEDFnHU-+n8Ts6i1LRyHQ@mail.gmail.com>
 <87bl41qkrh.wl-maz@kernel.org>
In-Reply-To: <87bl41qkrh.wl-maz@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 7 Oct 2021 13:03:28 +0100
Message-ID: <CALjTZvbsvsD6abpw0H5D4ngUXPrgM2mDV0DX5BQi0z8cd-yxzA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi again, Marc,

On Thu, 7 Oct 2021 at 09:52, Marc Zyngier <maz@kernel.org> wrote:
>
[snipped]
>
> I guess this is the relevant device?

Pretty much, yes.

> It is interesting that it
> advertises not supporting interrupt masking... Can you, you, out of
> curiosity, give the following hack a go? I would expect things to
> behave badly too (and maybe be even worse). But one way or another, it
> may give us a hint.
>
> Thanks,
>
>         M.
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0099a00af361..b3c0b9d07f17 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -205,7 +205,7 @@ static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
>
>         if (desc->msi_attrib.is_msix)
>                 pci_msix_mask(desc);
> -       else if (desc->msi_attrib.maskbit)
> +       else //if (desc->msi_attrib.maskbit)
>                 pci_msi_mask(desc, mask);
>  }
>
> @@ -216,7 +216,7 @@ static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
>
>         if (desc->msi_attrib.is_msix)
>                 pci_msix_unmask(desc);
> -       else if (desc->msi_attrib.maskbit)
> +       else //if (desc->msi_attrib.maskbit)
>                 pci_msi_unmask(desc, mask);
>  }

Hm. You belive the controller is lying? :) Sure thing, I'll give it a
spin and let you know the result.

Thanks,
Rui
