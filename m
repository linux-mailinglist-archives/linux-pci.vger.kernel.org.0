Return-Path: <linux-pci+bounces-26156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA0A92F41
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 03:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6E68A60AB
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 01:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105361B85C5;
	Fri, 18 Apr 2025 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlaLx2z0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB01A256B;
	Fri, 18 Apr 2025 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939608; cv=none; b=sqGD/kp76R+W6aOLLjaLRRJvtrP5p3LnCPw9q1sUdHKxF+ZJhBgTIPiUrwsjiW03vZr4MQuihAvq+hgXXpziW6w3rojEyeJRebZTHW2FaXkcqtZnsPRGfNNaOdDYvDFWmMW63C7Ozc+aTkS56xqA9H941NPPz0DvwhMDSX4dqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939608; c=relaxed/simple;
	bh=U+F8ldFqzQFXlP4zcLsLMmWyIa7D3/1WsjChZtt/k74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksUrqZ/lVUiIpE0hA8cLrvV+2SxrPlQMmYnkxLYS9n4rVU09GZ4VedRdud725pUQoKjztvwh5knaBgmQFaHDCOTtsGqLpXUrhT3Ebjhp6nubW3ekXW+z3WXYjEdAsoAbwczR/oF70Fe+JTdQ76MhAmeUrO0+1bpovoj4RedlVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlaLx2z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABFDC4CEE4;
	Fri, 18 Apr 2025 01:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744939607;
	bh=U+F8ldFqzQFXlP4zcLsLMmWyIa7D3/1WsjChZtt/k74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlaLx2z0k3VZNsGFsw3yraUscSurRVv5t5gAUWl+yGChD+u12vgFOAkK7JPh5hOx/
	 Db80/f6aVVrYD1Jqy7PwqDFTT5He0HcaYvmIqih6SDd/v85QcRD7bGHOZrJFoH2aHl
	 I1UhRIWtZUew2xCffT06tKKTLhlg/PY3IHLm04BtXDZrCB7P34VG7mBMP+LQLoW5At
	 JmTFLpy4UA0Ans52CexoTj85UIPjqp9Wt5emD8PdMjdNlmRILEm/Es58ytScOi7iKA
	 1HGD9fYG1sIV1d3Co5f5Rz6bOn2FpQEnNt+vQMog+AlqfpzzXyT1SMIJL9p5VACs56
	 B9Cy0y6Dg3gig==
Date: Thu, 17 Apr 2025 19:26:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] Ignore spurious PCIe hotplug events
Message-ID: <aAGqUzMF5rn1gAMl@kbusch-mbp.dhcp.thefacebook.com>
References: <cover.1744298239.git.lukas@wunner.de>
 <Z_7G3rq08FCFU0gy@kbusch-mbp.dhcp.thefacebook.com>
 <Z__Hb9-GBTkBRRyf@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__Hb9-GBTkBRRyf@wunner.de>

On Wed, Apr 16, 2025 at 05:06:23PM +0200, Lukas Wunner wrote:
> On Tue, Apr 15, 2025 at 02:51:42PM -0600, Keith Busch wrote:
> > On Thu, Apr 10, 2025 at 05:27:10PM +0200, Lukas Wunner wrote:
> > > First of all, PCIe hotplug is deliberately ignoring link events occurring
> > > as a side effect of Downstream Port Containment.  But it's not yet ignoring
> > > Presence Detect Changed events.  These can happen if a hotplug bridge uses
> > > in-band presence detect.  Reported by Keith Busch, patch [1/2] seeks to
> > > fix it.
> > 
> > There are switches that let you
> > toggle downstream connections to change what's attached and it causes a
> > DPC event, swapping out the downstream device at the same time. So this
> > change has the pci driver resume with the wrong device if you happen to
> > be in such a situation. I don't have such switches anymore
> 
> What's the error type causing the DPC event?  Surprise Down?
> 
> Since commit 2ae8fbbe1cd4 ("PCI/DPC: Ignore Surprise Down error on hot
> removal"), which went into v6.9, the DPC driver handles Surprise Down
> silently and it tells the hotplug driver *not* to ignore the hotplug
> event.  It does that by unconditionally clearing the PCI_DPC_RECOVERED
> flag at the end of dpc_handle_surprise_removal().
> 
> Hence in the situation you're describing, the hotplug driver should
> always bring down the slot and bring it back up with the new device.

I think you're right, thank you for the pointers.

