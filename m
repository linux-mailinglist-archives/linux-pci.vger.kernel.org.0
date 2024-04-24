Return-Path: <linux-pci+bounces-6650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41C8B1435
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 22:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED821F238FB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361D13C9C6;
	Wed, 24 Apr 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcNalWWx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2A1BC46;
	Wed, 24 Apr 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989552; cv=none; b=kTrSCbOPqnZzGAJGpZfUyvxR9Otbiad4GvXjfNk0LTlqowkn4/YfkjEg9KBce30lPg5fy4REnVTpk9GVzIaVLkkfSnwTpesv1SY6HbtGJpkZ428Z30XbgHEPa7kDqfZGJeN3QWQFqZboC+V8pXsBaoEn6WWk23hqbUukf7orVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989552; c=relaxed/simple;
	bh=l1RGYmYQuIqY4fDQ48B8iWBxN7iKGEFcCbhtbIhBmrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FQNf9v7zgKnsu3OC0Kg70AkrQKdFfOPukItuo3YIlHL1stZgW5PfCW+CSbbn+vD5iBLW84Zatd0Zwxvvf2bSwrE1WnnGTy5RTqAhNY4QTMgt2tbGoVFDbcN+dxAXEaBdfQ7QgTI/77IHO+mOyANBFr4pXlMt7OlWS+ohogSFIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcNalWWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D1BC113CD;
	Wed, 24 Apr 2024 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713989551;
	bh=l1RGYmYQuIqY4fDQ48B8iWBxN7iKGEFcCbhtbIhBmrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FcNalWWxpCc4o499SxiFn2Cwa8YJLOHHzrNRUz8AXiOhIPU37REbmJfFyL7TcHVOe
	 SCbR6x276i0hcxXD6oLp/YQYcj1wPVJNbrBA1pH3sP3B/6RYKWG52mX2WGXDVZW0jj
	 dLjfsL0eXY14W7to1URhERVGxMMQtvpy++eJplf4diEk5Na7tvyIkiU4w1nh18q+yJ
	 m9sETJCH6vMmsWCd7b8L6yNzcx/lLrsZL5j38+2RikjiXS26tbFHYzH9oaQ7DyLnej
	 sJHR1S4R1XLwDkN50wQdvhuYvOemESHhPPE/A5gGnZY4yFTbUO4rDFna4NUTMiMwV3
	 M/rsBId6Kx/7Q==
Date: Wed, 24 Apr 2024 15:12:29 -0500
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
Subject: Re: [PATCH v6 00/10] Make PCI's devres API more consistent
Message-ID: <20240424201229.GA503230@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>

On Mon, Apr 08, 2024 at 10:44:12AM +0200, Philipp Stanner wrote:
> ...
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

There's a lot of good work here; thanks for working on it.

> Philipp Stanner (10):
>   PCI: Add new set of devres functions

This first patch adds some infrastructure and several new exported
interfaces:

  void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar, const char *name)
  void pcim_iounmap_region(struct pci_dev *pdev, int bar)
  int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
  void pcim_release_region(struct pci_dev *pdev, int bar)
  void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
  void __iomem *pcim_iomap_region_range(struct pci_dev *pdev, int bar,
  void pcim_iounmap_region_range(struct pci_dev *pdev, int bar,

>   PCI: Deprecate iomap-table functions

This adds a little bit of infrastructure (add/remove to legacy_table),
reimplements these existing interfaces:

  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
  void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
  int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
  void pcim_iounmap_regions(struct pci_dev *pdev, int mask)

and adds a couple new exported interfaces:

  void pcim_release_all_regions(struct pci_dev *pdev)
  int pcim_request_all_regions(struct pci_dev *pdev, const char *name)

There's a lot going on in these two patches, so they're hard to
review.  I think it would be easier if you could do the fixes to
existing interfaces first, followed by adding new things, maybe
something like separate patches that:

  - Add pcim_addr_devres_alloc(), pcim_addr_devres_free(),
    pcim_addr_devres_clear().

  - Add pcim_add_mapping_to_legacy_table(),
    pcim_remove_mapping_from_legacy_table(),
    pcim_remove_bar_from_legacy_table().

  - Reimplement pcim_iomap(), pcim_iomap_regions(), pcim_iounmap().

  - Add new interfaces like pcim_iomap_region(),
    pcim_request_region(), etc.

    AFAICS, except for pcim_iomap_range() (used by vbox), these new
    interfaces have no users outside drivers/pci, so ... we might
    defer adding them, or at least defer exposing them via
    include/linux/pci.h, until we have users for them.

>   PCI: Warn users about complicated devres nature
>   PCI: Make devres region requests consistent
>   PCI: Move dev-enabled status bit to struct pci_dev
>   PCI: Move pinned status bit to struct pci_dev
>   PCI: Give pcim_set_mwi() its own devres callback
>   PCI: Give pci(m)_intx its own devres callback
>   PCI: Remove legacy pcim_release()
>   drm/vboxvideo: fix mapping leaks
> 
>  drivers/gpu/drm/vboxvideo/vbox_main.c |   20 +-
>  drivers/pci/devres.c                  | 1011 +++++++++++++++++++++----
>  drivers/pci/iomap.c                   |   18 +
>  drivers/pci/pci.c                     |  123 ++-
>  drivers/pci/pci.h                     |   21 +-
>  include/linux/pci.h                   |   18 +-
>  6 files changed, 999 insertions(+), 212 deletions(-)
> 
> -- 
> 2.44.0
> 

