Return-Path: <linux-pci+bounces-2007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB882A065
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 19:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771992868FA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637444CE05;
	Wed, 10 Jan 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3XvDp1x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3234B5A5
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 18:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791F5C433F1;
	Wed, 10 Jan 2024 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704912422;
	bh=28sUgNMuJk3lGbNWFP+z5pW+bpRodb8yQmim84cXVk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N3XvDp1xVrvpizp3yx0SJ2in3PZqUYDFF7UbkrjzUPx3D27q7nuaPsOJ5pnW9TNqX
	 qeVFGPqU/lt+3Wwrg0F3mpUMPTHJ9cRMnS084gLPT+nYu0OhW7JsK33XwU3TZnrSPt
	 C3alDMnGxVMsKT19VMa5y5jNjqfPVi4WU8pMhd5V5r9TxKQqox88VfXa0XY8Sms8mF
	 AIOh64ZquZVwvkW+IGO/B4fSJ50KfYLsnpOe5GXU5cX968H0fSkhirtyFHUSH0UUKR
	 Q440/YTHxShz+nBK1zPb/VwAIfhi7q5L++DY5u5pIdvib+Ddm/P+b/NoUeIwY8EZvx
	 oAjFYGWDe7dJw==
Date: Wed, 10 Jan 2024 12:46:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
	rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
	tasev.stefanoska@skynet.be, enriquezmark36@gmail.com,
	kernel@witt.link, koba.ko@canonical.com, wse@tuxedocomputers.com,
	ilpo.jarvinen@linux.intel.com, ricky_wu@realtek.com,
	linux-pci@vger.kernel.org, Michael Schaller <michael@5challer.de>
Subject: Re: [PATCH v5] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20240110184659.GA2113074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f95657a40a596c7f9ba0bad413fcd414514cf2b7.camel@linux.intel.com>

On Wed, Jan 10, 2024 at 07:24:31AM -0800, David E. Box wrote:
> On Thu, 2023-12-28 at 18:30 -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 28, 2023 at 04:31:12PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 20, 2023 at 05:12:50PM -0800, David E. Box wrote:

> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 55bc3576a985..3c4b2647b4ca 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > 
> > > > @@ -1579,7 +1579,7 @@ static void pci_restore_pcie_state(struct pci_dev
> > > > *dev)
> > > >  {
> > > > ...
> > 
> > > > +        So we restore here only the
> > > > +	 * LNKCTL register with the ASPM control field clear. ASPM will
> > > > +	 * be restored in pci_restore_aspm_state().
> > > > +	 */
> > > > +	val = cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
> > > > +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
> > > 
> > > When CONFIG_PCIEASPM is not set, we will clear ASPMC here and never
> > > restore it.  I don't know if this ever happens.  Do we need to worry
> > > about this?  Might firmware restore ASPMC itself before we get here?
> > > What do we want to happen in this case?
> 
> I just checked this. L1 does get disabled which we don't want. We
> need to save and restore the BIOS ASPM configuration even when
> CONFIG_PCIEASPM is not set.

There's some other ASPM stuff that we want even when CONFIG_PCIEASPM
is not set.  I think some of that code is currently in probe.c and
pci.c.

I can't find it right now, but we had some discussion about moving
that code into aspm.c, compiling aspm.c unconditionally, and adding
CONFIG_PCIEASPM ifdefs inside it for these cases.  Maybe this is the
time do to that?  If so, probably a preliminary patch or two to do
the code movement without any functional changes, followed by the
actual fixes.

> > > Since ASPM is intertwined with the PCIe Capability, can we call
> > > pci_restore_aspm_state() from here instead of from
> > > pci_restore_state()?
> > > 
> > > Calling it here would make it easier to see the required ordering
> > > (LNKCTL with ASPMC cleared, restore ASPM L1SS, restore ASPMC) and
> > > it would be obvious that none of the other stuff in
> > > pci_restore_state() is relevant (PASID, PRI, ATS, VC, etc).
> > > 
> > > If that could be done, I think it would make sense to do the same with
> > > pci_save_aspm_state() even though it's a little more independent.
> 
> Makes sense
> 
> > The lspci output in Michael's report at
> > https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de
> > reminded me that LTR is important for L1.2, and we currently have
> > this:
> > 
> >   pci_restore_state
> >     pci_restore_ltr_state
> >     pci_restore_pcie_state
> > 
> > I wonder if pci_restore_ltr_state() should be called from
> > pci_restore_pcie_state() as well?  It's intimately connected to ASPM,
> > and that connection isn't very clear in the current code.
> 
> Make sense too since LTR is a required capability for L1.2. I'll
> send updated patches after the merge window.

Sounds good, will look for them :)

Bjorn

