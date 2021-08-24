Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3083F6286
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 18:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhHXQO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 12:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232403AbhHXQO5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 12:14:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84CAB61220;
        Tue, 24 Aug 2021 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629821652;
        bh=SiwWz97Kt2QCP23ZbPzkXSUXv9wq6rkyZ46i+0fVdBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlScbicLH1ray6HBF1GYrpooSGte1BMoSUN+t5iYBixBw/r8nxTgP15BaOBldyPm5
         rOkqOXa3c5fvZhlh7pkH3xdA/Y2hG2ikJgt0zV5LPddSIQVAv4R1zOFNYpyihSuu89
         PSnL7kW/ukKqHbF6AGTbxEFGiFSnv9ntKeic3AMtiVPsyXg2O6dj79CHO7GaxxKuu1
         NjE8WQhCzd31F4I7OKLRMcZw2fLcUmFJ4dMHrNERdbJsO3j29ip0LpjpJSJwKS55d9
         5ITfjbuPEmBGtPQnGe1tXvA4JZCiNqkATlbTDevfumN0X2AQql+rH5QbtFI3JO8uja
         nzL8Msd1xXqiw==
Received: by pali.im (Postfix)
        id 1D9C77A5; Tue, 24 Aug 2021 18:14:10 +0200 (CEST)
Date:   Tue, 24 Aug 2021 18:14:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add 'slot-power-limit' PCIe port
 property
Message-ID: <20210824161409.2mxzpy5r32tm3kgu@pali>
References: <20210820160023.3243-1-pali@kernel.org>
 <20210820160023.3243-2-pali@kernel.org>
 <YSURxtc7UAaSEfSy@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSURxtc7UAaSEfSy@robh.at.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 24 August 2021 10:35:34 Rob Herring wrote:
> On Fri, Aug 20, 2021 at 06:00:21PM +0200, Pali Rohár wrote:
> > This property specifies slot power limit in mW unit. It is form-factor and
> > board specific value and must be initialized by hardware.
> > 
> > Some PCIe controllers delegates this work to software to allow hardware
> > flexibility and therefore this property basically specifies what should
> > host bridge programs into PCIe Slot Capabilities registers.
> > 
> > Property needs to be specified in mW unit, and not in special format
> > defined by Slot Capabilities (which encodes scaling factor or different
> > unit). Host drivers should convert value from mW unit to their format.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> This needs to be in dtschema schemas/pci/pci-bus.yaml instead.
> 
> (pci.txt is still here because it needs to be relicensed to move all the 
> descriptions to pci-bus.yaml.)

Ok, this is just a proposal for a new DTS property. So documentation
issues will be fixed in real patch.

> > 
> > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> > index 6a8f2874a24d..e67d5db21514 100644
> > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > @@ -32,6 +32,12 @@ driver implementation may support the following properties:
> >     root port to downstream device and host bridge drivers can do programming
> >     which depends on CLKREQ signal existence. For example, programming root port
> >     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> > +- slot-power-limit:
> > +   If present this property specifies slot power limit in mW unit. Host drivers
> 
> As mentioned, this should have a unit suffix. I'm not sure it is 
> beneficial to share with SFP in this case though.
> 
> > +   can parse this slot power limit and use it for programming Root Port or host
> > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit message
> > +   through the Root Port or host bridge when transitioning PCIe link from a
> > +   non-DL_Up Status to a DL_Up Status.
> 
> I no nothing about how this mechanism works, but I think this belongs in 
> the next section as for PCIe, a slot is always below a PCI-PCI bridge. 
> If we have N slots, then there's N bridges and needs to be N 
> slot-power-limit properties, right?
> 
> (The same is probably true for all the properties here except 
> linux,pci-domain.) There's no distinction between host and PCI bridges  
> in pci-bus.yaml though.
> 
> Rob

This slot-power-limit property belongs to same place where are also
other slot properties (link speed, reset gpios, clkreq). So I put it in
place where others are.

But I'm not sure where it should be as it affects link/slot. Because
link has two sides. I guess that link speed and slot power limit could
belong to the root/downstream port and reset gpio to the endpoint card
or upstream port...
