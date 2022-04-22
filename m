Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4750BCC8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378992AbiDVQY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 12:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiDVQY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 12:24:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AD75AA48;
        Fri, 22 Apr 2022 09:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 847FAB831AE;
        Fri, 22 Apr 2022 16:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94321C385A4;
        Fri, 22 Apr 2022 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650644490;
        bh=etqmrdOWo9ppgctMHAaKf/sfoIrdAB76WJWQZwxQ2Gg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A+6/RqeaXjNWl8zQqLBCX3hXYA+0YsyIWRltY82UNGQpLHI8QHudEkEJ4XjKigLSF
         Oi/fcCZ3cniW0P4EcokdUA3CxbxJ5boJcItodWn6KARz+JfiY1aU79zTWcL7X2TfGh
         r44U/1clREJMGFahvXWw/rriH9wO4EOWMwIhtnSLPBBFV8BdRUAswPqd0mUlRqA3P+
         Vt5+MxosXyI8KqZkA3HbiIUk1a/3DuJ5RVue0DrFTbcEb9zbpEDWb52plrSqA1FVH2
         /J8QcMM95G60eo+X7+Y8fBmu33+GCGmG8qKTmkNnTfwc52Q+hqrLLUY95qgc/0TDLn
         EQBXZpjTn4iJQ==
Date:   Fri, 22 Apr 2022 11:21:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Update entries to distinguish
 MediaTek PCIe controller
Message-ID: <20220422162126.GA1458908@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422070908.14043-1-jianjun.wang@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 03:09:08PM +0800, Jianjun Wang wrote:
> Update driver entries in pcie-mediatek-gen3.c to distinguish the
> MediaTek PCIe controllers.

What's the reason for doing this?  I *think* it has something to do
with the fact that we currently have two "mtk_pcie_driver"
definitions: one in pcie-mediatek.c and the other in
pcie-mediatek-gen3.c, and apparently we want to make them different.

I can buy that.  But there are many other symbols with the same names
in the two drivers, e.g., mtk_pcie_probe(), mtk_pcie_remove().  Why is
mtk_pcie_driver special?

Maybe it's important that the of_device_id[] names be different?

This change is fine; I'd just like the commit log to have a little
more explanation of *why* it is useful.

Nit: I don't think this distinguishes the *controllers*.  It looks
like it distinguishes the *drivers*.

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
> Changes in v2:
> Remove the changes in Kconfig description and update the commit message.
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 7705d61fba4c..6745076a02b9 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1011,21 +1011,21 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
>  				      mtk_pcie_resume_noirq)
>  };
>  
> -static const struct of_device_id mtk_pcie_of_match[] = {
> +static const struct of_device_id mtk_pcie_gen3_of_match[] = {
>  	{ .compatible = "mediatek,mt8192-pcie" },
>  	{},
>  };
> -MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
> +MODULE_DEVICE_TABLE(of, mtk_pcie_gen3_of_match);
>  
> -static struct platform_driver mtk_pcie_driver = {
> +static struct platform_driver mtk_pcie_driver_gen3 = {
>  	.probe = mtk_pcie_probe,
>  	.remove = mtk_pcie_remove,
>  	.driver = {
> -		.name = "mtk-pcie",
> -		.of_match_table = mtk_pcie_of_match,
> +		.name = "mtk-pcie-gen3",
> +		.of_match_table = mtk_pcie_gen3_of_match,
>  		.pm = &mtk_pcie_pm_ops,
>  	},
>  };
>  
> -module_platform_driver(mtk_pcie_driver);
> +module_platform_driver(mtk_pcie_driver_gen3);
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
