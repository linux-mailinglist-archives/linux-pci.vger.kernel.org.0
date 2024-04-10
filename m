Return-Path: <linux-pci+bounces-6099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0B8A0388
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358CA288428
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD600175A4;
	Wed, 10 Apr 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2VUPn7B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XHwcKB+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB7C8DE;
	Wed, 10 Apr 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789112; cv=none; b=DR9F/FwZUv19I+hTM5+7YBTOgJ0OJ/LNeeFHHvKwTetapQ5NUSK5p+JSYeMMxyBDXtu0B5kn9SSCux576uoWisY805OphgOSCQM8xDUmd/EngN5M9/S5Rx44Jk7/Nk3jJE6xYMz6948Qq775fyW7jzLuKkIMiINCq/9kNJX0i64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789112; c=relaxed/simple;
	bh=WeZllxq7TttKSWb/B/xcRfnzOGFwGN/uRbD0A2tilJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/r5FwMiT3pipPWfrTbQ2q4uT5UGVLesfoaiYlzKY9o7SJj2fsgZ+hcFBXBiYjBy4M/wuJF+RG/3YkNYtc/5dHRb6pEYKwvS7LXz6OrErjIU12dC7Gs/cZSAdmCMR7BXbIkPgY9XA0d5yDePr9NlyAuWkU5dqJdpDuHt4eGkWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2VUPn7B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XHwcKB+F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73LrkXOaXiFL9Q356e61wUHtK1Ks48GRA3mlWdlLbVs=;
	b=x2VUPn7BPO/ZPg9Pa3S+OrYrnms+v2nZgwRuq9JUk7yDkGtUDyph3q29SQhmYbtFQ+9bXh
	qN03qDIE1DwOCSK/tcdfXRU6Di73hdHk4Sg7X5PtRO10m6srfh6iYpC2OmJSnnciSGn6tR
	+MwW92Wo7yksogaJq6LA4d/55jEALi2qV/Tgvra+0RpXUXHvHo3UjlVi4GmqDib8AvxWh3
	hKSH7tF0tWfx3W5ZhcEhQIRZHIxJ2wvkNA9CAA4z9UHSEhZJQOwmOqjxtFd94pzZ3B8GJd
	Z31EGJPIpCte0So2Xu2JBMTejmnJjgEVwp/UwcKALmyh1UWA+5gVWge/Wamcbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73LrkXOaXiFL9Q356e61wUHtK1Ks48GRA3mlWdlLbVs=;
	b=XHwcKB+FT/a82sWEvZhG0tMj9ZcsMjAaf3GCAeOU8rR8hQuSGJ1vb45oNC2QvxX4XGe78m
	vmNC82VPdKduooCw==
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Marc Zyngier <maz@kernel.org>,
 Reinette Chatre <reinette.chatre@intel.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Dave Jiang
 <dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Robin Murphy
 <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/7] PCI/MSI: Remove IMS (Interrupt Message Store)
 support for now
In-Reply-To: <20240410221307.2162676-1-helgaas@kernel.org>
References: <20240410221307.2162676-1-helgaas@kernel.org>
Date: Thu, 11 Apr 2024 00:45:08 +0200
Message-ID: <87wmp425xn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 17:13, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.

Bah.

> Remove it for now.  We can add it back when a user comes along.
>
> I propose to merge this via the PCI tree unless somebody else wants it.

Go wild!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

