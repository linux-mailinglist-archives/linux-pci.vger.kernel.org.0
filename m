Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899FE516F16
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384813AbiEBLxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEBLxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 07:53:17 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 04:49:48 PDT
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516217041;
        Mon,  2 May 2022 04:49:48 -0700 (PDT)
Received: by rosenzweig.io (Postfix, from userid 1000)
        id 6848A41019; Mon,  2 May 2022 11:40:19 +0000 (UTC)
Date:   Mon, 2 May 2022 11:40:19 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: apple,pcie: Drop max-link-speed from
 example
Message-ID: <Ym/DI6yAmSHCHimf@rosenzweig.io>
References: <20220502091308.28233-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502091308.28233-1-marcan@marcan.st>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io> 
On Mon, May 02, 2022 at 06:13:08PM +0900, Hector Martin wrote:
> We no longer use these since 111659c2a570 (and they never worked
> anyway); drop them from the example to avoid confusion.
> 
> Fixes: 111659c2a570 ("arm64: dts: apple: t8103: Remove PCIe max-link-speed properties")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> index 7f01e15fc81c..daf602ac0d0f 100644
> --- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -142,7 +142,6 @@ examples:
>            device_type = "pci";
>            reg = <0x0 0x0 0x0 0x0 0x0>;
>            reset-gpios = <&pinctrl_ap 152 0>;
> -          max-link-speed = <2>;
>  
>            #address-cells = <3>;
>            #size-cells = <2>;
> @@ -153,7 +152,6 @@ examples:
>            device_type = "pci";
>            reg = <0x800 0x0 0x0 0x0 0x0>;
>            reset-gpios = <&pinctrl_ap 153 0>;
> -          max-link-speed = <2>;
>  
>            #address-cells = <3>;
>            #size-cells = <2>;
> @@ -164,7 +162,6 @@ examples:
>            device_type = "pci";
>            reg = <0x1000 0x0 0x0 0x0 0x0>;
>            reset-gpios = <&pinctrl_ap 33 0>;
> -          max-link-speed = <1>;
>  
>            #address-cells = <3>;
>            #size-cells = <2>;
> -- 
> 2.35.1
> 
