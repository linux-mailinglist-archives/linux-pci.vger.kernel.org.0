Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7C11FF3E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 08:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLPHws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 02:52:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42281 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPHws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 02:52:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so8005885otd.9;
        Sun, 15 Dec 2019 23:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teaKbuiwSImi7RfIBsT5A595WaRZ9qMw7uZTBvgzoPo=;
        b=T9+hyjIOYswgHEv4Tk1y+UNP7CGTbnEox9pCdGBWORd9ZZ8iJyE++oJ17Ew7Pahdw8
         eV4gf9dCyNCNDRSAH/6T+z2+0xICmVRXxTvFJK3lXXeCq+konXyjj9WGgZhxkc3ABdiF
         JEM7Gm1bSUKBl2NJoGdxXv/p/bAUz4rzX+FTOUyLZb6hIqR2WQMjUJNm42ULZRiJZZoc
         ga24v8E8mr7DcvLxPW8MMCvY2OXxWEnyGfPcU+z0xN5sXyUwN7CB3kpXsWqkjc+ot3QR
         6s8GOULh2ygu7Y0nuPsI8e9UL1ThafpjTBl47lNjqSxsBLfirQSGATt1hukDBeom5QaS
         NYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teaKbuiwSImi7RfIBsT5A595WaRZ9qMw7uZTBvgzoPo=;
        b=i8UQsnBUKManNbfKeGEx09gaawx5DdjPvw2tZ3nV+0D8LrmGh0MAeBdEFet7stC96C
         iXOu5pPhZ2Pll4HELXt/QfodfpQmhIjdQyu5Sm007o6HKjqyzW5XLhQOmqFZnkbdU5yK
         UxpNivJOCS8G7t9fg28FvvP9C+IP8UZFnDnBSSn5Xe89jf5xL4lStB3vIshOZBNoF18j
         OPIAWyAHp4vJTPnrY8/wGuz2S68SchMffnbFnV1XuorzrGvSuRn2/SvNubOOguY/qwbc
         EFT1qHVXWy7CUVIOMO+S3xKKYPAyn252efyuRKUdkrDNEZt3vfUN4LvRt5/ui0hm1TXM
         OQ9w==
X-Gm-Message-State: APjAAAW8fPY11K+qYAuCFimhpbIxw2WQMbjuzfUH81FrUCEPTGNsZYoo
        UxDpXVoK8xYq0Kuk+5wmu6gLQqBQHf+b15oY58g=
X-Google-Smtp-Source: APXvYqzJWsrCKHBWPt/+qDVqGaXSw/dwYOelFmuU1LMlbhh0onKHLZCdb9U0GQHZ+rXpK2GlmhJM1lVnV2qMLZqENUI=
X-Received: by 2002:a9d:175:: with SMTP id 108mr30137165otu.325.1576482767410;
 Sun, 15 Dec 2019 23:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191213185011.GA170447@google.com>
In-Reply-To: <20191213185011.GA170447@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 16 Dec 2019 07:52:20 +0000
Message-ID: <CA+V-a8u7RO1L1ExPXwHuSpKrCA47iRPFySUn1royEGoOxy0=2A@mail.gmail.com>
Subject: Re: [v2 1/6] pci: pcie-rcar: preparation for adding endpoint support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Dec 13, 2019 at 9:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Dec 13, 2019 at 08:47:43AM +0000, Lad Prabhakar wrote:
> > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > this patch prepares for adding endpoint support to rcar controller,
> > there are no functional changes with this patch, a common file is
> > created so that it can be shared with endpoint driver. Alongside
> > this patch fixes checkpatch reported issues.
>
> Can you please split this into:
>
>   - a patch that moves code only, with no other changes except any
>     necessary Kconfig and Makefile changes
>   - another patch that fixes the checkpatch things
>
> When the checkpatch fixes are buried in the code move, it's impossible
> to review them.
>
thank you for the review.sure I'll split up the patches and resend.

Cheers,
--Prabhakar

> > Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/arm64/configs/defconfig            |    2 +-
> >  drivers/pci/controller/Kconfig          |    4 +-
> >  drivers/pci/controller/Makefile         |    2 +-
> >  drivers/pci/controller/pcie-rcar-host.c | 1056 ++++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-rcar.c      | 1229 ++-----------------------------
> >  drivers/pci/controller/pcie-rcar.h      |  129 ++++
> >  6 files changed, 1242 insertions(+), 1180 deletions(-)
> >  create mode 100644 drivers/pci/controller/pcie-rcar-host.c
> >  create mode 100644 drivers/pci/controller/pcie-rcar.h
