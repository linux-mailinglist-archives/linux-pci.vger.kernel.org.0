Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957173DAB94
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 21:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhG2TDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 15:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhG2TDp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 15:03:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2217560041;
        Thu, 29 Jul 2021 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627585422;
        bh=QZzTxuOXLw86rHcrs3zAcLvxXqbKvso+gGJ/Bt/V7Yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TH2hos7zxb777wZ4DD5mN0DLcj65CFt3bLmdhbc6AYFgav8nyV0CRJSDoH0LY8Jow
         R+jXTaFeTZJMdfkVePdh3VudGpQfc2BmYI5fbu2AFf88fJLfMiwIHe1+CliGXbew8A
         vwflPDfg0fR+UqRe8INTZ9eEF4/746XoDgm05V6Ja2QhKuvO4S6CP2pC2UB5Q6X/zA
         i2JIBwXdzJJPH7Brqzo3PQgRgZr0Z42SETyY4c5URe+cCpiEh1tdnZGDp26UXwz61c
         xccOpLXbdBL1w1TOe3rH67+4Evgt6KBDR8VsxSIMbs0GlUfk9bj6TFaBnAsGO9v9a9
         dt4irhlxmF8Qw==
Date:   Thu, 29 Jul 2021 21:03:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: PCI: kirin: Add support for Kirin970
Message-ID: <20210729210337.6fc9a92c@coco.lan>
In-Reply-To: <CAL_Jsq+JgWMf8XPdHQ9GRdA+7EODJ47vwuz0jGkkyeETZPXz9Q@mail.gmail.com>
References: <cover.1627559126.git.mchehab+huawei@kernel.org>
        <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
        <CAL_Jsq+JgWMf8XPdHQ9GRdA+7EODJ47vwuz0jGkkyeETZPXz9Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 29 Jul 2021 09:20:15 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Thu, Jul 29, 2021 at 5:56 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Add a new compatible, plus the new bindings needed by
> > HiKey970 board.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 61 ++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > index 90cab09e8d4b..bb0c3a081d68 100644
> > --- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > @@ -24,11 +24,13 @@ properties:
> >      contains:
> >        enum:
> >          - hisilicon,kirin960-pcie
> > +        - hisilicon,kirin970-pcie
> >
> >    reg:
> >      description: |
> >        Should contain dbi, apb, config registers location and length.
> > -      For HiKey960, it should also contain phy.
> > +      For HiKey960, it should also contain phy. All other devices
> > +      should use a separate phy driver.
> >      minItems: 3
> >      maxItems: 4
> >
> > @@ -47,6 +49,7 @@ examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> >      #include <dt-bindings/clock/hi3660-clock.h>
> > +    #include <dt-bindings/clock/hi3670-clock.h>
> >
> >      soc {
> >        #address-cells = <2>;
> > @@ -83,4 +86,60 @@ examples:
> >          clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
> >                        "pcie_apb_sys", "pcie_aclk";
> >        };
> > +
> > +      pcie@f5000000 {
> > +        compatible = "hisilicon,kirin970-pcie";
> > +        reg = <0x0 0xf4000000 0x0 0x1000000>,
> > +              <0x0 0xfc180000 0x0 0x1000>,
> > +              <0x0 0xf5000000 0x0 0x2000>;
> > +        reg-names = "dbi", "apb", "config";
> > +        bus-range = <0x0  0x1>;
> > +        msi-parent = <&its_pcie>;
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        device_type = "pci";
> > +        phys = <&pcie_phy>;
> > +        ranges = <0x02000000 0x0 0x00000000
> > +                  0x0 0xf6000000
> > +                  0x0 0x02000000>;
> > +        num-lanes = <1>;
> > +        #interrupt-cells = <1>;
> > +        interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names = "msi";
> > +        interrupt-map-mask = <0 0 0 7>;
> > +        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> > +        pcie@4,0 { // Lane 4: M.2
> > +          reg = <0 0 0 0 0>;
> > +          compatible = "pciclass,0604";
> > +          device_type = "pci";
> > +          reset-gpios = <&gpio7 1 0>;
> > +          clkreq-gpios = <&gpio27 3 0 >;  
> 
> Looking at the schematics some more, this is not right. CLKREQ# is an
> input from the device, and they are not connected to any GPIO (just
> pulled high) on hikey970. These GPIOs are simply clock enables and
> very much specific to hikey. So I'd call this 'hisilicon,clken-gpios'
> and you can just stick them in the host bridge node.
> 

Ok. If I understood your review, the schema will then be:

      pcie@f4000000 {
        compatible = "hisilicon,kirin970-pcie";
        reg = <0x0 0xf4000000 0x0 0x1000000>,
              <0x0 0xfc180000 0x0 0x1000>,
              <0x0 0xf5000000 0x0 0x2000>;
        reg-names = "dbi", "apb", "config";
        bus-range = <0x0  0x1>;
        msi-parent = <&its_pcie>;
        #address-cells = <3>;
        #size-cells = <2>;
        device_type = "pci";
        phys = <&pcie_phy>;
        ranges = <0x02000000 0x0 0x00000000
                  0x0 0xf6000000
                  0x0 0x02000000>;
        num-lanes = <1>;
        #interrupt-cells = <1>;
        interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names = "msi";
        interrupt-map-mask = <0 0 0 7>;
        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
        reset-gpios = <&gpio7 0 0>;

        pcie@0 { // Lane 0: upstream
          reg = <0 0 0 0 0>;
          compatible = "pciclass,0604";
          device_type = "pci";
          #address-cells = <3>;
          #size-cells = <2>;
          hisilicon,clken-gpios = <&gpio27 3 0 >, <&gpio17 0 0 >, <&gpio20 6 0 >;
          ranges;

          pcie@1,0 { // Lane 4: M.2
            reg = <0x800 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
            reset-gpios = <&gpio3 1 0>;
            #address-cells = <3>;
            #size-cells = <2>;
            ranges;
          };

          pcie@5,0 { // Lane 5: Mini PCIe
            reg = <0x2800 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
            reset-gpios = <&gpio27 4 0 >;
            #address-cells = <3>;
            #size-cells = <2>;
            ranges;
          };

          pcie@7,0 { // Lane 7: Ethernet
            reg = <0x3800 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
            reset-gpios = <&gpio25 2 0 >;
            #address-cells = <3>;
            #size-cells = <2>;
            ranges;
          };
        };
      };
    };

Right?

After updating the dt-schema from your git tree, the above doesn't 
generate warnings anymore.

Thanks,
Mauro
