Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFB2127E6
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgGBP3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 11:29:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbgGBP3M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 11:29:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A45931B;
        Thu,  2 Jul 2020 08:29:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F7003F68F;
        Thu,  2 Jul 2020 08:29:09 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:29:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     m.karthikeyan@mobiveil.co.in, linux-pci@vger.kernel.org,
        mingkai.hu@nxp.com, mark.rutland@arm.com, minghuan.lian@nxp.com,
        zhiqiang.hou@nxp.com, l.subrahmanya@mobiveil.co.in
Subject: Re: [PATCH] PCI: mobiveil: Modified the Device tree bindings
 interrupt-map example
Message-ID: <20200702152904.GA25591@e121166-lin.cambridge.arm.com>
References: <20191029155342.29342-1-m.karthikeyan@mobiveil.co.in>
 <20191029224055.GA117186@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029224055.GA117186@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 05:40:55PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2019 at 09:23:42PM +0530, m.karthikeyan@mobiveil.co.in wrote:
> > From: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> 
> *All* patches modify something, so the subject line isn't very
> informative.  I think you're actually fixing a bug:
> 
> > -		interrupt-map = <0 0 0 0 &pci_express 0>,
> > +		interrupt-map = <0 0 0 1 &pci_express 0>,
> 
> and *that* should be clear in the subject.  Maybe something like:
> 
>   dt-bindings: PCI: mobiveil: Correct INTx mapping
> 
> I don't know the implications of this for backwards compatibility.

Yes that has to be tested but nonetheless this binding is still
broken (and probably the driver was made to work with it so I
need to check it).

It is certain that the current binding can't work with a PCI device
requiring an INTD.

Lorenzo

> 
> > Legacy IRQs Interrupt pins map 01h, 02h, 03h, and 04h while value of 00h
> > indicates Function uses no legacy interrupt Message
> > 
> > Signed-off-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> > ---
> >  .../devicetree/bindings/pci/mobiveil-pcie.txt | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > index 64156993e05..b9dcb0ddc19 100644
> > --- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > @@ -31,9 +31,14 @@ Required properties:
> >  - interrupts: The interrupt line of the PCIe controller
> >  		last cell of this field is set to 4 to
> >  		denote it as IRQ_TYPE_LEVEL_HIGH type interrupt.
> > -- interrupt-map-mask,
> > -	interrupt-map: standard PCI properties to define the mapping of the
> > -	PCI interface to interrupt numbers.
> > +- interrupt-map-mask:
> > +		Its a 4-tuple like structure denoting phys.hi, phys.mid,
> > +		phys.low and interrupt-cell
> > +- interrupt-map: standard PCI properties to define the mapping of the
> > +		PCI interface to interrupt numbers. Here the first 4-tuple
> > +		are represented similar to interrupt-map-mask representation
> > +		while the next fields represents Interrupt controller phandle
> > +		and its #interrupt-cells fields
> 
> The original text was basically the same as all the other bindings, so
> I don't really see the point of changing this to be different from all
> the rest.
> 
> A few (mediatek, nvidia) refer to the "standard PCI bus binding
> document" for more details.
> 
> Maybe there should be a common place in the Linux source for
> describing these "standard properties" so it's not repeated
> everywhere?
> 
> >  - ranges: ranges for the PCI memory regions (I/O space region is not
> >  	supported by hardware)
> >  	Please refer to the standard PCI bus binding document for a more
> > @@ -63,10 +68,10 @@ Example:
> >  		#interrupt-cells = <1>;
> >  		interrupts = < 0 89 4 >;
> >  		interrupt-map-mask = <0 0 0 7>;
> > -		interrupt-map = <0 0 0 0 &pci_express 0>,
> > -				<0 0 0 1 &pci_express 1>,
> > -				<0 0 0 2 &pci_express 2>,
> > -				<0 0 0 3 &pci_express 3>;
> > +		interrupt-map = <0 0 0 1 &pci_express 0>,
> > +				<0 0 0 2 &pci_express 1>,
> > +				<0 0 0 3 &pci_express 2>,
> > +				<0 0 0 4 &pci_express 3>;
> 
> Above you say the first 4-tuple in interrupt-map is similar to
> interrupt-map-mask, but these all look the same and they don't look
> like interrupt-map-mask.
> 
> Oh, I guess you mean the "0 0 0 1" is a 4-tuple and the
> "&pci_express 0" part is the "next fields".  I would have called that
> a 6-tuple.  But I'm not a DT person, so maybe I just don't know the
> terminology.
> 
> >  		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
> >  
> >  	};
> > -- 
> > 2.17.1
> > 
> > 
> > -- 
> > Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
> > attachments, is for the sole use of the intended recipient(s) and may 
> > contain proprietary confidential or privileged information or otherwise be 
> > protected by law. Any unauthorized review, use, disclosure or distribution 
> > is prohibited. If you are not the intended recipient, please notify the 
> > sender and destroy all copies and the original message.
> 
> You should try to avoid confidentiality notices like this in email to
> the public mailing lists.  I don't know whether we could apply a patch
> with this notice on it or not.
