Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836D4543D88
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiFHU0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 16:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiFHU0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 16:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF838719D;
        Wed,  8 Jun 2022 13:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB9261CC8;
        Wed,  8 Jun 2022 20:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AB3C3411C;
        Wed,  8 Jun 2022 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654719959;
        bh=9n03tEEmAqhGngy9FDlsSxvVhf4oGNgIu1WDM3aPpt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MIP/DY9Y9G4P5JHPm50KarY0Kw6xmunpfKz8jD2EgTKriKOeSkhs+925w0zU63F61
         b4fRGE078sIH72iILZIGxgI5eI3PePhKhISUuvbT8ufOebpCzW/bMo/EnITikUMzPJ
         S0Ej0tXoqbKFdKp1dSChRcr3tXHgIZ/ALUJlSthF9ilxlLLBm0f9Ga8TbdG+HYlIpR
         hJwtdREa0MaddcTf2IgGrxkfVgsX0XTQHUA+Vf6LKpZqBjvzWU2nkK8+awAiPNFkyo
         T+vebQXxfxJaWv4wDkGovmzh09abgfIQVW93lWYtBDk0BUc+V5q5DmxLZQtHHkcLEO
         dqDNMkr4LtVkQ==
Date:   Wed, 8 Jun 2022 15:25:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: brcmstb: Fix refcount leak in brcm_pcie_probe
Message-ID: <20220608202557.GA419456@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603130849.38252-1-linmq006@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 05:08:49PM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied with Rob's reviewed-by to pci/ctrl/brcmstb for v5.20, thanks!

> ---
> changes in v2:
> - update Fixes tag.
> v1 Link: https://lore.kernel.org/r/20220602125003.10723-1-linmq006@gmail.com
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 375c0c40bbf8..e3b673441a11 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1597,8 +1597,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		ret = brcm_pcie_enable_msi(pcie);
>  		if (ret) {
>  			dev_err(pcie->dev, "probe of internal MSI failed");
> +			of_node_put(msi_np);
>  			goto fail;
>  		}
> +		of_node_put(msi_np);
>  	}
>  
>  	bridge->ops = pcie->type == BCM7425 ? &brcm_pcie_ops32 : &brcm_pcie_ops;
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
