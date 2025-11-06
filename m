Return-Path: <linux-pci+bounces-40527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A9C3CD84
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43C604E3CE6
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C9932B994;
	Thu,  6 Nov 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="De37bFg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F934DCE1
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450037; cv=none; b=OsmmVZNB6njjIcSUsr3aufLgdWKDQ2+MRpIEUUsLCDOFCFkZB7W7yWdfBtgOhAxE41UCSOsIUxmioc+QA/I9CO3Etpyxm6lSjOxthpXwzHwwm8balezi8vY19odT9prdAZsVBT9gMezCaXqvwDMszzba5C+vaFC3DcSrZ85KZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450037; c=relaxed/simple;
	bh=E/de/IhKUA6FWGeDbVpUjdlEQCPj4LmdhwlxDbKUK0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4rg9Vcb9b/fJE7ZIColu1ov4SPyXzjJKi2wVSXI/xl5YGmy2nadqy91O/DRSh/jrubf8x8LpgBDg6IEXqYxYn/dyP6Sp941ftJMYReFVItvPLUs4mtyS3nT99KwouHqKuxWNQDivN8PGGwN1/dHuVY0BbXY/sMyKUmuCAiTDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=De37bFg5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5B24BC0FA8F;
	Thu,  6 Nov 2025 17:26:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61047606EE;
	Thu,  6 Nov 2025 17:27:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB9F711850A25;
	Thu,  6 Nov 2025 18:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762450031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L7wB1lZ5txcUr4iAspNHzbN9ocWksvAKNiYdtfUQSRY=;
	b=De37bFg5nXjHVt5PtG7igKZacMY7eZxOEeIM5ReagP9ltX/KcdCirfEBuW3CAOVV8PhAmr
	re77BJT3MRK0nzrGQnUkUdGFtrgaAI7735n0cvZrUs7uu5PcAI2yAngvuHxGNqlRpLMNkE
	3zKsBW8jR/R96vfe3eEJwMolUUEiOuaUW1sPTgO5tc4PwjVEJGR2ykuz20sTNoLnrgYf6v
	Bav53813xZpuoYOq0ou4ahqhDC00KJM9PLpmyYobi5LZp09qadxPv0OQXaD0mfAOvhFtyS
	vK0AdM1BiaoI4OlcdVznQQX7J/XEfb861ci2XvU1ag3nDYePjfhY9cME85qNwg==
Date: Thu, 6 Nov 2025 18:27:08 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mbrugger@suse.com,
 guillaume.gardet@arm.com, tiwai@suse.com, Lizhi Hou <lizhi.hou@amd.com>,
 Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <20251106182708.03cfb6c6@bootlin.com>
In-Reply-To: <aQy9C8315Gu5F5No@apocalypse>
References: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
	<20251106002345.GA1934302@bhelgaas>
	<aQyApy8lcadd-1se@apocalypse>
	<20251106131854.0f0aa8b7@bootlin.com>
	<aQy9C8315Gu5F5No@apocalypse>
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

Hi Andrea,

+ CC Rob

On Thu, 6 Nov 2025 16:21:47 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> Hi Herve,
> 
> On 13:18 Thu 06 Nov     , Herve Codina wrote:
> > Hi, Andrea, Bjorn,
> > 
> > On Thu, 6 Nov 2025 12:04:07 +0100
> > Andrea della Porta <andrea.porta@suse.com> wrote:
> >   
> > > [+cc Herve]
> > > 
> > > Hi Bjorn,
> > > 
> > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:  
> > > > [+cc Lizhi]
> > > > 
> > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:    
> > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> > > > > is generated if no 'of_root' node is defined.
> > > > > 
> > > > > On DT-based systems, this cannot happen as a root DT node is
> > > > > always present. On ACPI-based systems, this is not a true error
> > > > > because a DT is not used.
> > > > > 
> > > > > Downgrade the pr_err() to pr_info() and reword the message text
> > > > > to be less context specific.    
> > > > 
> > > > of_pci_make_host_bridge_node() is called in the very generic
> > > > pci_register_host_bridge() path.  Does that mean every boot of a
> > > > kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT system will see
> > > > this message?    
> > > 
> > > This is the case, indeed. That's why downgrading to info seems sensible.
> > >   
> > > > 
> > > > This message seems like something that will generate user questions.
> > > > Or is this really an error, and we were supposed to have created
> > > > of_root somewhere but it failed?  If so, I would expect a message
> > > > where the of_root creation failed.    
> > > 
> > > Not really an error per se: on ACPI system we usually don't have DT, so
> > > this message just warns you that there will be no pci nodes created on it.
> > > Which, again, should be of no importance on ACPI.  
> > 
> > I my last understanding, all architecture (even x86) have the DT root node
> > set. This node is empty on architectures that don't use DT to describe
> > hardware at boot (ACPI for instance).  
> 
> This does not seem to be the case for all arch, see below.
> 
> > 
> > This DT node is needed for PCI board that will be described by a DT overlay.
> > LAN966x for instance.
> > 
> > On v6.18-rc1 kernel, I successfully used my LAN966x board on a ACPI system.
> > This means that of_root DT node was present on my system.
> >   
> > > 
> > > The only scenario in which this message is actually an error would be on
> > > ACPI system that use DT as a complement to make runtime overlay work,  
> > 
> > It is an error also if you use a PCI board that needs PCI DT nodes
> > (CONFIG_PCI_DYNAMIC_OF_NODES) Lan966x for instance.  
> 
> Yes, I was referring exactly to that.
> 
> >   
> > > i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK this fw is
> > > more a PoC that something really widespread and currntly the overlay
> > > approach is in stand-by anyway (meaning no one will use it unless some
> > > major changes will be made to make it work). But there may be other
> > > situations in which this scenario could arise, I'm thinking about Bootlin's
> > > LAN966x driver which also uses runtime overlay to describe thw hw.
> > > On ACPI system the root DT node is not created because unflatten_device_tree()
> > > is not called.  
> > 
> > I am not so sure.
> > My LAN966x board is working on a x86 ACPI system.  
> 
> Indeed it depends on the architecture. On x86 an empty DT node is created,
> provided you have CONFIG_OF_EARLY_FLATTREE defined (which I guess you have,
> even if it's not in default config).

Indeed, I have CONFIG_OF_EARLY_FLATTREE = y.

> 
> On arm64, ACPI and DT are mutually exclusive, unless the DT is basically empty
> (i.e. only root node and chosen node). The DT root node is not automatically
> created if not provided at boot, though. This reinforces my idea of providing
> the only root node DT on arm as well, but I'm not entirely sure about 
> possible side effects.
> 

Isn't it possible to have the same kind of operations on ARM64 ACPI and on x86?

In order to have CONFIG_PCI_DYNAMIC_OF_NODES working on ACPI, we need a DT
node, even empty.

ARM64 ACPI without an empty DT node means that no PCI boards using a DT
description will work on this system.

Best regards,
Hervé

