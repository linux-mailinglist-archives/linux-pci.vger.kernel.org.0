Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8373F7809
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhHYPLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 11:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240864AbhHYPLQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 11:11:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3F9D61100;
        Wed, 25 Aug 2021 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629904231;
        bh=jT6lH15jkUwPsIoMKnlswllzB45QQFJk2KpE+PMlXfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1CJGrl2szqPHShOnBn3w+hUT7AbxeLLu3G3HSUfQUwsW/EiCG+7hnizAWrRVedCN
         Y3gj/HqZeZ+KH3tAPLP7B+1QE8N0uyQRKNZ/q+i3Myjr7LvvbLCGM9Nim+naitYgGm
         XLqGE5RJSxD0PWcS/xWYlvSp+ISoFzWNMHhh2ywuwOOU6dLYgnsoPtCkh8Wvr9Bh5T
         3l/royS6IRE71vE25oQzx2vE4+ilajYNXytFlL0nmOhYDIGruvDhuDYVxh4/zC80DG
         KxmHdEi6CpNZpie5jCgeXtclwUeri3CuriFopVUg9xskcXD7UfLD1l3iKf+mSFvGaE
         djMNl+K8fw7hw==
Received: by pali.im (Postfix)
        id 6F5B55F1; Wed, 25 Aug 2021 17:10:28 +0200 (CEST)
Date:   Wed, 25 Aug 2021 17:10:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add 'slot-power-limit' PCIe port
 property
Message-ID: <20210825151028.hwhibrtqcrslhjsq@pali>
References: <20210820160023.3243-1-pali@kernel.org>
 <20210820160023.3243-2-pali@kernel.org>
 <YSURxtc7UAaSEfSy@robh.at.kernel.org>
 <20210824161409.2mxzpy5r32tm3kgu@pali>
 <CAL_JsqL1NzTp8v+kw1M_aS5OmJMuRiuys4RKYTT2yYy4pKNzJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL1NzTp8v+kw1M_aS5OmJMuRiuys4RKYTT2yYy4pKNzJA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 25 August 2021 09:57:52 Rob Herring wrote:
> On Tue, Aug 24, 2021 at 11:14 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Tuesday 24 August 2021 10:35:34 Rob Herring wrote:
> > > On Fri, Aug 20, 2021 at 06:00:21PM +0200, Pali Rohár wrote:
> > > > This property specifies slot power limit in mW unit. It is form-factor and
> > > > board specific value and must be initialized by hardware.
> > > >
> > > > Some PCIe controllers delegates this work to software to allow hardware
> > > > flexibility and therefore this property basically specifies what should
> > > > host bridge programs into PCIe Slot Capabilities registers.
> > > >
> > > > Property needs to be specified in mW unit, and not in special format
> > > > defined by Slot Capabilities (which encodes scaling factor or different
> > > > unit). Host drivers should convert value from mW unit to their format.
> > > >
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > >
> > > This needs to be in dtschema schemas/pci/pci-bus.yaml instead.
> > >
> > > (pci.txt is still here because it needs to be relicensed to move all the
> > > descriptions to pci-bus.yaml.)
> >
> > Ok, this is just a proposal for a new DTS property. So documentation
> > issues will be fixed in real patch.
> >
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> > > > index 6a8f2874a24d..e67d5db21514 100644
> > > > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > > > @@ -32,6 +32,12 @@ driver implementation may support the following properties:
> > > >     root port to downstream device and host bridge drivers can do programming
> > > >     which depends on CLKREQ signal existence. For example, programming root port
> > > >     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> > > > +- slot-power-limit:
> > > > +   If present this property specifies slot power limit in mW unit. Host drivers
> > >
> > > As mentioned, this should have a unit suffix. I'm not sure it is
> > > beneficial to share with SFP in this case though.
> > >
> > > > +   can parse this slot power limit and use it for programming Root Port or host
> > > > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit message
> > > > +   through the Root Port or host bridge when transitioning PCIe link from a
> > > > +   non-DL_Up Status to a DL_Up Status.
> > >
> > > I no nothing about how this mechanism works, but I think this belongs in
> > > the next section as for PCIe, a slot is always below a PCI-PCI bridge.
> > > If we have N slots, then there's N bridges and needs to be N
> > > slot-power-limit properties, right?
> > >
> > > (The same is probably true for all the properties here except
> > > linux,pci-domain.) There's no distinction between host and PCI bridges
> > > in pci-bus.yaml though.
> > >
> > > Rob
> >
> > This slot-power-limit property belongs to same place where are also
> > other slot properties (link speed, reset gpios, clkreq). So I put it in
> > place where others are.
> >
> > But I'm not sure where it should be as it affects link/slot. Because
> > link has two sides. I guess that link speed and slot power limit could
> > belong to the root/downstream port and reset gpio to the endpoint card
> > or upstream port...
> 
> I wasn't debating whether it goes upstream or downstream, but just
> that it can apply to more than just the host bridge or root port(s).
> We have that now already with reset-gpios. Look at the hikey970 case
> that's queued for 5.15. It's got RP -> switch -> slots/devices with
> reset gpio on each slot.
> 
> As for upstream vs. downstream side, this is one of those cases where
> we didn't represent the downstream side in DT, so everything gets
> stuffed in the upstream side. As PCIe is point to point, it doesn't
> matter so much. It would be a bigger issue on old PCI.

Upstream vs downstream matters for hotplugging PCIe cases. Upstream
part (endpoint card) can be unplugged from hotplugging PCIe bridge and
so does not have any node in sysfs (or lspci output). But downstream
part (or root port) of PCIe bridge is always present.
