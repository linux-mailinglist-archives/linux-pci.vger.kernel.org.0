Return-Path: <linux-pci+bounces-30827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94937AEA82B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CDA5A43FC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2232F2369;
	Thu, 26 Jun 2025 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6eBVjKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B612F2701;
	Thu, 26 Jun 2025 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968903; cv=none; b=Scil+J9cS3nwxDSETwhvpEJ1KfRWbazW5ayI81WVtNf1aUt6iRQQk94+a7YfyfFnUw2j7zTXvBRWbx2wsNtyNlJyGQPzeBJZPBwwfjnQzoJKkEdFMRMyqIJNGOLS1D1/AHYNGOYclP/be8e683g5mwMvK6L8eYw0/a7RGTOMcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968903; c=relaxed/simple;
	bh=cpAuonRarh3V/5AZzHmJhohOs3ZPe+MF471SUSLwCUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtLeYGRg42ow1GZv5mtpJl4VZ46Sy2HpG2OlcGYyxNKgZMiLUBs3hdxnF2l7jFV/dH3aQxXiCTRYxq7Yw+CARwHMEvGblmN4mwpZFwKyC8s5NAnkR0nt7v1MAOYwRwzfksIfEVZDuDk1rLi38kG0uabNwtOT5dDX8c/zbckWMFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6eBVjKJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so21658426d6.0;
        Thu, 26 Jun 2025 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750968901; x=1751573701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRDEmi54S6LjnrBjZVa4DLbUJlXZIMr6dV6Euspeu5w=;
        b=C6eBVjKJ84GAt4zdaISpnVkucoppPf0iV1WO4iP63TagvDy/RRXXRiOpL5hbG3Ec9g
         sAzh5ijnefOxvujiqNqKSDzA9boWerjTG0R5UJ2SmhqiSeACLIcMUyqecr/UxExF6cad
         zXR7CI9/aKrYNKmp2QKB5yddTY0aOv0PspxklTJ+zdxpd25XGLOZH0GjTXrihHQRVxtn
         6IAFfYnjMwAmCu4GZQ7qfpuK9TKa6GcRqcRlh6bNplwcTlngkRrGQRePSAm8SswI4k8o
         1JiItobaB/xaOMA/XdywyssaqFr+vF+4EobOHmbwcEvP3DGv1xwF5OsnGkfhqo1CsnYA
         YpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968901; x=1751573701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRDEmi54S6LjnrBjZVa4DLbUJlXZIMr6dV6Euspeu5w=;
        b=Y51r60dKC46zSROqhEMGONjpvMIGAig0xejiV+jEHOUm5YxghXYPJ/u6v5TUPZd23s
         cdAQTWaFwZBv717/XPYO4TDxhe8jznBtkc1H4Z0DdAELumtlrC2pFLp93ku8yymjwq7T
         8BJHnYoc1weiyuNMoOCVKHZqkG8BCLS+4w3jR+2HhEooWcLu5QGkmS9Y2HLuVnKJbUqN
         WLwhktLayYYSVWDoS1i+iIV0U0CMkWC0Dd5ajm93qkfmlPX+j851EpWDyxPman2Ro+jr
         j5ggHNqv9jTmOWVgqHgcD/NxraKYn6Bz5OShvkMh1YOH4zexuiNtVkVIjOxvtYNM3Y42
         hsNg==
X-Forwarded-Encrypted: i=1; AJvYcCUsUCpuO0wGlMvk9etmQqoAH9FlCSANYwnnWVWF4+nOhMQqtq43+jJaZhELixc2mvf91o6hHZNmPXoTCUk=@vger.kernel.org, AJvYcCXQIHog1af6qc0JJmJkeyK44KAk1DBjA7l6e82ifCZcMysAmiKVM3KS06I0y/FZjKzL+dMC6Mt+G6Q6@vger.kernel.org, AJvYcCXSyRXZtL1g+PGeWrADgbBPSAOqcZOhnf2Y3xsYXY34fWvmYGWIr3q4pSFHk4A1unyICQPiPEcsm+GzwPeXtGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjNBJfJRJByzATVodJVYfZ8Nn2uHXFVOqQA2WJhgLcPEpSq7t
	5p2FjvOvsJ0WhGTc27LzuBi3Nqvy/31w56k0qYhg39xPFJOnPt070HNJ
