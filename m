Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030BE614A02
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 12:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKALz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 07:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKALz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 07:55:56 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18F180;
        Tue,  1 Nov 2022 04:55:55 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso16472291fac.13;
        Tue, 01 Nov 2022 04:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1gVTUqCuPMUev0ujZeNXu/CWSNZgTr+132JZ6/ognRo=;
        b=nKkX/cfKzDXN72XIOR2OYD2e+Q18MTCaP77lXs/mDeFRqP0FszBFWJtexoqj5tbzbr
         7+MohlBt0K8SGyXT9g3Jj9n1UrD0ySiulwvJ5tyFIqdcYdfi6RjT9I4//tml4rBaeuhy
         GuplAb7Nw3CqufC7gBb14XcbXz7pMjeRE1A9Wts4QeVZ6wS8aS8XgtHzOJ3SZT88B/Ck
         oZeoHUwunTGKmyLUrnIUv09qq5BFRNIu5OsrY3j7gLkGw4me7IhiQL6s39u5nUAn9ztA
         zYA+SoKFmPGx/7FTlhHITWSF7ozkAt0E0UcQfkaVCETZbWdwhy202scTrXf2Mcx1bs8y
         2Rog==
X-Gm-Message-State: ACrzQf0peqo2rbDWRHGR3TzjkDw+Fqdv9owXQ2ivmI/C0SsBVauly+77
        ehxdcSntb0PHyJr/EKs26ZbZ5AJTYQ==
X-Google-Smtp-Source: AMsMyM6qMT8qCkO6ZNEjSImtbudJZC9vqH6tDKsweV0FpVQVuDjfk3wQo6SRNNJQcpJKsMUfQzqVfg==
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e4be with SMTP id t14-20020a056871054e00b0013b29b7e4bemr10919340oal.176.1667303755012;
        Tue, 01 Nov 2022 04:55:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p15-20020a0568708a0f00b001226d2100f2sm4346552oaq.33.2022.11.01.04.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:55:54 -0700 (PDT)
Received: (nullmailer pid 909535 invoked by uid 1000);
        Tue, 01 Nov 2022 11:55:54 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     robh+dt@kernel.org, bhelgaas@google.com, michals@xilinx.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        nagaradhesh.yeleswarapu@amd.com, linux-pci@vger.kernel.org,
        bharat.kumar.gogada@amd.com, devicetree@vger.kernel.org
In-Reply-To: <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
References: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
 <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
Message-Id: <166730310310.897892.15492131590720845659.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Tue, 01 Nov 2022 06:55:54 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 01 Nov 2022 10:50:49 +0530, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ----------
>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 137 ++++++++++++++++++
>  2 files changed, 137 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pcie@fd0e0000: Unevaluated properties are not allowed ('iommus', 'power-domains' were unexpected)
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

