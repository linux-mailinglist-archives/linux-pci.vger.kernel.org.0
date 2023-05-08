Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD46FA236
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjEHI1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjEHI1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 04:27:23 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530341A125;
        Mon,  8 May 2023 01:27:07 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5475e0147c9so1143360eaf.1;
        Mon, 08 May 2023 01:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683534426; x=1686126426;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WHUlZpeMyjqd2JYUgY2eHNWG1bqzG/LjLu6e2GSUtNk=;
        b=OlC8rCuChWAeg/QY8MZOKhpKQH9b4JPgs98Xml7j2rxY/qmUkQcyZhiOZwu1XbBWNL
         a2wcbpbpRqL1/1/6j4kxKSits12dkeXk+vh6XywP1lOPVbcuxVkV6LCYYhab3089IPqt
         aHT9GIaBgTm6fEWx8Q3gsvJQpFbuI3AL/o/05rlvlOAeWJWA7fQDqy1AYnuV0AXI90dR
         FdSo7fODhmb+X9n3tmQw1eQCytz8Ftm5qep6j4iia56LLQvH2E4RMl/tEMW9tF/6Brjd
         M1cKHwxFN+68fFT+1fR1th87wMbyWyCnv6LbNZWvWWLt8qzoUfJuuQNSQo9INHWS5Cmd
         CdOA==
X-Gm-Message-State: AC+VfDwB3VM9Fl+POANiGOLg4MOpu/dY2xpVSgXkPY3B+gED1fjVLyUv
        N90y5GVECMDSbN02nhC1YQ==
X-Google-Smtp-Source: ACHHUZ64TdmlneC7I2hyuGS9hkgReKtzuOarI8Il6BCrERKnGSiV8pCbE8zCqMVSck1GuBov3oW27w==
X-Received: by 2002:a4a:9c4e:0:b0:541:f9a3:3455 with SMTP id c14-20020a4a9c4e000000b00541f9a33455mr3750503ook.4.1683534426014;
        Mon, 08 May 2023 01:27:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v26-20020a4ae6da000000b0054c84710025sm3821446oot.8.2023.05.08.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:27:05 -0700 (PDT)
Received: (nullmailer pid 462508 invoked by uid 1000);
        Mon, 08 May 2023 08:27:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org
In-Reply-To: <20230508071837.68552-1-krzysztof.kozlowski@linaro.org>
References: <20230508071837.68552-1-krzysztof.kozlowski@linaro.org>
Message-Id: <168353442421.462471.2290093137731039069.robh@kernel.org>
Subject: Re: [PATCH fixes] dt-bindings: PCI: fsl,imx6q: fix assigned-clocks
 warning
Date:   Mon, 08 May 2023 03:27:04 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 08 May 2023 09:18:37 +0200, Krzysztof Kozlowski wrote:
> assigned-clocks are a dependency of clocks, however the dtschema has
> limitation and expects clocks to be present in the binding using
> assigned-clocks, not in other referenced bindings.  The clocks were
> defined in common fsl,imx6q-pcie-common.yaml, which is referenced by fsl,imx6q-pcie-ep.yaml.  The fsl,imx6q-pcie-ep.yaml used assigned-clocks thus leading to warnings:
> 
>   Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000:
>     Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>   From schema: Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 
> Fix this by moving clocks to each specific schema from the common one
> and narrowing them to strictly match what is expected for given device.
> 
> Fixes: b10f82380eeb ("dt-bindings: imx6q-pcie: Restruct i.MX PCIe schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Patch for current cycle (v6.4-rc).   Please take directly as fixes or
> let me know, so I will send it to Linus.
> ---
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   | 13 +---
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 38 +++++++++
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 77 +++++++++++++++++++
>  3 files changed, 117 insertions(+), 11 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508071837.68552-1-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

