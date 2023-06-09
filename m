Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D90729B31
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjFINNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjFINNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 09:13:05 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7E132;
        Fri,  9 Jun 2023 06:13:04 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33be5dbb90cso7462645ab.0;
        Fri, 09 Jun 2023 06:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316384; x=1688908384;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9D35kaOS2C39e0x3xanvuuHggxbq1FnGkrcYzbCLtU=;
        b=WzG6EWqQUviK0Lgqsexec2C/Fo1Hd59OLpbqa/3tXUBVQQwRctzGR3F8wC1B2hdTwd
         0+Vfe/vcpS5fgadaTT4xsvIVIqkQUYNtrstjqvZ6oYLdmhheVU9Ou8Kw+QDJZPf+HcJx
         ynvh9XiY1+k/ZJwvocenrIT6Ii0/5zsGRn6VmjZDd/eD4QIgzcUjzO82MhDqLi7TFg2Y
         EIN6NuPEZ9Uq7DuigfL32acnzrGIyL1ZHHXX85WSqrqQrDi7jIZRcrWCopIkEC6oyIGN
         18IuPTsyauQExZlUeLsJBYkhfkY5/1FO/TPh4J5NEz0qTobizh/rpjQTaaFKjxoeyEei
         j1qw==
X-Gm-Message-State: AC+VfDw3gK/ZwoDsmitBujmfSku7g0WZeD6yNZc8OoOJ6OnMDRAjo/BO
        kPnbOK0a2zPZWZNCXQ8t+A==
X-Google-Smtp-Source: ACHHUZ5j0wP0elCI9OCxxC/oYXvqyZN73d9plY1jTIgztDBrNxHCN2RK5U+QxwWY+4Ul4XsgZoOnag==
X-Received: by 2002:a92:ddcf:0:b0:335:38b:e734 with SMTP id d15-20020a92ddcf000000b00335038be734mr1479493ilr.28.1686316383875;
        Fri, 09 Jun 2023 06:13:03 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z6-20020a92d186000000b0033d2eba1800sm1086619ilz.15.2023.06.09.06.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:13:02 -0700 (PDT)
Received: (nullmailer pid 662840 invoked by uid 1000);
        Fri, 09 Jun 2023 13:13:00 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        manivannan.sadhasivam@linaro.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
 <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
Message-Id: <168631638078.662811.2470035951687478762.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: qcom: ep: Add interconnects
 path
Date:   Fri, 09 Jun 2023 07:13:00 -0600
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


On Fri, 09 Jun 2023 17:17:26 +0530, Krishna chaitanya chundru wrote:
> Some platforms may not boot if a device driver doesn't initialize
> the interconnect path. Mostly it is handled by the bootloader but
> we have starting to see cases where bootloader simply ignores them.
> 
> Add the "pcie-mem" interconnect path as a required property to the
> bindings.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts'
Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: found a tab character where an indentation space is expected
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1686311249-6857-2-git-send-email-quic_krichai@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

