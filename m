Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D1D6E697B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjDRQ1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjDRQ1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 12:27:37 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999ABBAB;
        Tue, 18 Apr 2023 09:27:22 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-38dfa504415so583910b6e.0;
        Tue, 18 Apr 2023 09:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835242; x=1684427242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA3Wj6o+Guvdyn6RVWvc15n99JJqv1Kt6CugaXzG/F8=;
        b=mGsWZW/8X0/PhZqjkhij0g3zsoUHvTBhb0SpsjQhi8nOFJRbfmcdUnKM9GScncj7jk
         7mepd1GwBgrfS/UGbmzMVztZFONLgU5LMsPgZZ3R1dGwaGoWqJDD6PFN6p0T4FnArzyE
         XWi21AAO36UYeGKHWO/8j3PJEYZmB0MSMc81tCduD6ompeTpNbnjN2JHvP3w0YM7qu4z
         2g0c9ZrHB27VyRe3oKb/Q24di1LMbbM3aft3dEYbILzMroPur2HrO4rqv+b/Tvq/cdLb
         X6QXbiZz0EzjKW19Itfaok7DjEfRggGkodLeBEzYFSkplBm4P19g2TWiEl7FRO4ezp0S
         /L+g==
X-Gm-Message-State: AAQBX9dgSZKuvtOplE8SAbQ4kNm2zIYvIKJVI81SgL/n6ghkUseqzy9j
        RxJ8drhRX5hd2R3YqH48omI3hBt42g==
X-Google-Smtp-Source: AKy350bBHLRqNa07Du4N0WmT6K0vuSFaG9g8fJGUXZXaLSnM3rdYMjG2JcU3ECFR82i0sqHbDMgiyw==
X-Received: by 2002:a05:6808:2203:b0:38e:390b:777b with SMTP id bd3-20020a056808220300b0038e390b777bmr1228732oib.59.1681835241818;
        Tue, 18 Apr 2023 09:27:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i11-20020aca3b0b000000b0038c235e24fesm2204031oia.48.2023.04.18.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:27:20 -0700 (PDT)
Received: (nullmailer pid 1810183 invoked by uid 1000);
        Tue, 18 Apr 2023 16:27:19 -0000
Date:   Tue, 18 Apr 2023 11:27:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
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
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: Use of_property_present() for testing DT property
 presence
Message-ID: <20230418162719.GF1764573-robh@kernel.org>
References: <20230310144719.1544443-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144719.1544443-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
> ---
>  drivers/pci/controller/pci-tegra.c     | 4 ++--
>  drivers/pci/controller/pcie-mediatek.c | 2 +-
>  drivers/pci/hotplug/rpaphp_core.c      | 4 ++--
>  drivers/pci/of.c                       | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Ping!

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
