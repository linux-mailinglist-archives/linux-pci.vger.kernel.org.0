Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053655452E8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbiFIR0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbiFIRZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 13:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A369B79;
        Thu,  9 Jun 2022 10:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5031361BB6;
        Thu,  9 Jun 2022 17:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9E5C34114;
        Thu,  9 Jun 2022 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654795552;
        bh=LRXZrTeIfc/3UjoxAqS+VWrDiLI0ppGgIhrh3HyHgZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MQjB4azLUJEdeltSFXYBvNCenrXYvpToyYU4mAcKTRlZJTLz0YEdfhiDMgiOOYeh+
         V9XB/uIgb6VERaxRZdFgwFqJs2bVq+5lVvS76QJOU3ljv7wtE2DSx+eVncXit1oNaF
         niqHR3ydolPb8ctajta6HlDOf9kGUWGcerCvAI+BxWZV5tJAKfk6XKgPtIM0up9dX0
         fVCAuPKFxSDaG7lOqn5RFL0fSq47MmycHbkJsnwnqRoqpaKYdBP8bgVG0cl9FPtn40
         Saq8VFx6B2WFxiLodw9RA8Kiq9hSY7oS++OC3uK+FHZMtTL9/23BVRrCg/9vdCqt1F
         JE/oHicJMGtYg==
Date:   Thu, 9 Jun 2022 12:25:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     miles.chen@mediatek.com, Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Fix refcount leak in
 mtk_pcie_init_irq_domains
Message-ID: <20220609172550.GA519198@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601041259.56185-1-linmq006@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 08:12:58AM +0400, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied to pci/ctrl/mediatek-gen3 with Miles' reviewed-by and
Jianjun's ack, thanks!

> ---
> changes in v2:
> - move of_node_put(intc_node) right after irq_domain_add_linear to cover
> normal path and error paths.
> ---
> changes in v3:
> - call of_node_put() in error paths with goto, and call of_node_put() before
>   return 0 in normal path. Since this function has a goto part to handle
>   resources, so put them together, as suggested by Miles Chen <miles.chen@mediatek.com>
> 
> v1 link: https://lore.kernel.org/all/20220526110246.53502-1-linmq006@gmail.com/
> v2 link: https://lore.kernel.org/all/20220530064807.34534-1-linmq006@gmail.com/
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 3e8d70bfabc6..bceed28446ed 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -600,7 +600,8 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
>  						  &intx_domain_ops, pcie);
>  	if (!pcie->intx_domain) {
>  		dev_err(dev, "failed to create INTx IRQ domain\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_put_node;
>  	}
>  
>  	/* Setup MSI */
> @@ -623,13 +624,15 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
>  		goto err_msi_domain;
>  	}
>  
> +	of_node_put(intc_node);
>  	return 0;
>  
>  err_msi_domain:
>  	irq_domain_remove(pcie->msi_bottom_domain);
>  err_msi_bottom_domain:
>  	irq_domain_remove(pcie->intx_domain);
> -
> +out_put_node:
> +	of_node_put(intc_node);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
