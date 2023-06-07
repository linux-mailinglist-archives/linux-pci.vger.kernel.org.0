Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11A726719
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFGRVe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 13:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjFGRVd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 13:21:33 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A067C1BF1;
        Wed,  7 Jun 2023 10:21:32 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33d269dd56bso4451775ab.1;
        Wed, 07 Jun 2023 10:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158492; x=1688750492;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nkOWQ+vj49HHolrGuM8oO51BRgEeTSl4OC+gwsNtn4M=;
        b=SOlekEQcUFLPUHJp/11oIcuneKsoNPUA8CtvvoUgTPlemTYSqZjJZUU1jL8p335Qaj
         G1zsfMAeI4PZUxi1drXYxQYRnsW1viqxPNnGuae2xcFoEfcOYHDG8udPZ/1vyrWZFGDK
         3L8MgNtVUl9BSELnMTGixweAFmZcBLoivW6CNbn92ZwErWtZLuEdXhX5fp+hChs2XP9R
         7FOHlUzZQMhpR+VnUCUfkLuTvf42RXfBBfeGsSxq8+koiQ/n9Oqcz7B06z0bMxVKNwiA
         2hmtgZXKYqT/jfO1A161UE181JLbe2B335TEafV+zLF++CT6xPvNtF9k+AE8xuDU5sdW
         xnBg==
X-Gm-Message-State: AC+VfDzocffZSMnvRvzOr9QsTWwfHkoqEfVBBbSla/LpozK/BLyzqc8l
        xdm0UTMcmjDa+9918pk7xg==
X-Google-Smtp-Source: ACHHUZ4F6h8LQOVmWn7LEoSNDCTxBGI8+w6CVKJmG5+h3YgYdC+f8K0MbjxTn8bIgxWDBjgfyWXRWg==
X-Received: by 2002:a92:de44:0:b0:338:a648:9c8 with SMTP id e4-20020a92de44000000b00338a64809c8mr4687509ilr.17.1686158491729;
        Wed, 07 Jun 2023 10:21:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b12-20020a92c84c000000b0032ca1426ddesm3793146ilq.55.2023.06.07.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:21:30 -0700 (PDT)
Received: (nullmailer pid 3589539 invoked by uid 1000);
        Wed, 07 Jun 2023 17:21:28 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     quic_vbadigan@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        quic_ramkri@quicinc.com, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        manivannan.sadhasivam@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <1686154687-29356-2-git-send-email-quic_krichai@quicinc.com>
References: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
 <1686154687-29356-2-git-send-email-quic_krichai@quicinc.com>
Message-Id: <168615848698.3589455.9774241463877355430.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: qcom: ep: Add interconnects
 path
Date:   Wed, 07 Jun 2023 11:21:28 -0600
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


On Wed, 07 Jun 2023 21:48:05 +0530, Krishna chaitanya chundru wrote:
> Add the "pcie-mem" interconnect path to the bindings.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb: pcie-ep@1c00000: 'interconnects' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb: pcie-ep@1c00000: 'interconnect-names' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1686154687-29356-2-git-send-email-quic_krichai@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

