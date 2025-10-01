Return-Path: <linux-pci+bounces-37335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5CDBAFD94
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 11:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E18E3C672F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869502D94AA;
	Wed,  1 Oct 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZk4BoDg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CF2D7DC3
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310919; cv=none; b=L/KyNBCy83ZgPWP6VNNFn2l+fmRAU8ahqXghGbTH7aMtUAyDqYC2jWPADayeICRuc2lEJMYLyn8VgZt+C2xl4d3nVxRmijYc7G5/6/9t4FjyWFZOZtaDz6qgxopEGl16fEhVIUG1uR9yJMqTB3JWtw5H8blmF/xWmfN0NOYmsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310919; c=relaxed/simple;
	bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAhlMFLVcD6m6Q57xma2OiPwieagDJl4dSwg42wuoeW/Ikv+Rg2gNv1YEKd7eDbIfN4dqBOtF7NY2i+VTvna/77vdjaih0TmbEEKXEFbspYRWKH9pFa+m0YJMEmaiVO2Ul3X04RWzD5edP91ckZMu1hfGlJFhQrvcDqQGR5O6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZk4BoDg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e29d65728so47389255e9.3
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759310916; x=1759915716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=SZk4BoDgsFAf5kMvr7CbXBjcwCX04Gigy/5uI9mf3QxITYphuXHHOPFGqSL+otUVU0
         2S+ooXPjysDGDq5LyrNPJHYnCXbCx6H/PQoEKlPmttcSprij44r05SUx7xUq7wQ2zxYw
         nfFKg2EPAo2A2HpO0LMagnc18VPUsVaw9ualx5ys9clXOxrxYzqV/vNwKXVXf9+la+tC
         nqJ54pGhDvCFFMcNYqLV1bA1Es7uY6AOJ910q57gfDxP3FhMZrQHPHl1RhY2WEHlXP9T
         aEuYrwYCfYP16Y7s1ETYGvYUfW0Sa3RHGsEsE1dAcO9uF+AXd/FQtKom+Xfidit8qAOy
         v7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310916; x=1759915716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=HCf9oBJFPnzNVx1Q0O3UBnKysx8IzJPogtLaQPmkORXS0FuYJ1NxVEzdUSvXWO5zbg
         QGy9RJrr4qHlrx3QU7PFDedIqoadIaXS+1XoRCt3XYpRJqoT3Ul0XbZHHFRG0iO3V2W1
         17/8dI24K4REHbbVyauTKxUROguOiEHghnq0lELOTKYYY9xnOK8ZXTtSlIZW7rFdStOd
         bcZ0b6umuXJs5W329uW5kfSP7vdOQBpBR0gKYnXTX7auKiZ9awq0cvO6wA1+N7i8iRqz
         jOL3P6n4zNwLF4iNTipH04VNoTIZm6fAtHGKdpoLZiMlB9G92lPfzLpagu+Jmqx8Df7i
         +TsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD6pl9BX8JfkBjSm+TuZGx8yruqDCZiuloM+R9mO92St6BqAKYGTwxh4JJ5wXjFcDZ+IzDTGg8iak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72GZoVB2KxWa39T3Yh97RrZPeS6hncjzJE2Hr7deewwMFFJ7f
	2Ri389WRb/kdbX1OVVX3kZD4ERhORZl/CDplXNQbFRRpSgl4Nl1aMiPeAUaKmkfKtSN+Jc6rC0h
	NnJYotlfqPrpEdAVdyhilNkRAt/c+5trzqyJCgY6v
X-Gm-Gg: ASbGnctxqFxZSTj6MzCpJTiOUSJ+e0RUmfrPe5Lcrd1G/wrXPFdIHw5XuNm5qs8K1fE
	gtBoSBl4/IQgso/UlY4wuw3E9qy4oDKBg3+XSetRwGw4KXmAh3Va6fuZx+nycz+bqUYKxTL+Kor
	wLnXEFahVTcCLDejXTeCr9lrA0zMU9orkR0dvb3gRARo+Z/tRlXs5cyjMRPObrDZGw2XAal6qQ0
	XT9mo3c9eOnpqCvVYDxoo23kGfxuSv+KTVkfoeQlSQqbi1Ap+EutYO6xgSLFVxqYRU56igpEnTu
	0gw=
X-Google-Smtp-Source: AGHT+IFcom3ihUiZsvQc7Ctd6T7AFUDP+BI45kum3YBKQg7Ja8eF4g1jmM9Rz4a7lPBApkzRM7m3vX/ZWyyP9taYRzo=
X-Received: by 2002:a05:600c:1d12:b0:46e:3d41:5fe7 with SMTP id
 5b1f17b1804b1-46e612dcff2mr22205905e9.29.1759310915370; Wed, 01 Oct 2025
 02:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 1 Oct 2025 11:28:23 +0200
X-Gm-Features: AS18NWC0UIhXtF3ngdaaXlg7HajAeA8SvMGIxlOaATZh6gKK8pvCVQpA1AHU2RE
Message-ID: <CAH5fLgh84SZznuv_BHMxSe4riF=YZekCp1Kx6KmiipzTOHmRsw@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] rust: io: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

