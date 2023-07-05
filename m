Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57A274809F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjGEJQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjGEJQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 05:16:34 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90995171D;
        Wed,  5 Jul 2023 02:16:33 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-785d738d3feso10487639f.0;
        Wed, 05 Jul 2023 02:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548593; x=1691140593;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lq04kjYiYY2D3X+Ef3fDnIElUg0AyuRuSsj7VlSyuoQ=;
        b=CfrZnxanMyi4FhJAHWksnO2sTz0pwiVA10UDlk8h19omW0NQXQzDeentcWgNJYZc0w
         S9X6s1cT0m9mUwxnDY+GcU4tOq6i6HeTYGIH8nODj6W/IlzyicBH118g8gm1ssk4HsLT
         06NDFeSUurndOgXik83WwuRxRbtOqqW0a/q201FY4jrhhJgpDgrwnb2qgrc1586c/Zj3
         9myqB1uLje7pF/QesfXQDRFIgdq6C65pqYeyIRdw4cSfQ6fgMj8HYRX9vIZQPyKsbikl
         IMZdPB5RBMiojrSbQy7J2Xw6cB9CMXtuqRqQ0dvKljRxXl4osPrSVJUAR4VE1O+Gg6YL
         kGOQ==
X-Gm-Message-State: ABy/qLadAYkjMa+30GqzD83ASDPKo3IZl8s6huKNigia6qLa0B6ZTYcc
        aWINBHCq4WxrEKya8FDl4A==
X-Google-Smtp-Source: APBJJlGE/605ujaMNU/z7n4PfFpdNXqgpH5xUQ/WO6pZbEYqJ7Qqw5V8pnQPxHsByRVJ6CADRgbktA==
X-Received: by 2002:a6b:f314:0:b0:783:727a:8e15 with SMTP id m20-20020a6bf314000000b00783727a8e15mr1322122ioh.6.1688548592781;
        Wed, 05 Jul 2023 02:16:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b20-20020a056602001400b007791e286fdbsm3863821ioa.21.2023.07.05.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:16:32 -0700 (PDT)
Received: (nullmailer pid 4038328 invoked by uid 1000);
        Wed, 05 Jul 2023 09:16:27 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     conor+dt@kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, andersson@kernel.org,
        quic_shazhuss@quicinc.com, linux-arm-msm@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        agross@kernel.org, linux-phy@lists.infradead.org, mani@kernel.org,
        konrad.dybcio@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
        krzysztof.kozlowski+dt@linaro.org, quic_nitegupt@quicinc.com,
        devicetree@vger.kernel.org
In-Reply-To: <1688545032-17748-3-git-send-email-quic_msarkar@quicinc.com>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-3-git-send-email-quic_msarkar@quicinc.com>
Message-Id: <168854858712.4038293.10826309392324391984.robh@kernel.org>
Subject: Re: [PATCH v1 2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP
 PCIe PHY
Date:   Wed, 05 Jul 2023 03:16:27 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 05 Jul 2023 13:47:07 +0530, Mrinmay Sarkar wrote:
> Add devicetree YAML binding for Qualcomm QMP PCIe PHY
> for SA8775p platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.example.dtb: phy@1c18000: clock-names:4: 'phy_aux' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.example.dtb: phy@1c18000: clock-names:5: 'pipe' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.example.dtb: phy@1c24000: clock-names:4: 'phy_aux' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.example.dtb: phy@1c24000: clock-names:5: 'pipe' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1688545032-17748-3-git-send-email-quic_msarkar@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

