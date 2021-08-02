Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9E3DE2AB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhHBWvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:51:08 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:41833 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWvH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Aug 2021 18:51:07 -0400
Received: by mail-io1-f46.google.com with SMTP id r6so13879071ioj.8;
        Mon, 02 Aug 2021 15:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/F4j+M7HVJEvHKJ2P+dsejOG3GT9RgPPzMUplBDxmc=;
        b=OBZ0woradCx25ma2M2hI3YBHOMQYiL7xVzIl9R8jAR91Fs65W2dOBmDCBckmhDz6va
         XQfWY60pf2/eRNeesEjnSxyFywP0M2xn5kjbT/u46GvIhM5VX1WgYIa7Cqe8AvXwMNst
         oUMxvCbZ5tVls4OnIBbWW/2qbHEwIuX+xnHxsn/Uv99o42SRL2vmJhOIdlgkzHq2d2L7
         ua/1n27yahmyYciQmJreOzGYmG5PayUF6tIj7MsbsxTxOLzwM8W6kC+oM4lcfI2mmcsF
         pI+Ie9KbMjWajZZZ+nBfFO79cfWfEJZCBdQ4hTAxfCzw8hmrOHnlZyATjLPL6PZqG0aj
         9jZA==
X-Gm-Message-State: AOAM530I+ddGKXUabO0PQdo+Q9OfT8iUBxD66rZF71G62NJDig28NgF4
        g+89mGh9PzddXXBI0PwP+g==
X-Google-Smtp-Source: ABdhPJzU91hJ+fXSq9vSjd/JxyD8l3kfaa55GgZIbbDJZmhB9B9cdKN8uNK/sV04rNOQVY5XCRa9aA==
X-Received: by 2002:a05:6638:4115:: with SMTP id ay21mr16712898jab.13.1627944656371;
        Mon, 02 Aug 2021 15:50:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s21sm7996018iot.33.2021.08.02.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:50:55 -0700 (PDT)
Received: (nullmailer pid 1771316 invoked by uid 1000);
        Mon, 02 Aug 2021 22:50:53 -0000
Date:   Mon, 2 Aug 2021 16:50:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: PCI: kirin: Add support for Kirin970
Message-ID: <YQh2zcFSKW+qucAG@robh.at.kernel.org>
References: <cover.1627559126.git.mchehab+huawei@kernel.org>
 <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
 <CAL_Jsq+JgWMf8XPdHQ9GRdA+7EODJ47vwuz0jGkkyeETZPXz9Q@mail.gmail.com>
 <20210729210337.6fc9a92c@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729210337.6fc9a92c@coco.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 09:03:37PM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 29 Jul 2021 09:20:15 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 
