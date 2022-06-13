Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F297454A0F1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiFMVLs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351961AbiFMVLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:11:18 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28E13BFBA;
        Mon, 13 Jun 2022 13:49:25 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id p69so7435094iod.0;
        Mon, 13 Jun 2022 13:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9y9S2jTfiwYCjZBju7QRApsnUswkLeTkpiFJ2ILbNA=;
        b=ghXNRMIMxlBKTKU8AiEYwXaVRWL/2X9k/16XZ2UV0SZyjfvhcadQJZ00ZXrZFSJaoe
         XNzjO2cX27P9i8XvW4hI9t0YBVALRI54esTjmfKWmkTwLOdey5fO/7UdofItOh2HV6S0
         0/RMd2zicJX/KhvuhNmxY5fqbTFnBDohh4q9EbKVVqAAaw7jfIS9uKVSjvU2Bgz1SsXk
         w6PGTy0d1WT4czea0+SYOlZIa8WlMaty+AjmjvpUyZuXOt+DY7h0hmSJXhrJFkv1DhFg
         VII722q0J6IJ8hQdKx5TCB51dPaWrSStLRsgNtj2zYs9HeI9EDVBSRN1pRJpvdZkZfsQ
         hQww==
X-Gm-Message-State: AOAM533EN4z1XZUWgaUKPLx9+6OTu//yvqtjGhXVp2m2DW962MYhRJFV
        ZJQ0u1m4HPd9nqI/mxGCZA==
X-Google-Smtp-Source: ABdhPJwmUtyMGzOzN7QyE6TdUsITPaeeOFVlVhkuqGn3DW1FVCj2Z7jxSEV6u0Ar3hFvuZYI2JRoPg==
X-Received: by 2002:a05:6602:1410:b0:657:86b8:e641 with SMTP id t16-20020a056602141000b0065786b8e641mr794646iov.188.1655153364901;
        Mon, 13 Jun 2022 13:49:24 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id v7-20020a92c6c7000000b002d3ecb1a58esm4479815ilm.15.2022.06.13.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:49:24 -0700 (PDT)
Received: (nullmailer pid 58164 invoked by uid 1000);
        Mon, 13 Jun 2022 20:49:23 -0000
Date:   Mon, 13 Jun 2022 14:49:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] PCI: dwc: Enable CDM-check independently from
 the num_lanes value
Message-ID: <20220613204923.GB55629-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 11:25:22AM +0300, Serge Semin wrote:
> Currently the embedded CDM IOs consistency check-engine is enabled only if
> the num_lanes field of dw_pcie structure is set to non-zero value. It's
> definitely wrong since the CDM checking has nothing to do with the PCIe
> lanes settings, while that feature will be left disabled for the platforms
> which expect it being enabled and prefer keeping the default lanes setup.
> Let's fix that by enabling the CDM-check feature before the num_lanes
> parameter is handled.
> 
> Fixes: 07f123def73e ("PCI: dwc: Add support to enable CDM register check")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
