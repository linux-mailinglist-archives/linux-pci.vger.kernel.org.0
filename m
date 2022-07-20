Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4233957B84B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiGTORd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 10:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiGTORc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 10:17:32 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310F446D87;
        Wed, 20 Jul 2022 07:17:31 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id z132so14391840iof.0;
        Wed, 20 Jul 2022 07:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=fTbHuzNk788olqUHrliPvBvFbjERGU5VKnP1jkIeETE=;
        b=pcV19WK5XXw0Oxrug4Gx3rTwcrSpXQ8F78BQtLuY6bRgisqKuFLjDT+k81Yh0l8O3a
         4toh3k969ltQbdKg0YzHwD5FcG82bW5QdvsNeItQayHS6CLyS6qBAZTZOdAZNT7vwekR
         aTjpBqV0e+fKZ8rBGuySawPFtVjmgUZ0N560SsCbR18yD34Antaxt34A0HMjYCZwhqKq
         sHVdwtpkB6vZMoUvoatgM1HewLvFpxPAxxtNxC722fftH66S/NDCe02lezjrQgBNMuAM
         gMY21YhrjxPKnZZ4zoJjuf/+m6wIjukqJiH/xOnGrfnVTzHSepMASlSvSS+2CirWjLSW
         q9DA==
X-Gm-Message-State: AJIora/A56nEaUL3ALm9Jywa0QpRSrgwyzWiquUJwYvIMA/P9lLAL5j0
        nZOhfZ1EyEAAhobFb+Ovqw==
X-Google-Smtp-Source: AGRyM1v1gxgKIvHOMxLR/VgWQI1MqZ7vRACS7FQYPq1C8bqyEIFjCWJ6rX5JLcQbBrttPj2w905law==
X-Received: by 2002:a02:cea6:0:b0:33f:774f:5267 with SMTP id z6-20020a02cea6000000b0033f774f5267mr19939966jaq.274.1658326650262;
        Wed, 20 Jul 2022 07:17:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m15-20020a056e020def00b002dce9ddcb08sm3619740ilj.30.2022.07.20.07.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:17:29 -0700 (PDT)
Received: (nullmailer pid 3267382 invoked by uid 1000);
        Wed, 20 Jul 2022 14:17:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "kw@linux.com" <kw@linux.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dongjin Yang <dj76.yang@samsung.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
In-Reply-To: <20220720055436epcms2p63896ebe4e2131e3844044d0112288570@epcms2p6>
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>        <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p6> <20220720055436epcms2p63896ebe4e2131e3844044d0112288570@epcms2p6>
Subject: Re: [PATCH v4 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Date:   Wed, 20 Jul 2022 08:17:27 -0600
Message-Id: <1658326647.075453.3267381.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Jul 2022 14:54:36 +0900, Wangseok Lee wrote:
> Add description to support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform
> of Axis Communications and PCIe controller is designed based on Design-Ware
> PCIe controller.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
> v3->v4 :
> -Add missing properties
> 
> v2->v3 :
> -Modify version history to fit the linux commit rule
> -Remove 'Device Tree Bindings' on title
> -Remove clock-names entries
> -Change node name to soc from artpec8 on excamples
> 
> v1->v2 :
> -'make dt_binding_check' result improvement
> -Add the missing property list
> -Align the indentation of continued lines/entries
> ---
>  .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 138 +++++++++++++++++++
>  .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 148 +++++++++++++++++++++
>  2 files changed, 286 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.example.dtb: pcie-ep@17200000: Unevaluated properties are not allowed ('#interrupt-cells', 'bus-range', 'interrupt-names', 'samsung,syscon-bus-p-fsys', 'samsung,syscon-bus-s-fsys' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.example.dtb: pcie@17200000: Unevaluated properties are not allowed ('samsung,syscon-bus-p-fsys', 'samsung,syscon-bus-s-fsys' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

