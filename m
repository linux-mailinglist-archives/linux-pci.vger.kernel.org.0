Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC25871E1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 21:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiHAT6q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiHAT6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 15:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E982CB848;
        Mon,  1 Aug 2022 12:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3789B8167E;
        Mon,  1 Aug 2022 19:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171DCC433C1;
        Mon,  1 Aug 2022 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659383922;
        bh=bYJ0bSRA0g70/0Gy+QE2z5n6tE03ra3n2Vh9gv/i9rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BUjLjhr16fTup+1WV0cV8ihRyjcASfi0gXV4QDqgSvhOFboSh8meclZWuuuYehsnx
         DG/wqnsR5EeKpoOW7fbyiKF0qLtgcngvVHsNCVKIaodiM8/dr11QOEW2WM41P/K2sC
         I9ZvPF4evUyjb0o85MG7LOHrqEuKCfWxaiQSBoXTBrOooGkZCrERvCUuqLtlvy2MHU
         0vxwGoKAQfVIN8joqnw0MIZ5S+ByZ3QLjmb3d93KXdxa2ZBOPZyEEb0gf08McCSss3
         9aWWxivmc6TJsJveLWOJWYLn+2mZbkeIqmUsguF/kKK0betFYWLGXq7KzIZraGGxXY
         Dejt4tUEP/UNQ==
Date:   Mon, 1 Aug 2022 14:58:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: host-generic-pci: Allow IOMMU and MSI
 properties
Message-ID: <20220801195840.GA621358@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728175137.1172841-1-robh@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 11:51:37AM -0600, Rob Herring wrote:
> Allow 'iommu-map', 'iommu-map-mask', and 'msi-parent' properties for
> generic host. This fixes unevaluated property warnings on Arm Juno, AMD
> Seattle, and FSL LS1028a.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

I assume you'll merge this, Rob?  Let me know if you want me to.

> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index 6bcaa8f2c3cf..d25423aa7167 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -106,6 +106,9 @@ properties:
>      maxItems: 3
>  
>    dma-coherent: true
> +  iommu-map: true
> +  iommu-map-mask: true
> +  msi-parent: true
>  
>  required:
>    - compatible
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
