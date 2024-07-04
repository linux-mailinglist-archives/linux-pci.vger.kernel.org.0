Return-Path: <linux-pci+bounces-9775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DECF926F57
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8A6B220E7
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 06:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F98107A0;
	Thu,  4 Jul 2024 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yDApkY8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AFAFC0A;
	Thu,  4 Jul 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073506; cv=none; b=PrmBVEsa8LP+ZFuZoXlPN5quhnHUQfRpEBs3MdSA+Y+/jX359gK5r8opSAM2GWBl/br0+fM5wRlAQywOTlHn/8XwDlKLIJHz2D5v1wK18/4uL95+aqJHBGXygrofKy5Gtx8f8SPYVEcvWxzRNhBvZ2n0iVobBN8N2g6snWIv5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073506; c=relaxed/simple;
	bh=aDrAoHB8yy2A3/CS5V0LEYqnLU6En2W4VPvbgotYtWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt1QxoHVQ1dO2zx08BhX6mK76T6fH2NOAS1k4RuKhnGwT3blbsgoRndUMmeZWHE/6PEPMQjKyRL3uTjv56HqM4mKGLnawLdz7G2pW7v3MVA5+u39GGP5lc1TAPlTefC/VI6C2FTHMIwPUZWhhUxk0L+3AFlffVj7/aGl5DuN008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yDApkY8D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wMDUzWPY2FXi8oQKbIXbNY1WdXq1Yu34joP84Ju99HM=; b=yDApkY8DoyGRO2LI2uMCseBbMd
	ZxIu/gRNIzhW2aiCEUL9HLLgWUh0vKkQc7KOuhp3Sfb4M4WoLC1/l0VOHKxjzP/QKOmjmtVpc0Y/x
	Gkt+z5Zt5zQpfLLovS5e5wwGlCx+r2U+ow8NI2KOKz0WRDk5YEoRQ3i5zcV+bEzGF1ZrJueM85m4m
	xDqqbL0OhOXvzofjybbyWbRoQ/gXB9WNvgUv2mb7XFnLYIFPcu3byetSz4tk5DH+xvA7wGhvgPEPq
	GALc7DqOAJ8kkK5ib4iDYDkZxyN0pqmLQG81BmdLBjqHF6iOYFxgCmEGIGFYeqvRGc6xM2qeADOLs
	mz5PiXGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFgz-0000000CIfu-2MUG;
	Thu, 04 Jul 2024 06:11:41 +0000
Date: Wed, 3 Jul 2024 23:11:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	bhelgaas@google.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCIe coherency in spec (was: [RFC PATCH 2/2] drm/ttm: downgrade
 cached to write_combined when snooping not available)
Message-ID: <ZoY9HZwon3_yiq6F@infradead.org>
References: <20240703210831.GA63958@bhelgaas>
 <99ff395019901c5c1a7b298481c8261b30fdbd01.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ff395019901c5c1a7b298481c8261b30fdbd01.camel@icenowy.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 04, 2024 at 10:00:52AM +0800, Icenowy Zheng wrote:
> So I here want to ask a question as an individual hacker: what's the
> policy of linux-pci towards these non-coherent PCIe implementations?
> 
> If the sentences of Christian is right, these implementations are just
> out-of-spec, should them get purged out of the kernel, or at least
> raising a warning that some HW won't work because of inconformant
> implementation?

Nothing in the PCIe specifications that mandates a programming model.
Non-coherent DMA is extremely common in lower end devices, and despite
all the issues that it causes well supported in Linux.

What are you trying to solve?


