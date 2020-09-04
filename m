Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5825E1CA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgIDTNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 15:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIDTNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 15:13:19 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6051C206B8
        for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2020 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599246798;
        bh=Owwwx48zTzwVWjpDFG1//g/fUyXBMElpSOw7p1Gqe4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wn27XH3gIgmSq9IMeE8Ucrd9cJrFESt3hd22/xnCh4Zo4F9as5t4xYYbg3XuRa/j7
         /UC11kryEp00OTvQSkebPxRriVpb1O40YG1bTB54fOtJ63Uwext8YxhJdoas7A0Kwz
         Ni81YvV3iIgThkkLYH5lRSELJLcxbgT3BCPNvLsY=
Received: by mail-oi1-f171.google.com with SMTP id z22so7542930oid.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2020 12:13:18 -0700 (PDT)
X-Gm-Message-State: AOAM532ka1GGiKgmNz8FLiAkX6K0ta34yJ7pVnC5fi9AM/07gYRVEl+s
        JUstVOINHm3REp1FBV9HUnQoB60iy7LE2m155Q==
X-Google-Smtp-Source: ABdhPJy+JiQUwTXGopw5b11cb1ZulrGsW0e7T32qeHh+SdXQ0a84uBOfd6SaL+JHbRTV3bruFzYNSqYmsLqE6n9VxXw=
X-Received: by 2002:aca:1711:: with SMTP id j17mr6370474oii.152.1599246797728;
 Fri, 04 Sep 2020 12:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200904142132.6054-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200904142132.6054-1-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Sep 2020 13:13:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVXsKZkR09uNOnWtO2sSZXBUF=PHk-_zhYbC6EfN7Z_w@mail.gmail.com>
Message-ID: <CAL_JsqKVXsKZkR09uNOnWtO2sSZXBUF=PHk-_zhYbC6EfN7Z_w@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Remove useless msi_controller allocation/initialization
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 4, 2020 at 8:21 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> The mvebu host controller driver allocates an msi_controller structure
> without assigning its methods.

It's only allocating a pointer, not an actual msi_controller struct. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

>
> This means that the PCI IRQ MSI layer ignores it and that after all it
> should not really be needed.
>
> Remove it.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index c39978b750ec..eee82838f4ba 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -12,7 +12,6 @@
>  #include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/mbus.h>
> -#include <linux/msi.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
> @@ -70,7 +69,6 @@ struct mvebu_pcie_port;
>  struct mvebu_pcie {
>         struct platform_device *pdev;
>         struct mvebu_pcie_port *ports;
> -       struct msi_controller *msi;
>         struct resource io;
>         struct resource realio;
>         struct resource mem;
> @@ -1127,7 +1125,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>         bridge->sysdata = pcie;
>         bridge->ops = &mvebu_pcie_ops;
>         bridge->align_resource = mvebu_pcie_align_resource;
> -       bridge->msi = pcie->msi;
>
>         return mvebu_pci_host_probe(bridge);
>  }
> --
> 2.26.1
>
