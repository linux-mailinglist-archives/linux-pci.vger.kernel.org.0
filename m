Return-Path: <linux-pci+bounces-17223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2019D641D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 19:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D925F1611B6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556B1DF961;
	Fri, 22 Nov 2024 18:22:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3F15CD60;
	Fri, 22 Nov 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299775; cv=none; b=AK1TV7MDPo2e6EMXpRXUYXM18FrPxm3VXQDQPlqOkQnFPTWnV3T6XOwnJhuvYNFi9vw++MfFhrRWe/kCsXTeU420nd5itlUmctEQy5JB4SnPxYbJaDmg7WcQS2ZXfYgj1eiKtSenhoc6zbXCkoCMvHg5OjL3EDJ22LqUgmJ3pSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299775; c=relaxed/simple;
	bh=KXwZiJFQRphelGCPCym0D1/HQX9H6TTWlpETErvkVLI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0gWsKWOJ+0Z5i4avIuDPBUDMor87ulpeBlgRorBOjJ6vh0nbyKiM6uycmeG7uhCnbcYnZD4kMvm6nR3LcHcouXZkbYUwE9yK96ZIfqDfQZyHviRUJ9aeRNsXf25YcaKaAjpGEQi2wqqT9o7Ql2S/kWl/I8dwYweVU/OHOaz6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xw3Nc04B8z67n0t;
	Sat, 23 Nov 2024 02:22:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CACAD140C72;
	Sat, 23 Nov 2024 02:22:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 19:22:48 +0100
Date: Fri, 22 Nov 2024 18:22:47 +0000
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
Message-ID: <20241122182247.00005ab0@huawei.com>
In-Reply-To: <20241122172354.GA2430869@bhelgaas>
References: <20241122153040.00006791@huawei.com>
	<20241122172354.GA2430869@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 22 Nov 2024 11:23:54 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Nov 22, 2024 at 03:30:40PM +0000, Jonathan Cameron wrote:
> >   
> > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > index 68f46e4a72a6..4db9bc8e29f8 100644
> > > > --- a/lib/Kconfig
> > > > +++ b/lib/Kconfig
> > > > @@ -739,6 +739,21 @@ config LWQ_TEST
> > > >  	help
> > > >            Run boot-time test of light-weight queuing.
> > > >  
> > > > +config SPDM
> > > > +	bool "SPDM"    
> > > 
> > > If this appears in a menuconfig or similar menu, I think expanding
> > > "SPDM" would be helpful to users.  
> > 
> > Not sure it will!  Security Protocol and Data Model
> > which to me is completely useless for hinting what it is ;)
> > 
> > Definitely keep (SPDM) on end of expanded name as I suspect most
> > people can't remember the terms (I had to look it up ;)  
> 
> Agree that the expansion doesn't add a whole lot, but I do think the
> unadorned "SPDM" config prompt is not quite enough since this is in
> the "Library routines" section and there's no useful context at all.
> 
> Maybe a hint that it's related to PCIe (although I'm not sure it's
> *only* PCIe?) or device authentication or even some kind of general
> "security" connection?

It's much broader than PCIe (I believe originated in USB before
being standardized?)

Maybe something like...

SPDM for security related message exchange (with devices)

Attempting to distill the text in the Introduction of the spec.

"The Security Protocol and Data Model (SPDM) Specification defines messages, data objects, and sequences for
performing message exchanges over a variety of transport and physical media. The description of message
exchanges includes authentication and provisioning of hardware identities, measurement for firmware identities,
session key exchange protocols to enable confidentiality with integrity-protected data communication, and other
related capabilities. The SPDM enables efficient access to low-level security capabilities and operations. Other
mechanisms, including non-DMTF-defined mechanisms, can use the SPDM"

So clear as mud ;)

J


> 
> I admit that you're in good company; "parman" and "objagg" have zero
> context and not even any help text at all.
> 
> Bjorn


