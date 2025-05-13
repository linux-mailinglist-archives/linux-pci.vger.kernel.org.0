Return-Path: <linux-pci+bounces-27646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6E8AB586D
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DDD19E3FEB
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894842BE0E1;
	Tue, 13 May 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjsGTcZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B418E1F;
	Tue, 13 May 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149371; cv=none; b=c3qeQGEX5O0boOS1n0E4VNXzYN54smMeQIQQSiCL9qVCF80y+4fvToLdXTHWacZP2CfAU9+vm4Nyfd6eHDpsB9hQ4cGK4mQ/c5CNbzaK3c2QM4McsCfY3WOt0r5qQNFdZKLgufiXTIwgIMU9IsElsZVF2Vs/hhJi6MCVf+6cm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149371; c=relaxed/simple;
	bh=0uh/PTXJRbMcazwRaWv8Bo4RnC9VvZ9wH65449hEE1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzBnXBoO8TSf1uAhOH3qHobe22fwoek2soxj8Rr/xudv5mKV8eaXaFAu5SGYUowVvkEhg+YkRFrRBHqvXmFf9U8ASFyizZitTxCwVHNBNumfY9YKR9vFO41Xkr8i+ds6HYqI1L6hkRBVCx9D1cEivyCeG4bfsKwggf5D6qQq5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjsGTcZC; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-730580b0de8so3918031a34.1;
        Tue, 13 May 2025 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747149369; x=1747754169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uh/PTXJRbMcazwRaWv8Bo4RnC9VvZ9wH65449hEE1k=;
        b=TjsGTcZCG8xVHzecc3IhC0N0hWKrd12FzhBu4N7uI7Oyjnz3vdy3hfI6Tmam6eHbTn
         hRimn/ncGUfz/OL43gghjHooZvWGmtSkyHoErZ6Z5PiZP4IQ5DqtfiPa3G+Iih8t7kGY
         p4zk0iMFp1kDQU4M5YqrTHgl+JJ2VBkkJ/J18BdGVCB2vyaE4fL9psS1mwj6NVw6LFsp
         +vkCZkuResQEAGz4YnDY5Xn0l1gdOjHY6V55MBvHIkoclNjL4O7sdyRbg677bOb+N+/p
         OaGmgDcarhIiCYkj4dj/cfcyTa66XyyPqy+KGzjMkf9PvUuNhrYOMjfW64sJib+7udGV
         fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747149369; x=1747754169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uh/PTXJRbMcazwRaWv8Bo4RnC9VvZ9wH65449hEE1k=;
        b=K2+Svxw9AhVSwV3jECbw156pq2IoWF+uaVQmOSirnKIvV3qNYj3ZquKRqv/4+ZTt8+
         ika1bgypSp28PMhIPB+XqTzbMKpPzaDCbh14uFyY9kbkV66Mp9OyiR4GNz+SIPixiwTS
         MA0Z9BYouCY0m/6dbFjFxEkSplKzlYjxVLnR4jggxlHqoZV2queGsvWMngooCB57vudd
         8ed11D/509FOVkwmzUE2rOZUq4wuKw+6EfDchoWw/0kFCGIfYlmgnFGfOVrdJ3jSk+Cp
         DQ26WYn6st0WKSH6YTLhE/xuaDQQBzBJZwEwPu2q4+Uh+nml6y2s7t8Hejct6Ytqbx/n
         q2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU3V3f2dGyXbd8J7AeiUmGY02Y9YZ/GEqYFMBy3y/rYgLOma4ZM/O5GE8s96qGHn7mk9j9v9MucyjyN@vger.kernel.org, AJvYcCUimwU2XgGQsZervKcY5E9wfMvczCzE5P0MuI2nDDOqUMXdyIk65zkzca/GlWENGHgBQ0VSJ4PKoGr5m6B+7LU=@vger.kernel.org, AJvYcCV+Ufsu6Bfst/7IlmDJw6x/NmeQX3HQSyJK68ai5nX/SO9ARwwNuFhLdg+HnQNj59X4zjrHtDf7+iKfmng=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwwNkyao4eGYmJ0OMIuosFHkTKBM7mEWlHUQPEqEA6aS4nSg+
	Jg+u507GMqrR8my7z/clyIS735yt43xNy0O9QfbMEVEBRAopnQxI
X-Gm-Gg: ASbGncuWSmEj/tOmFBqbUbz3SBZR47igfiFdsoh47S4U73M91Wlpb8pGRiWlMaZrjlE
	1ktH+nre2EWaF5bYlHIao/R4TmWOBeUqf+TdWpMGxfwsjrYyB4SEv4bP6zadqqbenNW+e180rOX
	l5xfDMkkeCl3wI4aXQsJqbRqAhv4Du6Mliv0CbBZZ4qLFj0iyFRvySq4yyP9o69lv/MRbcZw7Kp
	Gzqov7la21gd42HiUNIo57h7MRw7WvS8ZEgKHAg9qDzfcYyCoFRaidMKR+z9oZe7/LBtQxRy5h3
	V5D18DtChGyzibe7besFAp4VSSbpNZ3pk+bzkEZCWIv8J9FNx1cG2435TZWI9bl807KZi61ovhj
	u1SgCjyeXDA2G2NqdUkU5TdY00ktV
X-Google-Smtp-Source: AGHT+IGbr/uZ7r4cS/fBNvQYU2fhVqEpCiBt00je02tqMC1tSmemGmi5CB3JGNk1qdmVKM7wKn0FCw==
X-Received: by 2002:a05:6871:e086:b0:2c4:1b1c:42c3 with SMTP id 586e51a60fabf-2e005bc46camr2217682fac.9.1747149368576;
        Tue, 13 May 2025 08:16:08 -0700 (PDT)
Received: from my-computer (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba0b7f856sm2270445fac.45.2025.05.13.08.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:16:08 -0700 (PDT)
Date: Tue, 13 May 2025 10:15:24 -0500
From: Andrew Ballance <andrewjballance@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, bhelgaas@google.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, me@kloenk.dev,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	daniel.almeida@collabora.com,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/11] rust: add support for Port io
Message-ID: <aCNiDPgMGZ-tD66n@my-computer>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
 <ff526b49-a033-450d-9e48-699187167712@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff526b49-a033-450d-9e48-699187167712@app.fastmail.com>

On Fri, May 09, 2025 at 07:53:31AM +0200, Arnd Bergmann wrote:
> Can you describe here why you want to support both "Io" and "PortIo"
> cases separately? I don't think we need to micro-optimize for
> legacy ISA devices any more, so I'd hope the "Io" path would be
> sufficient to cover the common outliers (ata, uart, vga, ipmi, ne2000)
> that need the iomap indirection and also the legacy devices that only
> need port I/O (floppy, x86 platform devices, ...).

Yeah, we probably don`t need the `PortIo` type and can rely on `Io` for
port io. I`ll remove it for the v2.

Best regards
Andrew Ballance

