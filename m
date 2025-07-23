Return-Path: <linux-pci+bounces-32793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA853B0F16F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCB8AE1227
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE52BF010;
	Wed, 23 Jul 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSSjdR7k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2F2AD3E;
	Wed, 23 Jul 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270754; cv=none; b=C/yEZbcyCQtL4Ama/qxzFPsbJRxy2jIF/PlgP26sGTSa5cSNiz4ryrD8tRoiY8mrjniNkEdk2TtKSjjCtnp2FIZ/vf9Sja4zdcGdr/9UgM4Tf4gj9byBjkRFJZGs9T239qx9AnPdAYVyb+Uwxi4lgy3FP/Ag9LI1BhMSPgkqfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270754; c=relaxed/simple;
	bh=m8FyO70WVcGbmv2de5R4u32YsJtbHj03aCoX4C4Jg/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jNVFvVQIuIP38Wu7rNZnWMICDe4Vmt0sxmNI7aABO8Rl0iRruo5iV39IZIJQMCQq4nDwJUq/262WZhjXbWtyK4hbhyj6bOPKFEVXTmBpqBIU/ur2xIRD6PKBQu4aoMDlfSf6o13pNDpB3O5e+Sfk1L8XlYULqhx97JkkFQgTlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSSjdR7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD506C4CEE7;
	Wed, 23 Jul 2025 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753270754;
	bh=m8FyO70WVcGbmv2de5R4u32YsJtbHj03aCoX4C4Jg/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uSSjdR7kJvBQ88qLPTtylG1pXPiir85MEGShW3/iE9k1mkMJuSiULLVwfPvIIiXIO
	 UGCmjn0WEmcO1hcC8YF7rLkrKv+CK7iLaPwGOJjy8kuvssWOSDpLZD559XfI+Numd2
	 XIYxK7Uos6m8Z7+aoE/HX9he0vFTqrSCond7wuClqsQ1aajh1QzgQScvXnvrcDcJJj
	 yot5nuHNwyLKOrEWZAie1EjPYnD8fw9yAokUorA28zg9bNtGH+MFnrQTsWiEqmglqi
	 LNy6+MMDYG3a4wXFJ9dsN0zx2c767gZsUMM4wksXI1oSDdK0412+30ofinU7B7vLkM
	 ae3QBidKz4DqA==
Date: Wed, 23 Jul 2025 06:39:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3 0/6] PowerNV PCIe Hotplug Driver Fixes
Message-ID: <20250723113912.GA2880767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97289b39-ca4b-47ac-af81-c5223932ff63@linux.ibm.com>

On Wed, Jul 23, 2025 at 04:30:18PM +0530, Madhavan Srinivasan wrote:
> 
> 
> On 7/23/25 2:17 AM, Bjorn Helgaas wrote:
> > On Thu, Jul 17, 2025 at 06:27:52PM -0500, Bjorn Helgaas wrote:
> >> On Tue, Jul 15, 2025 at 04:31:49PM -0500, Timothy Pearson wrote:
> >>> Hello all,
> >>>
> >>> This series includes several fixes for bugs in the PowerNV PCIe hotplug
> >>> driver that were discovered in testing with a Microsemi Switchtec PM8533
> >>> PFX 48xG3 PCIe switch on a PowerNV system, as well as one workaround for
> >>> PCIe switches that don't correctly implement slot presence detection
> >>> such as the aforementioned one. Without the workaround, the switch works
> >>> and downstream devices can be hot-unplugged, but the devices never come
> >>> back online after being plugged in again until the system is rebooted.
> >>> Other hotplug drivers (like pciehp_hpc) use a similar workaround.
> >>>
> >>> Also included are fixes for the EEH driver to make it hotplug safe,
> >>> and a small patch to enable all three attention indicator states per
> >>> the PCIe specification.
> >>>
> >>> Thanks,
> >>>
> >>> Shawn Anastasio (2):
> >>>   PCI: pnv_php: Properly clean up allocated IRQs on unplug
> >>>   PCI: pnv_php: Work around switches with broken presence detection
> >>>
> >>> Timothy Pearson (4):
> >>>   powerpc/eeh: Export eeh_unfreeze_pe()
> >>>   powerpc/eeh: Make EEH driver device hotplug safe
> >>>   PCI: pnv_php: Fix surprise plug detection and recovery
> >>>   PCI: pnv_php: Enable third attention indicator state
> >>>
> >>>  arch/powerpc/kernel/eeh.c         |   1 +
> >>>  arch/powerpc/kernel/eeh_driver.c  |  48 ++++--
> >>>  arch/powerpc/kernel/eeh_pe.c      |  10 +-
> >>>  arch/powerpc/kernel/pci-hotplug.c |   3 +
> >>>  drivers/pci/hotplug/pnv_php.c     | 244 +++++++++++++++++++++++++++---
> >>>  5 files changed, 263 insertions(+), 43 deletions(-)
> >>
> >> I'm OK with this from a PCI perspective, and I optimistically put it
> >> on pci/hotplug.
> >>
> >> I'm happy to merge via the PCI tree, but would need acks from the
> >> powerpc folks for the arch/powerpc parts.
> >>
> >> Alternatively it could be merged via powerpc with my ack on the
> >> drivers/pci patches:
> >>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >>
> >> If you do merge via powerpc, I made some comment formatting and commit
> >> log tweaks that I would like reflected in the drivers/pci part.  These
> >> are on
> >> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=hotplug
> > 
> > Powerpc folks: let me know how you want to handle this.  I haven't
> > included it in pci/next yet because I don't have acks for the
> > arch/powerpc parts.
> 
> Patchset looks fine to be. 
> 
> I am fine to take it via my tree since I already have your Acked-by.

OK, I'll assume this will be merged via your tree.  Please cherry-pick 
the drivers/pci patches from my tree to preserve my tweaks.  I moved
them from pci/hotplug to pci/hotplug-pnv_php:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=hotplug-pnv_php

