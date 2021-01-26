Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1D3040D9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405975AbhAZOtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 09:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391343AbhAZOte (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 09:49:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0200C23101;
        Tue, 26 Jan 2021 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611672533;
        bh=G/T0jPwLGg8lM5WaMFH8R28YFCg05xkzcrFyW7ZCPQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dq6nQ9AVkEDX3HsZpsZJN7dp/GBweFeek9jOCUXcVoW64SJkJHIJaBP8fafURMFip
         rOov4+9+g8wMzfS08IOKRplGuXsREEwhwwVgrp+GP3nkiH3T8TpC3cHqIpHy3uZZnY
         HgN6larYeLzTtYBHgzldyKL1vADTENCi0EokpjUElcUn5l0So6KRruefXxQVoqI9ce
         yAVZTHZK1jVqYoGTBU4MpvENU14eUnQ0YS4r8HG1hmdCBDvUSxjLGDNZJjC1AZeB1z
         Jt6iOtz1zT2nXiDPooQI/wESx8jwsZ9iPUfKfwxLEwzQLUZ+J2MUzhfKMKdk7xkkPg
         eyO3A2n7WiIXQ==
Received: by mail-ej1-f49.google.com with SMTP id ke15so23269935ejc.12;
        Tue, 26 Jan 2021 06:48:52 -0800 (PST)
X-Gm-Message-State: AOAM533lSga2MxUa6M4Sr0WCFjB6eZhov5QiuZq03hdvnn6pkd6ljRxr
        sdEzsov8l7BurKbFBAq+eilQ659c5b2Qmb6Jvg==
X-Google-Smtp-Source: ABdhPJz5uL45LCjYMSeSUuhgl7Xo+mvSzco3ZHqNBiKXImdAUCiZ6mpo5aHUEBCt7/kYu2Qj402kAGhAxp2DUZ4ZcOs=
X-Received: by 2002:a17:906:a94:: with SMTP id y20mr3484816ejf.525.1611672531542;
 Tue, 26 Jan 2021 06:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20210125024824.634583-1-xxm@rock-chips.com> <20210125152632.GA381616@robh.at.kernel.org>
 <e22ea1ed-9b3b-98ae-5b78-6c3c10af3589@rock-chips.com>
In-Reply-To: <e22ea1ed-9b3b-98ae-5b78-6c3c10af3589@rock-chips.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Jan 2021 08:48:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLEmCFP5D1SN-BuOC=ZNsA216RMLT-aAN4Bqst7Kb=TQ@mail.gmail.com>
Message-ID: <CAL_JsqJLEmCFP5D1SN-BuOC=ZNsA216RMLT-aAN4Bqst7Kb=TQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxLzJdIGR0LWJpbmRpbmdzOiByb2NrY2hpcDogQWRkIERlc2lnbg==?=
        =?UTF-8?B?V2FyZSBiYXNlZCBQQ0llIGNvbnRyb2xsZXLjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFyb2JoZXJyaW5n?=
        =?UTF-8?B?MkBnbWFpbC5jb23ku6Plj5HjgJE=?=
To:     xxm <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 8:44 PM xxm <xxm@rock-chips.com> wrote:
>
> Hi Rob,
>
> Thanks for reply.
>
> =E5=9C=A8 2021/1/25 23:26, Rob Herring =E5=86=99=E9=81=93:
> > On Mon, Jan 25, 2021 at 10:48:24AM +0800, Simon Xue wrote:
> >> Document DT bindings for PCIe controller found on Rockchip SoC.
> >>
> >> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> >> ---
> >>   .../bindings/pci/rockchip-dw-pcie.yaml        | 133 ++++++++++++++++=
++
> >>   1 file changed, 133 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw=
-pcie.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> >> new file mode 100644
> >> index 000000000000..24ea42203c14
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> >> @@ -0,0 +1,133 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: DesignWare based PCIe RC controller on Rockchip SoCs
> >> +
> >> +maintainers:
> >> +  - Shawn Lin <shawn.lin@rock-chips.com>
> >> +  - Simon Xue <xxm@rock-chips.com>
> >> +  - Heiko Stuebner <heiko@sntech.de>
> >> +
> >> +description: |+
> >> +  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
> >> +  PCIe IP and thus inherits all the common properties defined in
> >> +  designware-pcie.txt.
> >> +
> >> +allOf:
> >> +  - $ref: /schemas/pci/pci-bus.yaml#
> >> +
> >> +# We need a select here so we don't match all nodes with 'snps,dw-pci=
e'
> >> +select:
> >> +  properties:
> >> +    compatible:
> >> +      contains:
> >> +        const: rockchip,rk3568-pcie
> >> +  required:
> >> +    - compatible
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: rockchip,rk3568-pcie
> >> +      - const: snps,dw-pcie
> >> +
> >> +  reg:
> >> +    items:
> >> +      - description: Data Bus Interface (DBI) registers
> >> +      - description: Rockchip designed configuration registers
> >> +
> >> +  clocks:
> >> +    items:
> >> +      - description: AHB clock for PCIe master
> >> +      - description: AHB clock for PCIe slave
> >> +      - description: AHB clock for PCIe dbi
> >> +      - description: APB clock for PCIe
> >> +      - description: Auxiliary clock for PCIe
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: aclk_mst
> >> +      - const: aclk_slv
> >> +      - const: aclk_dbi
> >> +      - const: pclk
> >> +      - const: aux
> >> +
> >> +  msi-map: true
> >> +
> >> +  num-lanes: true
> >> +
> >> +  phys:
> >> +    maxItems: 1
> >> +
> >> +  phy-names:
> >> +    const: pcie-phy
> >> +
> >> +  power-domains:
> >> +    maxItems: 1
> >> +
> >> +  ranges:
> >> +    maxItems: 3
> >> +
> >> +  resets:
> >> +    maxItems: 1
> >> +
> >> +  reset-names:
> >> +    const: pipe
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - reg-names
> >> +  - clocks
> >> +  - clock-names
> >> +  - msi-map
> >> +  - num-lanes
> >> +  - phys
> >> +  - phy-names
> >> +  - power-domains
> >> +  - resets
> >> +  - reset-names
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +
> >> +    bus {
> >> +        #address-cells =3D <2>;
> >> +        #size-cells =3D <2>;
> >> +
> >> +        pcie3x2: pcie@fe280000 {
> >> +            compatible =3D "rockchip,rk3568-pcie", "snps,dw-pcie";
> >> +            reg =3D <0x3 0xc0800000 0x0 0x400000>,
> >> +                  <0x0 0xfe280000 0x0 0x10000>;
> >> +            reg-names =3D "pcie-dbi", "pcie-apb";
> > I believe I already said use 'dbi'. The DBI is also not 4MB. The config
> > space goes here too, not in 'ranges'.
>
> Sorry for missing  update in yaml.
>
> I think yaml is used to describe the resources of specific SoC, it
> reserves 4MB for DBI on Rockchip SoC.
>
> So, I think assign 4MB here is reasonable.

Not if there's nothing there. Otherwise you are wasting almost 4MB of
virtual space. Doesn't matter so much on 64-bit, but for 32-bit it
really does.

Rob
