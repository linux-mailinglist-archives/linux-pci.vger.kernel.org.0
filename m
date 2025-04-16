Return-Path: <linux-pci+bounces-26005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DF8A90756
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80C2440AE1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029EB154430;
	Wed, 16 Apr 2025 15:06:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8531B4223;
	Wed, 16 Apr 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815995; cv=none; b=Gwvuy8xsGgTHGTfor5bKrUsrVRFT3AaL1gnEOFUTRundW6i8/vWbfO5U9Pwd18OB39qtgXzbeldPxyoUZRpfNdAZKTD1ZqqC2LY7UMa2Nav5S77CuhFVI0D2Y/Rb18m4mT5wLk9/QcVZyBMqr+G/Np/imOcRPQtGjkjTbyGXyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815995; c=relaxed/simple;
	bh=Y0cgPHUB3rm/lSE3lzKIbQ4kyOlm5FYm+xgtEGiJt8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhLDIR+u+gBuKPXlqu7MsBCIhMERNLIp/n7ZSTeYLD0f70uflNb2g/txYFGHXuOnSWeBgc/X3EeNQcI425HfzJW9oSIrPz3E2uH5duAoa/+fiVTcqZuojTiEb3sGt48wqjJVhOPzajMz5xBYMRwPl5gagiVAg71FxIfS3r8WlNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8E1312C06E34;
	Wed, 16 Apr 2025 17:06:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7D9F6B1FDF; Wed, 16 Apr 2025 17:06:23 +0200 (CEST)
Date: Wed, 16 Apr 2025 17:06:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
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
Message-ID: <Z__Hb9-GBTkBRRyf@wunner.de>
References: <cover.1744298239.git.lukas@wunner.de>
 <Z_7G3rq08FCFU0gy@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_7G3rq08FCFU0gy@kbusch-mbp.dhcp.thefacebook.com>

On Tue, Apr 15, 2025 at 02:51:42PM -0600, Keith Busch wrote:
> On Thu, Apr 10, 2025 at 05:27:10PM +0200, Lukas Wunner wrote:
> > First of all, PCIe hotplug is deliberately ignoring link events occurring
> > as a side effect of Downstream Port Containment.  But it's not yet ignoring
> > Presence Detect Changed events.  These can happen if a hotplug bridge uses
> > in-band presence detect.  Reported by Keith Busch, patch [1/2] seeks to
> > fix it.
> 
> There are switches that let you
> toggle downstream connections to change what's attached and it causes a
> DPC event, swapping out the downstream device at the same time. So this
> change has the pci driver resume with the wrong device if you happen to
> be in such a situation. I don't have such switches anymore

What's the error type causing the DPC event?  Surprise Down?

Since commit 2ae8fbbe1cd4 ("PCI/DPC: Ignore Surprise Down error on hot
removal"), which went into v6.9, the DPC driver handles Surprise Down
silently and it tells the hotplug driver *not* to ignore the hotplug
event.  It does that by unconditionally clearing the PCI_DPC_RECOVERED
flag at the end of dpc_handle_surprise_removal().

Hence in the situation you're describing, the hotplug driver should
always bring down the slot and bring it back up with the new device.

Thanks,

Lukas

