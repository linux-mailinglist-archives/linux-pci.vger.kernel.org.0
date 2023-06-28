Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1252374159F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjF1Ps6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 11:48:58 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:55589 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjF1Psy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 11:48:54 -0400
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso1551039f.3;
        Wed, 28 Jun 2023 08:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967333; x=1690559333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmTdI6aTJpGlvsmEIXpojhkUyCDrvul1ub65kr5OXXY=;
        b=A+OTX2pgbwuJCbp08InsEXoXEUCt63S/xyqk+evViFM5udndrc8DkmN0Ugdx4u1Dk5
         S8NaZpr6/B93CbuxXdb9djuvhAr+5A/I8Z+zqhz04XgSim0sgBeuveXCCpWTq4hA6QlA
         uGKIXKDWE7wVkpfAz4bHICQoMD+1vZ3hn7sH4r6oUu4/8v+0bM/4ycAEQEf8bZVB6Hjv
         ziNGXJ2gDQ6TLOHdB+O1cWhhY/1zcEunpK/OcqxClkCRP9khtWqR9eqkNn5hw6cY5hfK
         nwnnXecV1iPBD4AxTlcR23hPBlJXTzW6TlRsgiLDcpeVDisUgJoJU10qEcEiZqvPutqu
         d/Pw==
X-Gm-Message-State: AC+VfDzmuXW5BXiAtU2IOYbqzFReFB78n4h6pzMMfxl4y5KTeMwyK1lM
        qB/5HQRgwkBi4TBdLcVC0J4wab+dmg==
X-Google-Smtp-Source: ACHHUZ5bCBpza7MWUkgpEbyr3ZW8vu2duiFRPPB99GdRkuoCdmCH5MHC8Ii01MOY3mWgBSE5zRgG9Q==
X-Received: by 2002:a5e:c60c:0:b0:784:314f:8d5b with SMTP id f12-20020a5ec60c000000b00784314f8d5bmr5261858iok.11.1687967333395;
        Wed, 28 Jun 2023 08:48:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z6-20020a5e9246000000b0076ffebfc9fasm1103011iop.47.2023.06.28.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:48:52 -0700 (PDT)
Received: (nullmailer pid 535027 invoked by uid 1000);
        Wed, 28 Jun 2023 15:48:51 -0000
Date:   Wed, 28 Jun 2023 09:48:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bharat.kumar.gogada@amd.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, michals@amd.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Message-ID: <20230628154851.GA534688-robh@kernel.org>
References: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
 <20230628092812.1592644-3-thippeswamy.havalige@amd.com>
 <168794750573.46969.6154878983254071435.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168794750573.46969.6154878983254071435.robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 04:18:26AM -0600, Rob Herring wrote:
> 
> On Wed, 28 Jun 2023 14:58:11 +0530, Thippeswamy Havalige wrote:
> > Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
> > dt binding.
> > 
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > change in v5:
> > Modified uppercase case hex value to lower case.
> > change in v4:
> > - Removed unnecessary space.
> > changes in v3:
> > - Fixed compatible string issue.
> > - Modified ranges property description to maxItems.
> > - Modified address-cell property of interrupt-controller child node.
> > changes in v2:
> > - None
> >  .../bindings/pci/xlnx,xdma-host.yaml          | 114 ++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
> Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
> Documentation/devicetree/bindings/i2c/qcom,i2c-cci.example.dtb: /example-0/cci@ac4a000/i2c-bus@1/camera@60: failed to match any schema with compatible: ['ovti,ov7251']
> Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example-0/usb/mdio@1/switch@0: failed to match any schema with compatible: ['marvell,mv88e6190']
> Documentation/devicetree/bindings/net/qca,ar71xx.example.dtb: /example-0/ethernet@1a000000/mdio/switch@10: failed to match any schema with compatible: ['qca,ar9331-switch']
> Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: /example-0/memory-controller@13410000/ethernet@6: failed to match any schema with compatible: ['davicom,dm9000']
> Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.example.dtb: /example-0/iomcu@ffd7e000: failed to match any schema with compatible: ['hisilicon,hi3660-iomcu', 'syscon']
> Documentation/devicetree/bindings/leds/common.example.dtb: /example-2/i2c/led-controller@30: failed to match any schema with compatible: ['panasonic,an30259a']
> Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
> Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: /example-0/parent/i2c/camera@36: failed to match any schema with compatible: ['ovti,ov5695']
> Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dtb: /example-1/syscon@20e00000: failed to match any schema with compatible: ['sprd,sc9863a-glbregs', 'syscon', 'simple-mfd']
> Documentation/devicetree/bindings/clock/milbeaut-clock.example.dtb: /example-2/serial@1e700010: failed to match any schema with compatible: ['socionext,milbeaut-usio-uart']
> Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.example.dtb: /example-0/cpuctrl@a22000/clock@0: failed to match any schema with compatible: ['hisilicon,hix5hd2-clock']
> Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.example.dtb: /example-0/peripheral-controller@8a20000/phy@850: failed to match any schema with compatible: ['hisilicon,hi3798cv200-combphy']
> Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.example.dtb: /example-0/system-controller@802000/clock@0: failed to match any schema with compatible: ['hisilicon,hi3620-clock']
> Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/cpu: failed to match any schema with compatible: ['cpu-driver']
> Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/codec: failed to match any schema with compatible: ['codec-driver']
> Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: /example-0/pmic@0: failed to match any schema with compatible: ['sprd,sc2731']
> Documentation/devicetree/bindings/input/mediatek,pmic-keys.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['mediatek,mt6397']
> Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
> Documentation/devicetree/bindings/thermal/imx-thermal.example.dtb: /example-0/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6q-anatop', 'syscon', 'simple-mfd']

This can be ignored.

Rob
