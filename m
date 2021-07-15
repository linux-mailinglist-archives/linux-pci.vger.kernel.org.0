Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483783CA3E9
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhGOR0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 13:26:34 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:35641 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhGOR0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 13:26:33 -0400
Received: by mail-io1-f46.google.com with SMTP id d9so7356552ioo.2;
        Thu, 15 Jul 2021 10:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kf1evJp0mMw4X9FefVnWN29DSwILfIRDegyhezWiKMs=;
        b=erq8rXDY78o7xlo4SIHYyxi/8yoLbu7bZCNWQl9XVbQegcQ7UdzZgQuYQ54qXO+h8j
         sPHTLw6U10g+aeOGtwTnSNqNRhAY2Mndj6zYVUXqcEgUOTVG2m/ZbU7obMlgRGVYkmV2
         hYPzHJ9Q7ZVHV0lFy4XexCc2xNR7XUIWzw2t/XeTmL+DFadinTzdTGShDJuVHFE3juie
         shDTO4QAzvcj8HUgrtvRYRTOxdx2de33VbOf3MnaDtKfHFkuvoj7EGQ+7397Ii1ZpuPu
         nnnqnBrggj+9UlZihuTK9EraxhhyPQXQ6OktsoXr3YKb2uIo8jDO8DCtVJQa7ZhCMhud
         divA==
X-Gm-Message-State: AOAM530NwF2RTKFvSumTgLSfooRzzkb21ZFu/EeXXTNpcQR+Oji9LxSv
        ekAQBfkfXl5leOffyZ2noQ==
X-Google-Smtp-Source: ABdhPJxD+9lkUaw6EjbkEA9Dvv2T2gjP6OqfRxwcyBfzlcv8uV672bm/jA+nXHywZqBhpFtSa3btiA==
X-Received: by 2002:a02:9f8e:: with SMTP id a14mr4958548jam.55.1626369820252;
        Thu, 15 Jul 2021 10:23:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i5sm3490419ilc.16.2021.07.15.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:23:39 -0700 (PDT)
Received: (nullmailer pid 1277979 invoked by uid 1000);
        Thu, 15 Jul 2021 17:23:37 -0000
Date:   Thu, 15 Jul 2021 11:23:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: PCI: add snps,dw-pcie.yaml
Message-ID: <20210715172337.GA1263164@robh.at.kernel.org>
References: <cover.1626174242.git.mchehab+huawei@kernel.org>
 <0454d09414d74d9789213f5e7779002bcc024537.1626174242.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0454d09414d74d9789213f5e7779002bcc024537.1626174242.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 01:17:51PM +0200, Mauro Carvalho Chehab wrote:
> Currently, the designware schema is defined on a text file:
> 	designware-pcie.txt
> 
> Convert the pci-bus part into a schema.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 96 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> new file mode 100644
> index 000000000000..fd372d715ab4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/snps,dw-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare PCIe interface
> +
> +maintainers:
> +  - Jingoo Han <jingoohan1@gmail.com>
> +  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +
> +description: |
> +  Synopsys DesignWare PCIe host controller
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    anyOf:
> +      - {}
> +      - const: snps,dw-pcie
> +
> +  reg:
> +    description: |
> +      It should contain Data Bus Interface (dbi) and config registers for all
> +      versions.
> +      For designware core version >= 4.80, it may contain ATU address space.
> +    minItems: 2
> +    maxItems: 4
> +
> +  reg-names:
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      enum: [dbi, dbi2, config, atu, addr_space, app, elbi, mgmt]

Isn't 'config' only for host and 'addr_space' only for endpoint?

> +
> +  num-lanes:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: |
> +      number of lanes to use (this property should be specified unless
> +      the link is brought already up in BIOS)
> +    maximum: 16
> +
> +  reset-gpio:
> +    description: GPIO pin number of PERST# signal
> +    maxItems: 1
> +    deprecated: true
> +
> +  reset-gpios:
> +    description: GPIO controlled connection to PERST# signal
> +    maxItems: 1
> +
> +  snps,enable-cdm-check:
> +    type: boolean
> +    description: |
> +      This is a boolean property and if present enables
> +      automatic checking of CDM (Configuration Dependent Module) registers
> +      for data corruption. CDM registers include standard PCIe configuration
> +      space registers, Port Logic registers, DMA and iATU (internal Address
> +      Translation Unit) registers.
> +
> +  num-viewport:
> +    description: |
> +      number of view ports configured in hardware. If a platform
> +      does not specify it, the driver autodetects it.
> +    deprecated: true
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - reg
> +  - reg-names
> +  - compatible
> +
> +examples:
> +  - |
> +    bus {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      pcie@dfc00000 {
> +        device_type = "pci";
> +        compatible = "snps,dw-pcie";
> +        reg = <0xdfc00000 0x0001000>, /* IP registers */
> +              <0xd0000000 0x0002000>; /* Configuration space */
> +        reg-names = "dbi", "config";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
> +                 <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> +        interrupts = <25>, <24>;

Not documented.

> +        #interrupt-cells = <1>;

Not documented.

> +        num-lanes = <1>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4529cf5ed430..f0115c590731 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14283,6 +14283,7 @@ M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
> +F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>  F:	drivers/pci/controller/dwc/*designware*
>  
>  PCI DRIVER FOR TI DRA7XX/J721E
> -- 
> 2.31.1
> 
> 
