Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1865A880B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 23:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiHaVZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiHaVZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 17:25:21 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B255082;
        Wed, 31 Aug 2022 14:25:20 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11f4e634072so12976308fac.13;
        Wed, 31 Aug 2022 14:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3IO7QYOx3ovoZtkLdtuGfUPure2DXDjbSLg7kimkmnk=;
        b=M9KTKOqS5jkSj+FIbaVsG5A0B/o+cHUCcat0CJuKK6flq7WPJnC/5ipTx7YwHG1GO4
         faDv1w9S9O7KLeS2D9PioKjRMKIVvtdxRaMJ6bUPVQGacW5Qzyfx/NUkcIeMrn7Gu9Cx
         w8/UwloFuOle+7iNzDdtYsAvBMWz5ZC5q/DsI6/yh2tyN9pyDs32sUTR4RNIaSU9ECmb
         SlYJOGozX16ch/16cK/51IvooDcXMbnyRag9wByBjYda83Po6hDx1mXQkTgOpIfiDNB9
         X6y5jsK5amE5nKEpwOqI11PoA/1L7TKNafPDN+fAVn3aKklzUDC0QJBCDR4A9O9wOBxE
         T4bg==
X-Gm-Message-State: ACgBeo3Yo8UVQX3ZtI5fCNfLAapFVQplnsprbg+/nTWrKuJRiqZ97r5b
        0yj5fLyjOq/Ex4if3QtDcw==
X-Google-Smtp-Source: AA6agR5FNzao4c+d5/VDOYcbN1vLGoZj2frgIS/RF/DPtMRtmJentWXzD/8RolZiTMlRjZR7NZI+KQ==
X-Received: by 2002:a05:6808:f89:b0:344:cab1:14e9 with SMTP id o9-20020a0568080f8900b00344cab114e9mr2076886oiw.82.1661981119631;
        Wed, 31 Aug 2022 14:25:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id by6-20020a056830608600b00638e49d4cadsm9278246otb.36.2022.08.31.14.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:25:19 -0700 (PDT)
Received: (nullmailer pid 277757 invoked by uid 1000);
        Wed, 31 Aug 2022 21:25:18 -0000
Date:   Wed, 31 Aug 2022 16:25:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 12/20] dt-bindings: PCI: dwc: Add dma-coherent property
Message-ID: <20220831212518.GA277724-robh@kernel.org>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822184701.25246-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Aug 2022 21:46:53 +0300, Serge Semin wrote:
> DW PCIe EP/RP AXI- and TRGT1-master interfaces are responsible for the
> application memory access. They are used by the RP/EP PCIe buses (MWr/MWr
> TLPs emitted by the peripheral PCIe devices) and the eDMA block. Since all
> of them mainly involve the system memory and basically mean DMA we can
> expect the corresponding platforms can be designed in a way to make sure
> the transactions are cache-coherent. As such the DW PCIe DT-nodes can have
> the 'dma-coherent' property specified. Let's permit it in the DT-bindings
> then.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
