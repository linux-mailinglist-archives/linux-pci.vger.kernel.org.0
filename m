Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0784E9704
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbiC1MxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242643AbiC1Mww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 08:52:52 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD7A6424;
        Mon, 28 Mar 2022 05:51:10 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-de3eda6b5dso15113393fac.0;
        Mon, 28 Mar 2022 05:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cQGZg2ywem6zxyCvwABFfPlNmUhfTOw/8YRFpemaFf4=;
        b=lxYI6PE/y1AyVi/kPrz3uzfMQr9NaeAJKx8sGYkkgayhNhRdX+0v8MSLkl0ltW8lPc
         +bQaTpJ9DHNQyC4ADdh5zwr4gAP4aTUFj6xsZ2JYYDOeobyBPIKgd9ci+lZ08p2jFaMv
         801DaSCgvRAMAndOHxMccqrF18/Txhat1aQdT3HFXkJh19UHjybZWD6n8ega68PUY3Fo
         pZELp6whHbujMgMelI8H9FtkqWGMxsWL1vHbvfiJ4YPOB1RRr8A3bU0TPUWc5HSaniAR
         Ay3ZvsiiNOn3Uv6RyWymXtu2xVYsPSkL1t6kahtYQhtQD5QdxlssOaFRMeF7Wx4koVlE
         0LNw==
X-Gm-Message-State: AOAM530/wo7YVM7ixMwqwClLMz94E/DAq0sQuC9xy79gOFymU07BV7gS
        STn7jcA96DPvD+7wBftaxA==
X-Google-Smtp-Source: ABdhPJxhc/XOS06cKfWmV8nxW6YHrYLXoTD/KyWUtNUbx5hNVIsj9+PLIdx7x7AayOuJl1MVzaw89Q==
X-Received: by 2002:a05:6870:a1a0:b0:dd:e471:8baf with SMTP id a32-20020a056870a1a000b000dde4718bafmr14907619oaf.40.1648471869579;
        Mon, 28 Mar 2022 05:51:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n62-20020acaef41000000b002ef646e6690sm7309500oih.53.2022.03.28.05.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:51:08 -0700 (PDT)
Received: (nullmailer pid 2153574 invoked by uid 1000);
        Mon, 28 Mar 2022 12:51:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <1648433498-23450-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648433498-23450-1-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to json-schema
Date:   Mon, 28 Mar 2022 07:51:05 -0500
Message-Id: <1648471865.799906.2153573.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Mar 2022 11:11:38 +0900, Kunihiko Hayashi wrote:
> Convert the file into a JSON description at the yaml format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/pci/socionext,uniphier-pcie.yaml | 100 ++++++++++++++++++
>  .../devicetree/bindings/pci/uniphier-pcie.txt |  82 --------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 101 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1609988


pcie@66000000: compatible: ['socionext,uniphier-pcie', 'snps,dw-pcie'] is too long
	arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dt.yaml
	arch/arm64/boot/dts/socionext/uniphier-ld20-global.dt.yaml
	arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dt.yaml
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dt.yaml

