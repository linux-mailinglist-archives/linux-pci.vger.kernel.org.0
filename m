Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863C76EB988
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 16:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDVOCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDVOCm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 10:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29341FDE;
        Sat, 22 Apr 2023 07:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5075860F18;
        Sat, 22 Apr 2023 14:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51947C433EF;
        Sat, 22 Apr 2023 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682172160;
        bh=M+19OIGkYQfkDhd3NC46xx3NZlpI86+iqKp9pMPHUMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/g0byYEMbp0Gjic00ZuQuvBUPdlkgXax9XQ327dTlxoeKG6k/+6ElZ3d2hXBRX6b
         0v0wWXXQi9fHxlW4LyOPfOYFJ20duSzgOdwCRsu/n9Rt7BmaKRXtNkGqfIm0/fFX4q
         1rXkHW9NILgklzzyryOpyjq6GiBITIncATd9FyUWWuy+3rfwuYXs8mFD/ggXUl+/yQ
         mGLjJpP3uf4bwjZJdAETGrEtxFWGOmDG/MUj1VsMbfwC50/z3281EJdUuMMeHAg2Fm
         PDbrYchg31PcetngyEAPK+Jv42x9fqnuCjuwV0gcbKxbrJbM3f794V56r9hXtwm0P2
         f7GOJV/I3TXMQ==
Date:   Sat, 22 Apr 2023 19:32:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 16/22] dt-bindings: PCI: dwc: Update maxItems of reg
 and reg-names
Message-ID: <20230422140230.GM4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-17-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-17-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:57PM +0900, Yoshihiro Shimoda wrote:
> Update maxItems of reg and reg-names on both host and endpoint
> for supporting a new SoC later.
> 

Which SoC?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

With the above fixed,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++--
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> index 8fc2151691a4..cb727f60be0b 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -33,11 +33,11 @@ properties:
>        normal controller functioning. iATU memory IO region is also required
>        if the space is unrolled (IP-core version >= 4.80a).
>      minItems: 2
> -    maxItems: 5
> +    maxItems: 6
>  
>    reg-names:
>      minItems: 2
> -    maxItems: 5
> +    maxItems: 6
>      items:
>        oneOf:
>          - description:
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 1a83f0f65f19..0bfcfd6ccb5f 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -33,11 +33,11 @@ properties:
>        are required for the normal controller work. iATU memory IO region is
>        also required if the space is unrolled (IP-core version >= 4.80a).
>      minItems: 2
> -    maxItems: 5
> +    maxItems: 6
>  
>    reg-names:
>      minItems: 2
> -    maxItems: 5
> +    maxItems: 6
>      items:
>        oneOf:
>          - description:
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
