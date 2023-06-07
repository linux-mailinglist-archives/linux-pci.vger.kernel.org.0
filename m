Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DF727066
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 23:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjFGVRo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 17:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFGVRn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 17:17:43 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994F1BC2;
        Wed,  7 Jun 2023 14:17:41 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-777b4716673so62429539f.1;
        Wed, 07 Jun 2023 14:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686172660; x=1688764660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CezTeziIf00zGpoaS9kJexhOOJCksUQFj/tFMeNhKEI=;
        b=Zdew9f6v1S43JgwN6IG53pOGdqd+3oxYD028cfcvKVFUNPiwAAb1Di9fTFPHqO2l8A
         CNXvCCQoTTOeNPWUQxYs6+gFFYixiukNA9VNOPviIotGGj0uY9XbSZuuT+PpiCtqApeL
         DXNtA6foVRMMa3ou5RaZ94+C9Mx8D1kritb5r+eKWoihuPexKLbB0C55K6IJ+sEgTvbq
         9ktXDUmBRzxKHHe77uMfrrKXIQ0O23FQ3yFvVPPiug3BPwZEV/MDhsc8eDGhznsWJTC8
         JO8GpLUrrL0XeaMHvikrFzWuE8uFpZpCnGBpLIciEjND2uNJ6BnRx0gRg01jlTxB4XRD
         ar6w==
X-Gm-Message-State: AC+VfDxo7ji1dkmzUove//0iSqX9/ueY7k1EVitYg+a+QpQhc0LyQKHr
        JlTbU+yx2n2/rYLxoJlR0g==
X-Google-Smtp-Source: ACHHUZ7xDt00NqecnMVQ7QklGZOSiZ6wbDqFwT3Bg6xKWAh7OlzGKj1NKXq780cgjNHvEXrKVPDTJg==
X-Received: by 2002:a6b:dd10:0:b0:777:a7a5:9c80 with SMTP id f16-20020a6bdd10000000b00777a7a59c80mr219524ioc.6.1686172660649;
        Wed, 07 Jun 2023 14:17:40 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d26-20020a5d9bda000000b00763699c3d02sm4097710ion.0.2023.06.07.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:17:39 -0700 (PDT)
Received: (nullmailer pid 4108377 invoked by uid 1000);
        Wed, 07 Jun 2023 21:17:38 -0000
Date:   Wed, 7 Jun 2023 15:17:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Conor Dooley <conor+dt@kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: updated max-link-speed for newer
 generations
Message-ID: <20230607211738.GA4076577-robh@kernel.org>
References: <20230531092121.291770-1-ben.dooks@codethink.co.uk>
 <20230531092121.291770-2-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531092121.291770-2-ben.dooks@codethink.co.uk>
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

On Wed, May 31, 2023 at 10:21:21AM +0100, Ben Dooks wrote:
> Add updated max-link-speed values for newer generation PCIe link
> speeds.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..56391e193fc4 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -22,8 +22,9 @@ driver implementation may support the following properties:
>     If present this property specifies PCI gen for link capability.  Host
>     drivers could add this as a strategy to avoid unnecessary operation for
>     unsupported link speed, for instance, trying to do training for
> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> -   for gen2, and '1' for gen1. Any other values are invalid.
> +   unsupported link speed, etc.  Must be '6' for gen6,  '5' for gen5,
> +   '4' for gen4, '3' for gen3, '2' for gen2, and '1' for gen1.
> +   Any other values are invalid.

This file is a deadend to be removed.

Please update dtschema with the new values.

Rob
