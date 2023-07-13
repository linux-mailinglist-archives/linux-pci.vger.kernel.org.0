Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3980752736
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjGMPeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjGMPeF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 11:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB21FC4;
        Thu, 13 Jul 2023 08:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF8061A04;
        Thu, 13 Jul 2023 15:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDA0C433C8;
        Thu, 13 Jul 2023 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262443;
        bh=TXXooUFVHTPaYTGh9FoTYszC1QZuaCRw5/+96j0pc6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xe5OKuEmVyzCWQGWWTpbwZp9QmpxM25RMyrl/t2vF6laqsfNK2a4HPaaULj6dNWIU
         W9xqH5wYzIwc9vZ10gvdkYx0LQZPft+7z2N4c+N+fa/Ic/45egxS7oOBnY0l1366pY
         jBm8C0dqSAO3aWJnjMhTjC5fK9OOeFF3X/NXJ8l46HhJ2Q5UhdIDzOwluYGrTFbEr/
         mNZfsq65W7FzjZq58xWCgqSRzd1IsRQh64B6jQ8IGkmgcfL0s5miNNiCLdgzEYVGW2
         pNK2YbO7FElM+52Ur3d/D2CXaGJ5LKGIZq6tAI0WHXiKVloB3alxKJvlKmsHuKmvr6
         PgQN5jIvPVjEA==
Date:   Thu, 13 Jul 2023 10:34:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v3 RESEND 2/2] PCI: rcar-host: add support for optional
 regulators
Message-ID: <20230713153401.GA317502@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712103916.1631-3-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 12:39:16PM +0200, Wolfram Sang wrote:
> The KingFisher board has regulators. They just need to be en-/disabled,
> so we can leave the handling to devm. Order variables in reverse-xmas
> while we are here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Krzysztof or Lorenzo may fix this up for you, but:
s/add support/Add support/ in subject to match history
and recast commit log to say what the patch *does* ("enable optional
regulators using devm, so devm will automatically disable them when
the driver releases the device"), not *what needs to be done*.

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
> 2.30.2
> 
