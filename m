Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231947588A0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 00:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGRWlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 18:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRWlU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 18:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF91992;
        Tue, 18 Jul 2023 15:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F9286126C;
        Tue, 18 Jul 2023 22:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36781C433C7;
        Tue, 18 Jul 2023 22:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689720079;
        bh=Pdv6QIpn8FQCnZstZsZ0RQR6Zm2Buc8EqGmX8Albn5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4ZhtFF+qm9hkGQO5cHMDfNftjPP3amO9/hgnzAsDWjOzavM8ZMHPBgbvKrvfwcv0
         4XpAAAPGc1euY9kxCb+2l9kDernTG4hRMoEd3zdGwqpGV8LsSAfBYOkVcGBbnKCxOD
         u6x70PlWdU2JDqBb+rmulxRPCmLEx3QsYXXn/K+UhKoAbkQXVBPqNrAcpwTXaaAoPM
         SKVmXf0oUhy2F+2YWFheKBWuPPtSf3rxtSY+bN79+GFOZYF+yxyn5bnUs62z99/4Jc
         tk15R5bytpam1HqZykgT+eLSsG54NSs388IDZbPiFR8V5+E1wuon/uORgX25FBXLYi
         1XL4Eag4y10JQ==
Received: (nullmailer pid 2143349 invoked by uid 1000);
        Tue, 18 Jul 2023 22:41:16 -0000
Date:   Tue, 18 Jul 2023 16:41:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: dwc: improve msi handling
Message-ID: <20230718224116.GA2142638-robh@kernel.org>
References: <20230717172651.64324-1-sebastian.reichel@collabora.com>
 <20230717172651.64324-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717172651.64324-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 07:26:47PM +0200, Sebastian Reichel wrote:
> Allow missing "msi" interrupt, iff the node has a "msi-map" property.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml        | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 1a83f0f65f19..abc1bcef13ec 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -25,6 +25,15 @@ select:
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
>    - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> +  - if:
> +      not:
> +        required:
> +          - msi-map
> +    then:
> +      properties:
> +        interrupt-names:
> +          contains:
> +            const: "msi"

Don't need quotes.

>  
>  properties:
>    reg:
> @@ -193,9 +202,6 @@ properties:
>            oneOf:
>              - description: See native "app" IRQ for details
>                enum: [ intr ]
> -    allOf:
> -      - contains:
> -          const: msi
>  
>  additionalProperties: true
>  
> -- 
> 2.40.1
> 
