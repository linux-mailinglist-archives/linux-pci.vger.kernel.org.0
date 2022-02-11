Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238D04B2878
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351126AbiBKO4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 09:56:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351117AbiBKO4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 09:56:05 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009F195;
        Fri, 11 Feb 2022 06:56:04 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id r27so9801295oiw.4;
        Fri, 11 Feb 2022 06:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G92XEusdmcOWW1tVd4s4eS/xu7wCfgqOh4/w21H1KCI=;
        b=tesSOSgQ5B/eHUYLCPIdbrLlD9dcsyOyugN4/qWS3FLRLsjbwgYLyi8dLEyuzTHL2I
         r079ADGYEmHyeWsGwmJZn7+si72MNfmDtvLdjeFYiHb4YI4kJkg+42+YJ6kORdYlnmbs
         kBiw1XKNQI260NIhxTHZVpeDfJhYydETIkTi/oRy+aKLF/hU2G8WRp3few4gRTSydygg
         7gvZt9YWCYCVSRgqoLCK8JfmaMxzXnNQLYbOeytgoY3pbusOzMmuE/xYbQ5gAzgBzw17
         /waAwQbbcN1FbCyRZ8nEUrJj/Hm+UbhOAPjqm63Skb+oXxDAQ82/5PvHwwEQ2AeiBbDP
         FTxQ==
X-Gm-Message-State: AOAM5328X7pbvi7/oL/PtRg0vunSS5ew+19F4kZ6mkXtRiKRk+Fgnvw+
        3FlKsU1oTxrJZbUlmiF/TA==
X-Google-Smtp-Source: ABdhPJxvk/bXB+X8A+FLOIi5cTW6wNNMcPBQMYmn+SeoN9QWfa96oOTjz+R+oKyp0y91s8XllCb2oA==
X-Received: by 2002:a05:6808:1924:: with SMTP id bf36mr336810oib.53.1644591363160;
        Fri, 11 Feb 2022 06:56:03 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id o144sm9739330ooo.25.2022.02.11.06.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:56:02 -0800 (PST)
Received: (nullmailer pid 353302 invoked by uid 1000);
        Fri, 11 Feb 2022 14:55:59 -0000
Date:   Fri, 11 Feb 2022 08:55:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, krzysztof.kozlowski@canonical.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 04/10] dt-bindings: PHY: P2U: Add support for Tegra234
 P2U block
Message-ID: <YgZ4/6ExXhAKSpdz@robh.at.kernel.org>
References: <20220205162144.30240-1-vidyas@nvidia.com>
 <20220205162144.30240-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205162144.30240-5-vidyas@nvidia.com>
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

On Sat, Feb 05, 2022 at 09:51:38PM +0530, Vidya Sagar wrote:
> Add support for Tegra234 P2U (PIPE to UPHY) module block which is a glue
> module instantiated once for each PCIe lane between Synopsys DesignWare
> core based PCIe IP and Universal PHY block.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../bindings/phy/phy-tegra194-p2u.yaml          | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> index 9a89d05efbda..6ba1f69b1126 100644
> --- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> @@ -4,7 +4,7 @@
>  $id: "http://devicetree.org/schemas/phy/phy-tegra194-p2u.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  
> -title: NVIDIA Tegra194 P2U binding
> +title: NVIDIA Tegra194 & Tegra234 P2U binding
>  
>  maintainers:
>    - Thierry Reding <treding@nvidia.com>
> @@ -12,13 +12,17 @@ maintainers:
>  description: >
>    Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
>    Speed) each interfacing with 12 and 8 P2U instances respectively.
> +  Tegra234 has three PHY bricks namesly HSIO, NVHS and GBE (Gigabit Ethernet)
> +  each interfacing with 8, 8 and 8 P2U instances respectively.
>    A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
> -  interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
> -  lane.
> +  interface and PHY of HSIO/NVHS/GBE bricks. Each P2U instance represents one
> +  PCIe lane.
>  
>  properties:
>    compatible:
> -    const: nvidia,tegra194-p2u
> +    oneOf:
> +      - const: nvidia,tegra194-p2u
> +      - const: nvidia,tegra234-p2u

Use 'enum'

>  
>    reg:
>      maxItems: 1
> @@ -28,6 +32,11 @@ properties:
>      items:
>        - const: ctl
>  
> +  nvidia,skip-sz-protect-en:
> +    description: Should be present if two PCIe retimers are present between
> +      the root port and its immediate downstream device.
> +      type: boolean

Check your indentation.

This patch should have failed checks for both of these issues. No report 
so either this patch couldn't be applied or there another issue. In any 
case, you failed to test this yourself.

Rob
