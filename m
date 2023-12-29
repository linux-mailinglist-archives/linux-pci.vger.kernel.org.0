Return-Path: <linux-pci+bounces-1528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF281FC31
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441021F20FA8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77B385;
	Fri, 29 Dec 2023 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+g0Xd0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2A3C2A
	for <linux-pci@vger.kernel.org>; Fri, 29 Dec 2023 00:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22810C433C7;
	Fri, 29 Dec 2023 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703809847;
	bh=djIH+WOLVWmH0owwBXve4lYjSZlHhaKVT+MAdr6+vv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q+g0Xd0/yDbxrjWtRQ8BSWg0Oua+FrJOSpkJlyp1zqE2k3OMvUpYtZYxjKSpquoJE
	 7Ijlg3DjH+z9t54abuSYaaD2PNtAmVORaU97vc4W4BEmj/1qDvy0F0ys6wpOJaOa5B
	 u1R4A2ye0awN9pFyf4Sox89g2s2vNARKjKO+mhR0SrHQyU9YL1UDWki2PGwVn5x9bS
	 Vb+05eB9O4tPkgCfybMMYcbNhsUbMwQdY2+k1W2BLGPoB99E0Z450pp2yEBNAcx7DP
	 bC5ZzTLC4yZE1TaqIVUcLIfklRbM2XJhmPpIt/9xB2aaU0AtOKkEX7zGvCCFgAl7pu
	 FBLtJVIBWwYCA==
Date: Thu, 28 Dec 2023 18:30:45 -0600
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
Message-ID: <20231229003045.GA1561509@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228223112.GA1554975@bhelgaas>

[+cc Michael]

On Thu, Dec 28, 2023 at 04:31:12PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 20, 2023 at 05:12:50PM -0800, David E. Box wrote:
> ...

> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 55bc3576a985..3c4b2647b4ca 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c

> > @@ -1579,7 +1579,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
> >  {
> > ...

> > +        So we restore here only the
> > +	 * LNKCTL register with the ASPM control field clear. ASPM will
> > +	 * be restored in pci_restore_aspm_state().
> > +	 */
> > +	val = cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
> > +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
> 
> When CONFIG_PCIEASPM is not set, we will clear ASPMC here and never
> restore it.  I don't know if this ever happens.  Do we need to worry
> about this?  Might firmware restore ASPMC itself before we get here?
> What do we want to happen in this case?
> 
> Since ASPM is intertwined with the PCIe Capability, can we call
> pci_restore_aspm_state() from here instead of from
> pci_restore_state()?
> 
> Calling it here would make it easier to see the required ordering
> (LNKCTL with ASPMC cleared, restore ASPM L1SS, restore ASPMC) and
> it would be obvious that none of the other stuff in
> pci_restore_state() is relevant (PASID, PRI, ATS, VC, etc).
> 
> If that could be done, I think it would make sense to do the same with
> pci_save_aspm_state() even though it's a little more independent.

The lspci output in Michael's report at
https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de
reminded me that LTR is important for L1.2, and we currently have
this:

  pci_restore_state
    pci_restore_ltr_state
    pci_restore_pcie_state

I wonder if pci_restore_ltr_state() should be called from
pci_restore_pcie_state() as well?  It's intimately connected to ASPM,
and that connection isn't very clear in the current code.

Bjorn

