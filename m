Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860225A8807
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 23:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiHaVYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 17:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiHaVYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 17:24:49 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43BCC68;
        Wed, 31 Aug 2022 14:24:45 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11e9a7135easo24728203fac.6;
        Wed, 31 Aug 2022 14:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ptckDRyC3NuutV/1EQwXwr/4eg6rFrtCSCG7+WQhK1U=;
        b=OH9U6oTI9IM1ydlFk/dAVvemii05k1QdcnziLcC+kLjt0WdykZyM9dljQwepXTytcW
         QZuoGHJkUQRj+nvVhUlN3boOGnKV0pi6g789XtEwzDVs3lvQNqpaDQafiT02jjN6sfwe
         zBqgEs3w9MKwLhoXWLKtpX/gVORwpMQKdQVx4lw+3Cg+MvtVbOgdOvOYR6EGqgcXa+RM
         adKx5twYT1J4REqCvSXlXMzqbX704QqJseBq+FpOgxgRJtTg2l7Pb2FnrwIsjubJ6KFv
         LzVMN6ioJ/pLc1MsniZdp8JxXPNehRREs/VlPo+jRzmE3gvgDg9svv66nFN+oGZimsf+
         DwUQ==
X-Gm-Message-State: ACgBeo2KtThsJ4AImrriE/lxPfqNAHpZ+jdM+a7iyNk/k//S4swkIuXo
        UvHc8z4xvzgjtKLDVcBqQQ==
X-Google-Smtp-Source: AA6agR6taqPYE3ZLkGFuOohLzZadZneybxVqVYn6iJavCQbIzrZE934PA3y4+GwUZvEJRpWSE6RErA==
X-Received: by 2002:a05:6870:f2a1:b0:122:3d83:b14d with SMTP id u33-20020a056870f2a100b001223d83b14dmr1756973oap.136.1661981084919;
        Wed, 31 Aug 2022 14:24:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d15-20020a9d51cf000000b0063b1f060d25sm7451596oth.65.2022.08.31.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:24:44 -0700 (PDT)
Received: (nullmailer pid 276625 invoked by uid 1000);
        Wed, 31 Aug 2022 21:24:43 -0000
Date:   Wed, 31 Aug 2022 16:24:43 -0500
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
Subject: Re: [PATCH v5 09/20] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Message-ID: <20220831212443.GA267718-robh@kernel.org>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822184701.25246-10-Sergey.Semin@baikalelectronics.ru>
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

On Mon, Aug 22, 2022 at 09:46:50PM +0300, Serge Semin wrote:
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
> Note since there are DW PCI-based vendor-specific DT-bindings with the
> custom names assigned to the same IRQ resources we have no much choice but
> to add them to the generic DT-schemas in order to have the schemas being
> applicable for such devices. Let's mark these names as deprecated so not
> to encourage the new DT-bindings to use them.
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
> - Add platform-specific interrupt names, but mark them as deprecated.
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 51 ++++++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 17 +++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 67 ++++++++++++++++++-
>  3 files changed, 132 insertions(+), 3 deletions(-)

I still don't like how you've done interrupts/clocks/reg. I'd suggest 
dropping it if you want this series applied soonish.

Rob
