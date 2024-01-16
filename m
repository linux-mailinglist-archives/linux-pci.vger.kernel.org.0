Return-Path: <linux-pci+bounces-2218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1282F445
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF991F24B43
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68211CD29;
	Tue, 16 Jan 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFoyXt9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8461D53F;
	Tue, 16 Jan 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429785; cv=none; b=mQnJKpWiUhmeN/ODm5Tk8q86JKgDOIkAqoqvZ+kIxAqvD1VBVV0G/Yzn//udtilmBpYBRJVDUjxcNTnvcOl1eyC8dZFlh/j8W962LSJCR37rgAmpuFqLftwnBIa2ykBO61L+/ZdmFGU62T1kPhQd+thyKdHrtSpKirf4KvDZiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429785; c=relaxed/simple;
	bh=QyGcrPCsH5mWKeg5veqXTGBrCMU5whrzG0xwiht42Ho=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=EH8zXlkN93qOuUUW8aVR8w0WZrQUCgrd8ec9uk5OlOrmSo2KHgzoWnQoF2hxXy+QB8VL8YkVzvuZyu9PIfuOoagwzHaH2JUa1hFi2YZ35kIWKHDDcWbPOV+nqfyucJwpUFO1N3T7z9WTORgKkgsAOfKs8bDh3q44RL81DUO00Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFoyXt9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB2FC433F1;
	Tue, 16 Jan 2024 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705429785;
	bh=QyGcrPCsH5mWKeg5veqXTGBrCMU5whrzG0xwiht42Ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tFoyXt9kT1rTsYtkOnwMFL1QYGCE/KuqoqnKJWZHglwRNZHtacgndtF8KDNZi9VTp
	 mmVJzQUf3ZPZ5QUJ/F8imfU84MNAE5cC3JtaOJYDnYotRRJNILzhBjZ8rzqZ6ydORc
	 aspbtRFkOtBBt6cZdyAdF5ixsMVOpItx3R6/UtubYM5GLLFAbafL0I0jJ0TtuwnKn5
	 jNG2mSJBHe8FqVmOAJiwpYkiuK9bZyu4SMncNDE3SpMj0iuJQZ4ooov5mbITZp3CBt
	 bAuaVoQdsAi1Ie5Ycpyiu3o7r2v2wnjwpl7saN3YQ0rP4z3bVgfYh1+vM+/XFZ4weo
	 Rz//p/WpwIpbg==
Date: Tue, 16 Jan 2024 12:29:43 -0600
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
Subject: Re: [PATCH 00/10] Make PCI's devres API more consistent
Message-ID: <20240116182943.GA101377@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-2-pstanner@redhat.com>

On Mon, Jan 15, 2024 at 03:46:11PM +0100, Philipp Stanner wrote:
> ...

>   pci: add new set of devres functions
>   pci: deprecate iomap-table functions
>   pci: warn users about complicated devres nature
>   pci: devres: make devres region requests consistent
>   pci: move enabled status bit to pci_dev struct
>   pci: move pinned status bit to pci_dev struct
>   pci: devres: give mwi its own callback
>   pci: devres: give pci(m)_intx its own callback
>   pci: devres: remove legacy pcim_release()
>   drm/vboxvideo: fix mapping leaks

If/when you update these, take a look at the drivers/pci/ subject line
history and capitalize these to match.

We haven't really used the "devres" prefix in drivers/pci.

The de facto convention is:

  - "PCI/AER:" for major features defined by the PCIe base spec (AER,
    DPC, VGA, ASPM, PM, etc).

  - "PCI: iproc:" for controller drivers (iproc, dwc, qcom, mvebu,
    etc).

  - "PCI:" for everything else

