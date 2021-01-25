Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F403048BB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbhAZFkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:40:12 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45443 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbhAYPiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 10:38:21 -0500
Received: by mail-ot1-f49.google.com with SMTP id n42so13098269ota.12;
        Mon, 25 Jan 2021 07:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f18aNlf+CBP0yuuR02rWziM5RLBYLipwk+rx5Ec7GS8=;
        b=QFd6Q1pxY6fNeAuXRDZLa871Cu1jUJtc/g5v7sL+W3kHdSw3UtoVUWarB030pk65lH
         yXPuyIOfOKSIom588SIvZb8BccogjHhL7CZbgOPWNDJdwjzpACr7z6019CvO7L4TPnhB
         h33Fud+Wyl2Wzg+xwj0id4CRMfRsDVqXAwtO5iwnaansRVSR6PiotwdI4v+jMPXWiTk2
         iZ5QSV5Dkx9h3oaG9P2eazHMLiSkJOXAD8XhTynAxTT2vvrJezEEkS+VL9GZ+OgKAPGV
         F1UFin9wiyaBPivqf7VA3j8EMQA6W+1p6UXjwGCKpJ622dOst2gjNqTHSpQD9Ih3s9wI
         RT5Q==
X-Gm-Message-State: AOAM530A9vIYIg66eHaG8bJKqWnkLjzp0vgbLv5WQihC0vpCYhSZvKkm
        IYaClWHUuxda18ANjuqg9lcm71XOBw==
X-Google-Smtp-Source: ABdhPJwBLRd3UYnmCyIIcmDPrWI9kJuiZLJQ+nSP8vtT2LMcRfAerKqDfj2xYImFVdFMovdkZAB/Qg==
X-Received: by 2002:a9d:6e98:: with SMTP id a24mr797090otr.351.1611588394589;
        Mon, 25 Jan 2021 07:26:34 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm3593187oth.41.2021.01.25.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:26:33 -0800 (PST)
Received: (nullmailer pid 390270 invoked by uid 1000);
        Mon, 25 Jan 2021 15:26:32 -0000
Date:   Mon, 25 Jan 2021 09:26:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20210125152632.GA381616@robh.at.kernel.org>
References: <20210125024824.634583-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125024824.634583-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 10:48:24AM +0800, Simon Xue wrote:
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
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: pipe
> +
> +required:
> +  - compatible
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
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
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

I believe I already said use 'dbi'. The DBI is also not 4MB. The config 
space goes here too, not in 'ranges'.

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
> +                     <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
> +                     <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
> +            resets = <&cru 193>;
> +            reset-names = "pipe";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
> 
