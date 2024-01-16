Return-Path: <linux-pci+bounces-2237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B053882FCD2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407F3B24DD4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2411E519;
	Tue, 16 Jan 2024 21:37:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6520319
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441067; cv=none; b=UVHUHfpbnk2Uq779Qs0sXfT0uvQIHlTFC9d+NAYd/aVjhJslOZkniAVVmHPCBXsbnWUQKl/2F8M7buYPq8hVppxhBU2fAi8YMJ650U0XQWKTPC6OZ7jEvenKLpoQvYsq6OLNs2d+AWpW68Bl0ejxWkHHsT42AuE8lli8eUwpfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441067; c=relaxed/simple;
	bh=DrPYOohz5TNLetnSbNFby5mXuPuzhsqpd/t6fTixqvY=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=rESAlXc56GjK6MZPD2NWpDnMzfWHe8b9Oay69As2gSibUgQEld569PYEnDtQwcvfNLeKqNbyIlLj168G+gUVWyXAopza18YiWbnZRF3dZysT3iCQPT77wZMsgQn94ZFV7lhM1YvaVHz6mD3bIHEz062oO1A4Lj6kRutwzwgQcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 7afc7402-b4b7-11ee-abf4-005056bdd08f;
	Tue, 16 Jan 2024 23:37:43 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Tue, 16 Jan 2024 23:37:39 +0200
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
Subject: Re: [PATCH 08/10] pci: devres: give pci(m)_intx its own callback
Message-ID: <Zab3I9o_BXRjYm4j@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
 <20240115144655.32046-10-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-10-pstanner@redhat.com>

Mon, Jan 15, 2024 at 03:46:19PM +0100, Philipp Stanner kirjoitti:
> pci_intx() is one of the functions that have "hybrid mode" (i.e.,
> sometimes managed, sometimes not). Providing a separate pcim_intx()
> function with its own device resource and cleanup callback allows for
> removing further large parts of the legacy pci-devres implementation.
> 
> As in the region-request-functions, pci_intx() has to call into its
> managed counterpart for backwards compatibility.
> 
> Implement pcim_intx() with its own device resource.
> Make pci_intx() call pcim_intx() in the managed case.
> Remove the legacy devres struct from pci.h.

...

> +	/*
> +	 * This is done for backwards compatibility, because the old pci-devres
> +	 * API had a mode in which this function became managed if the dev had
> +	 * been enabled with pcim_enable_device() instead of pci_enable_device().
> +	 */
> +	if (pci_is_managed(pdev)) {
> +		if (pcim_intx(pdev, enable) != 0)
> +			WARN_ON_ONCE(1);

		WARN_ON_ONCE(pcim_intx(pdev, enable));

?

> +		return;
> +	}

...

> +	if (new != pci_command)

	if (new == pci_command)
		return;

?

>  		pci_write_config_word(pdev, PCI_COMMAND, new);

-- 
With Best Regards,
Andy Shevchenko