X-Gm-Gg: ASbGncs817Jj3p9ul56l/ZJ5hVXqbwAmQmeh5WU+oRLDQEZDzIDD7WNVsKD6Zi4wU1C
	da2l/txDfhrcOMRzq5GzKAYyFjY2obPV9mb09pA32SGzqzbZ0lYnqWljwhatEHN0Ig9fsTk/r3x
	f9O4vHeMF7qHosG7XCySSCpCjBErFla2/kS2pL2gJsBaQ3VM/SZY7t7z9h472kzuAXHaXo6GVGH
	utRKjzj2V2VL59n/FSmUSnfu89ozw2KhAVPnbylvtRyejmpYdNDEM4PQ0RFwQ5xRwF2bbfEVcZn
	z78ekGE7cNCuqMgod7Ere2UWfSZGagj1eBb4KeunwkxsnN4aEkM87e60eT703SozPqouGMruUUJ
	vo4b0jgeKn5Qu1yf0gF594bc4Kb7nwXZFgQBqF4MoK3Yp4nBZPlTn
X-Google-Smtp-Source: AGHT+IEANItfJ+pbqeBQO9zwWycA6QYr37LnE7rpJ76vkzhiuapAzbecZpIvlqbfzXpn4d+I1bbk1w==
X-Received: by 2002:ad4:5f45:0:b0:6f5:38a2:52dd with SMTP id 6a1803df08f44-7000291700fmr16852486d6.31.1750968900853;
        Thu, 26 Jun 2025 13:15:00 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771d9b90sm11303106d6.47.2025.06.26.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:15:00 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id E3F23F40067;
	Thu, 26 Jun 2025 16:14:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 26 Jun 2025 16:14:59 -0400
X-ME-Sender: <xms:Q6pdaCFvUPD0RHCFio9KJ9_8SmnRa6EZEjitXaODhWBsPpYdue3WPg>
    <xme:Q6pdaDUTee5HY1z5j3I0fBp6lWCxpXdfipx3S0F7v2MAPlCdII2vy8ppD_PBBD_a5
    Cy1R38UuHkbfdyKHw>
X-ME-Received: <xmr:Q6pdaMIjC_NMg4gupZQQBgEFPS9vES_l000JIP9nNu1wJQ_hwWagZdu8lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q6pdaMHxmfVow-BgZppwkhXcy-rOii4jzc4YQSbNSDERCQc3uKdlsw>
    <xmx:Q6pdaIUZ71mHC69yScigDCEqRKfd0NeZX43RPMvdGZtTCj-34A5QWg>
    <xmx:Q6pdaPP3PXnMM6xqfrz5MeSrcnx1u1wbr_jbXo6ovbavxO88ROqfWw>
    <xmx:Q6pdaP11yAx7qVlXO-XTcMNXESRSjpeWEP3qwe4Y2bmlyOZ6j_QNqw>
    <xmx:Q6pdaJVXSL-IDbBt1k4PNPpzaAHv7ymXnHVDFfoH2JNUEsFM0Ac2rvVY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 16:14:59 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:14:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/5] rust: devres: get rid of Devres' inner Arc
Message-ID: <aF2qQu3pP6WOPE5P@tardis.local>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200054.243480-4-dakr@kernel.org>

On Thu, Jun 26, 2025 at 10:00:41PM +0200, Danilo Krummrich wrote:
> So far Devres uses an inner memory allocation and reference count, i.e.
> an inner Arc, in order to ensure that the devres callback can't run into
> a use-after-free in case where the Devres object is dropped while the
> devres callback runs concurrently.
> 
> Instead, use a completion in order to avoid a potential UAF: In
> Devres::drop(), if we detect that we can't remove the devres action
> anymore, we wait for the completion that is completed from the devres
> callback. If, in turn, we were able to successfully remove the devres
> action, we can just go ahead.
> 
> This, again, allows us to get rid of the internal Arc, and instead let
> Devres consume an `impl PinInit<T, E>` in order to return an
> `impl PinInit<Devres<T>, E>`, which enables us to get away with less
> memory allocations.
> 
> Additionally, having the resulting explicit synchronization in
> Devres::drop() prevents potential subtle undesired side effects of the
> devres callback dropping the final Arc reference asynchronously within
> the devres callback.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

