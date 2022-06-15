Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A154D232
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiFOT7s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 15:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbiFOT7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 15:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE2381AE;
        Wed, 15 Jun 2022 12:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F3061418;
        Wed, 15 Jun 2022 19:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B44C34115;
        Wed, 15 Jun 2022 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655323154;
        bh=gLU9FNk8nWDVMI83UqR0Bx/ijIXX/FVmaX52WhrT0cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QaoHgEsict8qsyWnZOYdhQU7L1N50RebxDgbgmc1CiSDMm9eFnQpkZ3mSPTtLxHnK
         dFHzuQGXgLz5ZzzVJE67ulLHDwjqAsiDDtEnXcWJLh9s9I323EAK7RsrHJPZT7t69m
         w0jC7meTqK0uTC8wPWRQhL6q9Rq/jUEEOfQ0VRfaUt685+BE/VP/Glzo1q7c0mRkfQ
         wWlaBgKMXmNXQtLaMQqzPSSlxV9AbM9O1eR/WphxRYtJTaZRwGtfMDZWPY2VL1zEKS
         pkwwv+K3m8t9Rn0HGL6wB14aJLVP7NIZTJeWhlmQ2N7fs8iepePyiFNVt063tle3zc
         BH31L829XiCdQ==
Date:   Wed, 15 Jun 2022 14:59:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Print LTSSM state when PCIe link
 down
Message-ID: <20220615195912.GA1024264@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329030715.7975-1-jianjun.wang@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 11:07:15AM +0800, Jianjun Wang wrote:
> Print current LTSSM state when PCIe link down instead of the register
> value, make it easier to get the link status.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> Changes in v2:
> Print both of the register value and the LTSSM state.

Applied to pci/ctrl/mediatek-gen3 for v5.20, thanks!

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 41 ++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 6745076a02b9..c24e03c198b7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -153,6 +153,37 @@ struct mtk_gen3_pcie {
>  	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
>  };
>  
> +/* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
> +static const char *const ltssm_str[] = {
> +	"detect.quiet",			/* 0x00 */
> +	"detect.active",		/* 0x01 */
> +	"polling.active",		/* 0x02 */
> +	"polling.compliance",		/* 0x03 */
> +	"polling.configuration",	/* 0x04 */
> +	"config.linkwidthstart",	/* 0x05 */
> +	"config.linkwidthaccept",	/* 0x06 */
> +	"config.lanenumwait",		/* 0x07 */
> +	"config.lanenumaccept",		/* 0x08 */
> +	"config.complete",		/* 0x09 */
> +	"config.idle",			/* 0x0A */
> +	"recovery.receiverlock",	/* 0x0B */
> +	"recovery.equalization",	/* 0x0C */
> +	"recovery.speed",		/* 0x0D */
> +	"recovery.receiverconfig",	/* 0x0E */
> +	"recovery.idle",		/* 0x0F */
> +	"L0",				/* 0x10 */
> +	"L0s",				/* 0x11 */
> +	"L1.entry",			/* 0x12 */
> +	"L1.idle",			/* 0x13 */
> +	"L2.idle",			/* 0x14 */
> +	"L2.transmitwake",		/* 0x15 */
> +	"disable",			/* 0x16 */
> +	"loopback.entry",		/* 0x17 */
> +	"loopback.active",		/* 0x18 */
> +	"loopback.exit",		/* 0x19 */
> +	"hotreset",			/* 0x1A */
> +};
> +
>  /**
>   * mtk_pcie_config_tlp_header() - Configure a configuration TLP header
>   * @bus: PCI bus to query
> @@ -327,8 +358,16 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  				 !!(val & PCIE_PORT_LINKUP), 20,
>  				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
>  	if (err) {
> +		const char *ltssm_state;
> +		int ltssm_index;
> +
>  		val = readl_relaxed(pcie->base + PCIE_LTSSM_STATUS_REG);
> -		dev_err(pcie->dev, "PCIe link down, ltssm reg val: %#x\n", val);
> +		ltssm_index = PCIE_LTSSM_STATE(val);
> +		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
> +			      "Unknown state" : ltssm_str[ltssm_index];
> +		dev_err(pcie->dev,
> +			"PCIe link down, current ltssm state: %s (%#x)\n",
> +			ltssm_state, val);
>  		return err;
>  	}
>  
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
