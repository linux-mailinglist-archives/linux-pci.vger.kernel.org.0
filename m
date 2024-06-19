Return-Path: <linux-pci+bounces-8978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99590EB5A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96C21F23132
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59520147C60;
	Wed, 19 Jun 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrfgAX2j"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B31474A9
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800962; cv=none; b=GIRywExw8Q7n+bvZagfEMIDrwEjGZed641+aBODdtWzUgBcS1R0Ybp9596G6F5yOwDr+32R16UvITcEZpeg5CUHe3XE7CpbhQEC6Ik0+0ytWkl1+INA3TKaw37aiGoIWNEE/iFuWOo2cq6SgXgSDYRxCOoHNX5HLtsyW1VG4l74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800962; c=relaxed/simple;
	bh=VIG0BR/NDPmGtg8voRIq3GjmFPyIl3KX6RyNLUEhLvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzqoTlPyQQ6Y8gRy7RS3GhBGN+bPeVnXC88HHXLMo52Lck935ZnGXB7gpBJsdPtY6OFXmJMH0Q9AAZsQxY6cgx/z5bJogvMfEYNNE9TqtQEO+rba8niPcKR1VpxuwlJsj8sr7Fx2cIe4uJwHjDtHw1ujevjjI9xrH+shQsXm9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrfgAX2j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718800959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEIb/uS/KDuzfIvJsLzv4TZYlQ9RyQMIGFEXdxP6eh8=;
	b=NrfgAX2jATHScI/7J2sleQ4UQaQJJWtPxpYpmPzS8Bq2llqD+SrLKxMrzk7B8rnj3OIn9q
	e+GUTt3O3b6u5Pa1Br0ro5tV+Giga5QYbCBLeD6bb/dSAWvd1vjGieqq4hN7Y1bEGtFN/5
	AJK9AxZpX4QXBdl+KMLKMy+TIq8Ekio=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-EnOkcdPaP1yZviQTMoSYFw-1; Wed, 19 Jun 2024 08:42:38 -0400
X-MC-Unique: EnOkcdPaP1yZviQTMoSYFw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42196394b72so42057395e9.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 05:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718800957; x=1719405757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEIb/uS/KDuzfIvJsLzv4TZYlQ9RyQMIGFEXdxP6eh8=;
        b=qywDmMJ+HUGBTbg8DfBotv6x9W9adJbyCiA9CQbS83ZxmEE8JPftu91x5wBkQ0t/oi
         KXEmMvhiqxkYYwzp3V6PSxc8Fi2kGsyZDTdKN5mvqn1n8zc5qOcdIkZyIRUR+jLXILJh
         cIhze6dsm0nLo1JZb6EDTdCUKpcup9L7lnFjADxLU7YG0yFEHsN6INMRtuP8UdxQiR1l
         EKWgJre4Xf7nmAd8wpOj1lKcdtKM2O26pWhGW6X3Iyo1DGevgStFVpbZZ8HMXYo56b5k
         FUJnHgHb+qodD3eCBmYvS1CEB2ZNuMx4c/sz0vZpmLQlTvqfAVUS69LTeneH+3Y1lLJq
         akaw==
X-Forwarded-Encrypted: i=1; AJvYcCVudNXyd9QOpMJv0i1CMwx3HhdT7BsukPfYODe0roG7t5g5MDLhmGA1xO9Z1vlbg2KO/Hct84WK9loABHgPWryWIgQis0MbjSjR
X-Gm-Message-State: AOJu0Yx+R6HX0C/vQi848G2AVype5I9B6FmZWARF8dDBLdEWNQL66yLk
	R4sBSF+fho1h+GgEqxSN+Z/2xcqbPuewWmwSuGF5I/qeXrIBp7hASQz3zM56faaezg8Z968n2kv
	icfK3dbQtcTMO2/4I5sq8EqUTV1fJRbqnJKU0amQGARovl3crTYadoBJjNg==
X-Received: by 2002:a5d:698f:0:b0:35f:1d7a:c41c with SMTP id ffacd0b85a97d-36319a85dfemr1873758f8f.60.1718800957339;
        Wed, 19 Jun 2024 05:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT44IZwYnLeIXr1pEyTrxlYDiUj0k+ywN+trqFdH7nS5AjwVcwBiOiMlmVcMy2meveSTaW4Q==
X-Received: by 2002:a5d:698f:0:b0:35f:1d7a:c41c with SMTP id ffacd0b85a97d-36319a85dfemr1873734f8f.60.1718800956975;
        Wed, 19 Jun 2024 05:42:36 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3620c6c4a60sm4321665f8f.91.2024.06.19.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:42:36 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:42:34 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 00/10] Device / Driver and PCI Rust abstractions
Message-ID: <ZnLSOlcQ6mI2hC4c@pollux>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240619120407.o7qh6jlld76j5luu@vireshk-i7>
 <2024061929-onstage-mongrel-0c92@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061929-onstage-mongrel-0c92@gregkh>

On Wed, Jun 19, 2024 at 02:17:58PM +0200, Greg KH wrote:
> On Wed, Jun 19, 2024 at 05:34:07PM +0530, Viresh Kumar wrote:
> > On 19-06-24, 01:39, Danilo Krummrich wrote:
> > > - move base device ID abstractions to a separate source file (Greg)
> > > - remove `DeviceRemoval` trait in favor of using a `Devres` callback to
> > >   unregister drivers
> > > - remove `device::Data`, we don't need this abstraction anymore now that we
> > >   `Devres` to revoke resources and registrations
> > 
> > Hi Danilo,
> > 
> > I am working on writing bindings for CPUFreq drivers [1] and was
> > looking to rebase over staging/rust-device, and I am not sure how to
> > proceed after device::Data is dropped now.
> 
> As it should be dropped :)
> 
> A struct device does not have a "data" pointer, it has specific other
> pointers to hold data in, but they better be accessed by their proper
> name if you want rust code to be reviewable by anyone.
> 
> Also, you shouldn't be accessing that field directly anyway, that's what
> the existing dev_set_drvdata/dev_get_drvdata() calls are for.  Just use
> them please.

Sorry that this was confusing. `device::Data` was a generic type for drivers to
store their private data in. It was meant to be handled by subsystems to store
it in their particular driver structure. Is most cases of course this eventually
ends up in a call to dev_set_drvdata() (e.g. through pci_set_drvdata()).

The reason we had this in the first place was that `device::Data` was also used
to store resources and registrations. With my rework to `Devres` this isn't the
case anymore, and hence `device::Data` does not add any value anymore and was
removed.

> 
> thanks,
> 
> greg k-h
> 


