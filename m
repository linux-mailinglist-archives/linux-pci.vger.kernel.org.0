Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036CE3DE567
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 06:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhHCEeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 00:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhHCEeD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 00:34:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6974260560;
        Tue,  3 Aug 2021 04:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627965233;
        bh=bn6oyh45wOqyplLgqkhziI/otlLb0w3ygJk6evdjAxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jRlwO3PYvUPv9QDaHwv/dNRBelNcmniqS0QKRECyG91K3AVLdXBxuC/SWKW8Teyrb
         eLPjN3p+XoKN+p9ZhEFSu+gd7W6Z+ZDrEv2AcWO5XWdeiaoFCDqN5OytlGZCDBcMZX
         e/oyg0elUdR6/64lPoheR46C8nmXJroNfg2M1Efa1WGDd6vPdHJb7W1ZAYjhXHr5AU
         ZUPJKKs/DEAlezu6U9gsudVdJ6i6rQHA83wFYs1WcuorTmETPpQQp77omV4uWxEEF/
         CG2yWrhJ1poI2Pw9an5vetpAem44dctIhAtKMkrML/vkqbW62lSX2XUJwfd0UhLsV1
         VwOoD0OJ8wIlQ==
Date:   Tue, 3 Aug 2021 06:33:46 +0200
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
Message-ID: <20210803063028.6566241d@coco.lan>
In-Reply-To: <YQh2zcFSKW+qucAG@robh.at.kernel.org>
References: <cover.1627559126.git.mchehab+huawei@kernel.org>
        <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
        <CAL_Jsq+JgWMf8XPdHQ9GRdA+7EODJ47vwuz0jGkkyeETZPXz9Q@mail.gmail.com>
        <20210729210337.6fc9a92c@coco.lan>
        <YQh2zcFSKW+qucAG@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 2 Aug 2021 16:50:53 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Thu, Jul 29, 2021 at 09:03:37PM +0200, Mauro Carvalho Chehab wrote:
> > Em Thu, 29 Jul 2021 09:20:15 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >   

> > 
> > Ok. If I understood your review, the schema will then be:
> > 
> >       pcie@f4000000 {
> >         compatible = "hisilicon,kirin970-pcie";
> >         reg = <0x0 0xf4000000 0x0 0x1000000>,
> >               <0x0 0xfc180000 0x0 0x1000>,
> >               <0x0 0xf5000000 0x0 0x2000>;
> >         reg-names = "dbi", "apb", "config";
> >         bus-range = <0x0  0x1>;
> >         msi-parent = <&its_pcie>;
> >         #address-cells = <3>;
> >         #size-cells = <2>;
> >         device_type = "pci";
> >         phys = <&pcie_phy>;
> >         ranges = <0x02000000 0x0 0x00000000
> >                   0x0 0xf6000000
> >                   0x0 0x02000000>;
> >         num-lanes = <1>;
> >         #interrupt-cells = <1>;
> >         interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
> >         interrupt-names = "msi";
> >         interrupt-map-mask = <0 0 0 7>;
> >         interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> >                         <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> >                         <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> >                         <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> >         reset-gpios = <&gpio7 0 0>;
> > 
> >         pcie@0 { // Lane 0: upstream
> >           reg = <0 0 0 0 0>;
> >           compatible = "pciclass,0604";
> >           device_type = "pci";
> >           #address-cells = <3>;
> >           #size-cells = <2>;
> >           hisilicon,clken-gpios = <&gpio27 3 0 >, <&gpio17 0 0 >, <&gpio20 6 0 >;  
> 
> Up one more level.

Yeah. This is at the upper level at the newer series:

	[PATCH v2 3/4] dt-bindings: PCI: kirin: Add support for Kirin970
	https://lore.kernel.org/lkml/93a42a6317eed3b0eb6a35b6d4c484e106cb2793.1627637448.git.mchehab+huawei@kernel.org/


> >           ranges;
> > 
> >           pcie@1,0 { // Lane 4: M.2
> >             reg = <0x800 0 0 0 0>;
> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >             reset-gpios = <&gpio3 1 0>;
> >             #address-cells = <3>;
> >             #size-cells = <2>;
> >             ranges;
> >           };
> > 
> >           pcie@5,0 { // Lane 5: Mini PCIe
> >             reg = <0x2800 0 0 0 0>;
> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >             reset-gpios = <&gpio27 4 0 >;
> >             #address-cells = <3>;
> >             #size-cells = <2>;
> >             ranges;
> >           };
> > 
> >           pcie@7,0 { // Lane 7: Ethernet  
> 
> Port 7 is lane 6 and Port 9 is lane 7. So I think it should be 'Lane 6'. 

True. I'll fix it on v3.

> 
> >             reg = <0x3800 0 0 0 0>;
> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >             reset-gpios = <&gpio25 2 0 >;
> >             #address-cells = <3>;
> >             #size-cells = <2>;
> >             ranges;
> >           };
> >         };
> >       };
> >     };
> > 
> > Right?
> > 
> > After updating the dt-schema from your git tree, the above doesn't 
> > generate warnings anymore.
> > 
> > Thanks,
> > Mauro
> >   

Thanks,
Mauro
