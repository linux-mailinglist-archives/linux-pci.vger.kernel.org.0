Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2C365999
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 15:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDTNOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 09:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhDTNOU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 09:14:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB21613C3;
        Tue, 20 Apr 2021 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618924428;
        bh=5ngbTZUuRjFnbOZ5YDzcHl+LD9EANqvUFI4zXthVZ3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gz/e+o12WxLzV3ekArfmfo20J6qj9dTLaUY7ZAg9u1OIEnukYqc1aVsHHI1iQAial
         ankcIIu9pN7y/rdVRjeGM15yDzPl8KS+yS9IKmPy2DwHMiexBerA755IlnTX48DlPq
         2UjytdFvLT50E37InemU1Tu22R/7YkV3NIzF3ECpC51idKLDWOCt6qtpzza4OfTSpk
         v7MVDHBS+ObZj1zgVF+IcNM8QeC+T37Q5HzLa6TkZTMzpY8eWVyLE7iyOmNxDlBXi1
         AvDg3kzJXs26eovH0qTnGOrpkxZc8j+6TSeiLV3mM/O8by7LXLhOkPAKGm8VL/Ffro
         gj/zsalLiNdQQ==
Received: by mail-qk1-f175.google.com with SMTP id t17so10731737qkg.4;
        Tue, 20 Apr 2021 06:13:48 -0700 (PDT)
X-Gm-Message-State: AOAM53158r6agaca+BqPW276xAIaRBZuzR6bQmvjesiUO9gz25s+WZ29
        9EhqdUTT/IStDzEKte/vULYQQHdu8Lndsdgd5Q==
X-Google-Smtp-Source: ABdhPJwjtWC1cE3ElIyzvn6w+ghuEwSU5cAamZB/FX4d8iNqmT6pm4fi4UvG2KW0N9SXxdsqQeBiuQpdEII07+6JSdE=
X-Received: by 2002:a05:620a:1409:: with SMTP id d9mr814132qkj.464.1618924427919;
 Tue, 20 Apr 2021 06:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210325090026.8843-1-kishon@ti.com> <20210325090026.8843-2-kishon@ti.com>
 <20210325233812.GA1943834@robh.at.kernel.org> <985bd950-7bdf-d9b5-0a89-c05a56739c68@ti.com>
In-Reply-To: <985bd950-7bdf-d9b5-0a89-c05a56739c68@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Apr 2021 08:13:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+LLLxOgb_cXNKSzYToWArnPESHDRKjaezn1bh2yBMFA@mail.gmail.com>
Message-ID: <CAL_JsqJ+LLLxOgb_cXNKSzYToWArnPESHDRKjaezn1bh2yBMFA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: PCI: ti,am65: Add PCIe host mode
 dt-bindings for TI's AM65 SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 30, 2021 at 4:29 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 26/03/21 5:08 am, Rob Herring wrote:
> > On Thu, Mar 25, 2021 at 02:30:21PM +0530, Kishon Vijay Abraham I wrote:
> >> Add PCIe host mode dt-bindings for TI's AM65 SoC.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++++++++++++++
> >>  1 file changed, 111 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> >> new file mode 100644
> >> index 000000000000..b77e492886fa
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> >> @@ -0,0 +1,111 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: TI AM65 PCI Host
> >> +
> >> +maintainers:
> >> +  - Kishon Vijay Abraham I <kishon@ti.com>
> >> +
> >> +allOf:
> >> +  - $ref: /schemas/pci/pci-bus.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - ti,am654-pcie-rc
> >> +
> >> +  reg:
> >> +    maxItems: 4
> >> +
> >> +  reg-names:
> >> +    items:
> >> +      - const: app
> >> +      - const: dbics
> >
> > Please use 'dbi' like everyone else if this isn't shared with the other
> > TI DW PCI bindings.
>
> I'm just converting existing binding in pci-keystone.txt to yaml.
> Documentation/devicetree/bindings/pci/pci-keystone.txt
>
> Device tree for AM65 is also already in the upstream kernel.
>
> I can try to remove the am65 specific part from pci-keystone.txt

Can you remove pci-keystone.txt entirely. That's what 'converting' means.

Rob
