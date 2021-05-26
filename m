Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815D8391CA5
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhEZQGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233593AbhEZQGl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 12:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28770613B9;
        Wed, 26 May 2021 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622045110;
        bh=uYJjN7xB0FXI63Ro7dOj439Kdyus8vjfWCTStMVab1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sOj2ZCRlI8FbGQ/cY2Gj+jxxH6wx4c5vf4uoYmQYqAOZMU5L6X0DmD/OfZaahLp2v
         yibEyyBA14mroKLeXftIF38fUZ6UZ8Od/FKkIiulS+npqXu3eGq4QC97xBtJ1ZL1tk
         EFbQvQFY40CEKjqJapS82XS1H1MaSHvQexKEehHY8CPlRP0zlEY49xjdk+KrViIV/9
         +4vUlyWUoUsf1gAk45F04Fp4S7rArTG/wJ1C9/rLbWGw80B0bvtDsBYdtVkfRSVVLE
         LqhTyVAAvuhZDdGhWIE13NYuW/vZ93nq2E7mIMhWMCD6Q0EB9F23AyCyQMOv3SmDkX
         F9VmoZxnJHhDg==
Received: by mail-ej1-f54.google.com with SMTP id jt22so3283769ejb.7;
        Wed, 26 May 2021 09:05:10 -0700 (PDT)
X-Gm-Message-State: AOAM532nAmzctbyD3yPJozOo3q/cTYBzNFI2/59HhTH+7Zm05DEMZqxP
        uXKwqW08WmeQo6EJotinRc9KgZ+WZeD0Um/C0w==
X-Google-Smtp-Source: ABdhPJzFG2Z0vSdtgJr3rMjrWewRzotRZARdBVPmtJ4gyUPXO8LbQcnfSVZIHCVRTg29pGODhbB5m4JDgR8anbTtOnc=
X-Received: by 2002:a17:907:78cd:: with SMTP id kv13mr33811865ejc.360.1622045108736;
 Wed, 26 May 2021 09:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210526134708.27887-1-kishon@ti.com> <20210526140902.lnk5du5k3b4sny3m@handheld>
In-Reply-To: <20210526140902.lnk5du5k3b4sny3m@handheld>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 May 2021 11:04:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+7AD4WXggRrVVb=HKVmuomda3KVXuC1mcjYwbgnWRUkg@mail.gmail.com>
Message-ID: <CAL_Jsq+7AD4WXggRrVVb=HKVmuomda3KVXuC1mcjYwbgnWRUkg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint
 mode dt-bindings to YAML
To:     Nishanth Menon <nm@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 9:09 AM Nishanth Menon <nm@ti.com> wrote:
>
> On 19:17-20210526, Kishon Vijay Abraham I wrote:
> > Convert PCIe host/endpoint mode dt-bindings for TI's AM65/Keystone SoC
> > to YAML binding.
> >
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> [...]
> > diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> > new file mode 100644
> > index 000000000000..419d48528105
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/pci/ti,am65-pci-ep.yaml#"
>
> drop the '"'?

Yes, though we haven't been consistent here...

> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>
> drop the '"'?
> > +
> > +title: TI AM65 PCI Endpoint
> > +
> > +maintainers:
> > +  - Kishon Vijay Abraham I <kishon@ti.com>
> > +
> > +allOf:
> > +  - $ref: "pci-ep.yaml#"
>
> drop the '"' ?
>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,am654-pcie-ep
> > +
> > +  reg:
> > +    maxItems: 4
> > +
> > +  reg-names:
> > +    items:
> > +      - const: app
> > +      - const: dbics
> > +      - const: addr_space
> > +      - const: atu
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ti,syscon-pcie-mode:
> > +    description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  interrupts:
> > +    minItems: 1
> > +
> > +  dma-coherent: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - max-link-speed
> > +  - power-domains
> > +  - ti,syscon-pcie-mode
> > +  - dma-coherent
> > +
> > +unevaluatedProperties: false
>
> Is it possible to lock this down further with additionalProperties: false?

unevaluatedProperties is what we want here.

> I could add some ridiculous property like system-controller; to the
> example and the checks wont catch it.

Yes, because unevaluatedProperties is currently unimplemented. Once
the upstream jsonschema tool supports it[1], there will be warnings.
The other way we could address this is there are $ref resolving tools
that flatten schemas.

Rob

[1] https://github.com/Julian/jsonschema/issues/613#issuecomment-636026577
