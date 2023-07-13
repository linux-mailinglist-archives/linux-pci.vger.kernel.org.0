Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB97526FF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjGMP3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjGMP30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 11:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415E2D51
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 08:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20B1661A05
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 15:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0819FC433D9;
        Thu, 13 Jul 2023 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262160;
        bh=CY4JDQBpi5drm8CS73V87lUEw94G6P6TGnEhz/2bAHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fETFFyA6sE1BkfaQXd89hoisYHu+Zy8+r7MFAFMv6rJJL2FIC0C9RdDIHbR87D+np
         Z0ukyrsdJCNhSrkQJcViQjyj2bsucKVLuRp9emxLA6EPHg1DRHIqxIHtiIu3LTKgOl
         aNxIEpFIiz9TlJGurhf0ppCXRJ8mlY8Cm+U0DVGpfrJxzgvQIiHQpHNXyXw4fDCOwJ
         DmLneSs816QfUj5VMC1ZoO52USboSHlWZqy1auZaA5mHunLPw5jIAuKHOCrOBUdftq
         dd1JsqTIQqmAOTjpOp7u061NXoncImerTnRraiRWRPNUWEqc6ADH/99VxzW1ztZbQm
         vcahNk9yfKDSg==
Date:   Thu, 13 Jul 2023 10:29:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        palmer@dabbelt.com
Subject: Re: [PATCH] PCI: fu740: Set the number of msix vectors
Message-ID: <20230713152917.GA317416@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712072311.27433-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 07:23:11AM +0000, Yong-Xuan Wang wrote:
> The fu740 PCIe has 256 msix vectors. We need to specify it in driver code
> to enable more msix vectors.

s/msix/MSI-X/ in subject and commit log to match spec usage.

Also, recast the commit log so it says *what the patch does*, not
"what we need to do."

> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
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
>  
>  	/* SiFive specific region: mgmt */
>  	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
> -- 
> 2.17.1
> 
