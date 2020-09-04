Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229E925D82B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIDL63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 07:58:29 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38531 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDL62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 07:58:28 -0400
Received: by mail-oo1-f68.google.com with SMTP id r10so117670oor.5;
        Fri, 04 Sep 2020 04:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9tCEIkRGQnaztUyMojleGF3hkNEd1n8iupS20opO6o=;
        b=h5oN929J5JNGRTmPlSOxYO2B454CW6n4f700rAoCQVTdg+LLTeCqWO00QnTKg7SzUl
         GoS9HjRgZSOjABC7ccfRPJ6N8WjCy6mz+BGKampDbVIwpi9SL72qQAiJJnb4WutrVf7r
         YUBAX0FSS/qmK5fimEHLJoJYxFx+DVx8/Sdehs9UGv8dRXvWCLW/fqHqLz71BKXasksA
         NcrKD8XlA8vw4RjuqsOvUFZEFys9KI4yEiQc9KD3R3hDLst3MBEl4y7Zarskz7phidqt
         7il3I1YtrG4A1T8+9uRL6oXPV4jRvKJssqSY3WFznLNlhipJ7VEhqoWUCBeac9Xbf6nf
         BsIQ==
X-Gm-Message-State: AOAM532sArEUnlkrWFm0DB5sH98CWQVW/yzzdOCz28naBdhHrNww0uwo
        PKg3xHQ7fdykQBwrEVlrkciyYDMr4eRPYx1e40E=
X-Google-Smtp-Source: ABdhPJyIzaQmNZ7IdOnSLRQ7vsc5EVSjIxYs25WB+EnmqwRm8oqhovoYW7RqbPoq1qtt2EAxQHHzr+4JEP/OmKaFHZ0=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr5484812ooj.1.1599220707324;
 Fri, 04 Sep 2020 04:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200904103851.3946-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200904103851.3946-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Sep 2020 13:58:16 +0200
Message-ID: <CAMuHMdWuQzPAPi46FEF2yzQww=6rbX469fQFm3X0XaGnBSzfMQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] misc: pci_endpoint_test: Add Device ID for RZ/G2H
 PCIe controller
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
> Add Renesas R8A774E1 in pci_device_id table so that pci-epf-test
> can be used for testing PCIe EP on RZ/G2H.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
