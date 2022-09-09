Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9535B2BCB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 03:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIIBny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 21:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIIBny (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 21:43:54 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6951A1D70;
        Thu,  8 Sep 2022 18:43:48 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id l7-20020a056830154700b0065563d564dfso190665otp.0;
        Thu, 08 Sep 2022 18:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kgAGirvJfdV3oB1r2QFilMXE0qgu9JtE1NsMjf6XFLY=;
        b=HlXNPYy77skSLLlW3UTRziORBMcE2Ve018T9cGWi5pa44jemfQrZso5MWWC3jtUpBM
         HoW/DDVM1B1PbOJozSlqS6BWG+VNSYlVeioh39Vh4CvK7tB9YDzZb9nlTGkgJIa3GM8H
         0+Unop6fNs3N2C5hthowFIt5aMXxt/MIWvKvtZMhERVUgc03bZIZgYE9VWkHOkggsbo2
         ASw9BRY6d3Pkapru/whyvkTTkw/ykq0UeICcWcN/9kty7CThOsPYE2pNPorQoGV5C/Lp
         vNb9vtMwsIcUumJiykTfdwMh18M1Hbqh7Z8c0ZcsPIDxZ4FtI7FYw8qaDVH7F/uLMUSY
         JI2g==
X-Gm-Message-State: ACgBeo3rbnTNrKp3ecvIbiPCFk8oZAHoX8unSswXRNzZFmhwpNhD8Zw4
        jglZ5iEaYP5W/SaMGicbvA==
X-Google-Smtp-Source: AA6agR5i2t4iZ8enK9UJxaM3KxuW+PQOhJgW4tqlPDGLyRN8vJfn+FxaRNRJx75tuZ0LmnK4pAh3Gw==
X-Received: by 2002:a05:6830:1bfa:b0:637:1491:2ac7 with SMTP id k26-20020a0568301bfa00b0063714912ac7mr4569354otb.9.1662687828152;
        Thu, 08 Sep 2022 18:43:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e7-20020a056870c34700b0012696ac05d5sm483842oak.19.2022.09.08.18.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 18:43:47 -0700 (PDT)
Received: (nullmailer pid 3745755 invoked by uid 1000);
        Fri, 09 Sep 2022 01:43:46 -0000
Date:   Thu, 8 Sep 2022 20:43:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        maz@kernel.org, ntb@lists.linux.dev, robh+dt@kernel.org,
        kishon@ti.com, imx@lists.linux.dev, bhelgaas@google.com,
        festevam@gmail.com, peng.fan@nxp.com, jdmason@kudzu.us,
        manivannan.sadhasivam@linaro.org, kw@linux.com,
        aisheng.dong@nxp.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lznuaa@gmail.com
Subject: Re: [PATCH v9 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Message-ID: <20220909014346.GA3745691-robh@kernel.org>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
 <20220907034856.3101570-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907034856.3101570-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 06 Sep 2022 22:48:55 -0500, Frank Li wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
