Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6C570D68
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiGKWc6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 18:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGKWcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 18:32:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F647D7BF;
        Mon, 11 Jul 2022 15:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D733B815F3;
        Mon, 11 Jul 2022 22:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDEBC34115;
        Mon, 11 Jul 2022 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657578756;
        bh=ZRNcQJ+A2nAPqlfYlLU9IXnKjoNOlpRcfrMLlQ0nMC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Du4WuOAkpAjMpBiGEzqbA6fgAo9O01pv60EaYMWk9k4PNawklP7ZgPsd3uwhuXoRh
         D0EYBQiiXPnjjh3UxUvaXE7KiaedPGdiRVLVlGv2tvdakHWy1c/gmbLgD+HipnDItO
         F+bnncYVrY21l41mqs+t15AKdmw+mNjbWnVDFxLmU8tlF2//aCl6lDm6d/liHm4FDe
         THKrdKOJ1DqeN2j3l3LTuONSr05lvvlzkV0X265oyigvf0N5FEj6nTfPDKPgX0TLZ0
         VUMqt5tAUPyhWdwtt9enrUmLvVc6fILkNn3crBilzBfyfRbLybgHbRzkUiUT6b32pv
         T/X8J/zs4EhYA==
Date:   Mon, 11 Jul 2022 17:32:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Toan Le <toan@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Drop of_match_ptr() to avoid unused variables
Message-ID: <20220711223234.GA701706@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706195838.217054-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 02:58:38PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We have stubs for most OF interfaces even when CONFIG_OF is not set, so we
> allow building of most controller drivers in that case for compile testing.
> 
> When CONFIG_OF is not set, "of_match_ptr(<match_table>)" compiles to NULL,
> which leaves <match_table> unused, resulting in errors like this:
> 
>   $ make W=1
>   drivers/pci/controller/pci-xgene.c:636:34: error: ‘xgene_pcie_match_table’ defined but not used [-Werror=unused-const-variable=]
> 
> Drop of_match_ptr() to avoid the unused variable warning.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this on pci/misc for v5.20.  Holler if you object :)

> ---
>  drivers/pci/controller/dwc/pci-keystone.c   | 2 +-
>  drivers/pci/controller/dwc/pcie-armada8k.c  | 2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
>  drivers/pci/controller/pci-xgene.c          | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index d10e5fd0f83c..602909f712b9 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1324,7 +1324,7 @@ static struct platform_driver ks_pcie_driver __refdata = {
>  	.remove = __exit_p(ks_pcie_remove),
>  	.driver = {
>  		.name	= "keystone-pcie",
> -		.of_match_table = of_match_ptr(ks_pcie_of_match),
> +		.of_match_table = ks_pcie_of_match,
>  	},
>  };
>  builtin_platform_driver(ks_pcie_driver);
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 4e2552dcf982..8391417fad41 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -343,7 +343,7 @@ static struct platform_driver armada8k_pcie_driver = {
>  	.probe		= armada8k_pcie_probe,
>  	.driver = {
>  		.name	= "armada8k-pcie",
> -		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
> +		.of_match_table = armada8k_pcie_of_match,
>  		.suppress_bind_attrs = true,
>  	},
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
> index 1569e82b5568..48af5170a8e7 100644
> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
> @@ -258,7 +258,7 @@ static struct platform_driver spear13xx_pcie_driver = {
>  	.probe		= spear13xx_pcie_probe,
>  	.driver = {
>  		.name	= "spear-pcie",
> -		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
> +		.of_match_table = spear13xx_pcie_of_match,
>  		.suppress_bind_attrs = true,
>  	},
>  };
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index eb6240958bb0..549d3bd6d1c2 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -641,7 +641,7 @@ static const struct of_device_id xgene_pcie_match_table[] = {
>  static struct platform_driver xgene_pcie_driver = {
>  	.driver = {
>  		.name = "xgene-pcie",
> -		.of_match_table = of_match_ptr(xgene_pcie_match_table),
> +		.of_match_table = xgene_pcie_match_table,
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe = xgene_pcie_probe,
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
