Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD71624CD6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKJVWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiKJVWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:22:19 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7FF31FBC;
        Thu, 10 Nov 2022 13:22:18 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13c2cfd1126so3539297fac.10;
        Thu, 10 Nov 2022 13:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ+3Ccu0uhREUGx5S7RKmOuqs17Und03iOnQWDCqGPM=;
        b=fX8H1hsYHwETdHcE16WqqwmMmbSZeRQpBXJt0lW0xUgFQql4hq/zKusJ7OIK9/FzNB
         D2vElgOAKVaG4D99MWrJ8ODHwBVBUJCrcfQLImLbzkZUdpZJm2OuVxuJjEdOtEX0vYzj
         KSb/czpc4Lq0m1EsrXnvZ/63JDgJkCttfZZ8cucnX2F/3YDTq6jx9Vnyq9WBDkQ4UgWx
         9+5q2Zu7vOKwcvZqCxNtmXx7L9AT797wdITasWhIJP7G6nIUQSHYxj5dZF6h0Vk7ws1w
         hma9PfqgEpOvKKTgZtumGefM9CwWOeH3NbDXNRPw4Q5U1DQc+Mg1jZvS5kuYBBXENNwo
         /1eA==
X-Gm-Message-State: ACrzQf3iA7V3i0fMdVZDpj/GKNtniRcCT8c+0sVPEnRmTUGtCMMG1gNn
        e+ur9pANOiWvlliSSXCQdA==
X-Google-Smtp-Source: AMsMyM6abEVLmKF/QrAZLvpq2Fr9k27olRNNzfOuZj+82upXJu7cEmVCsnZlQafB4BTwX9OzkzWwlQ==
X-Received: by 2002:a05:6871:4045:b0:13b:be94:f56 with SMTP id ky5-20020a056871404500b0013bbe940f56mr2273595oab.198.1668115337801;
        Thu, 10 Nov 2022 13:22:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j103-20020a9d17f0000000b0066c2d80c753sm314993otj.22.2022.11.10.13.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:22:17 -0800 (PST)
Received: (nullmailer pid 1067668 invoked by uid 1000);
        Thu, 10 Nov 2022 21:22:18 -0000
Date:   Thu, 10 Nov 2022 15:22:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        caihuoqing <caihuoqing@baidu.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 10/20] dt-bindings: PCI: dwc: Add reg/reg-names common
 properties
Message-ID: <166811533701.1067589.1394970504851660332.robh@kernel.org>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107204934.32655-11-Sergey.Semin@baikalelectronics.ru>
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


On Mon, 07 Nov 2022 23:49:24 +0300, Serge Semin wrote:
> Even though there is a more-or-less limited set of the CSR spaces can be
> defined for each DW PCIe controller the generic DT-schema currently
> doesn't specify much limitations on the reg-space names used for one or
> another range. In order to prevent the vendor-specific controller schemas
> further deviation from the generic interface let's fix that by introducing
> the reg-names definition in the common DW PCIe DT-schemas and preserving
> the generic "reg" and "reg-names" properties in there. New DW PCIe device
> DT-bindings are encouraged to use the generic set of the CSR spaces
> defined in the generic DW PCIe RP/EP DT-bindings, while the already
> available vendor-specific DT-bindings can still apple the common
> DT-schemas.
> 
> Note the number of reg/reg-names items need to be changed in the DW PCIe
> EP DT-schema since aside with the "dbi" CSRs space these arrays can have
> "dbi2", "addr_space", "atu", etc ranges.
> 
> Also note since there are DW PCIe-based vendor-specific DT-bindings with
> the custom names assigned to the same CSR resources we have no much choice
> but to add them to the generic DT-schemas in order to have the schemas
> being applicable for such devices. These names are marked as
> vendor-specific and should be avoided being used in new bindings in favor
> of the generic names.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> - Split up reg-names in the same way as the interrupt-names: common,
>   Root Port and Endpoint specific names. (@Rob)
> - Drop synonymous from the names list since the device schemas create
>   their own enumerations anyway.
> 
> Changelog v5:
> - Add platform-specific reg names, but mark them as deprecated.
> 
> Changelog v6:
> - Move the common reg-names definitions to the RP/EP schemas. Thus drop
>   the 'definitions' property. (@Rob)
> - Drop the 'deprecated' keywords from the vendor-specific names. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 22 +++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 82 +++++++++++++++++--
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 78 ++++++++++++++++--
>  3 files changed, 169 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
