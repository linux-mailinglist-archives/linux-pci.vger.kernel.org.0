Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB34B4D38
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 12:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349170AbiBNKtP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 05:49:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348982AbiBNKtE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 05:49:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD49BDA45
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 02:11:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l9so8541169plg.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 02:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TZC2zqnsGdYKa6ED3IQ9bDrMCL7iNxaV9fJORDhdXXQ=;
        b=s68lMju5iEdQddCWAGgZ9FK5zw+gevcdYhSzhov5HJEUNazg4BACE2jOSbbjNAH8n8
         ov/bykvpBolzaTfjrMelg9os0BIQ6zc4fjqcOJwemaUTLeQlBx+u0ZbCB9dtqEMe0Koi
         u1iRhdu/LIjK31Rha7+WK2zTd0fLVqmBj5egOxiVqitgVA9Z/f845dcFrYPOXGiO/0DC
         zaWyAQ3AmN3bGDAlRph7fyH8yqIo6ARx0/fg4ebruIc4f5KmE53x4vUCLFcTwaSY4vKe
         TP6B0Mm0CNydDy0bLgCLGSk1nUL8eb7D+O1pj+Dk3r2DZNyVN7EzchZ+K26LTnNpwTrR
         9XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TZC2zqnsGdYKa6ED3IQ9bDrMCL7iNxaV9fJORDhdXXQ=;
        b=aOwvaEtC09U3C8e5LMXRlNN4+szo1Qlbpg3lDZJzkzA45lFW/Gf/PDWg+QvZdzwNHH
         6iVoQrPvIlOzGTTuDYp/a9JVItht4w/jssSMR0Mp5vtd8mGH1DjMJ33nSudG/oURaxrl
         DYXYr3LGjjl9qo1as8vl0ijU/SDyP/sofzoaKlP1KOfFGFb6Cnc08F1sMwymNW5M1wy5
         HbqNg1F3NC1WklNi01N86nsq62e0h4WnAy/1tr3BiXenzrM+ebvgtGRM0ovw7GvJcIjk
         rlvTDusTXOUR5SXvdWf4Z0PFbTkYQZ5ayYBsRspjNICJkafoYQata7TZpOblHqH94GIx
         9KYg==
X-Gm-Message-State: AOAM533Ml5Aud5OJ2T26vsgX4JvEY+QW3+6gl1iI63IE5ThXi+tKQXPL
        4jl8Ba9O07Nfr76+LpPTJb8U
X-Google-Smtp-Source: ABdhPJwZs3ndm10YO39LbYVx1RxPAULC6DZ65ngqdzYWV2fW1AmJXxHQgwkikX0c8E6JiybbRc52fw==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr8152443pjb.25.1644833515150;
        Mon, 14 Feb 2022 02:11:55 -0800 (PST)
Received: from thinkpad ([2409:4072:817:5a6f:3104:62c0:1941:5033])
        by smtp.gmail.com with ESMTPSA id np15sm4359544pjb.44.2022.02.14.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 02:11:54 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:41:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 4/5] misc: pci_endpoint_test: Add support to pass
 flags for buffer allocation
Message-ID: <20220214101145.GL3494@thinkpad>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220126195043.28376-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126195043.28376-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 26, 2022 at 07:50:42PM +0000, Lad Prabhakar wrote:
> By default GFP_KERNEL flag is used for buffer allocation in read, write
> and copy test and then later mapped using streaming DMA api. But on
> Renesas RZ/G2{EHMN} platforms using the default flag causes the tests to
> fail. Allocating the buffers from DMA zone (using the GFP_DMA flag) make
> the test cases to pass.
> 
> To handle such case add flags as part of struct pci_endpoint_test_data
> so that platforms can pass the required flags based on the requirement.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> This patch is based on the conversation where switching to streaming
> DMA api causes read/write/copy tests to fail on Renesas RZ/G2 platforms
> when buffers are allocated using GFP_KERNEL.
> 
> [0] https://www.spinics.net/lists/linux-pci/msg92385.html
> 
> Cheers,
> Prabhakar
> ---
>  drivers/misc/pci_endpoint_test.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 0a00d45830e9..974546992c5e 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -117,6 +117,7 @@ struct pci_endpoint_test {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
>  	size_t dmac_data_alignment;
> +	gfp_t flags;

gfp_flags? Since this is used for allocation.

Thanks,
Mani

>  	const char *name;
>  };
>  
> @@ -125,6 +126,7 @@ struct pci_endpoint_test_data {
>  	size_t alignment;
>  	int irq_type;
>  	size_t dmac_data_alignment;
> +	gfp_t flags;
>  };
>  
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
> @@ -381,7 +383,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  		goto err;
>  	}
>  
> -	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
> +	orig_src_addr = kzalloc(size + alignment, test->flags);
>  	if (!orig_src_addr) {
>  		dev_err(dev, "Failed to allocate source buffer\n");
>  		ret = false;
> @@ -414,7 +416,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  
>  	src_crc32 = crc32_le(~0, src_addr, size);
>  
> -	orig_dst_addr = kzalloc(size + alignment, GFP_KERNEL);
> +	orig_dst_addr = kzalloc(size + alignment, test->flags);
>  	if (!orig_dst_addr) {
>  		dev_err(dev, "Failed to allocate destination address\n");
>  		ret = false;
> @@ -518,7 +520,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
>  		goto err;
>  	}
>  
> -	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> +	orig_addr = kzalloc(size + alignment, test->flags);
>  	if (!orig_addr) {
>  		dev_err(dev, "Failed to allocate address\n");
>  		ret = false;
> @@ -619,7 +621,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
>  		goto err;
>  	}
>  
> -	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> +	orig_addr = kzalloc(size + alignment, test->flags);
>  	if (!orig_addr) {
>  		dev_err(dev, "Failed to allocate destination address\n");
>  		ret = false;
> @@ -788,6 +790,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	test->alignment = 0;
>  	test->pdev = pdev;
>  	test->irq_type = IRQ_TYPE_UNDEFINED;
> +	test->flags = GFP_KERNEL;
>  
>  	if (no_msi)
>  		irq_type = IRQ_TYPE_LEGACY;
> @@ -799,6 +802,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		test->alignment = data->alignment;
>  		irq_type = data->irq_type;
>  		test->dmac_data_alignment = data->dmac_data_alignment;
> +		test->flags = data->flags;
>  	}
>  
>  	init_completion(&test->irq_raised);
> @@ -947,23 +951,27 @@ static const struct pci_endpoint_test_data default_data = {
>  	.test_reg_bar = BAR_0,
>  	.alignment = SZ_4K,
>  	.irq_type = IRQ_TYPE_MSI,
> +	.flags = GFP_KERNEL,
>  };
>  
>  static const struct pci_endpoint_test_data am654_data = {
>  	.test_reg_bar = BAR_2,
>  	.alignment = SZ_64K,
>  	.irq_type = IRQ_TYPE_MSI,
> +	.flags = GFP_KERNEL,
>  };
>  
>  static const struct pci_endpoint_test_data j721e_data = {
>  	.alignment = 256,
>  	.irq_type = IRQ_TYPE_MSI,
> +	.flags = GFP_KERNEL,
>  };
>  
>  static const struct pci_endpoint_test_data renesas_rzg2x_data = {
>  	.test_reg_bar = BAR_0,
>  	.irq_type = IRQ_TYPE_MSI,
>  	.dmac_data_alignment = 8,
> +	.flags = GFP_KERNEL | GFP_DMA,
>  };
>  
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
> -- 
> 2.25.1
> 
