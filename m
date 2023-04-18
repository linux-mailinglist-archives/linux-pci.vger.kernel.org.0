Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642FD6E6DCB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDRVDJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjDRVDI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABFB7ED6;
        Tue, 18 Apr 2023 14:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC73662C35;
        Tue, 18 Apr 2023 21:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155EEC433EF;
        Tue, 18 Apr 2023 21:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681851786;
        bh=wUDQT7v4d9CA1v22EaRJl1H3C9V5twleJc7yXsj1qDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d5Uz3AqaD26Yv+nr9cFaoJzGbvLA3JqeJLNEPT8wSh1eb6X6EvRFOZ1SKuGjyCYpx
         eH2HpI20aWdUaPs3W5D/b6IG/WZzl6KwS/RFlYyRmrj2rU8u8rhD2yi+B+D2Asy1aG
         QZzpLc0Q40QmOcm3NtyQ0h0gD2NQ5jFUlsl5BFNaodBkqBr1SPZwgBdjChL8Vl6K7q
         VzDjHXH+ceP1GDR16/ib2INaiLJASQIi75eyNC3TBuwxzV7EIo15vKo9ljsrRpjMPA
         0kVyQPK6wtnK0kOGYyaRSwpiVK5b41MoX34NS0IlllNjSRS+UpeVDKG7EhBSgiUjHy
         8RPrv8vYiZQzA==
Date:   Tue, 18 Apr 2023 16:03:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: Use of_property_present() for testing DT property
 presence
Message-ID: <20230418210304.GA158193@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144719.1544443-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:19AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied with AngeloGioacchino's reviewed-by to pci/enumeration for
v6.4, thanks!

> ---
>  drivers/pci/controller/pci-tegra.c     | 4 ++--
>  drivers/pci/controller/pcie-mediatek.c | 2 +-
>  drivers/pci/hotplug/rpaphp_core.c      | 4 ++--
>  drivers/pci/of.c                       | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 74c109f14ff0..79630885b9c8 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1375,7 +1375,7 @@ static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
>  	struct tegra_pcie_port *port;
>  	int err;
>  
> -	if (!soc->has_gen2 || of_find_property(np, "phys", NULL) != NULL)
> +	if (!soc->has_gen2 || of_property_present(np, "phys"))
>  		return tegra_pcie_phys_get_legacy(pcie);
>  
>  	list_for_each_entry(port, &pcie->ports, list) {
> @@ -1944,7 +1944,7 @@ static bool of_regulator_bulk_available(struct device_node *np,
>  	for (i = 0; i < num_supplies; i++) {
>  		snprintf(property, 32, "%s-supply", supplies[i].supply);
>  
> -		if (of_find_property(np, property, NULL) == NULL)
> +		if (!of_property_present(np, property))
>  			return false;
>  	}
>  
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index ae5ad05ddc1d..31de7a29192c 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -643,7 +643,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
>  		return err;
>  	}
>  
> -	if (of_find_property(dev->of_node, "interrupt-names", NULL))
> +	if (of_property_present(dev->of_node, "interrupt-names"))
>  		port->irq = platform_get_irq_byname(pdev, "pcie_irq");
>  	else
>  		port->irq = platform_get_irq(pdev, port->slot);
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index 491986197c47..2316de0fd198 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -278,7 +278,7 @@ int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
>  		return -EINVAL;
>  	}
>  
> -	if (of_find_property(dn->parent, "ibm,drc-info", NULL))
> +	if (of_property_present(dn->parent, "ibm,drc-info"))
>  		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
>  						be32_to_cpu(*my_index));
>  	else
> @@ -440,7 +440,7 @@ int rpaphp_add_slot(struct device_node *dn)
>  	if (!of_node_name_eq(dn, "pci"))
>  		return 0;
>  
> -	if (of_find_property(dn, "ibm,drc-info", NULL))
> +	if (of_property_present(dn, "ibm,drc-info"))
>  		return rpaphp_drc_info_add_slot(dn);
>  	else
>  		return rpaphp_drc_add_slot(dn);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..e085f2eca372 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -447,7 +447,7 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>  		return -ENODEV;
>  
>  	/* Local interrupt-map in the device node? Use it! */
> -	if (of_get_property(dn, "interrupt-map", NULL)) {
> +	if (of_property_present(dn, "interrupt-map")) {
>  		pin = pci_swizzle_interrupt_pin(pdev, pin);
>  		ppnode = dn;
>  	}
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
