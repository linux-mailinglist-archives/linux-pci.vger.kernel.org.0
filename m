Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F265624EA8F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Aug 2020 02:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgHWAc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Aug 2020 20:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHWAcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Aug 2020 20:32:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0DC061573;
        Sat, 22 Aug 2020 17:32:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s2so5268397ioo.2;
        Sat, 22 Aug 2020 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsZoxPoLhqbUeZj/RqXQMzdgBATwQI9M/taaTrFxrcI=;
        b=prB0m3ovlX+Tt7YUwdPANWpMeqw7MuVw7bYlxs+v5vW/Pqq3Y3oq/jsjGzDlefrxBd
         /forhKz6f3SZcNq0UOnmXJIOA1chkAe+tRp5n+fxP8sG/qX8DYITd6APtOEQfz4mpvTg
         hTXD8W6T3p3au+XfWxGcGs2/WEriqH+Bh6Drk/Tf3FecbPfXKcmC9HCfHK0NQW61KG+7
         8yPonEh8UTLOvY3AuEW/VnYHMpyQ3uP/DLpifZ9BMhrB1fFD3TpkYIWeeubcPbLkCixG
         DFAxS6S6fCBMWWgJaK+6UQjb/tBy/YcU0dkCAfu71XwRA7ptg+JO0ximpkpevMGF2ZDc
         gUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsZoxPoLhqbUeZj/RqXQMzdgBATwQI9M/taaTrFxrcI=;
        b=i35wiam6VoOLfM4a+ooHZP9HbIGgASqLvxMKX5U4w725qawwOkXKbrIt6wZl9Ul90H
         5tDDwFb1UXcFx+DvM0Itnx7Jdg5r/f5kVlmw6Z5YGdidSKXIiY/4PubqtyWWbJkVWJVb
         EnSagwOUuxOSPVuPJ6f0cekseRRB+Z9wIMrYoQyiZCEihziroBakrYy/wOa5y5HjEB0D
         CRXRMFS1CvRJDmSv3HSMvKcThO3oRUFDvoSebGYe9/DL02QJMROaonJVNvzabmp5aC5X
         hKxJFDZ8SjF3XxJnI0nhn1P7scBR0CMOD0fPT/yVeYEZYod9C+gVZVYa2Dw2+pP68DH/
         Pi8w==
X-Gm-Message-State: AOAM530P0zhjFhHhRcM1q+B4HJSp/rNOlDkUJhAgL/hMFuNM429Pw4yq
        0F/0pBJXWit0m1bY+Kpa7FpLZU8xaDFrdrskLnuvXKTtSWI=
X-Google-Smtp-Source: ABdhPJzzwaYlNUJ0FlaOId7Z0x9I2Pa+zPa/qWXmbhq/hdzbTohApMlq8N0UjiDH/QXpAExGFsND/3crvlUdV6wZ9Cw=
X-Received: by 2002:a6b:b292:: with SMTP id b140mr5342260iof.87.1598142773579;
 Sat, 22 Aug 2020 17:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200821205115.50333-1-shawn@anastas.io>
In-Reply-To: <20200821205115.50333-1-shawn@anastas.io>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Sun, 23 Aug 2020 10:32:42 +1000
Message-ID: <CAOSf1CGjm576cj3mqAqhp0xGE4P5F0ULNBPWxN44kmBLgUh4_A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pseries: Add pcibios_default_alignment implementation
To:     Shawn Anastasio <shawn@anastas.io>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 22, 2020 at 6:51 AM Shawn Anastasio <shawn@anastas.io> wrote:
>
> Implement pcibios_default_alignment for pseries so that
> resources are page-aligned. The main benefit of this is being
> able to map any resource from userspace via mechanisms like VFIO.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

That said, there's nothing power specific about this so we should
probably drop the pcibios hacks and fix the default alignment in the
PCI core.

> This is identical to powernv's implementation.
>
> Signed-off-by: Shawn Anastasio <shawn@anastas.io>
> ---
>  arch/powerpc/platforms/pseries/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 911534b89c85..6d922c096354 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -210,6 +210,11 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
>  }
>  #endif
>
> +static resource_size_t pseries_pcibios_default_alignment(void)
> +{
> +       return PAGE_SIZE;
> +}
> +
>  static void __init pSeries_request_regions(void)
>  {
>         if (!isa_io_base)
> @@ -231,6 +236,8 @@ void __init pSeries_final_fixup(void)
>
>         eeh_show_enabled();
>
> +       ppc_md.pcibios_default_alignment = pseries_pcibios_default_alignment;
> +
>  #ifdef CONFIG_PCI_IOV
>         ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
>         ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
> --
> 2.28.0
>
