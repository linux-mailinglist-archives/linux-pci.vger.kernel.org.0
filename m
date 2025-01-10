Return-Path: <linux-pci+bounces-19641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2AA09E1B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 23:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CD0188DAB2
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 22:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805C215F40;
	Fri, 10 Jan 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQhgmR2k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5C2080D3;
	Fri, 10 Jan 2025 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548260; cv=none; b=W2qYgHZv3QCfExT8KEd6tpXTR5yKw8m8BiKzUqPb+hNKvg8RRSiwFV0J+hwrTDQCNYK/cVljuEx6sfqUglApJHBlDMYwaxIZX6gwIPx6+zVZ5zHvGLeFE0/yLcsVKOwH7XqTzTLIX8gWVK6Km5rWQWjTD0C2rF5oHJWoLd8ytso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548260; c=relaxed/simple;
	bh=9WkF6n5RBjRD1mrwR6nxL/hU9QiyhVm6Z4mOb8csuoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HTguapegnEwDohFXonTJCKu3Q3nGY+qZ4MqY0XnwZax/0qLbQ/buxxaTHuz0RuwWacNoHL0VYCsIl2csLdqYMr6lCbnBFZPwbHgKL4TgeTHCs8XnV2eOno8WwYkVoAmMRjCQn6XZpAoXOul4Zm4Eo87NRjm6oBUJR79XIMLYMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQhgmR2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BCAC4CED6;
	Fri, 10 Jan 2025 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736548259;
	bh=9WkF6n5RBjRD1mrwR6nxL/hU9QiyhVm6Z4mOb8csuoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rQhgmR2kSJPEviIMFBfSc+Z4Hchk6wciqoxq1D4PiiU2z+OXyngOrFXHmHSoTBD5y
	 sbrreH+lcvENWHkIyIzaxaX8C25ii1YOZqw2VyaaJQfTYL2+gMI4I9rXwiMD2txSUK
	 8QvNBNsuAfy5UaWrcvKFE/XCLn0J7RN7prRrAUcf7/kNHZx/sXU9N8AmIgEDAG9X+p
	 7M1zVVllWvmwGL9AJptwUutps9Txtg/gpYcYE8MwZrAZyS76HmrKZjdykYw0XCp0AT
	 ef3YzF9qvceS75EskXpOYtlaxhQPzb4PXV6UM0tvX810HEQu14+DoOmSEjliUbi0ot
	 T8HFuK07K2Y1Q==
Date: Fri, 10 Jan 2025 16:30:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] pci/msi: remove pci_msi_ignore_mask
Message-ID: <20250110223057.GA318711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110140152.27624-4-roger.pau@citrix.com>

Match subject line style again.

On Fri, Jan 10, 2025 at 03:01:50PM +0100, Roger Pau Monne wrote:
> Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both MSI
> and MSI-X entries globally, regardless of the IRQ chip they are using.  Only
> Xen sets the pci_msi_ignore_mask when routing physical interrupts over event
> channels, to prevent PCI code from attempting to toggle the maskbit, as it's
> Xen that controls the bit.
> 
> However, the pci_msi_ignore_mask being global will affect devices that use MSI
> interrupts but are not routing those interrupts over event channels (not using
> the Xen pIRQ chip).  One example is devices behind a VMD PCI bridge.  In that
> scenario the VMD bridge configures MSI(-X) using the normal IRQ chip (the pIRQ
> one in the Xen case), and devices behind the bridge configure the MSI entries
> using indexes into the VMD bridge MSI table.  The VMD bridge then demultiplexes
> such interrupts and delivers to the destination device(s).  Having
> pci_msi_ignore_mask set in that scenario prevents (un)masking of MSI entries
> for devices behind the VMD bridge.
> 
> Move the signaling of no entry masking into the MSI domain flags, as that
> allows setting it on a per-domain basis.  Set it for the Xen MSI domain that
> uses the pIRQ chip, while leaving it unset for the rest of the cases.
> 
> Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
> with Xen dropping usage the variable is unneeded.
> 
> This fixes using devices behind a VMD bridge on Xen PV hardware domains.

Wrap to fit in 75 columns.

The first two patches talk about devices behind VMD not being usable
for Xen, but this one says they now work.  But this doesn't undo the
code changes or comments added by the first two, so the result is a
bit confusing (probably because I know nothing about Xen).

Bjorn

