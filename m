Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5595B2FD685
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 18:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391746AbhATRJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 12:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391034AbhATRIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 12:08:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B21C0613C1;
        Wed, 20 Jan 2021 09:07:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id rv9so15772711ejb.13;
        Wed, 20 Jan 2021 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1wX5ly9KNpFR/9HstrUm3GzasiDkWdUw9hrXvAAY0Ts=;
        b=KOeywYqay+ueWQ5/AK4VgxKMSGMkyowp/1EijRuSIgJkCuhm/8YWHVQ4LtUExF1ZtC
         tIbWeGoPwD9A1ajCJaLwgxi8io21qbc2nb1M6xb+/2zLM80lyyVAeD5DsHGy8/WAhojj
         8Um4Vx3GtjJYAQy9GAZVDzEtPDL5Uk2WYsEGZljf0EfQLpqw90HJXdOtm4dfKeAzO6mi
         ZFB1XIHcdldxCF0/izAQm5JFrkr12qjIhw/AM6i1nEupwqsATl+pasqxaryV9LNp3/b3
         kQiN6jurcYntN1oyRZ6wzrjD9KH/tQoGAtYkr04wAdkUs+AnECzpTCBs6vJLacrbhl7i
         BQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1wX5ly9KNpFR/9HstrUm3GzasiDkWdUw9hrXvAAY0Ts=;
        b=IIiRbya9emKALTfx3pLiVIGdy7xj/BeMI1Xkdt0+Ekz/iXemZHhKgPHrR1O8TuyJAp
         i7Wmu3pLqTrm2qLRKbJrRpGV00cKCdWF4NQuVqpU8AD8DeizSe8JymWI4827hpzSFtBk
         2VPsbil1n5YNBBooBiadJxk4EIPscNKleHyNl4DYmOLU5PfuggAmbU6xjSfQmSVi+q7w
         K4ocN6ZT49zcJGuYTLdhLawQGMQ9WxYMNDVNA4Rw86p9fsasx8hbleuV9mKl1vqyKOr/
         qlGAayyb8b4T836LPPS3gJ6gI1uriHkX6PfIfnKRsn5k6hLCcxa4+JiZrVs4JmMGZ3V5
         zGgw==
X-Gm-Message-State: AOAM532r/Wk6EmNOitgfex5hPLpf6HT/PEqONbCft74WO+trC5isIWHr
        V19pWlkWF5dsRUndaWHyuqbIGWw6YK4=
X-Google-Smtp-Source: ABdhPJzx43bHVjPAsc27foNN651TyJnIkWDokBwgyvBBBheh28vCkRltuJq0N3m+hunyuKGeJiBiIA==
X-Received: by 2002:a17:906:cedd:: with SMTP id si29mr7109703ejb.426.1611162451828;
        Wed, 20 Jan 2021 09:07:31 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y8sm1408114edd.97.2021.01.20.09.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 09:07:31 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
To:     Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Heiko Stuebner <heiko@sntech.de>
References: <20210120101554.241029-1-xxm@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <3af70037-c05d-1759-2bae-41db1e8e2768@gmail.com>
Date:   Wed, 20 Jan 2021 18:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210120101554.241029-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Simon,

Thanks you for version 2.
A few comments, have a look if it is useful or that you disagree.

This patch has no commit message. Add one in version 3.

Submit all patches in one batch with the same sort message ID to all
maintainers including Heiko.

Heiko Stuebner <heiko@sntech.de>

Example message ID:
20210120101554.241029-1-xxm@rock-chips.com

/////

Included is a copy of the Rockchip pcie nodes in a sort of test.dts below.
Could you confirm that the properties in that dts are the one that we
can expect for Linux mainline and can base our YAML document on?

With rk3568-cru.h and rk3568-power.h manualy added we do some tests with
the following commands:

make ARCH=arm64 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/pci/pci-bus.yaml

/////

Example notifications:

/arch/arm64/boot/dts/rockchip/test.dt.yaml: pcie@fe270000: reg: [[3,
3225419776, 0, 4194304], [0, 4263968768, 0, 65536]] is too long

/arch/arm64/boot/dts/rockchip/test.dt.yaml: pcie@fe270000: ranges:
'oneOf' conditional failed, one must be fixed:

Before you submit version 3 make sure that all warnings gone as much as
possible.

On 1/20/21 11:15 AM, Simon Xue wrote:
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> new file mode 100644
> index 000000000000..9d3a57f5305e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe RC controller on Rockchip SoCs
> +
> +maintainers:
> +  - Shawn Lin <shawn.lin@rock-chips.com>
> +  - Simon Xue <xxm@rock-chips.com>
     - Heiko Stuebner <heiko@sntech.de> ;)
> +
> +description: |+
> +  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  designware-pcie.txt.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +# We need a select here so we don't match all nodes with 'snps,dw-pcie'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: rockchip,rk3568-pcie
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:

> +    item:

    items:

> +      - const: rockchip,rk3568-pcie
> +      - const: snps,dw-pcie

Add empty line

