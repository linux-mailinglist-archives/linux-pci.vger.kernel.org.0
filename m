Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF57C0129
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjJJQFQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjJJQE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 12:04:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16910C4;
        Tue, 10 Oct 2023 09:04:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66636C433C9;
        Tue, 10 Oct 2023 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953865;
        bh=CPjakDH/b/NnLZYhG6qAlFTOBENXy2ZPobzsoGHhlUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oKoB9O5WH9REfKO57RoBNap5FlOCwlHa5tWCMjXkqpZGOdyHCWTAd/nvxQGrRbScf
         RmwSZew+Hu9gAxh/XrnU6Gya5EylyR2BhX5LJfw9MiSoYPYbFPfmQJRa4vmK1LIcK4
         fxKkbPA6DLOwewexCElKjkUTlw9mGdpspzauxvuSpU6QPr1TyBnR/bahgwJ5YaHJ1j
         hNeS5F5I498tCazwxNI4y89y8FYggplvKSaAf7OHXnl3X7QF1pUA7Bd+o2pXlPMrZr
         fXQlXzmmPEzoenCDb3Mtcx8FCJTO8Ouz8pa8WSGpx3WZqQ7uI1YNZfUMsnC82m26/x
         +zK+IfiHqRekg==
Date:   Tue, 10 Oct 2023 11:04:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] PCI: mediatek-gen3: fix PCIe #PERST being de-asserted
 too early
Message-ID: <20231010160423.GA977719@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR-7Nm2c5s4kuOp0@pidgin.makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 06, 2023 at 09:45:58AM +0200, Daniel Golle wrote:
> The driver for MediaTek gen3 PCIe hosts de-asserts all reset
> signals at the same time using a single register write operation.
> Delay the de-assertion of the #PERST signal by 100ms as required by
> PCIe CEM clause 2.2, some PCIe devices fail to come up otherwise.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index e0e27645fdf4..ba8cfce03aad 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -350,7 +350,13 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)

I feel like I'm missing something because this patch seems to be
adding a delay for T_PVPERL, but the comment before the existing
msleep() claims *it* is the T_PVPERL delay:

         * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
         * and 2.2.1 (Initial Power-Up (G3 to S0)).
         * The deassertion of PERST# should be delayed 100ms (TPVPERL)
         * for the power and clock to become stable.

>  	msleep(100);
>  
>  	/* De-assert reset signals */
> -	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> +	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
> +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +
> +	msleep(100);

So I'm confused about these two sleeps.  Are they for different
parameters?

T_PVPERL is defined from "Power stable to PERST# inactive".  Do we
have any actual indication of when to start that delay, i.e., do we
have a clue about when power became stable?

> +	/* De-assert PERST# signals */
> +	val &= ~(PCIE_PE_RSTB);
>  	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>  
>  	/* Check if the link is up or not */
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
