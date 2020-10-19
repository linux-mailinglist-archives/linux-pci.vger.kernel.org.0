Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7ED29258A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgJSKTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 06:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgJSKTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 06:19:13 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8023C2225A;
        Mon, 19 Oct 2020 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603102751;
        bh=9ol2BO/fELkAmNUDWpBODVH2SpWv/piQGMjT5MYog5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o725qncPvt2aQQVrR+pZKJJSPCc5JTp6uGiZm/LhIBFBycVETVEIw1yJ2Ng0K1jgb
         Zc/a2MBJn9KI5y5OuTzb7CXsJj33DDhJl//dfsRyJZDAZurX93QBBHdIbcfjSlny9D
         EUCuuuPyyiKzjg/47uNt3/FrnTZQxpRuUS8584SE=
Received: by mail-ej1-f44.google.com with SMTP id qp15so13122701ejb.3;
        Mon, 19 Oct 2020 03:19:11 -0700 (PDT)
X-Gm-Message-State: AOAM533AHy9eKIFSpFLlQaIcPYIqYPFh2X+xkTbfcxGNv/9x1VHhfZlr
        vFyNRNKQ6V1ZbTTccHSLt7jECkqTHcvQaVu4Fbc=
X-Google-Smtp-Source: ABdhPJwavZy+EEcdbCdWEY/sitMYjxth1cT0VbGrluAs9SydNvzA5wXj6kcEfurdExdip/Bi9Tdcm1TK35qAcuPN1Qc=
X-Received: by 2002:a17:906:f151:: with SMTP id gw17mr16187128ejb.119.1603102749944;
 Mon, 19 Oct 2020 03:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
 <20201019094715.15343-3-m.szyprowski@samsung.com> <20201019101233.GB51073@kozik-lap>
In-Reply-To: <20201019101233.GB51073@kozik-lap>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 19 Oct 2020 12:18:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcyruYQxcioPxGE8J8jS0Yey+09HpXxFgQm4f2w98s5cg@mail.gmail.com>
Message-ID: <CAJKOXPcyruYQxcioPxGE8J8jS0Yey+09HpXxFgQm4f2w98s5cg@mail.gmail.com>
Subject: Re: [PATCH 2/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie binding
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Oct 2020 at 12:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Oct 19, 2020 at 11:47:11AM +0200, Marek Szyprowski wrote:
> > From: Jaehoon Chung <jh80.chung@samsung.com>
> >
> > Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> > variant).
>
> The title has typo and actually entire "Doc" should be dropped. Just
> "dt-bindings: pci:".  This applies to all DT patches.
>
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
> >          rewrote commit message]
>
> If you wrote them in YAML it should be a new patch of yours. It is the
> same then as converting TXT to YAML.
>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  .../bindings/pci/samsung,exynos-pcie.yaml     | 106 ++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > new file mode 100644
> > index 000000000000..48fb569c238c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung SoC series PCIe Host Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Jaehoon Chung <jh80.chung@samsung.com>
> > +
> > +description: |+
> > +  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
> > +  PCIe IP and thus inherits all the common properties defined in
> > +  designware-pcie.txt.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - samsung,exynos5433-pcie
>
> const, not enum
>
> > +
> > +  reg:
> > +    items:
> > +      - description: External Local Bus interface (ELBI) registers.
> > +      - description: Data Bus Interface (DBI) registers.
> > +      - description: PCIe configuration space region.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: elbi
> > +      - const: bdi
> > +      - const: config
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: PCIe bridge clock
> > +      - description: PCIe bus clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pcie
> > +      - const: pcie_bus
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: pcie-phy
> > +
> > +  vdd10-supply:
> > +    description:
> > +      Phandle to a regulator that provides 1.0V power to the PCIe block.
> > +
> > +  vdd18-supply:
> > +    description:
> > +      Phandle to a regulator that provides 1.8V power to the PCIe block.
> > +
> > +required:
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - clock-names
> > +  - phys
> > +  - phy-names
> > +  - vdd10-supply
>
> additionalProperties: false

This can be unevaluatedProperties, since you include pci-bus schema.
However still you should either include designware schema or include
it's properties here.

Best regards,
Krzysztof
