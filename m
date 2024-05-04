Return-Path: <linux-pci+bounces-7076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9F8BBCDF
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396D11C20D98
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEAC40877;
	Sat,  4 May 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVgSE3m2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZgkTPHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26644225D0;
	Sat,  4 May 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714837702; cv=none; b=ZBeZfK2CMhWhaAbJZ4EnZ+5+GyQkXqwtb8KkgKKG8pC7tSSic6+uYbupKZPDn0PRef5iFTnTRTi5jjc7iAa+FNWhIEkyucUyC35Yle00RXrTjL7bormLaJpiWbWAbzf0EnmoUC+IoX6WF09/K++k6SI5ZrIrQo72Hcn/Kx3Cyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714837702; c=relaxed/simple;
	bh=N7dQrrzlTJ++kwcKr2K8iINkTGGrKX9dIW9u5tuH/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTZjDRH6f62uYPtUnQtNawcQUN78koz/yh7YDC27zrSxPUBgApOsRKIElm2Zz1KSEeXHpDG7I4icMdviQxVPnEnYP6qZoAw2PIYVWWR1ZVK2SCAz9hfPs/dYZAOV8MSxtw0dRn0MWiIoGhwy2Yr6E6EBw3bBr0kaxtFIwUAM3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVgSE3m2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZgkTPHB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 4 May 2024 17:48:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714837691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4KBN0TKU29q7oTncF5x//I8JiIVxS6XRK8cMe/alR+k=;
	b=lVgSE3m2E6R7yHoq1UG9d3tj1bAq+4qNMT895p8iaxqTJ9RZtgcGclq+Mxr92UaWEBQp+V
	2UL9tep2y8E/5XRFvqRdMsuKMoL1ZXGdb2ZBbPwcv57EYVVjzD+MGV16UiQwkyCzjAuuGK
	KLtTbOBOmmFVZnSwfk+CehcHwdaaHyAjjoERAWRfI2gdC/CMpf3lpMBvPuAatSLRkiC5Sy
	gOleu83O0IbUSjUe69NL3Em8xwtH7UHrPYG6FctKNNfApt/jTPHIPEWkTweuXYlQaVZKo2
	F8cSuBopDfqQbqLaLxqj8faauvfeM0f0IBsbL9n2D+YvQnb8VUDRvP86IOzUzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714837691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4KBN0TKU29q7oTncF5x//I8JiIVxS6XRK8cMe/alR+k=;
	b=nZgkTPHBLQnlTx337VnCjY7JLKgwg+lemVQCUcfb06rqGzM0eLnLf07fhajq5AOEzCTvOf
	eccKgI4ZmY9/rpDQ==
From: Nam Cao <namcao@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <20240504154806.zpZEo__F@linutronix.de>
References: <cover.1714762038.git.namcao@linutronix.de>
 <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
 <ZjX3t1NerOlGBhzw@wunner.de>
 <20240504093529.p8pbGxuK@linutronix.de>
 <ZjYFOrGlluGW_GzV@wunner.de>
 <20240504105630.DPSzrgHe@linutronix.de>
 <ZjZOCj4Cxizsj3iY@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjZOCj4Cxizsj3iY@wunner.de>

On Sat, May 04, 2024 at 05:02:34PM +0200, Lukas Wunner wrote:
> On Sat, May 04, 2024 at 12:56:30PM +0200, Nam Cao wrote:
> > On Sat, May 04, 2024 at 11:51:54AM +0200, Lukas Wunner wrote:
> > > Could you reproduce with pciehp instead of shpchp please?
> > 
> > Same thing for pciehp below. I think the problem is because without 
> > pci_stop_and_remove_bus_device(), no one cleans up the device added in
> > pci_scan_slot(). When another device get hot-added, pci_get_slot() wrongly
> > thinks another device is already there, so the hot-plug fails.
> 
> pciehp powers down the slot because you're returning a negative errno
> from pciehp_configure_device().  Please return 0 instead if
> pci_hp_add_bridge() fails.

Thanks for the suggestion. This is applicable to shpchp as well.

Best regards,
Nam

