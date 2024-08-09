Return-Path: <linux-pci+bounces-11532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3694D126
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C01F21A15
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BF1953A2;
	Fri,  9 Aug 2024 13:24:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F420194C6F;
	Fri,  9 Aug 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209886; cv=none; b=eM03DTksb8LNg8Wd8q1kYvJXgBF6d96gs6JHnogiJZng9inf3rLwNlXNgUt96aEcufg0Shy5u4/WqvF4YGL3DVMVRZyTpgq9iRM/SUrouhoU7Ylk9tuviMkDfeYRMKQ7c5B7CFn/6xt+MDojKcCKquuAk5C3NmzhdxoSZyvGzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209886; c=relaxed/simple;
	bh=PlIgI8gAlVAcwnI50P2voAAORVnkHQhFcXVJ9vyHHW4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=LJLQFkqllRfvbGrVQeEzbgkHRXFIJDgel7yACU1jeuOI3dLrfNF8OfLzuJSoV5GT0G8zAUlyom3SAP0MHqaE+cLC5OYQgo3uVo53VrdL92XOjVdNtRTijMPJ2AoOnUpKqh5To8bSsoVxEzclcpie+4WZfl0iQ9CF5PnlxU9VSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9E8E492009C; Fri,  9 Aug 2024 15:24:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9A4C192009B;
	Fri,  9 Aug 2024 14:24:40 +0100 (BST)
Date: Fri, 9 Aug 2024 14:24:40 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: Rework error reporting with PCIe failed link
 retraining
Message-ID: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 This is v2 superseding a patch series originally posted here: 
<https://lore.kernel.org/r/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/>.

 This patch series addresses issues observed by Ilpo as reported here: 
<https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/>, 
one with excessive delays happening when `pcie_failed_link_retrain' is 
called, but link retraining has not been actually attempted, and another 
one with an API misuse caused by a merge mistake.

 It also addresses an issue observed by Matthew as discussed here: 
<https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/> 
and here: 
<https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/>. 
where a stale LBMS bit state causes `pcie_failed_link_retrain', in the 
absence of a downstream device, to leave the link stuck at the 2.5GT/s 
speed rate, which then negatively impacts devices plugged in in the 
future.

 See individual change description for further details; 1/4 and 2/4 are 
new changes, 3/4 supersedes: 
<https://patchwork.kernel.org/project/linux-pci/patch/alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk/>, 
and 4/4 supersedes: 
<https://patchwork.kernel.org/project/linux-pci/patch/alpine.DEB.2.21.2402100048440.2376@angie.orcam.me.uk/>.

 These changes have been verified with a SiFive HiFive Unmatched system, 
also using a small debug change to verify that the state of the LBMS bit 
is clear at the exit from `pcie_failed_link_retrain'.

 Ilpo, since 3/4 and 4/4 have only been trivially updated and their 
combined effect is not changed even I chose to retain your Reviewed-by 
tags from v1.  Let me know if you disagree and what to do so you don't.

 I apologise to take so long, it's been a tough period to me load-wise.

  Maciej

