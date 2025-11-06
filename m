Return-Path: <linux-pci+bounces-40501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA6C3ADB9
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 968F23453ED
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48432A3F5;
	Thu,  6 Nov 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mT6it3kh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258B32721F;
	Thu,  6 Nov 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431544; cv=none; b=g57aoGq9jrZh4BKv30Vpdxq7i1oNvzz5S8vzSGpiDSG44LOmWCbmZEQNN8wCaJRZuSpW0qp1FSQK4m3A/wCLnyh4OiePzlhdU/Rw/SV009XpdklSMND8pPr5TUgSr+17M1r0UT3ZRrKt6Px/fubJiivFhdBYjIkXdzmh9vg1p6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431544; c=relaxed/simple;
	bh=3Qo9p504br6E8O5em7NlOnt/ylpumOzEneV4yrVVLjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4m0K8xwmx9lg+nGSIF462Bs4ACYLPYpEYIHMVqf8xE14oFT9M+lFMLE5pBSr3Q0eN4x6vP9O3rhSQLOKWNixAnSyKyuGBRp4yzUyTNoVjtGHH8mLbDc4Is+beRy9xGWHjCot3DHFhVXoPmL7ic3QnpAVsoVyu7jhYKgA0fD/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mT6it3kh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3C8081A18F6;
	Thu,  6 Nov 2025 12:18:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A1AC6068C;
	Thu,  6 Nov 2025 12:18:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A68D11850E1E;
	Thu,  6 Nov 2025 13:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762431538; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cD98W/fulZnWO52DCEQXKVY0Q7L/B0fTZwxSO/g6/ks=;
	b=mT6it3khmPmj+SW8y4XCmEenlxW8ADsCI7pdOqSWhWAlsp0KWUGISl0tLEHO+vaawiAIKL
	Bx62OsSZi/AuZVCcFu+6uUNe/FRTCHvtJeGXqiq+4x3YamxHy+UqgNINUhvdvNUlquUD+6
	Na8TYVzaKGqE46qDZScRXBHP85QZvzfUbiRAhe5ZCuiNn9HT/sAhmahYkbuRGnRvahhx/L
	ql1rwOqpha22E3yIbwMzm6UjJC0AjuVVsRrCSWu8BPMczCD6UxTtxMHWAHrpYG2uIGVXe6
	HytfFbuDzAUVTGpQERS4mbVIt4EEzgT8kYAOVR12twTP1hbOm+vdIaDPcDBBGA==
Date: Thu, 6 Nov 2025 13:18:54 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mbrugger@suse.com,
 guillaume.gardet@arm.com, tiwai@suse.com, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <20251106131854.0f0aa8b7@bootlin.com>
In-Reply-To: <aQyApy8lcadd-1se@apocalypse>
References: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
	<20251106002345.GA1934302@bhelgaas>
	<aQyApy8lcadd-1se@apocalypse>
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

Hi, Andrea, Bjorn,

On Thu, 6 Nov 2025 12:04:07 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> [+cc Herve]
> 
> Hi Bjorn,
> 
> On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:
> > [+cc Lizhi]
> > 
> > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:  
> > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> > > is generated if no 'of_root' node is defined.
> > > 
> > > On DT-based systems, this cannot happen as a root DT node is
> > > always present. On ACPI-based systems, this is not a true error
> > > because a DT is not used.
> > > 
> > > Downgrade the pr_err() to pr_info() and reword the message text
> > > to be less context specific.  
> > 
> > of_pci_make_host_bridge_node() is called in the very generic
> > pci_register_host_bridge() path.  Does that mean every boot of a
> > kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT system will see
> > this message?  
> 
> This is the case, indeed. That's why downgrading to info seems sensible.
> 
> > 
> > This message seems like something that will generate user questions.
> > Or is this really an error, and we were supposed to have created
> > of_root somewhere but it failed?  If so, I would expect a message
> > where the of_root creation failed.  
> 
> Not really an error per se: on ACPI system we usually don't have DT, so
> this message just warns you that there will be no pci nodes created on it.
> Which, again, should be of no importance on ACPI.

I my last understanding, all architecture (even x86) have the DT root node
set. This node is empty on architectures that don't use DT to describe
hardware at boot (ACPI for instance).

This DT node is needed for PCI board that will be described by a DT overlay.
LAN966x for instance.

On v6.18-rc1 kernel, I successfully used my LAN966x board on a ACPI system.
This means that of_root DT node was present on my system.

> 
> The only scenario in which this message is actually an error would be on
> ACPI system that use DT as a complement to make runtime overlay work,

It is an error also if you use a PCI board that needs PCI DT nodes
(CONFIG_PCI_DYNAMIC_OF_NODES) Lan966x for instance.

> i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK this fw is
> more a PoC that something really widespread and currntly the overlay
> approach is in stand-by anyway (meaning no one will use it unless some
> major changes will be made to make it work). But there may be other
> situations in which this scenario could arise, I'm thinking about Bootlin's
> LAN966x driver which also uses runtime overlay to describe thw hw.
> On ACPI system the root DT node is not created because unflatten_device_tree()
> is not called.

I am not so sure.
My LAN966x board is working on a x86 ACPI system.

I think, that if you don't want the kernel log, just set 
  CONFIG_PCI_DYNAMIC_OF_NODES = n

With CONFIG_PCI_DYNAMIC_OF_NODES = y, we need to create some nodes
and if cannot succeed to attach them to a DT tree, it is an error.
IMHO, pr_err() in that case is legit.


Best regards,
Hervé

