Return-Path: <linux-pci+bounces-32117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6FB05191
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06B04A6B7A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 06:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC742D3A88;
	Tue, 15 Jul 2025 06:13:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E83B652
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559997; cv=none; b=MKWy/lpWhnOmMrhtbq+uto5RWKYz0UD6hQ2RoSj4PEJWIiTvOFrv+PcMgvznW7tfWeV3LoPYrAv7HYaqc2OjdAdR9+x//E9AEKfb31XHVeUaNq7+6dp7OUaw8wEyxDFWzV8feAUQeTvqrcEd6YaHj+LUUbVxxKXDnqvoYcaGZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559997; c=relaxed/simple;
	bh=ueIbDSrNwyKsHYxEbNhUtG6syaZbqLVpnfjceYDqcKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1x3qCQy2FCuKMN416GfyZ/h51aVVcaG+CgOcez3Q2+CrjZfmaQspCdqz1bO+ErliReliFTmjo0lUz6HZOcLBLcmkBEyZwTjt53kt5Xt6xqXMmdTAo3kX+UOGmiU1s2Gp4QktDPyLuHn6IHKzAFcNBVRk1hfMCWbmkLjbs05gO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD7A2227AAD; Tue, 15 Jul 2025 08:13:09 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:13:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-pci@vger.kernel.org, Yaron Avizrat <yaron.avizrat@intel.com>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>
Subject: Re: [PATCH] PCI: Allow drivers to opt in to async probing
Message-ID: <20250715061309.GB18672@lst.de>
References: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de> <20250714134502.GB11300@lst.de> <aHUSE1Q1V-A-OiUv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUSE1Q1V-A-OiUv@wunner.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 04:20:03PM +0200, Lukas Wunner wrote:
> I guess what happens in your case is, *after* initial probing has
> concluded and user space is up and running, a driver is unbound
> from the device and another driver is subsequently re-bound.
> E.g. "nvme" is unbound and "virtio-pci" is bound instead.

How?  This is a non-modular simply kernel running on kvm.  There
should be no re-binding, and binding nvme devices to virtio of course
also doesn't make sense.


