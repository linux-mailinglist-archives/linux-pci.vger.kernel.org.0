Return-Path: <linux-pci+bounces-2235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B317F82FCAD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639071F2CFFE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE3328C1;
	Tue, 16 Jan 2024 21:29:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1243418F
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440576; cv=none; b=k7t6HUR6DwpIdHrKagAiJxE+s8fZCJEgZbe5t8sULNhmLoGjdrGh8g+N4E7nExgZmJI945pFWK3ZPmX67U66bJvz127K19l4sRbvYqhlfiLrDhQDaFZ6+P3pVJv1tts5UteJi3ReTRk9aYZpiDe9SOjJje+NPxYgPk4mote7X+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440576; c=relaxed/simple;
	bh=iKqKH6e4RDFRFZxOWMGe7xqaGvkzIxvIqzTieuZVuao=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=JymDKSXeRfgbHGgHR4PkbjEoz/1v3ZhrSMzjY4YkxMVX0pat+MUG1ceSbiVpTBrznR+A63e+zBWqYvUQ82Tz/zT5Dt5V1nPrD7auW/OHk3ujxU7gTeymNMinQcDMljPWSCtFoAK4aLbeyGoaq5KDDpsviIsF2L6eijA0E+9ybyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 56bdf0cf-b4b6-11ee-abf4-005056bdd08f;
	Tue, 16 Jan 2024 23:29:33 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Tue, 16 Jan 2024 23:29:32 +0200
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
Subject: Re: [PATCH 04/10] pci: devres: make devres region requests consistent
Message-ID: <Zab1PKqs4UHI5ilz@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
 <20240115144655.32046-6-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-6-pstanner@redhat.com>

Mon, Jan 15, 2024 at 03:46:15PM +0100, Philipp Stanner kirjoitti:
> Now that pure managed region request functions are available, the
> implementation of the hybrid-functions which are only sometimes managed
> can be made more consistent and readable by wrapping those
> always-managed functions.
> 
> Implement a new pcim_ function for exclusively requested regions.
> Have the pci_request / release functions call their pcim_ counterparts.
> Remove the now surplus region_mask from the devres struct.

...

> +	if (pci_is_managed(pdev)) {
> +		if (exclusive == IORESOURCE_EXCLUSIVE)
> +			return pcim_request_region_exclusive(pdev, bar, res_name);
> +		else

Redundant 'else'

> +			return pcim_request_region(pdev, bar, res_name);
> +	}

-- 
With Best Regards,
Andy Shevchenko



