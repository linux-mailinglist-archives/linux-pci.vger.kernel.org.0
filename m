Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A04E53BB5E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiFBPIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiFBPIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 11:08:52 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30706B7D6;
        Thu,  2 Jun 2022 08:08:51 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id m82so6824384oif.13;
        Thu, 02 Jun 2022 08:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHVMppeew5tvngB9V7RVRiVw3/EcQO9cXfk5fahNvLU=;
        b=fBxcKX6i+esqGFur/dZk6XvOGTQNB4GYwtI9V+JmIS9Yw7q1pFS0UETlEPSepPLrpB
         SRDu417ZJxiTn1YPUu/Na0cAuKnegfbp7wXvhLtOZ8DvLPDCa4GVt9vDZ5/HxwHHr/WP
         AM6mMeI1RTgBdRBznhlieHvlX7tcAaJ4a0EINyx956F84s8nQOx4w8+MQKb3Aw6SxXse
         znmmAxnJ/d3RH/52PFjKykvo0PaeoqTLy9nYozTYe7l6CQZzMNAkRM5xdtYzKB3EExAI
         P3O3UMhUTYHvZflT3fBh8nENCKUfyFYh1/xGbGp0QrSAD8ieDFseBB0OVsMz1xtgV9fs
         XwkQ==
X-Gm-Message-State: AOAM530rPQRLldzk8qBa4AU27AfkyXbsDCdjMxa9TvZ/Y6XxYup1Oscm
        Q6TKx93n+PUrtlAFZXaxfA==
X-Google-Smtp-Source: ABdhPJwI6NXiIW3dX0C54wwELhLgM1CsiWXpZ2l+oWAZfXgMWDCL7fHj3aUVKFwUwLojjrteAyY0kA==
X-Received: by 2002:a05:6808:13d4:b0:32e:3651:bbb1 with SMTP id d20-20020a05680813d400b0032e3651bbb1mr1707443oiw.86.1654182530993;
        Thu, 02 Jun 2022 08:08:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s11-20020a4adb8b000000b0035eb4e5a6d2sm2326257oou.40.2022.06.02.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:08:50 -0700 (PDT)
Received: (nullmailer pid 2330349 invoked by uid 1000);
        Thu, 02 Jun 2022 15:08:50 -0000
Date:   Thu, 2 Jun 2022 10:08:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: apple: Add missing 'power-domains'
 property
Message-ID: <20220602150850.GA2330255-robh@kernel.org>
References: <20220531215815.2408477-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531215815.2408477-1-robh@kernel.org>
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

On Tue, 31 May 2022 16:58:14 -0500, Rob Herring wrote:
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
> 
> The Apple PCIe host schema is missing 'power-domains' in the schema.
> The example has 3 power domains. However, this is wrong too as actual
> dts files have a single power domain and Sven confirmed 1 is correct.
> 
> Cc: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Correct the power-domains to be 1 and update the example
> ---
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks!
