Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB33CA40C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhGOR17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 13:27:59 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:35597 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhGOR16 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 13:27:58 -0400
Received: by mail-il1-f173.google.com with SMTP id a11so5701993ilf.2;
        Thu, 15 Jul 2021 10:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UT6yu64pjsQwg83SvbhVDr958pjgnmXDxPh8Y2Ai0pY=;
        b=RETj90UpgIRMOVoB/i0iNsFKH9/CKC851Dnp18nowrB57QamirZi/qWL7OFb8v2DzO
         nGfcf9+UsCI9lKjjNBRDe58RWxRXA4gCRm61k6BlevixBmaXqOVzElLLHBsJRVHhWOV9
         opiOwLT0OJBOhPPnnKN6yp1/W6vjTOGfj93bAp62RT8Fmn5v3VnQFjgd6aAu3M9vdlTg
         qEDFGIj6QDptPNCDbLRZhBoNMiojipygqjU7iD14x8Zh+if4UBB15r5KgGSw4T/5ChPX
         W0nUjuo7DqhcHTp8KM/r2vts/U6UeWfYBi6x5MuLOMc8UWak8XsE6DhEZ9tToxxNUAU0
         Jipg==
X-Gm-Message-State: AOAM530O28V/3iVME9xsbmAiTO4JShGj+JkuoSpv2b7RE0aLPTcCWtob
        N8le1+bl1Src1TOwavihvQ==
X-Google-Smtp-Source: ABdhPJyCLi7fSw7/fRoMn4kkpqkEFdQrBnpSMyjD+Rv63YLKdSMEk51qZSuhA94mLu4gvpYc0GAooA==
X-Received: by 2002:a92:6605:: with SMTP id a5mr3597431ilc.15.1626369904925;
        Thu, 15 Jul 2021 10:25:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c16sm3424131ilo.72.2021.07.15.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:25:03 -0700 (PDT)
Received: (nullmailer pid 1280076 invoked by uid 1000);
        Thu, 15 Jul 2021 17:25:00 -0000
Date:   Thu, 15 Jul 2021 11:25:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dt-bindings: PCI: kirin-pcie.txt: Convert it to
 yaml
Message-ID: <20210715172500.GB1263164@robh.at.kernel.org>
References: <cover.1626174242.git.mchehab+huawei@kernel.org>
 <1f9b2f372364328e9cd3a18cf605ad541f3de4ab.1626174242.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f9b2f372364328e9cd3a18cf605ad541f3de4ab.1626174242.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 01:17:55PM +0200, Mauro Carvalho Chehab wrote:
> Convert the file into a JSON description at the yaml format.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 81 +++++++++++++++++++
>  .../devicetree/bindings/pci/kirin-pcie.txt    | 41 ----------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 82 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> new file mode 100644
> index 000000000000..f797e2cc3da6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/hisilicon,kirin-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Kirin SoCs PCIe host DT description
> +
> +maintainers:
> +  - Xiaowei Song <songxiaowei@hisilicon.com>
> +  - Binghui Wang <wangbinghui@hisilicon.com>
> +
> +description: |
> +  Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
> +  It shares common functions with the PCIe DesignWare core driver and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.

Make this part of the schema:

> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#

$ref: /schemas/pci/snps,dw-pcie-yaml#

Instead.

> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - hisilicon,kirin960-pcie
> +        - hisilicon,kirin970-pcie
> +
> +  reg:
> +    description: |
> +      Should contain rc_dbi, apb, config registers location and length.

maxItems: 3

> +
> +  reg-names:
> +    items:
> +      - const: dbi          # controller configuration registers
> +      - const: apb          # apb Ctrl register defined by Kirin
> +      - const: config       # PCIe configuration space registers
> +

> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2

Don't need these 2. pci-bus.yaml covers that.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie: pcie@f4000000 {
> +        compatible = "hisilicon,kirin960-pcie";
> +        reg = <0x0 0xf4000000 0x0 0x1000>,
> +              <0x0 0xff3fe000 0x0 0x1000>,
> +              <0x0 0xf4000000 0 0x2000>;
> +        reg-names = "dbi","apb", "config";

space                        ^

> +        bus-range = <0x0  0x1>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
> +        num-lanes = <1>;
> +        #interrupt-cells = <1>;
> +        interrupts = <0 283 4>;

Not documented.

> +        interrupt-names = "msi";

Not documented.

> +        interrupt-map-mask = <0xf800 0 0 7>;
> +        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> deleted file mode 100644
> index 3a36eeb1c434..000000000000
> --- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -HiSilicon Kirin SoCs PCIe host DT description
> -
> -Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
> -It shares common functions with the PCIe DesignWare core driver and
> -inherits common properties defined in
> -Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
> -
> -Additional properties are described here:
> -
> -Required properties
> -- compatible:
> -	"hisilicon,kirin960-pcie"
> -	"hisilicon,kirin970-pcie"
> -- reg: Should contain rc_dbi, apb, config registers location and length.
> -- reg-names: Must include the following entries:
> -  "dbi": controller configuration registers;
> -  "apb": apb Ctrl register defined by Kirin;
> -  "config": PCIe configuration space registers.
> -
> -Optional properties:
> -
> -Example based on kirin960:
> -
> -	pcie@f4000000 {
> -		compatible = "hisilicon,kirin960-pcie";
> -		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> -		      <0x0 0xF4000000 0 0x2000>;
> -		reg-names = "dbi","apb", "config";
> -		bus-range = <0x0  0x1>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		device_type = "pci";
> -		ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
> -		num-lanes = <1>;
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0xf800 0 0 7>;
> -		interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
> -				<0x0 0 0 2 &gic 0 0 0  283 4>,
> -				<0x0 0 0 3 &gic 0 0 0  284 4>,
> -				<0x0 0 0 4 &gic 0 0 0  285 4>;
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b54bd9dd07ec..d5f53b2d3f9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14420,7 +14420,7 @@ M:	Xiaowei Song <songxiaowei@hisilicon.com>
>  M:	Binghui Wang <wangbinghui@hisilicon.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
> +F:	Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  F:	drivers/pci/controller/dwc/pcie-kirin.c
>  
>  PCIE DRIVER FOR HISILICON STB
> -- 
> 2.31.1
> 
> 
