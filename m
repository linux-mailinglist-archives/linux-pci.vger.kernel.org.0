Return-Path: <linux-pci+bounces-10108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F492DB18
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C6B221D0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7C12F38B;
	Wed, 10 Jul 2024 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHen+WkZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E5D535;
	Wed, 10 Jul 2024 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647519; cv=none; b=hQJFJkkq2/UyjI1Dlr+vF3/6icsybfk65+b15iPkeEE52CTZiYBPwkUt6weFKWj/UhrTWJWZojSbFXiswmBnl5bIdatuLKTLmD378MzPJ30l7QqXz3XS85fRlvdx1irQ8H9RGmqrGvwqSu0Jihbi/rjFJC6ZzVQ/byuv7/AfeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647519; c=relaxed/simple;
	bh=WLMHNlkbdy+hBuh8DELkEFwB4rHb8miMeNdbIm324AI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r6YZXZOKn+ymlkvWjnJ3h0PtVq4YdTTvK9ZerAl1hKVvDLHqh0qY36A/A89hndPAxC/jvAx9um8didFtbukYEj44WXJZIKW/hP7HbRv+j/QYFndpgO4sq9Y2bZREE/8kV6SFP08ZluPMSHin1RGFRMnb0CoKkMkwqqZv2NOlczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHen+WkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB6DC32781;
	Wed, 10 Jul 2024 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720647519;
	bh=WLMHNlkbdy+hBuh8DELkEFwB4rHb8miMeNdbIm324AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kHen+WkZgQRTYZmykiydiAJ30UEEi3/hUDFTVE0KR6MeqOEr0ZZEeJkhSz8atu6qQ
	 hdRpD2aqFq9qgczlY7O9wz0XzHDq7316TyRqIKqltJPOuWh8H0/mXMRxUwC03AZHbq
	 3BAPIU9FLD/aOrKIh4sub+329Rc8qB2DlQehhgzpuy5VdvSzYWLEP1NOHd0fgbtj9z
	 /H8OLyvo4NdGkuHL6Q7gAnAGVTQjFL9PF+Ogi19ITl3Z5bojhUNJjlbb0hLKhcSUkT
	 hhh5pNlKNq3kH4JFrD9o2sHXQniUbPmolANxbAGPt/XjEb0eYHvfDLIfUjmHHuRgmv
	 XWNrL6kMk+L+g==
Date: Wed, 10 Jul 2024 16:38:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: George-Daniel Matei <danielgeorgem@chromium.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nic_swsd@realtek.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
Message-ID: <20240710213837.GA257340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com>

On Wed, Jul 10, 2024 at 05:09:08PM +0200, George-Daniel Matei wrote:
> >> Added aspm suspend/resume hooks that run
> >> before and after suspend and resume to change
> >> the ASPM states of the PCI bus in order to allow
> >> the system suspend while trying to prevent card hangs
> >
> > Why is this needed?  Is there a r8169 defect we're working around?
> > A BIOS defect?  Is there a problem report you can reference here?
> 
> We encountered this issue while upgrading from kernel v6.1 to v6.6.
> The system would not suspend with 6.6. We tracked down the problem to
> the NIC of the device, mainly that the following code was removed in
> 6.6:
>
> > else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
> >         rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
>
> For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
> the reason, L1 was observed to cause some problems
> (https://bugzilla.kernel.org/show_bug.cgi?id=217814). We use a Raptor
> Lake soc and it won't change residency if the NIC doesn't have L1
> enabled. I saw in 6.1 the following comment:

Can you verify that the problem still exists in a current kernel,
e.g., v6.9?

If this is a regression that's still present in v6.9, we need to
identify the commit that broke it.  Maybe it's 90ca51e8c654 ("r8169:
fix ASPM-related issues on a number of systems with NIC version from
RTL8168h")?

> > Chips from RTL8168h partially have issues with L1.2, but seem
> > to work fine with L1 and L1.1.
>
> I was thinking that disabling/enabling L1.1 on the fly before/after
> suspend could help mitigate the risk associated with L1/L1.1 . I know
> that ASPM settings are exposed in sysfs and that this could be done
> from outside the kernel, that was my first approach, but it was
> suggested to me that this kind of workaround would be better suited
> for quirks. I did around 1000 suspend/resume cycles of 16-30 seconds
> each (correcting the resume dev->bus->self being configured twice
> mistake) and did not notice any problems. What do you think, is this a
> good approach ... ?

Whatever the problem is, it definitely should be fixed in the kernel,
and Ilpo is right that it *should* be done in the PCI core ASPM
support (aspm.c) or at least with interfaces it supplies.

Generally speaking, drivers should not need to touch ASPM at all
except to work around hardware defects in their device, but r8169 has
a long history of weird ASPM stuff.  I dunno if that stuff is related
to hardware defects in the r8169 devices or if it is workarounds for
past or current defects in aspm.c.

> > This doesn't restore the state as it existed before suspend.  Does
> > this rely on other parts of restore to do that?
> 
> It operates on the assumption that after driver initialization
> PCI_EXP_LNKCTL_ASPMC is 0 and that there are no states enabled in
> CTL1. I did a lspci -vvv dump on the affected devices before and after
> the quirks ran and saw no difference. This could be improved.

Yep, we can't assume any of that because the PCI core owns ASPM
config, not the driver itself.

> > What's the root cause of the issue?
> > A silicon bug on the host side?
> 
> I think it's the ASPM implementation of the soc.

As Heiner pointed out, if it's a SoC defect, it would potentially
affect all devices and a workaround would have to cover them all.

Side note: oops, quoting error below, see note about top-posting here:
https://people.kernel.org/tglx/notes-about-netiquette

> On Tue, Jul 9, 2024 at 12:15 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >
> > On 08.07.2024 19:23, Bjorn Helgaas wrote:
> > > [+cc r8169 folks]
> > >
> > > On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote:
> > >> Added aspm suspend/resume hooks that run
> > >> before and after suspend and resume to change
> > >> the ASPM states of the PCI bus in order to allow
> > >> the system suspend while trying to prevent card hangs
> > >
> > > Why is this needed?  Is there a r8169 defect we're working around?
> > > A BIOS defect?  Is there a problem report you can reference here?
> ...

