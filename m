Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B56FACCA
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjEHL2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjEHL1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 07:27:46 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C50E48;
        Mon,  8 May 2023 04:27:35 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ab074ef787so263799a34.0;
        Mon, 08 May 2023 04:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545254; x=1686137254;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMxrGhF5fj/3JoYFKkI+lC/oQhJpPCoS64Ws4CRWfrA=;
        b=bO1qCNhFEVb07Iir9R+DzwOqXz25xPGCPtHrPpq3u/lxJmZ6CFNxNs1bxRIFLhIL43
         8E7C+NcdRvGtIdGM4p7/K7NuYPiE7O3wOxHMCp/o7SpqJUfIbxO4943i4Ht94l9snmOJ
         spIoH3graEZibcrYj4IEazp1eoTjmLZai3Bqd8mLfgRVlDJLtTKs2fzqXU4VWIWZCnNm
         zwiMwu22Pcn57W7YXeweazZuuWFE006fF1+8TWKHr2G9KorAFWaQocl7GxSKQtwfFtRh
         S/nDN880HBkny2hzym06iIN2HUN5pLeHRdj7M6/i7vQQdilYOa1WIage2njrbUXVoOTe
         xgaA==
X-Gm-Message-State: AC+VfDxOIrNaBK/d2Opru3u40TIc1ZUVCIiUc/Ivj8kV7YomSu2H0p6R
        xp0udiRV9wWxVDXfbQ5NHQ==
X-Google-Smtp-Source: ACHHUZ48fwZKDNWYvkwazCmeTz96sb7FQBsEdEaLloaLh7S/di9IH9Rfj7VagInKNk1wRti83UH6zA==
X-Received: by 2002:a05:6808:3d4:b0:389:4f86:205e with SMTP id o20-20020a05680803d400b003894f86205emr4417581oie.9.1683545254054;
        Mon, 08 May 2023 04:27:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u3-20020a056808000300b00383ef58c15bsm5425446oic.28.2023.05.08.04.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:27:32 -0700 (PDT)
Received: (nullmailer pid 789286 invoked by uid 1000);
        Mon, 08 May 2023 11:27:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20230508104557.47889-2-wsa+renesas@sang-engineering.com>
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
 <20230508104557.47889-2-wsa+renesas@sang-engineering.com>
Message-Id: <168354524790.789228.15379102393089960407.robh@kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: PCI: rcar-pci-host: add optional
 regulators
Date:   Mon, 08 May 2023 06:27:28 -0500
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


On Mon, 08 May 2023 12:45:55 +0200, Wolfram Sang wrote:
> Support regulators found on the e.g. KingFisher board.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508104557.47889-2-wsa+renesas@sang-engineering.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

