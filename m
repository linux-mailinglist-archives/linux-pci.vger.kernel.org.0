Return-Path: <linux-pci+bounces-40576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08BC3FD40
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 12:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94E1934AD9D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5D277CA4;
	Fri,  7 Nov 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EidR1XSF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01027E04C
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516718; cv=none; b=OEYZOmmSD3GhiccPrI9/R85++Ovpp/kfatfslq4yX24nHLwD7Cu9s/+QnMhsbyQSnYgKxyfq4b0KphEYFKVJsGsetyh3wkq0r4O7G7npd9whNAp+6n4494GT0J8t8aiXnbzM0A71OKHf5mzh0hTNBjJmSxWADNhYmrjZfzxz2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516718; c=relaxed/simple;
	bh=UDVuq/lrhkMd3aCRzHjBXDEmTc6zljOBa7UFGRfvTZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry0B+iar617mYjWesK02+1snwiEm1DPgZ6muXLuW0cY/Dpfo62O/ySXM/zJJZjoPrnoUPrFcaGKKX+04w6Hg+Mc+7VChOv5B1qZgIsIuBNgtrGetI6g8ozcma2KtIE2atUskmMZW5PYMc2sSjNkiATRZX0cBTLemNXEUDElfGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EidR1XSF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6C0AD1A191B
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 11:58:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F857606A6;
	Fri,  7 Nov 2025 11:58:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3701111852441;
	Fri,  7 Nov 2025 12:58:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762516712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C4R54YJMw/9k/KwHXpEmkLyJAAbzYMXCXrdeUpMH9Zs=;
	b=EidR1XSF2KvVll3yLkR6CDO2jbmKN25490panR36DO3hpBFIsHjzhK9CQBsyvzoab0Xz0g
	IfKQ5zIUH8dzqMb+NRFLHsJPBmqopY8jfxAg15CFL26vqalAQKXFiQUVMAFE0givROlE6O
	JpXGwiSg/wlhccCMNytyI/EKJkAFiFN0/udUC7yDTJx+PeCAoFGmLIRF/lUoliZl8O/5qq
	kLNT5qXbLdfuY7lK1f9BjCtamZigehvjMcmuwHQNsUXK6iODqmdEiLLptET7zH30+UGFop
	/DcgQ8EGhmH7cRbIjGfUSZwxnDYFiLng+wz6M0dVXaz0yseJCOHMy/81vhEvYQ==
Date: Fri, 7 Nov 2025 12:58:28 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mbrugger@suse.com,
 guillaume.gardet@arm.com, tiwai@suse.com, Lizhi Hou <lizhi.hou@amd.com>,
 Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <20251107125828.18a034de@bootlin.com>
In-Reply-To: <aQ28s57R0YfrqwdG@apocalypse>
References: <20251106182708.03cfb6c6@bootlin.com>
	<20251106175016.GA1960490@bhelgaas>
	<aQ28s57R0YfrqwdG@apocalypse>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrea, Bjorn,

On Fri, 7 Nov 2025 10:32:35 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> Hi Bjorn,
> 
> On 11:50 Thu 06 Nov     , Bjorn Helgaas wrote:
> > On Thu, Nov 06, 2025 at 06:27:08PM +0100, Herve Codina wrote:  
> > > On Thu, 6 Nov 2025 16:21:47 +0100
> > > Andrea della Porta <andrea.porta@suse.com> wrote:  
> > > > On 13:18 Thu 06 Nov     , Herve Codina wrote:  
> > > > > On Thu, 6 Nov 2025 12:04:07 +0100
> > > > > Andrea della Porta <andrea.porta@suse.com> wrote:  
> > > > > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:    
> > > > > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:      
> > Patch at https://lore.kernel.org/r/955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com,
> > added back for reference:
> > 
> >   diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> >   index 3579265f1198..872c36b195e3 100644
> >   --- a/drivers/pci/of.c
> >   +++ b/drivers/pci/of.c
> >   @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> > 
> > 	  /* Check if there is a DT root node to attach the created node */
> > 	  if (!of_root) {
> >   -               pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> >   +               pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
> > 		  return;
> > 	  }
> >   
> > > > > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error
> > > > > > > > message is generated if no 'of_root' node is defined.
> > > > > > > > 
> > > > > > > > On DT-based systems, this cannot happen as a root DT node
> > > > > > > > is always present. On ACPI-based systems, this is not a
> > > > > > > > true error because a DT is not used.
> > > > > > > > 
> > > > > > > > Downgrade the pr_err() to pr_info() and reword the message
> > > > > > > > text to be less context specific.      
> > > > > > > 
> > > > > > > of_pci_make_host_bridge_node() is called in the very generic
> > > > > > > pci_register_host_bridge() path.  Does that mean every boot
> > > > > > > of a kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT
> > > > > > > system will see this message?      
> > > > > > 
> > > > > > This is the case, indeed. That's why downgrading to info seems
> > > > > > sensible.
> > > > > >     
> > > > > > > This message seems like something that will generate user
> > > > > > > questions.  Or is this really an error, and we were supposed
> > > > > > > to have created of_root somewhere but it failed?  If so, I
> > > > > > > would expect a message where the of_root creation failed.      
> > 
> > I think we should just remove the message completely.  I don't want
> > users to enable CONFIG_PCI_DYNAMIC_OF_NODES out of curiosity or
> > willingness to test, and then ask about this message.  
> 
> Agreed. This would be the easy solution, the other being creating the
> empty DT so that the message will never be printed. But this require some
> careful thought. The latter solution will be needed if we'll ever want to
> make drivers like RP1 or lan96xx (which uses the runtime overlay) to work.
> 
> > 
> > "You can avoid the message by also enabling CONFIG_OF_EARLY_FLATTREE"
> > is not a very satisfactory answer.  
> 
> Unfortunately this would work on x86, but not on arm. And who knows on
> other platforms.
> 
> > 
> > A message at the point of *needing* this, i.e., when loading an
> > overlay fails for lack of this dynamic DT, is fine.  
> 
> It seems fine to me.
> 

Ok, even if I would prefer having an empty (or not) of_node available on all
platforms, what is proposed makes sense especially in regards to potential
users questions.

Best regards,
Hervé


