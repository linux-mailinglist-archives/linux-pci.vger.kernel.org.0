Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85696567810
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGETvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiGETvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 15:51:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F71D0E6;
        Tue,  5 Jul 2022 12:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18407B8197D;
        Tue,  5 Jul 2022 19:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728DCC341C7;
        Tue,  5 Jul 2022 19:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657050687;
        bh=FHSwCWE5Qqw8UZ5yAxfce6oaTgBWlJxEMNIl7ItdHGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hsNjREwz7ClHCyhPShCaTaluPcAsVCtc33dMkOpkJzU88Cd4hBjaXvmyTCeowsHgq
         Y9ScpDC4v2WlVhwd2afC3lwmhAFyjd3/MwIZ2L9vxW04MAQuGo3Wzf1JLF+mAuxo8j
         HcMx5IrHg5zq/Lb0r+pzaMcMPSgSF2NRKo0dxqEIlnJ2F/lwCkSub/7kAzspu18EtD
         UHiu9f27bYpNPgpPUnQj/FJX235A26qsIO0+iABwpUzzCyBBR07MeVtRCP51YGw8xB
         PQJYgD6/uru1DPq10JSJP47Mwk8FBO8jj2cH7chMvt/M70BzNVWNYVIf5+O3CZ1udO
         JB56OWi/DQO6A==
Date:   Tue, 5 Jul 2022 14:51:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pci: toshiba,visconti-pcie: Update the
 common clock properties
Message-ID: <20220705195125.GA78912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520085648.620703-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 05:56:48PM +0900, Nobuhiro Iwamatsu wrote:
> The clock for this driver switched to the common clock controller driver.
> Therefore, update common clock properties for PCIe controller in the binding
> document.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Acked-by: Rob Herring <robh@kernel.org>

Rob, does your ack mean you want me to pick this up?  It looks like
you merged the original 17c1b16340f0 ("dt-bindings: pci: Add DT
binding for Toshiba Visconti PCIe controller")?

> ---
>  .../devicetree/bindings/pci/toshiba,visconti-pcie.yaml         | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> index 30b6396d83c8..b9d0484606cc 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> @@ -69,6 +69,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/clock/toshiba,tmpv770x.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> @@ -102,7 +103,7 @@ examples:
>                   0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
>                   0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
>                   0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> -            clocks = <&extclk100mhz>, <&clk600mhz>, <&clk25mhz>;
> +            clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
>              clock-names = "ref", "core", "aux";
>              max-link-speed = <2>;
>          };
> -- 
> 2.36.0
> 
> 
