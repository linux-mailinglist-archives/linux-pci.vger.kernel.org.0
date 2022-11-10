Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48581624C51
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKJVBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiKJVBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:01:40 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F325431EE9;
        Thu, 10 Nov 2022 13:01:39 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13b23e29e36so3494852fac.8;
        Thu, 10 Nov 2022 13:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXJtyHEr+ciozyD19jwAQk+e1bvRNjgF+Op8DGPG9rY=;
        b=u3+LnnzPZwMxzAVjd7w7nd/DI1fXgGySZc6+XwvVYBdLLdaLBHpTtKglL27naKLCeM
         OhhmJ48cl3Mh+WDTCCefFT7uw9aivVGFBHuIB5B/anuV0fFvffKh2FPxKxrYAXqvo0MJ
         gdCxZ7bLL93aLwNfByqZ+RgqnnP95hMo185OD4RsWeJ50a6GzPRopqQf6SmwYG+qJH4x
         FXYCT+JMk8gwYnTQV+CqfcQbqzMguftocwbqtDv0SFU2DsUhnCp8C9MJ7ad7A52lrh7P
         ba8WAggy18RGmydnqWKwuvSADttGDjYyEHl/hVUx6Q+GEMZY4BgnC+MIdXttNz9SXMLy
         3LMw==
X-Gm-Message-State: ACrzQf3bigu260Zw+Pa6/cnQjOBJbE9SpGHLnGLPqBfKAPDi7ieIBsYM
        xPgH9NiINwqeKZvi6sdfpQ==
X-Google-Smtp-Source: AMsMyM4ngmuAwOYwkleFC9q+x5ykJa6ii8672Wg9jIR4LOg7CXPbbjbsf8Mjpcq5XmD/jiaAnb8HXA==
X-Received: by 2002:a05:6870:7b89:b0:132:32c5:42ad with SMTP id jf9-20020a0568707b8900b0013232c542admr2131456oab.123.1668114099169;
        Thu, 10 Nov 2022 13:01:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s83-20020aca5e56000000b0035028730c90sm223079oib.1.2022.11.10.13.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:01:38 -0800 (PST)
Received: (nullmailer pid 976711 invoked by uid 1000);
        Thu, 10 Nov 2022 21:01:40 -0000
Date:   Thu, 10 Nov 2022 15:01:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>, linux-kernel@vger.kernel.org,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 05/20] dt-bindings: PCI: dwc: Add phys/phy-names
 common properties
Message-ID: <166811409796.976609.332316910295244271.robh@kernel.org>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107204934.32655-6-Sergey.Semin@baikalelectronics.ru>
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


On Mon, 07 Nov 2022 23:49:19 +0300, Serge Semin wrote:
> It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
> PHY phandle references. There can be up to 16 PHYs attach in accordance
> with the maximum number of supported PCIe lanes. Let's extend the common
> DW PCIe controller schema with the 'phys' and 'phy-names' properties
> definition. There two types PHY names are defined: preferred generic names
> '^pcie[0-9]+$' and non-preferred vendor-specific names
> '^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
> the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
> "pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
> keystone, dra7xx; "pcie": histb, etc).
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> 
> Changelog v5:
> - Add a note about having line-based PHY phandles order. (@Rob)
> - Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
> 
> Changelog v6:
> - Add the Nvidia Tegra194-specific "p2u-[0-7]" phy-names too. (@DT-tbot)
> - Drop 'deprecated' keywords from the vendor-specific names. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 24 +++++++++++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         |  3 +++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  3 +++
>  3 files changed, 30 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