> +  reg:    items:
      - description:
      - description:

Add some description for regs.

> +    maxItems: 1
remove

This reg maxItems gives errors.

> +

> +  interrupt:
interrupts:
   items:

> +      - description: system information
> +      - description: power management control
> +      - description: PCIe message
> +      - description: legacy interrupt
> +      - description: error report
> +
> +  interrupt-names:
> +    items:
> +      - const: sys
> +      - const: pmc
> +      - const: msg
> +      - const: legacy
> +      - const: err
> +
> +  clocks:
> +    items:
> +      - description: AHB clock for PCIe master
> +      - description: AHB clock for PCIe slave
> +      - description: AHB clock for PCIe dbi
> +      - description: APB clock for PCIe
> +      - description: Auxiliary clock for PCIe
> +
> +  clock-names:
> +    items:
> +      - const: aclk_mst
> +      - const: aclk_slv
> +      - const: aclk_dbi
> +      - const: pclk
> +      - const: aux
> +
> +  msi-map: true
> +
> +  power-domains:
> +    maxItems: 1

/////
These properties come from designware-pcie.txt
Maybe add them here for now till there's a common yaml?

  num-ib-windows: number of inbound address translation windows
  num-ob-windows: number of outbound address translation windows

Optional properties:
  num-lanes:

/////

  phys:
    maxItems: 1

  phy-names:
    const: pcie-phy

ranges:
     ......
     ......
This ranges needs a fix so that it doesn't generate notifications.
See above example.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:

        const: pipe

> +    items:
> +      - const: pipe

remove

> +
> +required:
> +  - compatible
> +  - bus-range
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - msi-map
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - power-domains
> +  - resets
> +  - reset-names

Add also all the other properties that are defined in this binding and
are required. But not the ones from pci-bus.yaml.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |

> +    #include <dt-bindings/clock/rk3568-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/rk3568-power.h>

If #include is not possible for now replace all defines by there
original numbers.
Just to get this binding pass for mainline.

> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie3x2: pcie@fe280000 {
> +            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";

dts sort order is:

compatible
reg
interrupts
the rest
things with #

> +            reg = <0x3 0xc0800000 0x0 0x400000>,
> +                  <0x0 0xfe280000 0x0 0x10000>;
> +            reg-names = "pcie-dbi", "pcie-apb";
> +            interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;

> +            interrupt-names = "sys", "pmc", "msg", "legacy", "err";

Could you confirm that these "interrupt-names" are used in your driver?
Else remove.

            bus-range = <0x20 0x2f>;

> +            clocks = <&cru ACLK_PCIE30X2_MST>, <&cru ACLK_PCIE30X2_SLV>,
> +                     <&cru ACLK_PCIE30X2_DBI>, <&cru PCLK_PCIE30X2>,
> +                     <&cru CLK_PCIE30X2_AUX_NDFT>;
> +            clock-names = "aclk_mst", "aclk_slv",
> +                          "aclk_dbi", "pclk",
> +                          "aux";

		device_type = "pci";
		linux,pci-domain = <0>;
		num-ib-windows = <6>;
		num-ob-windows = <2>;
		max-link-speed = <2>;

Maybe give a complete example?

> +            msi-map = <0x2000 &its 0x2000 0x1000>;
> +            num-lanes = <2>;
> +            phys = <&pcie30phy>;
> +            phy-names = "pcie-phy";
> +            power-domains = <&power RK3568_PD_PIPE>;
> +            ranges = <0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000
> +                      0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000
> +                      0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
> +            resets = <&cru SRST_PCIE30X2_POWERUP>;
> +            reset-names = "pipe";

            #address-cells = <3>;
            #size-cells = <2>;

> +        };
> +    };
> +...
> 

///////////

test.dts

///////////
/dts-v1/;
#include <dt-bindings/clock/rk3568-cru.h>
#include <dt-bindings/interrupt-controller/arm-gic.h>
#include <dt-bindings/interrupt-controller/irq.h>
#include <dt-bindings/phy/phy.h>
#include <dt-bindings/power/rk3568-power.h>

