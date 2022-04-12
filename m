Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0D4FDF87
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiDLMOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352892AbiDLMMe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 08:12:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0801A84ECD
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 04:13:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7DCB1570;
        Tue, 12 Apr 2022 04:13:56 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.8.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DD5F3F5A1;
        Tue, 12 Apr 2022 04:13:55 -0700 (PDT)
Date:   Tue, 12 Apr 2022 12:14:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, rafael@kernel.org
Subject: Re: [PATCH 16/18] PCI: aardvark: Add suspend to RAM support
Message-ID: <20220412111401.GA20749@lpieralisi>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-17-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220193346.23789-17-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Rafael]

On Sun, Feb 20, 2022 at 08:33:44PM +0100, Marek Behún wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Add suspend and resume callbacks. The priority of these are
> "_noirq()", to workaround early access to the registers done by the
> PCI core through the ->read()/->write() callbacks at resume time.

This commit log should be rewritten to clarify it. IIUC, you are hooking
up the _noirq() callbacks to take advantage of callbacks ordering rather
than needing the IRQ disabled per-se.

Thread here:
https://lore.kernel.org/linux-pci/20220220193346.23789-17-kabel@kernel.org

I'd ask Rafael please if this is common practice or a workaround and
whether that's how it should be done.

Thanks,
Lorenzo

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 39 +++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 3b51f47abd72..8c9ac7766ac7 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1896,6 +1896,44 @@ static int advk_pcie_setup_phy(struct advk_pcie *pcie)
>  	return ret;
>  }
>  
> +static int __maybe_unused advk_pcie_suspend(struct device *dev)
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
> +static int __maybe_unused advk_pcie_resume(struct device *dev)
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
> +/*
> + * The PCI core will try to reconfigure the bus quite early in the resume path.
> + * We must use the _noirq() alternatives to ensure the controller is ready when
> + * the core uses the ->read()/->write() callbacks.
> + */
> +static const struct dev_pm_ops advk_pcie_dev_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(advk_pcie_suspend, advk_pcie_resume)
> +};
> +
>  static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -2171,6 +2209,7 @@ static struct platform_driver advk_pcie_driver = {
>  	.driver = {
>  		.name = "advk-pcie",
>  		.of_match_table = advk_pcie_of_match_table,
> +		.pm = &advk_pcie_dev_pm_ops,
>  	},
>  	.probe = advk_pcie_probe,
>  	.remove = advk_pcie_remove,
> -- 
> 2.34.1
> 
