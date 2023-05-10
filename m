Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8E6FDB43
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjEJKDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjEJKDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 06:03:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486565A4
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 03:03:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so12566047a12.1
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683713024; x=1686305024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXkL38+f1ngRUOm18ZpalyUvbkYRXsdB38LEiKs+XYU=;
        b=R+FWrCYSj/Yeo0NAn+Wnna7pA0/zwlsqYN+KgBHv2JMAqODemnRkTkca3fQYGIo8AY
         JXPcwd6d/MPp05AEear7jnsOO0UmuSN23Z2h9yvpD/zgeiKwOjYAt9gFs+l2X/wiuOZG
         rkS/59S89QftcWV+2HqvK4TdV0r1wfABAhEgiQ07O5u5ekq9zHad8U0Z4SO+5k6ryYM9
         +P8p1bQ8SiREb26IPt7yTjkfHaBY73E9Rc1mgb5cel4StmlMjMM5HiWTU/p7hItZoW/P
         4NGb1703GpllXae9PyW9QdMB0oLpJhUJsdwumR1uMUTf9FwvCSEh1RhG1pL3u02Uvv64
         0kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713024; x=1686305024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXkL38+f1ngRUOm18ZpalyUvbkYRXsdB38LEiKs+XYU=;
        b=gUGs1+WmLTlU6m6+Z4OJ0YogJFWkWzPxlblcWGV9Q0PqxVNvKLqJijkNG8JSbo/Ba6
         aRmOgK4YI7AIt0+1pcbxF6nvO/mahtPnJiLn9/BzfnVT27Yh/OrHAcCm1G1uxqA48ajv
         W1xcfDy/zboldTzL1M1ItzgAEKyU4lRFTAtDjZCnW5UMZt40ZrbN7P8eEhBca6MHSzeT
         QbOC150fPauOB5UgOcF+uNgFhoya6cpdUb4JcXhTAHRvyr82SxTMU45xwIs2nDRRoAG+
         HPTgEqueE7dKkt/UIfeXrCZEmpxiaja8nju7KJqSNWdFYQzAP7KXAPWCf0fUZ498L4H9
         HfMg==
X-Gm-Message-State: AC+VfDwqdC8KwMoFzPisa4Fk2+G6bXWzYhMjwz/a3+6dH3+Vc9fwqJal
        LcXkXFuHTnGmpDEe9eyjUIxLXw==
X-Google-Smtp-Source: ACHHUZ6Q0SYXkGsPfGGGsxb7netz6Es7bm8EVJED6/gqAeRTS2GlpJPFwUjaOmwqI+c/4TkUt27fMg==
X-Received: by 2002:aa7:cd53:0:b0:50b:c49b:62d4 with SMTP id v19-20020aa7cd53000000b0050bc49b62d4mr12938066edw.28.1683713023853;
        Wed, 10 May 2023 03:03:43 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id d16-20020a056402001000b0050bd47f9073sm1720193edu.39.2023.05.10.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 03:03:43 -0700 (PDT)
Date:   Wed, 10 May 2023 12:03:41 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        mani@kernel.org, kw@linux.com, jingoohan1@gmail.com,
        kishon@kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, fancer.lancer@gmail.com,
        Rob Herring <robh@kernel.org>, robh+dt@kernel.org,
        marek.vasut+renesas@gmail.com, devicetree@vger.kernel.org,
        lpieralisi@kernel.org
Subject: Re: [PATCH v16 17/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Message-ID: <20230510100341.euimwx7jezgthsuk@krzk-bin>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-18-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-18-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 May 2023 15:22:29 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.example.dtb: pcie@e65d0000: reg: [[0, 3864854528, 0, 4096], [0, 3864862720, 0, 2048], [0, 3864866816, 0, 8192], [0, 3864875008, 0, 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.example.dtb: pcie@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'config'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.example.dtb: pcie@e65d0000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-ranges', 'interrupt-map', 'interrupt-map-mask', 'ranges', 'snps,enable-cdm-check' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml


See https://patchwork.ozlabs.org/patch/1779258

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
