Return-Path: <linux-pci+bounces-1622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C49822B7D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 11:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DACB21BD0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334AC18C1B;
	Wed,  3 Jan 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdE6J6YD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A918C17;
	Wed,  3 Jan 2024 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A478C433C8;
	Wed,  3 Jan 2024 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704278421;
	bh=PzZyxGoJo4itwp7LCQZOTQ6nb/jmCq7cpRucX8CCrZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdE6J6YDCZ6DF3b3SSWz8ZSlHKxG6XKLuVhbA4iu6Ouem1gd+qLvg7qiKHFckyuLC
	 Hkuvbw+vkhBE349YCoj5Wf4EDNUg4KeCTDN2WAuGtJ6uj4GEh59CyiCC40ftqwPGrS
	 mFud03uz5rFP+SY8uGcvQ0UKG5YDzhgVWcs43e26DMsEEDW5Kdzc/mKJdTOFtRCH73
	 OgNoMilUpZmlJvbWlL5hcSMt25y+Z+XZKsf9Skyf59ED9jkt75oYMpajiZm7Dkk+fZ
	 XB+09BVOsTRVfAgcKlzuHXcBNumKS0zw6JixXUs84iDpDN4K40GCIme7n5SuxH68GF
	 XniKl+7bOeCjQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rKyfW-00010q-27;
	Wed, 03 Jan 2024 11:40:15 +0100
Date: Wed, 3 Jan 2024 11:40:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: qcom: Reshuffle reset logic in 2_7_0 .init
Message-ID: <ZZU5jqJ14HscR1Ed@hovoldconsulting.com>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
 <20231227-topic-8280_pcie-v1-1-095491baf9e4@linaro.org>
 <ZY7R581pgn3uO6kk@hovoldconsulting.com>
 <fa0fbadc-a7c3-4bea-bed7-0006db0616dc@linaro.org>
 <ZY7l828-mSGXVwrk@hovoldconsulting.com>
 <598ede70-bc01-4137-b68b-981c3d420735@linaro.org>
 <ZZPiwk1pbhLyfthB@hovoldconsulting.com>
 <07b20408-4b45-48c3-9356-730a7a827743@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b20408-4b45-48c3-9356-730a7a827743@linaro.org>

On Tue, Jan 02, 2024 at 06:03:36PM +0100, Konrad Dybcio wrote:
> On 2.01.2024 11:17, Johan Hovold wrote:
> > On Sat, Dec 30, 2023 at 02:16:18AM +0100, Konrad Dybcio wrote:
> >> On 29.12.2023 16:29, Johan Hovold wrote:
> >>> On Fri, Dec 29, 2023 at 04:01:27PM +0100, Konrad Dybcio wrote:
> >>>> On 29.12.2023 15:04, Johan Hovold wrote:
> >>>>> On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
> >>>>>> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
> >>>>>> AUX_CLK will be stuck at 'off'.
> >>>>>
> >>>>> No, this path is exercised on every boot without the aux clock ever
> >>>>> being stuck at off. So something is clearly missing in this description.
> >>>
> >>>> That's likely because the hardware has been initialized and not cleanly
> >>>> shut down by your bootloader. When you reset it, or your bootloader
> >>>> wasn't so kind, you need to start initialization from scratch.
> >>>
> >>> What does that even mean? I'm telling you that this reset is asserted on
> >>> each boot, on all sc8280xp platforms I have access to, and never have I
> >>> seen the aux clk stuck at off.
> >>>
> >>> So clearly your claim above is too broad and the commit message is
> >>> incorrect or incomplete.

> > We're clearly talking past each other. When I'm saying reset is asserted
> > on each boot, I'm referring to reset being asserted in
> > qcom_pcie_init_2_7_0(), whereas you appear to be referring to whether
> > the reset has been left asserted by the bootloader when the driver
> > probes.
> 
> OK, "boot" meant "booting the device" to me, not the PCIe controller.

Still not getting across to you apparently.

Again, the code in question is exercised on every boot and not once have
I seen a stuck clock due to reset being asserted *in*
qcom_pcie_init_2_7_0().

Now that's not what you were trying to describe as you were thinking of
reset having been left asserted *before* the driver probes (or before
qcom_pcie_init_2_7_0() is called).

See? Do you understand now what I was trying to say and why my
misinterpretation of your terse commit message lead me to claim that it
was clearly false?

> > I understand what you meant to say now, but I think you should rephrase:
> > 
> > 	At least on SC8280XP, if the PCIe reset is asserted, the
> > 	corresponding AUX_CLK will be stuck at 'off'.
> > 
> > because as it stands, it sounds like the problem happens when the driver
> > asserts reset.
> 
> Does this sound good?
> 
> "At least on SC8280XP, trying to enable the AUX_CLK associated with
> a PCIe host fails if the corresponding PCIe reset is asserted."

Yes, but you need to also say something about how this would happen, for
example, your hypothetical bootloader leaving it asserted and your actual
motivation for this change which is that it appears to be needed after
suspend. 

A commit message should be clear and self-contained and not force
reviewers to have to try to interpret what it means and guess what the
motivation for the change really is.

Johan

