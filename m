Return-Path: <linux-pci+bounces-11068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19053943683
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 21:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE644281B80
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCE3CF74;
	Wed, 31 Jul 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3lGUVjV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351038DEC;
	Wed, 31 Jul 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454568; cv=none; b=kfXVaVgMhoEEX0+9Rq9AhbWMu5mDOrH00HSZFPcgTXSD6wcrqKL0uARjtIH+14QpizmAL2AfZNwwW92a/jA45/3pL6Y4LyH9i2hMGqqlXQwdawgLC737wAyEwjHK/mHFdhkp7x3tWph22z2SqOkPgHpBbUhZIULM9DuHM8N6WpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454568; c=relaxed/simple;
	bh=Vd8fqkfwlFHhHJNjJJ8PkDDVoKHE/NzxbbiRJuqU6A0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K7qiSsMegXuiBoLOOTbGF+45D184N6WNC84sZ9z31boo8ruW9wehEeUlqsiW7BdgtE0AxX4wr2KodxhpP1V2tSiPKV7WrvoOtyzYe9YK81nFjpnVHQYF9jRpH2Qw8hlTz24KL7gswg+Gkg19SB3JyB5beWcPvfI8L6fSQ14guCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3lGUVjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F04CC4AF09;
	Wed, 31 Jul 2024 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722454567;
	bh=Vd8fqkfwlFHhHJNjJJ8PkDDVoKHE/NzxbbiRJuqU6A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O3lGUVjVHsx7HxAGvOsQhXjWehnqSCzJRaSafGYfyuPCnIDC8kkVYuBLh/NTlR0MU
	 JiSYF37mpYv+0icISrQuZZWIvj2olN6Y/A9/cWG1073dfshcJjHju5ctJMqRcdjzWl
	 7t+Xy/r5iTYrFHtFDgT9/9Ot6jBGYXmvIggEfzpcmUdiG0NfqeC1jwA3HGGCZZCmBK
	 /RCUfTUbdHEyCuqW2AiPMz1zS17cG91dyX+K4aTuf9kHVTtL+tjo5xN+YoMcaOOHOc
	 znkXmAqpV1sdxfkjPOJHYp1KwZJJ5eLNt8tltPjHIIZPSFQBoRBSoU59+7W1FY5rp8
	 Fz7ZQs5+FzpWA==
Date: Wed, 31 Jul 2024 14:36:05 -0500
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
Message-ID: <20240731193605.GA77260@bhelgaas>
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

Given an ack from the vboxvideo maintainers, I can apply both of these
via the PCI tree so there's no race during the merge window.

