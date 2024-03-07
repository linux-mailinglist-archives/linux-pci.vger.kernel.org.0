Return-Path: <linux-pci+bounces-4630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A2875AEE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 00:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BD5280993
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495413D3B9;
	Thu,  7 Mar 2024 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7Qk9VWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538F3D393
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853093; cv=none; b=c1WaJqE0wfuvNG6ZiugoyrTZCa1Bs8pN9TSAVXGrRH+YL2juEBrXmxyAc+fO3yRy2hf7/SuCBnMAAFP9jqmU5v2RfXejwFVIvPnso/0k8iR4nDW4PDA+dse5YvAUe8+39BNMBbFMnB6VBOJ70A2enflq2RDyCw+fnVu5buWjo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853093; c=relaxed/simple;
	bh=f9wMIca3lpXOezESlz4C1Knc8+JeOJxKGX5HZb03kv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pyeLP05/Jqk9kSvzIxRYo5fxkpCbT45qFUQUao3RgJu7o2i1gb2MIx3FkK1C2kGRm1NQwykrvNNBpRMqRDBUrtFiehdoYY9Ixl6nx0b1qtWblJi5+H5ZeeP2z8l/5wrKs2CXmjSG2yrve1R4+fXRNrYznqyvuGwD7g+mZtLpXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7Qk9VWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF8EC433F1;
	Thu,  7 Mar 2024 23:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709853092;
	bh=f9wMIca3lpXOezESlz4C1Knc8+JeOJxKGX5HZb03kv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o7Qk9VWaqW/zq8+FP8p1XqLPpF03W1A+/ZbtXJvc4q7xScpMehX9gNw9nwRSzTCNF
	 bQfCU6y4wKj3MbEtrv1Bcy8HILrfuKve0Wonxx752XW/W+hOYf90osmG2JZ+bXhSkK
	 QmKfjxYXiqppAKMofTT17UUrj1QtMWGsQERrNSW1hLFopWJ/2I74Eg+GW2UPE1ps1E
	 2GsaED1i3tvFrZ/qtjic2E/EVzsQT4crv7Sgap9vkT+IQ0HOmREXGUiq+JqZk7FzHc
	 6YAjFEKw0beuRbphrMCH8PYXY92x2iqtPbrUltRq1ApXzmohAxKP//p4TOS/0jWPf/
	 JKOlO39nDFPFw==
Date: Thu, 7 Mar 2024 17:11:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Josselin Mouette <josselin.mouette@exaion.com>
Cc: linux-pci@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [Regression] [PCI/VPD] Possible memory corruption caused by
 invalid VPD data (commit found)
Message-ID: <20240307231131.GA658799@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>

[+cc Hannes]

[BTW, the patches are whitespace damaged, so they don't apply.  Looks
like tabs got converted to spaces]

On Thu, Mar 07, 2024 at 05:07:50PM +0100, Josselin Mouette wrote:
> We’ve been observing a subtle kernel bug on a few servers after kernel
> upgrades (starting from 5.15 and persisting in 6.8-rc1). The bug arises
> only on machines with Mellanox Connect-X 3 cards and the symptom is
> RabbitMQ disconnections caused by packet loss on the system Ethernet
> card (Intel I350). Replacing the I350 by a 82580 produced the exact
> same symptoms.

It looks like both I350 and 82580 use the igb driver?

> A bisect led to this change:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=5fe204eab174fd474227f23fd47faee4e7a6c000
> 
> Reverting the patch and adding more warnings (patch follows) allowed us
> to identify that the VPD data in the Connect-X 3 firmware is missing
> VPD_STIN_END, which makes it return at a 32k offset. But I presume the
> VPD data is incorrect far before that 32k limit.
> [   43.854869] mlx4_core 0000:16:00.0: missing VPD_STIN_END at offset 32769
> 
> Bjorn advised (thanks!) to look for what process is reading that VPD
> data. In our case it is libvirtd, and enabling debugging in libvirtd
> turned out a very interesting exercise, since it starts spewing
> gabajillions of VPD errors, especially in the Intel 82580 data.

Can we dig into these errors a bit?  I assume most of these come from
libvirtd (not the kernel)?

The VPD for different devices should be independent, so maybe an mlx4
VPD buffer overflow corrupted an igb VPD buffer, probably more likely
in libvirtd than in the kernel.

> That igb data does not look corrupt when we revert the change mentioned
> earlier, and we don’t see the packet loss either.

When you revert 5fe204eab174 ("PCI/VPD: Allow access to valid
parts of VPD if some is invalid"), you see no VPD errors either from
the kernel or from libvirtd except this one?

  mlx4_core 0000:16:00.0: missing VPD_STIN_END at offset 32769

> I’m not proficient in Kernel nor PCI internals, but a plausible
> explanation is that incorrect handling of the returned data causes out-
> of-bounds memory write, so this would mean a bug somewhere else, still
> to be found. 
> 
> If this hypothesis is correct, there are security implications, since a
> specifically crafted PCI firmware could elevate privileges to kernel
> level. In all cases, it does not look sensible to return data that is
> known to be incorrect.
> 
> -- 
> Josselin MOUETTE
> Infrastructure & Security architect
> EXAION
> 

