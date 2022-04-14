Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26221501A91
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiDNR4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbiDNR4S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 13:56:18 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0CEAC9B;
        Thu, 14 Apr 2022 10:53:53 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id w127so6171920oig.10;
        Thu, 14 Apr 2022 10:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LDb6a54Kbel4HFnWgqEnQRC1KuI8HmYdyvPnVqEyvNM=;
        b=RPjvYP1iMaRnISHqZiIUrdazy+j72GCIkPX5Wsm0lakMzKln0OInBGrkAiikfMySHB
         G6sqQTr2XF8Dyv8fWq+4Ym8NYdyHrBsNodoKbZMI10XXGxZKQ4XJscoN36E1lQcgMiiw
         tK56L95nSfKGX6FFuw3wsX3MNfNAnZBX9kICJXVyoaKU/h2miL7JVK5TgjRs9xFWrkiD
         dmnv9xHPOGbAKs1ddo8537A8yzkpmsvt+BvVtm25mDzrr80vvhSmj0X2Tv+3wWz6a06a
         TjPVA+1+E8gq/rohRg7946k69guYGLIzI4slwxIcrn1zrF2ke6ufgf+xJzdEVYfAZ7Cz
         mZVw==
X-Gm-Message-State: AOAM531AxBANnxX5+jbZ0Cbu6NNwFJbCdjbKVO+eocXHVWkXFemPjEL/
        U4lX9VmS3pPthPpb1wFukA==
X-Google-Smtp-Source: ABdhPJyG5OxYiytphJidoOSVhiPpd6J458I+J5CA5KHBqlbSmUD1awtoYmV8QXhgL5wR6MeqIR3cOA==
X-Received: by 2002:aca:b507:0:b0:2fa:6d40:4b40 with SMTP id e7-20020acab507000000b002fa6d404b40mr1885135oif.246.1649958832439;
        Thu, 14 Apr 2022 10:53:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nd8-20020a056871440800b000e2b75759f1sm891690oab.38.2022.04.14.10.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:53:52 -0700 (PDT)
Received: (nullmailer pid 2307872 invoked by uid 1000);
        Thu, 14 Apr 2022 17:53:51 -0000
Date:   Thu, 14 Apr 2022 12:53:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: pci: remove fallback from Rockchip
 DesignWare binding
Message-ID: <Ylhfr51RME+YAjOG@robh.at.kernel.org>
References: <20220413133731.242870-1-pgwipeout@gmail.com>
 <20220413133731.242870-2-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413133731.242870-2-pgwipeout@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 13, 2022 at 09:37:28AM -0400, Peter Geis wrote:
> The snps,dw-pcie binds to a standalone driver.
> It is not fully compatible with the Rockchip implementation and causes a
> hang if it binds to the device.
> 
> Remove this binding as a valid fallback.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 142bbe577763..8dc11fed8a3c 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -32,7 +32,6 @@ properties:
>    compatible:
>      items:
>        - const: rockchip,rk3568-pcie
> -      - const: snps,dw-pcie

With this, you no longer need 'select' so please drop it too.

>  
>    reg:
>      items:
> @@ -110,7 +109,7 @@ examples:
>          #size-cells = <2>;
>  
>          pcie3x2: pcie@fe280000 {
> -            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
> +            compatible = "rockchip,rk3568-pcie";
>              reg = <0x3 0xc0800000 0x0 0x390000>,
>                    <0x0 0xfe280000 0x0 0x10000>,
>                    <0x3 0x80000000 0x0 0x100000>;
> -- 
> 2.25.1
> 
> 
