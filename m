Return-Path: <linux-pci+bounces-17212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8976D9D615D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 16:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE73281F63
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AE6A332;
	Fri, 22 Nov 2024 15:30:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25613AC1;
	Fri, 22 Nov 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289449; cv=none; b=G7QVSuSVHaczrpaHsgGKZzmtGMalqSUWot7P9Wy50aRM2r6g3L7mLDnYoN5c3L+Q9IGbSBP8jN/J88TQZP0cBZK/RjH32JNMFgUBE/3pdjczZ9tQGVoOMQQUcyIpVOHyrg336D7VZ3Akc1StSxvEf4Z4VN7BRYD6p1RHoLs1dFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289449; c=relaxed/simple;
	bh=sSPHFaEhpqcfSwvNTbLH7yXzLTvWt+R8ixkPNq3qPDg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTbsy5a0/QpsBSV93NpSeGRc/hdcFFLCyEsIpklxwOwEYT92C5YCTxt2B1KSB5gTwEliLUVF8aCUIrY7PzA+EgB+5ZF1Ek1C4q/cWUJ9APX3W42dqS5T1Dam6HcdDiS2vu+Y4TrbQOpNG8kNfye1U/j4spOVCWb3JeWTHLqcNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvzWl387hz6K8n6;
	Fri, 22 Nov 2024 23:28:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 76476140A70;
	Fri, 22 Nov 2024 23:30:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 16:30:41 +0100
Date: Fri, 22 Nov 2024 15:30:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Alistair Francis <alistair@alistair23.me>, <lukas@wunner.de>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<bjorn3_gh@protonmail.com>, <ojeda@kernel.org>, <tmgross@umich.edu>,
	<boqun.feng@gmail.com>, <benno.lossin@proton.me>, <a.hindborg@kernel.org>,
	<wilfred.mallawa@wdc.com>, <alistair23@gmail.com>, <alex.gaynor@gmail.com>,
	<gary@garyguo.net>, <aliceryhl@google.com>
Subject: Re: [RFC 2/6] drivers: pci: Change CONFIG_SPDM to a dependency
Message-ID: <20241122153040.00006791@huawei.com>
In-Reply-To: <20241115175831.GA2046032@bhelgaas>
References: <20241115054616.1226735-3-alistair@alistair23.me>
	<20241115175831.GA2046032@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 68f46e4a72a6..4db9bc8e29f8 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -739,6 +739,21 @@ config LWQ_TEST
> >  	help
> >            Run boot-time test of light-weight queuing.
> >  
> > +config SPDM
> > +	bool "SPDM"  
> 
> If this appears in a menuconfig or similar menu, I think expanding
> "SPDM" would be helpful to users.

Not sure it will!  Security Protocol and Data Model
which to me is completely useless for hinting what it is ;)

Definitely keep (SPDM) on end of expanded name as I suspect most
people can't remember the terms (I had to look it up ;)

Jonathan



