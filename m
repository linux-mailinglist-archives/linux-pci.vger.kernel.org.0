Return-Path: <linux-pci+bounces-36697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED7B9212A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19912A296B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EDE30EF6F;
	Mon, 22 Sep 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C06HFul/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664B30E82A;
	Mon, 22 Sep 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556431; cv=none; b=bA2dLQvXcgimXg4b5Gjlt0SauStDVDF4JsLpV8f+HHx9mjmJn1aAm6ZjHhhORx4rGgmXR/ANY0DveRL1FQO1v+PTt+lLq85bkSnoLISTHvTKdIMtdr/t9PivqAwxXols5tJxvo/ccEgnM3lCPl4FDg1oTj08W7azGRyKErJl3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556431; c=relaxed/simple;
	bh=aRbXPB1JpMvAIJq5asAovoC0H16Nxldusb6Zozv6hHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGyMT9NNjAuHCQidNOT2/anOOuc5/y1tc9sxiWcoQ5rm6ooA4nFQB2zifMjyGNcgTlHtknC8mVafG6CwyrStHvVm/M1MmzxHLFih7EEYW5ktC6gTNctUZO2ULkdNgE6my0La8lGzcSe8gOnC32GMNucBnuDB6MPvD09oxeDukiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C06HFul/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED55EC4CEF0;
	Mon, 22 Sep 2025 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556430;
	bh=aRbXPB1JpMvAIJq5asAovoC0H16Nxldusb6Zozv6hHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C06HFul/szSJI0xrMjnZM1Ks1trKCXzVjBMOMrKb2VFViBpRuvzgO+pmJkv1umK2C
	 JnSK7Nyww7INSIyb/94rRMQm6binnV5LaXoLcngcUWamHTE5fCbpMCyhJFIE96WxB2
	 l/MZIDaLi3jj0kF3lcEbm3Cd+82Y1Ir4bM+q9X5NOXMlCEduS+V+5VTCOIuwGtnmU9
	 bgsQhrpaKfRqdXPFVz/1Rg7ndFcKCEaMoHIHZ4PawV8hKiR61Gm11baBOQuJFjGo+s
	 EAg28HFex3cQCPMFUIXUOQoTgW4JEcsHt11sauBMZS6A8YVXNICsQUYOdY+FquElN+
	 OcHa8LIlTl2Kw==
Date: Mon, 22 Sep 2025 21:23:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set
 by BIOS for devicetree platforms
Message-ID: <oc23e5sgo74wpjpaaefc6or5f54crfaeyer5zwst3wyyiauhxg@ess265fdcbeu>
References: <frmzvhnhljy23xds7lnmo23zg35wxpzu4pvabnc6v6vz7qn2lj@gk25cglbpn3q>
 <20250917112218.GA1844955@bhelgaas>
 <jgidvwogoopfgtmxywllxl76lap42s4fhzt23ldncgtzfvy5ir@xs7pnhuz2nxs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jgidvwogoopfgtmxywllxl76lap42s4fhzt23ldncgtzfvy5ir@xs7pnhuz2nxs>

On Wed, Sep 17, 2025 at 06:33:53PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 17, 2025 at 06:22:18AM GMT, Bjorn Helgaas wrote:
> > [+cc Kai-Heng, Rafael, Heiner, AceLan; response to
> > https://lore.kernel.org/r/20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com]
> > 
> > On Wed, Sep 17, 2025 at 04:14:42PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Sep 16, 2025 at 12:15:46PM GMT, Bjorn Helgaas wrote:
> > > > On Tue, Sep 16, 2025 at 09:42:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> > > > > the BIOS (through LNKCTL) during device initialization. This was done
> > > > > conservatively to avoid issues with the buggy devices that advertise
> > > > > ASPM capabilities, but behave erratically if the ASPM states are enabled.
> > > > > So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
> > > > > states that were known to work for the devices.
> > > ...
> > 
> > > > For debuggability, I wonder if we should have a pci_dbg() at the point
> > > > where we actually update PCI_EXP_LNKCTL, PCI_L1SS_CTL1, etc?  I could
> > > > even argue for pci_info() since this should be a low-frequency and
> > > > relatively high-risk event.
> > > 
> > > I don't know why we should print register settings since we are explicitly
> > > printing out what states are getting enabled.
> > 
> > My thinking here is that we care about is what is actually written to
> > the device, not what we *intend* to write to the device.
> > 
> > There's a lot of complicated aspm.c code between setting
> > link->clkpm_default/aspm_default and actually programming the device,
> > and when debugging a problem, I don't want to have to parse all that
> > code to derive the register values.
> 
> Sure, but that is not strictly related to this series I believe. I will add a
> patch for that at the start of this series so that you can merge it
> independently.
> 

I'm going to send this patch separately from this series.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

