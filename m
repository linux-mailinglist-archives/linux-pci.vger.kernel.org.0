Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647D785231
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 10:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjHWICS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjHWICN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 04:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37165CD0;
        Wed, 23 Aug 2023 01:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9870E616CF;
        Wed, 23 Aug 2023 08:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D2FC433C8;
        Wed, 23 Aug 2023 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692777728;
        bh=5wXBowWi/z5rX1b22zzh2tsRtXiSEcMH1JeaAg4xXBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdIHGVGipE/SD8BcM3OhOE9pSHYblDozh2QqSPBLFYuiEvc3hBpFgK15u2CewKKzt
         FDR1MVWz0U9PqC7T5VqRNIaJ7l7JGwXA1kA+szvS6B7BbaDDhRbaTSGsE1SvYs8KIJ
         blG5XlSbZo0QEeoeLrzdzA0XYFvRauz2B6r6LJVDsKJMX170QwCxdzWM3/TVkSXzzR
         sET8MWO1Po972tNYAq8acyWzJVGUlJUypUeaC7M2UynnyadoArO6irj8osYvcyQRpg
         KnQmDla1SkZYFmLIAkUDacxNtcvjawEUe0tfvDu6htO5qJovGePrJqogw41wS6MTDC
         LcoFAjiZ1LFuA==
Date:   Wed, 23 Aug 2023 13:31:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: rcar-host: add support for optional
 regulators
Message-ID: <20230823080152.GI3737@thinkpad>
References: <20230816104251.19744-1-wsa+renesas@sang-engineering.com>
 <20230816104251.19744-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816104251.19744-3-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 12:42:50PM +0200, Wolfram Sang wrote:
> The KingFisher board has regulators for miniPCIe, so enable these
> optional regulators using devm. devm will automatically disable them
> when the driver releases the device. Order variables in reverse-xmas
> while we are here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 88975e40ee2f..7aecc114af4f 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -29,6 +29,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "pcie-rcar.h"
>  
> @@ -953,14 +954,20 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>  	{},
>  };
>  
> +/* Design note 346 from Linear Technology says order is not important */
> +static const char * const rcar_pcie_supplies[] = {
> +	"vpcie12v", "vpcie3v3", "vpcie1v5"
> +};
> +
>  static int rcar_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
>  	struct rcar_pcie_host *host;
>  	struct rcar_pcie *pcie;
> +	unsigned int i;
>  	u32 data;
>  	int err;
> -	struct pci_host_bridge *bridge;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
>  	if (!bridge)
> @@ -971,6 +978,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	pcie->dev = dev;
>  	platform_set_drvdata(pdev, host);
>  
> +	for (i = 0; i < ARRAY_SIZE(rcar_pcie_supplies); i++) {
> +		err = devm_regulator_get_enable_optional(dev, rcar_pcie_supplies[i]);
> +		if (err < 0 && err != -ENODEV)
> +			return dev_err_probe(dev, err, "can't enable regulator %s\n",
> +					     rcar_pcie_supplies[i]);
> +	}
> +
>  	pm_runtime_enable(pcie->dev);
>  	err = pm_runtime_get_sync(pcie->dev);
>  	if (err < 0) {
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
