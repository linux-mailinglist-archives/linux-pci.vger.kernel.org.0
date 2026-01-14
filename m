Return-Path: <linux-pci+bounces-44786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE838D208B6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF5D9301720F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6892FDC25;
	Wed, 14 Jan 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqg9qRe7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9A2F39B8;
	Wed, 14 Jan 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411714; cv=none; b=H78TlxVhnMp8t7fZaWAljY3r1R/q1dsREXzXhDqxWPMtRc/TPQgVFAXoVzFHETwwvwUxsa8bm5cK3HRJuRD/Lv732XfQALrLu9utDCKwSihfYD5yhRyq09iC1rh4HNUdENKINK1gGUYwaLFpKB2OZoLxqTLvZf8N+T/HJ3A05b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411714; c=relaxed/simple;
	bh=wD/5RVHhGR99Mqb9HHrjiTflC51aStRb6BACeDI9CVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PWTIyCSW9CSo22fsWLm4+wLIemUcPEMF/kQtl6KVs9emJVek2TG4amUBVfEgT89FjSZpjLHey1npbWcJLtTzXLh+/qMD7vhwLs3Rzr3mjF5kiSfT4v1PtIH2QHhfbEKkrd/e/lxn07CVE1r0muZ++qJbM5istMLLI5Zb5+VAALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqg9qRe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB82C4CEF7;
	Wed, 14 Jan 2026 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768411713;
	bh=wD/5RVHhGR99Mqb9HHrjiTflC51aStRb6BACeDI9CVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zqg9qRe7uE1FygMozTkXAaWZGBj3D7YBYFSZBt2LQQMbz/euQHCq7j+XgVkO0tu7u
	 JOlzmj+7L/Y7CHZalggRJh8YXrB20UtopsY6u1mnVrgdsaluAeKicAY8SXllN7Dfu2
	 3QISaTvRBf0YFR9tYou4x/FG6TNAco1E7o0XPfiym71SxLBUsjzb8n2ebIu6haa0v3
	 UhiyTtn9QkYieySz+Ylamyd+PFXJU7XTgkBHMcjR7ZrmnyINnmagPfv/ZwPPluruMF
	 zHteLNNVXbIywvPHoC/jJGBElYbpoqmm4hCQHPKgJgy4q+BwvwumT5oWNdnpoaoATg
	 nz59CcWh7LSDQ==
Date: Wed, 14 Jan 2026 11:28:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johnny-CC Chang =?utf-8?B?KOW8teaZi+WYiSk=?= <Johnny-CC.Chang@mediatek.com>
Cc: "lukas@wunner.de" <lukas@wunner.de>,
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
Message-ID: <20260114172832.GA822909@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d91c98a99a0a1b368691a93141f4f14e5ece44c.camel@mediatek.com>

[+cc Jason, Alex for Nvidia input]

On Wed, Jan 14, 2026 at 06:39:24AM +0000, Johnny-CC Chang (張晋嘉) wrote:
> On Tue, 2025-11-18 at 17:39 +0800, Johnny-CC Chang wrote:
> > On Thu, 2025-11-13 at 10:39 +0100, Lukas Wunner wrote:
> > > On Thu, Nov 13, 2025 at 04:44:06PM +0800, Johnny Chang wrote:
> > > > Nvidia GB10 PCIe hosts will encounter problem occasionally
> > > > after SBR(secondary bus reset) is applied.
> > > 
> > > Could you elaborate what kinds of problems occur, how often they
> > > occur, etc?
> > 
> > There is about 1/1000 chance that after SBR is applied, any further
> > access via this root port will be blocked and make system crash. 

What sort of crash happens?  It's useful if we can include a bread
crumb that will help people identify the crash and find a fix.

What I would expect is some kind of PCIe error like a config read
timeout or unsupport request error.  But usually those just result in
~0 data back to the CPU, which usually doesn't directly cause a crash.

> I would like to update below description to replace original comment in
> v1 patch, is this information sufficient? 
> --------
> /*
>  * After SBR(secondary bus reset) is applied on an Nvidia GB10
>  * PCIe root port, there is 1/1000 chance that further requests
>  * via this root port will be blocked and cause system unstable.

I'm confused about what the topology is.  I first assumed GB10 was a
PCIe Endpoint, since Secondary Bus Reset only applies to devices below
a bridge, so SBR would be applied to a device by a config write to
that bridge.

But you mention a GB10 Root Port here, which obviously is not an
Endpoint, so there's no bridge upstream from the GB10 that could
initiate SBR to the GB10.

If this is actually a GB10 issue, it sounds like a hardware erratum
that lots of users would see and Nvidia would likely be aware of. 

Bjorn

