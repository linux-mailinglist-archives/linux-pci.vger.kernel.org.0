Return-Path: <linux-pci+bounces-40531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C76C3CF3F
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA3B14E01D3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726A2257829;
	Thu,  6 Nov 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIYXEgc+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB423EA94;
	Thu,  6 Nov 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451418; cv=none; b=Fy56ZfIZ5ajqm/ic0HnRnR+KVh7jnqsIjfGwtTF3lN1rgzGuQAXBchd5A+T1TkEAEH7unAwLRv9BelJciyG3IRCGH9mU+bxNwhyrD1B7Cx9sq9HXTPdyiAsZDNQyZITFk4U0aSmNB/hmmDwWeEi2SIRf425YAynMM3ZVgLV+b/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451418; c=relaxed/simple;
	bh=FxKA2fMr/WdbaFHAbSbkmcbsbRlTbS4a5322zAtajMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b0LlP4WB0A05BY8prNnL1fiDcKoMZn4RTnRbed26EhhkZGU9tASF+3YsFxXXSkSwl4bfPe2vObDnAqHd0DdcSzmfjFHb8JlzXQ5WxqjWBCBRnX1AAdure1Z6aZ4iMkB/O4Hs2YTEx7D6CE0rI0iFoKyonVqZshdFEVMDacRT8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIYXEgc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C033BC16AAE;
	Thu,  6 Nov 2025 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451417;
	bh=FxKA2fMr/WdbaFHAbSbkmcbsbRlTbS4a5322zAtajMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QIYXEgc+9LBNb0m+aXShs3Aup8pDGTCbuhCr/0D/IZdFYZk8GefrTYscWUAExw+uK
	 F+/r5w0Zxdu1QkgCyRa+LwZHc+eaY2CKB0ogbUBGUIZfnC3HBKwXDfwMXdhQIkrLha
	 Y8lA7m4P4Y354Al6MypB308FfCHwrHvZzllLa2Pn9aMmvr2AO9iitJVoBbpZo72dNl
	 4l1LzzuE9bgOfcC7qP72MpKzYzlUMPMyAkeAgiqtuxTFnX/nzzWEI4T487KcxwVKyB
	 iEkymD1taiV704dGGuUEu2vcXX1THFvk1HWfJtRGuFqJJwjBmEkyIEiof7+EHGIv48
	 zAPF78BGrEAfg==
Date: Thu, 6 Nov 2025 11:50:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <20251106175016.GA1960490@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106182708.03cfb6c6@bootlin.com>

On Thu, Nov 06, 2025 at 06:27:08PM +0100, Herve Codina wrote:
> On Thu, 6 Nov 2025 16:21:47 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> > On 13:18 Thu 06 Nov     , Herve Codina wrote:
> > > On Thu, 6 Nov 2025 12:04:07 +0100
> > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:  
> > > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:    
Patch at https://lore.kernel.org/r/955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com,
added back for reference:

  diff --git a/drivers/pci/of.c b/drivers/pci/of.c
  index 3579265f1198..872c36b195e3 100644
  --- a/drivers/pci/of.c
  +++ b/drivers/pci/of.c
  @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)

	  /* Check if there is a DT root node to attach the created node */
	  if (!of_root) {
  -               pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
  +               pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
		  return;
	  }

> > > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error
> > > > > > message is generated if no 'of_root' node is defined.
> > > > > > 
> > > > > > On DT-based systems, this cannot happen as a root DT node
> > > > > > is always present. On ACPI-based systems, this is not a
> > > > > > true error because a DT is not used.
> > > > > > 
> > > > > > Downgrade the pr_err() to pr_info() and reword the message
> > > > > > text to be less context specific.    
> > > > > 
> > > > > of_pci_make_host_bridge_node() is called in the very generic
> > > > > pci_register_host_bridge() path.  Does that mean every boot
> > > > > of a kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT
> > > > > system will see this message?    
> > > > 
> > > > This is the case, indeed. That's why downgrading to info seems
> > > > sensible.
> > > >   
> > > > > This message seems like something that will generate user
> > > > > questions.  Or is this really an error, and we were supposed
> > > > > to have created of_root somewhere but it failed?  If so, I
> > > > > would expect a message where the of_root creation failed.    

I think we should just remove the message completely.  I don't want
users to enable CONFIG_PCI_DYNAMIC_OF_NODES out of curiosity or
willingness to test, and then ask about this message.

"You can avoid the message by also enabling CONFIG_OF_EARLY_FLATTREE"
is not a very satisfactory answer.

A message at the point of *needing* this, i.e., when loading an
overlay fails for lack of this dynamic DT, is fine.

> > > > Not really an error per se: on ACPI system we usually don't
> > > > have DT, so this message just warns you that there will be no
> > > > pci nodes created on it.  Which, again, should be of no
> > > > importance on ACPI.  
> > > 
> > > I my last understanding, all architecture (even x86) have the DT
> > > root node set. This node is empty on architectures that don't
> > > use DT to describe hardware at boot (ACPI for instance).  
> > 
> > This does not seem to be the case for all arch, see below.
> > 
> > > This DT node is needed for PCI board that will be described by a
> > > DT overlay.  LAN966x for instance.
> > > 
> > > On v6.18-rc1 kernel, I successfully used my LAN966x board on a
> > > ACPI system.  This means that of_root DT node was present on my
> > > system.
> > >   
> > > > The only scenario in which this message is actually an error
> > > > would be on ACPI system that use DT as a complement to make
> > > > runtime overlay work,  
> > > 
> > > It is an error also if you use a PCI board that needs PCI DT
> > > nodes (CONFIG_PCI_DYNAMIC_OF_NODES) Lan966x for instance.  
> > 
> > Yes, I was referring exactly to that.
> > 
> > > > i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK
> > > > this fw is more a PoC that something really widespread and
> > > > currntly the overlay approach is in stand-by anyway (meaning
> > > > no one will use it unless some major changes will be made to
> > > > make it work). But there may be other situations in which this
> > > > scenario could arise, I'm thinking about Bootlin's LAN966x
> > > > driver which also uses runtime overlay to describe thw hw.  On
> > > > ACPI system the root DT node is not created because
> > > > unflatten_device_tree() is not called.  
> > > 
> > > I am not so sure.  My LAN966x board is working on a x86 ACPI
> > > system.  
> > 
> > Indeed it depends on the architecture. On x86 an empty DT node is
> > created, provided you have CONFIG_OF_EARLY_FLATTREE defined (which
> > I guess you have, even if it's not in default config).
> 
> Indeed, I have CONFIG_OF_EARLY_FLATTREE = y.
> 
> > On arm64, ACPI and DT are mutually exclusive, unless the DT is
> > basically empty (i.e. only root node and chosen node). The DT root
> > node is not automatically created if not provided at boot, though.
> > This reinforces my idea of providing the only root node DT on arm
> > as well, but I'm not entirely sure about possible side effects.
> 
> Isn't it possible to have the same kind of operations on ARM64 ACPI
> and on x86?
> 
> In order to have CONFIG_PCI_DYNAMIC_OF_NODES working on ACPI, we
> need a DT node, even empty.
> 
> ARM64 ACPI without an empty DT node means that no PCI boards using a
> DT description will work on this system.

