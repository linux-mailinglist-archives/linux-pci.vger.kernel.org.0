Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB536A4A5F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 19:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjB0S4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 13:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0S4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 13:56:00 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2BA23119;
        Mon, 27 Feb 2023 10:55:59 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso4106365ots.9;
        Mon, 27 Feb 2023 10:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MctcS45/qMC3RbmTOX9LKKozkUsDh8nNJ/NyikJMPj4=;
        b=A0/on59icryX7KzDBkI2DpHIiMCN8prrlWFN7YeTcfKKIh/LTT6zegMG9b1DQ7V0jX
         eQTnwlvsCpRFAh8CPs8U75q/bDvnjhnJSLrI4cO/mhYZtP7CoW9dQTpDnFv3o621Rj8y
         kJFCVEgGkRnaPTRTCtLcR5x0s7vLo/9EKiSbWuWnsZq91CI6hbiR+K30Kgzknt+diry4
         T6sZGm1aVxF6fBebdXOrJZai+O8CwuiUIspbxjR/CT7P2PNzmaJeG+vgOHZHe8WrzAcs
         HNZrhQ4DaYfuHfE+ijaSk1sUpLPaoDGOR9hYmTGLiLss5sevpHd1s9tnF3I5qKFNiiVc
         EqSw==
X-Gm-Message-State: AO0yUKW3fik9fNeHqFP2KjPJNbS2HHSxGI+JcKQaOeosihfH22sD5CEl
        oE69a8ca126a6j9r/mjiwZhjoAyw9Q==
X-Google-Smtp-Source: AK7set9OGq0HpkXMZUcFSJxSS6XaRI8ZocsjlJpUKSwpRZbJVr1Uxuu6XfU0iaKi5FPZEwUHnVKDHw==
X-Received: by 2002:a9d:4a4:0:b0:693:d5c2:9a9a with SMTP id 33-20020a9d04a4000000b00693d5c29a9amr7838837otm.36.1677524158423;
        Mon, 27 Feb 2023 10:55:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v14-20020a9d604e000000b006864816ecd9sm2849948otj.59.2023.02.27.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:55:58 -0800 (PST)
Received: (nullmailer pid 675791 invoked by uid 1000);
        Mon, 27 Feb 2023 18:55:57 -0000
Date:   Mon, 27 Feb 2023 12:55:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] dt-bindings: PCI: dwc: add DMA, region mask bits
Message-ID: <20230227185557.GA672128-robh@kernel.org>
References: <20230223180531.15148-1-enachman@marvell.com>
 <20230223180531.15148-5-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223180531.15148-5-enachman@marvell.com>
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

On Thu, Feb 23, 2023 at 08:05:28PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add properties to support configurable DMA mask bits
> and region mask bits.
> configurable DMA mask bits is needed for Marvell AC5/AC5X SOCs which
> have their physical DDR memory start at address 0x2_0000_0000.
> Configurable region mask bits is needed for the Marvell Armada
> 7020/7040/8040 SOCs when the DT file places the PCIe window above the
> 4GB region.
> The Synopsis Designware PCIe IP in these SOCs is too old to specify the
> highest memory location supported by the PCIe, but practically supports
> such locations. Allow these locations to be specified in the DT file.
> First DT property is called num-dmamask,
> and can range between 33 and 64.
> Second DT property is called num-regionmask,
> and can range between 33 and 64.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index d87e13496834..a1b06ff19ca7 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -261,6 +261,16 @@ properties:
>  
>    dma-coherent: true
>  
> +  num-dmamask:

Nope! There's already a defined way to define DMA/bus addresses and 
sizes in DT. That's dma-ranges.

Rob
