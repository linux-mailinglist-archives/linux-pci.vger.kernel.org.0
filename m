Return-Path: <linux-pci+bounces-11427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616D94A633
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064302820D7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7111BE87D;
	Wed,  7 Aug 2024 10:47:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1461DF667;
	Wed,  7 Aug 2024 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027676; cv=none; b=EXCzHFkTOJhTNjKvxHCjVJmpM6utiQIZSg3yeAFaa423qGERSW/1rgyWY6ohlWxK1oNjN1yy7RgAqmfYGtKo6jikPZuWtsoOwNKzUkIo1yEO4MpYC3WEgzRVfTYK/AHoi8gT0uLBeA8m53Y9zluPbDSVkH/MyAitEpbPUImohEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027676; c=relaxed/simple;
	bh=aKT1TNGY7N1VZKhJM3yrUJlvHm+MMYiI29thE1FOuK0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A24BLZP32gUVBa9QXYofk/D1Vzmo/Bf6UyxPYTnretYJHtlzEZJWnPOe7svnahUOjp9/LPdUH6Tg9YQ0Vmbiq4VsnMgx5G3/0tyWjQB5JikLtGEubtxAPmoaHzILojAy0BuKti33DIyCbpG+q1Iuh2SfPysPlQMaxMeX5L9Fajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wf6J73CH2z6K5kM;
	Wed,  7 Aug 2024 18:44:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 115FC1400D9;
	Wed,  7 Aug 2024 18:47:49 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 Aug
 2024 11:47:48 +0100
Date: Wed, 7 Aug 2024 11:47:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: David Hunter <david.hunter.linux@gmail.com>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<julia.lawall@inria.fr>, <skhan@linuxfoundation.org>,
	<javier.carrasco.cruz@gmail.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of.c: replace of_node_put with __free improves cleanup
Message-ID: <20240807114747.00002fc2@Huawei.com>
In-Reply-To: <20240801235526.GA129068@bhelgaas>
References: <20240719223805.102929-1-david.hunter.linux@gmail.com>
	<20240801235526.GA129068@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Aug 2024 18:55:26 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Rob, Jonathan]
> 
> On Fri, Jul 19, 2024 at 06:38:05PM -0400, David Hunter wrote:
> > The use of the __free function allows the cleanup to be based on scope
> > instead of on another function called later. This makes the cleanup
> > automatic and less susceptible to errors later.
> > 
> > This code was compiled without errors or warnings.  
> 
> I *think* this looks OK, but I'm not comfy with all this scope magic
> yet, so would like Jonathan and/or Rob to take a peek too.

I'm suspicious of usecases where there isn't a constructor / destructor pair.

This is more of a 'steal' the pointer and destroy it pattern.

Also, bug in this case.... see below.

> 
> And is there some way to include a hint here about how to find the
> implicit of_node_put()?  I think it's this from 9448e55d032d ("of: Add
> cleanup.h based auto release via __free(device_node) markings"):
> 
>   +DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))

Yes, it's that one.  Makes sense to add a reference to that in the
patch description for these.
> 
> but it did take some looking to find it.
> 
> If it looks good, I'll tweak the commit log to use imperative mood:
> https://chris.beams.io/posts/git-commit/
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94
> 
> since this technically says what *could* happen but not what the patch
> *does*.
> 
> > Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> > ---
> >  drivers/pci/of.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index b908fe1ae951..8b150982f5cd 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -616,16 +616,14 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
> >  
> >  void of_pci_remove_node(struct pci_dev *pdev)
> >  {
> > -	struct device_node *np;
> > +	struct device_node *np __free(device_node) = pci_device_to_OF_node(pdev);
> >  
> > -	np = pci_device_to_OF_node(pdev);
> >  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))

Wil now put the node if that second check fails. Didn't do that before
and I'm guessing we shouldn't?  Technically it calls the cleanup
in the !np case but that is fine as we check for NULL pointer.

So I'd leave this particular one alone.

> >  		return;
> >  	pdev->dev.of_node = NULL;
> >  
> >  	of_changeset_revert(np->data);
> >  	of_changeset_destroy(np->data);
> > -	of_node_put(np);
> >  }
> >  
> >  void of_pci_make_dev_node(struct pci_dev *pdev)
> > -- 
> > 2.34.1
> >   


