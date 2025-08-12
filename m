Return-Path: <linux-pci+bounces-33869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32399B22DD6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61F250543F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05F2279DDD;
	Tue, 12 Aug 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/OEfawe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED71A9F8B;
	Tue, 12 Aug 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016217; cv=none; b=F/HVkOhvpbE/0dCyxsQISRrRWyzwVjZ0C/hEpP99EuJcny9pU5FKc+HOOF05+Iw7W9xycrH8ZBNH+Uk5AWlecQXJHOhbvajsDIjCPTazoKp9mlT6Mc53VM0oHOAmHxBCuPL2nY1JY2QACMUqALLpdltOFTz/RdrY387jBsF+8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016217; c=relaxed/simple;
	bh=4vdLYj8onEuvH/MXXLnAQFBePXxWY8yQZFRDfo+p5Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sAfiTe6PXM9BWp2xJjZBgbCCb8y0SuiStBL/LkG+TdD9CjhEcJsQyMoYYPzYLABjhk/5aXfqIdiIxZiBA7xIdsigpprzSALtNJHOnTS/tGJ8v+aOK6xSbhvHVOLSnRdgTLpM6v3waMb5YyQVMpuHuevFyCkKlf60ob538Z1jwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/OEfawe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9F9C4CEF0;
	Tue, 12 Aug 2025 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016217;
	bh=4vdLYj8onEuvH/MXXLnAQFBePXxWY8yQZFRDfo+p5Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S/OEfawesxF6JiuSKpEmq5yRCtAAgnY5wHQJGqqMuoYS7JLV20eHNHUjOKqC3+Zh4
	 U2mLFIn+iaIXjxxV3o6MPIN1ZVr0ph88GZ8b8E8QfdvfwyUx/j6XFagmNpL1RDNu4V
	 GgDgmlmWp8Rp2V4uB6RjLuIV828KGm06dSKt1hRKwLoG0NBZw3EmBlmUTreD5f10sT
	 fdZwtu4mtGbT2gZT5cjSLSHQo98pbZu4iAgfq7qR4Th001IdGotmrL89N7Zd9Ix9Rm
	 nR45CRI7RJf0x9J4G1AzAOTRrLQVGhJZA15R/d6kKwebJeF2znCEJcAZyLvT6mKEbu
	 p9er2rUyIl7cQ==
Date: Tue, 12 Aug 2025 11:30:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250812163015.GA194338@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJtUjnuWr1S31jhX@kbusch-mbp>

On Tue, Aug 12, 2025 at 08:49:50AM -0600, Keith Busch wrote:
> On Tue, Aug 12, 2025 at 08:27:15AM +0200, Nam Cao wrote:
> > On Mon, Aug 11, 2025 at 05:46:59PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Aug 11, 2025 at 07:39:35AM +0200, Nam Cao wrote:
> > > > Commit d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> > > > added a WARN_ON sanity check that child devices support MSI-X, because VMD
> > > > document says [1]:
> > > > 
> > > >     "Intel VMD only supports MSIx Interrupts from child devices and
> > > >     therefore the BIOS must enable PCIe Hot Plug and MSIx interrups [sic]."
> > > 
> > > Can VMD tell the difference between an incoming MSI MWr transaction
> > > and an MSI-X MWr?
> > > 
> > > I wonder if "MSIx" was meant to mean "VMD only supports MSI or MSI-X
> > > interrupts, not INTx interrupts, from child devices"?
> > 
> > I don't know, sorry. I am hoping that the VMD maintainers can help us here.
> 
> The doc you linked is riddled with errors. The original vmd commit
> message is more accurate: VMD domains support child devices with MSI and
> MSI-x interrupts. The VMD device can't even tell the difference which
> one the device is using. It just manipulates messages sent to the usual
> APIC address 0xfeeXXXXX.

Thanks, Keith!  I updated the commit log like this:

  d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()") added a
  WARN_ON sanity check that child devices support MSI-X, because VMD document
  says [1]:

    Intel VMD only supports MSIx Interrupts from child devices and therefore
    the BIOS must enable PCIe Hot Plug and MSIx interrups [sic].

  However, the VMD device can't even tell the difference between a child
  device using MSI and one using MSI-X.  Per 185a383ada2e ("x86/PCI: Add
  driver for Intel Volume Management Device (VMD)"), VMD does not support
  INTx interrupts, but does support child devices using either MSI or MSI-X.

  Remove the sanity check to avoid the unnecessary WARN_ON reported by Ammar.


