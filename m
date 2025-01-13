Return-Path: <linux-pci+bounces-19699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D7A0C5BC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E1E18882F9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27401F9EDA;
	Mon, 13 Jan 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMQ6G17P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F541EE7B3;
	Mon, 13 Jan 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736811167; cv=none; b=DvqKf/kRIUpgRYk6KxZ6awhYnKNIcJIh/kbRqfSOaIQwK8G9eVREup34YuaDHaUriVUTim+wieVnvNcTU75KH8rSi3lJkwKxpg4cR87dnLzRa6l8JYQTREIVIpKNZ77sLHtNUDjuckPTUFWGvMbgSHlv12+m4TTX9Ngj0r/dNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736811167; c=relaxed/simple;
	bh=1jVk4ltA+d5ZhbhdluLbuAMr/zaGiphdqtr5ZLs8t80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A9/pNsGay1Xq7TuqpH1hKTFlhFItfNY6zelMVUR5NnVdC4v4mqjiWVihnA2ZRK//FUaE72U+Ltr5iTtbA35cqj2Gg9p+iPvFiFKjCprSP3id7aUwNEpVJadW4Jlzvgwub4qVWwU4SQqKbizAJ0c1tRnSPuPBKMcAZFfd+22zfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMQ6G17P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C17EC4CEE2;
	Mon, 13 Jan 2025 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736811167;
	bh=1jVk4ltA+d5ZhbhdluLbuAMr/zaGiphdqtr5ZLs8t80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TMQ6G17PrTp0lhrwJTgK+sdfXTdzsz+wfrbAbfgMGesgsasW1zc885f77VJ8+CU8c
	 S9E7OikwGIKzXcUdHMj9jMWX5IQHbT+cxfBWIIopte/FKrEC2DsUogjt+p0QkuuBGQ
	 SIsp30jOpVhwCJiOjipxrUOYFVp4ChIp/PqWLvwwKCUwaf5lf8+RSDfKQ/xexWNoVe
	 LzjU0DTDEI5w+cEbrPDn8VQrM1ouY7m3xkueE0O/YV4uEudlv8UbtMY099seZ4ySLs
	 sg5VmCl8jju91f/jCHRLbT2twapA+WejGgDRWZFiprXnOJznMfPjjwwCvDSUZEDTsh
	 NhnaB1VtjAa6w==
Date: Mon, 13 Jan 2025 17:32:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] pci/msi: remove pci_msi_ignore_mask
Message-ID: <20250113233245.GA442694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4TqNn_RSwGX1TQn@macbook.local>

On Mon, Jan 13, 2025 at 11:25:58AM +0100, Roger Pau Monné wrote:
> On Fri, Jan 10, 2025 at 04:30:57PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 10, 2025 at 03:01:50PM +0100, Roger Pau Monne wrote:
> > > Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both MSI
> > > and MSI-X entries globally, regardless of the IRQ chip they are using.  Only
> > > Xen sets the pci_msi_ignore_mask when routing physical interrupts over event
> > > channels, to prevent PCI code from attempting to toggle the maskbit, as it's
> > > Xen that controls the bit.
> > > 
> > > However, the pci_msi_ignore_mask being global will affect devices that use MSI
> > > interrupts but are not routing those interrupts over event channels (not using
> > > the Xen pIRQ chip).  One example is devices behind a VMD PCI bridge.  In that
> > > scenario the VMD bridge configures MSI(-X) using the normal IRQ chip (the pIRQ
> > > one in the Xen case), and devices behind the bridge configure the MSI entries
> > > using indexes into the VMD bridge MSI table.  The VMD bridge then demultiplexes
> > > such interrupts and delivers to the destination device(s).  Having
> > > pci_msi_ignore_mask set in that scenario prevents (un)masking of MSI entries
> > > for devices behind the VMD bridge.
> > > 
> > > Move the signaling of no entry masking into the MSI domain flags, as that
> > > allows setting it on a per-domain basis.  Set it for the Xen MSI domain that
> > > uses the pIRQ chip, while leaving it unset for the rest of the cases.
> > > 
> > > Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
> > > with Xen dropping usage the variable is unneeded.
> > > 
> > > This fixes using devices behind a VMD bridge on Xen PV hardware domains.
> > 
> > Wrap to fit in 75 columns.
> > 
> > The first two patches talk about devices behind VMD not being usable
> > for Xen, but this one says they now work.
> 
> Sorry, let me try to clarify:
> 
> Devices behind a VMD bridge are not known to Xen, however that doesn't
> mean Linux cannot use them.  That's what this series achieves.  By
> inhibiting the usage of VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal
> of the pci_msi_ignore_mask bodge devices behind a VMD bridge do work
> fine when use from a Linux Xen hardware domain.  That's the whole
> point of the series.
> 
> > But this doesn't undo the
> > code changes or comments added by the first two, so the result is a
> > bit confusing (probably because I know nothing about Xen).
> 
> All patches are needed.  There's probably some confusion about devices
> behind a VMD bridge not being known by Xen vs not being usable by
> Linux running under Xen as a hardware domain.
> 
> With all three patches applied devices behind a VMD bridge work under
> Linux with Xen.

There's certainly confusion in *my* mind because I don't know enough
about Xen to understand the subtlety about devices behind VMD not
being known by Xen but still being usable by Linux running under Xen.

Bjorn

