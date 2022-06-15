Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8754CD00
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiFOPcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiFOPcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 11:32:05 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749A12AC3;
        Wed, 15 Jun 2022 08:32:04 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id 19so13016453iou.12;
        Wed, 15 Jun 2022 08:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q8c2xxYz3j26DYod3eaaMN2lLSN9Ym6PyBo4ziuyZyk=;
        b=jVjAog30zbKSBZl7ydPao7MZNwJV3EiXV0aWnIyTVc607gtPEhcrenDZLhd0lSE1tS
         QlM3ksDLH1dbKN/Ge91vwNhIzrH5b8zsxrGBCXII2ONjoBXVLTauGSpysVnRzZDe8t10
         7UshVrEiiy2Y492XxQTbG30gP7fWJf/uJm+7pmonV/UXYYJxlQPXi06g66FhP8NxOwU5
         5HH34ysOXXG0e5gSGuuwp4LBwxfwceT858BhushIayFfvX52IFSiiNUb0fAImDl2L1cy
         0xhYctE8QJ/rxH8PbLkQOqiR+xDekelxNOYAdQ5DJrQhoOYKN9h6FgTL82DQHM3+O1QV
         kBZw==
X-Gm-Message-State: AJIora8rd+F65e2juDQaAT8X3GhMR6CYFMrlOUbWvcaeBfLfqSO8EeR+
        um+jJTcGjjP/cRvg9GUmcg==
X-Google-Smtp-Source: AGRyM1vZP1cpJh4LaQGtt0wTsnkyOry95Uj+prwRnysLP55TGjTCNDh9AJ78t39ZVGZhWD6AGPALWg==
X-Received: by 2002:a6b:f00e:0:b0:66a:4a4a:8506 with SMTP id w14-20020a6bf00e000000b0066a4a4a8506mr168845ioc.42.1655307123240;
        Wed, 15 Jun 2022 08:32:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id u11-20020a02aa8b000000b0032e1e0ac289sm6289840jai.8.2022.06.15.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:32:02 -0700 (PDT)
Received: (nullmailer pid 1290906 invoked by uid 1000);
        Wed, 15 Jun 2022 15:32:01 -0000
Date:   Wed, 15 Jun 2022 09:32:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/17] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Message-ID: <20220615153201.GB1069883-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-8-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:56:55AM +0300, Serge Semin wrote:
> Currently the 'interrupts' and 'interrupt-names' are defined being too
> generic to really describe any actual IRQ interface. Moreover the DW PCIe
> End-point devices are left with no IRQ signals. All of that can be fixed
> by adding the IRQ-related properties to the common DW PCIe DT-schema and
> defining a common and device-specific set of the IRQ names in accordance
> with the hardware reference manual. Seeing there are common and dedicated
> IRQ signals for DW PCIe Root Port and End-point controllers we suggest to
> split the IRQ names up into two sets: common definitions available in the
> snps,dw-pcie-common.yaml schema and Root Port specific names defined in
> the snps,dw-pcie.yaml schema. The former one will be applied to both DW
> PCIe RP and EP controllers, while the later one - for the RP only.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 51 +++++++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 17 +++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 63 ++++++++++++++++++-
>  3 files changed, 128 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index b2fbe886981b..0a524e916a9f 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -17,6 +17,25 @@ description:
>  select: false
>  
>  properties:
> +  interrupts:
> +    description:
> +      There are two main sub-blocks which are normally capable of
> +      generating interrupts. It's System Information Interface and MSI
> +      interface. While the former one has some common for the Host and
> +      Endpoint controllers IRQ-signals, the later interface is obviously
> +      Root Complex specific since it's responsible for the incoming MSI
> +      messages signalling. The System Information IRQ signals are mainly
> +      responsible for reporting the generic PCIe hierarchy and Root
> +      Complex events like VPD IO request, general AER, PME, Hot-plug, link
> +      bandwidth change, link equalization request, INTx asserted/deasserted
> +      Message detection, embedded DMA Tx/Rx/Error.
> +    minItems: 1
> +    maxItems: 26
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 26
> +
>    phys:
>      description:
>        There can be up to the number of possible lanes PHYs specified.
> @@ -91,4 +110,36 @@ properties:
>  
>  additionalProperties: true
>  
> +definitions:

$defs:

But I suppose this is the applying fixups or not issue. That's certainly 
not behavior we should rely on. If we need a way to specify applying 
fixups or not, we should do that. But really I'd prefer not to need 
that.

> +  interrupt-names:
> +    description:
> +      IRQ signal names common for the DWC PCIe Root Port and Endpoint
> +      controllers.
> +    oneOf:
> +      - description:
> +          Controller request to read or write virtual product data
> +          from/to the VPD capability registers.
> +        const: vpd
> +      - description:
> +          Link Equalization Request flag is set in the Link Status 2
> +          register (applicable if the corresponding IRQ is enabled in
> +          the Link Control 3 register).
> +        const: l_eq
> +      - description:
> +          Indicates that the eDMA Tx/Rx transfer is complete or that an
> +          error has occurred on the corresponding channel. eDMA can have
> +          eight Tx (Write) and Rx (Read) eDMA channels thus supporting up
> +          to 16 IRQ signals all together. Write eDMA channels shall go
> +          first in the ordered row as per default edma_int[*] bus setup.
> +        pattern: '^dma([0-9]|1[0-5])?$'
> +      - description:
> +          PCIe protocol correctable error or a Data Path protection
> +          correctable error is detected by the automotive/safety
> +          feature.
> +        const: sft_ce
> +      - description:
> +          Indicates that the internal safety mechanism detected and
> +          uncorrectable error.
> +        const: sft_ue

I still don't really like this pattern. My first read of it makes me 
think only 1 interrupt is supported, and I have to go look that this is 
referenced from 'items'.

Could we do a lot more with json-schema like you have? Yes, but the 
schemas are optimized for simplicity and a relatively fixed pattern of 
what's allowed as json-schema is new to most folks. It's also easy to 
create things that simply don't work (silently). Just reviewing this 
series is hard.

This series is trying to do lots of things. Refactoring, adding 
constraints, and adding a new binding. I would split it up if you want 
to make progress.

Rob
