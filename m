Return-Path: <linux-pci+bounces-15539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85749B4E3D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5971D1F216C6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED319415D;
	Tue, 29 Oct 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXNWH8lP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5FC2BAF9;
	Tue, 29 Oct 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216432; cv=none; b=gY3m/VDUZE5Zrcuk9GxKpVtevgkJb7vHZU45qiAs8j+hLjJHFdsNpSb+l+Cu3Kh6FiSmGKr9eJOwu1yF1klg9nXDVHNM9GiOa/C6G6rbkpUq6tyIPkgkAAIj6rnhZI4KGuM4g/PKDbV+aXoeHjwHSy23rGBnMmVSFk5j44zq0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216432; c=relaxed/simple;
	bh=z8kE0zz8IskfM8xgxZLCRvPQ6P7D3DW1E454Ru1T4h8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t2uV/9LdgRFn9f/H2wSykRVOocHg3NAC/vlYQVUvfbbMvwuherdwxWkzh20MqBlfza8VYyLsXQOAjoXnl4TE3AVAbrJ4FqYlqzKXLZ5Ex8mrp7VP9k0Q/t7gih0Oitgixai86VVE4M2ITGramk/qdJdO5NpZcsrP1bD6QFmPzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXNWH8lP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025A7C4CECD;
	Tue, 29 Oct 2024 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730216432;
	bh=z8kE0zz8IskfM8xgxZLCRvPQ6P7D3DW1E454Ru1T4h8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EXNWH8lPvmk6wDf7i/EWjdwYtMKTLjKFLxvK4MQMzKiLuVurCLm7OddASuJzDegpr
	 Gzj5X7uiv9vf0ntBg/YEAk4IwleCeZjFmFIJ1dBucC1s2tWYX90zeh1iLzVvV8b37R
	 ItmC0hVKUf5dMaGilwe2zvygQRlKryIt4sw2yX/hUb9XvgibBqceM1J4kyNA3wJI+/
	 QSaKGhPkXUqCaaqr8E8EEtJtOOHx4Qz08dxtOOiaEBfrYVu1imr/IMPZgoIYXOGcIb
	 vjDVc9dcbhL/6DXuw+wC7CWh+1qYhryJvhyzhpbWN5EwTZ6fiwlmDd55BwWD+filrw
	 tBz/Ur+SjZzjA==
Date: Tue, 29 Oct 2024 10:40:30 -0500
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
Message-ID: <20241029154030.GA1157452@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <648d12f6-85d4-971a-b46d-d0e8f9db9091@quicinc.com>

