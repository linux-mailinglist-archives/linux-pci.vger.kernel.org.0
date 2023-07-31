Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F104C769EF3
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 19:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjGaRKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGaRKG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 13:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63D4EE5
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 10:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4536123E
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 17:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE03C433C8;
        Mon, 31 Jul 2023 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690823167;
        bh=ggvXO0ST0j56nZ7jf9QQ3BG53zBDkvd/sUa0IPFnLos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a3V8fAAchOceIynjvRkzXcKSF/KjT9gsGKQmz1oR7HfRQhJLfiP3dHA1Mg0d6o3es
         k+WQ6DlZhekYlvm0khOpt5hAPaERn12DAtVDuJh7nMywK71sHuALC9Try8cBNyWbOg
         SxWP6oMn3C0gdjIX2GzmfWoOw8YuCn6282M3LwqNSxsXfUTzeSANH1sxYJvU5OOveG
         aNBBaoWm8h8o3zgbwJzD6/7vP2S3e4Z+uOpSjpJu7+FEcynKzsupNcRoV9VoLbWhuq
         xhnMOZ+2C+X5zIIv/OfgIwod3fIft7QPuw8Bdyq3MZFgxn0iR6Wj7Q0aTJxzYBF1fL
         XO2FJAf4EM0SA==
Date:   Mon, 31 Jul 2023 12:06:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        palmer@dabbelt.com, fancer.lancer@gmail.com, zong.li@sifive.com
Subject: Re: [PATCH v2] PCI: fu740: Set the number of MSI vectors
Message-ID: <20230731170605.GA14538@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731030626.13283-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 03:06:26AM +0000, Yong-Xuan Wang wrote:
> The iMSI-RX module of DW PCIe controller provide sets of MSI_CTRL_INT_i_*
> registers, and each set can handle 32 MSI interrupts. However, since we
> didn't specify the total number of supported interrupts for the fu740 PCIe
> controller, the driver previously only enable 1 set of MSI_CTRL_INT_i_*
> registers.
> This patch sets the supported number of MSI vectors to enables all the
> MSI_CTRL_INT_i_* registers on the fu740 PCIe core.

s/controller provide sets/controller provides sets/
/only enable/only/enabled/
s/to enables all the/to enable all the/

Separate pargraphs with blank lines.

Write in imperative mood, i.e.,

  Set the supported number of MSI vectors to enable all the ...

> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> Changelog
> v2:
> - recast the subject and the commit message
> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 0c90583c078b..1e9b44b8bba4 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -299,6 +299,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  	pci->pp.ops = &fu740_pcie_host_ops;
> +	pci->pp.num_vectors = MAX_MSI_IRQS;
>  	/* SiFive specific region: mgmt */
>  	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
> -- 
> 2.17.1
> 
