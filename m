Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790B4B4C15
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 11:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348400AbiBNKhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 05:37:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349509AbiBNKgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 05:36:35 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8521808
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 02:02:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j4so10120549plj.8
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3FWzPND9WvW0DCoLJOyDC1qp18zJ90FPtYnzhOK7Lxo=;
        b=KkDqPZYoT1GxMGWLVXlXtePwZUwNphej5qr/aPTYk+3Ur0Yl0owRHR/BjCbIQnXSbV
         ocDqX6cwHSGvVdaMbe26s7imwgXGNnpOm6D00/7ZV6l3VGycQc+weDvNfsnPF93+OSDu
         nZWwjjvDVSCzGYbW0VcX6uU0glqmbj5qgV78eAtrAR3XGpc/BgFwjWWvtg5cX73JvYzW
         8L1GE4GBmGlIJxUevAXtbX8F6/ysrVMd/jMIAdf3JPNmqCpwl0KxL04TOO4c5hD6m06A
         wXj77yppe99ACupcU9geF6iMo6T4YNGk9lNFbiP61OAg0Fk0CAtfVRrBo0vrrqRqpc41
         smOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3FWzPND9WvW0DCoLJOyDC1qp18zJ90FPtYnzhOK7Lxo=;
        b=rvqNHa9vPcS6HAvTVi1iBuoN0wUKVWsODuQYGp9K89VSkQKIYyzbuJF4CFo9oIFSB6
         RpCCoflt5kAV2IJ1RnB9dHrGk9pSe2Bcyv3IwVaPNoz57sE8K4J0bZ/Rm3mZ7moYx8cr
         jH0c+tPHQod/4HAAtG/xWqg8Uy4qW8oSrlRUHVvUd5T5Ksw/cHO/CZlqYH6qUyj4MxMo
         9sKykeL/JPqgAuRrTY5ZBzXVi06yw5oNZ1fR4WQ81RyVyoD+EtEm4flJ2Bl2ie2Qd9NF
         W0xiPdZHvoDsPQT1mY9g0hNYi9xTcMFP489FkkU0k4Msl1SiKlfpQhMpE8j0P7L0ghaA
         ybow==
X-Gm-Message-State: AOAM533D8tUUYlt1ZipLyK4S2h/QZTjzglDius2o6t2kNc5RIaVFk5vJ
        7GVTlPVrHd99UipI/4TWJL8Y
X-Google-Smtp-Source: ABdhPJyJ64qK8l+dVZGI6z1v97NAnYSzBQDf2NqUErR/7NdZCcUOASry2EezNzMjZnYRDuGM6dIBPg==
X-Received: by 2002:a17:902:e552:: with SMTP id n18mr13557384plf.152.1644832963831;
        Mon, 14 Feb 2022 02:02:43 -0800 (PST)
Received: from thinkpad ([157.51.138.108])
        by smtp.gmail.com with ESMTPSA id kx5sm13370870pjb.16.2022.02.14.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 02:02:43 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:32:32 +0530
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
Subject: Re: [RFC PATCH 3/5] misc: pci_endpoint_test: Add driver data for
 Renesas RZ/G2{EHMN}
Message-ID: <20220214100116.GK3494@thinkpad>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220126195043.28376-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126195043.28376-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 26, 2022 at 07:50:41PM +0000, Lad Prabhakar wrote:
> Add "dmac_data_alignment" member (indicating the alignment requirement
> for internal DMAC for data transfers) to struct pci_endpoint_test_data
> and add driver_data to Renesas RZ/G2{EHMN}.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 40 ++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8f786a225dcf..0a00d45830e9 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -116,6 +116,7 @@ struct pci_endpoint_test {
>  	struct miscdevice miscdev;
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
> +	size_t dmac_data_alignment;

Alignment is a generic requirement, so this could be "dma_alignment" or
"data_alignment". Eventhough the only current user is internal DMA, this can
also be used by others in the future.

Thanks,
Mani

>  	const char *name;
>  };
>  
> @@ -123,6 +124,7 @@ struct pci_endpoint_test_data {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
>  	int irq_type;
> +	size_t dmac_data_alignment;
>  };
>  
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
> @@ -368,8 +370,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  		goto err;
>  
>  	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> -	if (use_dma)
> +	if (use_dma) {
>  		flags |= FLAG_USE_DMA;
> +		if (test->dmac_data_alignment)
> +			size =  ALIGN(size, test->dmac_data_alignment);
> +	}
>  
>  	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Invalid IRQ type option\n");
> @@ -502,8 +507,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
>  		goto err;
>  
>  	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> -	if (use_dma)
> +	if (use_dma) {
>  		flags |= FLAG_USE_DMA;
> +		if (test->dmac_data_alignment)
> +			size =  ALIGN(size, test->dmac_data_alignment);
> +	}
>  
>  	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Invalid IRQ type option\n");
> @@ -600,8 +608,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
>  		goto err;
>  
>  	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> -	if (use_dma)
> +	if (use_dma) {
>  		flags |= FLAG_USE_DMA;
> +		if (test->dmac_data_alignment)
> +			size =  ALIGN(size, test->dmac_data_alignment);
> +	}
>  
>  	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Invalid IRQ type option\n");
> @@ -787,6 +798,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		test->test_reg_bar = test_reg_bar;
>  		test->alignment = data->alignment;
>  		irq_type = data->irq_type;
> +		test->dmac_data_alignment = data->dmac_data_alignment;
>  	}
>  
>  	init_completion(&test->irq_raised);
> @@ -948,6 +960,12 @@ static const struct pci_endpoint_test_data j721e_data = {
>  	.irq_type = IRQ_TYPE_MSI,
>  };
>  
> +static const struct pci_endpoint_test_data renesas_rzg2x_data = {
> +	.test_reg_bar = BAR_0,
> +	.irq_type = IRQ_TYPE_MSI,
> +	.dmac_data_alignment = 8,
> +};
> +
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
>  	  .driver_data = (kernel_ulong_t)&default_data,
> @@ -965,10 +983,18 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
>  	  .driver_data = (kernel_ulong_t)&am654_data
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),
> +	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
> +	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),
> +	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
> +	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),
> +	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
> +	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),
> +	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
> +	},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>  	  .driver_data = (kernel_ulong_t)&j721e_data,
>  	},
> -- 
> 2.25.1
> 
