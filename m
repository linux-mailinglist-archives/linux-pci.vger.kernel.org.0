Return-Path: <linux-pci+bounces-23574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C98A5EB81
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 07:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6B61899759
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E31FAC4A;
	Thu, 13 Mar 2025 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtcP3ZBa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089778F4A;
	Thu, 13 Mar 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846094; cv=none; b=Xl7tD2Nbysqqvd84eLEHvLbgr+3FUlWS0oAm0wiCEm8A8SP2Ug6GXfcth9f+xe2O5XFHmyvcaR6UMxsCNXNrUgpZ8AYh4fiadInT0GJuHo1q3ho5xV56mq6E56R5wyc+8XR0+1XcRy34Eyox5guJDUID+9CzFTg9G69jNN2R8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846094; c=relaxed/simple;
	bh=YLbPbJ+IrZenkUs4USyUP8K9l3CAG5baVrXa9ygpqR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO9c0Y+7WLBme/vKmLdxvw5FbWeE6F7Ss5XArr5FEuHFBCu71DWO6veDFvCX1E4Svv2feOhoR6MnUGU2clofbPJtvOCAHyuGkI85+EXuMRM6IPhrS+7raIDDPCdIhj9f6OWb1qFsYqsLBbKzs33p01AHDpmb7dwTsRP+HBkRt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtcP3ZBa; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c560c55bc1so53280985a.1;
        Wed, 12 Mar 2025 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846091; x=1742450891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2kIXwdeUOcxOgYoJMAOP6qJyfyd2nZwqk4Yee5iRNk=;
        b=KtcP3ZBaBkxtQTW1GAkdUNoLRsaCvyA/ufIKBw17csBj1P6oS9gVKnJ85ZEHAnOKg5
         309Z3vLQb1qd0uBioT4rBle3BYM41vIEjXsz0HqO/shCjM+GvGg69qTU7UM0V4lVGAXl
         Na2YZVgCRMi0Nj6CgDq1dojCWjbb2KgjevYFPX7/x1WbgouCUbpYLciKG1ZVeTp6uxkz
         aOaYzd088VEOmswE+7gMoFylwvDlRsyALMNL2VrmbQQaZ0cJeO3uF7HjZEk7hYvKilta
         vDt+mw6bUmA9WhOJ/u8qxqcE0531g2OItwxEZ7uSBGl1HJe7m4+a4A7aao/b4GJBdJzd
         O9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846091; x=1742450891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2kIXwdeUOcxOgYoJMAOP6qJyfyd2nZwqk4Yee5iRNk=;
        b=xMLQl65Bl6DT9MzEgx0xKokV5Qn9DGy+2pZ3uNzVm7ek7AyMEGxniCdUlx5V8BER6n
         k+QZvGWwNz2XfDVV9dkBQHCk5GQvkGS5gM2B9JR1CdfQISelOJrkl2iMS001kwvIj7cS
         E7BDS7Afk82050cOe60GwWxvwZjelW2ApB2aKw3HWnD2Pht+9b82zQD/hWyl4Db6lVIZ
         9ZJ01Fu6ak1p/8urwYwxXf4wc3t3xZLqucKVO22iDNonAGTxuxPn2jdtOFLYmxlnqEJ8
         AUHZg+1HKya2jWWJ8bJfPNUYeBofFid5WjAZ4uEP1EW/fApdU7PlIJZqCN6F/meY0Qs6
         ekXw==
X-Forwarded-Encrypted: i=1; AJvYcCUiG2iJQKaQxSVJklo7xAuZbl/IOsBguFuq+Mb0fFXOGmUrjp6QjkgxCs5m9Vm6DXr2QUL0+YWQjnJprxk=@vger.kernel.org, AJvYcCVcpfhS5nAuN+rY6c6T3gn7Lz/d8BaOuxWXBb0lX8w8m+cl2ASjUN/DbFV/aNy+T6D0DY6/pfB7gQF6@vger.kernel.org, AJvYcCWSj0aAHLy7aWPHC+2lCvJAl2H+MaHLBvWwvgZ91rotApfGKebu5BDkqPhKfvCYKyEQ3u/1ArvxaXi8vqTCUvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxihMJjDlj+5cTv+Awm029w0XtD1EoKl1jLtN3gBuSh2bX6flwM
	Cf2u7FbD3daoKr6m9418E7d+Anb7qEwmjadah62x9FMicLjqfaHU