/ {
	compatible = "rockchip,rk3568";

	#address-cells = <2>;
	#size-cells = <2>;

	cru: clock-controller@fdd20000 {
		compatible = "rockchip,rk3568-cru";
		reg = <0x0 0xfdd20000 0x0 0x1000>;
		#clock-cells = <1>;
		#reset-cells = <1>;
	};

	pcie30phy: phy@fe8c0000 {
		compatible = "rockchip,rk3568-pcie3-phy";
		reg = <0x0 0xfe8c0000 0x0 0x20000>;
		#phy-cells = <0>;
	};

	combphy2_psq: phy@fe840000 {
		compatible = "rockchip,rk3568-naneng-combphy";
		reg = <0x0 0xfe840000 0x0 0x100>;
		#phy-cells = <1>;
	};

	gic: interrupt-controller@fd400000 {
		compatible = "arm,gic-v3";
		#interrupt-cells = <3>;
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;
		interrupt-controller;

		reg = <0x0 0xfd400000 0 0x10000>,
		      <0x0 0xfd460000 0 0xc0000>;
		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
		its: interrupt-controller@fd440000 {
			compatible = "arm,gic-v3-its";
			msi-controller;
			#msi-cells = <1>;
			reg = <0x0 0xfd440000 0x0 0x20000>;
			status = "disabled";
		};
	};

	pmu: power-management@fdd90000 {
		compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
		reg = <0x0 0xfdd90000 0x0 0x1000>;

		power: power-controller {
			compatible = "rockchip,rk3568-power-controller";
			#power-domain-cells = <1>;
			#address-cells = <1>;
			#size-cells = <0>;
			status = "okay";
		};
	};

	pcie2x1: pcie@fe260000 {
		compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
		reg = <0x3 0xc0000000 0x0 0x400000>,
		      <0x0 0xfe260000 0x0 0x10000>;
		reg-names = "pcie-dbi", "pcie-apb";
		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
		bus-range = <0x0 0xf>;
		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
			 <&cru CLK_PCIE20_AUX_NDFT>;
		clock-names = "aclk_mst", "aclk_slv",
			      "aclk_dbi", "pclk", "aux";
		device_type = "pci";
		linux,pci-domain = <0>;
		num-ib-windows = <6>;
		num-ob-windows = <2>;
		max-link-speed = <2>;
		msi-map = <0x0 &its 0x0 0x1000>;
		num-lanes = <1>;
		phys = <&combphy2_psq PHY_TYPE_PCIE>;
		phy-names = "pcie-phy";
		power-domains = <&power RK3568_PD_PIPE>;
		ranges = <0x00000800 0x0 0x00000000 0x3 0x00000000 0x0 0x800000
			  0x81000000 0x0 0x00800000 0x3 0x00800000 0x0 0x100000
			  0x83000000 0x0 0x00900000 0x3 0x00900000 0x0 0x3f700000>;
		resets = <&cru SRST_PCIE20_POWERUP>;
		reset-names = "pipe";
		#address-cells = <3>;
		#size-cells = <2>;
		status = "disabled";
	};

	pcie3x1: pcie@fe270000 {
		compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
		reg = <0x3 0xc0400000 0x0 0x400000>,
		      <0x0 0xfe270000 0x0 0x10000>;
		reg-names = "pcie-dbi", "pcie-apb";
		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
		bus-range = <0x10 0x1f>;
		clocks = <&cru ACLK_PCIE30X1_MST>, <&cru ACLK_PCIE30X1_SLV>,
			 <&cru ACLK_PCIE30X1_DBI>, <&cru PCLK_PCIE30X1>,
			 <&cru CLK_PCIE30X1_AUX_NDFT>;
		clock-names = "aclk_mst", "aclk_slv",
			      "aclk_dbi", "pclk", "aux";
		device_type = "pci";
		linux,pci-domain = <1>;
		num-ib-windows = <6>;
		num-ob-windows = <2>;
		max-link-speed = <3>;
		msi-map = <0x1000 &its 0x1000 0x1000>;
		num-lanes = <1>;
		phys = <&pcie30phy>;
		phy-names = "pcie-phy";
		power-domains = <&power RK3568_PD_PIPE>;
		ranges = <0x00000800 0x0 0x40000000 0x3 0x40000000 0x0 0x800000
			  0x81000000 0x0 0x40800000 0x3 0x40800000 0x0 0x100000
			  0x83000000 0x0 0x40900000 0x3 0x40900000 0x0 0x3f700000>;
		resets = <&cru SRST_PCIE30X1_POWERUP>;
		reset-names = "pipe";
		#address-cells = <3>;
		#size-cells = <2>;
		status = "disabled";
	};

	pcie3x2: pcie@fe280000 {
		compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
		reg = <0x3 0xc0800000 0x0 0x400000>,
		      <0x0 0xfe280000 0x0 0x10000>;
		reg-names = "pcie-dbi", "pcie-apb";
		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
		bus-range = <0x20 0x2f>;
		clocks = <&cru ACLK_PCIE30X2_MST>, <&cru ACLK_PCIE30X2_SLV>,
			 <&cru ACLK_PCIE30X2_DBI>, <&cru PCLK_PCIE30X2>,
			 <&cru CLK_PCIE30X2_AUX_NDFT>;
		clock-names = "aclk_mst", "aclk_slv",
			      "aclk_dbi", "pclk", "aux";
		device_type = "pci";
		linux,pci-domain = <2>;
		num-ib-windows = <6>;
		num-ob-windows = <2>;
		max-link-speed = <3>;
		msi-map = <0x2000 &its 0x2000 0x1000>;
		num-lanes = <2>;
		phys = <&pcie30phy>;
		phy-names = "pcie-phy";
		power-domains = <&power RK3568_PD_PIPE>;
		ranges = <0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000
			  0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000
			  0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
		resets = <&cru SRST_PCIE30X2_POWERUP>;
		reset-names = "pipe";
		#address-cells = <3>;
		#size-cells = <2>;
		status = "disabled";
	};
};
