Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2C7D84CC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbjJZOcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbjJZOcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 10:32:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B61BC;
        Thu, 26 Oct 2023 07:32:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507d1cc0538so1323812e87.2;
        Thu, 26 Oct 2023 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330767; x=1698935567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHmRoq0ETjVN1za9BajG5M61oGOFzDIRHNAMG5IaVTQ=;
        b=ZDFxSzYgPL5hDBPeJK5qvLmBnQ8Hak30jneZZbBPqFNJTB/8ZhB9Zu7prPWU+2bcLn
         xD4IIuBi/WWqwD4PE54eoURl1oo3QzKT4QZN3KVOF2zsWFBVxb6QQnkQ6/v8YfEiBgZk
         agIXhqfO/SGCmM6bN85DneD8bMKjgHO6yNOiTJUqK2SaC+NvIjpmEUqnDCv0jUBMBfi0
         NvaHhMg0nlTs6rT+6iMpjbtjhmg/TL9ld4p8GL4ylD9TvNORO/H9bU42/AZapodVjNOA
         HvhvqgMga01+BTC9aEMleQ7Ij45NKiUJH+8Hb6Ihe8uj/ohPsdGaymL3URLJxALHi7Bk
         MEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330767; x=1698935567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHmRoq0ETjVN1za9BajG5M61oGOFzDIRHNAMG5IaVTQ=;
        b=UgsIPd9FfSF6GfbqhySECP2Au1yufCGZ+4CunsxZRAm8SfJrpEp/kmlyPmuF13cUqh
         1cR5oesvwHJRFRkdCb/zerNkn50HnmbckMYEzWkse6HGP/b10I3vxqZRKuz1CXbGaaL5
         6/9n7m30/5MwMVrufV8ePsNAZCrSa8cwegFL8v9ZkkKT6AvHlEJ+PNbod/Xra1ggLUYu
         wcCm5Jw0/Ws18HbYsyP0sS1QjDRee3r74qWcmpaoXro0HUqnGdPzI5c/3WDAcrjkk2vt
         7LOrZjLFhgYIE6fbGj9R0PqjSoF0HNoQywBcH4C/S3wgpw5C8mQhm3MTsU0CFaZNyH3/
         vaOQ==
X-Gm-Message-State: AOJu0YzjR0Hx24HY/XjJ9JkesAXnQdk3jkeRoVLryEianOHPQLwC4dFr
        If5oyeyfYoY5KK/hotXLVl0=
X-Google-Smtp-Source: AGHT+IHSgnN4Bgh64erDu9jYfseLN/aERhHKcZUhV4w5LUCCdNcCijf729M77+heSOLOkoWu93Tpgw==
X-Received: by 2002:ac2:51a3:0:b0:507:9618:d446 with SMTP id f3-20020ac251a3000000b005079618d446mr12199193lfk.61.1698330767273;
        Thu, 26 Oct 2023 07:32:47 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k15-20020ac2456f000000b005008c11ca6dsm3019090lfm.184.2023.10.26.07.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:32:46 -0700 (PDT)
Date:   Thu, 26 Oct 2023 17:32:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Niklas Cassel <nks@flawful.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: dwc: rockchip: Add dma
 properties
Message-ID: <4tzz7e5mznunyar6d675lzn4jdshqvik4flyronb7sjwhc4deh@qwikilvdyosc>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-4-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024151014.240695-4-nks@flawful.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 24, 2023 at 05:10:10PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> using:
> 
> allOf:
>   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> 
> and snps,dw-pcie.yaml does have the dma properties defined, in order to be
> able to use these properties, while still making sure 'make CHECK_DTBS=y'
> pass, we need to add these properties to rockchip-dw-pcie.yaml.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 229f8608c535..633f8e0e884f 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -35,6 +35,7 @@ properties:
>        - description: Rockchip designed configuration registers
>        - description: Config registers
>        - description: iATU registers
> +      - description: eDMA registers
>  
>    reg-names:
>      minItems: 3
> @@ -43,6 +44,7 @@ properties:
>        - const: apb
>        - const: config
>        - const: atu
> +      - const: dma
>  
>    clocks:
>      minItems: 5
> @@ -65,6 +67,7 @@ properties:
>        - const: pipe
>  
>    interrupts:
> +    minItems: 5
>      items:
>        - description:
>            Combined system interrupt, which is used to signal the following
> @@ -88,14 +91,31 @@ properties:
>            interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
>            tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
>            nf_err_rx, f_err_rx, radm_qoverflow

> +      - description:
> +          Indicates that the eDMA Tx/Rx transfer is complete or that an
> +          error has occurred on the corresponding channel.
> +      - description:
> +          Indicates that the eDMA Tx/Rx transfer is complete or that an
> +          error has occurred on the corresponding channel.
> +      - description:
> +          Indicates that the eDMA Tx/Rx transfer is complete or that an
> +          error has occurred on the corresponding channel.
> +      - description:
> +          Indicates that the eDMA Tx/Rx transfer is complete or that an
> +          error has occurred on the corresponding channel.

They aren't identical. Some IRQs indicate events on the write eDMA
channels, some - read eDMA channels. The respective channel ID would
be also useful to have in the description.

-Serge(y)

>  
>    interrupt-names:
> +    minItems: 5
>      items:
>        - const: sys
>        - const: pmc
>        - const: msg
>        - const: legacy
>        - const: err
> +      - const: dma0
> +      - const: dma1
> +      - const: dma2
> +      - const: dma3
>  
>    legacy-interrupt-controller:
>      description: Interrupt controller node for handling legacy PCI interrupts.
> -- 
> 2.41.0
> 
