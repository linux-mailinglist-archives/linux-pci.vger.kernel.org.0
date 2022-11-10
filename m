Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310E2624CE8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKJVYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKJVYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:24:25 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0FD49B49;
        Thu, 10 Nov 2022 13:23:41 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13b103a3e5dso3588074fac.2;
        Thu, 10 Nov 2022 13:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8yuPqe0AlGPuqFMvfD8dC0ZoPiWtr8E7h9y1M9t4nA=;
        b=clPHEGW45J7XbWF8zWJbsOXz6ZRaq6e8dTRj61oTUoOM303IX9lPnZIQz+B96xZbu7
         D8XF7NOSshyBfyCd6DZfCZcJOtzU3mrdV6QQIAMmohUvBqKbT+BQ/QIRzJGw1Npbdkto
         7SKaBTHI3QZ3GheX2u+NPB04KNFjgLcHiAf6O76SYxR5/LbKy98D/oSQx9uhYzSINZHk
         s42uK+aZb0t1lfwB035qIPHQy+pWIwHiPzgYsHDYIP+HKe0owbfDSoi2/vLacNKjUoel
         UyyJ0zFHZs6QneS+5qDDZ5YUbpUHA1psWwjvZyMpN5BIcnxeMZJ9whB1jWNIUf0/bzLI
         XfIw==
X-Gm-Message-State: ACrzQf2hiGZK3Ln75XvdMsP8PJPe5/DcwnuvZ0CD9cBqUIysyO/EOpL6
        NKDeWQR2nH8kUpr3i6r/6w==
X-Google-Smtp-Source: AMsMyM59DqkAP3yEsliKFJwwSlPATvJ5yKqHsGRhDP56RySQbp5O9VunxUd8R331x+bVHM3GAsTdHw==
X-Received: by 2002:a05:6871:4143:b0:13b:66b0:3ef3 with SMTP id lb3-20020a056871414300b0013b66b03ef3mr2247980oab.210.1668115416612;
        Thu, 10 Nov 2022 13:23:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s13-20020a056808208d00b0035a81480ffcsm209522oiw.38.2022.11.10.13.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:23:36 -0800 (PST)
Received: (nullmailer pid 1069503 invoked by uid 1000);
        Thu, 10 Nov 2022 21:23:37 -0000
Date:   Thu, 10 Nov 2022 15:23:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        caihuoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH v6 11/20] dt-bindings: PCI: dwc: Add clocks/resets common
 properties
Message-ID: <166811541565.1069420.11032822569415159193.robh@kernel.org>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107204934.32655-12-Sergey.Semin@baikalelectronics.ru>
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


On Mon, 07 Nov 2022 23:49:25 +0300, Serge Semin wrote:
> DW PCIe RP/EP reference manuals explicit define all the clocks and reset
> requirements in [1] and [2]. Seeing the DW PCIe vendor-specific
> DT-bindings have already started assigning random names to the same set of
> the clocks and resets lines, let's define a generic names sets and add
> them to the DW PCIe common DT-schema.
> 
> Note since there are DW PCI-based vendor-specific DT-bindings with the
> custom names assigned to the same clocks and resets resources we have no
> much choice but to add them to the generic DT-schemas in order to have the
> schemas being applicable for such devices. These names are marked as
> vendor-specific and should be avoided being used in new bindings in favor
> of the generic names.
> 
> [1] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
> Root Port, Version 5.40a, March 2019, p.55 - 78.
> [2] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
> Endpoint, Version 5.40a, March 2019, p.58 - 81.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> - Drop synonymous from the names list since the device schemas create
>   their own enumerations anyway.
> 
> Changelog v5:
> - Add platform-specific clock/reset names, but mark them as deprecated.
> 
> Changelog v6:
> - Move the common *-names definitions to the RP/EP schemas. Thus drop
>   the 'definitions' property. (@Rob)
> - Drop the 'deprecated' keywords from the vendor-specific names. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 120 ++++++++++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         |   6 +
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 -
>  3 files changed, 126 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
