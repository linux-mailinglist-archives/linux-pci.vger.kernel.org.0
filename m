Return-Path: <linux-pci+bounces-6719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E218B4466
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 07:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D343B1C2245A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D8381C7;
	Sat, 27 Apr 2024 05:35:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA73FBBF;
	Sat, 27 Apr 2024 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714196140; cv=none; b=frtfIGMPz/Yil5AZES1/kIop6RTD6sAz2iCIk2MgfgPlfG+MeY5+7dhWBthKfaItsmsOyfbqS3zCvePlqrnrfz9A9ThV0xaGwK169N56set9MXMqa03Qjdyc7a4DijPQ3MUgu8JBN9nM+E4mv4Jj2aqDTwO+EZGFyoVOjM4rNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714196140; c=relaxed/simple;
	bh=FydKzk9IMY7WF4Up9h/mfHIIoqBtqlvl//KZxLqMQ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8LrVr9ojrAwGmrXmHdk6kwhSLn8x5DbvHzrlFSc+QmaxxuspqmnfeVNmMxB4WQ/G2961VEUz+W0o26yU9e5yJ+ubJyVdhQ7T3wHQqAsQQEz5iCJm5A/QL9nJHQ+N7H5iHdEbEVZtcYAoVcIfzLDwvVdM5OjZgx5jeEKQqq2WPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 019D11019569E;
	Sat, 27 Apr 2024 07:35:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B1DE771E12; Sat, 27 Apr 2024 07:35:33 +0200 (CEST)
Date: Sat, 27 Apr 2024 07:35:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZiyOpZlHVH2yaC1B@wunner.de>
References: <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <20240426045207.GI112498@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426045207.GI112498@black.fi.intel.com>

On Fri, Apr 26, 2024 at 07:52:07AM +0300, Mika Westerberg wrote:
> On Thu, Apr 25, 2024 at 05:16:24PM -0400, Esther Shimanovich wrote:
> > I did find one example of a docking station that uses the DSL6540
> > chip, which has PCI IDs defined in include/linux/pci_ids.h:
> > #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
> > #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
> > It seems like it has an NHI, despite being in an external, removable
> > docking station. This appears to contradict what you say about only
> > having "NHI" on a host router. I am assuming that by host router, you
> > mean the fixed discrete, fixed thunderbolt chip, or the thunderbolt
> > controller upstream to the root port. Please correct me if I got
> > anything wrong!
> 
> So it goes same way with other discrete chips from Intel at least. It is
> the same silicon but the NHI is disabled on device routers.
> 
> That said, it is entirely possible for a "malicious" device to pretend
> to have one so we need to be careful.

If a device (accidentally or maliciously) exposes an NHI, the thunderbolt
driver will try to bind to it.

Do we take any precautions to prevent that?

AFAICS we'd be allocating a duplicate root_switch with route 0.
Seems dangerous if two driver instances talk to the same Root Switch.

This looks like something that needs to be checked by Intel Validation
Engineering folks.  Have they been testing this?  (+cc Gil)

Thanks,

Lukas

