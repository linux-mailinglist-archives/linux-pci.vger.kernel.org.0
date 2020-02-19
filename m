Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53BC164FEC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSUcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 15:32:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35322 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUcI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 15:32:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so25195956oie.2;
        Wed, 19 Feb 2020 12:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jt/ZzcjOheKJCVMsRBEe0Y481qhnTtTvnzWC5rkuAk=;
        b=m6lR/LxGd0loyKR4haTY8csO6IDl9eCqEJCVn+OkbFApVIg+fC4k8wbee9sAAkGA4h
         wy2Q9/NfDPlctjarUADb8SdaDJcneqvIGvGxGxYaUaQ/67UbUrtlw5OqQJzzYjtAYrRy
         Px/sfG3MOF7e3UJId3kY50W1ZfZHPiWvt0JKA+OL/Ga5Rl7UwYf0M0XXELu4NENN/w0J
         sOXEay51bcA2bkKqgNYwS6SJiB/twDBmc/uTZTogdMlV+DOSgJ9G1ypRmhqNmI3RCBc5
         750cgEctsL4uYDkPGyjsdUgBF3p6uXrJSwrHJsBMWpz/g+NH/N0911wpaKoKYOGibHg3
         aIIQ==
X-Gm-Message-State: APjAAAVYs00cBdvLHlwzv9tCqSfEV7KDeWf5sMXsbCNdR1E2PQM0CuDn
        fWflxtIGUUOMCSKwaeNXUA==
X-Google-Smtp-Source: APXvYqyui6Qd/+Vh+bwUOgDyJrIxaU7VHbbv1A8fmWcxfPN+qZqp9/uJH+Sc07nwV/0kUr0BIOLEiQ==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr5542263oiz.120.1582144327187;
        Wed, 19 Feb 2020 12:32:07 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g5sm290207otp.10.2020.02.19.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:32:06 -0800 (PST)
Received: (nullmailer pid 20753 invoked by uid 1000);
        Wed, 19 Feb 2020 20:32:05 -0000
Date:   Wed, 19 Feb 2020 14:32:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: Convert PCIe Host/Endpoint in
 Cadence platform to DT schema
Message-ID: <20200219203205.GA14068@bogus>
References: <20200217111519.29163-1-kishon@ti.com>
 <20200217111519.29163-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217111519.29163-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 17, 2020 at 04:45:19PM +0530, Kishon Vijay Abraham I wrote:
> Include Cadence core DT schema and define the Cadence platform DT schema
> for both Host and Endpoint mode. Note: The Cadence core DT schema could
> be included for other platforms using Cadence PCIe core.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 48 ++++++++++++
>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  5 files changed, 125 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml


> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> new file mode 100644
> index 000000000000..2f605297f862
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/cdns,cdns-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence PCIe host controller
> +
> +maintainers:
> +  - Tom Joseph <tjoseph@cadence.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: "cdns-pcie-host.yaml#"
> +
> +properties:
> +  compatible:
> +    const: cdns,cdns-pcie-host
> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: cfg
> +      - const: mem
> +
> +  msi-parent: true
> +
> +required:
> +  - reg
> +  - reg-names
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@fb000000 {
> +            compatible = "cdns,cdns-pcie-host";
> +            device_type = "pci";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x0 0xff>;
> +            linux,pci-domain = <0>;
> +            cdns,max-outbound-regions = <16>;
> +            cdns,no-bar-match-nbits = <32>;

> +            vendor-id = /bits/ 16 <0x17cd>;
> +            device-id = /bits/ 16 <0x0200>;

Please make these 32-bit as that is what the spec says.

> +
> +            reg = <0x0 0xfb000000  0x0 0x01000000>,
> +                  <0x0 0x41000000  0x0 0x00001000>,
> +                  <0x0 0x40000000  0x0 0x04000000>;
> +            reg-names = "reg", "cfg", "mem";
> +
> +            ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
> +                     <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
> +
> +            #interrupt-cells = <0x1>;
> +
> +            interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1>,
> +                 <0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1>,
> +                 <0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1>,
> +                 <0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
> +
> +            interrupt-map-mask = <0x0 0x0 0x0  0x7>;
> +
> +            msi-parent = <&its_pci>;
> +
> +            phys = <&pcie_phy0>;
> +            phy-names = "pcie-phy";
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38fe2f3f7b6f..e0402e001edd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12739,7 +12739,7 @@ PCI DRIVER FOR CADENCE PCIE IP
>  M:	Tom Joseph <tjoseph@cadence.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/cdns,*.txt
> +F:	Documentation/devicetree/bindings/pci/cdns,*
>  F:	drivers/pci/controller/pcie-cadence*
>  
>  PCI DRIVER FOR FREESCALE LAYERSCAPE
> -- 
> 2.17.1
> 
