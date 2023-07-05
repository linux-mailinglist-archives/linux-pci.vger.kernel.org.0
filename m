Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A774809C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGEJQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 05:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjGEJQb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 05:16:31 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8BDD;
        Wed,  5 Jul 2023 02:16:30 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78666f06691so138839739f.0;
        Wed, 05 Jul 2023 02:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548590; x=1691140590;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zrxkvponYz4V5NTYWmXXqT0XM8M8zhkcRZKfUVdIvfo=;
        b=IClVVPsIgs/ysIKiBXnn4zwciWKPCAUaWpJeofySICfheeSgtZ2bqcdH9v3cPn+kDN
         Pkoxp3TIgk7Ad/HQNHgEue6zvIAvaJ0DLOcd2CzY/fas7Zwzhl1aPE7SUqYHbFkiUXhe
         jY7s9tsQEfywYhh2hT5z134Ws1VR5u9rFdSTzvfol1YeVXqfVhEDB91caBHN0KbT1I+l
         PkjJvErlzyi4LdhfjmOQQc4CzbvK/95GA3vERHl7sVCccl9lRvay0C+WJK0uFcCCMx9r
         7gyOBv7idhBnwSVeYeEYGCiDdEOQc+lJolALBIz6bOJPaFp7NbWandFDjtXFeO2bwB5t
         wfvQ==
X-Gm-Message-State: AC+VfDzsU48vNnjb4dz/wMAgqPzM3Wv4kzU+NR2uhNjYkDMDDe88ERpQ
        8ECarSSjkfodwY6seKKPGg==
X-Google-Smtp-Source: ACHHUZ7uV5drZripZphbrl8LDJeBSaflagI8Iu3OZ5ufCPyk2D1KK9nohHZs6UkU+btahidNzSfF3g==
X-Received: by 2002:a5e:a911:0:b0:77e:3d2f:d1f4 with SMTP id c17-20020a5ea911000000b0077e3d2fd1f4mr15269163iod.15.1688548589990;
        Wed, 05 Jul 2023 02:16:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e20-20020a02a514000000b0042b48e5da4bsm1717283jam.134.2023.07.05.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:16:29 -0700 (PDT)
Received: (nullmailer pid 4038325 invoked by uid 1000);
        Wed, 05 Jul 2023 09:16:27 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        agross@kernel.org, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        quic_nayiluri@quicinc.com, quic_shazhuss@quicinc.com,
        linux-phy@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
        quic_ramkri@quicinc.com, linux-arm-msm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_nitegupt@quicinc.com, conor+dt@kernel.org, mani@kernel.org
In-Reply-To: <1688545032-17748-2-git-send-email-quic_msarkar@quicinc.com>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-2-git-send-email-quic_msarkar@quicinc.com>
Message-Id: <168854858595.4038242.5895489616920935149.robh@kernel.org>
Subject: Re: [PATCH v1 1/6] dt-bindings: PCI: qcom: Add sa8775p compatible
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


On Wed, 05 Jul 2023 13:47:06 +0530, Mrinmay Sarkar wrote:
> Add sa8775p platform to the binding.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/qcom,pcie.yaml:753:17: [warning] wrong indentation: expected 14 but found 16 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1688545032-17748-2-git-send-email-quic_msarkar@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