> > On Thu, Jul 29, 2021 at 5:56 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Add a new compatible, plus the new bindings needed by
> > > HiKey970 board.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 61 ++++++++++++++++++-
> > >  1 file changed, 60 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > > index 90cab09e8d4b..bb0c3a081d68 100644
> > > --- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > > @@ -24,11 +24,13 @@ properties:
> > >      contains:
> > >        enum:
> > >          - hisilicon,kirin960-pcie
> > > +        - hisilicon,kirin970-pcie
> > >
> > >    reg:
> > >      description: |
> > >        Should contain dbi, apb, config registers location and length.
> > > -      For HiKey960, it should also contain phy.
> > > +      For HiKey960, it should also contain phy. All other devices
> > > +      should use a separate phy driver.
> > >      minItems: 3
> > >      maxItems: 4
> > >
> > > @@ -47,6 +49,7 @@ examples:
> > >    - |
> > >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >      #include <dt-bindings/clock/hi3660-clock.h>
> > > +    #include <dt-bindings/clock/hi3670-clock.h>
> > >
> > >      soc {
> > >        #address-cells = <2>;
> > > @@ -83,4 +86,60 @@ examples:
> > >          clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
> > >                        "pcie_apb_sys", "pcie_aclk";
> > >        };
> > > +
> > > +      pcie@f5000000 {
> > > +        compatible = "hisilicon,kirin970-pcie";
> > > +        reg = <0x0 0xf4000000 0x0 0x1000000>,
> > > +              <0x0 0xfc180000 0x0 0x1000>,
> > > +              <0x0 0xf5000000 0x0 0x2000>;
> > > +        reg-names = "dbi", "apb", "config";
> > > +        bus-range = <0x0  0x1>;
> > > +        msi-parent = <&its_pcie>;
> > > +        #address-cells = <3>;
> > > +        #size-cells = <2>;
> > > +        device_type = "pci";
> > > +        phys = <&pcie_phy>;
> > > +        ranges = <0x02000000 0x0 0x00000000
> > > +                  0x0 0xf6000000
> > > +                  0x0 0x02000000>;
> > > +        num-lanes = <1>;
> > > +        #interrupt-cells = <1>;
> > > +        interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
> > > +        interrupt-names = "msi";
> > > +        interrupt-map-mask = <0 0 0 7>;
> > > +        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> > > +                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> > > +                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> > > +                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> > > +        pcie@4,0 { // Lane 4: M.2
> > > +          reg = <0 0 0 0 0>;
> > > +          compatible = "pciclass,0604";
> > > +          device_type = "pci";
> > > +          reset-gpios = <&gpio7 1 0>;
> > > +          clkreq-gpios = <&gpio27 3 0 >;  
> > 
> > Looking at the schematics some more, this is not right. CLKREQ# is an
> > input from the device, and they are not connected to any GPIO (just
> > pulled high) on hikey970. These GPIOs are simply clock enables and
> > very much specific to hikey. So I'd call this 'hisilicon,clken-gpios'
> > and you can just stick them in the host bridge node.
> > 
> 
> Ok. If I understood your review, the schema will then be:
> 
>       pcie@f4000000 {
>         compatible = "hisilicon,kirin970-pcie";
>         reg = <0x0 0xf4000000 0x0 0x1000000>,
>               <0x0 0xfc180000 0x0 0x1000>,
>               <0x0 0xf5000000 0x0 0x2000>;
>         reg-names = "dbi", "apb", "config";
>         bus-range = <0x0  0x1>;
>         msi-parent = <&its_pcie>;
>         #address-cells = <3>;
>         #size-cells = <2>;
>         device_type = "pci";
>         phys = <&pcie_phy>;
>         ranges = <0x02000000 0x0 0x00000000
>                   0x0 0xf6000000
>                   0x0 0x02000000>;
>         num-lanes = <1>;
>         #interrupt-cells = <1>;
>         interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-names = "msi";
>         interrupt-map-mask = <0 0 0 7>;
>         interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>                         <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
>                         <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
>                         <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
>         reset-gpios = <&gpio7 0 0>;
> 
>         pcie@0 { // Lane 0: upstream
>           reg = <0 0 0 0 0>;
>           compatible = "pciclass,0604";
>           device_type = "pci";
>           #address-cells = <3>;
>           #size-cells = <2>;
>           hisilicon,clken-gpios = <&gpio27 3 0 >, <&gpio17 0 0 >, <&gpio20 6 0 >;

Up one more level.

>           ranges;
> 
>           pcie@1,0 { // Lane 4: M.2
>             reg = <0x800 0 0 0 0>;
>             compatible = "pciclass,0604";
>             device_type = "pci";
>             reset-gpios = <&gpio3 1 0>;
>             #address-cells = <3>;
>             #size-cells = <2>;
>             ranges;
>           };
> 
>           pcie@5,0 { // Lane 5: Mini PCIe
>             reg = <0x2800 0 0 0 0>;
>             compatible = "pciclass,0604";
>             device_type = "pci";
>             reset-gpios = <&gpio27 4 0 >;
>             #address-cells = <3>;
>             #size-cells = <2>;
>             ranges;
>           };
> 
>           pcie@7,0 { // Lane 7: Ethernet

Port 7 is lane 6 and Port 9 is lane 7. So I think it should be 'Lane 6'. 

>             reg = <0x3800 0 0 0 0>;
>             compatible = "pciclass,0604";
>             device_type = "pci";
>             reset-gpios = <&gpio25 2 0 >;
>             #address-cells = <3>;
>             #size-cells = <2>;
>             ranges;
>           };
>         };
>       };
>     };
> 
> Right?
> 
> After updating the dt-schema from your git tree, the above doesn't 
> generate warnings anymore.
> 
> Thanks,
> Mauro
> 
