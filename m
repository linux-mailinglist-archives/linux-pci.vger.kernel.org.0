Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC5198059
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgC3QBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 12:01:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38631 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgC3QBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 12:01:45 -0400
Received: by mail-il1-f193.google.com with SMTP id n13so8976310ilm.5;
        Mon, 30 Mar 2020 09:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktt/Ga61qSWOmRmSZ17FaWn00l58rTu6NHlMsu22H60=;
        b=SL/pteOzgd23ELhY5Tq0U1+NcyQXpwCnvfn3j5iX34qqa4ffj9GXzgVArRyli8ljTy
         vDjycy1imRIIlv/awls9F0XF4dCKSpUD/HK3spvT64+37Leu/TvLFmKEHpnmu30/e826
         Tp5cEDYzcEjDOui0UqjfEx14dC6uhnKXAL1vp0tIpjAthZQ7ZOJWb5LTz5BV8ewJa8es
         XhuL7SlwcuHxZ6THbqw1F8vwh1rWzDqOKeRmUJnE+GWV5m6s3oILBOGaZfbTXpoC5nFc
         EKpiIvDqcgQiRztgWM44I+EnJLazIdPcowkpCLdE9BM9BrziVSiBP9W4ZP4wwSGzZ5sv
         XnfQ==
X-Gm-Message-State: ANhLgQ0y87DW3HcwezWUDteW85qt69+0qfaxptvIY6YhpiNVdgiTytxf
        5UNyjs46TGoRMGDt4O/lKQ==
X-Google-Smtp-Source: ADFU+vuHJfjdltL5wlWlRwIkMluIpN1VyD7AySpoFLGDLUOGl3dNS864QY56ABH3/8lhbGCyhvlP3w==
X-Received: by 2002:a92:3b56:: with SMTP id i83mr11919046ila.75.1585584104462;
        Mon, 30 Mar 2020 09:01:44 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i6sm5015642ila.20.2020.03.30.09.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:01:43 -0700 (PDT)
Received: (nullmailer pid 24386 invoked by uid 1000);
        Mon, 30 Mar 2020 16:01:42 -0000
Date:   Mon, 30 Mar 2020 10:01:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cadence: Deprecate
 inbound/outbound specific bindings
Message-ID: <20200330160142.GA6259@bogus>
References: <20200327104727.4708-1-kishon@ti.com>
 <20200327104727.4708-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327104727.4708-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 27, 2020 at 04:17:25PM +0530, Kishon Vijay Abraham I wrote:
> Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits for
> host mode as both these could be derived from "ranges" and "dma-ranges"
> property. "cdns,max-outbound-regions" property would still be required
> for EP mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
>  .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
>  5 files changed, 37 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> index 2996f8d4777c..50ce5d79d2c7 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Tom Joseph <tjoseph@cadence.com>
>  
>  allOf:
> -  - $ref: "cdns-pcie.yaml#"
> +  - $ref: "cdns-pcie-ep.yaml#"
>    - $ref: "pci-ep.yaml#"
>  
>  properties:
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> index cabbe46ff578..84a8f095d031 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> @@ -45,8 +45,6 @@ examples:
>              #size-cells = <2>;
>              bus-range = <0x0 0xff>;
>              linux,pci-domain = <0>;
> -            cdns,max-outbound-regions = <16>;
> -            cdns,no-bar-match-nbits = <32>;
>              vendor-id = <0x17cd>;
>              device-id = <0x0200>;
>  
> @@ -57,6 +55,7 @@ examples:
>  
>              ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
>                       <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
> +            dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
>  
>              #interrupt-cells = <0x1>;
>  
> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> new file mode 100644
> index 000000000000..6150a7a7bdbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence PCIe Device
> +
> +maintainers:
> +  - Tom Joseph <tjoseph@cadence.com>
> +
> +allOf:
> +  - $ref: "cdns-pcie.yaml#"
> +
> +properties:
> +  cdns,max-outbound-regions:
> +    description: maximum number of outbound regions
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32
> +    default: 32

I have a feeling that as the PCI endpoint binding evolves this won't be 
necessary. I can see a common need to define the number of BARs for an 
endpoint and then this will again just be error checking.

What's the result if you write to a non-existent region in register 
CDNS_PCIE_AT_OB_REGION_PCI_ADDR0/1? If the register is non-existent and 
doesn't abort, you could detect this instead.

Rob
