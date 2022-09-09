Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBC5B354F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIIKdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 06:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIIKdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 06:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FCB1EAF4
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 03:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B9961F87
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 10:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876BEC433C1;
        Fri,  9 Sep 2022 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662719588;
        bh=EfvzWZrKII824bXgNsNQt6eOqf8Mu/ndVvumX1L72VA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHDVzHwUlbpyVoHOop4WXhtctVZzK/tobvkC1V4TCwVsCA4ZImB0wRXDzN83TJAzS
         +GLBdPgIscDFQjIAsu5c4NqQL6HfGLVY8gYKX6WxUygTvXLPhXqwq7BsdkVe2HCNDD
         vL1IEpdyfHjS+PyVbwFloEoDqMAsPDpozoqsP6fJNFl5CdMi/Lgj8h74iN1VCq1p2N
         S6VG6wU+/hXPypsy6Ge4b/miuU7Uap6E02ntgHtpnNvYdDwiYM3XIgZ+h3kIwpzqvM
         YYOjN5bSWpVNalICvqLhdSW8oOjN3UDa0U3KNdLTF+M1cZxxazUuYl8v+U9EtABDoU
         4TQuTUgZy4LKQ==
Date:   Fri, 9 Sep 2022 12:33:01 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 07/11] PCI: aardvark: Add suspend to RAM support
Message-ID: <YxsWXSysbgfTHY47@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-8-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818135140.5996-8-kabel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 03:51:36PM +0200, Marek Behún wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Add suspend and resume callbacks. We need to use the NOIRQ variants to
> ensure the controller's IRQ handlers are not run during suspend() /
> resume(), which could cause races.

Be more explicit please, which races, which IRQ handlers. This is useful
information for future testers/reviewers in case something has to be
changed, thanks.

Lorenzo

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
> Changes since batch 5:
> - clarified commit message
> - changed to new macro NOIRQ_SYSTEM_SLEEP_PM_OPS, as was done for many
>   PCI controller drivers with commit 19b7858c3357 ("PCI: Convert to new
>   *_PM_OPS macros")
> ---
>  drivers/pci/controller/pci-aardvark.c | 34 +++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 3beafc893969..e30a33a4ecc6 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1890,6 +1890,39 @@ static int advk_pcie_setup_phy(struct advk_pcie *pcie)
>  	return ret;
>  }
>  
> +static int advk_pcie_suspend(struct device *dev)
> +{
> +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> +
> +	advk_pcie_disable_phy(pcie);
> +
> +	clk_disable_unprepare(pcie->clk);
> +
> +	return 0;
> +}
> +
> +static int advk_pcie_resume(struct device *dev)
> +{
> +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = advk_pcie_enable_phy(pcie);
> +	if (ret)
> +		return ret;
> +
> +	advk_pcie_setup_hw(pcie);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops advk_pcie_dev_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(advk_pcie_suspend, advk_pcie_resume)
> +};
> +
>  static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -2167,6 +2200,7 @@ static struct platform_driver advk_pcie_driver = {
>  	.driver = {
>  		.name = "advk-pcie",
>  		.of_match_table = advk_pcie_of_match_table,
> +		.pm = &advk_pcie_dev_pm_ops,
>  	},
>  	.probe = advk_pcie_probe,
>  	.remove = advk_pcie_remove,
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
