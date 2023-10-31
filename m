Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F477DC3CC
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 02:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjJaBK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 21:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjJaBK1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 21:10:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5CA2;
        Mon, 30 Oct 2023 18:10:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5079f9675c6so7773045e87.2;
        Mon, 30 Oct 2023 18:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698714622; x=1699319422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqPoT4F9RmVDc8pr+IDxp35lpchtUg1Qh6Xpf92yaO8=;
        b=ikRR3M7egHBwfmH46soRsjFkn5ofAN6lfjHPTCqRFfzrzWJqp0genw01VEUoLzthSP
         cjyA+O1QhgTUZeFx1KAp/J48ZNRis6627VO9Q9e3TsevaxVcMuPCZTSh6W4uziUEJJY3
         iLA1Ex/zR6O+YW2UtahArAarhkDfbDgSv7v0jOQs+tbvwcfp5oZFXGzNs+172uJaFPLb
         fXEKSaHgZdkhamFtjG8rFC6mXjBhbAzG+GR8pT4ZtNFe2kDKBBXQcgi0Pqm6JPAtHngp
         MI+4K+qmk3aA3P1dpZB5MUrJlDGrYBmBY8XVoUGSfMYnCMLk+jWJHDO3di8Kq1QaJHrv
         gJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698714622; x=1699319422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqPoT4F9RmVDc8pr+IDxp35lpchtUg1Qh6Xpf92yaO8=;
        b=biHJX7r6IZzAlb8GQjb1gDLcT0q+Ln3ISB87JoMbE7VGC+u8GpNsJ6XpFxLak5aoTU
         yYyBKM/wv2Ti4yfduGNVllK0pbKRZHtdLMksLtoV2E8pmTadSBeRp/eOmsq9jNyd8IcV
         cKWE0dW+0+XxFI0BNQTD0ROqiJ7E5S2fieGhZZe3TDOhuScoyjvfAsmumgEx0g3qdwy8
         7iHf2fHCV+nzXD16zM1TgQe6p7RBspB84gqB4a7KwzA7zAz8gqovKtHSfQj3JoptZzPo
         Y8JzITAHvyCDCrifRCkaKpxh+Y444LwPrlUTZ3RqMYrHPfmlOVwWvFQpPHom3Tz4B3RL
         oxIA==
X-Gm-Message-State: AOJu0Yxyjdzp0lKapE8c32emMkQq7G1+F0x6bRQhgo6ASI1USHCHJrAg
        GB/2E7mdTmcRK26jDO31mOgLOHujwo5aAQ==
X-Google-Smtp-Source: AGHT+IEMqTcP5JE/a5KNIjbcNlQMvWCSkDmRmU6WhDaXBEEHn1kqWQDZgSMKsd/pZYZYOz5BJ3/Rqg==
X-Received: by 2002:a05:6512:124f:b0:500:7fc1:414b with SMTP id fb15-20020a056512124f00b005007fc1414bmr10429837lfb.25.1698714622023;
        Mon, 30 Oct 2023 18:10:22 -0700 (PDT)
Received: from mobilestation ([89.113.151.243])
        by smtp.gmail.com with ESMTPSA id dw24-20020a0565122c9800b004fdde1db756sm26123lfb.26.2023.10.30.18.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 18:10:21 -0700 (PDT)
Date:   Tue, 31 Oct 2023 04:10:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Niklas Cassel <nks@flawful.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v3 2/6] dt-bindings: PCI: dwc: rockchip: Add optional dma
 interrupts
Message-ID: <jxsrtqplojsab4a64erm7ojjdm3kq5ohb5l7vf3lf7gzvx3q3d@ilyu4vg2xeze>
References: <20231027145422.40265-1-nks@flawful.org>
 <20231027145422.40265-3-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027145422.40265-3-nks@flawful.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 27, 2023 at 04:54:14PM +0200, Niklas Cassel wrote:
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
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 6ca87ff4ae20..7ad6e1283784 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -63,6 +63,7 @@ properties:
>        - const: pipe
>  
>    interrupts:
> +    minItems: 5
>      items:
>        - description:
>            Combined system interrupt, which is used to signal the following
> @@ -86,14 +87,31 @@ properties:
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

No. As you said yourself here
https://lore.kernel.org/linux-pci/ZTl1ZsHvk3DDHWsm@x1-carbon/
and in the response to my last message in v2, which for some reason
hasn't got to the lore archive:

On Fri, Oct 27, 2023 at 05:51:14PM +0200, Niklas Cassel wrote:
> However, e.g. rk3568 only has one channel for reads and one for writes.
> (Now this SoC doesn't have dedicated IRQs for the eDMA, but let's pretend
> that it did.)
> 
> So for rk3568, it would then instead be:
> dma0: wr0
> dma1: rd0
> dma2: <unused>
> dma3: <unused>

rk3568 doesn't have IRQs supplied in a normal way, as separate
signals.  Instead they are combined in the 'sys' IRQ. So you should
define the IRQs constraint being device-specific by using for example
the "allOf: if-else" pattern.

-Serge(y)

>  
>    legacy-interrupt-controller:
>      description: Interrupt controller node for handling legacy PCI interrupts.
> -- 
> 2.41.0
> 
