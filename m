Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6948F7B3
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jan 2022 17:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiAOQCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jan 2022 11:02:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58106 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiAOQCO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jan 2022 11:02:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 028D460DF5;
        Sat, 15 Jan 2022 16:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5B4C36AE7;
        Sat, 15 Jan 2022 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642262533;
        bh=dXfz+j87xPDNeSX6HqrqgV0QIp9lXOhuOevSxgxBxAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBZUceP1fm1936OzmEoRc6xtqdD5KbaOLzrdEc+FuWEcCjgwnmIq7E5Rf9kN/qhOD
         8yJWG2lHkrpd6AAyQEMaHrVuUBaZQVsC04OOGISARjc6DNf4NcLCVz59LvwhH1XxXy
         0moIJHeGq+McQ5xaKrJey/AyOw7Fme5/Aeh/hs1pS32r0E655g9LGIStj7Gcfsr48+
         56Avbf+02HmjAu1u80ZQKazofB9alNivfvpNOb5XbdMHyaIPqwF/jXOCt6bO0279/8
         BCmo6chcAZz0OG6WtjiZUYit2B7zeWX4IxUgwaJSjC9VMR5E8F4bpBlH9EnvKMZo94
         Mk2j4H4tbkxmA==
Received: by mail-ed1-f48.google.com with SMTP id q25so46084088edb.2;
        Sat, 15 Jan 2022 08:02:13 -0800 (PST)
X-Gm-Message-State: AOAM532iF24XQny1hY7MtF5WCxSm1CnvVYUE86Mzh2CW3ma8zqRgdmWp
        UYoci5uR5GahZiClB0Poi5Qrkegzg/CcOTEX5Q==
X-Google-Smtp-Source: ABdhPJxfQvzMyV4E/lfsW80blaC+yF6Jz6eXdtfrSUYSUFPPjf5rBowLMBSmFOPgGlwU3ROMI1ZeCovUN+HxGfr8daY=
X-Received: by 2002:aa7:c587:: with SMTP id g7mr9586993edq.109.1642262531677;
 Sat, 15 Jan 2022 08:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20211214221450.589884-1-luca@lucaceresoli.net>
 <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
 <59a23c89-0810-eb28-acd9-7051ac34d438@lucaceresoli.net> <4579940c-27dc-733e-4022-ebea4671c839@lucaceresoli.net>
In-Reply-To: <4579940c-27dc-733e-4022-ebea4671c839@lucaceresoli.net>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 15 Jan 2022 10:02:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ5nr6xJoTv3A6UPMMDXhWKcwSEUA3ux3kK8OMWQxdc6w@mail.gmail.com>
Message-ID: <CAL_JsqJ5nr6xJoTv3A6UPMMDXhWKcwSEUA3ux3kK8OMWQxdc6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix link removal on probe error
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Saravana Kannan <saravanak@google.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Saravana

On Tue, Jan 11, 2022 at 4:35 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Rob,
>
> On 16/12/21 10:08, Luca Ceresoli wrote:
> > Hi Rob,
> >
> > thanks for the quick feedback!
> >
> > On 14/12/21 23:42, Rob Herring wrote:
> >> On Tue, Dec 14, 2021 at 4:15 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >>>
> >>> If a devm_phy_get() calls fails with phy_count==N (N > 0), then N links
> >>> have already been added by device_link_add() and won't be deleted by
> >>> device_link_del() because the code calls 'return' and not 'goto err_link'.
> >>>
> >>> Fix in a very simple way by doing all the devm_phy_get() calls before all
> >>> the device_link_add() calls.
> >>>
> >>> Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> >>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> >>> ---
> >>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> >>> index f7f1490e7beb..2ccc53869e13 100644
> >>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> >>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> >>> @@ -757,7 +757,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
> >>>                 phy[i] = devm_phy_get(dev, name);
> >>>                 if (IS_ERR(phy[i]))
> >>>                         return PTR_ERR(phy[i]);
> >>> +       }
> >>>
> >>> +       for (i = 0; i < phy_count; i++) {
> >>>                 link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> >>
> >> I think this should happen automatically now with fw_devlink being
> >> enabled by default. Can you try?
> >
> > Do you mean removal should be done automatically? I think they are not
> > due to the DL_FLAG_STATELESS flag.
>
> I would love to have feedback because, as said, I think my patch is
> correct, but if I'm wrong (which might well be) I have to drop patch 1
> and rewrite patch 2 in a slightly more complex form.

I mean that why do you need explicit dependency tracking here when
dependencies on a PHY should happen automatically now. IOW, what is
special about this driver and dependency?

Rob
