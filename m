Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F6EF12F2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 10:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfKFJxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 04:53:45 -0500
Received: from foss.arm.com ([217.140.110.172]:36852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731554AbfKFJxp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 04:53:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 700D9328;
        Wed,  6 Nov 2019 01:53:44 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA2DE3F6C4;
        Wed,  6 Nov 2019 01:53:43 -0800 (PST)
Date:   Wed, 6 Nov 2019 09:53:41 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Anvesh Salveru <anvesh.s@samsung.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, pankaj.dubey@samsung.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: designware: Add binding for
 ZRX-DC PHY property
Message-ID: <20191106095340.GO9723@e119886-lin.cambridge.arm.com>
References: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
 <CGME20191028121748epcas5p3054c9583c14a2edde9f725d005895a04@epcas5p3.samsung.com>
 <1572264988-17455-2-git-send-email-anvesh.s@samsung.com>
 <20191105215332.GA19296@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105215332.GA19296@bogus>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 03:53:32PM -0600, Rob Herring wrote:
> On Mon, Oct 28, 2019 at 05:46:27PM +0530, Anvesh Salveru wrote:
> > Add support for ZRX-DC compliant PHYs. If PHY is not compliant to ZRX-DC
> > specification, then after every 100ms link should transition to recovery
> > state during the low power states which increases power consumption.
> > 
> > Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
> > property in DesignWare controller DT node.
> > 
> > CC: Rob Herring <robh+dt@kernel.org>
> > CC: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> > Change in v2: None
> > 
> >  Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > index 78494c4050f7..9507ac38ac89 100644
> > --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > @@ -38,6 +38,8 @@ Optional properties:
> >     for data corruption. CDM registers include standard PCIe configuration
> >     space registers, Port Logic registers, DMA and iATU (internal Address
> >     Translation Unit) registers.
> > +- snps,phy-zrxdc-compliant: This property is needed if phy complies with the
> > +  ZRX-DC specification.
> 
> If this is a property of the phy, then it belongs in the phy node or 
> should just be implied by the phy's compatible. 

As suggested in the previous revision of this series [1], this is absolutely a
property of the phy.

> IOW, you should be able 
> to support this or not without changing DTs.
> 
> Is this spec Synopys specific? (About the only thing Google turns up are 
> your patches.) If not, then probably shouldn't have a 'snps' prefix.

This was also unfamiliar to me, however my current understanding is that
Zrx-dc describes the 'Receiver DC single ended impedance' limits, this is
specified in the PCI specification (table 'Common Receiver Parameters'),
with a different limit for each speed.

I believe the purpose of this series is to to satisfy the following
implementation note in the spec "Ports that meet the Zrx-dc specification
for 2.5 GT/s while in the L1.Idle state are therefore not required to
implement the 100 ms timeout and transition to Recovery should avoid
implementing it, since it will reduce the power savings expected from the
L1 state".

In other words, if it is known that the phy is compliant then an
unnecessary transition to a higher energy state can be avoided. Though it's
the PCI controller (in this case) that must action this and must find out
about the phy it is connected to.

So in my view 'phy-zrxdc-compliant' should be a property of a phy (without
snps prefix), and if a controller wants to determine if it is compliant then
there must be a phandle to the phy so the controller can find out.

[1] https://patchwork.kernel.org/patch/11202121/

Thanks,

Andrew Murray

> 
> >  RC mode:
> >  - num-viewport: number of view ports configured in hardware. If a platform
> >    does not specify it, the driver assumes 2.
> > -- 
> > 2.17.1
> > 
