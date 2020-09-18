Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22B26F4A6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 05:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIRDSd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 23:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIRDSd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 23:18:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD454C06174A;
        Thu, 17 Sep 2020 20:18:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so6130641eja.3;
        Thu, 17 Sep 2020 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6PnPj4Sw4zuNKtUjGj8+UjzMcuXjg8lWfZXTOiE9Qg=;
        b=QPBnvPFkQPq5DeZstFRhQhGfZuJXS3IGMDaeKIjYkpYAA1T5g68eZvVcPOQIKJ86kU
         V0Pe7vIW7L3LOZLh511TZtEOkCEbW7UBlR5BTjTO7FmCC21KinefShrvnE3btUEMediR
         SS/HdkuTVrOm1LWX5lIWFb71CoAmPZRHI/EhC6wjMArDMDfAY/Y4EhlTZiRg4VRmKoAr
         /xMXYA2pTMI12dRDTnfvMWdUJcMe2ZjH+oAJdn/Sv/IX26BX1KPqQ130fIC4HmoJkyZU
         VscLC33+6NIAqCuleuNHIcdTvg3cwAUKl+aUDJEJbPpjD8lzA5aRyOPPRDO5MmQ38iNR
         IItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6PnPj4Sw4zuNKtUjGj8+UjzMcuXjg8lWfZXTOiE9Qg=;
        b=EO9WjzLdRssuIy3HEZIQTUJ7akx1dlEthoYEMkvWv/8jYyxA9oC4ooEbBU9s02fqI/
         alg9nX7ZyyAEgLYcHO44V8vpKRC90m+5D7rWXRkqAJmpxJc1dIzdH+T/AJqx3tpVtyfv
         /ZQvd0O6eshWSvFdNzaZppKL0ungY1Ok5OX/CSDYsCThF5GBU6ChsktF/6B2eyE9FPeB
         Jy3OaRjC/XlC7+RXi3+XKGU4qoycN2qEy0JArbeyBRmfb0N0p4hbACFIoimw/pOQYftB
         13VJBuY26o+EkI2aogE/+TD0P90A1UjNvFFpEfGzlveYli0ZNLGGn/lnD0GNIDvbQFil
         O1Hg==
X-Gm-Message-State: AOAM532kHOuYhd9F5h2t75lnx9BDNXzBYZQqNAMSxiS1z1bOA761JkDG
        K8eqBP3A70x2+ERPvtqiV/B9DLR/LgjnbTBJND8=
X-Google-Smtp-Source: ABdhPJzn5xjNPEmrRqG86NPTPRnCb7XHzWPcl3KJ4FUWp/Xzi6Xh4bJ/4bULiv7vpRQGPYCRWgxVF2J7NwVsylUypzg=
X-Received: by 2002:a17:906:1b58:: with SMTP id p24mr35251625ejg.77.1600399111121;
 Thu, 17 Sep 2020 20:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
 <1599644912-29245-2-git-send-email-wuht06@gmail.com> <20200915172501.GA2146778@bogus>
In-Reply-To: <20200915172501.GA2146778@bogus>
From:   Hongtao Wu <wuht06@gmail.com>
Date:   Fri, 18 Sep 2020 11:18:19 +0800
Message-ID: <CAG_R4_Xv86KE3NQtYEq-3mJjMucrULLVA0=JUkWAVDJPjucKKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC
 host controller
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 1:25 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 09, 2020 at 05:48:31PM +0800, Hongtao Wu wrote:
> > From: Hongtao Wu <billows.wu@unisoc.com>
> >
> > This series adds PCIe bindings for Unisoc SoCs.
> > This controller is based on DesignWare PCIe IP.
> >
> > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > ---
> >  .../devicetree/bindings/pci/sprd-pcie.yaml         | 101 +++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> > new file mode 100644
> > index 0000000..c52edfb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/sprd-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SoC PCIe Host Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Hongtao Wu <billows.wu@unisoc.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sprd,pcie-rc
> > +
> > +  reg:
> > +    minItems: 2
> > +    items:
> > +      - description: Controller control and status registers.
> > +      - description: PCIe configuration registers.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: config
> > +
> > +  ranges:
> > +    maxItems: 2
> > +
> > +  num-lanes:
> > +    maximum: 1
> > +    description: Number of lanes to use for this port.
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    description: Builtin MSI controller and PCIe host controller.
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: msi
> > +
> > +  sprd-pcie-poweron-syscons:
>

I am Sorry!
I'll fix it.

> Doesn't match the example.
>
> > +    minItems: 1
> > +    description: Global register.
> > +      The first value is the phandle to the global registers required to
> > +      confige PCIe phy, clock and so on.
> > +      The second value is the global register type which indicates whether it
> > +      is a set/clear register or not.
> > +      The third value is the time to delay after the global register is set or
> > +      cleared.
> > +      The fourth value is the global register address.
> > +      The fifth value is the the mask value that the global register must
> > +      be operate.
> > +      The sixth value is the value that will be set to the global register.
> > +      Note that Some Unisoc global registers have not been upstreamed.
> > +      The global register and its mask can't be found in linux kernel,
> > +      so we use an offset address and a number to instead them.
>
> From the example, it looks like you set/clear 2 bits for power on/off.
> What's the worst case you expect here? What do the 2 bits do? If they
> are for clocks, resets, or power domains, then we have bindings for
> those which should be used. This use of phandles to syscons should be
> avoided whenever possible.
>

There are two kinds of global register ( set/clear registers and
non-set/clear registers )
about PCIe on Unisoc SoCs.
Each set of set/clear registers contain two addresses. One can be
written and the other one
can be read. Different bits in  the set/clear register indicate
different functions, so we
set/clear one bit for power on/off.
The non-set/clear registers are normal which only have one address.

The second value in property 'sprd,pcie-poweron-syscons' is a flag
which indicates whether
the global register is set/clear or not. If this value is 1, we think
that it's a set/clear register.
If this value is 0, we think it's a non-set/clear register.

I wanted to parse all of the global registers about power on/off in an
array (include set/clear
registers and non-set/clear registers). However, it may not be a good idea.
I'll split the property 'sprd,pcie-poweron-syscons' info clocks, power
domains, phy and so on
in the next version.

> If we wanted a language for specifying sequences of register accesses in
> DT, we would have defined that a long time ago.
>

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - num-lanes
> > +  - ranges
> > +  - interrupts
> > +  - interrupt-names
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    ipa {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pcie0: pcie@2b100000 {
> > +            compatible = "sprd,pcie-rc";
> > +            reg = <0x0 0x2b100000 0x0 0x2000>,
> > +                  <0x2 0x00000000 0x0 0x2000>;
> > +            reg-names = "dbi", "config";
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            ranges = <0x01000000 0x0 0x00000000 0x2 0x00002000 0x0 0x00010000>,
> > +                     <0x03000000 0x0 0x10000000 0x2 0x10000000 0x1 0xefffffff>;
> > +            num-lanes = <1>;
> > +            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "msi";
> > +
> > +            sprd,pcie-poweron-syscons =
> > +                <&ap_ipa_ahb_regs 0 0 0x0000 0x40 0x40>,
> > +                <&ap_ipa_ahb_regs 0 0 0x0000 0x20 0x20>;
> > +            sprd,pcie-poweroff-syscons =
>
> Not documented.
>

Thanks! I'll fix it in the next version.

> > +                <&ap_ipa_ahb_regs 0 0 0x0000 0x20 0x0>,
> > +                <&ap_ipa_ahb_regs 0 0 0x0000 0x40 0x0>;
> > +        };
> > +    };
> > --
> > 2.7.4
> >
