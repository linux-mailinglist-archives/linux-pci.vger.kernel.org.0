Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2F1DC1FD
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgETWUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 18:20:44 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33159 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 18:20:44 -0400
Received: by mail-il1-f194.google.com with SMTP id y17so2771222ilg.0;
        Wed, 20 May 2020 15:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cvcsbmtAMBUtxfIKB+hoBBdn/4WW1hWmEN5RP5dp/Z0=;
        b=Xb4a+t3n2hAKF1CBgmXR7T7l4GZpzmDIH7bOKZHS3t8oggvmWgrzBSXy/mLvS26IWf
         XuG5ByfOeiV881xWr++NJYlJpn6qQmNHnCuTF+dxwZSmaKE/GNJWH+DEBsBZJ3mVHjQA
         SbTIMOCt9ujaMxQ8DWTMe2jDjoQmGFRhaAtxdORjFuT8kejdJ4g+kHF0t+ybEoTlrSsO
         9YBaJUvOPGRXLcEqFVGMtlamaYd92fAkesDwS1AGv5kvpn217/Gh4OvLfYV/1+xrw1VZ
         Jgaa3NBJxUNtIxan0LEUYXc0TCHVPkLPWP0TyqkWO4eIPA+hHII4KUhwIueaLEq385bX
         38ag==
X-Gm-Message-State: AOAM532hsOanGiQKnmrgTZrmpYC8+s81KwAhdYtmDz+5+Kv1t12OPdq9
        Eo8Ig+XlHSL2bUQdkzaLP6ye1Ng=
X-Google-Smtp-Source: ABdhPJybrWt7gAM8MOngLf1pJSaQmJyDF6HmEm5+ths4SE/nrQrPRuXnk2C9Hu3iAmKaSp2P7SOXjw==
X-Received: by 2002:a05:6e02:686:: with SMTP id o6mr5812922ils.280.1590013242979;
        Wed, 20 May 2020 15:20:42 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 7sm1609841ion.52.2020.05.20.15.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:20:42 -0700 (PDT)
Received: (nullmailer pid 704863 invoked by uid 1000);
        Wed, 20 May 2020 22:20:40 -0000
Date:   Wed, 20 May 2020 16:20:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM
 Root Port
Message-ID: <20200520222040.GA693614@bogus>
References: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1588852716-23132-2-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588852716-23132-2-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 05:28:35PM +0530, Bharat Kumar Gogada wrote:
> Add YAML schemas documentation for Versal CPM Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> new file mode 100644
> index 0000000..5fc5c3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/xilinx-versal-cpm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CPM Host Controller device tree for Xilinx Versal SoCs
> +
> +maintainers:
> +  - Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> +

allOf:
  - $ref: /schemas/pci/pci-bus.yaml#

> +properties:
> +  compatible:
> +    const: xlnx,versal-cpm-host-1.00
> +

> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2

Can drop.

> +
> +  reg:
> +    items:
> +      - description: Configuration space region and bridge registers.
> +      - description: CPM system level control and status registers.
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: cpm_slcr
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  msi-map:
> +    description:
> +      Maps a Requester ID to an MSI controller and associated MSI sideband data.
> +
> +  ranges:
> +    maxItems: 2
> +
> +  "#interrupt-cells":
> +    const: 1
> +

> +  interrupt-map-mask:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  interrupt-map:
> +    description: Standard PCI IRQ mapping properties.

Can drop these 2.

> +
> +  interrupt_controller:

s/_/-/

> +    description: Interrupt controller child node.

type: object

And then need to describe all the properties under it too.

> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.

Can drop.

> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-parent
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - ranges
> +  - bus-range
> +  - msi-map

interrupt-controller node not required?

You can drop all the standard properties required in pci-bus.yaml (it's 
in dtschema repo).

> +
> +additionalProperties: false

This will need to be 'unevaluatedProperties: false'

> +
> +examples:
> +  - |
> +
> +    versal {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               cpm_pcie: pci@fca10000 {

pcie@...

> +                       compatible = "xlnx,versal-cpm-host-1.00";
> +                       #address-cells = <3>;
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       interrupts = <0 72 4>;
> +                       interrupt-parent = <&gic>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> +                                       <0 0 0 2 &pcie_intc_0 1>,
> +                                       <0 0 0 3 &pcie_intc_0 2>,
> +                                       <0 0 0 4 &pcie_intc_0 3>;
> +                       bus-range = <0x00 0xff>;
> +                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
> +                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
> +                       msi-map = <0x0 &its_gic 0x0 0x10000>;
> +                       reg = <0x6 0x00000000 0x0 0x10000000>,
> +                             <0x0 0xfca10000 0x0 0x1000>;
> +                       reg-names = "cfg", "cpm_slcr";
> +                       pcie_intc_0: interrupt_controller {
> +                               #address-cells = <0>;
> +                               #interrupt-cells = <1>;
> +                               interrupt-controller ;
> +                       };
> +                };
> +    };
> -- 
> 2.7.4
> 
