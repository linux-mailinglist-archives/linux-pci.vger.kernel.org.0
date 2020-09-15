Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8C26AC84
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgIOStr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 14:49:47 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36716 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgIORZO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 13:25:14 -0400
Received: by mail-il1-f193.google.com with SMTP id t12so3779522ilh.3;
        Tue, 15 Sep 2020 10:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ul2LXTL5GXddTr4Xc/xs2FtVJnvszmoffCmKpJlo9Ic=;
        b=UsvAiHoiY3WYFDiR8IiG3t7IQmCHLjQWtJNU82KdnKBejQ+br/wgB/baFpVsSKeODg
         TLDOiTeEv72Q0VmfxIMzyQNhKpfW09q9CvDOu9WoHPRgk0tdkxbMsdcs9SFwrSVkES/1
         XUN7XllNuyXybi9cVidtm4udJ9f545AAg/8d//S0L6b1i2UbqVAm+vdyrBMuyWgCIBNk
         ULEVsnaVVYHjXBSLohjxJHXg+jGbKkDL3pNbfAJDa0Er7xZUYGKCMb1m9qxgQyxxL+0a
         g8bxYSyI22zVxlz6SmVLtEf2wG9ltHhPgWQHSzn1UeKywXD0RXcfLvRicuQO1mI5apxT
         Rbxw==
X-Gm-Message-State: AOAM53267W+9SDe5N6E2+GTZZ46iuCltRWujgkflG6DwbNXl5eZJSQC2
        fBcQ2zxq5WIGZRuZSl6MVbMO1dtpW6jAxlE=
X-Google-Smtp-Source: ABdhPJyISWkF+R7pw4ebaFKvuvf67D5TILLOAU6Wc/MtGZsidYExPVK3Q2KtISQkKKySYa2VtJjUUg==
X-Received: by 2002:a92:9ec3:: with SMTP id s64mr17294072ilk.294.1600190703172;
        Tue, 15 Sep 2020 10:25:03 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t4sm7987748iob.48.2020.09.15.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:25:02 -0700 (PDT)
Received: (nullmailer pid 2162809 invoked by uid 1000);
        Tue, 15 Sep 2020 17:25:01 -0000
Date:   Tue, 15 Sep 2020 11:25:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC
 host controller
Message-ID: <20200915172501.GA2146778@bogus>
References: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
 <1599644912-29245-2-git-send-email-wuht06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599644912-29245-2-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 09, 2020 at 05:48:31PM +0800, Hongtao Wu wrote:
> From: Hongtao Wu <billows.wu@unisoc.com>
> 
> This series adds PCIe bindings for Unisoc SoCs.
> This controller is based on DesignWare PCIe IP.
> 
> Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> ---
>  .../devicetree/bindings/pci/sprd-pcie.yaml         | 101 +++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> new file mode 100644
> index 0000000..c52edfb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sprd-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Hongtao Wu <billows.wu@unisoc.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sprd,pcie-rc
> +
> +  reg:
> +    minItems: 2
> +    items:
> +      - description: Controller control and status registers.
> +      - description: PCIe configuration registers.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +
> +  ranges:
> +    maxItems: 2
> +
> +  num-lanes:
> +    maximum: 1
> +    description: Number of lanes to use for this port.
> +
> +  interrupts:
> +    minItems: 1
> +    description: Builtin MSI controller and PCIe host controller.
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +
> +  sprd-pcie-poweron-syscons:

Doesn't match the example.

> +    minItems: 1
> +    description: Global register.
> +      The first value is the phandle to the global registers required to
> +      confige PCIe phy, clock and so on.
> +      The second value is the global register type which indicates whether it
> +      is a set/clear register or not.
> +      The third value is the time to delay after the global register is set or
> +      cleared.
> +      The fourth value is the global register address.
> +      The fifth value is the the mask value that the global register must
> +      be operate.
> +      The sixth value is the value that will be set to the global register.
> +      Note that Some Unisoc global registers have not been upstreamed.
> +      The global register and its mask can't be found in linux kernel,
> +      so we use an offset address and a number to instead them.

From the example, it looks like you set/clear 2 bits for power on/off. 
What's the worst case you expect here? What do the 2 bits do? If they 
are for clocks, resets, or power domains, then we have bindings for 
those which should be used. This use of phandles to syscons should be 
avoided whenever possible.

If we wanted a language for specifying sequences of register accesses in 
DT, we would have defined that a long time ago.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - num-lanes
> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ipa {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0: pcie@2b100000 {
> +            compatible = "sprd,pcie-rc";
> +            reg = <0x0 0x2b100000 0x0 0x2000>,
> +                  <0x2 0x00000000 0x0 0x2000>;
> +            reg-names = "dbi", "config";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges = <0x01000000 0x0 0x00000000 0x2 0x00002000 0x0 0x00010000>,
> +                     <0x03000000 0x0 0x10000000 0x2 0x10000000 0x1 0xefffffff>;
> +            num-lanes = <1>;
> +            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi";
> +
> +            sprd,pcie-poweron-syscons =
> +                <&ap_ipa_ahb_regs 0 0 0x0000 0x40 0x40>,
> +                <&ap_ipa_ahb_regs 0 0 0x0000 0x20 0x20>;
> +            sprd,pcie-poweroff-syscons =

Not documented.

> +                <&ap_ipa_ahb_regs 0 0 0x0000 0x20 0x0>,
> +                <&ap_ipa_ahb_regs 0 0 0x0000 0x40 0x0>;
> +        };
> +    };
> --
> 2.7.4
> 
