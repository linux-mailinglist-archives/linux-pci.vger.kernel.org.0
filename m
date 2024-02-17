Return-Path: <linux-pci+bounces-3657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BA858A82
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 01:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53F61C202F1
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FA2594;
	Sat, 17 Feb 2024 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjdYzigu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80A1FA6
	for <linux-pci@vger.kernel.org>; Sat, 17 Feb 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128446; cv=none; b=Vs2cSxPL8oqWvv12XCfiTX150396tEzCXMVvCvCls3JUoxXAd5WtXCHDCwn9XTflNPgr1b5D9vcj4Ue8RzgLopLke+26MdF+ObrhCMZDefoUfpRd1MG4mVwDm61XLNZMhHMjAK4nih09S/7A586MkNniyHBNFd0A9ONgZ9P+1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128446; c=relaxed/simple;
	bh=L5UMDtvf1riAPjgsS68Lb4/wKwZ3yEfzaSwXNSGUVx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rxGh2M+9k/rhyrx0EDDYE9AHsncHw70luXgry6ABGsqcVlXCVbgJJaQw6ZhNAN484PkT8jfAdR2ksc8koAI2twnIKE/S/RZxfG9FuJswYrgYuA/e+MES04MmoyCOZeIRGM8eVSg+VdE5lJZt2pSiEUAKrLAUh407GbUhIVH1aWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjdYzigu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E54C433C7;
	Sat, 17 Feb 2024 00:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708128445;
	bh=L5UMDtvf1riAPjgsS68Lb4/wKwZ3yEfzaSwXNSGUVx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CjdYzigupKCzPSwut1HXBPpPkvYqgs3ZWoxM2/YVurXAXZG2t3oZcF+t7L0zULkjk
	 YUClxelBM5k2nwSKLRrzND3OzuDgbhsPiiojMXUMow31BXxptQTv/WayyaTxR6wLu3
	 KIpW6ODDA5485VFbxJv2K64e1HkSFlRcCxMa3UdEVjFWaXeCZjsVBTQAW4uOjxOiLQ
	 VP+DURnoBqt4zkfn9xUctyIAKooM8f6apIwNBJ8tf+yp637Zl+uMrPen0wAEYhhjv1
	 V7xA5Btoi7v7dP/dS2miV1Jg9fy+o5fB/aDyYxLKObqOMOE622kKZOuHawdyPxaBxK
	 LktTA8Ge0kC8A==
Date: Fri, 16 Feb 2024 18:07:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240217000723.GA1294711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215140908.GA3619@thinkpad>

On Thu, Feb 15, 2024 at 07:39:08PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 14, 2024 at 04:02:28PM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > > ...
> > 
> > > ... And for your usecase, allowing the controller driver to
> > > start the link post boot just because a device on your Pixel
> > > phone comes up later is not a good argument. You _should_not_
> > > define the behavior of a controller driver based on one
> > > platform, it is really a bad design.
> > 
> > I haven't followed the entire discussion, and I don't know much
> > about the specifics of Ajay's situation, but from the controller
> > driver's point of view, shouldn't a device coming up later look
> > like a normal hot-add?
> 
> Yes, but most of the form factors that these drivers work with do
> not support native hotplug. So users have to rescan the bus through
> sysfs.
> 
> > I think most drivers are designed with the assumption that
> > Endpoints are present and powered up at the time of host
> > controller probe, which seems a little stronger than necessary.
> 
> Most of the drivers work with endpoints that are fixed in the board
> design (like M.2), so the endpoints would be up when the controller
> probes.
>
> > I think the host controller probe should initialize the Root Port
> > such that its LTSSM enters the Detect state, and that much should
> > be basically straight-line code with no waiting.  If no Endpoint
> > is attached, i.e., "the slot is empty", it would be nice if the
> > probe could then complete immediately without waiting at all.
> 
> Atleast on Qcom platforms, the LTSSM would be in "Detect" state even
> if no endpoints are found during probe. Then once an endpoint comes
> up later, link training happens and user can rescan the bus through
> sysfs.

Can the hardware tell us when the link state changes?  If so, we
should be able to scan the bus automatically without the need for
sysfs.  For example, if the Root Port advertised PCI_EXP_FLAGS_SLOT, 
we might be able to use a Data Link Layer State Changed interrupt to
scan the bus via pciehp when the Endpoint is powered up, even if the
Endpoint is actually soldered down and not physically hot-pluggable.

Bjorn

