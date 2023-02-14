Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFF6968F1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 17:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBNQNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjBNQNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 11:13:05 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAFD2BEC3;
        Tue, 14 Feb 2023 08:12:42 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id y7so6033207iob.6;
        Tue, 14 Feb 2023 08:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LD9SzIWdhRY9asjg/ZL2uFG6rIBopHeDBCQ4UT5kFqo=;
        b=zefSb2B5wnumKeK4V2sGwNUtb6dykC55BIiNMWoN2ts8fH4F6LW1n5yTeCY2odKxDV
         B5vMjiAHy5LTPJNTZ8qedXKuKACjTtyUoht0Uimo0+7QQETYLfb9RJuz5ijWoODPS1VV
         YMw8cKA3vAK+sTNapoHA46R+InpVxUoKGx7S8kQ3vppEynMv+C511EI3orsi4sqLssYW
         r0HKnnD2ZKoVnJcKufTv7Q6Dph1St7rxKCdQuUl3I4eOzU0T79YfsDCJSmvzLpQrry0h
         l32Uycipl8uD6lFFq/pvFCPWXCTV1iZ5hBGhEposCwRsFrmIE32C5LNYMWsX9vfS3uGs
         rFhQ==
X-Gm-Message-State: AO0yUKU71PUlqqrNloawXaLI+MrQJql5Xf9mupbtIHiQJJQX7V+jBtw7
        fAX1X31D7+Hnnf7LzVisfQ==
X-Google-Smtp-Source: AK7set8qyUSgOs3whqgR606O4US8PwptRL2/mzIDXkCpojqDRiSAUOK9HZYVQ8EeJU7Yi8QskcIWuw==
X-Received: by 2002:a5e:8e05:0:b0:722:5927:c9c0 with SMTP id a5-20020a5e8e05000000b007225927c9c0mr2387877ion.4.1676391162000;
        Tue, 14 Feb 2023 08:12:42 -0800 (PST)
Received: from robh_at_kernel.org (c-73-14-99-67.hsd1.co.comcast.net. [73.14.99.67])
        by smtp.gmail.com with ESMTPSA id q11-20020a056e02106b00b00313b281ecd2sm4838378ilj.70.2023.02.14.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:12:41 -0800 (PST)
Received: (nullmailer pid 76714 invoked by uid 1000);
        Tue, 14 Feb 2023 16:12:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     pankaj.dubey@samsung.com, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, jh80.chung@samsung.co,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hongxing.zhu@nxp.com,
        alim.akhtar@samsung.com, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, m.szyprowski@samsung.com,
        kw@linux.com, devicetree@vger.kernel.org,
        Sergey.Semin@baikalelectronics.ru,
        linux-samsung-soc@vger.kernel.org, lukas.bulwahn@gmail.com,
        lpieralisi@kernel.org
In-Reply-To: <20230214121333.1837-11-shradha.t@samsung.com>
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1@epcas5p1.samsung.com>
 <20230214121333.1837-11-shradha.t@samsung.com>
Message-Id: <167638945319.3745.5262086066044660323.robh@kernel.org>
Subject: Re: [PATCH 10/16] dt-bindings: PCI: Add phy-names as required
 property
Date:   Tue, 14 Feb 2023 10:12:34 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 14 Feb 2023 17:43:27 +0530, Shradha Todi wrote:
> To replace devm_of_phy_get with devm_phy_get to get the
> PHY pointer using non DT version, we need to add phy-names
> property in DT and make it a required property with const
> value.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  Documentation/devicetree/bindings/pci/samsung,pcie.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.example.dtb: pcie@15700000: 'phy-names' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230214121333.1837-11-shradha.t@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

