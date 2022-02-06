Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C434AAEFF
	for <lists+linux-pci@lfdr.de>; Sun,  6 Feb 2022 12:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiBFLdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Feb 2022 06:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiBFLdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 06:33:32 -0500
X-Greylist: delayed 222 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 03:33:31 PST
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D8CC043181
        for <linux-pci@vger.kernel.org>; Sun,  6 Feb 2022 03:33:31 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 145D94003D
        for <linux-pci@vger.kernel.org>; Sun,  6 Feb 2022 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644147210;
        bh=ZiDU9Eu3x+M8fVHZBfeMoqgYec/dSCr3pkNCtmbnF0Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vt9a0OJwHTP5YJBNR4cI0KJmrPJZbHdfA19zAi95Km9ElnUYKVrrVL46KhjP6GEzD
         tfpVKAuCyCl/qhRevWgtSb0DhuK1f0GyXO6+7v+maXLf35ITq3xVNotyWFptWRYMsk
         PEvM4K10M/NXOL2zuOxLziC30D3JHZBbPn3ErxRFGGYVFQzjKj0p8U8qHKvXP1vYgU
         uiMs4VBbppatnwo8jH1es0W5e9Rn2SxhuzVbIcCTyXaPT98r+y6KglKdDlTcg44Qwb
         CCZdzjXuAxHeVb5gN3IgSlBj0878CkqMj3vUacLXPhU0goC2nEnUQvZuioDMVVGSlJ
         k/DFhBfwoM9lg==
Received: by mail-ed1-f72.google.com with SMTP id k12-20020a50c8cc000000b0040f28426e5aso2338485edh.17
        for <linux-pci@vger.kernel.org>; Sun, 06 Feb 2022 03:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZiDU9Eu3x+M8fVHZBfeMoqgYec/dSCr3pkNCtmbnF0Y=;
        b=W3xp59Gwy4vpkwZCYTb5iwi9jYEFfx9612XyuQ9jmKrvL5G0KRwOQbY0AiTEiQDUHL
         0gkIwqOH6JWh92FC3X9RLNq7ah8ySZb1SUZd4tNGB710rkckItOL+eeKGsDNWaWdmkJ1
         kfVT+O9/U4cG9Ckrf2Wo4p0PhQ7ef3dn0dTWhi4w6oU4quWNXCy9IU1uSVhSgFj4m9GJ
         WWuBHf24hJMIuKr9Tp7+uBlHAnnLaZkXqc3iCiiY6ndki5GbJRAk5GXMZkdm+jbvWXoe
         61OTTvFIfQ/fWBsQiFFdBEdFWZE0uCi9nXYj6SVlg4VmpGOSQgGAdo2qBOMEedWUwrJD
         zuCQ==
X-Gm-Message-State: AOAM531dF8MJFaYTflsSsJzjFv8+TPFhgPhSrUPGTRupTrIIQUVg2PT2
        L2XoDKGoVgvnpFXOxeMo/VbA2xBnzmQndtCOVvQoR4SOo4mteoidKl8NE/ulHMerYdO7dF92SwC
        fxMtDOIFw643FaPJpmap1ejghK8FjqG9Z/8W2+Q==
X-Received: by 2002:a50:fc06:: with SMTP id i6mr6183209edr.89.1644147209699;
        Sun, 06 Feb 2022 03:33:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwy3U1ftL3UccDBSq+2ALlKh+KNAz5yKkEnqRtTK4p/TCdyp5nH+nET54fdFXxmYZ3tk3uTmg==
X-Received: by 2002:a50:fc06:: with SMTP id i6mr6183183edr.89.1644147209552;
        Sun, 06 Feb 2022 03:33:29 -0800 (PST)
Received: from [192.168.0.83] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ck7sm1294186ejb.44.2022.02.06.03.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 03:33:28 -0800 (PST)
Message-ID: <4e2bec9b-4759-b699-fa7b-974f5f43da9d@canonical.com>
Date:   Sun, 6 Feb 2022 12:33:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V1 03/10] dt-bindings: memory: Add Tegra234 PCIe memory
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220205162144.30240-1-vidyas@nvidia.com>
 <20220205162144.30240-4-vidyas@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220205162144.30240-4-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/02/2022 17:21, Vidya Sagar wrote:
> Add the memory client and stream ID definitions for the PCIe hardware
> found on Tegra234 SoCs.

I could not find dependencies or merging strategy in cover letter.
Please always describe it, so I don't have to go through all the patches
to figure this out.

> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  include/dt-bindings/memory/tegra234-mc.h | 64 ++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
> index 2662f70c15c6..60017684858a 100644
> --- a/include/dt-bindings/memory/tegra234-mc.h
> +++ b/include/dt-bindings/memory/tegra234-mc.h
> @@ -7,15 +7,53 @@
>  #define TEGRA234_SID_INVALID		0x00
>  #define TEGRA234_SID_PASSTHROUGH	0x7f
>  
> +/* NISO0 stream IDs */
> +#define TEGRA234_SID_PCIE0	0x12U
> +#define TEGRA234_SID_PCIE4	0x13U
> +#define TEGRA234_SID_PCIE5	0x14U
> +#define TEGRA234_SID_PCIE6	0x15U
> +#define TEGRA234_SID_PCIE9	0x1FU
>  
>  /* NISO1 stream IDs */
>  #define TEGRA234_SID_SDMMC4	0x02
> +#define TEGRA234_SID_PCIE1	0x5U
> +#define TEGRA234_SID_PCIE2	0x6U
> +#define TEGRA234_SID_PCIE3	0x7U
> +#define TEGRA234_SID_PCIE7	0x8U
> +#define TEGRA234_SID_PCIE8	0x9U
> +#define TEGRA234_SID_PCIE10	0xBU

I don't see usage of these...

>  #define TEGRA234_SID_BPMP	0x10
>  
>  /*
>   * memory client IDs
>   */
>  
> +/* PCIE6 read clients */
> +#define TEGRA234_MEMORY_CLIENT_PCIE6AR 0x28

I see you use them in DTS but not in mc driver. Don't you miss anything
here?

> +/* PCIE6 write clients */
> +#define TEGRA234_MEMORY_CLIENT_PCIE6AW 0x29
> +/* PCIE7 read clients */
> +#define TEGRA234_MEMORY_

Best regards,
Krzysztof
