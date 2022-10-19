Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C496053F5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 01:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJSXcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 19:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJSXb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 19:31:57 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BCB171CF8;
        Wed, 19 Oct 2022 16:31:54 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id x188so21065866oig.5;
        Wed, 19 Oct 2022 16:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5cGz5B9dPL46ZTbOBdW+TTlGdujxRf62tpWJdo/bwM=;
        b=vZAUr/mcKwU3CB6M0WGpUg5CDf2k3uAcTS1T508kwSNMB8s+jZot8RXsyiPKzhLZBT
         qGzUvzztTaFwRrLwT3vHpOYiMK7FLtm6mnBGpvMlcL1BDQ2wfBf60Nilr5w9+IenZIVP
         PGFRZfzbV2AiiEfNoCgtwmeGqH9Z1JMbQ5YxMXrLELD65u8xUFeDGxnbHzxdpOnQGBsQ
         SeJmjucKzqEiqlTCIg1rIJ+hCghlcvUlVnSVNYIJiDNgLpjgwHgUKEvNzzkYQyvMBZKS
         fLh3+00pxP0QkvjX5jrPibkaUmsEUDUf9PcBU3Quo2hrKkYuybdg3mPX7NiD/fd3GJ8N
         iwBg==
X-Gm-Message-State: ACrzQf0m3IDly+Np8wog3mwA2a+h8jWJ3I+HOYr4drIP1SsnabM27JXJ
        zh/zPwtt2Fhj/OpStLF06A==
X-Google-Smtp-Source: AMsMyM5ZVSZDdegdGAkToDobbXtMAhqVv57lgef/mAQiKfsNW1YOi3NJDccz/RIi8hCNsqTAHAnWbQ==
X-Received: by 2002:a05:6808:1507:b0:355:3ec:3109 with SMTP id u7-20020a056808150700b0035503ec3109mr6076098oiw.263.1666222313861;
        Wed, 19 Oct 2022 16:31:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y22-20020a056870459600b0011d02a3fa63sm8264285oao.14.2022.10.19.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:31:53 -0700 (PDT)
Received: (nullmailer pid 19944 invoked by uid 1000);
        Wed, 19 Oct 2022 23:31:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bharat.kumar.gogada@amd.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, michals@xilinx.com
In-Reply-To: <20221019144640.9458-2-thippeswamy.havalige@amd.com>
References: <20221019144640.9458-1-thippeswamy.havalige@amd.com> <20221019144640.9458-2-thippeswamy.havalige@amd.com>
Message-Id: <166622207386.14208.14849032885001110673.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge
Date:   Wed, 19 Oct 2022 18:31:53 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 19 Oct 2022 20:16:40 +0530, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 -----------
>  .../bindings/pci/xilinx-nwl-pcie.yaml         | 122 ++++++++++++++++++
>  2 files changed, 122 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pcie@fd0e0000: Unevaluated properties are not allowed ('clocks', 'iommus', 'power-domains' were unexpected)
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

