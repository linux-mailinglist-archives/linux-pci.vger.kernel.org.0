Return-Path: <linux-pci+bounces-34022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E10B25A66
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 06:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A292D3B660C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 04:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608521F4CBD;
	Thu, 14 Aug 2025 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFk8wODM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FF1EA7DD
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144941; cv=none; b=PwRWBmPNBI+7R4N7gJthqNKD2AKbdZlePwSChkvPzgekhQA0XMn56KuJscYtKs0UABKkdH96TzbuSDPKvvJyBbdj1cE7mCsW4R0gT1fM1OeXmTkZV0B3rr0P1rl80MEgg5Kmx2adi/QpJyLhbI/R3g4DIrKsoGPZhmi9pj7ynrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144941; c=relaxed/simple;
	bh=aINf4JQIOzGrbC8KNPOs49EQ27ER0B2fAmdlIOg6AJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uef6hdS3M2A2OqOCBO9aQlkAvthem7EHAAuMwov2EGGkUOyjGaYPvaMrxV3og/+n0PQ42Ieh3gV8B0tfb36booeges9wpYfgmC3zlCMrvsJJHj1FbjXTVLTMUBIj1gPOfz3Hr1sn15aF5pgrVMKyIydVdd/nF0LY+WaBTHI9weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFk8wODM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4717553041so355680a12.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755144938; x=1755749738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=VFk8wODMCPp4sykRcxFNrGPwYPG/tsAGsdvjgE8c//5GEJgXop+PzeRQ86GIEnq+Jt
         ASnKVOR4xGiZ4gw3PsRdnQIZmOaAliJXJMdIgmMpEIALEpSHT7cBRDzkwbzLoco5gInP
         2Abkeoobct2tyzQw6OD8fUL7uatVHX+mJDw5ev5SBRFATouJVPxFd3u2MWeryMAoCQRa
         OLz16rLSNbNZSh7wwfTHosg5H9wZjviaTXy8WCve6PISnwpN4KltPa/Polk9HYhhXvzH
         /Gf67SHkyWDytV3RVGaHCQm7l7DWx7B1HC3m87leSgUlALZeAiB1gChgw4j7cMuET9Dk
         xRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144938; x=1755749738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=bwtWT/4LyWYJ1eKj32nBA4rtyNW6Up4yQbZ3ueO6CX2rWyl2xyGb38NnXswNnRFREt
         Ls2nVTJLxlROo61069mOODMyRkXRkgUdKXe7k06ABAuZEhxTbOMqzjKWn+saby56/YNu
         x4fq1P/VckX0QpZVoIp7hEVqPicTGK7iYLEGOhYZLznW16fhbxe+kEjDEuF2GE+rCdEW
         +JdHBEyyZhEDBvlQl9/KrBd/tyj7fC51fppjFF43xmFcuKdtTc/wDOToX1vJ6WvKYFG9
         U54Xcj47DR7SNl7haFjT8gXOfANrZeVlxCjm/T6qZR9OTQw8GIh1LdgDTT7wfbwKGtvd
         XNFg==
X-Forwarded-Encrypted: i=1; AJvYcCXVQcxbAy8S7++wSe1pjFVhgSFASgto7Jq6D8+vxltL+06oBb1p3FLSrvb0qJYQg4ipBCTzXrfm5gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDmzyLROZuaeF6JmwPMMZj2XIqSyLqbYDcLkwCUd+otlV0gzB
	FjtBldNqQDuhYkPKH61yyyCme8Eu+XQChOvLM+KnO8jPW5fOe9wc1jnW67mj6/UUBlY=
X-Gm-Gg: ASbGncuObFbj+gG7hIe8ulEd+nRrZoQ+dVe9YzRd7XZi7ma4aQaFR8bPCL6mxbkN5pz
	6tjiMmHQ5HyXkpcx0aOx/ZmaLdg4cs659CFQR70PhqJf0/jR6SY3WJsL11oY8gbIw/+7ZZ8PgYH
	O8L4lqXUEVQsBb7JBfVyDHXTda99yn+O+ma/zzbq6T9VQp2Gh35AQJZgPwKTTB60keZu56zUWX7
	GgiIrZDGXLtvVvC2zWtRZX9kCf69zjmjr4JRSSev02rvbKDdbKymf7CEbMegt8v5L6IJgPoA1F8
	8NWp2ExgAG5zqyWP6yQV7ISpfRhU5P5ALaKt5fzcsLOUINRG5DYQW8rJhWt4acCXEIFgUOUo/D1
	58bL4nrZs89hz8hNa4jKXWMh9ue/RcDAUigs=
X-Google-Smtp-Source: AGHT+IFKmQVKtrRTGaZ8hTWhd7nE8H1E8AgUXml21TmSiOXRMbfiiTxpX/j+26/xYc1Zfc3ne6Vv/g==
X-Received: by 2002:a05:6a20:7d8b:b0:240:1204:dd5 with SMTP id adf61e73a8af0-240bcfbba85mr2301691637.8.1755144938050;
        Wed, 13 Aug 2025 21:15:38 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9795200sm31652911b3a.114.2025.08.13.21.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:15:37 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:45:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] rust: clk: replace `kernel::c_str!` with
 C-Strings
Message-ID: <20250814041535.l7yj2wm4ae3l4k7p@vireshk-i7>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
 <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>

On 13-08-25, 11:59, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  rust/kernel/clk.rs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

