Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5585A1550
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHYPNV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYPNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:13:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DE5A3E4;
        Thu, 25 Aug 2022 08:13:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d8so16266685lfq.0;
        Thu, 25 Aug 2022 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=X/HJjwysbwPY5lP7z2XNqzIAkb64JXray4RDUjSnQ/E=;
        b=eqUAj/ulLGt9fKA9X2CPCHPQjf16XH6ZbfZynema2QyRMvKMwPMqa1nQf/nm/j0Yer
         GaqnozYsFW7kX/T00PRfVhchF/6CMdCQ1kVqktnNEiTweJ/xbQ/efxECtWGsz2k6MH57
         Q7BFrsZUYMEBmYVPtOQcPkDOZ4nCwv4mMFhhsoOw671PL+gmQEKVBXH3kfvhF0M0zpuO
         5l5A6lG/iLRbAHHcqkI44HNnVUIV5t6SVeHTAQ77Bc2E8hKr9r+s0yUCM9Wyroa3Xym7
         jET8lru2kRRlSonG2xONqxvPYYkeJm0sa7UD3gqhTRgpy8KrXhyqbEp/w+AM++IWu2Kn
         nvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=X/HJjwysbwPY5lP7z2XNqzIAkb64JXray4RDUjSnQ/E=;
        b=v0X3dxlZvffChl14AnQ2Nx9Ohwj4Pgx8OTntD9gU7zjst+LvfuYoN7R5ThN+c+04VU
         O9eP3OJffx3m1GsU1fw1OvU0ZpEs5UYIVv6xXu//X8PFELOmooEIp1acADEyfDoHsqEg
         o2RY8dT73/IoBzIyJfQTHCCzpWSuZIDqMtcAEufNukwXArkvhV1OlfvtokaJG8niyoRs
         GWh9uIM0y1p0tV2a6EKoZ8B5ei6TTh50WCZ4EKWoV006lYpNYGTbSEX+fr0c3m9+2pya
         IY+aRSWoQaxIe66WDRqSwtCSprIkxNGC27HaKqxvo2iRg3lIpgRxmQfyyu25KoXd7tP1
         UHtA==
X-Gm-Message-State: ACgBeo1itz09/9U9naasWsz6JHUpaDqVHAD44sWriywBrKsd1MkMH1zb
        VM48swgcz/FnG0zeuJAr1R4=
X-Google-Smtp-Source: AA6agR4h1iWUpc20LQ+4wYlO85M6Cr5yt6RX+MQK1HeajaoyfhxIAa55vq9Ftczgq4dODFiIrLVNHw==
X-Received: by 2002:a05:6512:b9d:b0:48b:2567:4bad with SMTP id b29-20020a0565120b9d00b0048b25674badmr1325505lfv.9.1661440396732;
        Thu, 25 Aug 2022 08:13:16 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id 19-20020a2eb953000000b00261d623d9ffsm297018ljs.134.2022.08.25.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:13:15 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:13:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Subject: Re: [PATCH v5 05/20] dt-bindings: PCI: dwc: Add phys/phy-names
 common properties
Message-ID: <20220825151313.lyjhc3g3udabvr2r@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-6-Sergey.Semin@baikalelectronics.ru>
 <1661205444.106003.931361.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661205444.106003.931361.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 22, 2022 at 04:57:24PM -0500, Rob Herring wrote:
> On Mon, 22 Aug 2022 21:46:46 +0300, Serge Semin wrote:
> > It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
> > PHY phandle references. There can be up to 16 PHYs attach in accordance
> > with the maximum number of supported PCIe lanes. Let's extend the common
> > DW PCIe controller schema with the 'phys' and 'phy-names' properties
> > definition. The PHY names are defined with the regexp pattern
> > '^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
> > the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
> > "pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
> > keystone, dra7xx; "pcie": histb, etc). Though the "pcie%d" format would
> > the most preferable in this case.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch unpinned from the next one:
> >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> >   by the Rob' request. (@Rob)
> > 
> > Changelog v5:
> > - Add a note about having line-based PHY phandles order. (@Rob)
> > - Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
> > ---
> >  .../bindings/pci/snps,dw-pcie-common.yaml     | 19 +++++++++++++++++++
> >  .../bindings/pci/snps,dw-pcie-ep.yaml         |  3 +++
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  3 +++
> >  3 files changed, 25 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 

> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14180000: phy-names: 'oneOf' conditional failed, one must be fixed:
> 	'p2u-0' does not match '^pcie[0-9]+$'
> 	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-1' does not match '^pcie[0-9]+$'
> 	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-2' does not match '^pcie[0-9]+$'
> 	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-3' does not match '^pcie[0-9]+$'
> 	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'

Right. I've missed the Nvidia Tegra194 phy-names. I'll mark them as
deprecated too. Meanwhile @Rob could you review the rest of the
series?

-Sergey

> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14180000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'linux,pci-domain', 'num-lanes', 'ranges', 'supports-clkreq' were unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14160000: phy-names: 'oneOf' conditional failed, one must be fixed:
> 	'p2u-0' does not match '^pcie[0-9]+$'
> 	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-1' does not match '^pcie[0-9]+$'
> 	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-2' does not match '^pcie[0-9]+$'
> 	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-3' does not match '^pcie[0-9]+$'
> 	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb: pcie@14160000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'linux,pci-domain', 'num-lanes', 'num-viewport', 'ranges' were unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: phy-names: 'oneOf' conditional failed, one must be fixed:
> 	'p2u-0' does not match '^pcie[0-9]+$'
> 	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-1' does not match '^pcie[0-9]+$'
> 	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-2' does not match '^pcie[0-9]+$'
> 	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-3' does not match '^pcie[0-9]+$'
> 	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-4' does not match '^pcie[0-9]+$'
> 	'p2u-4' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-5' does not match '^pcie[0-9]+$'
> 	'p2u-5' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-6' does not match '^pcie[0-9]+$'
> 	'p2u-6' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-7' does not match '^pcie[0-9]+$'
> 	'p2u-7' does not match '^pcie(-?phy[0-9]*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: Unevaluated properties are not allowed ('num-lanes' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: phy-names: 'oneOf' conditional failed, one must be fixed:
> 	'p2u-0' does not match '^pcie[0-9]+$'
> 	'p2u-0' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-1' does not match '^pcie[0-9]+$'
> 	'p2u-1' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-2' does not match '^pcie[0-9]+$'
> 	'p2u-2' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-3' does not match '^pcie[0-9]+$'
> 	'p2u-3' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-4' does not match '^pcie[0-9]+$'
> 	'p2u-4' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-5' does not match '^pcie[0-9]+$'
> 	'p2u-5' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-6' does not match '^pcie[0-9]+$'
> 	'p2u-6' does not match '^pcie(-?phy[0-9]*)?$'
> 	'p2u-7' does not match '^pcie[0-9]+$'
> 	'p2u-7' does not match '^pcie(-?phy[0-9]*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: Unevaluated properties are not allowed ('num-lanes' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
