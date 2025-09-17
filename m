Return-Path: <linux-pci+bounces-36344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FCB7C5D7
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E521BC3B86
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD72F3617;
	Wed, 17 Sep 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkOcHhF8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5292D9EE5;
	Wed, 17 Sep 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108140; cv=none; b=aFv/5AafTuqEBntg2xiQdAWCz5YQden83dN0OraKtyQl4F6nm6qhxpscayk5SXoTDhdPxt9LAryQyBqyagUe74WzaQGqzv8pjoeyl4Ce5F8NRzib2cYQqrKxLtlXlTdmm1zyo1UfKSOnVJqNPgbUbc8UD/dFzWQ3UJe/ndWz0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108140; c=relaxed/simple;
	bh=P8qzGWIhByRFZr7nwyU8aErrXN4ExIt9jBI3wNw3DOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ng6IFEdbGunDvXsXITWN4qwnM6mXB+t6Eh2IzX4ljyci7a6eBgMwZk2B/+Szcm15plGx2V39LMTdNAySQAsuJYsPnlgAydjnKkxxzKjbcVtwqrtDKdBtyJBAJQ2Cy8PjvxQHwRFLfTtJtldA8g0oMNjZeFD/G9PHvkRm6UBWF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkOcHhF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F68C4CEF0;
	Wed, 17 Sep 2025 11:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758108140;
	bh=P8qzGWIhByRFZr7nwyU8aErrXN4ExIt9jBI3wNw3DOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dkOcHhF8Tzhf0qmstpd8TJR+CwpzHhukAz4m9vupb6UvHShWYkw1MkqHh9q/AAvqr
	 6vkTRBEt9Qondm1AWJlecwk46MZPAvuYqGMNuVjIZMKMnqt2rUY/0EAaKfJKPvujkY
	 MonE5s/ljRaU0Mss9XIi2DMw09nzmss4SrCthOviw0aSM26EIbJkUVP+d7Fru5gSfj
	 bsAksP3XDV0GQZO38LaGzxofCGsUIFMtUNN+LO0wG2g/FAomCX2C0pKNy79fblr3S/
	 2xHQ4LVqOndRB8Ivlclljhcuzkf5oQJ0kaDUAisrKfdpccFOEbvxV2DLjRiwZEtKY4
	 15xUV3ByVE3xA==
Date: Wed, 17 Sep 2025 06:22:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set
 by BIOS for devicetree platforms
Message-ID: <20250917112218.GA1844955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <frmzvhnhljy23xds7lnmo23zg35wxpzu4pvabnc6v6vz7qn2lj@gk25cglbpn3q>

[+cc Kai-Heng, Rafael, Heiner, AceLan; response to
https://lore.kernel.org/r/20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com]

On Wed, Sep 17, 2025 at 04:14:42PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Sep 16, 2025 at 12:15:46PM GMT, Bjorn Helgaas wrote:
> > On Tue, Sep 16, 2025 at 09:42:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> > > the BIOS (through LNKCTL) during device initialization. This was done
> > > conservatively to avoid issues with the buggy devices that advertise
> > > ASPM capabilities, but behave erratically if the ASPM states are enabled.
> > > So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
> > > states that were known to work for the devices.
> ...

> > For debuggability, I wonder if we should have a pci_dbg() at the point
> > where we actually update PCI_EXP_LNKCTL, PCI_L1SS_CTL1, etc?  I could
> > even argue for pci_info() since this should be a low-frequency and
> > relatively high-risk event.
> 
> I don't know why we should print register settings since we are explicitly
> printing out what states are getting enabled.

My thinking here is that we care about is what is actually written to
the device, not what we *intend* to write to the device.

There's a lot of complicated aspm.c code between setting
link->clkpm_default/aspm_default and actually programming the device,
and when debugging a problem, I don't want to have to parse all that
code to derive the register values.

