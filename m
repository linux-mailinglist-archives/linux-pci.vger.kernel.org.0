Return-Path: <linux-pci+bounces-2232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B4082FC9C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875571F2BA3B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C12E626;
	Tue, 16 Jan 2024 21:18:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D52E624
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439916; cv=none; b=SeS8ufiXNChZblkR0eXXpCq8pjBKPwVlDYQrgB2fxvEjm49dIFijywkdji0g3eYvnRe5pGHAgbFuFXPIBB62Bf6pI88vNz/4UvmCMAuKruaLhrws1vdI5Ye2XFhQUqlu2y7cN2TjMqSZMMGqCocDHcjHBW6OyidrxJlRSYVEzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439916; c=relaxed/simple;
	bh=lvkTMMRuhJu5viOvzqXhbppQZAvUMGytV+uhbZeFHo0=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=YFzcLNLjVn1VbNr+84Z2J8YiKVUz8YtdfpDbyVBPmdNP9kSIu0qODd44y49rgnYNoAyknSjuIZwyGkNqlUbzgbfEIpx784t+v/gUJPQLRPiXDWJG38B6J6VzFOTXmWaZjQ/+PL1Zbv0fZtJC172NofqumcaRV9+w/ktyuluyio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id a42b3ea7-b4b4-11ee-abf4-005056bdd08f;
	Tue, 16 Jan 2024 23:17:24 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Tue, 16 Jan 2024 23:17:23 +0200
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/10] Make PCI's devres API more consistent
Message-ID: <ZabyY3csP0y-p7lb@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115144655.32046-2-pstanner@redhat.com>

Mon, Jan 15, 2024 at 03:46:11PM +0100, Philipp Stanner kirjoitti:
> ¡Hola!

i? Vim user? :-)

> PCI's devres API suffers several weaknesses:
> 
> 1. There are functions prefixed with pcim_. Those are always managed
>    counterparts to never-managed functions prefixed with pci_ – or so one
>    would like to think. There are some apparently unmanaged functions
>    (all region-request / release functions, and pci_intx()) which
>    suddenly become managed once the user has initialized the device with
>    pcim_enable_device() instead of pci_enable_device(). This "sometimes
>    yes, sometimes no" nature of those functions is confusing and
>    therefore bug-provoking. In fact, it has already caused a bug in DRM.
>    The last patch in this series fixes that bug.
> 2. iomappings: Instead of giving each mapping its own callback, the
>    existing API uses a statically allocated struct tracking one mapping
>    per bar. This is not extensible. Especially, you can't create
>    _ranged_ managed mappings that way, which many drivers want.
> 3. Managed request functions only exist as "plural versions" with a
>    bit-mask as a parameter. That's quite over-engineered considering
>    that each user only ever mapps one, maybe two bars.
> 
> This series:
> - add a set of new "singular" devres functions that use devres the way
>   its intended, with one callback per resource.
> - deprecates the existing iomap-table mechanism.
> - deprecates the hybrid nature of pci_ functions.
> - preserves backwards compatibility so that drivers using the existing
>   API won't notice any changes.
> - adds documentation, especially some warning users about the
>   complicated nature of PCI's devres.

Instead of adding pcim_intx(), please provide proper one for
pci_alloc_irq_vectors(). Ideally it would be nice to deprecate
old IRQ management functions in PCI core and delete them in the
future.

-- 
With Best Regards,
Andy Shevchenko



