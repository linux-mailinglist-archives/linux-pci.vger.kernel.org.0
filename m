Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3A19D225
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbgDCI20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 04:28:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33035 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389015AbgDCI20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2020 04:28:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id m14so5455032oic.0;
        Fri, 03 Apr 2020 01:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd71ZkzudxX5g2IyvVUOYdKyHi8OFqEjn6IvsJ3wV7k=;
        b=FptaELtUqZtw2PU+tc3+NF2788XDhVfr2VIIe/2V4QAciH24UopAEvzEfFTk/eMdr0
         KK/bH8IlvDlRvFlCFXPsGiRlA/hSkE2w5OtvxkMdZHMNIERNp89MWsiIAJA2VmdcXoe0
         ltumbPd00FeL8SIWehhKXlPqxNa8Xa/nGbJBnbEqx15TEWLKO5PbN/Ah1PvmwVIpuDW/
         qpyf1Az7WlIF/EcBQWWZlhK6KZ7Rv8PVaR9Mru0mJZDROQwD4npZKPiNSCghc4nsZSbU
         WAFKIioIP8XG8tZQUQ37UB3Ue+j4/8lXhRQK+ITWCjXfzdhRUMh4YNwkg4ogzTorSu0b
         gRXQ==
X-Gm-Message-State: AGi0PubH7hqbi2eLKTJiwBMHgXhLZ2t5EbB/p+TopymSgWJx8ZrALXP3
        lelfEc20rHbEF5+UXWZS5KqygYsQa28o31HrWi8=
X-Google-Smtp-Source: APiQypIS6fpMGxM4Q7dZQ7e1YsUy6vcUkIWwvKfW8MQ2oAPzqQO4S5tcl4AqLxJx41ERvItQuVYYFJJlh5Wv+BynmHU=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr2041353oig.153.1585902505654;
 Fri, 03 Apr 2020 01:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <TYAPR01MB454403D69A74036B74CC8220D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB454403D69A74036B74CC8220D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Apr 2020 10:28:13 +0200
Message-ID: <CAMuHMdVWn=U82k5RJnBaRUgRHh3bRfdncOupmX67-u-nbwsG9w@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] arm64: defconfig: enable CONFIG_PCIE_RCAR_HOST
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Fri, Apr 3, 2020 at 10:03 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:39 AM
> >
> > config option PCIE_RCAR internally selects PCIE_RCAR_HOST which builds the
> > same driver. So this patch renames CONFIG_PCIE_RCAR to
> > CONFIG_PCIE_RCAR_HOST so that PCIE_RCAR can be safely dropped from Kconfig
> > file.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thank you for the patch!
>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> But, I'm thinking this patch (and patch 03/11) should be separated
> from this patch series for arm64 subsystem to ease maintenance.
> My scenario is:
>  1) patch series 1: R-Car PCIe endpoint support.
>  -- This means: patch 1, 4 - 9, 11
>
>  2) After the patch series 1 is merged, submit this patch 2/11 to arm subsystem
>    and submit the patch 10/11 to misc subsystem.
>
>  3) At last, submit patch 3/11 after the patch 2/11 is merged.
>
> Geert-san, what do you think?

Thanks, I agree with your summary.

I can take patch 2/11 through renesas-devel.
Probably it's best if I submit it to arm-soc as a fix for v5.8, after
the driver part
has been merged into v5.8-rc1, so 3/11 can be submitted for v5.9.

BTW, I'm wondering about "[PATCH v6 05/11] PCI: rcar: Fix calculating
mask for PCIEPAMR register". Can the issue fixed by this patch happen with
the current driver in host mode, or is that limited to ep mode?
In case of the former, please submit it to the PCI maintainer as a separate
fix.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
