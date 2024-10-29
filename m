Return-Path: <linux-pci+bounces-15532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7A9B4C79
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1898281C08
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8531A89;
	Tue, 29 Oct 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyG/7oDp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AC10F9;
	Tue, 29 Oct 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213333; cv=none; b=pqVZqTADmqRTN/IyA03vdgNioMaDuZewYuldVg/353mm3QJ+yTjfB0+RQzvhQACVsYLQyMoCRspzLBCGJgACrU3YnOTbGImPU2d7bWGlMJBW4HiUyhkNdZTYv2gSqM5ikt3DSDVe2rw134BvDp42gQsapjPuC365ltg1e4dIcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213333; c=relaxed/simple;
	bh=aq0smJWMoF0urEfEydYW6lBnfnX5/GErqTGpobBR4xc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oiEJkUrtMzXHx9ICPWK1MmgJQxN5xJSs4ZJxliUkAGL96Sh+PKVb1zVcWv1xiR/3e/VlIt/qgVW6lwof4fKtNvCLuBIcvpuqsXQatJbaRYJw177vfgpdqTaPkPvcEdR3fueLtYwtZM3i+78s/ZF/kDYR5Ox6VFupVJcxN2iZG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyG/7oDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE50C4CECD;
	Tue, 29 Oct 2024 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730213332;
	bh=aq0smJWMoF0urEfEydYW6lBnfnX5/GErqTGpobBR4xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pyG/7oDpoNHQOlZXjTIso0HTpbhVzqWqUQDZz4VW6Gce0vrjNBG7uiZy/h7N7FHfV
	 GxdlLxD74xGzmWAFpS3Z1fEPbxHRVxN1S8t3zzitVrT+IhbkZsvcX/xD141sZt43fJ
	 CZnkVgb40tkv7rhPOT0SfObRy1yw6dlqnjZciPsEAjhYJCzwTK4GsM5CavflbcAnlK
	 9coYysIgtuuAZMA5GAyBEk5LDGBiaVtmXGD33/HEfs1SLWmqhotu6j36dq33PrTR2o
	 xf5+JIyf+EcpWdkGntkA6zXSxdSdjazxHR0a1YuSkQDfvaKozScrGB3brD1iHd4Fzx
	 WVcZ2fJWa9klA==
Date: Tue, 29 Oct 2024 09:48:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
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
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Message-ID: <20241029144850.GA1152694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNx1SA9iiECS1O=cwkcu2KWcPvvB7Zvm7=SR3F5m9nv+fg@mail.gmail.com>

On Tue, Oct 29, 2024 at 10:22:36AM -0400, Jim Quinlan wrote:
> On Tue, Oct 29, 2024 at 1:17 AM Krishna Chaitanya Chundru
> <quic_krichai@quicinc.com> wrote:
> > On 10/29/2024 12:21 AM, James Quinlan wrote:
> > > On 10/24/24 21:08, Krishna Chaitanya Chundru wrote:
> > >> On 10/22/2024 12:33 AM, Rob Herring wrote:
> > >>> On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
> > >>>> Support configuration of the GEN3 preset equalization settings, aka the
> > >>>> Lane Equalization Control Register(s) of the Secondary PCI Express
> > >>>> Extended Capability.  These registers are of type HwInit/RsvdP and
> > >>>> typically set by FW.  In our case they are set by our RC host bridge
> > >>>> driver using internal registers.
> > >>>>
> > >>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > >>>> ---
> > >>>>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12
> > >>>> ++++++++++++
> > >>>>   1 file changed, 12 insertions(+)
> > >>>>
> > >>>> diff --git
> > >>>> a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > >>>> b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > >>>> index 0925c520195a..f965ad57f32f 100644
> > >>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > >>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > >>>> @@ -104,6 +104,18 @@ properties:
> > >>>>       minItems: 1
> > >>>>       maxItems: 3
> > >>>>   +  brcm,gen3-eq-presets:
> > >>>> +    description: |
> > >>>> +      A u16 array giving the GEN3 equilization presets, one for
> > >>>> each lane.
> > >>>> +      These values are destined for the 16bit registers known as the
> > >>>> +      Lane Equalization Control Register(s) of the Secondary PCI
> > >>>> Express
> > >>>> +      Extended Capability.  In the array, lane 0 is first term,
> > >>>> lane 1 next,
> > >>>> +      etc. The contents of the entries reflect what is necessary for
> > >>>> +      the current board and SoC, and the details of each preset are
> > >>>> +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
> > >>>
> > >>> If these are defined by the PCIe spec, then why is it Broadcom specific
> > >>> property?
> > > Yes, I will remove the "brcm," prefix.
> > >>>
> > >> Hi Rob,
> > >>
> > >> qcom pcie driver also needs to program these presets as you suggested
> > >> this can go to common pci bridge binding.
> > >>
> > >> from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
> > >> of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
> > >> through P10) and where as data rates of 64.0 GT/s use different class of
> > >> presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
> > >> have optional preset hints (Table 4-24).
> > >>
> > >> And there is possibility that for each data rate we may require
> > >> different preset configuration.
> > >>
> > >> Can we have a dt binding for each data rate of 16 byte array.
> > >> like gen3-eq-preset array, gen4-eq-preset array etc.
> > >
> > > Yes, that was the idea when using "genX-eq-preset", for X in {3,4...}.
> > >
> > > Keep in mind that this is an RFC; I have a backlog of commit submissions
> > > before I can submit the code that uses this DT property.  If you
> > > (Krishna) want to submit something now I'd be quite happy to go with
> > > that.  I don't believe it is acceptable to submit a bindings commit w/o
> > > code that uses it (if I'm incorrect I'll be glad to do a V2).
> > >
> > I submitted a pull request for this. if you have any other suggestions
> > or if we need to have any other details we can update this pull request.
> > https://github.com/devicetree-org/dt-schema/pull/146
> 
> Thanks for doing this.   However, why a u8 array?  The registers are
> defined as u16 so it would be more natural to use a u16 array, each
> entry giving
> all of the data for a single lane.  In our implementation we read a
> u16 and we write it to the register -- what advantage is there by
> using a u8 array?
> 
> Also if there are 16 lanes, you will need 32 maxItems, correct?

I added these questions to the github PR.

Also, why does it define gen3-eq-presets, gen4-eq-presets,
gen5-eq-presets, and gen6-eq-presets?  I think there's only a single
place to write these values (the Lane Equalization Control registers,
PCIe r6.0, sec 7.7.3.4), isn't here?  How would software choose the
correct values to use?

> > >> - Krishna Chaitanya
> > >>>> +
> > >>>> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> > >>>
> > >>> minItems: 1
> > >>> maxItems: 16
> > >>>
> > >>> Last I saw, you can only have up to 16 lanes.
> > >>>
> > >>> Rob
> > >>>
> > >



