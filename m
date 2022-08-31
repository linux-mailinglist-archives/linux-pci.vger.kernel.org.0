Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853A65A8811
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 23:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiHaV0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 17:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiHaV0o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 17:26:44 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D77B78B;
        Wed, 31 Aug 2022 14:26:44 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso11146651otb.6;
        Wed, 31 Aug 2022 14:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rIyadyeq6YLRftLRyrN0QiirUdnHJN+op5RTIIc+np8=;
        b=luaXHk+xH0MfVZcIDVtf6jCniMVXtHxJ8UrbW3yaDth5ViJ4buBSNnmS8XKK9efFzD
         po1fCRrxxz+g+YZbycuFvg2Zv7MRKm05Hw0doE6hOP+QwBoDbDYDOjRx+sBx9PHpGihn
         vaA5Yk5yLdW5U8cExD3CfTvn8SnPfX7zJw68vDdKuB5JebxVfRzdaptv/9qts5jrH7ef
         sBWxmlf74PLEzYN5q8EHaqMLZAW2Pa0UqqtUGGldWmrplpisQcYl7nyPOSoMD4XDTKHP
         IVgIfsE3bOgW560iG7zlffs2USsoCnzrOVoLKwMLWZyZcCg9ZjgTdoT4kGtZD3Q8kl1H
         yDXQ==
X-Gm-Message-State: ACgBeo3vKqFoVQNDF7Llb03ZMJnYYJ712f6zysVDcH4lA08BQmte/0Bd
        +Z/D72wFvCsXTCezZMQ5ZA==
X-Google-Smtp-Source: AA6agR7h7g/4sGiJzr8LtSk06Zhc0E+hGHG6a643D5LCN9/i1HNmUyxP4sw3/5p5W25yVMpjgOueGw==
X-Received: by 2002:a05:6830:929:b0:63b:25ba:dfe4 with SMTP id v41-20020a056830092900b0063b25badfe4mr8368108ott.311.1661981203420;
        Wed, 31 Aug 2022 14:26:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o139-20020a4a2c91000000b00435ae9a836asm8623117ooo.15.2022.08.31.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:26:43 -0700 (PDT)
Received: (nullmailer pid 279436 invoked by uid 1000);
        Wed, 31 Aug 2022 21:26:31 -0000
Date:   Wed, 31 Aug 2022 16:26:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 13/20] dt-bindings: PCI: dwc: Apply common schema to
 Rockchip DW PCIe nodes
Message-ID: <20220831212631.GA277851-robh@kernel.org>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822184701.25246-14-Sergey.Semin@baikalelectronics.ru>
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

On Mon, Aug 22, 2022 at 09:46:54PM +0300, Serge Semin wrote:
> As the DT-bindings description states the Rockchip PCIe controller is
> based on the DW PCIe RP IP-core thus its DT-nodes are supposed to be
> compatible with the common DW PCIe controller schema. Let's make sure they
> are evaluated against it by referring to the snps,dw-pcie.yaml schema in
> the allOf sub-schemas composition.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> 
> Changelog v5:
> - Apply snps,dw-pcie.yaml instead of the snps,dw-pcie-common.yaml schema.
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Shouldn't this come before/after patch 7?

Reviewed-by: Rob Herring <robh@kernel.org>
