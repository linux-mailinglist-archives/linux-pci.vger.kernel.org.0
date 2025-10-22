Return-Path: <linux-pci+bounces-38954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D819FBF9B97
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 04:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE9734FC5C2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 02:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666021D3CD;
	Wed, 22 Oct 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKlNqAj8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447B21D3C5
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100055; cv=none; b=YeEvs7VIQJOVGHOh5R5353MA0wq2LYp1aRlLyTiN0YlrehRkeBngAW3R5dYzhw0q9yidfJIYPv1mbWVicHdjYO6yGnSy0rAzojk2HfVwXlbPvJ+jh3T+L3yJPcc1iGy5slg/7HdKZWgUgPGN5/I73sanctLGfCn4OcS0ciBZ8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100055; c=relaxed/simple;
	bh=A+P0s8xM+ovp2iCRdR2wm/nwAd8dNmdnn9/2R/2q9mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2ni8O35TQcJcihb6ArWYiPw0uNNafKv52SDZuOV8YpH00VtvDFVzV1jqybA6+j9FJ+nTVZEBpM93dBghYOQgqaaAB7wnORQL2BBS+RdNzONx5h3iAaB/dApvl66gtbEOSR4GAJ8+Nr81Dzp8bet9blaImn3okJsx/6j6WCI6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKlNqAj8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33d896debe5so4316214a91.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100051; x=1761704851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=aKlNqAj8jXvvWoICbfNwKUqLGP/aPJt/n2SESZe6VHiyTTE8J40WagoO4bVRrT+qiX
         OgTdYRYckYQlquqlWtROXxhAwy+utRm1jmHF5SAROzafg4jUZ3LaXBg12KXTsMoK2QTy
         MhoEL5kohuLJmswz8GF+RPKgG6gVOPrXt2mWXRituP26sm0KzzdVtDXj1zcQB0fCMvoV
         EWFQ4s/bvRvRkPtHqWB0VAwv5CQ5QwEyQAtaIx/wbAK6O0V+wsI23tum/tKi+cZZ8nm/
         MU3CXKwTo1bA2ndzRTVmIVKL7gBE9yBOelXsJxfxoEncwWtTZfW4pUjNlmChldVCbrmQ
         vEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100051; x=1761704851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=SZ4+TmaA0sYsPb0tmMtHymYjaDMuyqojeX8AyjrhrP/mxUtDnm/E2zOKe69pVxH1n+
         /cRqpHB6Ad/AuK0m7PGWFw220Dh6T3wo8rtU4aH61QJ+3lpywNQl7QzXP8ejo7vyy652
         6nEfaZt26lfSqT2v5vk6Z9iq1nF3UiEbAnff3JHvjBEq+c2X7MHruHoosVZstCJ90gLy
         6WtNX12omjv99exzvxpbtJuIoZ3vKYN1RkZDcjZiJkRfArGvM+znJFQnPb/gIMq0YXRv
         UQ2F5AQUB3s6bcOk2UMPCtDs4F75LTD+KnU9NYHK/jVhygkHR0icDmPIswHafRQIn866
         tHSw==
X-Forwarded-Encrypted: i=1; AJvYcCWC1IRJsuumZUF3pNjV/Hb4lrBmajAstw6NRVXuUglz2maE8G3m+gRiCeeG6iT2nzcHAzJ6p05a4j4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YtkNJvyofq5sXg7ApRoXldpZaeB+d0R6l97/aRNZBAOR3O+q
	lnOl0+8iElVTGmNasHtezzcR4if7bRC0VqkJEiT8H8ECNZ79jLvK/WPvwyI+MvL/TAw=
X-Gm-Gg: ASbGncsN5OTMMQKEU0sV1o/fNrJxSx7SYH/IHVs8z39ZLorjx7/UwDVtT3vlZysjehL
	WlSNK6Qa1D/SMXFgQDqZg18i27Cr3rZwQy0vFRhGcKdZH/0eSTDUQA70QKtQ1C5IcW3B6C4PAnW
	ov1AyfTmse774f/aANcrne5G+e41GgXg2VptPgRj1HNHoy79stli/ndIlEQ3eXP5n+jzq51OAzf
	Tow5L1SaduEyc63HJ+ry0thlVe0zeHGG0bHVisQeFAAIQYYCk0lAPbN5lbjvBjvnFU5lv3GQRvN
	OgvYcfoVqVh4silIDkKH/4Lb9HtpsJOUrnwGKekw/NaV9n7yZMkmQIwxgPnB1adxtadN4Kt+wzA
	Jvuv37m964i1eEI54xHaj6DSObLYmBkESEUenwmbtN6jvZPsfb+EEmMnolNZDrWjo4ICmEgPbLw
	fbjdGnVQ/MymfMV5BnMLQIq4k=
X-Google-Smtp-Source: AGHT+IFJLVFpIR1aWCyZCFOIKnAA6a58lXYXHZeAFELxfkfneTEN5uN4Dh2U6O2etE9y+Y+gRJvc9A==
X-Received: by 2002:a17:90b:1dc6:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-33bcf888575mr30106334a91.12.1761100051119;
        Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f11e1sm981092a91.12.2025.10.21.19.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:30 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:57:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Message-ID: <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>

On 18-10-25, 13:45, Tamir Duberstein wrote:
> Correct the spelling of "CString" to make the link work.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/opp.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

