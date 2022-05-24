Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6895332AC
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbiEXUyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbiEXUyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 16:54:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2EC719C6
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 13:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64760B81BA0
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 20:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36062C34118
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 20:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653425686;
        bh=EXN66lEkV8PZ3yfw5x7JaNelF/LVqEMnp/lDsHs6nt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XPi94MgT/NoZmnonSrBMzKWgkf0wQbxOXHmf0FcBv/itc7PM3EhCHkWqFkvhftDy+
         sgmnl2CPvmnlosVocIVD3oCIbVVnsO0T0z4o2dV/QzaAWtrd6WXdTg/e/NwQubD+X5
         LiBbTIetWvjX+9fPnXMaF192RiydKoDZXP2PRGSDNl/j17snL5HJEqqSTfgEXj4mx2
         D9SywqGyhmMWlEW4PUh1geToOjwfM5cuAXo0pTJkgv+iH1pBWFLoW1+VFdcV9fE5Ev
         2vdhKohKK3xkC1Nnb2X9UCZ7KJf2D5x6CDBnxypwqN2ByXBPvR91juw4h5M000xxvY
         sJwWGtX2pBDig==
Received: by mail-ej1-f43.google.com with SMTP id gi33so29262766ejc.3
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 13:54:46 -0700 (PDT)
X-Gm-Message-State: AOAM532xEmasdxjcrF8MwlZL62TBcppEuL4sfh8kBNthasoKbpoXLtqY
        IgNNby31pto0JLRM8KvhfXXegrD4//gk+eKx2Q==
X-Google-Smtp-Source: ABdhPJwrIrEJpw0Qwtf/AXWM2ESUgHj39LEvLVbxMKSKeGyGtICBAhzh1IWplD1XbPYAi35+5SRuPSGNygDw1pZdPyo=
X-Received: by 2002:a17:906:7952:b0:6fe:1e0b:6343 with SMTP id
 l18-20020a170906795200b006fe1e0b6343mr26538885ejo.337.1653425684479; Tue, 24
 May 2022 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220524201509.GA257154@bhelgaas>
In-Reply-To: <20220524201509.GA257154@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 May 2022 15:54:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLeAKQNmbvNxVva=+xRP-XYSH1DLz-0OZyXKSPXf-TvEg@mail.gmail.com>
Message-ID: <CAL_JsqLeAKQNmbvNxVva=+xRP-XYSH1DLz-0OZyXKSPXf-TvEg@mail.gmail.com>
Subject: Re: PCI: keystone: ks_pcie_v3_65_add_bus()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 3:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Not sure whether anybody cares about the keystone driver any more.  It
> seems basically unmaintained after 57e1d8206e48 ("MAINTAINERS: move
> Murali Karicheri to credits") [1].
>
> Anyway, ks_pcie_v3_65_add_bus() [2] looks unusual to me.  It's an
> .add_bus() method that is called whenever we create a new PCI bus:
>
>   ks_pcie_v3_65_add_bus(...)
>   {
>     ks_pcie_set_dbi_mode
>     dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1)
>     dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1)
>     ks_pcie_clear_dbi_mode(ks_pcie)
>     dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start)
>   }
>
> This seems like something that should be done when the Root Port is
> enumerated, not when we set up its secondary bus.  Maybe somewhere in
> ks_pcie_host_init() or ks_pcie_config_msi_irq()?

See these commits for the reasoning:

1df793054859 PCI: dwc: Convert to use pci_host_probe()
6ab15b5e7057 PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
6e8e104d2196 PCI: Also call .add_bus() callback for root bus

The reason was to keep the initialization in the same order as when we
had the DWC specific .scan_bus() op. There's not a driver hook in
between the h/w setup and scanning devices.


> I don't think we should use .add_bus() unless it's actually something
> related to adding a bus.

I think I was inspired from how pcibios_add_bus() is (ab)used.

Rob
