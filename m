Return-Path: <linux-pci+bounces-3181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE784C0E4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 00:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62840287415
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 23:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96ED1C2B3;
	Tue,  6 Feb 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve+C9mB9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373C1CD1B;
	Tue,  6 Feb 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262211; cv=none; b=IqqUDg8WQa1D8Gq5/wbmQEZ1Y/tuuXUU00JBsH0tMzEEOyE99/ysrjrCF4ZR9ombn/K5lWT+AD/SAl7p/hI8pItA7/uDqLnsVZz30/3t/77hYbSHS0257nr/UgloDX8kNqM2itqHfjP9xSxQK0rmsGmjjhvSPUj1DL7BuLHT4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262211; c=relaxed/simple;
	bh=CUW83ZHkPqjX5g7EjjrPYiIZAwsabK+k4Z7EK/jU6fM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H4B2CEOxbO5v2GYfFO2GXL/WJSTbRcQrA0jHwVBLjB/TS/32RU51bue/BbhTWxFSZxDvwMxEzbtI7oo3I6KQppfSvivLi6FLvXLUvMqKSRD1dnfiV877pkLSVVDjzF0wXcRxKI4NEUzubXD5Ffe4F4oMwkaGdbxH3pD+GcsDF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve+C9mB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20177C433C7;
	Tue,  6 Feb 2024 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707262209;
	bh=CUW83ZHkPqjX5g7EjjrPYiIZAwsabK+k4Z7EK/jU6fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ve+C9mB9800jx7gx3a8F0bEltkfUd2n5wI1lclSL/Js31dyeEcCKuoVUoDsDr8YYg
	 KLt1qCQYTGfZNgEbO0s6gGN3US++8HosbYyhDQ96TA4ySNTSn7I/5P94WesPmmZ6f8
	 wBIhLwgxg0zhoYvfruYzUaUo8LPOiiYXaNj+K9qpFV/XBJ18Z9lJtt/Bci48gvSdoC
	 TpbkzJ0BoA4hr6gr+Qg+QfxTtd2fadi5Fj6dOz7tvpPhu25P9Z69Yu5OxHFHNpLciR
	 loZTl2HMa2YoyXEfm40eDVpNTkwfy9DdOpeuQtBmVbCQkoJyc4eOcdbereHInZoQzH
	 un6qQ/LY6MnHg==
Date: Tue, 6 Feb 2024 17:30:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: puranjay12@gmail.com, Jian-Hong Pan <jhp@endlessos.org>,
	Johan Hovold <johan@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
Message-ID: <20240206233007.GA886412@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cfc65c594deef33f24b60a66b7c78c742da7203.camel@linux.intel.com>

On Tue, Feb 06, 2024 at 01:25:29PM -0800, David E. Box wrote:
> On Mon, 2024-02-05 at 15:05 -0800, David E. Box wrote:
> > On Mon, 2024-02-05 at 16:42 -0600, Bjorn Helgaas wrote:
> > > On Mon, Feb 05, 2024 at 11:37:16AM -0800, David E. Box wrote:
> > > > On Fri, 2024-02-02 at 18:05 -0600, Bjorn Helgaas wrote:
> > > > > On Fri, Feb 02, 2024 at 03:11:12PM +0800, Jian-Hong Pan wrote:
> > > > ...
> > > 
> > > > > > @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_dev
> > > > > > *pdev,
> > > > > > void *userdata)
> > > > > >         pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT,
> > > > > > ltr_reg);
> > > > > >         pci_info(pdev, "VMD: Default LTR value set by driver\n");
> > > > > 
> > > > > You're not changing this part, and I don't understand exactly how LTR
> > > > > works, but it makes me a little bit queasy to read "set the LTR value
> > > > > to the maximum required to allow the deepest power management
> > > > > savings" and then we set the max snoop values to a fixed constant.
> > > > > 
> > > > > I don't think the goal is to "allow the deepest power savings"; I
> > > > > think it's to enable L1.2 *when the device has enough buffering to
> > > > > absorb L1.2 entry/exit latencies*.
> > > > > 
> > > > > The spec (PCIe r6.0, sec 7.8.2.2) says "Software should set this to
> > > > > the platform's maximum supported latency or less," so it seems like
> > > > > that value must be platform-dependent, not fixed.
> > > > > 
> > > > > And I assume the "_DSM for Latency Tolerance Reporting" is part of the
> > > > > way to get those platform-dependent values, but Linux doesn't actually
> > > > > use that yet.
> > > > 
> > > > This may indeed be the best way but we need to double check with our
> > > > BIOS folks.  AFAIK BIOS writes the LTR values directly so there
> > > > hasn't been a need to use this _DSM. But under VMD the ports are
> > > > hidden from BIOS which is why we added it here. I've brought up the
> > > > question internally to find out how Windows handles the DSM and to
> > > > get a recommendation from our firmware leads.
> > > 
> > > We want Linux to be able to program LTR itself, don't we?  We
> > > shouldn't have to rely on firmware to do it.  If Linux can't do
> > > it, hot-added devices aren't going to be able to use L1.2,
> > > right?
> > 
> > Agreed. We just want to make sure we are not conflicting with what
> > BIOS may be doing.
> 
> So the feedback is to run the _DSM and just overwrite any BIOS
> values. Looking up the _DSM I saw there was an attempt to upstream
> this 4 years ago [1]. I'm not sure why the effort stalled but we can
> pick up this work again.
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20201015080311.7811-1-puranjay12@gmail.com/

There was a PCI SIG discussion about this a few years ago that never
really seemed to get resolved:
https://members.pcisig.com/wg/PCIe-Protocol/mail/thread/35064

Unfortunately that discussion is not public, but the summary is:

  Q: How is the LTR_L1.2_THRESHOLD value determined?

     PCIe r5.0, sec 5.5.4, says the same value must be programmed into
     both Ports.

     A: As noted in sec 5.5.4, the value is determined primarily by
	the amount of time it will take to re-establish the common
	mode bias on the AC coupling caps, and it is assumed that the
	BIOS knows this.

  Q: How are the LTR Max Snoop values determined?

     PCI Firmware r3.3, sec 4.6.6, says the LTR _DSM reports the max
     values for each Downstream Port embedded in the platform, and the
     OS should calculate latencies along the path between each
     Downstream Port and any Upstream Port (Switch Upstream Port or
     Endpoint).

     Of course, Switches not embedded in the platform (e.g., external
     Thunderbolt hierarchies) will not have this _DSM, but I assume
     they should contribute to this sum?

     A: The fundamental problem is that there is no practical way for
	software to discover the AC coupling capacitor sizes and
	common mode bias circuit impedance.

	Software could compute conservative values, but they would
	likely be 10x worse than typical, so the L1.2 exit latency
	would be significantly longer than actually required to be.

	The interoperability issues here were understood when
	designing L1 Substates, but no viable solution was found.

So the main reason Puranjay's work got stalled is that I didn't feel
confident enough that we understood how to do this, especially for
external devices.

It would be great if somebody *did* feel confident about interpreting
and implementing all this.

Bjorn

