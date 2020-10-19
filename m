Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75B6292538
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgJSKMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 06:12:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36830 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJSKMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:12:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id x7so10749072wrl.3;
        Mon, 19 Oct 2020 03:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNwoLW/uhEhaowbL4cROOqpmBzSg2gSs6aEkMndsKUs=;
        b=n2ysOjWCt03tFL4y7NB/qkG3vSlIC0m9nAg3RLtWVzB/Vcb8O4qTEd35/L1Y6N9lbc
         rzcVQdmwHmb75zHTWpZDR6M+28mu8rflIs6fzBo31Zc8+mNLq9keTj8RIytmYT9TJFJa
         2q+Sn+QNmarKTjntw/FVvqxfdPo8C3MOasNLQ7hwA8UhCfMVU8+CL6tWx2W0my6h5aGe
         5HUthGTMKmbL6aRq9Y8AmXBhx2XuSWbhis/lxaoeSGrK+lYtnNVLdSXqQrX1aieNXrhB
         VoNeAvlpAcJQF+OXfIKJMZ5t30XX5HrA+YQuBIfPEnBLrxplMf3CR8xH1lb60G1l+UjW
         T38w==
X-Gm-Message-State: AOAM533lkSATNjO6JLB67U4XHX2Linm5F/MQk8nQyLJw8YolRsip/KeI
        W7N/bjrXCmrdoI4xKYNujMiFewgoPFQ=
X-Google-Smtp-Source: ABdhPJxutNGEBOApOamb7LS0Wy9OIl/aw9zfThBCsPaSZTA6O8zHW5zY8pJW3zCsX6xx2EdfhseGAQ==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr19942142wrn.81.1603102357080;
        Mon, 19 Oct 2020 03:12:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id x3sm15743796wmi.45.2020.10.19.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:12:35 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:12:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie binding
Message-ID: <20201019101233.GB51073@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
 <20201019094715.15343-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-3-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:11AM +0200, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> variant).

The title has typo and actually entire "Doc" should be dropped. Just
"dt-bindings: pci:".  This applies to all DT patches.

> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
> 	   rewrote commit message]

If you wrote them in YAML it should be a new patch of yours. It is the
same then as converting TXT to YAML.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> new file mode 100644
> index 000000000000..48fb569c238c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC series PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Jaehoon Chung <jh80.chung@samsung.com>
> +
> +description: |+
> +  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  designware-pcie.txt.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos5433-pcie

const, not enum

> +
> +  reg:
> +    items:
> +      - description: External Local Bus interface (ELBI) registers.
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: elbi
> +      - const: bdi
> +      - const: config
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PCIe bridge clock
> +      - description: PCIe bus clock
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +  vdd10-supply:
> +    description:
> +      Phandle to a regulator that provides 1.0V power to the PCIe block.
> +
> +  vdd18-supply:
> +    description:
> +      Phandle to a regulator that provides 1.8V power to the PCIe block.
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - vdd10-supply

additionalProperties: false

Best regards,
Krzysztof
