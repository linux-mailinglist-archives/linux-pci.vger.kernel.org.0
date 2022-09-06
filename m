Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0875AF721
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIFVlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiIFVlQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:41:16 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9313883F9;
        Tue,  6 Sep 2022 14:41:07 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127dca21a7dso4198271fac.12;
        Tue, 06 Sep 2022 14:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EW+cR7KJ28XYEq6YcUljunwqIl+1KGyFFiNfE5ICVAA=;
        b=VP2NU5Rc8hiRaszoXjbjfY/Nu7CSFwstXGuouLQT9udJ412B8EvhVVWKKJYcDQ+gR0
         qtBZWzQl80S/4kOHiKqerdYjKGCsKDkMdE/VuO0dNjI6UK62XLMHmTyRzHSbsL6OD9QF
         ibCIaOaAbHW0WAeMsFE8ORUAW9NSB1UfboAfi9fWbYHz992b2gQSrJ+fxisG0u2qD1wF
         iPmsSKVZ/DACTYVntpRYdroyPjTwbjXcbVg8nD/B8phojy/zkFIvhy46tL8PaweCL/+J
         FIZqGTTxqNhbk/dygMD5n+5mKO6w+3psBTdBbPm2oQYmkmVnzzzaR/MXJOCxHPXe10eH
         jDTg==
X-Gm-Message-State: ACgBeo1lEkotvgUE2DYyX8c/1d07vNnTXOJqqOIW1+XONxrgJjqdaI2B
        Gfzyq0Cu17+c5wriEPuqUg==
X-Google-Smtp-Source: AA6agR6f9fGCXs1O4gA9YicEAr3WSKrESrdckaoq8Rl9HDETjjj10oBq0P1Nl9KEbeC0SbXW6hLrmg==
X-Received: by 2002:a05:6808:158a:b0:343:7564:91f1 with SMTP id t10-20020a056808158a00b00343756491f1mr10822132oiw.23.1662500466925;
        Tue, 06 Sep 2022 14:41:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm7648953oab.3.2022.09.06.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:41:05 -0700 (PDT)
Received: (nullmailer pid 1224959 invoked by uid 1000);
        Tue, 06 Sep 2022 21:41:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, tglx@linutronix.de, festevam@gmail.com,
        ntb@lists.linux.dev, shawnguo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, maz@kernel.org, kishon@ti.com,
        peng.fan@nxp.com, imx@lists.linux.dev, lorenzo.pieralisi@arm.com,
        kw@linux.com, lznuaa@gmail.com, jdmason@kudzu.us,
        linux-imx@nxp.com, linux-pci@vger.kernel.org,
        s.hauer@pengutronix.de, bhelgaas@google.com, aisheng.dong@nxp.com
In-Reply-To: <20220906194052.3079599-4-Frank.Li@nxp.com>
References: <20220906194052.3079599-1-Frank.Li@nxp.com> <20220906194052.3079599-4-Frank.Li@nxp.com>
Subject: Re: [PATCH v8 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Tue, 06 Sep 2022 16:41:00 -0500
Message-Id: <1662500460.117998.1224958.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 06 Sep 2022 14:40:51 -0500, Frank Li wrote:
> I.MX mu support generate irq by write a register. Provide msi controller
> support so other driver such as PCI EP can use it by standard msi
> interface as doorbell.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: reg-names:0: 'processor-a-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: reg-names:1: 'processor-b-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: power-domain-names:0: 'processor-a-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: power-domain-names:1: 'processor-b-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

