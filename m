Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C956A1ED
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiGGM1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiGGM1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 08:27:54 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B052251F;
        Thu,  7 Jul 2022 05:27:53 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id v185so16632929ioe.11;
        Thu, 07 Jul 2022 05:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cMPT7f9qv5sQO6WNbfFTELIdIiXOvBw5cTsisXNHniQ=;
        b=H1v4dAcR3R+lnwYPtIEQCKBk7xLj9VCoRBs0Y1HShtJqQDfLCIm17VSiC8FnDGT5b4
         yW+uvtGzJlqQkD9mGjrkkcUMagPURP/6DMGcc74P5JDwxvUYEKOEBck2WE2Ii9Oyh5Tr
         B/0KDpjRposrsw5ntBPJV44s36jTzTuRfdZJfcaMf9EkKYn82fHsI+/YsDoeXHtJB7ET
         8IOYkYVZpx3+27XAEB4bNsv+wQ3vGBdbl2Ylm0x4naBVU1o80UIQgETYLEVhY7OOcS4r
         Hx82jNbAJ5eWKLP1wRDPJKNfErDdP6HMK+npE35aYjUNf6CzwsHTGm9W8mxBck5v6GVX
         sAkg==
X-Gm-Message-State: AJIora+K1PVEpO/QX0l73UCIK67S+rDVFNfa3XNPEoIypmzKIpK3zP3A
        r3oZieVND5qRKD863jmpLA==
X-Google-Smtp-Source: AGRyM1tZlHGQo0cV0eRw2oO9lgiCjvxMu4CTwm0ERhDKTH/9dm5gg9bF2hOLr7xmiE2qJa9CFxMU5Q==
X-Received: by 2002:a5e:a506:0:b0:66a:2cdc:e6f7 with SMTP id 6-20020a5ea506000000b0066a2cdce6f7mr25146629iog.113.1657196872555;
        Thu, 07 Jul 2022 05:27:52 -0700 (PDT)
Received: from robh.at.kernel.org ([98.38.210.73])
        by smtp.gmail.com with ESMTPSA id z23-20020a05663803b700b00331c06bf620sm12890894jap.154.2022.07.07.05.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:27:52 -0700 (PDT)
Received: (nullmailer pid 1454232 invoked by uid 1000);
        Thu, 07 Jul 2022 12:27:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     kthota@nvidia.com, sagar.tv@gmail.com, lpieralisi@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        gustavo.pimentel@synopsys.com, linux-tegra@vger.kernel.org,
        thierry.reding@gmail.com, mmaddireddy@nvidia.com,
        jingoohan1@gmail.com, kw@linux.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220707081301.29961-4-vidyas@nvidia.com>
References: <20220707081301.29961-1-vidyas@nvidia.com> <20220707081301.29961-4-vidyas@nvidia.com>
Subject: Re: [PATCH V4 3/9] dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
Date:   Thu, 07 Jul 2022 06:27:51 -0600
Message-Id: <1657196871.476299.1454231.nullmailer@robh.at.kernel.org>
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

On Thu, 07 Jul 2022 13:42:55 +0530, Vidya Sagar wrote:
> Add support for PCIe controllers that operate in the endpoint mode
> in tegra234 chipset.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Rebased on top of previous patch
> 
> V3:
> * New patch in this series
> 
>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 123 +++++++++++++++++-
>  1 file changed, 117 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: Unevaluated properties are not allowed ('nvidia,enable-ext-refclk' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