X-Gm-Gg: ASbGnctmiTARB+f03mzq/MVpjUm1KMkf/Fgf5JUM8bNGfJw9L6Ke1/nbxhiyRni7ku/
	AdIg/4EddSp82uWqqtoFWT1xD+j8YY9DTj+rYjXDaq7/RkSiTSwQn8zeOwtcSznpXGvO7dQI3E3
	JvEJzJqpRAffAnYr3wwvYxJY8VNo70rutS4ata6ZbcXafG+VbEaItkIRPJfT26RIZgjZJf410hz
	p0tA3y5seAwNN9nRoQTIQ/uYS433/0BQEtzX9n+MYA6BAGV3jSlEEv6/sKUBq2JV2e+MPw23F2h
	FkHbMnDY8WLaLd3WuzvfMpxAYkZDupTdmC/tGAmso0irxXPJOow2g4L/8qPkFXRQmbcETrgmzkS
	BpppzcQ5I1HBbUu0qbIUj4n2T7G3O36Tko+v5E2+KEhTUVA==
X-Google-Smtp-Source: AGHT+IEybozJr4WmT7d60ZySLDE5NJNqa/fMOrEiAi6hphZ3cPld0W7pJv8HVQEQwW00iSBchuOQ4w==
X-Received: by 2002:a05:620a:6891:b0:7c5:4b18:c4c3 with SMTP id af79cd13be357-7c55e886df9mr1819408885a.30.1741846091450;
        Wed, 12 Mar 2025 23:08:11 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89c7dsm56499485a.95.2025.03.12.23.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:08:10 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 59D0B1200043;
	Thu, 13 Mar 2025 02:08:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 13 Mar 2025 02:08:10 -0400
X-ME-Sender: <xms:SnbSZ737GBo4SPpg2hEtUGh6akqJMTxKCY9hAzwbDv9Ai73CiBFTsA>
    <xme:SnbSZ6EZAc89kcgNUFjip4lMnwJe_SbMHdwtIRJGylZXezBF3zm9gkdZKaOP3kvb-
    zSM8-x7YP7v1smuvg>
X-ME-Received: <xmr:SnbSZ77nSlZMZvK7blKxUiqYhOEMOjiLUo5vW5rdBsQQdPJ8zKQpzrfb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:SnbSZw3MJLb0T-U7sQyqZNeUGJlsaDnj46BisVqQccYv3Y4FnlTLjw>
    <xmx:SnbSZ-FTPjuJcP5pwZJUcFeKZLqJeaRliiJEaavD8Oae9EuGzynahw>
    <xmx:SnbSZx95OCv2_GPqJwGrAq43KzeZvQRjBArmTafwpkr4b9cLOO-_Aw>
    <xmx:SnbSZ7n9DiGosMLq2g4K877yI0RHhUbGpUo-ZTV3rVAIKIl_GQJQWQ>
    <xmx:SnbSZ6EKk-i33ugi8-Minwm8uAv72c7616nmCws5Wm5eKOsv0ayLk8FD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 02:08:09 -0400 (EDT)
Date: Wed, 12 Mar 2025 23:08:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Improve soundness of bus device abstractions
Message-ID: <Z9J2SAzb0JWHRebL@Mac.home>
References: <20250313021550.133041-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313021550.133041-1-dakr@kernel.org>

On Thu, Mar 13, 2025 at 03:13:30AM +0100, Danilo Krummrich wrote:
> Currently, when sharing references of bus devices (e.g. ARef<pci::Device>), we
> do not have a way to restrict which functions of a bus device can be called.
> 
> Consequently, it is possible to call all bus device functions concurrently from
> any context. This includes functions, which access fields of the (bus) device,
> which are not protected against concurrent access.
> 
> This is improved by applying an execution context to the bus device in form of a
> generic type.
> 
> For instance, the PCI device reference that is passed to probe() has the type
> pci::Device<Core>, which implements all functions that are only allowed to be
> called from bus callbacks.
> 
> The implementation for the default context (pci::Device) contains all functions
> that are safe to call from any context concurrently.
> 
> The context types can be extended as required, e.g. to limit availability  of
> certain (bus) device functions to probe().
> 

For the whole series:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> A branch containing the patches can be found in [1].
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
> 
> Danilo Krummrich (4):
>   rust: pci: use to_result() in enable_device_mem()
>   rust: device: implement device context marker
>   rust: pci: fix unrestricted &mut pci::Device
>   rust: platform: fix unrestricted &mut platform::Device
> 
>  drivers/gpu/nova-core/driver.rs      |   4 +-
>  rust/kernel/device.rs                |  18 ++++
>  rust/kernel/pci.rs                   | 131 ++++++++++++++++-----------
>  rust/kernel/platform.rs              |  93 ++++++++++++-------
>  samples/rust/rust_driver_pci.rs      |   8 +-
>  samples/rust/rust_driver_platform.rs |  16 +++-
>  6 files changed, 177 insertions(+), 93 deletions(-)
> 
> 
> base-commit: b28786b190d1ae2df5e6a5181ad78c6f226ea3e1
> -- 
> 2.48.1
> 

