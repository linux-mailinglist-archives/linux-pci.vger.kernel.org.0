Return-Path: <linux-pci+bounces-6977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652748B912D
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 23:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A97B229ED
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 21:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD864D5BF;
	Wed,  1 May 2024 21:51:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222451649C6
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600260; cv=none; b=qbbIoXolLtA2JtP/GlpixBa/b2HCrM0ztAiVA/0VNUH7e60L85XE4eL9w7k1J7FmKlfEeP2cineIv9/HiV3Ww1GyVS7wzQt+BJwWeX+d3J+3OZh7RbWH1bBCZrS2RF18u+cDhpGWdOOfuwxzEr5t7oEItP+1NvhOr7eS2oyvYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600260; c=relaxed/simple;
	bh=XCQWg7aAGZmD+W6VPcRVR/kos4oLwOoeAg3aXIVkUc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsUDtMq3qKw7EDMeA8yB4bC+lRlj+Z8PIbEtc8v6V3dqx8821v3ST/SKWA3SxUK1E5Axc1fIrDJkXIgWy/Fp0YcEV+KeWuGEq9Wuo8L1FNVd89W6WNpdsinChz3JPLt7FQ+McEJsBU/a5lo9ZqR84ojEMgohp9ulq2jGB/wvvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9886228007E3E;
	Wed,  1 May 2024 23:50:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 64BC741166; Wed,  1 May 2024 23:50:47 +0200 (CEST)
Date: Wed, 1 May 2024 23:50:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
	Peter Delevoryas <pdel@meta.com>
Subject: Re: [PATCH] pci: fix broadcom secondary bus reset handling
Message-ID: <ZjK5N_313fwR5YWd@wunner.de>
References: <20240501145118.2051595-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501145118.2051595-1-kbusch@meta.com>

On Wed, May 01, 2024 at 07:51:18AM -0700, Keith Busch wrote:
> After a link reset, the Broadcom / LSI PEX890xx PCIe Gen 5 Switch in synth
> mode will temporarily insert a fake place-holder device, 1000 02b2, before
> the link is actually active for the expected downstream device. Confirm
> the device's identifier matches what we expect before moving forward.
> Otherwise, the pciehp driver may unmask hotplug notifications before
> the link is actually active, which triggers an undesired device removal.

This won't work if the device was hot-swapped with a different one
and thus correctly returns a different Vendor/Device ID.  We'd wait
for the device to report the previous device's Vendor/Device ID,
which doesn't make sense.

It would be possible to raise d3cold_delay in struct pci_dev for
children of affected Broadcom switches.  Have you considered that
as a potential solution?

Thanks,

Lukas

