Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906527DBF27
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjJ3RkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjJ3RkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 13:40:17 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F249C;
        Mon, 30 Oct 2023 10:40:15 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ce532451c7so2778252a34.2;
        Mon, 30 Oct 2023 10:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687614; x=1699292414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+u4tebm6nXGAEfm0k7+Viez2ebHLsDXcjiQ9FdQg8w=;
        b=fuNCcmiA8r6jRGdeFLYPAi+zXGqgOWqD7DBwlA39PUqerczk++znDLGu5M8iHF2Nuv
         53YGM0WafJyvU+2QjKS8QQ7u3DTashuv8mHEa9pA2AySb1/IZYep/FAEUTCTo6AUDMtn
         Y4k0uzLrmVYBvXQxLfC9T9Icmm8gZGP1q5nrAteXa1TgtlppM8tCQOu/D26X+Ge3PK3I
         k4LltDUGsoFARYQN/GdO9B9GiKbMui3ksrKfyIS8TJWRhEX+6wlKaiPYFomHtKpXqzmk
         58MGGxGf4ERVtYfBUQrHnH/HGpos3ui0mftmracpLU389YcAnrTs72xsasBEdVdZXW1O
         RAEw==
X-Gm-Message-State: AOJu0YwDa2qBrF5zrqpaGQcyu6m0AV8UJe1mYN8pvqTuZTWRkcl4YkoP
        8QnzCb+2RqGTF/eLCfb4Dw==
X-Google-Smtp-Source: AGHT+IEg9yMvFNsDRTpR+Wsj9VVwm+fyrLBK4gTm+3/JpU6q7gH/e4XhpQiqhlM0nvHpGcl8T0bKZA==
X-Received: by 2002:a05:6830:4ac:b0:6ce:25a2:67cf with SMTP id l12-20020a05683004ac00b006ce25a267cfmr8966609otd.26.1698687614564;
        Mon, 30 Oct 2023 10:40:14 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id w20-20020a056830411400b006b8c87551e8sm1481131ott.35.2023.10.30.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:40:13 -0700 (PDT)
Received: (nullmailer pid 1560135 invoked by uid 1000);
        Mon, 30 Oct 2023 17:40:12 -0000
Date:   Mon, 30 Oct 2023 12:40:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <nks@flawful.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Simon Xue <xxm@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: PCI: dwc: rockchip: Add optional dma
 interrupts
Message-ID: <169868761168.1560075.5521220750018058491.robh@kernel.org>
References: <20231027145422.40265-1-nks@flawful.org>
 <20231027145422.40265-3-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027145422.40265-3-nks@flawful.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 27 Oct 2023 16:54:14 +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> using:
> 
> allOf:
>   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> 
> and snps,dw-pcie.yaml does have the dma interrupts defined, in order to be
> able to use these interrupts, while still making sure 'make CHECK_DTBS=y'
> pass, we need to add these interrupts to rockchip-dw-pcie.yaml.
> 
> These dedicated interrupts for the eDMA are not always wired to all the
> PCIe controllers on the same SoC. In other words, even for a specific
> compatible, e.g. rockchip,rk3588-pcie, these dedicated eDMA interrupts
> may or may not be wired.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

