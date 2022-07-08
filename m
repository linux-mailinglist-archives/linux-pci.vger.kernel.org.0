Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0969156C342
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbiGHVcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiGHVcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 17:32:06 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07D9FE30;
        Fri,  8 Jul 2022 14:32:05 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id b12so904946ilh.4;
        Fri, 08 Jul 2022 14:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=mPK7JqtCJf89laULVPANQB+hprBgnI5b+pSKYiY3/w8=;
        b=8ACxCXkywtP4blRLHr4+X1xls1PN631DIDPOcXsZM7tYI5oOqdxPet2yfggkjdU6oe
         R5RSQW2OdJdvDiOPcv932cyOgnslnbeqookhLU4rYKe8uJduQruwtLwnQVXG7ZSGom7m
         tPExlk6FOgIJqkogoXcMbFq0GPfwFRQcWTVnI2PgneJ7OqX7uo40lkEixBuuIDWQpKhT
         GAOyER2jJ4LQHg8LQYZlNByD+AnpSBVTvKAjLuUh51e5Lr2PWHJ7pbSfYsAmCPRqa2i/
         vp4nCGt+jDefhXHx2Ouub2VTKAgF4gO/EX16DE6Bvvw/G0IfW1GdEysM5aCZQXUhubvU
         bGmQ==
X-Gm-Message-State: AJIora+XBKirke44SSl9F7O/tChhH77kZ6gyW09QvrsNNzK43ZXoxr2/
        N6rp4sAty6NAZVTM5PkEdQ==
X-Google-Smtp-Source: AGRyM1tCjV1LWB4OVa94Ub7ppM+PyrcTgBMr3Gdo0En5H45DKfvVy4UHV6k2oZR63GxcoKo/GZSd4A==
X-Received: by 2002:a92:c811:0:b0:2dc:14bf:e15d with SMTP id v17-20020a92c811000000b002dc14bfe15dmr3121986iln.305.1657315924369;
        Fri, 08 Jul 2022 14:32:04 -0700 (PDT)
Received: from robh.at.kernel.org ([98.38.210.73])
        by smtp.gmail.com with ESMTPSA id a11-20020a02734b000000b0033ebd47834fsm1530397jae.128.2022.07.08.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:32:03 -0700 (PDT)
Received: (nullmailer pid 1508198 invoked by uid 1000);
        Fri, 08 Jul 2022 21:32:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     shawnguo@kernel.org, aisheng.dong@nxp.com, kw@linux.com,
        tglx@linutronix.de, peng.fan@nxp.com, linux-kernel@vger.kernel.org,
        kishon@ti.com, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, jdmason@kudzu.us, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        ntb@lists.linux.dev, maz@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org
In-Reply-To: <20220707210238.917477-2-Frank.Li@nxp.com>
References: <20220707210238.917477-1-Frank.Li@nxp.com> <20220707210238.917477-2-Frank.Li@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: irqchip: imx mu work as msi controller
Date:   Fri, 08 Jul 2022 15:32:02 -0600
Message-Id: <1657315922.435976.1508197.nullmailer@robh.at.kernel.org>
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

On Thu, 07 Jul 2022 16:02:37 -0500, Frank Li wrote:
> imx mu support generate irq by write a register.
> provide msi controller support so other driver
> can use it by standard msi interface.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dts:31.41-42 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

