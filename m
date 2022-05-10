Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4465221B1
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiEJQyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiEJQyM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 12:54:12 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449E293B5A;
        Tue, 10 May 2022 09:50:14 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e5e433d66dso18967259fac.5;
        Tue, 10 May 2022 09:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ejOmNVkuhi5gnwJe0lIiIooBTnp/Sw0pqGL8GRkeZpQ=;
        b=V5JyFAcyCYBw6ifa6sv+lWkw8By7HhtfAHyuUV/c1ny/MNRcwwM4DRZe/G6linoebr
         9IVNb5VMtLHnhZmgfPSgO6Oiht1MqenMAmzPMrBD3P9P3fC47ixGzFrFD9feow2HLlat
         s5100XM6RQDJ6WykuLcUXQOsvDTKxVSxw9WIxD+hv4QG/E2nXuKB3JTFFPaR2VcW7eU0
         aj7siKfGGgCAeymMRTV5gtbqK02CeIXc0Z4wkkdoBgfdCPPwGTT/mRf29uF9rfpIK60v
         4AS4I0ivpIebMTIuQ+nHYdmWsGqYvxb9ZfDJBOl9yae0CAkK2RjnGTE77tIj5GmH77+K
         AD4A==
X-Gm-Message-State: AOAM531p8FGCtxLycIG8+uL3mTmFnH71DDvky0L4x4S7fTC+PR8auIMX
        Z1qIGll4Q/pUTucyYkUvQI6FKsxESA==
X-Google-Smtp-Source: ABdhPJxq6q/Y/EDhN8+5jexFppLEAlfP8GCf3jJsY6yYlWf/6nIxz/rxgeHfOSHCfd7y8NBtG6pebQ==
X-Received: by 2002:a05:6870:630d:b0:e2:6498:6734 with SMTP id s13-20020a056870630d00b000e264986734mr556102oao.3.1652201413780;
        Tue, 10 May 2022 09:50:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 1-20020aca2801000000b00325cda1ff95sm5510341oix.20.2022.05.10.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:50:13 -0700 (PDT)
Received: (nullmailer pid 2180170 invoked by uid 1000);
        Tue, 10 May 2022 16:50:12 -0000
Date:   Tue, 10 May 2022 11:50:12 -0500
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
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
Message-ID: <YnqXxNxFhf/odyka@robh.at.kernel.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
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

On Fri, May 06, 2022 at 06:20:59PM +0300, Dmitry Baryshkov wrote:
> Convert pci/qcom,pcie schema to YAML description. The first patch
> introduces several warnings which are fixed by the other patches in the
> series.
> 
> Note regarding the snps,dw-pcie compatibility. The Qualcomm PCIe
> controller uses Synopsys PCIe IP core. However it is not just fused to
> the address space. Accessing PCIe registers requires several clocks and
> regulators to be powered up. Thus it can be assumed that the qcom,pcie
> bindings are not fully compatible with the snps,dw-pcie schema.
> 
> Changes since v5:
>  - s/stance/stanza (pointed out by Bjorn Helgaas)
> 
> Changes since v4:
>  - Change subjects to follow convention (suggested by Bjorn Helgaas)
> 
> Changes since v3:
>  - Rebase on linux-next to include sm8150 patches
> 
> Changes since v2 (still kudos to Krzyshtof):
>  - Readded reg-names conversion patch
>  - Mention wake-gpio update in the commit message
>  - Remove extra quotes in the schema
> 
> Changes since v1 (all kudos to Krzyshtof):
>  - Dropped the reg-names patch. It will be handled separately
>  - Squashed the snps,dw-pcie removal (from schema) into the first patch
>  - Replaced deprecated perst-gpio and wake-gpio with perst-gpios and
>    wake-gpios in the examples and in DT files
>  - Moved common clocks/clock-names, resets/reset-names and power-domains
>    properties to the top level of the schema, leaving only platform
>    specifics in the conditional branches
>  - Dropped iommu-map/iommu-map-mask for now
>  - Added (missed) interrupt-cells, clocks, clock-names, resets,
>    reset-names properties to the required list (resets/reset-names are
>    removed in the next patch, as they are not used on msm8996)
>  - Fixed IRQ flags in the examples
>  - Merged apq8064/ipq8064 into the single condition statement
>  - Added extra empty lines
> 
> Dmitry Baryshkov (8):
>   dt-bindings: PCI: qcom: Convert to YAML
>   dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
>   dt-bindings: PCI: qcom: Specify reg-names explicitly
>   dt-bindings: PCI: qcom: Add schema for sc7280 chipset
>   arm64: dts: qcom: stop using snps,dw-pcie falback
>   arm: dts: qcom: stop using snps,dw-pcie falback
>   arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
>   arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 398 ----------
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 714 ++++++++++++++++++

What tree do these apply to because they don't apply to rc1. I'm 
assuming the PCI tree and Lorenzo should take them.

Rob
