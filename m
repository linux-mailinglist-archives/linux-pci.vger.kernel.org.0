Return-Path: <linux-pci+bounces-11121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA11945141
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5606F284D66
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E91B3736;
	Thu,  1 Aug 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKIGiMer"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F41B29AF;
	Thu,  1 Aug 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531848; cv=none; b=l1ZnNRufzUK0tVd0adFyP0zhUjDN+AfZISyxWS5kiMTSNrkq3OcBWe6aYpGNGNKg4kNfKBpzHduPwOiqgCoTjgTCa+Y9I/kcJCBBdtvKxrKXWB0PCv6eqL5H09hNbSwhoucyYA8CZqCWOS0kXTZASBAeilEO2qM9uMr9IxVHF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531848; c=relaxed/simple;
	bh=ctBYTvcSoyXQzBR+EgWwQU7XaNzi5QtXFTkUFSCB0Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EcHBuXqhbzD0Wna0Y6XyiwrtiMRmHK4Rx9SXaIJRj1+04eaeGVya8US5U9RyHQW7H01SeEfnWWF0yRSaTqt2DA3Ghvz5m1BLUNk0B/0ZLUOmrlrr6FiQqJhgi1qNgHtgejYvzsjlsi3HyRmaHzSZDOaGrfUE0XDMrK6hl14+IFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKIGiMer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42318C32786;
	Thu,  1 Aug 2024 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722531848;
	bh=ctBYTvcSoyXQzBR+EgWwQU7XaNzi5QtXFTkUFSCB0Ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LKIGiMerh5HpOdwwADCsnTv2T1lWQHFG1qAosPxRGNY55J5YKzJO4b3ARVmKyGdsU
	 ZmOz5qabrtR4f9MBw7fPpHxIzUqCG9AhGl9KKVjUY4Jhnys6zSePj2kAELHIwxBeiP
	 uv5yk21451aYP5C9d70Bu0X6mdvfgdQON7qZHj2i29NtRvs6YHJIq/HK1c/UEwwpdF
	 1FKrZT6zpkTQZsrWiiu6y8SB4XlDhwuXYt7Udk6XJQWX+Itcufmfjzmeve5CP1XR1k
	 AvR6lrhh/arQ0rRcMaeFGxnY/x4VbYZQ5QS3HCYlpGCHOyYCx5jMO9NPcmSFibqktx
	 nTHjlmMvZxnhg==
Date: Thu, 1 Aug 2024 12:04:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Use pcim_request_region() in vboxvideo
Message-ID: <20240801170405.GA107618@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729093625.17561-2-pstanner@redhat.com>

On Mon, Jul 29, 2024 at 11:36:24AM +0200, Philipp Stanner wrote:
> Hi everyone,
> 
> Now that we've got the simplified PCI devres API available we can slowly
> start using it in drivers and step by step phase the more problematic
> API out.
> 
> vboxvideo currently does not have a region request, so it is a suitable
> first user.
> 
> P.
> 
> Philipp Stanner (2):
>   PCI: Make pcim_request_region() a public function
>   drm/vboxvideo: Add PCI region request
> 
>  drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++++
>  drivers/pci/devres.c                  | 1 +
>  drivers/pci/pci.h                     | 2 --
>  include/linux/pci.h                   | 1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)

Applied with Hans' ack to pci/devres for v6.12, thanks!

