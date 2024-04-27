Return-Path: <linux-pci+bounces-6723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2528B44B7
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 09:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0BF1F22F2B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 07:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6041A89;
	Sat, 27 Apr 2024 07:08:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274F41A8F;
	Sat, 27 Apr 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714201728; cv=none; b=RbQoa67RatuR86XP1d5xauIdeHdefPmE1BI7m/KifRh89LnwnKE8NVkl0BUn9O6S17U7F3UPheucMRPdIPqc9niwQy0+1K2o7+xXYL13ObQmVzrschNl01fHCw6v82Mj1nCoH33LDaX9kA1AXAB+/hNGnXF8MNImlYJrzC73Lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714201728; c=relaxed/simple;
	bh=ZlzmiTcSFW6jE908jpUQW7NesItFn4P1MlIpIrUce/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW4LF2jOS0SdtydMGQV8JtI6su+Rzk/+CjKQ/QQ3ViDtX5Sbrk++AWoqjKvcE7MBGVF21UJ7NC5HuhJJ7nzIYz6CyotIBXBF5yXz81zx20hZa+iXkyDkNnQ9tqS4pWsneoI7jQp+8HSOnGRUz5anHvjIa+ZnQw0q7s3sQOaRC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 05D182800B485;
	Sat, 27 Apr 2024 09:08:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DB1641EC347; Sat, 27 Apr 2024 09:08:42 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:08:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZiykekCe-rFe-a5G@wunner.de>
References: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>

On Thu, Apr 25, 2024 at 05:16:24PM -0400, Esther Shimanovich wrote:
> So unless I am misunderstanding something, it appears that my only
> option is waiting for Lukas's patches.

I've just pushed this branch:

https://github.com/l1k/linux/commits/thunderbolt_associate_v1

But it's not even compile-tested yet.  0-day is crunching through it now
and I'll force-push if/when fixing bugs.  It also doesn't contain support
yet for the "Get PCIe Downstream Entry" functionality that's apparently
needed for USB4.

The branch marks PCIe Downstream Adapters on a Root Switch as fixed and
external_facing.

However that doesn't appear to be sufficient:  I notice that in your
patch, you're also clearing the external_facing bit on the Root Port
above the discrete host controller.

Additionally you're marking the bridges leading to the NHI and XHCI
as fixed.  You're also marking the NHI and XHCI themselves as fixed
and external_facing.

I just want to confirm whether all of this is actually necessary.
At least marking the NHI and XHCI as external_facing seems nonsensical.
I need to know the *minimal* set of attribute changes to fix the problem.

I also need to know exactly what the user-visible issue is and how
it comes about.  Your commit message merely says "the build-in USB-C
ports stop working at all".  Does that mean that no driver is bound
to the NHI or XHCI?

The solution implemented by the above-linked branch hinges on the
NHI driver fixing up the device attributes.  But if the NHI driver
is not bound, it can't fix up the attributes.

I notice that commit 86eaf4a5b431 ("thunderbolt: Make iommu_dma_protection
more accurate") bemoans the inability to determine external_facing ports
clearly.  The above-linked branch may solve that, so it seems there may
be overlap between the issue discussed here and the one that the commit
sought to solve.

Thanks,

Lukas

