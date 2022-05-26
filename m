Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F11534F6A
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbiEZMki (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiEZMki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 08:40:38 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08032F392;
        Thu, 26 May 2022 05:40:37 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id t144so1946459oie.7;
        Thu, 26 May 2022 05:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AQamHjHqjaBZj2u5yKIBPO/vObcbZFHIk6zDCH1dFck=;
        b=C3PQAPuoivyAg/rdNzYYLKw/d/5sfxeAG0Cmg0PNpnjMGQ3YPUui2KUav+KuaqWjtl
         ZeNC+33ZHt8G7gtCnZYnS/cltOE77LKqIrx3d09MdVNOJCAGYzBkcFYyrjRx6oFnGbCb
         yxssd+wVTnIu5eesez3OpvLS7SuuEGE3q06amm+TWgIL+9Mn7V6UofqBHvgbWtp3oCli
         zMjByTR1m/kJC9OKWlzfJXM28rBnr7PCpu76Biph1gHAMrmVuZOOcXvu2yO9wLBvia4i
         acz+3wf3Ml1R3/AogD/Z2xs4hUrxkeHYsjkCCKTLiKcO7SrmVJd7BPRWye+j6Oy6ypD1
         Xdcg==
X-Gm-Message-State: AOAM5304SUsxj9OSQz62EqJMd6R6VhUEgcrqVFCywf7LRpUR13ZRHz4p
        01hQfDxgUiMdTSk93gGP9A==
X-Google-Smtp-Source: ABdhPJw6v1jlG/aL47HH5i/oSENJYdMRQCjPamtum1PF6Ms/NMUsitb0szo2+sDYTjlq15a5pxAlnw==
X-Received: by 2002:a54:409a:0:b0:32b:1820:c399 with SMTP id i26-20020a54409a000000b0032b1820c399mr1036653oii.110.1653568837078;
        Thu, 26 May 2022 05:40:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nl15-20020a056871458f00b000f20ac7e5a8sm548087oab.53.2022.05.26.05.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 05:40:36 -0700 (PDT)
Received: (nullmailer pid 3797154 invoked by uid 1000);
        Thu, 26 May 2022 12:40:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org
In-Reply-To: <20220526014107.2871787-1-robh@kernel.org>
References: <20220526014107.2871787-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: apple: Add missing 'power-domains' property
Date:   Thu, 26 May 2022 07:40:33 -0500
Message-Id: <1653568833.758093.3797153.nullmailer@robh.at.kernel.org>
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

On Wed, 25 May 2022 20:41:07 -0500, Rob Herring wrote:
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
> 
> The Apple PCIe host has 3 power domains at least according to the example.
> Add the 'power-domains' property to the schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Ideally, we'd define what each power domain is, but I don't know what
> they are.
> ---
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pcie@690000000: power-domains: [[59]] is too short
	arch/arm64/boot/dts/apple/t8103-j274.dtb
	arch/arm64/boot/dts/apple/t8103-j293.dtb
	arch/arm64/boot/dts/apple/t8103-j313.dtb
	arch/arm64/boot/dts/apple/t8103-j456.dtb
	arch/arm64/boot/dts/apple/t8103-j457.dtb

