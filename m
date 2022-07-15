Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03BC576A66
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 01:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiGOXGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 19:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGOXGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 19:06:33 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461238B497;
        Fri, 15 Jul 2022 16:06:32 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id v185so4977553ioe.11;
        Fri, 15 Jul 2022 16:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WS+m6FCV1ih7kQYyoEE+Xpgv4hF6eBI9SGC0nwJm3wI=;
        b=4QlHkrE2SWydcunm0CcgFwjypBz1SVw4Fm6XLbhNoYl5tnpDmYX9zyrP1BstyZT3Gi
         RA2nu8KDpeLUdIVTMMJBCYCLpJk2S+pJAQFmwID/ee1eoeWZmn8n0BTMCCNeGi9GnXmJ
         aD2yAk6RHZrWrMdZgkgZX8mC6qp/pOLnACDXn5igvYHbT5THh3KssnmWK1i3i7PiezzN
         Cgl5D+ejkjtncR99U/XcTGWkRy7RY03WOBlWNfbvPqBIFEOTSg/UD+MzHb40KGsCa/6i
         eYBu01kvM1zhvJA2k0KHBx5BjSWVrPhCrRRiUPhDp1zhwVzsY6j6yE+xbJQ5BcaEGHf/
         Yb1w==
X-Gm-Message-State: AJIora8BUEsBkOXr8LzdPmhI68lkQtKGw4vazbogXYD4kRYtmeFb7YcT
        Uxpxaso18LlyM/mM1MnYvw==
X-Google-Smtp-Source: AGRyM1vJzwIneWYq4VBZo4Q8Al9UejZ/c08fHYNczA4GDDXLOiIf81FvnXssYQRPzsCwTbZnDVFD6w==
X-Received: by 2002:a05:6602:1346:b0:669:35d4:1a81 with SMTP id i6-20020a056602134600b0066935d41a81mr8128000iov.112.1657926391461;
        Fri, 15 Jul 2022 16:06:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b13-20020a92ce0d000000b002dc6fd9a84bsm2149256ilo.79.2022.07.15.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:06:31 -0700 (PDT)
Received: (nullmailer pid 1631476 invoked by uid 1000);
        Fri, 15 Jul 2022 23:06:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        peng.fan@nxp.com, ntb@lists.linux.dev, kernel@vger.kernel.org,
        s.hauer@pengutronix.de, aisheng.dong@nxp.com, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        maz@kernel.org, festevam@gmail.com, shawnguo@kernel.org,
        tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        jdmason@kudzu.us, linux-imx@nxp.com, kernel@pengutronix.de
In-Reply-To: <20220715192219.1489403-4-Frank.Li@nxp.com>
References: <20220715192219.1489403-1-Frank.Li@nxp.com> <20220715192219.1489403-4-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Fri, 15 Jul 2022 17:06:28 -0600
Message-Id: <1657926388.230921.1631475.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Jul 2022 14:22:18 -0500, Frank Li wrote:
> imx mu support generate irq by write a register.
> provide msi controller support so other driver
> can use it by standard msi interface.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: interrupt-controller@5d270000: '#interrupt-cells' is a dependency of 'interrupt-controller'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: interrupt-controller@5d270000: '#interrupt-cells' is a dependency of 'interrupt-controller'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/interrupt-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

