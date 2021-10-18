Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05503431765
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 13:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJRLe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 07:34:56 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:45895 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRLez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 07:34:55 -0400
Received: by mail-ua1-f45.google.com with SMTP id a17so1378710uax.12;
        Mon, 18 Oct 2021 04:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0ObgRrATtrPSK/G4VV3LCyZwiCeoUzdzpzXNcktwlM=;
        b=OPhI2GQUOUf/z6GJ0EyL7zohIqlYAVyq+fBJduNp9Z6Ksc6QUNEmDcYAG3zg0gQGWc
         ycTgb2uIoJgOZGB3B+lZ70PuMxpoqbUZZxR56V0QZYYL8dZ1+meUPqDWasbR40xl8BAy
         xsqGtS6AsWt+0eWLJm3FylMWQPSlVL4YMtYCA8bp/z2BpbUDIIomk4MHMdeCHPc5d9w5
         O32ThN6h/wJZFJSfZRtLiWdM49LeZ3F7r2OUOtDu8oXwZ2u4n6jxoBSysEINVYmsA2BV
         WvdMFy5Gbz5oKUWF04HMU/C0Bjk2GnU83qN7MEevFnUZ7NMDLM19HNtQWS2HJDltKCPg
         JIiQ==
X-Gm-Message-State: AOAM5329s8tHM17sJrZeR6qmRbhlMQNe9TGvYjkTFHNURM+TvDMGABXR
        GwtKhcza1XSVwTb8jzV9cHJb591q598lBw==
X-Google-Smtp-Source: ABdhPJxpuWLTNTjDJUNeXSEF5hgcFu5tSKuC/aiMdGy4Z316nwX2zg697Padya+s82NkljAxaR8QXw==
X-Received: by 2002:ab0:6546:: with SMTP id x6mr24460407uap.1.1634556764247;
        Mon, 18 Oct 2021 04:32:44 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id w8sm8845280vkh.36.2021.10.18.04.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 04:32:43 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id f4so5100184uad.4;
        Mon, 18 Oct 2021 04:32:43 -0700 (PDT)
X-Received: by 2002:a67:d583:: with SMTP id m3mr26629786vsj.41.1634556763010;
 Mon, 18 Oct 2021 04:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634306198.git.naveennaidu479@gmail.com> <2544a93bf8725eecbea510e7ddbff6b5a5593c84.1634306198.git.naveennaidu479@gmail.com>
In-Reply-To: <2544a93bf8725eecbea510e7ddbff6b5a5593c84.1634306198.git.naveennaidu479@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Oct 2021 13:32:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVh79gvAZn+nBeWWtkJqvUb3woi1rRY=BkY+bc4YXFj1Q@mail.gmail.com>
Message-ID: <CAMuHMdVh79gvAZn+nBeWWtkJqvUb3woi1rRY=BkY+bc4YXFj1Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] PCI: rcar: Remove redundant error fabrication
 when device read fails
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:PCI DRIVER FOR RENESAS R-CAR" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Naveen,

On Sat, Oct 16, 2021 at 5:33 PM Naveen Naidu <naveennaidu479@gmail.com> wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error. There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
>
> The host controller drivers sets the error response values (~0) and
> returns an error when faulty hardware read occurs. But the error
> response value (~0) is already being set in PCI_OP_READ and
> PCI_USER_READ_CONFIG whenever a read by host controller driver fails.
>
> Thus, it's no longer necessary for the host controller drivers to
> fabricate any error response.
>
> This helps unify PCI error response checking and make error check
> consistent and easier to find.
>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -161,10 +161,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
>
>         ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
>                                       bus, devfn, where, val);
> -       if (ret != PCIBIOS_SUCCESSFUL) {
> -               *val = 0xffffffff;

I don't see the behavior you describe in PCI_OP_READ(), so dropping
this will lead to returning an uninitialized value?

> +       if (ret != PCIBIOS_SUCCESSFUL)
>                 return ret;
> -       }
>
>         if (size == 1)
>                 *val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
