Return-Path: <linux-pci+bounces-15540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135369B4EA4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69BB2863A8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69527195FE3;
	Tue, 29 Oct 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDX+L1jo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0C802;
	Tue, 29 Oct 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217340; cv=none; b=S9Tv3acl21DFGD8q85NsrW5Y5NxJfiR385ExzDQ9kyQ2zp7Lfvkx3UZU4T0KKoZLdElIBs9XlKoT9LObXxrt1yXfnRdTfUakNsnfiywybf0BUwOQkeWg7PJmLqMPZ01+vOMrHYzRb/F/GDsiqfJ7p/eY6mhbtpka4emHjuEKGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217340; c=relaxed/simple;
	bh=CJ9H12zIXj9xBzwi/AKR94i3YhNSTynRSfnQm/cP2d0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LeKEnfaZgUh7CxdMCvOky/XFcO/M1ZMg64FHTapEvu0xNjaCHw+v+n/GpnDD12sv25SZNCd/f05tpgCNjaWRx/M0XUZfjzxfYsP0EV0vHKtLvHXTW/n9NV2XFAcbaZ6Rac6mdVW4T4/+EntShFTDvYYnXTDVKAAIAm6BfYogCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDX+L1jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996F4C4CECD;
	Tue, 29 Oct 2024 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217339;
	bh=CJ9H12zIXj9xBzwi/AKR94i3YhNSTynRSfnQm/cP2d0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aDX+L1jo4ybiUcWcNRwc9C5InagXSA9kAjMFdO390oCLxwFSeg0my+YAxcrMp/P1W
	 8CY2k4HQjgEidQrCfoubYkEk8pRlB9Ut8IYG5OBmMe/rWqibi3Rn+0VwpD58GOxLYQ
	 OFXE1T3pI1RNrds7m9QOgpr5e4MBNKLAnoDBXCDA36zZlecdkuN7afVz3Urlmhty05
	 xir5/S6SyEYknw/hkqK93q+V722kd9scRm0dP0n8ExtfakWyo0hqLGRKeUeeyjoAnO
	 yPaOF/25En6B7m+1HZlTg2azoUOSaF6QhEzdTM+uQ9chK7CffggkL+zYfZ+t6I069f
	 a8UDXwMztnYsw==
Date: Tue, 29 Oct 2024 10:55:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
	Mayank Rana <quic_mrana@quicinc.com>
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Message-ID: <20241029155538.GA1157681@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029154030.GA1157452@bhelgaas>

