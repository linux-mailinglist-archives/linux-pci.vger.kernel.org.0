Return-Path: <linux-pci+bounces-23362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30DA5A41D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B651892EED
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E71DB34B;
	Mon, 10 Mar 2025 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh1ojB/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FEEC5
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636412; cv=none; b=nGELRkrBZDBVwDbILhNDjVoVYpopKFMiGcB6JJmnYUT2k/GVcZCNA0frX0R/B6D9IQf5pPHqfJkflRni5QXnd4JdLJyqB7waedE5mHa17d7r+qARdiHo1vCudJwqEiQijCKpbpcXBPKobg8vMb2AB4T8VBRRn3FkRsR1zqj6ewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636412; c=relaxed/simple;
	bh=HkM89bHaRg4TebLULrbtHGLdYF5pBzPUC1JgaDWSrbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ncRhscahad7QlU1SVEkJrMEuL6W1vjVfooSnWyVCS1VVHmMoPr72vxmkrVf2F0W56YwsrpGSFZfNs64DvkbC6D8+r54tV5PBskqpVDOeIG5NRL1ow/uA+JJUAoxxsDzN/ZQYSGPgUVeTP9uWl5kS2U7P7q7ywaqZeQMSBunldrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh1ojB/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA27DC4CEE5;
	Mon, 10 Mar 2025 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741636412;
	bh=HkM89bHaRg4TebLULrbtHGLdYF5pBzPUC1JgaDWSrbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lh1ojB/F2iH+q7qlPQy7RMFSxTdbl5FVX1Uo6hCyAnv1urC+y/MkfZHFEhxxamC6D
	 6+hSvSsacDQ/TDe+qQOkcVDgwXxzjJG4c6QJNMdggDysu92ZRQ+QsPC+1vKuxZfKmM
	 AElgANQ+8YxemFwqEYT5BrDDx6yyCC5B8Lc1nh8XZsNpAkd04c7SgCstlRS9w5noHz
	 GeHe30Q/v2K4dwkx2MinsC8dzxOsv/QZATnRoHLxROsMjyhq2brxm65kn4Lh/0oAs6
	 9UAwmGzAWdqhdh9GCKGfdAn+ZcxFAv8scNdg53cyExu/rt7CzhBr/uAetoAbe4LD1a
	 9K0giZ+MT1rnA==
Date: Mon, 10 Mar 2025 14:53:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: phasta@kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: Check BAR index for validity
Message-ID: <20250310195330.GA565062@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <809eab4e8563d12d2d1f26195cff32bde05c299d.camel@mailbox.org>

On Mon, Mar 10, 2025 at 08:54:54AM +0100, Philipp Stanner wrote:
> On Sat, 2025-03-08 at 15:07 -0600, Bjorn Helgaas wrote:
> > On Sat, Mar 08, 2025 at 01:23:28PM +0300, Dan Carpenter wrote:
> > > Hello Philipp Stanner,
> > > 
> > > Commit ba10e5011d05 ("PCI: Check BAR index for validity") from Mar
> > > 4,
> > > 2025 (linux-next), leads to the following Smatch static checker
> > > warning:
> > > 
> > > 	drivers/pci/devres.c:632
> > > pcim_remove_bar_from_legacy_table()
> > > 	error: buffer overflow 'legacy_iomap_table' 6 <= 15
> > 
> > Thanks, I dropped this patch for now.
> > 
> > > drivers/pci/devres.c
> > >     621 static void pcim_remove_bar_from_legacy_table(struct
> > > pci_dev *pdev, int bar)
> > >     622 {
> > >     623         void __iomem **legacy_iomap_table;
> > >     624 
> > >     625         if (!pci_bar_index_is_valid(bar))
> > > 
> > > This line used to check PCI_STD_NUM_BARS (6) but now it's checking
> > > PCI_NUM_RESOURCES (15).
> 
> What is even going on here. Why are thos different values? Does a PCI
> device now have at most 6, or 15 BARs?

You included the link below, so I guess you found the answer to this,
but PCI devices can have:

  - up to six normal BARs (pci_dev.resource[0-5])

  - a ROM BAR (pci_dev.resource[6])

  - up to six SR-IOV BARs (pci_dev.resource[7-12])

  - four windows (for bridges) (pci_dev.resource[13-16])

> Or is a BAR different from a "resource"?

Yes, as above.  Not all can be used at once, e.g., bridges can only
have two BARs and may not implement all four windows, and SR-IOV VFs
can't use the normal BARs at all.

> And why would it be 15? I haven't read the standard, but I would
> suspect it should be 16.

This is an implementation thing, not a PCI spec thing, but I count a
maximum of 17 resources if CONFIG_PCI_IOV is defined.

> And which of those two here should be used?
> https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/pci.h#L133

