Return-Path: <linux-pci+bounces-18747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F29F71D9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 02:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79775188B490
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F7433CE;
	Thu, 19 Dec 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bAjdJGWY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD3E22075;
	Thu, 19 Dec 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572425; cv=none; b=XNslSm/OPi7UloaGqAIElm4XOZUBOckrnIQ2Fehegc+tNwNKQDqDll0TZnoiAHCgkUu8/JDCN+3gOI+3FxfhR8G63fOWWB8TbtvoVhjPbuiD2MKGYhwNbvWUTtcNxy98pr0ZuLKaXgmDNdSFFbYw5JQoUWt0TkvEUoieCL4hWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572425; c=relaxed/simple;
	bh=D+hjjt3ihwde2L/XaDn561fQCTgdt3mPQJ6kAtBrx0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr5GZrflbBltu9koHYlWDC7jEs/UsYI9mBeDBVZGWhJzI/ERVunPSC7+0eMsnlIAFm5/fx0z2CzozKcqIFcOs1Xej78m87MR6pGaOyocMa0bytICBRHgnt0NZa71RSkPVQZQt7jr95e6wPomC1cfPsFdUIj5er1qqN6lUZNYJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bAjdJGWY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=PmrCcyA1Ch8l3GxS0c3p3ifF/9ECkLSeyXYIv7wdGcI=;
	b=bAjdJGWYgJP4yZ6ZhMJisRa864Zl1s4Tign/mXDz/ztREnSDT+JwDd0Te7oNav
	zUE4puxdVaBLfgflhuoiRnpRGKL01vVKPK7+n1AsB+UoQ7WuQTNWcx2CmNV5cvAF
	M8ilLaihgyan+mLsyUjZbzQE2/dd109UQr/w9hbcpgITY=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAHAlNLeWNngMyQAA--.8650S4;
	Thu, 19 Dec 2024 09:39:36 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	make_ruc2021@163.com,
	rafael.j.wysocki@intel.com,
	stable@vger.kernel.org,
	yinghai@kernel.org
Subject: Re: [PATCH] PCI: fix reference leak in pci_alloc_child_bus()
Date: Thu, 19 Dec 2024 09:39:23 +0800
Message-Id: <20241219013923.2996224-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <479bf618-187e-14f0-5319-c41f8b80faeb@linux.intel.com>
References: <479bf618-187e-14f0-5319-c41f8b80faeb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHAlNLeWNngMyQAA--.8650S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4xKw4Uuw4rAw1rtFyDGFg_yoW8Aryxpa
	93Ga1YkFW8Xr17uw4qvF1jv3s0kanrtry09r1rJ3W7CFy3CryxKFW3tFW5G3WDu397C3Wj
	v3Z8Xw1j9an8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUI1vsUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRm6C2djckyg+wAAsc

Ilpo Järvinen<ilpo.jarvinen@linux.intel.com> wrote:
> Ma Ke <make_ruc2021@163.com> writes:
> > When device_register(&child->dev) failed, calling put_device() to
> > explicitly release child->dev. Otherwise, it could cause double free
> > problem.
> > 
> > Found by code review.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  drivers/pci/probe.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 2e81ab0f5a25..d3146c588d7f 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
> >  add_dev:
> >  	pci_set_bus_msi_domain(child);
> >  	ret = device_register(&child->dev);
> > -	WARN_ON(ret < 0);
> > +	if (ret) {
> > +		WARN_ON(ret < 0);
> 
> The usual way is:
> 
> 	if (WARN_ON(ret < 0))
> 
> > +		put_device(&child->dev);
> > +	}
> >  
> >  	pcibios_add_bus(child);
> 
> But more serious problem here is that should this code even proceed as if 
> nothing happened when an error occurs? pci_register_host_bridge() does 
> proper rollback when device_register() fails but this function doesn't.
> 
> Into the same vein, is using WARN_ON() even correct here? Why should this 
> print a stacktrace if device_register() fails instead of simply printing 
> and error?
Thank you for your guidance and suggestions. I have the same confusion
about the simple handling(WARN_ON()) of errors if device_add() fails. 
I am looking forward to receiving guidance and insights from other 
experts.

--
Regards,

Ma Ke