On Tue, Oct 29, 2024 at 08:52:15PM +0530, Krishna Chaitanya Chundru wrote:
> On 10/29/2024 8:18 PM, Bjorn Helgaas wrote:
> > On Tue, Oct 29, 2024 at 10:22:36AM -0400, Jim Quinlan wrote:
> > > On Tue, Oct 29, 2024 at 1:17 AM Krishna Chaitanya Chundru
> > > <quic_krichai@quicinc.com> wrote:
> > > > On 10/29/2024 12:21 AM, James Quinlan wrote:
> > > > > On 10/24/24 21:08, Krishna Chaitanya Chundru wrote:
> > > > > > On 10/22/2024 12:33 AM, Rob Herring wrote:
> > > > > > > On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
> > > > > > > > Support configuration of the GEN3 preset equalization settings, aka the
> > > > > > > > Lane Equalization Control Register(s) of the Secondary PCI Express
> > > > > > > > Extended Capability.  These registers are of type HwInit/RsvdP and
> > > > > > > > typically set by FW.  In our case they are set by our RC host bridge
> > > > > > > > driver using internal registers.
> > > > > > > > 
> > > > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > > > > ---
> > > > > > > >    .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12
> > > > > > > > ++++++++++++
> > > > > > > >    1 file changed, 12 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git
> > > > > > > > a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > index 0925c520195a..f965ad57f32f 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > @@ -104,6 +104,18 @@ properties:
> > > > > > > >        minItems: 1
> > > > > > > >        maxItems: 3
> > > > > > > >    +  brcm,gen3-eq-presets:
> > > > > > > > +    description: |
> > > > > > > > +      A u16 array giving the GEN3 equilization presets, one for
> > > > > > > > each lane.
> > > > > > > > +      These values are destined for the 16bit registers known as the
> > > > > > > > +      Lane Equalization Control Register(s) of the Secondary PCI
> > > > > > > > Express
> > > > > > > > +      Extended Capability.  In the array, lane 0 is first term,
> > > > > > > > lane 1 next,
> > > > > > > > +      etc. The contents of the entries reflect what is necessary for
> > > > > > > > +      the current board and SoC, and the details of each preset are
> > > > > > > > +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
> > > > > > > 
> > > > > > > If these are defined by the PCIe spec, then why is it Broadcom specific
> > > > > > > property?
> > > > > Yes, I will remove the "brcm," prefix.
> > > > > > > 
> > > > > > Hi Rob,
> > > > > > 
> > > > > > qcom pcie driver also needs to program these presets as you suggested
> > > > > > this can go to common pci bridge binding.
> > > > > > 
> > > > > > from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
> > > > > > of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
> > > > > > through P10) and where as data rates of 64.0 GT/s use different class of
> > > > > > presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
> > > > > > have optional preset hints (Table 4-24).
> > > > > > 
> > > > > > And there is possibility that for each data rate we may require
> > > > > > different preset configuration.
> > > > > > 
> > > > > > Can we have a dt binding for each data rate of 16 byte array.
> > > > > > like gen3-eq-preset array, gen4-eq-preset array etc.
> > > > > 
> > > > > Yes, that was the idea when using "genX-eq-preset", for X in {3,4...}.
> > > > > 
> > > > > Keep in mind that this is an RFC; I have a backlog of commit submissions
> > > > > before I can submit the code that uses this DT property.  If you
> > > > > (Krishna) want to submit something now I'd be quite happy to go with
> > > > > that.  I don't believe it is acceptable to submit a bindings commit w/o
> > > > > code that uses it (if I'm incorrect I'll be glad to do a V2).
> > > > > 
> > > > I submitted a pull request for this. if you have any other suggestions
> > > > or if we need to have any other details we can update this pull request.
> > > > https://github.com/devicetree-org/dt-schema/pull/146
> > > 
> > > Thanks for doing this.   However, why a u8 array?  The registers are
> > > defined as u16 so it would be more natural to use a u16 array, each
> > > entry giving
> > > all of the data for a single lane.  In our implementation we read a
> > > u16 and we write it to the register -- what advantage is there by
> > > using a u8 array?
> > > 
> > > Also if there are 16 lanes, you will need 32 maxItems, correct?
> > 
> > I added these questions to the github PR.
> > 
> > Also, why does it define gen3-eq-presets, gen4-eq-presets,
> > gen5-eq-presets, and gen6-eq-presets?  I think there's only a single
> > place to write these values (the Lane Equalization Control registers,
> > PCIe r6.0, sec 7.7.3.4), isn't here?  How would software choose the
> > correct values to use?
> 
> 7.7.3.4 Lane Equalization Control Register is for gen3 speed, for gen4
> we had a new capability register 7.7.5.9 16.0 GT/s Lane Equalization Control
> Register for gen5 we have 7.7.6.9 32.0 GT/s Lane Equalization Control
> Register.

Oh, thank you!  I completely missed those new registers.

> for gen3 we should not use uint8 as gen3 as transmitter preset and
> receiver preset hint thus for each lane we need to have uint16 instead
> of uint8 as we are defining per lane property in driver where we use
> each uint16 value of array needs to be mapped correctly in the register.
> If we have only support for single lane then last 16 bits becomes
> invalid. so for 16 lanes we need to uint16 array each of uint16 instead
> of uint8. ( I will modify it to uint16 instead of uint16)
> 
> for remaining gen speeds we don't have receiver preset hint, and it
> requires only 8 bits to represent a lane only. so i will use only uint8
> for remaining gen speeds.
> 
> Bjorn,
> 
> from PCIe spec 8.3.3.3 Tx Equalization Presets for 8.0, 16.0, 32.0, and
> 64.0 GT/ tells which preset value we neeed to use based upon different
> parameters. Based upon the type of the board hardware one has to
> calculate the preset value and provide them using these properties.

Thanks, I had looked at 8.3.3.3, but missed the extra 16, 32, and 64
GT/s registers because 8.3.3.3 looks more like guidance for hardware
design and firmware to calculate the values, and it doesn't mention
the registers the OS would program.

Sorry for confusing things!

Bjorn

