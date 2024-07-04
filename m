Return-Path: <linux-pci+bounces-9778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4816926FD5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB19283452
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98791A08C0;
	Thu,  4 Jul 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pCvebEww"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6E1A08C4;
	Thu,  4 Jul 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075449; cv=none; b=L8Q4wdvGFZDwstwQkwhFvzauN3p9GAwcRUqpSoUgybXEDMcJftCrCe5j21WCrFedomPepQKXt4IXQN3q9grIwS4EIOGFPMhfaNX1GC8/ypjkfw121mUQ10ZF6mvooXbvwdxZz2PmvMqUNkKp7Yhs+kh4oCWREvWal3m+g0mI6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075449; c=relaxed/simple;
	bh=C5Gt6GpTd+UsQ/97Qqy5yrcQBhYdMqxjLWLGNWygVh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeyaH9yEkunZSXW5RFNbqmSlo4o5UzLoS/Q3SjPsGowfdQvdOwSVNyckGcHoZXX3bpjS17LkLHNVGLCMRZ1ogGtThJCj1Yo8qVAeSkrhuWcP69IlKjIe6tZP8tS5/K/Y37TLBdqPyYsPXLfecUoMkyWi32XXcya6D4Pc6MyubZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pCvebEww; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=awbbpRBWE7W7u7wrmPj3r9l6ibvQU6/aKWQd0BnOj3E=; b=pCvebEwwcRQB0joWcPaJO8Kjdn
	BTvYHfsCLSn9ahVnzayRvc05y0EaNrYH6iQOaEHQk4cxPsJi28HOOB+N1T7ITjjqv8mXhhhbP2kf4
	AswB51esYrF1Y70lh+P81+ld8wwZLYOZXl4liuWnNSbQj01TkejS+RwqmbseJVWduw62XQSBe+QgI
	RvAc49bsqeST3MO8yWEAI0icb9sfUjp4esAoAro11pHHTuwLzXXV12a4wAvVsR98owwwuAGaZNKRv
	ucHAbsMSGIIsB5n4DxDTJXSmu5rTfy9z2ftRUJyncUiMSlpdqBDkUvCUldhjYEzI4sO7ALuSL73ld
	8IN3t2Hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGCK-0000000CN3T-3LQT;
	Thu, 04 Jul 2024 06:44:04 +0000
Date: Wed, 3 Jul 2024 23:44:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <ZoZEtLe66MZRBDLc@infradead.org>
References: <20240703210831.GA63958@bhelgaas>
 <99ff395019901c5c1a7b298481c8261b30fdbd01.camel@icenowy.me>
 <ZoY9HZwon3_yiq6F@infradead.org>
 <51603213d16493879c85417c0c8cc3f2df0cf7cf.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51603213d16493879c85417c0c8cc3f2df0cf7cf.camel@icenowy.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 04, 2024 at 02:40:16PM +0800, Icenowy Zheng wrote:
> > Nothing in the PCIe specifications that mandates a programming model.
> > Non-coherent DMA is extremely common in lower end devices, and
> > despite
> > all the issues that it causes well supported in Linux.
> > 
> > What are you trying to solve?
> 
> Currently the DRM TTM subsystem (and GPU drivers using it) will assume
> coherency and fail on these non-coherent systems with cryptic error
> messages (like `[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring gfx
> test failed (-110)`) without mentioning coherency issues at all.
> 
> My original patchset tries to solve this problem by make the TTM
> subsystem sensible of coherency status (and prevent CPU-side cached
> mapping when non-coherent), but got argued by TTM maintainer and the
> maintainer says TTM's ignorance on non-coherent systems is intentional.

From the dma mapping subsystem POV all drivers not supporting DMA
incoherent devices are buggy.  But if the drm maintaintainers disagree
(and they have in the past) there is not much I can do, especially
given the DRM is rather special in abuses of all kinds of APIs anyway.


