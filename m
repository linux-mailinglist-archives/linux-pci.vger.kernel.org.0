Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE13CC8A7
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhGRK6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 06:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhGRK6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Jul 2021 06:58:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4282360E09;
        Sun, 18 Jul 2021 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626605708;
        bh=IbtTbduagSl46TiZq6dHHvm7L6082HA3Xm8jM1+Pkps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5EeEyh6UJstCmymZEE59uhejrYUfXl3NeBcZgpqlZdioFyw665uC8wN0gsyLwCUm
         CyckWCJ52+cchqyQcUbUciadgF+Cyh0YImU5OFaqEbQRrOD0f4yQXT4O5UxNZITTSC
         o5cy6wjRU01CHtWU3WZNqz8DTVmy45biQgxNE7NHJBpk3LxbNdo3eVgTX18FDGGnwU
         7ZJQ9NOkgkouzZzDUT06TKo566wSAEXIZ9HfDf471qf5ECVgZM724sZb6lYVUGfvag
         7KhdjlJcqfm9DmJxr0PFgvLNZelBr6fPq1mrgW2bVOmtV2q7qTpIRwsHjoLL00aVmR
         b+s7KFwqlGAxw==
Date:   Sun, 18 Jul 2021 12:55:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: PCI: add snps,dw-pcie.yaml
Message-ID: <20210718125503.395515e7@coco.lan>
In-Reply-To: <20210718115916.3a37f969@coco.lan>
References: <cover.1626174242.git.mchehab+huawei@kernel.org>
        <0454d09414d74d9789213f5e7779002bcc024537.1626174242.git.mchehab+huawei@kernel.org>
        <20210715172337.GA1263164@robh.at.kernel.org>
        <20210718115916.3a37f969@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Sun, 18 Jul 2021 11:59:16 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 15 Jul 2021 11:23:37 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 
> > On Tue, Jul 13, 2021 at 01:17:51PM +0200, Mauro Carvalho Chehab wrote:  
> > > Currently, the designware schema is defined on a text file:
> > > 	designware-pcie.txt
> > > 
> > > Convert the pci-bus part into a schema.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 96 +++++++++++++++++++
> > >  MAINTAINERS                                   |  1 +
> > >  2 files changed, 97 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..fd372d715ab4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > @@ -0,0 +1,96 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/snps,dw-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Synopsys DesignWare PCIe interface
> > > +
> > > +maintainers:
> > > +  - Jingoo Han <jingoohan1@gmail.com>
> > > +  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > +
> > > +description: |
> > > +  Synopsys DesignWare PCIe host controller
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    anyOf:
> > > +      - {}
> > > +      - const: snps,dw-pcie
> > > +
> > > +  reg:
> > > +    description: |
> > > +      It should contain Data Bus Interface (dbi) and config registers for all
> > > +      versions.
> > > +      For designware core version >= 4.80, it may contain ATU address space.
> > > +    minItems: 2
> > > +    maxItems: 4
> > > +
> > > +  reg-names:
> > > +    minItems: 2
> > > +    maxItems: 4
> > > +    items:
> > > +      enum: [dbi, dbi2, config, atu, addr_space, app, elbi, mgmt]    
> > 
> > Isn't 'config' only for host and 'addr_space' only for endpoint?  
> 
> The problem on enforcing an enum here is that severa *.dts files violate it. 
> In the specific case of 'addr_space', there is (are?) place(s) where the wrong
> compatible was used, like on arch/arm/boot/dts/artpec6.dtsi:
> 
> 	pcie: pcie@f8050000 {
> 		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
> 		reg = <0xf8050000 0x2000
> 		       0xf8040000 0x1000
> 		       0xc0000000 0x2000>;
> 		reg-names = "dbi", "phy", "config";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		device_type = "pci";
> 			  /* downstream I/O */
> 		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000
> 			  /* non-prefetchable memory */
> 			  0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
> 		num-lanes = <2>;
> 		bus-range = <0x00 0xff>;
> 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> 		interrupt-names = "msi";
> 		#interrupt-cells = <1>;
> 		interrupt-map-mask = <0 0 0 0x7>;
> 		interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> 				<0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> 				<0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> 				<0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> 		axis,syscon-pcie = <&syscon>;
> 		status = "disabled";
> 	};
> 
> 	pcie_ep: pcie_ep@f8050000 {
> 		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> 		reg = <0xf8050000 0x2000
> 		       0xf8051000 0x2000
> 		       0xf8040000 0x1000
> 		       0xc0000000 0x20000000>;
> 		reg-names = "dbi", "dbi2", "phy", "addr_space";
> 		num-ib-windows = <6>;
> 		num-ob-windows = <2>;
> 		num-lanes = <2>;
> 		axis,syscon-pcie = <&syscon>;
> 		status = "disabled";
> 	};
> 
> (funny enough, this is not generating warnings here).
> 
> Btw, besides the above, there are some DTS that use something different
> from what's there at the enum:
> 
> 
> 	$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 dtbs_check 2>&1 |tee dtbs_check.log
> 	$ grep "\['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt'\]" dtbs_check.log|sed "s,From schema:,,"|cut -d: -f 2-|cut -d' ' -f 4-|sort|uniq -c|sort -n -r
> 	     51 'ctrl' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt']
> 	     44 'parf' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt']
> 	     18 'cfg' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt']
> 	      4 'link' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt']
> 
> In order to use an enum and not having warnings, the enum should be 
> instead:
> 
> 	reg-names:
> 	  minItems: 2
> 	  maxItems: 4
> 	  items:
> 	    enum: [dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link] 

Actually, some reg definitions have 5 items.

I'm sending an updated patch series.

Thanks,
Mauro
