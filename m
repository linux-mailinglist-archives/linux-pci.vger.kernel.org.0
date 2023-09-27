Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4B7B0495
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjI0Mqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjI0Mq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 08:46:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3616C0;
        Wed, 27 Sep 2023 05:46:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9FAC433C8;
        Wed, 27 Sep 2023 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695818788;
        bh=yur1lIib+MwlO3G13u5slhNv5izV70kTNuXNh85akv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCKu0Q83mtA+/cOefVFb4tQpEBvyJOqtu9iQ6NQiatNAdI4ptP52X2BoZwD6ToknT
         H1LzC/biabj/L2oKT3gPEC3fNlrLY5sCnYelvnyItmu3MW+e9tHaD/iIvGM9jq74Su
         cjhozkVVEkuCbqNcZsmRdwjCou8lxdFd1/dyvo481oLo+kF+Y9XMsMgIAZ4CuomM+U
         dEcsdT2z2qQArfP7MJbs0bpQgg9vp3FSpPsG5jcME63VN4IlM1FUTUbhAP5lTa/mVt
         KMIB960gL8I2Nm9GxoR9CXm7FevWBgwfuCRk1k5Uc0gRrWGsNOA+xURidh1tUE7GAx
         gEnrE4Mah85AA==
Date:   Wed, 27 Sep 2023 14:46:21 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     hch@infradead.org, bhelgaas@google.com,
        christophe.jaillet@wanadoo.fr, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 1/1] PCI: layerscape-ep: set 64-bit DMA mask
Message-ID: <20230927124621.GD18050@thinkpad>
References: <20230926140445.3855365-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926140445.3855365-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 26, 2023 at 10:04:45AM -0400, Frank Li wrote:
> From: Guanhua Gao <guanhua.gao@nxp.com>
> 
> Set DMA mask and coherent DMA mask to enable 64-bit addressing.
> 
> Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     change from v2 to v3
>     - remove check return value of dma_set_mask_and_coherent. 64bit mask always
>     return success.
>     - remove redundate comments
>     change from v1 to v2
>     - Remove 32bit DMA mask set.
> 
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index de4c1758a6c3..2c2c9aaa8700 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -249,6 +249,8 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  
>  	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
>  
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = dw_pcie_ep_init(&pci->ep);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
