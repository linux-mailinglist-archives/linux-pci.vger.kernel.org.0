Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0E535313
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbiEZSBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiEZSBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 14:01:50 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11FBA76DC;
        Thu, 26 May 2022 11:01:49 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id u140so579233oie.3;
        Thu, 26 May 2022 11:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0JqQalKaWiG8XHYe0XLumPJRaO/INlcWZjb1nLCW2s=;
        b=ZRE6UTFXd9xntktF1oVeXj//soBHiBsYcmgNR9tKkeY5x5llysCy0/0t8qCJL0T6Nx
         A2YU1NsMyAWVp7QoxT8iFMRE7z6IQEaXiiz21jjk1iD35U2GkqDenkdyDNRupPMiVtwq
         L91/xuR71HERQZK7pvL8Vo9VZuunN2ycEXMdDltNia7txUBXa3u71BvVHsQW+bzgPxWx
         KsIyOjN+yHeDD+4VVJr82bAmVAZtMvp5B0RKinT5EIxL7jCzgY6yNS9z2qWDDhHgcBsO
         rDKJnh+SEyoR1w4sbUVCUCH7/SQ3rOnwzBX06xexSr4AluvX5SlxS1dvD1jdLA0s0gFx
         Xa9w==
X-Gm-Message-State: AOAM533gB2uVHEbXbvNYA8uYq1sJbItoJ4MCyhI000UloFDZWsw4UIQE
        UviTWNFK/Pt5fH6dv6hU2A==
X-Google-Smtp-Source: ABdhPJy3x+eYjWH16bJov5lyVoqYTbS9OyPH7C/p51KQNNVQR9X+y1THAxgvsY2mWgKvcafvLZGIdw==
X-Received: by 2002:a05:6808:138d:b0:32b:cbd6:129f with SMTP id c13-20020a056808138d00b0032bcbd6129fmr442122oiw.258.1653588108821;
        Thu, 26 May 2022 11:01:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m14-20020a056820050e00b0040eb1d3f43dsm935248ooj.2.2022.05.26.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:01:48 -0700 (PDT)
Received: (nullmailer pid 67657 invoked by uid 1000);
        Thu, 26 May 2022 18:01:40 -0000
Date:   Thu, 26 May 2022 13:01:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 02/10] PCI: dwc: Propagate error from
 dma_mapping_error()
Message-ID: <20220526180140.GA54904-robh@kernel.org>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
 <20220513172622.2968887-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513172622.2968887-3-dmitry.baryshkov@linaro.org>
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

On Fri, May 13, 2022 at 08:26:14PM +0300, Dmitry Baryshkov wrote:
> If dma mapping fails, dma_mapping_error() will return an error.
> Propagate it to the dw_pcie_host_init() return value rather than
> incorrectly returning 0 in this case.
> 
> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

There's already a similar fix applied.

> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f32d964..a9a31e9e7b6e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -396,8 +396,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  						      sizeof(pp->msi_msg),
>  						      DMA_FROM_DEVICE,
>  						      DMA_ATTR_SKIP_CPU_SYNC);
> -			if (dma_mapping_error(pci->dev, pp->msi_data)) {
> -				dev_err(pci->dev, "Failed to map MSI data\n");
> +			ret = dma_mapping_error(pci->dev, pp->msi_data);
> +			if (ret) {
> +				dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
>  				pp->msi_data = 0;
>  				goto err_free_msi;
>  			}
> -- 
> 2.35.1
> 
