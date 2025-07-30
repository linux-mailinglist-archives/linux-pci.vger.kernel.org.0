Return-Path: <linux-pci+bounces-33168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BAFB15E22
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 12:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F46018A41A8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581D292B50;
	Wed, 30 Jul 2025 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ol/V9cZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780292877F9;
	Wed, 30 Jul 2025 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871295; cv=none; b=RxifRu4lvpFPvZ8u0Qo1kp/Y+CqGu8v/owG5Jt462bM+oaYptnJHA6GacLBDq6s3rLZ+GhGrQaaeg+Z5f7zclN5T6fK9suhMZC34T78RNB3F0SJeJB3rEGTkcfNb/H8g0jYGTSBPG33fPml2cWCfa39flhenJxyO1s5xwKFtqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871295; c=relaxed/simple;
	bh=olWu41/0mb3ct37I97ZjNn13dWE7jzQhfEoE2OIXTWE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kndC6AHMJOtl78hHh3xr3Kbzc8wMKOdevpi+VHuB7J/vRXPsC+n15eho+4bhEapvdXhopRSs8HipCu9swTWe542Nt2G0KnJxjdISBC4ybd28xgITXWiHIX132M5+7z+Dx0ykTgmS96I5s2OHt/XUVXTl1QoajgA0++C2M5pHFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ol/V9cZM; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sWEbs127MJ7Az6eAkAVwRNtYIfnEVwFcX1aCfu4/3Tg=;
	b=ol/V9cZMbgott3Dl5l/i+D+i/4yBIBK146eU6uqhrGHuUZUb2gbHuU6sc9nFPqnYdxCRJ0nDW
	bd/iUQVXv+h7mMlgp4oeTuESwaUTQ9e7UCv6ElhnRoUXCGTcEU/ZiWWfL0XKuKNh9w4uE92jdLu
	Twz2bYMRetdKnwfQf0jQDRU=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsT0F3cPYzN0rg;
	Wed, 30 Jul 2025 18:26:37 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsSx61qqJz6GD7P;
	Wed, 30 Jul 2025 18:23:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE6DE14038F;
	Wed, 30 Jul 2025 18:28:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 12:28:06 +0200
Date: Wed, 30 Jul 2025 11:28:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven
 Price <steven.price@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc
 Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform
 device driver
Message-ID: <20250730112804.00002629@huawei.com>
In-Reply-To: <20250729232243.GK26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-13-aneesh.kumar@kernel.org>
	<20250729182244.00002f4f@huawei.com>
	<20250729232243.GK26511@ziepe.ca>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Jul 2025 20:22:43 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Jul 29, 2025 at 06:22:44PM +0100, Jonathan Cameron wrote:
> > > +}  
> >   
> > > +static void cca_tsm_remove(void *tsm_core)
> > > +{
> > > +	tsm_unregister(tsm_core);
> > > +}
> > > +
> > > +static int cca_tsm_probe(struct platform_device *pdev)
> > > +{
> > > +	struct tsm_core_dev *tsm_core;
> > > +
> > > +	tsm_core = tsm_register(&pdev->dev, NULL, &cca_pci_ops);
> > > +	if (IS_ERR(tsm_core))
> > > +		return PTR_ERR(tsm_core);
> > > +
> > > +	return devm_add_action_or_reset(&pdev->dev, cca_tsm_remove, tsm_core);  
> > 
> > So this makes two with the one in Dan's test code. 
> > devm_tsm_register() seems to be a useful generic thing to add (implementation
> > being exactly what you have here.  
> 
> Pelase no, this is insane, you have a probed driver with a
> probe/remove function pairing already. Why on earth would you use devm
> just to call a remove function :(
> 
> Just put tsm_unregister() in the normal driver remove like it is
> supposed to be done and use the drvdata to pass the tsm_core_dev
> pointer. It is easy and normal, look at fwctl for a very simple
> example.
> 
> devm is useful to solve complex things, these trivial things should be
> done normally..

Sure, that would be fine for now.  If we end up with a large complex flow that
happens to have a tsm_register() in amongst various managed resources
we can revisit.  If they all end up looking like this then a manual call
in remove is fine.

> 
> Jason


