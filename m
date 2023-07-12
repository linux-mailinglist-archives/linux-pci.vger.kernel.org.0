Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118EA750463
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 12:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjGLK2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLK2G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 06:28:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3144C2
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2023 03:28:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b698937f85so111338521fa.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2023 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689157684; x=1691749684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MDnpbQW6MKptLXRw2ikgYx+YDaU7y99YWItJjmroTg=;
        b=K9ie4d9pGLJqesCUP0wCNTDflHUEgOClatDYGY3ii5p9o+6tLMWuPn/djjlMwzC/cV
         8mBcrr/F7VXNmOZxYGE5QBUF7tGRNHawq3k4wRXHINSJNv+e4VUo7Sm0PKRgaKvHRILf
         NwcFk5qV2wJ/czSW5Y+PFmDjLCfwB+3HUQt0e+goAS3Xb7AbTm7PUi8ObM6VaVte3f1V
         SWnFE+A/5xbo92ve90H+3GAz/OP8IoHaZjkm1fv0/waQCOhtXs1fkOaTW+oFclIhfmvP
         Y21yY2w27Zo5Mt9R1MVarS2OJOg2SpCss0ZE0oo7Ir8qo0xUAW7gamVmRgPPQoaGEBgZ
         YUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689157684; x=1691749684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MDnpbQW6MKptLXRw2ikgYx+YDaU7y99YWItJjmroTg=;
        b=XtlAiHqMW0iXbh4lKJRj7symubaK49XC5gk8138FujcGED8tF9PnHh2EzjCJOfg6eB
         fgUa36pu19VNle8YJqu62JLD3i/Xap5Zryy8HYL6gQRBlObvCrJi7ApZgUR70j/8Avxy
         196vE5JW42JWX+I0/tn3t4XGpq5H0pSXXYYjb36Cg3YyXX5MnszV5G4rquAuBLcqWijT
         H+Nh5VTd/BZbqDp2cMSlmwSiliinM4GAP1ZDvqE2D5jpwHarOvVwdzaLnWwujCpUSu1A
         n1OaAZLxyXYWB7KxUoLQi8I7Mehy0Jtvb/HrYU3WNV/htoX9SEskmXz+qUSj6y0cmA6Z
         QSDg==
X-Gm-Message-State: ABy/qLac5H/c0MlR7LQqu868QK2+V619ccS45oxrpDyAUmGtGZh4GYZ2
        sTYuSkqdAMcB4VRmXdRjTXQ=
X-Google-Smtp-Source: APBJJlErUBAROjOqaeZQjhHPcw59Os5PiMLIfnrvPCSSiWWURAwQxiJqLr7pFJmCoO7ovGrkfMEWZg==
X-Received: by 2002:a2e:9b4f:0:b0:2b6:d8e4:71b3 with SMTP id o15-20020a2e9b4f000000b002b6d8e471b3mr15958006ljj.21.1689157683624;
        Wed, 12 Jul 2023 03:28:03 -0700 (PDT)
Received: from mobilestation ([85.249.22.88])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e8042000000b002b6b60c14besm899201ljg.29.2023.07.12.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:28:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 13:28:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        palmer@dabbelt.com
Subject: Re: [PATCH] PCI: fu740: Set the number of msix vectors
Message-ID: <bbls4bo2qo4hl7nnnl3me7dapg3rgkzu2zl64yjs33jqkcl5cw@cueakkkfg3xb>
References: <20230712072311.27433-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712072311.27433-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 07:23:11AM +0000, Yong-Xuan Wang wrote:
> The fu740 PCIe has 256 msix vectors. We need to specify it in driver code
> to enable more msix vectors.

AFAIR DW PCIe RP doesn't support MSI-X. It's just MSI implemented in
the framework of iMSI-RX engine. There can be up to eight
MSI_CTRL_INT_i_* registers enabled each of which is equipped with 32
doorbells. The control register and the doorbell flag IDs are encoded
by the MSI data: [7:5] - MSI_CTRL_INT_* register, [4:0] - doorbell. So
when an MSI MWr TLP arrives DW PCIe RP controller detects it by the
target address, then parses its data and raises the IRQ with the
respective doorbell set. Such TLPs is never transferred further to the
system then.

So I'd fix the commit message respectively. Other than that the change
looks good.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
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
