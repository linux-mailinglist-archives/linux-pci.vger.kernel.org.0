Return-Path: <linux-pci+bounces-4162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FC686A2DC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 23:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B7FB254F2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0D55C06;
	Tue, 27 Feb 2024 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlyN6aOc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415154664;
	Tue, 27 Feb 2024 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074484; cv=none; b=PLJq1rQA8N0q/w6vf8TklF3wGGbO+Ct/evgOg3iVVRW/W4m7Qm0ab68Pnt7+NgnVJme938oi07CDKzzkpkND2wR2bkgYy+vsiphu/gBIIfCsGFKNHbWHIH8M1cUkTFma1t/FYp4dy/hcnzdy/XY98ZncBcmoNCjYpYF3jP6KunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074484; c=relaxed/simple;
	bh=6m0RaLVBGIBZ4UX8emf3gfaLlwLoklTp7XJ281diEVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rZ+QvEtzVkYMbK09xTM2I1OHeSHWTGKrebKQTCTaw3NWI1DhWdeb4I5Sf4+go/pRxR3oh6aAnxG4v3iCiwhwSZmw0F/kWKutCSf2b/bYYo+C9txVLZC6OC8QBvWhmJhvLyg2/eYzbBMjuwrK4ZiHM/VAzHMh9wcE/AMiy/Swufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlyN6aOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AFDC433F1;
	Tue, 27 Feb 2024 22:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709074483;
	bh=6m0RaLVBGIBZ4UX8emf3gfaLlwLoklTp7XJ281diEVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UlyN6aOcxmFEeWfmoKbn/U5wEhuz8T5RHwAvu2iEQ27J6wiafS4VN+rjzZe3aHtw+
	 VMOQtQ+/hzaaQ4JGYjfeuCtGFiTcB8YK2JQzfKEVSjNKuUa6nihxV+WyFk+flFHv+f
	 oy42asMXSUtBpvt1yr8JoZjK3iW4sOT5SkUGEMW3lG7cSfJH2eqfKHuwyx+oVebPB7
	 AvUthh5DGx/m5v8Zd1bSml3KjiNDL51L+4AobvcP0kG5QuDk3wX1w8/WlfdFONycNX
	 Nf0db2JNCHLyBtTJXjZCkNd44h2wcwmLQup0rl6y1vwKZ/J1OaSewIBzUUm3Rg6ANi
	 MjYek+Glxlj7w==
Date: Tue, 27 Feb 2024 16:54:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240227225442.GA249898@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227184015.GS2587@thinkpad>

On Wed, Feb 28, 2024 at 12:10:15AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 27, 2024 at 11:37:05AM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 27, 2024 at 10:38:40PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Feb 27, 2024 at 10:25:35AM -0600, Bjorn Helgaas wrote:
> > > 
> > > [...]
> > > 
> > > > > Ok, I got the issue. TBH, I added the device tree property based on
> > > > > the existing quirks for the ACPI devices. But none of the DT based
> > > > > platforms I'm aware of (even the legacy Qcom MSM8996 chipset
> > > > > released in early 2016) doesn't have any issue with D3hot. But I'm
> > > > > just nervous to assume it is the case for all the DT based platforms
> > > > > in the wild.
> > > > > 
> > > > > But to proceed further, what is your preference? Should we ammend
> > > > > the DT property to make it explicit that the propery only focuses on
> > > > > the D3hot capability of the bridge and it works as per the spec
> > > > > (PMCSR) or bite the bullet and enable D3hot for all the non-ACPI
> > > > > platforms?
> > > > > 
> > > > > We can add quirks for the bridges later on if we happen to receive
> > > > > any bug report.
> > > > 
> > > > I would assume all devices support D3hot via PMCSR per spec.  We can
> > > > add quirks if we discover something that doesn't.
> > > 
> > > When you say "all devices", are you referring to bridges in DT
> > > platforms or the bridges across all platforms?
> > 
> > This patch is only concerned with DT, so that's what I'm commenting on
> > here.  I don't know how to untangle the question of ACPI systems.
> 
> Ok, I just wanted to confirm.
> 
> > This patch affects platform_pci_bridge_d3(), so just based on the
> > "platform" in the function name, I would expect it to be concerned
> > with the D3cold case and whether the platform supports controlling
> > main power.
> > 
> > It looks like this patch says "we can put devices in D3cold if DT has
> > 'supports-d3'".  But I don't know how to make sense of that because
> > that requires (a) platform hardware to control main power and (b)
> > software that knows how to use that hardware.  Wouldn't this require a
> > little more DT description, like "regulator X controls main power for
> > this bridge"?  And then an OS would only be able to actually use
> > D3cold if it knows how to *operate* the regulator, and it doesn't seem
> > like DT could answer that.
> 
> Fair point. And for most of the DT based platforms, there is no
> dedicated power supply for the bridge described in DT. So
> transitioning the bridge to D3cold is not entirely possible in the
> OS.
> 
> Since we concluded that enabling D3hot for all bridges in DT
> platforms is the way to go, I'll drop supporting the DT property in
> next version.
> 
> I'll also remove it from the binding.

Sounds good, thanks!

