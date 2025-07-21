Return-Path: <linux-pci+bounces-32670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E7EB0C938
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1AD4E66D0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D32C1594;
	Mon, 21 Jul 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4C67cU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1828469C;
	Mon, 21 Jul 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117695; cv=none; b=cPvSVBuNwDtuZTUUKEXF346KALavcJew2cLSENMpoSLNgf3ZLndCi1AOTCn7TAHu2JFvP+/qAONCy1NX3dIBLQEsdX10AnKE4s1iKo9EfamBpTwxefCi8s1AiT1uY+F3+yFboLpVQR7j/UY8CErlQ7JVigLtN9IUBH70QPYPnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117695; c=relaxed/simple;
	bh=7aLCRswqV++mghCreEKzuV/N6zLWOtAnFtIQI9EPrE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OCFRTnF966+TvXTdtzKSCDCCiBWh3RKDcaIN6EpGoD4l6bMiMfMUVsU8b2/nSFj+loaDoeuUan2pbFfAq9jibzixZJTod5zofdenQZQwckMRnr7yglXYfrBriZHfzqvvs43BH0zh5/tswH0NjG46+y3LbGKw9tqT3lJX8/cIyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4C67cU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444ACC4CEED;
	Mon, 21 Jul 2025 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753117693;
	bh=7aLCRswqV++mghCreEKzuV/N6zLWOtAnFtIQI9EPrE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W4C67cU/gCDs0z7LrU5Fh4oxSCeUTkFyHuA0JBo9PLUdwsxZ1gN87Pud/4oDnUaBL
	 Vg1qQZ8/TePCenuvOJZsWfVU2t9+upq71HEKcLaGZ3U0y1oNxPZmdM8ClR3rI67MsK
	 5fzWUjC6WdqkT2+0jGb0LY7VdegN+TN0Ce1YO3ikB26v9TQ/D6Pb914SKz7zMy3+zS
	 V2NGe1Xf0MpmbubCf3RPgJ8VhKUrgofNERjX3BwXkrNdI/KOuxqORA+xIslBD8V+Ln
	 fJu7TzmufDgR3gH5B5S9N31XnFydH9yJHoWO0TFj+Tq+AxcetXG0+285+w4S71QAOs
	 dWeZJ5FuJfv5g==
Date: Mon, 21 Jul 2025 12:08:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] pci/controller: Use dev_fwnode()
Message-ID: <20250721170811.GA2742811@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716144937.GA2531969@bhelgaas>

Jiri, question for you below about more possible drivers/pci/
conversions to use dev_fwnode() for struct device * cases.

Would like to get this in for v6.17 if these should be changed.

Bjorn

On Wed, Jul 16, 2025 at 09:49:38AM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 16, 2025 at 09:59:42AM +0200, Nam Cao wrote:
> > On Tue, Jul 15, 2025 at 01:49:17PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jun 11, 2025 at 12:43:44PM +0200, Jiri Slaby (SUSE) wrote:
> > > > irq_domain_create_simple() takes fwnode as the first argument. It can be
> > > > extracted from the struct device using dev_fwnode() helper instead of
> > > > using of_node with of_fwnode_handle().
> > > > 
> > > > So use the dev_fwnode() helper.
> > > > 
> > > > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > ---
> > > >  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 5 ++---
> > > >  drivers/pci/controller/pcie-mediatek-gen3.c          | 3 +--
> > > 
> > > I think the pcie-mediatek-gen3.c part of this is no longer relevant
> > > after Nam's series [1].
> > 
> > fwnode is still needed after my patch. As part of
> > struct irq_domain_info info = { ... }
> > 
> > You could squash this one into my patch. I personally would leave it be.
> > But fine to me either way.
> 
> Oh, I think I see what happened:
> 
>   - Jiri replaced of_fwnode_handle() with dev_fwnode() in the
>     irq_domain_create_linear() call [1]
> 
>   - On top of that, Nam replaced irq_domain_create_linear() with
>     msi_create_parent_irq_domain(), and moved the dev_fwnode() to the
>     struct irq_domain_info [2]
> 
>   - I rebuilt pci/next with Nam's series merged *before* Jiri's,
>     resulting in a conflict (of_fwnode_handle() was still used in the
>     irq_domain_create_linear() call) which I resolved by using
>     dev_fwnode() when building struct irq_domain_info [3]
> 
> I think the result [4] is OK, but it's not ideal because a
> dev_fwnode() conversion got inserted into Nam's patch without
> explanation.
> 
> So I think I'll put Jiri's patches (along with Arnd's similar altera
> patch [5]) on a branch and merge them before Nam's.
> 
> Jiri, question for you: even after all this, there are still several
> uses in drivers/pci/ of of_fwnode_handle() to extract the
> fwnode_handle for a struct device * [6,7,8,9,10,11,12].
> 
> Should these also be changed?
> 
> Bjorn
> 
> [1] https://lore.kernel.org/r/20250611104348.192092-16-jirislaby@kernel.org
> [2] https://patch.msgid.link/bfbd2e375269071b69e1aa85e629ee4b7c99518f.1750858083.git.namcao@linutronix.de
> [3] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=dd6fad415071
> [4] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-mediatek-gen3.c?id=beedc9eb3114#n750
> [5] https://lore.kernel.org/r/20250611104348.192092-2-jirislaby@kernel.org
> 
> [6] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c?id=beedc9eb3114#n217
> [7] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c?id=beedc9eb3114#n442
> [8] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-altera-msi.c?id=beedc9eb3114#n169
> [9] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-mediatek.c?id=beedc9eb3114#n490
> [10] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-xilinx-dma-pl.c?id=beedc9eb3114#n468
> [11] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-xilinx-nwl.c?id=beedc9eb3114#n501
> [12] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/plda/pcie-plda-host.c?id=beedc9eb3114#n156

