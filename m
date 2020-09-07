Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0A25F767
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgIGKLt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 06:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIGKLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 06:11:49 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C470DC061573;
        Mon,  7 Sep 2020 03:11:48 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id p81so3125036ybc.12;
        Mon, 07 Sep 2020 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NItqmQS+iLVNAJXUD1/14RQeKA0HQt2QXYC8OgD50R0=;
        b=sjBIjhtsM3MYD03QVvK9ryci/drsGqrrx2FQGG5loNGf75/Rokr2STGll9xhyHY+8A
         ZnErgnF2pk5GKL9yHAJPimPqd/k+oLB5EAN3hDmxEWMvtNPJ2BDvZkisUGQMZCh5+D0b
         ZKu8z0vLXxXgReoHcSx0lSzRctzBtoKlUq7Yymoju7IIrSlb24s6+hSE2SbNuOkziHea
         V9P/3T9V30VT3zCDzdS1msTUp4uwfgvjcWFZlPEs+Pk1SndrPvCVPh9zqI6lesmjPurN
         r93Xo5xlWMtMFkmOmjhtVRZVze0dUNUNV4Mu5gMJgstWiqTXJgcwaAVALyvnZn4/1nn9
         bzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NItqmQS+iLVNAJXUD1/14RQeKA0HQt2QXYC8OgD50R0=;
        b=NeZGnO8zMzOHfdPMfRH9EnS7essk/YfeK4Luuj/nOPE2udPMfYscO4XznPiv6wZaWj
         8Gegi0nja3ORsZcvFXcrZWvbq/buyl0ITlnS2JT4TS8Yz5uvH8EIR2c3QtGDJh57mO0i
         rdN0wccCn9QPo4zj/nta/e7NpZCdG5YuEnciY9vyBzL5UHfp5lI/RZiDX+G0YXP5Voj0
         hWYNADGWaluTLpPOC8H/Tf3vRlPRYjJdH/HKxr84UBxUhIbfcZO1uGcVCB9ApFL7WP0H
         ZcHcqyQabvcY76lPRwAdK6fUte2F6iVgRBn6vfOtTdt7UwEiaK8nYyT5F8sxQrwDnx7C
         7kMA==
X-Gm-Message-State: AOAM5332Uzd5HYo2zfw0hdK/6bp/sv5VHXk3vlNPYuFNsA3xryAKrKtP
        ejXNA1t4GBoL9Du6cpSWElexl75+tbxZJDfaF64=
X-Google-Smtp-Source: ABdhPJxzSRxWnS28Xn1CbdmXZj4gM9rzsXX6crUDa0nckRnqb+LEdnfv3snb4Obd4pUsBmgvfL59iDb3yRszRWu//6g=
X-Received: by 2002:a25:ab91:: with SMTP id v17mr26093196ybi.76.1599473507987;
 Mon, 07 Sep 2020 03:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200907100902.GF6428@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200907100902.GF6428@e121166-lin.cambridge.arm.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 7 Sep 2020 11:11:21 +0100
Message-ID: <CA+V-a8v6t63NsSXCjmsLzA-8D=1mO3UhwHfgKM6dor7jyuBFUQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add PCIe EP nodes on RZ/G2[EMN]
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Mon, Sep 7, 2020 at 11:09 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Aug 14, 2020 at 06:30:32PM +0100, Lad Prabhakar wrote:
> > Hi All,
> >
> > This patch series adds support for PCIe EP nodes to Renesas r8a774a1,
> > r8a774b1 and r8a774c0 SoC's.
> >
> > Patches are based on top of [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/
> >     pci.git/log/?h=next
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (5):
> >   dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
> >   misc: pci_endpoint_test: Add Device ID for RZ/G2M and RZ/G2N PCIe
> >     controllers
> >   arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
> >   arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
> >   arm64: dts: renesas: r8a774c0: Add PCIe EP node
> >
> >  .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  7 +++-
> >  arch/arm64/boot/dts/renesas/r8a774a1.dtsi     | 38 +++++++++++++++++++
> >  arch/arm64/boot/dts/renesas/r8a774b1.dtsi     | 38 +++++++++++++++++++
> >  arch/arm64/boot/dts/renesas/r8a774c0.dtsi     | 19 ++++++++++
> >  drivers/misc/pci_endpoint_test.c              |  7 +++-
> >  5 files changed, 105 insertions(+), 4 deletions(-)
>
> I can take the first two patches but the dts changes should be routed
> and posted to arm-soc.
>
Thanks, the DTS changes have been picked up by Geert.

Cheers,
Prabhakar
