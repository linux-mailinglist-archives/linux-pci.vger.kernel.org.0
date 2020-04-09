Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27F1A3231
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDIKFU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 06:05:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33189 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKFU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 06:05:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id 103so3519923otv.0;
        Thu, 09 Apr 2020 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=339j4MaqRyQUqdJT33toZfwVsRBRNf1r0tP9u8tA6/k=;
        b=E1dFeILKHlqqZAzfS0yB6UoHzzwrLRtZ8X8WHp+c1guK812Ac3v1D8MqHQms5kdfj0
         3yyMWYgtrOyTvMYdbGk7LG3bqCNXBbKmyVByy1WkLVRcyRNNHIKtAC/Ff/Ffrx0Eyxwg
         34jnSSD42/QryQnaEchzDT17xTYgVRNKJotdWuyJBww1ox8bXhVVLeVPnmnemwEUjJ19
         /vNgWYmIKQfliHgiboJ5yKJveN5HoiD5xnCDzFwefHb0Kx4WaqeSCvuqR7IYEwoGbmfa
         xnjM1LOH0HynOtlqdJOWztV53gpIugfHYz9hYfqAXd12Wk/G21Z6fXwZK3+8Fm31/kRz
         KE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=339j4MaqRyQUqdJT33toZfwVsRBRNf1r0tP9u8tA6/k=;
        b=h30BwOqb943WWLPKJDgPZV6lL+NL7sISAyPkNuJ9D6lLf9mwgvyARvISazHMLHBJ/J
         zGU6EiBEHX7cf7g2LOxasCBv+Xp6wfAb4b5jqByxObQqG2FmgQVTUuPmh5YoiKMxy3n9
         O0GJUtQwF7Y+Ekt8BnjR7Agp5dE0RL6uaGXuvKRn0gPusvwjy4uZ+o8WGgX61ZCTDdXL
         5S6/ZlkO5QYdgvfOdcM+hp8V1GKr4pyHBcWP/sUnyB2mh1uz/o1T3vfYAXJSpQPUmpNh
         5JjkAi6TSpQGc3rYHRiYebkBmMQoQq/w7vPWkpAO7TlnzUVoOSGlWzsS9vjmlB+NWir/
         smnQ==
X-Gm-Message-State: AGi0PuYh9GO3mc3Zu2qlNvDDlsNJTyh4Xxh2/0JWswsOtVToyt0eVrsg
        0YOn2Lrumt52fNrOlGdctgVl+ZAg/ZbzVIT+A04=
X-Google-Smtp-Source: APiQypI1ZTh7a2IVl4I8tXE41Mc3lGPBZY4nosM1GN+H5r+AL5nH4NCX6DGIGvQhFATTRXa0MRQAoqev/aam1hCwyf0=
X-Received: by 2002:a9d:ef6:: with SMTP id 109mr2955843otj.43.1586426718309;
 Thu, 09 Apr 2020 03:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <1586360280-10956-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1586360280-10956-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <e3f5fa77-f78e-edbf-9efc-53b5ea620460@cogentembedded.com>
In-Reply-To: <e3f5fa77-f78e-edbf-9efc-53b5ea620460@cogentembedded.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Apr 2020 11:04:52 +0100
Message-ID: <CA+V-a8s1E_kq_GENBTw3zGxKSPFnVKNY-ta9+c8W8nV4JFyEEw@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] PCI: Add Renesas R8A774C0 device ID
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergei and Bjorn,

On Thu, Apr 9, 2020 at 10:36 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 08.04.2020 18:37, Lad Prabhakar wrote:
>
> > Add R8A774C0 device ID so that this can be used by
> > pci_endpoint_test driver.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >   include/linux/pci_ids.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 1dfc4e1dcb94..9e957c18abeb 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2460,6 +2460,7 @@
> >   #define PCI_DEVICE_ID_RENESAS_SH7763        0x0004
> >   #define PCI_DEVICE_ID_RENESAS_SH7785        0x0007
> >   #define PCI_DEVICE_ID_RENESAS_SH7786        0x0010
> > +#define PCI_DEVICE_ID_RENESAS_R8A774C0       0x002d
>
>     We don't add the device IDs in this file, unless used in several places.
> Is it?
>
My bad I should have checked it before making this change actually it
was suggested in my previous version of the series but anyway atm this
was planned to be  used only in pci_endpoint_test driver, so in that
case Ill drop this patch.

Cheers,
--Prabhakar

> [...]
>
> MBR, Sergei
