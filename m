Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BE14847BD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 19:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiADSZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiADSZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 13:25:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2062C061761;
        Tue,  4 Jan 2022 10:25:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA6D61507;
        Tue,  4 Jan 2022 18:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAD5C36AE9;
        Tue,  4 Jan 2022 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641320714;
        bh=1vW/2bgAcqY2wQ8349AnZRwcC6kttYshiqCSkRHR+rs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I8vH6aQRWbAgccogh831KAlri0eQgMunecG7Y2p9qZ0rxbhozEtz56iaL3JVZaIf3
         O4SbqXvMeeCQl0YsU4O8VJoHvxaSlfwwA4w0qdhCBKFq1QQFVtOEegjVF2JFXbdxwe
         BTVbYPKzYzSs4JGtsJNy+HF0Hza7nJgJohEym57Aa0DLylJ/1kfCZx/Gb50ijvjf3d
         xmA4PBcFU7NcSi9nkOIj/yJqdhTZcWrdY91KUTd5xqbmF2vk6JERn+eDqN5Up56vpV
         FLKdKsFvcK0A1L1qsNw76fH3rs6ikUlVodWLERZauQZ7rlsPZYxyTawlGNFg64Qqzy
         5b5Cn53kD7yhw==
Received: by mail-ed1-f41.google.com with SMTP id b13so151798453edd.8;
        Tue, 04 Jan 2022 10:25:14 -0800 (PST)
X-Gm-Message-State: AOAM531P0oWLlVa8Y6O1jr9gkQe0a1GOXlVuIBuoQfpYUtiltmYbSCm9
        dDE6yteCB+ybqof19oe/5LN2l9B6+5mL4NnqQA==
X-Google-Smtp-Source: ABdhPJy8PnY1vV4shFU7O8/wlAqOdptwOc4ZVTX4Sc2tO9AyDDj0mrGrP4knLFOUnVWdeCRu5oinsn9J+wNeTnTN99U=
X-Received: by 2002:a05:6402:1a35:: with SMTP id be21mr48280640edb.215.1641320713096;
 Tue, 04 Jan 2022 10:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20211126083119.16570-1-kishon@ti.com> <20211126083119.16570-5-kishon@ti.com>
In-Reply-To: <20211126083119.16570-5-kishon@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Jan 2022 12:25:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLn6K6N1rXGj69-xnZgPX-ecKePN_CYXLCEQLhxB=0m1Q@mail.gmail.com>
Message-ID: <CAL_JsqLn6K6N1rXGj69-xnZgPX-ecKePN_CYXLCEQLhxB=0m1Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI: keystone: Add quirk to mark AM654 RC BAR flag
 as IORESOURCE_UNSET
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 26, 2021 at 2:31 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> AM654 RootComplex has a hard coded 64 bit BAR of size 1MB and also has
> both MSI and MSI-X capability in it's config space. If PCIEPORTBUS is
> enabled, it tries to configure MSI-X and msix_mask_all() adds about 10
> Second boot up delay when it tries to write to undefined location.
>
> Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET so that
> msix_map_region() returns NULL for Root Complex and avoid un-desirable
> writes to MSI-X table.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 52d20fe17ee9..73e6626a0d8f 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -557,8 +557,14 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>                 { 0, },
>         };
>
> -       if (pci_is_root_bus(bus))
> +       if (pci_is_root_bus(bus)) {

The existing quirk has to be called for every device. But this quirk
applies to just the RC, so can't you add another quirk and use the
existing quirk infrastructure matching mechanism?

>                 bridge = dev;
> +               if (pci_match_id(am6_pci_devids, bridge)) {
> +                       struct resource *r = &dev->resource[0];
> +
> +                       r->flags |= IORESOURCE_UNSET;
> +               }
> +       }
>
>         /* look for the host bridge */
>         while (!pci_is_root_bus(bus)) {
> --
> 2.17.1
>
