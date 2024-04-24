Return-Path: <linux-pci+bounces-6652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255148B143C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F6D288EDB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501E013D2BC;
	Wed, 24 Apr 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVnkFev/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2813C9C6;
	Wed, 24 Apr 2024 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989576; cv=none; b=HxFLdXMsfuwmdx/ZDW0ueDTdGJ6YnXXEaqTAQk7VtTp8K8uM+TWkAGxQ2Wz4+IM8MaPgcBduwlnfdU0aO8Z0yXHWWhN+TgVcDiyQIAFxmhL+NbPDFsPFLtcjYowfB5R8Wym78yi9Vu0hv/xADs4NZQhXJF+HhI12g3ax88eZMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989576; c=relaxed/simple;
	bh=Z31A8N0qW+ZyGJx8PwhBZp2nsGK8UYpFU7rmbakzEfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TcM0yEUlvD1Rlwr3dbN3hl9JMEnS+EO9H9dIBh9aq/dnpJJhCUyJM26lvZuChhK/9K8rtQRbemIDwlhyN/p+LYHSexv2aIByyiujdi52uJ8l0HGFkUnP8kPYE0wXcXD+ITboCtysiwNaserPtwa+4b5hxayb9+uR8erffMjy7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVnkFev/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91507C113CD;
	Wed, 24 Apr 2024 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713989575;
	bh=Z31A8N0qW+ZyGJx8PwhBZp2nsGK8UYpFU7rmbakzEfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kVnkFev/TiZTySQUl4vTE3gALeCYbONHxzH+MJibn9p60uXTGAbHlT7Jm6T0LG431
	 AldHO2UoU3LA5UJeDdQzsDqD9ANeyL18Kd4+nM3DN2TcLuwwN6AMDbGAC53CjtSJVe
	 hM41diZx+HhF+/tTHMHdssvTCmJKfH7YJNyX6N2LNbi4kULJH5B6z4rCjH9vQFfFk+
	 suMwe50kS0IvOjRmKeECTqlxEWiev8IXU1GzRq6klc7ukkDdEl6tC3WPQ3EScIHpQJ
	 6DLftMO+cXRHN4hs5bWTflXQ99tX07tk8z1bJ7BmW9V4sS9tf+UL7iT4fU4U9Jly52
	 ji6qGFJSyN5bQ==
Date: Wed, 24 Apr 2024 15:12:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 03/10] PCI: Warn users about complicated devres nature
Message-ID: <20240424201253.GA499493@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408084423.6697-4-pstanner@redhat.com>

On Mon, Apr 08, 2024 at 10:44:15AM +0200, Philipp Stanner wrote:
> The PCI region-request functions become managed functions when
> pcim_enable_device() has been called previously instead of
> pci_enable_device().
> 
> This has already caused bugs by confusing users, who came to believe
> that all pci functions, such as pci_iomap_range(), suddenly are managed
> that way.

Since you mention a bug, it'd be nice to include a URL or commit if
you have one.

> This is not the case.
> 
> Add comments to the relevant functions' docstrings that warn users about
> this behavior.

> @@ -3914,6 +3916,13 @@ EXPORT_SYMBOL(pci_release_region);
>   *
>   * Returns 0 on success, or %EBUSY on error.  A warning
>   * message is also printed on failure.
> + *
> + * NOTE:
> + * This is a "hybrid" function: Its normally unmanaged, but becomes managed
> + * when pcim_enable_device() has been called in advance.
> + * This hybrid feature is DEPRECATED! If you need to implement a new pci
> + * function that does automatic cleanup, write a new pcim_* function that uses
> + * devres directly.

This note makes sense on exported functions, but I think it's overkill
on static ones like this.

s/Its normally/It's normally/
s/new pci/new PCI/

Rewrap into one paragraph (or separate by blank line).

Applies to all the hunks of this patch.

>  static int __pci_request_region(struct pci_dev *pdev, int bar,
>  				const char *res_name, int exclusive)

