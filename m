Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B8543E76
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiFHVVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiFHVVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 17:21:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA6194BEF;
        Wed,  8 Jun 2022 14:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 419EDB82B41;
        Wed,  8 Jun 2022 21:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA963C3411E;
        Wed,  8 Jun 2022 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654723260;
        bh=S3UEZv3ead2hOkIPLW7Y042Bs94VzTGvzX0yMk+NxlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rbfxb19Ae3cah/01V7chFtBj+m46O5WTrj4ME78TsGsYH8e3YRinhfNXJoSg4VOft
         4KXfE9px6mQqZUtk3mA2jL8VJNXKk6a4/9ZocluE3GBrstjvkd7sDZBYq/ReztMUew
         kzzLvHqRzpdljwPJNm7fuYNRtDiEDTJSJGb5+SkSsT8Zk+L0bya94XtMGOe/MmQqMo
         R02p6t+mL8QPInjZhu+ZHlDjhPBXpKUJD4jzdYCZXPEjYFUMdHW79wb2r7zBNvWXkg
         CGe1Idm4gzUdd8g6egGBwPZcJ3JPiez0TfHJrH562iHqj/ezcCMpMQGj3brbmqFL14
         aZaq1gPAa+PwA==
Date:   Wed, 8 Jun 2022 16:20:58 -0500
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
Message-ID: <20220608212058.GA424368@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601041259.56185-1-linmq006@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Can we get an ack from Ryder or Jianjun, as well, since they're listed
as maintainers?

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
