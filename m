Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D67C48E3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 06:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjJKEnr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 00:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345123AbjJKEnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 00:43:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406E98;
        Tue, 10 Oct 2023 21:43:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44C4C433C7;
        Wed, 11 Oct 2023 04:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696999423;
        bh=RiUxKKSDAlh2Ofjb6kMNvoJr5jP/M8ygUX6ZJYjZe+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DP/yMMsI5G4GroWtB4JLU/Mez0UAp0PRbScs6vQdXdCUzRIJvTZEFSbdKQv3RuqhJ
         mHnZxfEAMlJFe/RBRSPMFO9CTAN+s6Qdl/uA1mMxBXWyNSd9i/DxuKvO3Iimj5SV7T
         XkbfDV0Tw77qCKdJVPAQhPoMLpuqv7NQA5igkk6/skT+h/r/U677DaSL/T1HP1I5V9
         fDK7w36L2hQLIHWDgvJTrwbrLwMHSAf+HLcc4KknZ0ltzx+19jEvJUmpVWeKKU0OGb
         MC1ae3dOPis0i+4to+JvXz7oeiUqbZ9nMYADXkwLvrxHpNrpcWDZohCBZnNnHeBwYp
         bWtUvhJg9JUIA==
Date:   Wed, 11 Oct 2023 10:13:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v21 10/16] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Message-ID: <20231011044329.GB3508@thinkpad>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-11-yoshihiro.shimoda.uh@renesas.com>
 <20231010112512.GE4884@thinkpad>
 <TYBPR01MB5341AB2F02A1162130DDFC22D8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB5341AB2F02A1162130DDFC22D8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 11, 2023 at 12:54:59AM +0000, Yoshihiro Shimoda wrote:
> Hello Manivannan,
> 
> > From: Manivannan Sadhasivam, Sent: Tuesday, October 10, 2023 8:25 PM
> > To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org; bhelgaas@google.com; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; jingoohan1@gmail.com; gustavo.pimentel@synopsys.com; marek.vasut+renesas@gmail.com;
> > linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Geert Uytterhoeven
> > <geert+renesas@glider.be>; Serge Semin <fancer.lancer@gmail.com>; Conor Dooley <conor.dooley@microchip.com>
> > Subject: Re: [PATCH v21 10/16] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
> > 
> > On Fri, Sep 22, 2023 at 03:53:25PM +0900, Yoshihiro Shimoda wrote:
> > > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > > PCIe host module.
> > >
> > > Link:
> <snip URL>
> > > Link:
> <snip URL>
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  .../bindings/pci/rcar-gen4-pci-host.yaml      | 127 ++++++++++++++++++
> > >  1 file changed, 127 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > > new file mode 100644
> > > index 000000000000..ffb34339b637
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml

[...]

> > > +            #interrupt-cells = <1>;
> > > +            interrupt-map-mask = <0 0 0 7>;
> > > +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> > > +                            <0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> > > +                            <0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> > > +                            <0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > I believe these are for legacy INTx interrupts. But you are using the same IRQ
> > number used for MSI above. Can you clarify?
> 
> On the SoC (R-Car S4-8), the same IRQ number is used for both MSI and legacy INTx
> interrupts...
> 

Ok. This seems wierd, but fine with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
