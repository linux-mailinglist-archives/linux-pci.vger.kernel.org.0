Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFF586FF1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiHAR6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiHAR5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 13:57:44 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB4AE74;
        Mon,  1 Aug 2022 10:56:39 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id h145so8950779iof.9;
        Mon, 01 Aug 2022 10:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=swF7ZVHMCOwHn1HGWFtQKimToggk8zvIDUmVw6CQKLI=;
        b=UntEDNWaNC3zVgZbo+zQx4EIPS+G5ScnvdbDmKFd2D+88q4oT5qtpaRMiKMeiyh5sZ
         b0+ghmFeR35uVr+n8sKY0op6jadVh91FiEb1OXrRnz10HTMcSpq1hkPrLqycM4tn3Gmo
         8OoaPm+l5mMWBo9pAEGvz10BO8U1NkToAzYsNAwKNA6u3UAzqvFdn+BmsefEzVPqWWnI
         STJTYnUTs0le+e+DYlqTaYbVmb+OEDlkz72KjYykMetU0q9roNU+P3LkOmo3KB8akwKF
         G2hXFY12WM4tni/mSN/bGt1GE2rtCUxBQuehIwip4XIdcXHJM5T/GHes4OW6Cjcn/AhO
         H2oQ==
X-Gm-Message-State: AJIora9kdPjq8rbLB7gvYnHT1SCRzryFMtmiUN0oLD525JiKMAfcgenZ
        LIY3qxrV2bsk4c1a51yZ2Q==
X-Google-Smtp-Source: AGRyM1vOklV2wavmSd1cJCeWDxv2exVzcyxTJudjKx3tMKpJjXVfreDyUQ6tfydxIbeIdFMmhOhkVw==
X-Received: by 2002:a6b:7010:0:b0:67b:e83c:4412 with SMTP id l16-20020a6b7010000000b0067be83c4412mr5877352ioc.22.1659376598611;
        Mon, 01 Aug 2022 10:56:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a10-20020a92d10a000000b002dcfbf36438sm4963753ilb.12.2022.08.01.10.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:56:38 -0700 (PDT)
Received: (nullmailer pid 1256701 invoked by uid 1000);
        Mon, 01 Aug 2022 17:56:36 -0000
Date:   Mon, 1 Aug 2022 11:56:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/17] dt-bindings: PCI: dwc: Add phys/phy-names
 common properties
Message-ID: <20220801175636.GA1234403-robh@kernel.org>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728143427.13617-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 05:34:13PM +0300, Serge Semin wrote:
> It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
> PHY phandle references. There can be up to 16 PHYs attach in accordance
> with the maximum number of supported PCIe lanes. Let's extend the common
> DW PCIe controller schema with the 'phys' and 'phy-names' properties
> definition. The PHY names are defined with the regexp pattern
> '^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
> the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
> "pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
> keystone, dra7xx; "pcie": histb, etc). Though the "pcie%d" format would
> the most preferable in this case.

No phy-names is my preference. Some string plus an index is utterly 
pointless. Oh well...

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
>  .../bindings/pci/snps,dw-pcie-common.yaml         | 15 +++++++++++++++
>  .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml  |  3 +++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml     |  3 +++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 3e992b653d12..627a5d6625ba 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -17,6 +17,21 @@ description:
>  select: false
>  
>  properties:
> +  phys:
> +    description:
> +      There can be up to the number of possible lanes PHYs specified.

This needs something about being in order of lane number.

> +      Obviously each specified PHY is supposed to be able to work in the
> +      PCIe mode with a speed implied by the DWC PCIe controller it is
> +      attached to.
> +    minItems: 1
> +    maxItems: 16
> +
> +  phy-names:
> +    minItems: 1
> +    maxItems: 16
> +    items:
> +      pattern: '^pcie([0-9]+|-?phy[0-9]*)?$'

Please comment here that pcie[0-9] is the preferred form.

Rob
