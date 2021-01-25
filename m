Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C12303568
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 06:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbhAZFkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbhAYP4H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 10:56:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BDC0613D6;
        Mon, 25 Jan 2021 07:55:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id n6so15932621edt.10;
        Mon, 25 Jan 2021 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOfyMKZTVMFkxLGbe5k1gBTItQ5Xbwh8Wz8c7T0rHmk=;
        b=L8u7VlRW+tiHkg7CeNcQ8xLj5U4iZ3T947mi7HmkKzueWsl3NCRKZji9ykkWFWwzuI
         zsFXp4OkcppPqgu2qeHGxA3zUKcIhOU+/UlPuZZ9fpx0iam6Q6bt9Wj/FIc6ZHLfxiF9
         2RBFE0pl8YmzUJ8aOtjRu769KjX3DNiOSWmOsQ7sxABfMSOUHeX3f1P34PTL/XpTxopy
         9Gb0zalU+3zbV7nL7aLv6mjz39/uMprOMSwagXUgg+NINiyFB9R3aGHa+lNgH+LUxFwi
         2fvC96lEHqFy9fCMDpq5fj1h+/BwWTGQoJjjKTJOmuE2ociKYCJTjp8aq1vpz031LbE5
         Bl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOfyMKZTVMFkxLGbe5k1gBTItQ5Xbwh8Wz8c7T0rHmk=;
        b=poJuPy0sIqzziu8dkJ1Efg4gELSTxUOQrLrYpvs4VKNqmm/HmJgmQ2iOAiL2hBuO8i
         yE3zNzMJIfI3VJKFNqI0AcQUZRoRPWFUsnLDIEJ/fSZu+RR/tcsAwEGfAR1dRb0npEsn
         2v6s/woMnRzCwtGoR0PtNDcDdTuZv6NUvs0JRhG8UIc8W/bTzzJuiECIaSdP0OWLjWmK
         NnEIe1kcnvrwLH6/3MrqW1uC8YDekUYHLhzSRcKuq9Zq4/I78t7km2xKscLXVDIllbz4
         KmDJtkLcb2vszAM1CG2AT4DgWJAwaWot7CFrUX3FyxF3NXHZDnu00Y8+UnrpasaazHvT
         9PPQ==
X-Gm-Message-State: AOAM5324tWlNWhXuBhMadx4DsH4v1ahWSMmDJ5cDyMdZ2MUC+Wqjqq0d
        6bsK8oeMovKattLU5Tq7WEvT9JTVBMY=
X-Google-Smtp-Source: ABdhPJyuulNKB4EEL1lvq10gMZkd3iMS9W3Tjc6+svr9Nz6yqMHzt4bETBprYKKiGcOwQkzAwwNS5Q==
X-Received: by 2002:a05:6402:31ae:: with SMTP id dj14mr1015112edb.364.1611590122664;
        Mon, 25 Jan 2021 07:55:22 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g14sm10818591edm.31.2021.01.25.07.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 07:55:22 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
To:     Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Heiko Stuebner <heiko@sntech.de>
References: <20210125024824.634583-1-xxm@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <84c7672f-2cfc-63fc-bc36-35ab22cbfad8@gmail.com>
Date:   Mon, 25 Jan 2021 16:55:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210125024824.634583-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks you for version 3.

A few comments, have a look if it is useful or that you disagree.

On 1/25/21 3:48 AM, Simon Xue wrote:
> Document DT bindings for PCIe controller found on Rockchip SoC.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> new file mode 100644
> index 000000000000..24ea42203c14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -0,0 +1,133 @@
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
> +  - Heiko Stuebner <heiko@sntech.de>
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
> +    items:
> +      - const: rockchip,rk3568-pcie
> +      - const: snps,dw-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers
> +      - description: Rockchip designed configuration registers

reg-names:
    items:
      - const: dbi
      - const: apb

rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");

config ???

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
> +  num-lanes: true
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ranges:

> +    maxItems: 3

if remove ??? config ???
<0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000>
then maxItems: 2

> +

reset-gpios:
   maxItems: 1

rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
GPIOD_OUT_HIGH);

> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: pipe

vpcie3v3-supply: true

rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");

> +
> +required:
> +  - compatible
> +  - reg

> +  - reg-names

required but not defined above

> +  - clocks
> +  - clock-names
> +  - msi-map
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |

> +    #include <dt-bindings/interrupt-controller/arm-gic.h>

no interrupts then no need for include defines ??

> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie3x2: pcie@fe280000 {
> +            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
> +            reg = <0x3 0xc0800000 0x0 0x400000>,
> +                  <0x0 0xfe280000 0x0 0x10000>;

> +            reg-names = "pcie-dbi", "pcie-apb";

reg-names = "dbi", "apb";

> +            bus-range = <0x20 0x2f>;
> +            clocks = <&cru 143>, <&cru 144>,
> +                     <&cru 145>, <&cru 146>,
> +                     <&cru 147>;
> +            clock-names = "aclk_mst", "aclk_slv",
> +                          "aclk_dbi", "pclk",
> +                          "aux";
> +            device_type = "pci";
> +            linux,pci-domain = <2>;
> +            max-link-speed = <2>;
> +            msi-map = <0x2000 &its 0x2000 0x1000>;
> +            num-lanes = <2>;
> +            phys = <&pcie30phy>;
> +            phy-names = "pcie-phy";
> +            power-domains = <&power 15>;

> +            ranges = <0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000>,

remove ??? config ???
<0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000>

> +                     <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
> +                     <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
> +            resets = <&cru 193>;
> +            reset-names = "pipe";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +        };
> +    };
> +...
> 

