Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8AF51497A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359330AbiD2Mjg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359305AbiD2Mjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 08:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 842A65AEDD
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651235777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tmPALbAB2aFHap4uYCwyzn1Tmk9I3K+tWth9ftQrgaY=;
        b=EY3M1kSm4wT8l9wufLyrDwpugLXaS+8TFkeYQGMadx5wQlAobt9kl4yRDwhZtUGVT5xoqQ
        StXpUWrwILt9zjv79Soyv54DqK1oITYWHwotNYihZfPRlZzIoUhUEIZGqoNLR7JQBYNMuz
        OLxHNl8G54VG8/yd740H//3wsbn4uTU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-IUJ7Dyz5MvCpMux0yNDyWg-1; Fri, 29 Apr 2022 08:36:15 -0400
X-MC-Unique: IUJ7Dyz5MvCpMux0yNDyWg-1
Received: by mail-qv1-f69.google.com with SMTP id b8-20020a056214002800b0044666054d36so5852781qvr.12
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 05:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tmPALbAB2aFHap4uYCwyzn1Tmk9I3K+tWth9ftQrgaY=;
        b=a1TSar/feXx7R9WuN6vdcrOoYJtD5+BXghm0BHlnLktStEesGJ7cq9XVE9drQD7+aQ
         XcyrYe0g0IOzujM0AlCtYz9cL+ubBUbgwSB7jfmZYieJCzQyGQeKt4y2gq35BUAR1biW
         oU3wh54mfUveN5pTN02brN+KTZXDIWED7sUhW9imjoqju9HenIR9PJUEnU3JZSZLkuRn
         pxdZ+azO4Hccr+MKqL4tDdsG+gdNDQilfhFKz6Y34u11bw03lV1MNdzwrtQtwLm3vmmI
         /3a1TzS0bmdO3yTQxNRP6IzAvb4IxN0r5Rhu89q7WeVnHuqKjfYezbj7QqIy4tkVlQ1a
         S2Yw==
X-Gm-Message-State: AOAM530jLaDpt/YMhGxqlGT1pPh/w3p5gbR8ZCXgOFCWq5y/IPmRjSsW
        untHoj13yAvnJVWjDY0xpVPDCI9CKsasfPNL8HW9SrLuKBEDeDSHNoY7ncyCoPSHJl+oY0z2dDi
        K+01iK7gdgAiDrT3dKAY4
X-Received: by 2002:ae9:c30d:0:b0:69e:bd20:40cc with SMTP id n13-20020ae9c30d000000b0069ebd2040ccmr22855194qkg.10.1651235775349;
        Fri, 29 Apr 2022 05:36:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR/e2gvH8C2pX3ZYsnNabO4ZISvCIsY0TiWhX1g+iYQGQTh69cKbIxck8xvTa6d132FN2MyQ==
X-Received: by 2002:ae9:c30d:0:b0:69e:bd20:40cc with SMTP id n13-20020ae9c30d000000b0069ebd2040ccmr22855187qkg.10.1651235775101;
        Fri, 29 Apr 2022 05:36:15 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id h75-20020a379e4e000000b0069db8210ffbsm1383072qke.12.2022.04.29.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:36:14 -0700 (PDT)
Date:   Fri, 29 Apr 2022 07:36:12 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, mani@kernel.org,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH] PCI: qcom-ep: check return value after calling
 platform_get_resource_byname()
Message-ID: <20220429123612.sugqipgfmyy2xc6s@halaneylaptop>
References: <20220429080740.1294797-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429080740.1294797-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 04:07:40PM +0800, Yang Yingliang wrote:
> If platform_get_resource_byname() fails, 'mmio_res' will be set to null pointer,
> it will cause null-ptr-deref when it used in qcom_pcie_perst_deassert(), so we
> need check the return value.
> 
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 6ce8eddf3a37..becb0c2ff870 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -416,6 +416,10 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
>  
>  	pcie_ep->mmio_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  							 "mmio");
> +	if (!pcie_ep->mmio_res) {
> +		dev_err(dev, "Failed to get mmio resource\n");
> +		return -EINVAL;
> +	}
>  
>  	syscon = of_parse_phandle(dev->of_node, "qcom,perst-regs", 0);
>  	if (!syscon) {
> -- 
> 2.25.1
> 

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

