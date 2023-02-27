Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753E26A4BC5
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 20:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjB0T4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 14:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjB0Tz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 14:55:56 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE927487;
        Mon, 27 Feb 2023 11:55:37 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id b10-20020a4aba0a000000b005200c0d4a2aso1182743oop.11;
        Mon, 27 Feb 2023 11:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi77Q6Z8Ff9qsnZSuzIme0IaEFZzAF96yr6jKLT/oNY=;
        b=SRujPQTf8ADse0J8OKENRUhyL3irU3TJLqlFVW61b61irn+fBZ4dWq7rLoLnuVmLxF
         zXbR4ZY3QwqOEBCsbTvQc1MuV/X8QRQXvNf8P22dB/wJj7SuRpZ/1HQ6MVNeOFaOA8i4
         cQuFgYLrm6waNMwhkJXYIYLXtEseVHbcmFJ6gcbc33su4ylYGxtJYR3kFJn0quPDqZGQ
         xHjd5dtOcYTJ3FbFBeh7B9esZ90Ub1XaE66tZatFp5X03Ood1MGxl0FGzAuLHOtoQoWV
         CZ/8TqZ732OMFfxotimjIHAkK/sd8cqPbRdCDIG5qh8JoemQh7T2DsEl6L2t1nkD3N8c
         iUoQ==
X-Gm-Message-State: AO0yUKUjHoH8XoegLOERIChAYZ4HCA4Bcis10bUqv/6RWcRzwY4O6VDg
        RWl5SWxvhIwDdacspGqEGw==
X-Google-Smtp-Source: AK7set9GQuirZFd7o5uFL8Fk7mb03UTZ7Ig8Xe1KNoWVOrcBWkvbceDiwdjpSqwnJAwtKq6eclwsGw==
X-Received: by 2002:a4a:5250:0:b0:51f:955a:ca37 with SMTP id d77-20020a4a5250000000b0051f955aca37mr12887637oob.8.1677527736308;
        Mon, 27 Feb 2023 11:55:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h15-20020a4abb8f000000b00525398a1144sm2977105oop.32.2023.02.27.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:55:36 -0800 (PST)
Received: (nullmailer pid 754635 invoked by uid 1000);
        Mon, 27 Feb 2023 19:55:35 -0000
Date:   Mon, 27 Feb 2023 13:55:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dt-bindings: PCI: qcom: Add iommu properties
Message-ID: <20230227195535.GA749409-robh@kernel.org>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
 <20230224105906.16540-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224105906.16540-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 24, 2023 at 04:28:55PM +0530, Manivannan Sadhasivam wrote:
> Most of the PCIe controllers require iommu support to function properly.
> So let's add them to the binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a3639920fcbb..f48d0792aa57 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -64,6 +64,11 @@ properties:
>  
>    dma-coherent: true
>  
> +  iommus:
> +    maxItems: 1
> +
> +  iommu-map: true
> +

I think both properties together doesn't make sense unless the PCI host 
itself does DMA in addition to PCI bus devices doing DMA.

Rob
