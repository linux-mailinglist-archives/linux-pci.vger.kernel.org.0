Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892C74154E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjF1PfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 11:35:05 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:48508 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjF1PeL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 11:34:11 -0400
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3457157a164so18075965ab.1;
        Wed, 28 Jun 2023 08:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966450; x=1690558450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/X2hAUFjtjTxD3ZzLBqnkOn9iuSLj2tfmbRpgM7AGs=;
        b=c2Mac58w2NhNI7jX/razs+RcjJKNzXPhdoa5KTw5M7yTkboMB5bOQvhGdlAVnsdnga
         L6kwME6pzFm5v27sz2rHu7Mr3HqJ/ZzkaQjIBRA6h5nhhz6WRsVXeY6E6k27H1EaeaWK
         +eieGdp4yM2rprjVSrE7ebtYRdohlib/LEU+KwCucvjVBVtHdZyoh4Fw+7t5OOimDdkc
         QOiY+vxt27II0/+AdYckg3ZiHcfe9FYpE3npm7OVUDRP+HPG2yYIJypBuHv3NYLX/Scu
         w+FBqvkP+de299kcdOvmUsUVC0frwBM7rRdlhrdQ1sihfd738uMhumpNrJhfWdyXK1wQ
         tzJQ==
X-Gm-Message-State: AC+VfDz+fgc43+Y1h52x8peuMVC1xW1NQVcCEzl9MaGhPDJOdYYGKMcQ
        uMO9LDBsKrBrlpALdEe2sQ==
X-Google-Smtp-Source: ACHHUZ5cBSGxp5brqqji35xfsO4qnAZ87cIJPAyEYQR3gryEjVp6yQwQleq5s0Zu+gObkzPLaOcK8g==
X-Received: by 2002:a05:6e02:6d1:b0:342:7948:80dd with SMTP id p17-20020a056e0206d100b00342794880ddmr25928777ils.18.1687966450039;
        Wed, 28 Jun 2023 08:34:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s14-20020a92cc0e000000b00345b34fcf34sm1550349ilp.38.2023.06.28.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:34:09 -0700 (PDT)
Received: (nullmailer pid 518656 invoked by uid 1000);
        Wed, 28 Jun 2023 15:34:06 -0000
Date:   Wed, 28 Jun 2023 09:34:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     quic_ramkri@quicinc.com, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, quic_nitegupt@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, helgaas@kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Conor Dooley <conor+dt@kernel.org>, quic_skananth@quicinc.com,
        krzysztof.kozlowski@linaro.org, manivannan.sadhasivam@linaro.org,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Message-ID: <20230628153406.GA517577-robh@kernel.org>
References: <1687918770-28416-1-git-send-email-quic_krichai@quicinc.com>
 <1687918770-28416-2-git-send-email-quic_krichai@quicinc.com>
 <168792223860.3670940.1209110069541964432.robh@kernel.org>
 <3ccdc726-bb7b-85ba-b492-4bee5474c8d7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ccdc726-bb7b-85ba-b492-4bee5474c8d7@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 10:45:03AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 6/28/2023 8:47 AM, Rob Herring wrote:
> > On Wed, 28 Jun 2023 07:49:28 +0530, Krishna chaitanya chundru wrote:
> > > Some platforms may not boot if a device driver doesn't
> > > initialize the interconnect path. Mostly it is handled
> > > by the bootloader but we have starting to see cases
> > > where bootloader simply ignores them.
> > > 
> > > Add the "pcie-mem" interconnect path as a required property
> > > to the bindings.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/clock/milbeaut-clock.example.dtb: /example-2/serial@1e700010: failed to match any schema with compatible: ['socionext,milbeaut-usio-uart']
> > Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dtb: /example-1/syscon@20e00000: failed to match any schema with compatible: ['sprd,sc9863a-glbregs', 'syscon', 'simple-mfd']
> > Documentation/devicetree/bindings/leds/common.example.dtb: /example-2/i2c/led-controller@30: failed to match any schema with compatible: ['panasonic,an30259a']
> > Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/cpu: failed to match any schema with compatible: ['cpu-driver']
> > Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/codec: failed to match any schema with compatible: ['codec-driver']
> > Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
> > Documentation/devicetree/bindings/thermal/imx-thermal.example.dtb: /example-0/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6q-anatop', 'syscon', 'simple-mfd']
> > Documentation/devicetree/bindings/i2c/qcom,i2c-cci.example.dtb: /example-0/cci@ac4a000/i2c-bus@1/camera@60: failed to match any schema with compatible: ['ovti,ov7251']
> > Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
> > Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
> > Documentation/devicetree/bindings/input/mediatek,pmic-keys.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['mediatek,mt6397']
> > Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: /example-0/pmic@0: failed to match any schema with compatible: ['sprd,sc2731']
> > Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> > Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
> > Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: /example-0/memory-controller@13410000/ethernet@6: failed to match any schema with compatible: ['davicom,dm9000']
> > Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.example.dtb: /example-0/cpuctrl@a22000/clock@0: failed to match any schema with compatible: ['hisilicon,hix5hd2-clock']
> > Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.example.dtb: /example-0/system-controller@802000/clock@0: failed to match any schema with compatible: ['hisilicon,hi3620-clock']
> > Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.example.dtb: /example-0/peripheral-controller@8a20000/phy@850: failed to match any schema with compatible: ['hisilicon,hi3798cv200-combphy']
> > Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: /example-0/parent/i2c/camera@36: failed to match any schema with compatible: ['ovti,ov5695']
> > Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example-0/usb/mdio@1/switch@0: failed to match any schema with compatible: ['marvell,mv88e6190']
> > Documentation/devicetree/bindings/net/qca,ar71xx.example.dtb: /example-0/ethernet@1a000000/mdio/switch@10: failed to match any schema with compatible: ['qca,ar9331-switch']
> > Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.example.dtb: /example-0/iomcu@ffd7e000: failed to match any schema with compatible: ['hisilicon,hi3660-iomcu', 'syscon']
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1687918770-28416-2-git-send-email-quic_krichai@quicinc.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> Hi Rob,
> 
> Can you please verify again I don't see any errors when I ran it

Yep, you can ignore this.

Rob
