Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4238C25D856
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgIDMDm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 08:03:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34961 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgIDMCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 08:02:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id i4so5649024ota.2;
        Fri, 04 Sep 2020 05:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ukvd//aAW110cXpWs2S4slyQ27lJWEeHAGcDPXmvUPg=;
        b=kyELYHHcqKSspFHozuvy6XiCK/1OYXt2aqDpfVVV9Mo7vmx26gf/SV/V6POuAb4TcW
         6eOqi2/jHHkme08NqY3wW0iRTFcQuFY2xAJpLZt51HHUiWoYJMYaEl/Fap5Icr5zsMr6
         /0D1K8gfvVM4rwa+sz9jL/hcV0zKU5hyMuOonCP/JolqNsClE6pv2xRnyfJ59HF9B7k2
         ar97ujD7ZIEl+9hR5kSw9iPjNuZBiAQL2M2lCcKDIul9GTPrr0ITZOIfvVWpGzCuwcsg
         FEclf0dRJrSwd/FI4gZuKSP9GyzhNGO6HWuRg7QBfrGuyCyLczmTNXW88Z7o8mu2UXa1
         0TNQ==
X-Gm-Message-State: AOAM533+vA1b/5nhtJpFS6z5Q/70EMXae9GM5t59RNzUgvJdrcHUNva7
        N5ICrFeQMoiPCgT/95csaujiTibUisRKqMqnMPw=
X-Google-Smtp-Source: ABdhPJwZ4Cx5KfC2gKhC3iG2JjMNxBPWddp4GhRs/zydiWXuSmWwiH5W/NIzx+jZsINXrGzQLm6wW/3PB9DqBnC+KoI=
X-Received: by 2002:a9d:162:: with SMTP id 89mr5264289otu.250.1599220973051;
 Fri, 04 Sep 2020 05:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200904103851.3946-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200904103851.3946-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Sep 2020 14:02:41 +0200
Message-ID: <CAMuHMdVXOZ8AYiocxs-v6cHz10-47OTArU45915SJAK3rz93Lg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774e1: Add PCIe EP nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
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
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 4, 2020 at 12:40 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add PCIe EP nodes for R8A774E1 Soc dtsi.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
