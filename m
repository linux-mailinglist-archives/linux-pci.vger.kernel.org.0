Return-Path: <linux-pci+bounces-44988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D8D2889B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A234300C349
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EC2EB5A1;
	Thu, 15 Jan 2026 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cypro30I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4982EBDDE;
	Thu, 15 Jan 2026 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510429; cv=none; b=A/c5UNo29nSu5EA92EMApa23qTesQHy5D5qFD4djy3wil21kYICJcD2EznysI/twxfivPRoOFomU5EwyUhYx/JT8H5Ae8C/B/yAF+MHsg/4II+hMqCvZqhSy7wgkvgl7QrKHuAMy306c/GvKbafEU3PpSdy+1N39Zl4A/ZXF+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510429; c=relaxed/simple;
	bh=kUIIoYoPjMjhLb2Ikm1Imwe9wIvpSRMNJmMBdsX0NfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c1IGc44RmleK2GpqIkiVSGwQjgBCzwHiWt6gFGPskTJK7xDTklEl3w1AruusO5dehxnM9KtRW7g+huORvJJc6ub/7NnXCvqHTPUq97iREhwrTedKxwxkCuWS7PeF5vWIyWyJJw2TvMqRM9oibbFgtfjkG3+D+xXZjpf/GpOKaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cypro30I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89D4C116D0;
	Thu, 15 Jan 2026 20:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768510429;
	bh=kUIIoYoPjMjhLb2Ikm1Imwe9wIvpSRMNJmMBdsX0NfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cypro30Ix2LyXok4K5JmT0bXfJdd660c0A8Q0TCWcPRwJ5x6+j8Nzw2MC/95i7rgp
	 0Mt2iOjN6bcNUaOlkI5mTnGAL8NLFDXqEyWwxoMhMgn9lKOKPh6ulzdpALJoADIrbS
	 nvGzMApAfZ0Leo5ZTmwROkFDAvON0A3IVZ9e4E2abJsOwuqmwRdQdWx/k6/nBGeXnH
	 aCgXIKyeM8FTD82xWgiu+hcONJNWPcSaYUzZxtoe/EOVbTc13SE69zzuGtF+aTk5y+
	 lSXduIOieNL9xib+Nmclwnnsc0L/LqNwUI1oW0fTunZ8Ew5QvgCPP26PYCiObGwTSm
	 E6oi31K5cm+vQ==
Date: Thu, 15 Jan 2026 14:53:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terje Bergstrom <tbergstrom@nvidia.com>
Cc: Johnny-CC Chang =?utf-8?B?KOW8teaZi+WYiSk=?= <Johnny-CC.Chang@mediatek.com>,
	"lukas@wunner.de" <lukas@wunner.de>,
	Project_Global_Digits_Upstream_Group <Project_Global_Digits_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Message-ID: <20260115205347.GA881345@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8fb91b-e132-4d8e-ab7a-d7954fc6629d@nvidia.com>

On Thu, Jan 15, 2026 at 12:11:09PM -0800, Terje Bergstrom wrote:
> On 1/14/26 09:28, Bjorn Helgaas wrote:
> 
> > What sort of crash happens?  It's useful if we can include a bread
> > crumb that will help people identify the crash and find a fix.
>
> We observed retraining to lower PCIe lane count and config read
> timeout.  So yes crash is not the best way to describe it.
> 
> > I'm confused about what the topology is.  I first assumed GB10 was
> > a PCIe Endpoint, since Secondary Bus Reset only applies to devices
> > below a bridge, so SBR would be applied to a device by a config
> > write to that bridge.
>
> gb10 is an SoC designed by NVIDIA and Mediatek in collaboration.
> It's not an endpoint, but has its own PCIe controller for connecting
> PCIe peripherals like NVMe drives, NIC, etc.

OK, so you do SBR to some endpoint below a GB10 Root Port, and after
the SBR, the link to the endpoint retrains with a lower lane count and
config reads to the endpoint time out?

I see you're from NVIDIA, so if you're confirming that this is a
hardware erratum (not an issue with the GB10 PCI controller driver),
we should definitely apply this, and I'll wordsmith the commit log and
comment something like this:

  When asserting Secondary Bus Reset to downstream devices via a GB10
  Root Port, the link doesn't retrain correctly.  The link may retrain
  with a lower lane count, and config accesses to downstream devices
  may fail.

Bjorn

