Return-Path: <linux-pci+bounces-2236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D384682FCCF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71984282F08
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5DF3589E;
	Tue, 16 Jan 2024 21:34:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4735892
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440888; cv=none; b=cMt02s62NB0cPlnHGYs7IkwNgGsg06P4hq0XG3R08+zWVDTWusiO7GUuIrQV06mpAJa99NOioNJr3SIkOY1S7neXurwe71UPebH9CHGSLYYhBA4nycTan6LsRl1kVtrLKd0hIOyemawVVH3DJfKtejEtg7RQJcNSnUrRZJdhvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440888; c=relaxed/simple;
	bh=8q2kkthKKZfmYT6jrWqhYmpSkNgCxvG1e59sTCJKmBA=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=lwlnh2481x1/mRSBo4kihnWowA6k7IE2MiwMyawiIo6/cTaEbDcXk4SluAHPUWzhnq8qLTFrCXR8wu4Uhctb49EL28EbOG8M6gJG/BVZh4HxJIubAstAGyqcVWxx0m1VkFMkPGYB38Ha0uq0Hk5XTq8aG94f6LYo7B6bHNQTFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 10895911-b4b7-11ee-a9de-005056bdf889;
	Tue, 16 Jan 2024 23:34:44 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Tue, 16 Jan 2024 23:34:44 +0200
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
Subject: Re: [PATCH 06/10] pci: move pinned status bit to pci_dev struct
Message-ID: <Zab2dC6HVmk2gEwn@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
 <20240115144655.32046-8-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-8-pstanner@redhat.com>

Mon, Jan 15, 2024 at 03:46:17PM +0100, Philipp Stanner kirjoitti:
> The bit describing whether the PCI device is currently pinned is stored
> in the PCI devres struct. To clean up and simplify the pci-devres API,

"PCI devres", 'pci-devres', ...
Shouldn't these (and across entire series) be consistent terms?
E.g., "PCI devres API".

> it's better if this information is stored in the pci_dev struct, because

pci_dev struct --> struct pci_dev

> it allows for checking that device's pinned-status directly through the
> device struct.
> This will later permit simplifying  pcim_enable_device().

> Move the 'pinned' boolean bit to struct pci_dev.

...

>  	u8		pm_cap;		/* PM capability offset */
>  	unsigned int	enabled:1;	/* Whether this dev is enabled */
> +	unsigned int	pinned:1;	/* Whether this dev is pinned */
>  	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */

First of all, I think it's better to group PM stuff, like

	u8		pm_cap;		/* PM capability offset */
	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
					   can be generated */
	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
	unsigned int	enabled:1;	/* Whether this dev is enabled */
	unsigned int	pinned:1;	/* Whether this dev is pinned */

Second, does this layout anyhow related to the HW layout? (For example,
PME bits and their location in some HW register vs. these bitfields)
If so, but not sure, it might be good to preserve (to some extent) the
order.

-- 
With Best Regards,
Andy Shevchenko



