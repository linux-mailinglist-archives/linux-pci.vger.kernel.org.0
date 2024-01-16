Return-Path: <linux-pci+bounces-2220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F982F485
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 19:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3570DB22AAE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034081CF8F;
	Tue, 16 Jan 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4Z0AZN/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA81CD33;
	Tue, 16 Jan 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430678; cv=none; b=abzVzMBbTSkUmBaxB2HCehU3fkr5HxKbktKnsLEuCxVzq263JROB7cJtnVVJe5L3Gj/f2D+S6JWVnlDxTkUDdZnakf+y8lXH4lLilbeVvc59OhrfMbA51/R+zrZny2T6zgsMDAqQq5C38bmwXMqbguR3h8nGnet94/3O758h+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430678; c=relaxed/simple;
	bh=hQkulcNIkuAvuM+4UOBSRVqqf8pRQ1TkYnDyipqHu9Q=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=LGQYOx6JVrGBSrERRTYy02ogN9yWRnkm+OF8eZkTMjCZ7+5vhxrMhO+ikeOhxB5RIH02taAivgYN0PV+ESMz77z7THNJJPztTQadwRgLqip2GR+x6n3VbYjT4ftEqPKiJfmbpUSsOtIvYfpCzyiU3lnZFIXMvi/5j8RZStYtR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4Z0AZN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23771C433F1;
	Tue, 16 Jan 2024 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430678;
	bh=hQkulcNIkuAvuM+4UOBSRVqqf8pRQ1TkYnDyipqHu9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M4Z0AZN/db2RgMT7oCsZe7mx3q9it8JCiTGD84rVdIBh8RyqAfHjYeVKi0zVvADQw
	 hjyVJKrG2LyryU4fZjmzcDdKGx+sFlEMYCam0MrfEZTVG1Q277dhC+QDiYL1woLucz
	 /YpkUvebvEkTkc+y8isyvUe42CAfc4L9AqvDFRh9jNVQzA56BAJ2CU+ErVhOSp5GDQ
	 EVoUmUDVLQxgcRKzIhiBfCFT2HhI0+jq+MOFXF3Yj0YmIcWV8qYcC8u+vFfWIqJ/Ne
	 wB+s9FfDOvm3uXSXkIgunCgCVYb1VBSpOha2FqRzBSWGKOwWZBwkNHjKtTndCFB00z
	 auD9dqR0gWeNw==
Date: Tue, 16 Jan 2024 12:44:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 01/10] pci: add new set of devres functions
Message-ID: <20240116184436.GA101781@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-3-pstanner@redhat.com>

On Mon, Jan 15, 2024 at 03:46:12PM +0100, Philipp Stanner wrote:
> PCI's devres API is not extensible to ranged mappings and has
> bug-provoking features. Improve that by providing better alternatives.

I guess "ranged mappings" means a mapping that doesn't cover an entire
BAR?  Maybe there's a way to clarify?

> When the original devres API for PCI was implemented, priority was given
> to the creation of a set of "pural functions" such as
> pcim_request_regions(). These functions have bit masks as parameters to
> specify which BARs shall get mapped. Most users, however, only use those
> to mapp 1-3 BARs.
> A complete set of "singular functions" does not exist.

s/mapp/map/

Rewrap to fill 75 columns or add blank lines between paragraphs.  Also
below.

> As functions mapping / requesting multiple BARs at once have (almost) no
> mechanism in C to return the resources to the caller of the plural
> function, the devres API utilizes the iomap-table administrated by the
> function pcim_iomap_table().
> 
> The entire PCI devres implementation was strongly tied to that table
> which only allows for mapping whole, complete BARs, as the BAR's index
> is used as table index. Consequently, it's not possible to, e.g., have a
> pcim_iomap_range() function with that mechanism.
> 
> An additional problem is that pci-devres has been ipmlemented in a sort
> of "hybrid-mode": Some unmanaged functions have managed counterparts
> (e.g.: pci_iomap() <-> pcim_iomap()), making their managed nature
> obvious to the programmer. However, the region-request functions in
> pci.c, prefixed with pci_, behave either managed or unmanaged, depending
> on whether pci_enable_device() or pcim_enable_device() has been called
> in advance.

s/ipmlemented/implemented/

> This hybrid API is confusing and should be more cleanly separated by
> providing always-managed functions prefixed with pcim_.
> 
> Thus, the existing devres API is not desirable because:
> 	a) The vast majority of the users of the plural functions only
> 	   ever sets a single bit in the bit mask, consequently making
> 	   them singular functions anyways.
> 	b) There is no mechanism to request / iomap only part of a BAR.
> 	c) The iomap-table mechanism is over-engineered, complicated and
> 	   can by definition not perform bounds checks, thus, provoking
> 	   memory faults: pcim_iomap_table(pdev)[42]

Not sure what "pcim_iomap_table(pdev)[42]" means.

> 	d) region-request functions being sometimes managed and
> 	   sometimes not is bug-provoking.

Indent with spaces (not tabs) so it still looks good when "git log"
adds spaces to indent.

> + * Legacy struct storing addresses to whole mapped bars.

s/bar/BAR/ (several places).

> +	/* A region spaning an entire bar. */
> +	PCIM_ADDR_DEVRES_TYPE_REGION,
> +
> +	/* A region spaning an entire bar, and a mapping for that whole bar. */
> +	PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING,
> +
> +	/*
> +	 * A mapping within a bar, either spaning the whole bar or just a range.
> +	 * Without a requested region.

s/spaning/spanning/ (several places).

> +	if (start == 0 || len == 0) /* that's an unused BAR. */

s/that/That/

> +	/*
> +	 * Ranged mappings don't get added to the legacy-table, since the table
> +	 * only ever keeps track of whole BARs.
> +	 */
> +

Spurious blank line.

> +	devres_add(&pdev->dev, res);
> +	return mapping;
> +}
> +EXPORT_SYMBOL(pcim_iomap_range);

Bjorn

