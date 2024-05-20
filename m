Return-Path: <linux-pci+bounces-7689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259E8CA2E1
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032011C214F9
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B21384BF;
	Mon, 20 May 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKi+QQHC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A71137771
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234612; cv=none; b=PTL13+645F2B9km6Z97BDgKyCJMDQx8piRqCfXa5JNXjKQvfeXQyu2KJA+m91gzqrrr0Z3E+PbibDY1EfdC4IxYXB0N73S0dRJIP6Vrsj5l4pxJuvDHuK22pFnNMpZi0d80BR5Te2/8GiBiDfpgCFVGVVsvgEGG3Xu7GHBXqBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234612; c=relaxed/simple;
	bh=gJtO96/QOXNax5m7dA7p+4hZofa+TNrvNiDNq8i6miY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbDe32TMbt2Jfl7Eot5F9U8l/gXPxrgZuZ5N4pN2ETg3Z0n9cAvGxejv6eaMfvi3DP/QcNOpuNvE17IxMQ8+YscjrV0pmr8qMOEnSp0jDoLrd/sxmpC0EmBoD1Fu2jb5Y0U4v8GOzbHkhPmuwgSX43lPrVVMxu5hbk0akYGSpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKi+QQHC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716234608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p1ApWCJ3+udEonFuD2vtbOZd8j1mco+XVOTUyxyL7A0=;
	b=fKi+QQHCw7wxLF8kKR2rV5BKn50ToPOuUVtcN+sqe9UA1vbbOdaFM8pb1XD3yahHhpkG6q
	OeCmGzD7r1lble1WBkpS+zsJZ/qTg+idbAC1IcRUc1BWWcoy5hmcS0N0eaCqt0LffYLpMS
	qgd6Gglftr0nS7FYXrCFqxJn8uEBA5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-6oVTIiDPNTmkn4q3uZnrYA-1; Mon, 20 May 2024 15:50:07 -0400
X-MC-Unique: 6oVTIiDPNTmkn4q3uZnrYA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34dc7b83209so7111590f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 12:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716234606; x=1716839406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1ApWCJ3+udEonFuD2vtbOZd8j1mco+XVOTUyxyL7A0=;
        b=hxpz87pB529XLDnLzmefvFnkv77fPVS7N0m/gKlyIw8Cz2pvpat/4k0C2NFoZkoTxM
         UQyxvEIac4ApGCseW91ackYj2HT4Ma2NI27RgqaOdqNB3JKyOGqRdZbMT8+s9xuyUzO7
         UkZ1VYw1SHfeW0ldIwLNVwq7slTxWqPGQBOcrt5kRX0RO0iaFtXu6D4mGfgbYVnLhqAn
         UUObP0w9LHfrZ3ANvVEPTOyYMWz++TXu4YV14tcYtmqB5SZ0V8PaG3sWWeDSpXk4P060
         Lb8mNeT7zpVrYcyTCOxtsHwxYXnGcWpOl9OiJXYj/pxcf/NkFE3TGnJf+yf50dscUZie
         Bcvg==
X-Forwarded-Encrypted: i=1; AJvYcCUyeK5rF5R7v7+neyM93sHATRsxZW6cH8ZAZNFG02V56jmSbVX0Efzv3GP5Ou69M+Ay9u69PL76WtmTz/RoVSm/nQa66jYSL9bw
X-Gm-Message-State: AOJu0Yy/Qlj/npLzVvLm8M0TBSXessgsOXbnCZuZ5QJg6YnJUhVfxV/c
	aCM8TXb+zXXHI0/T1f0UUSNKM8xRKmc95UNjYQplh9Hupfcvyb1gwCTvMClZLWV2C6wOwBw+b0f
	onFd9O9Dce8pdxMn8C/YvPpWnILjuvC7dKXyMqZkxUUrLavAZRGsfQIh5Nw==
X-Received: by 2002:a5d:4991:0:b0:354:ca33:2228 with SMTP id ffacd0b85a97d-354ca332303mr1801443f8f.33.1716234606230;
        Mon, 20 May 2024 12:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD2Iv/bESoQ0Kc6Ww/7RxmYUENXDU1Srws//gmTKJixcaSapdeDilp8Mui/bX6lMEu2TKMpg==
X-Received: by 2002:a5d:4991:0:b0:354:ca33:2228 with SMTP id ffacd0b85a97d-354ca332303mr1801423f8f.33.1716234605793;
        Mon, 20 May 2024 12:50:05 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:acb0:ae3f:f045:1823])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d7d8f15esm12651384f8f.83.2024.05.20.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:50:04 -0700 (PDT)
Date: Mon, 20 May 2024 21:50:01 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] [RFC] Device / Driver and PCI Rust abstractions
Message-ID: <ZkupaTM+xjCiBbb4@pollux.localdomain>
References: <20240520172554.182094-1-dakr@redhat.com>
 <2024052029-unbridle-wildcard-fbf8@gregkh>
 <2024052020-basket-amuser-222f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052020-basket-amuser-222f@gregkh>

On Mon, May 20, 2024 at 08:16:19PM +0200, Greg KH wrote:
> On Mon, May 20, 2024 at 08:14:57PM +0200, Greg KH wrote:
> > On Mon, May 20, 2024 at 07:25:37PM +0200, Danilo Krummrich wrote:
> > > This patch sereis implements basic generic device / driver Rust abstractions,
> > > as well as some basic PCI abstractions.
> > > 
> > > This patch series is sent in the context of [1], and the corresponding patch
> > > series [2], which contains some basic DRM Rust abstractions and a stub
> > > implementation of the Nova GPU driver.
> > > 
> > > Nova is intended to be developed upstream, starting out with just a stub driver
> > > to lift some initial required infrastructure upstream. A more detailed
> > > explanation can be found in [1].
> > > 
> > > Some patches, which implement the generic device / driver Rust abstractions have
> > > been sent a couple of weeks ago already [3]. For those patches the following
> > > changes have been made since then:
> > > 
> > > - remove RawDevice::name()
> > > - remove rust helper for dev_name() and dev_get_drvdata()
> > > - use AlwaysRefCounted for struct Device
> > > - drop trait RawDevice entirely in favor of AsRef and provide
> > >   Device::from_raw(), Device::as_raw() and Device::as_ref() instead
> > > - implement RevocableGuard
> > > - device::Data, remove resources and replace it with a Devres abstraction
> > > - implement Devres abstraction for resources
> 
> Ah, here's the difference from the last time, sorry, it wasn't obvious.
> 
> Still nothing about proper handling and use of 'remove' in the context
> of all of this, that's something you really really really need to get
> right if you want to attempt to have a driver in rust interact with the
> driver core properly.

We were right in the middle of discussing about the correct wording when I sent
those patches the first time. There were some replies from my side, e.g. [1] and
another reply from Wedson [2] about this, which you did not want to reply to any
more.

I'm not saying I insist on not changing those comments up, but first we have to
agree on how we want them to be rephrased, especially since from the
discussions so far I got the impression that we might talk a bit past each
other.

Hence, I'd propose to just continue the discussion, where we need to.

[1] https://lore.kernel.org/rust-for-linux/ZgNCo4Hvs-EjDNGT@pollux/
[2] https://lore.kernel.org/rust-for-linux/CANeycqrdBVJhAiGZdv2NSnz2SUCuDC=04D_JiTF6vfs8iLvjrA@mail.gmail.com/

> 
> thanks,
> 
> greg k-h
> 


