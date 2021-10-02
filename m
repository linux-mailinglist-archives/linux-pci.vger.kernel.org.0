Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0447941FDAF
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhJBSYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 14:24:12 -0400
Received: from mail-vk1-f177.google.com ([209.85.221.177]:45045 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhJBSYL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 14:24:11 -0400
Received: by mail-vk1-f177.google.com with SMTP id s137so5859385vke.11;
        Sat, 02 Oct 2021 11:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgYFGECkMM3zfEo/dmg94OtbjIf3E69UNOzLv03h1qA=;
        b=T/dyIT/XHU94TgTYTSir394gp6q/jqpwfQnOP+4z4oiHlCSyIblQ25zk5GaISzFpPr
         /KoLBzO4wNvSxGh1W3yNa/pN5OaYV6dsF4XBFigpWK9q6xXVrmhueeOl8/ZiVArC3vL8
         GjxBPfgJ2WDIgTXy4eaDaKaX94NkPmsGcKCtsFzc8EFssBvG4ul152H2ATffJCFum53o
         WVl9ChgNGLgpS7pBVcPF5AbcokZKwsqeRuoWmNIZ1QxyqhIunARTs5FkFZwtLSkxT5hy
         sdUIQblb/hQMLEgaayzvws3aDwhM2kYVUfa7uNYfDppsVRJ1vKpXHkZ7uWoWq47Aqb5k
         K4iA==
X-Gm-Message-State: AOAM531leYad/5tkBoFz8x8BRNaNjfJavNRYSmRJF6wsNTFiu+zfbgzb
        4oHs+7lCvJvDisleLJiCUqSP+F1uCfLtFF/FwYI=
X-Google-Smtp-Source: ABdhPJwqppFP1oPDH04cVBPOsVKlnib0ULpmK2lW3bGkaEcAWvDIGAYuMcSdEBUyIimD9yIK2tzAJAac+qOEHmZXaAE=
X-Received: by 2002:a1f:230c:: with SMTP id j12mr11783798vkj.11.1633198944857;
 Sat, 02 Oct 2021 11:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <54bed9a0e6991490ddb2b07e5abfaf40a7a62928.1633090577.git.geert+renesas@glider.be>
 <20211002155953.GA971127@bhelgaas>
In-Reply-To: <20211002155953.GA971127@bhelgaas>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 2 Oct 2021 20:22:13 +0200
Message-ID: <CAMuHMdVRqW=v+AKsXKJkm7d_DUubF_zn3tRq560S9m5996PrHw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-host: Remove unneeded includes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Sat, Oct 2, 2021 at 6:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Seems overkill to mention "rcar" and "pci" twice in the subject.  We
> have so far not distinguished pcie-rcar-host.c and pcie-rcar-ep.c in
> subject lines.
>
> If we want to start doing that consistently, maybe we could use "PCI:
> rcar-host:" and "PCI: rcar-ep:" as we have done for cadence-ep and
> designware-ep.

I know.  But this is for PCIe, and there's also pci-rcar-gen2 for traditional
PCI.

> On Fri, Oct 01, 2021 at 02:16:43PM +0200, Geert Uytterhoeven wrote:
> > Remove includes that are not needed, to speed up (re)compilation.
> > ...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
