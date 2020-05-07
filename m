Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE31C986B
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 19:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgEGRyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGRyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 13:54:15 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0BC05BD43;
        Thu,  7 May 2020 10:54:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j4so5251031otr.11;
        Thu, 07 May 2020 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9qTr+beRcohA6PMx27iJvmErOKyI82EyxD1O5Dcxzk=;
        b=SVsD6C63OiLwNbOKAQM5ZFhQakJf5wmETFQL9x+dixJ/i776z1xlYBs4MsH37nM2Q/
         rN20lR9IsgpWIANGiiWVwGlmETI6MlQhpuSRDvTmx+GG6KHHYSzcUoNVSnvvH7krGkvj
         Q43/nk2XB+fPJ3E2IE3bqXw22a9vnsjtN/mdP8+cPQfVIfxvSJy+aNEnvd9ILL9vOdUm
         5La8QEzc3kfhqomZWhA2DoXxQkPpXhtMplOVm0qU37uRCu8S1TmTFKpmv5czDR9NGbtZ
         LigoAd2EISFD3oT6dUZbKvD8dcwnV4wuzzivD++70wK7jNSwQiHi++7UHGS5HfwfnQvw
         i8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9qTr+beRcohA6PMx27iJvmErOKyI82EyxD1O5Dcxzk=;
        b=G9m6oJDPdsYQwsyjqIiEcbGEwadzh8pSK285cM5/i2m32cM94R7vVBL3hRU1GHPwa7
         7x2XsPU1eT42HHNa5rJGMOUW6mLT0YdwcqODSppeeht1q92d2hm1Zfbk2t6Pezuf7igr
         EaEV8OqW+0sx1RxGm3154UbOcEhIJiv1CfqJVL4bqS9k9oH06ux1kmqNcURknanu0PAn
         pcjmL0VoaaMUjyp7G3XM6ZsUbTT+cI7ToScznZM6f8hwJBK2gJNZWQBXioX49d5l1ZxJ
         ZFC94Y+ds0RvMFIKT1DxWYLdIxZ8HJfYwQMLbRKkp5q7HnQpx++7ythAtXri84h2lQ3J
         lYlw==
X-Gm-Message-State: AGi0PuZ9ITIij31wB+e6EtZtr/gZuIodbQRmN+pz5QHffOVd4e0ggIWs
        IM7ZzqXd9axnNkMEWb4AlA+aVvs9+4AV6N9uw0o=
X-Google-Smtp-Source: APiQypIsmJ2T5664lpXTF/RWS8/eux+ZnXoiFN88OHtyHhUrSboY+wgSVo2JHDzVRl08o0T/GlQRWx6bo0sL6qxy4RY=
X-Received: by 2002:a05:6830:108b:: with SMTP id y11mr11230755oto.88.1588874053316;
 Thu, 07 May 2020 10:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200507174446.GC1216@bug>
In-Reply-To: <20200507174446.GC1216@bug>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 May 2020 18:53:46 +0100
Message-ID: <CA+V-a8u00kfN=rNs72y-R4-8fpz4rPYX8xf+DoBMmYYVjUS8fg@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Add endpoint driver for R-Car PCIe controller
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pavel,

On Thu, May 7, 2020 at 6:44 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
>
> > R-Car/RZ-G2x SoC's, this also extends the epf framework to handle multiple windows
> > supported by the controller for mapping PCI address locally.
> >
> > Note:
> > The cadence/rockchip/designware endpoint drivers are build tested only.
> >
> > Changes for v9 (Re-spun this series as there were minimal changes requested):
> ...
> > * Replaced mdelay(1) with usleep_range(1000, 1001) in rcar_pcie_ep_assert_intx()
>
> Are you sure that is good idea? You are requesting 1ms sleep time with 1us tolerance,
> I dont believe common systems can do that.
>
Agreed the systems cannot do that, but the main reason of replacing
mdelay(1) with usleep_range(1000, 1001) was since  pci_epc_raise_irq()
calls mutex_lock() and then this function rcar_pcie_ep_assert_intx(),
so we can assume this function also can sleep. And, according to
Documentation/timers/timers-howto.rst, we should use usleep_range()
instead of mdelay().

Cheers,
--Prabhakar



> Best regards,
>                                                                         Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
