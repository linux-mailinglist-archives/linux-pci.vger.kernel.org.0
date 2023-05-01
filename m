Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC16F38F6
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjEAUBy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 16:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjEAUBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 16:01:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB603AA5;
        Mon,  1 May 2023 13:01:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4edc7cc6f46so3566028e87.1;
        Mon, 01 May 2023 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682971234; x=1685563234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvmu5M+HURCzZFCW8OzaI5WwpQHIEwD9NCXnM545kfc=;
        b=dala0YJi12o2pLjSbA2nD6dyxRl7IXpfhKwGipsn4XoD6VQ7qdvIj4MCBwHUJpPf+L
         4n3DCxBYt+twy8FU2dP1GYz79xAedgdYMUC+1VVj94NdIr9hvlE8/EoEJp7pykcaXUf2
         AfL3OEVOHP8/2AiB4EhDXAnaL887UNToAhj+t+uDxvnkjOdLXw1vs4I0PsctD810Tizv
         R9kHRcnBxDr1p1RGETuPWKBpwbLYa0jPqyjHfVw3UDJBWweX4L0iTs4RFWN4YJZIceGE
         LHi2XTSthHbBnfeFycDrYTN3EmKoS1Db/PPfyEAEc7mp+Q8XoXnbYJQsu4ETbAJ0drHc
         MyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682971234; x=1685563234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvmu5M+HURCzZFCW8OzaI5WwpQHIEwD9NCXnM545kfc=;
        b=ER8A/vybIZQK5nSGVrCYGaIBORqsnprBYezH9siC+GF/mhE8TZVEVBHmIIsyX31IGf
         b4m/oi7oxHTcZfCQOO6zVD5GSkCPV+MpkOewyIyylJbf+EZYlM3QwQgMC5TRLl3Z2XJJ
         uFmWOqBEZc2qz+6uMJdu5g8Yygi7Iao9K3QNuUrqxA64hKe5qINDdkeYzqnlHCoUyPmC
         n1Y+4paGXzFQ/nAyliA2hOkBZVNOGx6m5JXXh+ym8UsMgvUt+hrBtiA3K3KfoHs6DoJ3
         HbFMKA5Eymu35Eq2pw6G9Lh8frjpOyRIddcnHckGyYzdvzsRv3nVWgE8h6773DrPKtb9
         O7CQ==
X-Gm-Message-State: AC+VfDxB2ZzDmyWt9+F2p0AnMmhN74C0eOb+D8ona2hEb5tUcATJnSRI
        EN0nx2OQ04ZK3TXog/2grnE=
X-Google-Smtp-Source: ACHHUZ6kOmxcE+5Uz0pFYE/HefI5nwfA5Wj8yqky8D9ZmNcg2yqJZXUgRhxxucmIz6PWHpFvvjDsMA==
X-Received: by 2002:ac2:53b9:0:b0:4ee:5aeb:e2f2 with SMTP id j25-20020ac253b9000000b004ee5aebe2f2mr5007035lfh.38.1682971233710;
        Mon, 01 May 2023 13:00:33 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id b27-20020a056512025b00b004a91df49508sm4926052lfo.177.2023.05.01.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:00:33 -0700 (PDT)
Date:   Mon, 1 May 2023 23:00:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 15/21] dt-bindings: PCI: dwc: Update maxItems of reg
 and reg-names
Message-ID: <20230501200030.45aibpsx5lmwl2ty@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-16-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-16-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:51PM +0900, Yoshihiro Shimoda wrote:
> Update maxItems of reg and reg-names on both host and endpoint
> for supporting Renesas R-Car Gen4 PCIe controllers later.

Right. I haven't anticipated it in my DW PCIe DT-bindings series.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
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