On Tue, Oct 29, 2024 at 10:40:32AM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2024 at 08:52:15PM +0530, Krishna Chaitanya Chundru wrote:
> > On 10/29/2024 8:18 PM, Bjorn Helgaas wrote:
> > > On Tue, Oct 29, 2024 at 10:22:36AM -0400, Jim Quinlan wrote:
> > > > On Tue, Oct 29, 2024 at 1:17 AM Krishna Chaitanya Chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > > > On 10/29/2024 12:21 AM, James Quinlan wrote:
> > > > > > On 10/24/24 21:08, Krishna Chaitanya Chundru wrote:
> > > > > > > On 10/22/2024 12:33 AM, Rob Herring wrote:
> > > > > > > > On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
> > > > > > > > > Support configuration of the GEN3 preset equalization settings, aka the
> > > > > > > > > Lane Equalization Control Register(s) of the Secondary PCI Express
> > > > > > > > > Extended Capability.  These registers are of type HwInit/RsvdP and
> > > > > > > > > typically set by FW.  In our case they are set by our RC host bridge
> > > > > > > > > driver using internal registers.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > > > > > ---
> > > > > > > > >    .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12
> > > > > > > > > ++++++++++++
> > > > > > > > >    1 file changed, 12 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git
> > > > > > > > > a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > > b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > > index 0925c520195a..f965ad57f32f 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > > @@ -104,6 +104,18 @@ properties:
> > > > > > > > >        minItems: 1
> > > > > > > > >        maxItems: 3
> > > > > > > > >    +  brcm,gen3-eq-presets:
> > > > > > > > > +    description: |
> > > > > > > > > +      A u16 array giving the GEN3 equilization presets, one for
> > > > > > > > > each lane.
> > > > > > > > > +      These values are destined for the 16bit registers known as the
> > > > > > > > > +      Lane Equalization Control Register(s) of the Secondary PCI
> > > > > > > > > Express
> > > > > > > > > +      Extended Capability.  In the array, lane 0 is first term,
> > > > > > > > > lane 1 next,
> > > > > > > > > +      etc. The contents of the entries reflect what is necessary for
> > > > > > > > > +      the current board and SoC, and the details of each preset are
> > > > > > > > > +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
> > > > > > > > 
> > > > > > > > If these are defined by the PCIe spec, then why is it Broadcom specific
> > > > > > > > property?
> > > > > > Yes, I will remove the "brcm," prefix.
> > > > > > > > 
> > > > > > > Hi Rob,
> > > > > > > 
> > > > > > > qcom pcie driver also needs to program these presets as you suggested
> > > > > > > this can go to common pci bridge binding.
> > > > > > > 
> > > > > > > from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
> > > > > > > of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
> > > > > > > through P10) and where as data rates of 64.0 GT/s use different class of
> > > > > > > presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
> > > > > > > have optional preset hints (Table 4-24).
> > > > > > > 
> > > > > > > And there is possibility that for each data rate we may require
> > > > > > > different preset configuration.
> > > > > > > 
> > > > > > > Can we have a dt binding for each data rate of 16 byte array.
> > > > > > > like gen3-eq-preset array, gen4-eq-preset array etc.
> > > > > > 
> > > > > > Yes, that was the idea when using "genX-eq-preset", for X in {3,4...}.
> > > > > > 
> > > > > > Keep in mind that this is an RFC; I have a backlog of commit submissions
> > > > > > before I can submit the code that uses this DT property.  If you
> > > > > > (Krishna) want to submit something now I'd be quite happy to go with
> > > > > > that.  I don't believe it is acceptable to submit a bindings commit w/o
> > > > > > code that uses it (if I'm incorrect I'll be glad to do a V2).
> > > > > > 
> > > > > I submitted a pull request for this. if you have any other suggestions
> > > > > or if we need to have any other details we can update this pull request.
> > > > > https://github.com/devicetree-org/dt-schema/pull/146
> > > > 
> > > > Thanks for doing this.   However, why a u8 array?  The registers are
> > > > defined as u16 so it would be more natural to use a u16 array, each
> > > > entry giving
> > > > all of the data for a single lane.  In our implementation we read a
> > > > u16 and we write it to the register -- what advantage is there by
> > > > using a u8 array?
> > > > 
> > > > Also if there are 16 lanes, you will need 32 maxItems, correct?
> > > 
> > > I added these questions to the github PR.
> > > 
> > > Also, why does it define gen3-eq-presets, gen4-eq-presets,
> > > gen5-eq-presets, and gen6-eq-presets?  I think there's only a single
> > > place to write these values (the Lane Equalization Control registers,
> > > PCIe r6.0, sec 7.7.3.4), isn't here?  How would software choose the
> > > correct values to use?
> ...

Oh, one more thing: I guess "gen3", "gen4", etc. are well-entrenched
terms in the industry, and they're probably fine in marketing
materials.

But I really don't like them in device trees or drivers because the
spec doesn't use those terms.  In fact, the spec specifically advises
*avoiding* them (PCIe r6.0, sec 1.2 footnote):

  Terms like “PCIe Gen3” are ambiguous and should be avoided. For
  example, “gen3” could mean (1) compliant with Base 3.0, (2)
  compliant with Base 3.1 (last revision of 3.x), (3) compliant with
  Base 3.0 and supporting 8.0 GT/s, (4) compliant with Base 3.0 or
  later and supporting 8.0 GT/s, ....

As a practical matter, those terms make it hard to use the spec: where
do I go to learn how to use "gen4-eq-presets"?  There's no instance of
"gen4" in the PCIe spec.  AFAICT, all I can do is look up the PCIe
r4.0 spec and try to figure out what was added in that revision, which
is a real hassle.

Bjorn

