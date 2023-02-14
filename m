Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C266968ED
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjBNQNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 11:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjBNQM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 11:12:57 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085B252BD;
        Tue, 14 Feb 2023 08:12:39 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id j17so6019950ioa.9;
        Tue, 14 Feb 2023 08:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sxGQh4DHINPPQJzpA71hCGf9LwnTAZIRU/+oLDvRlgk=;
        b=dt3mx2Sm3ApPzYir4aK/MFBwDom804+1Bl/LJ9sPw+Q9KrYbxhdgjBp30DlwdzGutd
         VpYfoZp2oYlxAY/BwWDtngQAe4ucBzWul1hYnuTZXd2mNnFDscFP/1saGzbbzSHeYaoJ
         LIs61IZFMR6lPTBHxyI52LSs7KF/ZlrxgzOtgdV08XmfSe46pn/eX6UIBvjBUrj06OnW
         5AU+YGbxfuUwbjyqCvlZf9BwXVRq7q8uRCI5SuF9UwjAmmD+ufYKGkZ/9Z5huvilJPy+
         tXwAho7E9a+/AQWX2lwaLXYj53rtnEaTRTlXWUMqcqqButtBEmETkbDi4rn1xazu6B1q
         jCsQ==
X-Gm-Message-State: AO0yUKVyRQl7vFcwg+I3f8cADR+Vj97TmQ+bDfetxn6ypPT7eGgS/roK
        fWQeDvmeiXk1uHBSAtoNCA==
X-Google-Smtp-Source: AK7set8d05seqW+6Lpm2vtV7rgeGYkDNnRLFja2NokWcAe/KeKg1s2d/S8b8G5y3trFBOSommRRYsQ==
X-Received: by 2002:a5e:c30a:0:b0:71a:1b72:5afc with SMTP id a10-20020a5ec30a000000b0071a1b725afcmr2256087iok.19.1676391158375;
        Tue, 14 Feb 2023 08:12:38 -0800 (PST)
Received: from robh_at_kernel.org (c-73-14-99-67.hsd1.co.comcast.net. [73.14.99.67])
        by smtp.gmail.com with ESMTPSA id t66-20020a6bc345000000b00704878474c7sm5289961iof.53.2023.02.14.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:12:37 -0800 (PST)
Received: (nullmailer pid 76712 invoked by uid 1000);
        Tue, 14 Feb 2023 16:12:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     alim.akhtar@samsung.com, Sergey.Semin@baikalelectronics.ru,
        pankaj.dubey@samsung.com, jh80.chung@samsung.co,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org, tglx@linutronix.de,
        linux-samsung-soc@vger.kernel.org, kw@linux.com,
        jingoohan1@gmail.com
In-Reply-To: <20230214121333.1837-6-shradha.t@samsung.com>
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499@epcas5p3.samsung.com>
 <20230214121333.1837-6-shradha.t@samsung.com>
Message-Id: <167638944926.3699.15638999253407034271.robh@kernel.org>
Subject: Re: [PATCH 05/16] dt-bindings: PCI: Rename the term elbi to appl
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


On Tue, 14 Feb 2023 17:43:22 +0530, Shradha Todi wrote:
> DT uses the name elbi in reg-names for application logic
> registers which is a wrong nomenclature. This patch fixes
> the same.
> 
> This commit shouldn't be applied without changes
> "arm64: dts: Rename the term elbi to appl" and
> "PCI: samsung: Rename the term elbi to appl"
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  Documentation/devicetree/bindings/pci/samsung,pcie.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/samsung,pcie.example.dtb: pcie@15700000: reg-names:1: 'appl' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/samsung,pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230214121333.1837-6-shradha.t@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

