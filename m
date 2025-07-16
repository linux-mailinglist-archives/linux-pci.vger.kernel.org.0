Return-Path: <linux-pci+bounces-32273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8785B078E5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89476B40183
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70871262FD9;
	Wed, 16 Jul 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUuKNjRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E0223301;
	Wed, 16 Jul 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677380; cv=none; b=VwuTfA7wkcojpfXDoZH2LSb7dhfbxHIvC2iy5fBQ0Hs+1b4UbSfifzRyciPB3sXi2Zb0iUBCXklDAe2c2GyVfePMSWgyIOkJBXqUT89KiGJawaUy5YV4R4rs7LxKXNk9C/9cSvpcGx1k9ByxsDCNiyD8/uqZh5bNwRbsig1gV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677380; c=relaxed/simple;
	bh=7d195KEgIoyVMxoatacwaj+oXYyt+91zLIQ+hn6aE1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F6OAPVIVDwfbqHrOOmUdJWAb13Z4Os0ypmhjsEPhhDO+wjQpGieF+VRdBDr6ZWCQ86WfcTwFUF1K6ubB5RmZpzI5siZJMqaVZGq6SupqWCMPmR2l3+6C6p72XS3CC4L7QbBESAPIjjlFngCyDco1v28s/V35x2NY1UGGWTthl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUuKNjRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D642C4CEE7;
	Wed, 16 Jul 2025 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752677378;
	bh=7d195KEgIoyVMxoatacwaj+oXYyt+91zLIQ+hn6aE1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XUuKNjRmxXmApuk69sTV6VR/FYl7OdAqzFI4vMteudIVc/skTGE0CmXBcFwDlUVPC
	 RZ5JnMoj2e5e0yHGC/PRx2JxBmF51cOA1AP8kLA7rZ7Je6TWQZr5EGFn0hdx86c2yP
	 VrV8fDXWmXvJbXD+zwGyQMAjtoYBSHU/CF8YRv2jMoD7r3pXikZZG5DXoki5WsBdSV
	 kbWxrFMOlE7kaLxz3UcHaNYjdRuyBQKDnSQa9WdNudV7j0n/2unMiVl3QClpefR6/p
	 46XsISaPV0u4m+NnO1qK0LjwtWgrdlVbaucIh/BLhKD42qaouEUA9isCQcc3MyKRaJ
	 OSlx9vqW8ZJ1A==
Date: Wed, 16 Jul 2025 09:49:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pci/controller: Use dev_fwnode()
Message-ID: <20250716144937.GA2531969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716075942.2aCLkdCs@linutronix.de>

[+cc Arnd]

On Wed, Jul 16, 2025 at 09:59:42AM +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 01:49:17PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jun 11, 2025 at 12:43:44PM +0200, Jiri Slaby (SUSE) wrote:
> > > irq_domain_create_simple() takes fwnode as the first argument. It can be
> > > extracted from the struct device using dev_fwnode() helper instead of
> > > using of_node with of_fwnode_handle().
> > > 
> > > So use the dev_fwnode() helper.
> > > 
> > > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: linux-pci@vger.kernel.org
> > > ---
> > >  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 5 ++---
> > >  drivers/pci/controller/pcie-mediatek-gen3.c          | 3 +--
> > 
> > I think the pcie-mediatek-gen3.c part of this is no longer relevant
> > after Nam's series [1].
> 
> fwnode is still needed after my patch. As part of
> struct irq_domain_info info = { ... }
> 
> You could squash this one into my patch. I personally would leave it be.
> But fine to me either way.

Oh, I think I see what happened:

  - Jiri replaced of_fwnode_handle() with dev_fwnode() in the
    irq_domain_create_linear() call [1]

  - On top of that, Nam replaced irq_domain_create_linear() with
    msi_create_parent_irq_domain(), and moved the dev_fwnode() to the
    struct irq_domain_info [2]

  - I rebuilt pci/next with Nam's series merged *before* Jiri's,
    resulting in a conflict (of_fwnode_handle() was still used in the
    irq_domain_create_linear() call) which I resolved by using
    dev_fwnode() when building struct irq_domain_info [3]

I think the result [4] is OK, but it's not ideal because a
dev_fwnode() conversion got inserted into Nam's patch without
explanation.

So I think I'll put Jiri's patches (along with Arnd's similar altera
patch [5]) on a branch and merge them before Nam's.

Jiri, question for you: even after all this, there are still several
uses in drivers/pci/ of of_fwnode_handle() to extract the
fwnode_handle for a struct device * [6,7,8,9,10,11,12].

Should these also be changed?

Bjorn

[1] https://lore.kernel.org/r/20250611104348.192092-16-jirislaby@kernel.org
[2] https://patch.msgid.link/bfbd2e375269071b69e1aa85e629ee4b7c99518f.1750858083.git.namcao@linutronix.de
[3] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=dd6fad415071
[4] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-mediatek-gen3.c?id=beedc9eb3114#n750
[5] https://lore.kernel.org/r/20250611104348.192092-2-jirislaby@kernel.org

[6] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c?id=beedc9eb3114#n217
[7] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c?id=beedc9eb3114#n442
[8] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-altera-msi.c?id=beedc9eb3114#n169
[9] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-mediatek.c?id=beedc9eb3114#n490
[10] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-xilinx-dma-pl.c?id=beedc9eb3114#n468
[11] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-xilinx-nwl.c?id=beedc9eb3114#n501
[12] https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/plda/pcie-plda-host.c?id=beedc9eb3114#n156

