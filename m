Return-Path: <linux-pci+bounces-19866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F5A11F53
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E35A7A2BFB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB2A231A49;
	Wed, 15 Jan 2025 10:26:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C01F9F41;
	Wed, 15 Jan 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936802; cv=none; b=hCACBALuePhnKUvAmck8G9vSmHLKryLCrZI9pAfngus7UPhVQnABxfME6T88/CE69hKyysvlHdJoeTrLhpOEJYsYgKxp0rGu5kbZUMo9Zu9quJsQSuN2NsisOovKiKIpdx0f1GPSZiaadM+NAGTqne+Hq7epZTrGyvQSkKhUIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936802; c=relaxed/simple;
	bh=OH42/fP7OUQN7pGxUSj67l+ZT4GC8a5m1Ndy2FdYJwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBvO49+cGIqrjIpXqbEeps4rtNEN4hzFZwO1vSUwhWc8mA9QMiCXvMenntiy3Koa5vHo/ZtgIDLKX5VVGPCjtLfd9wM9Vfay+lkPhpFDPxEA+zrPDdkgTSDS7ygSgsGD3m6ZvmJlXaiE0wnCG6fAHgrr35ktsNJAoBbn7MBnXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 768EB100DE9E0;
	Wed, 15 Jan 2025 11:18:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 50675577CC4; Wed, 15 Jan 2025 11:18:47 +0100 (CET)
Date: Wed, 15 Jan 2025 11:18:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiwei <jiwei.sun.bj@qq.com>, macro@orcam.me.uk, bhelgaas@google.com,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	guojinhui.liam@bytedance.com, helgaas@kernel.org,
	ahuang12@lenovo.com, sunjw10@lenovo.com
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
 hotplug testing
Message-ID: <Z4eLh24IkDrAm6cm@wunner.de>
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
 <3fe7b527-5030-c916-79fe-241bf37e4bab@linux.intel.com>
 <tencent_4514111F8A3EF9408C50D9379FE847610206@qq.com>
 <3d7c3904-a52e-9602-3ad2-29b5981729c7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d7c3904-a52e-9602-3ad2-29b5981729c7@linux.intel.com>

On Tue, Jan 14, 2025 at 08:25:04PM +0200, Ilpo Järvinen wrote:
> On Tue, 14 Jan 2025, Jiwei wrote:
> > [  539.362400] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
> > [  539.395720] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
> 
> DLLLA=0
> 
> But LBMS did not get reset.
> 
> So is this perhaps because hotplug cannot keep up with the rapid 
> remove/add going on, and thus will not always call the remove_board() 
> even if the device went away?
> 
> Lukas, do you know if there's a good way to resolve this within hotplug 
> side?

I believe the pciehp code is fine and suspect this is an issue
in the quirk.  We've been dealing with rapid add/remove in pciehp
for years without issues.

I don't understand the quirk sufficiently to make a guess
what's going wrong, but I'm wondering if there could be
a race accessing the lbms_count?

Maybe if lbms_count is replaced by a flag in pci_dev->priv_flags
as we've discussed, with proper memory barriers where necessary,
this problem will solve itself?

Thanks,

Lukas

