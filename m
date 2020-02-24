Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A1916AA0A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 16:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBXP0w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 10:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgBXP0w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 10:26:52 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7B220828;
        Mon, 24 Feb 2020 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582558011;
        bh=8N5QNPLpkgzq3RYMZ3/aBwBH9betmd6dohxLwvdK3p0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z5MuclNp7MYxT5IBCI2G2sQzYvDTngaP6kghRjsNtUzkhhlI48hatsq9uMcvhVZ1p
         10oI5hji875cQGXpy4YncTWGvb3G0yug8uKfvBJxxcmWe96/ifD+7r00c8N9fGetZJ
         ZoqURztkwjfv/fenCABp992VuHUEKgzzxJ0xVWvM=
Received: by mail-qt1-f179.google.com with SMTP id i23so6783694qtr.5;
        Mon, 24 Feb 2020 07:26:51 -0800 (PST)
X-Gm-Message-State: APjAAAW6rA3R3J46m9WnqgawQllvhTjkWHivOYtSmKe9OpPo4dqf8Owg
        MomGSxWf0LkJpOTORGhMIzC0As2FTMPUktF38g==
X-Google-Smtp-Source: APXvYqwycJnlUss4EYMa12eUzhhIhR27BPGX4l1gt+HbU1ugfbjsQcwgjLaS7LQEn4iYWXtThxlL8gmlHYkAs+wteKg=
X-Received: by 2002:ac8:59:: with SMTP id i25mr49052121qtg.110.1582558010446;
 Mon, 24 Feb 2020 07:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20200217111519.29163-1-kishon@ti.com> <20200217111519.29163-3-kishon@ti.com>
 <20200219203205.GA14068@bogus> <2b927c66-d640-fb11-878a-c69a459a28f8@ti.com>
In-Reply-To: <2b927c66-d640-fb11-878a-c69a459a28f8@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Feb 2020 09:26:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYScxGySy8xaN-UB6URfw8K_jSiuSXwVoTU9-RdJecww@mail.gmail.com>
Message-ID: <CAL_JsqLYScxGySy8xaN-UB6URfw8K_jSiuSXwVoTU9-RdJecww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: Convert PCIe Host/Endpoint in
 Cadence platform to DT schema
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 4:14 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 20/02/20 2:02 am, Rob Herring wrote:
> > On Mon, Feb 17, 2020 at 04:45:19PM +0530, Kishon Vijay Abraham I wrote:
> >> Include Cadence core DT schema and define the Cadence platform DT schema
> >> for both Host and Endpoint mode. Note: The Cadence core DT schema could
> >> be included for other platforms using Cadence PCIe core.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
> >>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 48 ++++++++++++
> >>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
> >>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
> >>  MAINTAINERS                                   |  2 +-
> >>  5 files changed, 125 insertions(+), 94 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> >>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> >>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> >>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >
> >
> >> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >> new file mode 100644
> >> index 000000000000..2f605297f862
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >> @@ -0,0 +1,76 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/pci/cdns,cdns-pcie-host.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Cadence PCIe host controller
> >> +
> >> +maintainers:
> >> +  - Tom Joseph <tjoseph@cadence.com>
> >> +
> >> +allOf:
> >> +  - $ref: /schemas/pci/pci-bus.yaml#
> >> +  - $ref: "cdns-pcie-host.yaml#"
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: cdns,cdns-pcie-host
> >> +
> >> +  reg:
> >> +    maxItems: 3
> >> +
> >> +  reg-names:
> >> +    items:
> >> +      - const: reg
> >> +      - const: cfg
> >> +      - const: mem
> >> +
> >> +  msi-parent: true
> >> +
> >> +required:
> >> +  - reg
> >> +  - reg-names
> >> +
> >> +examples:
> >> +  - |
> >> +    bus {
> >> +        #address-cells = <2>;
> >> +        #size-cells = <2>;
> >> +
> >> +        pcie@fb000000 {
> >> +            compatible = "cdns,cdns-pcie-host";
> >> +            device_type = "pci";
> >> +            #address-cells = <3>;
> >> +            #size-cells = <2>;
> >> +            bus-range = <0x0 0xff>;
> >> +            linux,pci-domain = <0>;
> >> +            cdns,max-outbound-regions = <16>;
> >> +            cdns,no-bar-match-nbits = <32>;
> >
> >> +            vendor-id = /bits/ 16 <0x17cd>;
> >> +            device-id = /bits/ 16 <0x0200>;
> >
> > Please make these 32-bit as that is what the spec says.
>
> Can you clarify this is mentioned in which spec? PCI spec has both of
> these 16 bits and I checked the PCI binding doc but couldn't spot the
> size of these fields.
>
> [1] -> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

Section 4.1.2.1. The key point is the type is 'encode-int' which means
32-bit. Keep in mind, that 16-bits was not a defined type when this
spec was written. We added that for FDT.

Also, look at other instances of reading 'vendor-id' in the kernel.

Rob
