Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872A424D4DF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHUMWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 08:22:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35992 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHUMWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 08:22:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id x24so1417151otp.3;
        Fri, 21 Aug 2020 05:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3Cty3iDMhmI0uvrBWWtrlYDNSJRFMglnzj/pu0/3wk=;
        b=ZTTPLhK4P8/GbUPDmldztluU5rSWDINTVesb+HsERp2YghoZgJkxWHZKObHZaQd/Dk
         dpXP2nIqQy/Fp/kYC2bmS0xpY6urbsT9l1xHKIdd6zqvFE55HiXyLwcS2wpNjqCiQ341
         6CQ5ckpFScy9eoZM7+CJc1afjrflCjTBuayt3+TLkTQzweGjlvyGJEznUNOHzErGxCVG
         n4t6A1B0zxoPGqDvYVfgZeR/gGMRdszQuJI7LwYLKymrgOGbBeqJ7a71V26MUhJRr96L
         V4Su7NPUssO2IVQ+DNM5a4ABdEc2GAn88OflT1K5vEnKMVTANVWUUrXSpx1aLkkx1ty0
         KN3w==
X-Gm-Message-State: AOAM532hfW8xROOXAjk47vD/71+37IImb+fcPuzyKIWF64smtNbTZySq
        7isafbMkoYu9Idm35JMUs86L027DIJz09L5ZecY=
X-Google-Smtp-Source: ABdhPJz335LYEtU3qA3RAE7Q/2Bs2XPPn6AvJ6wW0UmyVT4uzHNSWs1F6pT0PADuguTj8fHA6jFZByti9tHIPjQyBBM=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr1590236ote.107.1598012531780;
 Fri, 21 Aug 2020 05:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200814173037.17822-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200814173037.17822-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Aug 2020 14:22:00 +0200
Message-ID: <CAMuHMdWr1METtxzQ3FXG+hqKbykAXUdqwH14HV6+141dEPqnbw@mail.gmail.com>
Subject: Re: [PATCH 2/5] misc: pci_endpoint_test: Add Device ID for RZ/G2M and
 RZ/G2N PCIe controllers
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 7:33 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add Renesas R8A774A1 and R8A774B1 in pci_device_id table so that
> pci-epf-test can be used for testing PCIe EP on RZ/G2M and RZ/G2N.
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
