Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D27636D65
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 23:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKWWjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 17:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKWWjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 17:39:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2792B5D;
        Wed, 23 Nov 2022 14:39:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BCB761F4C;
        Wed, 23 Nov 2022 22:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6E7C433C1;
        Wed, 23 Nov 2022 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669243191;
        bh=a4+0uiLBUyE9xruBjqTz1QT1oKdoKy3V//RWTYjwkwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckM/t7ZKPNwm4Zuy7Uv7ff+ykJqZS0VjMONRm4ToWTuo/TVOIgm+DCpVBaQbrZVQV
         5oF158/847ifg8T2T+ZAbs2q7b2bPIT9Av7mBk8sEE+Nd4K+L5d3gUiQLmuOte198h
         jzaNpZIsLqhe2aEZhss2zLCaq7YcaSfVGI2heQIbfAxtwSNTPFCwL+n0Aci9SXBqZ9
         0aDTulLNWUMMBn0zIrE0D9gPm/B994EqT5o2bWCU9Be2ZMrv/TpKaRoR8cyTzV2lMI
         XqcW3gtWP30OBARqnEi8Ov5lqpxnboGARVYMETmGm7VboLN1xK48Nwxi8S1orSeTQD
         IJMG3CWalhSxQ==
Date:   Wed, 23 Nov 2022 22:39:46 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 6/9] PCI: microchip: Re-partition code between probe()
 and init()
Message-ID: <Y36hMtARoGy2YULP@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-7-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-7-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:55:01PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Continuing to use pci_host_common_probe() for the PCIe root complex on
> PolarFire SoC was leading to an extremely large _init() function and
> some unnatural code flow. Re-partition so some tasks are done in
> a _probe() routine, which calls pci_host_common_probe() and then use a
> much smaller _init() function, mainly to enable interrupts after address
> translation tables are set up.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 55 ++++++++++++++------
>  1 file changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index faecf419ad6f..73856647f321 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -381,6 +381,8 @@ static struct {
>  
>  static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
>  
> +static struct mc_pcie *port;
> +
>  static void mc_pcie_fixup_ecam(struct mc_pcie *port, void __iomem *ecam)
>  {
>  	struct mc_msi *msi = &port->msi;
> @@ -1095,7 +1097,34 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct mc_pcie *port;
> +	void __iomem *bridge_base_addr =
> +		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	int ret;
> +
> +	/* Configure address translation table 0 for PCIe config space */
> +	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> +			     cfg->res.start,
> +			     resource_size(&cfg->res));
> +
> +	/* Need some fixups in config space */
> +	mc_pcie_fixup_ecam(port, cfg->win);
> +
> +	/* Configure non-config space outbound ranges */
> +	ret = mc_pcie_setup_windows(pdev, port);
> +	if (ret)
> +		return ret;
> +
> +	/* address translation is up; safe to enable interrupts */

I think that Bjorn mentioned it elsewhere, but consistent capitalisation
would be nice. Otherwise, code movement looks good to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +	ret = mc_init_interrupts(pdev, port);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mc_host_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
>  	void __iomem *bridge_base_addr;
>  	void __iomem *ctrl_base_addr;
>  	int ret;
> @@ -1104,13 +1133,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  	if (!port)
>  		return -ENOMEM;
> -	port->dev = dev;
>  
> -	ret = mc_pcie_init_clks(dev);
> -	if (ret) {
> -		dev_err(dev, "failed to get clock resources, error %d\n", ret);
> -		return -ENODEV;
> -	}
> +	port->dev = dev;
>  
>  	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(port->axi_base_addr))
> @@ -1136,16 +1160,13 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	/* pick vector address from design */
>  	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
>  
> -	/* Configure Address Translation Table 0 for PCIe config space */
> -	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
> -			     cfg->res.start, resource_size(&cfg->res));
> -
> -	ret = mc_pcie_setup_windows(pdev, port);
> -	if (ret)
> -		return ret;
> +	ret = mc_pcie_init_clks(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to get clock resources, error %d\n", ret);
> +		return -ENODEV;
> +	}
>  
> -	/* address translation is up; safe to enable interrupts */
> -	return mc_init_interrupts(pdev, port);
> +	return pci_host_common_probe(pdev);
>  }
>  
>  static const struct pci_ecam_ops mc_ecam_ops = {
> @@ -1168,7 +1189,7 @@ static const struct of_device_id mc_pcie_of_match[] = {
>  MODULE_DEVICE_TABLE(of, mc_pcie_of_match);
>  
>  static struct platform_driver mc_pcie_driver = {
> -	.probe = pci_host_common_probe,
> +	.probe = mc_host_probe,
>  	.driver = {
>  		.name = "microchip-pcie",
>  		.of_match_table = mc_pcie_of_match,
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
