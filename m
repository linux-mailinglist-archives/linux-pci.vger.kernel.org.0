Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600E6E498A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQNMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjDQNLm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 09:11:42 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3BA7EE6;
        Mon, 17 Apr 2023 06:11:06 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1880110ebe5so500232fac.3;
        Mon, 17 Apr 2023 06:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737032; x=1684329032;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IXZt0KqImFgsyhhPxPLi1OSBe3TPO8lPA8li15emVQ8=;
        b=eNmVN/i1QwqyB475WNYuIM60wcQSoX++knu5ea25r1tSb0PbiZhk95iEtxyqpfKLRO
         uaG9JMtl70Y6JFjnYs95KSO2MUWDG7d0+x+8RQxUpQTych0Ei95nP7Eg7uJVDD5aJrgT
         tjR8elV4dfqtHbtrGws3SkK5KJGDuccDvo94P90BghSFlA3K8vMcculAcC+I4k14+kma
         PxMBEOA+pyIy+5pGDtxvvwAmsjqa4Ngrc64Hrm+nPTITFBHZnbtrNSbAxLB1q4yS/Xfu
         awBNxpOFJ+yzGN62U5CkFGE/rUfBKAf7QSXi12LxEcuEDkX0iNunNCMJMlfmkPrM4Baa
         EPlw==
X-Gm-Message-State: AAQBX9eaT/zl1BPwadiyvcQgRqNaAWsZS3PxhA9+GOku4JwRNJLCOc22
        Amw8+Mgg31EcY3/1IqWaAQ==
X-Google-Smtp-Source: AKy350ayJO+eG9U/cqv47KAeV20FExrvvzSFt2UABLULJZ9LP4qdLHS8V2D+sSymTWdAERUmkEL1bg==
X-Received: by 2002:a05:6870:519:b0:177:8200:d7b with SMTP id j25-20020a056870051900b0017782000d7bmr8842016oao.29.1681737032605;
        Mon, 17 Apr 2023 06:10:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id du3-20020a0568703a0300b001723a2e84b6sm4540975oab.6.2023.04.17.06.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:10:31 -0700 (PDT)
Received: (nullmailer pid 2588783 invoked by uid 1000);
        Mon, 17 Apr 2023 13:10:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bharat.kumar.gogada@amd.com,
        robh+dt@kernel.org, michals@xilinx.com, devicetree@vger.kernel.org,
        nagaradhesh.yeleswarapu@amd.com
In-Reply-To: <20230417103226.334588-2-thippeswamy.havalige@amd.com>
References: <20230417103226.334588-1-thippeswamy.havalige@amd.com>
 <20230417103226.334588-2-thippeswamy.havalige@amd.com>
Message-Id: <168173527725.2535601.7665980002341378947.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Date:   Mon, 17 Apr 2023 08:10:27 -0500
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


On Mon, 17 Apr 2023 16:02:25 +0530, Thippeswamy Havalige wrote:
> Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
>  .../bindings/pci/xlnx,xdma-host.yaml          | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: /example-0/soc/pcie@a0000000: failed to match any schema with compatible: ['xlnx,xdma-host-3.00']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230417103226.334588-2-thippeswamy.havalige@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

