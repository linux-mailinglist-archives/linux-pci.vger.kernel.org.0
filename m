Return-Path: <linux-pci+bounces-32070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE44B0407E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE37D16228A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C4253951;
	Mon, 14 Jul 2025 13:45:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF515253B7A
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500713; cv=none; b=HdmzCRVIbb1HQrA4clVOpKGPIEFsSLcSJa3eRlwM+OcsfBPCTNSn9iPbw5BBlCxRRWI75HSF9B0YUsn2lNO4Vp/fE9O7fcvNMZ3v7XfHVG9v66+HM1RPup/2+KSbzmjYrjqNWqXvKiq/SWUlDE5Bx9LtYIlZwwJK6teP3spIbUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500713; c=relaxed/simple;
	bh=x3MxtLTuUG04D2OKRTT/413ln0BXnFEnrh827ajfO2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqCdfj3yKNbHjxwdNiBb1yHZ4Ke+vq9X9TWoWSc5DM59+964TK7QbmjpPudMQezztrRNIp8IcAzQbWlcgPP3voHc8/3e/StWk1PIlFdsx3Z7IDFFO9L1F/KJvWbkG0xBAZZhp3J3SNQ4Kmu3N8m1uL7qKpqWngBzYpHLPnAHQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A6A1227A88; Mon, 14 Jul 2025 15:45:03 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:45:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
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
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>
Subject: Re: [PATCH] PCI: Allow drivers to opt in to async probing
Message-ID: <20250714134502.GB11300@lst.de>
References: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 04, 2025 at 09:38:33AM +0200, Lukas Wunner wrote:
> The PCI core has historically not allowed drivers to opt in to async
> probing:  Even though drivers may set "PROBE_PREFER_ASYNCHRONOUS", initial
> probing always happens synchronously.  That's because the PCI core uses
> device_attach() instead of device_initial_probe().

Is it?  I see frequent reordering of Qemu NVMe with the current kernel,
and have to disable it for some of my test setups that require different
device characteristics.

