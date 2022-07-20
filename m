Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B534257BF6F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiGTVHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGTVHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97224F19A;
        Wed, 20 Jul 2022 14:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DE69B8220E;
        Wed, 20 Jul 2022 21:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A98C3411E;
        Wed, 20 Jul 2022 21:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658351253;
        bh=1Ld4FvfjIhGCC9DAILNlZfNuF8HT5i1wxQaeRVUbfMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YvbWZdQJXXfi+kz4PP7VNfP/Lt3RfB/QdW2APqnK3nR0oBW0+dANP1X0CgPOUUFe6
         FttzxgsV+e0eqZyzMrSt1rfzsejYVtyh9GkzcWeh6mGJl3bc1nTYqP0OCnlRPSPpCu
         PCFTf/r1PWwEZD8SWKNB2Q3aC87VZtVpABHwLR3lVS+XJe4UgSgwZVRk+3480klkwl
         WON4x3e+oYZzkn5EwDZ7rgCRT+eg+3K3ILPYEaT8k38eXeLmxeZF+L3HDL6gNuZGMt
         KcW5+BtLrO25bO971OEaCcz7YxGco9FiLWob3G7gffa1LQOgQnTqovNErrBtmDtwpt
         ygvexKjEkj3eA==
Date:   Wed, 20 Jul 2022 16:07:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: fsl,imx6q-pcie: Add missing type for
 'reset-gpio-active-high'
Message-ID: <20220720210731.GA1657725@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719215031.1875860-1-robh@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 03:50:31PM -0600, Rob Herring wrote:
> 'reset-gpio-active-high' is missing a type definition and is not a common
> property. The type is boolean.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

You've merged previous updates, Rob, so I assume you'll do the same
with this.

> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 252e5b72aee0..376e739bcad4 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -144,6 +144,7 @@ properties:
>      description: If present then the reset sequence using the GPIO
>        specified in the "reset-gpio" property is reversed (H=reset state,
>        L=operation state) (optional required).
> +    type: boolean
>  
>    vpcie-supply:
>      description: Should specify the regulator in charge of PCIe port power.
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
