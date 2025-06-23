Return-Path: <linux-pci+bounces-30465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B76AE57B6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 01:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E77C444FB4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 23:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A022A4EE;
	Mon, 23 Jun 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Zb9RGP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33716229B15;
	Mon, 23 Jun 2025 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720441; cv=none; b=OeVokEWwaJlCj+m1qfoGgrqFr40GhSHc+t+SHEM8UyjrO2Tap4uu5cDAoR8tJkTz6SF2rWMVVjUWVySXPW4JFbYvQ2Q1Z5xd8lk1lFGehmNQ2Yja6Y+ohXg6TvFWFLlHzxr+iYMmPqoP7JF1mraO7tAlwPnJUWHT+CiJzMIUu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720441; c=relaxed/simple;
	bh=ZtQ2Qt4f7OMEWIrCp3AR0s+GaEutTrsUFzG/PxY8FzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdJQ7jIzJwNVGe567bvK9yILt0mfDGPGcnnE3pkJWcrrx2MOFmBegRR9StE4VUUU7HQh9JdMWg9tvAMSBRuWKlGKRMv3MHY4ogZuWJ50kfgOfskg159hmfcCVm2jEXMJVv8qnzbpU128Yd6Sq6mu07mmI9yvroLJHpXyw2JQ8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1Zb9RGP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2eeada3df1so265933a12.1;
        Mon, 23 Jun 2025 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750720438; x=1751325238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtQ2Qt4f7OMEWIrCp3AR0s+GaEutTrsUFzG/PxY8FzM=;
        b=k1Zb9RGPdjjfFKQ1vmipn0GJQOyWo3eHucp8lirLYVYuOuqmgEevk/5G+Zs+iYWJSl
         0so0IV20X3hOgaY9axzzaBtl5XgkW3cOAMDmM5eW3GDkzrVy1aRG7o4d9QmiORz62fwu
         cMBC4YigWsXxLs/ajZcXIsGvIGEceL5C3pkfMqPgxFUOsXSAwsmkL4kg0j7ljpuTXx+K
         7gm/i1PIsbH+IcId1Hq9yhRYzcJOetfE8BptVhdhqhLhLJj8gd5hL92v5wblMo81ZrKk
         xAgoFzKG1wFcVOur3sA+bKZMUtruD9ocbtW3IDVtHCJeo9YQ+vksX6fCzXBfMYNfvpwt
         dXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720438; x=1751325238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtQ2Qt4f7OMEWIrCp3AR0s+GaEutTrsUFzG/PxY8FzM=;
        b=toksJvoKBp8u3gsg5vSyVaLvwZHUr6h+x+w9jQHUTSyqQw5tBHP8Y0suSh/+tLT5x7
         KeRxinExNzaZV+or5Ly8ZT+wuIG5hC0vU7Ajr+OfSugWp+fOIEUJ3tGpfxVLAgPAG99l
         r7ZQc6mDU/NdylotqBnPQbkrqZN/6fYj0bwG5W81x3VE8t6+M5RCTaGJWGxrYI7AAOSW
         spf1/mszgQwLKNZTqsLQugyZLnfN8BoMS4Pqoffm4D8VtDIHlCDaV0ORUApdVxBzKRaI
         N+6Qi7f0KXbIr6fCR6YbffNWFnyJ18tSZRFj5HXW7VV6G7tRhRqFHPCqVHXKMBNk4uFy
         8lTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+EN7VULX7u/QqiDCJaPeYoZzVnL0C0efQFvucM95pB6qI805vjC8YVuXhuQwRbK5HDVU0UzH+wAsLgA==@vger.kernel.org, AJvYcCUHXMzFJPD/S1T3OLjd0Zb1Z5F7rp1kar9DuF8Gowz0dkdIJqF4kHtmc04bUtPaNqLQcNaMke16NRo59a9b@vger.kernel.org, AJvYcCW5upNZlvghOYx+sDWv6goBGGWhZwgj/IG/yE16xUrSkaUJQ/QUCfp2ffE66j44xfbSc6pBQ9Z9QwrL@vger.kernel.org, AJvYcCWs/34aZrUHKQOw6CMd9P93lHDG2NGzQ88VDmIbJnfyyYr7LFdXRHf4GjsSDNiFTywNli6XUC0j6G4=@vger.kernel.org, AJvYcCWs1Qa5SkNvHicPoHOYc/e++g7mDIyNmRmIuvQ5T4Dit+s+Gu1AyxfUVFlhXeF7oxegBgxi5YetwI5P@vger.kernel.org, AJvYcCX6js9Qs2H7VkNDLY/C+LeIGUb0yzL76dZ2lKvViqISAc/yUnBRNu0gVgVvbL9rYaLMmq2WvoOSE923YX0iPQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lhNL8cTlakLT2ypLTQMt0H5xVCEZzC97E+dM07b4Sp6SagfK
	ge/FKEBfbCa6YR7j61ev6CTGxoZohaNgMwad8rXB4au72n6b1InFvh9e27Mlfof7SdTzgDCl3CK
	yVwIwrXisydZPCzap4MB0eHa1f3neVHaMh8A9xsg=
X-Gm-Gg: ASbGncsBpyLv6Hy7zMIu9BbOdK6JsEV1oH0tzn6WY23xL9XTCUD96oOqW+3eoUYCp8A
	iLKIDeBgN7L+9TPH6yAcV6egRyoLJqmo5aDR5RrC9QTdBwJp+GV84aeImSm8IZQDjDEFagh5JWI
	GgjDBypKyiHfGCkReARqHqo5AvnvMOoiY7KSXCvmF+vm4=
X-Google-Smtp-Source: AGHT+IEsWii+V5p50ha11PTkF7dtQH4Lp+DAN/BWRuicAVRBL1LKwMw8G12V8WuF/myxhsVW+VQkOs7i/rj5crF+YW4=
X-Received: by 2002:a17:90b:57ee:b0:314:2d38:3e4d with SMTP id
 98e67ed59e1d1-3159d8c5e70mr7719800a91.3.1750720438379; Mon, 23 Jun 2025
 16:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
In-Reply-To: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Jun 2025 01:13:46 +0200
X-Gm-Features: Ac12FXyx0oigTMFFaBp0d8IysYfhBRX_G8OKWklWXPpi1hgSkQf15JDHjf6iluE
Message-ID: <CANiq72k9_bzjV7YbFL1NZTESjFYRiiLgYaGHYv_m9hNa+p9zmA@mail.gmail.com>
Subject: Re: [PATCH V2] rust: Use consistent "# Examples" heading style in rustdoc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 11:03=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Use a consistent `# Examples` heading in rustdoc across the codebase.
>
> Some modules previously used `## Examples` (even when they should be
> available as top-level headers), while others used `# Example`, which
> deviates from the preferred `# Examples` style.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Benno Lossin <lossin@kernel.org>

Applied to `rust-next` -- thanks everyone!

This is a trivial change that shouldn't be able to break anything
anywhere, and I haven't heard any complaints, so I will go ahead and
take it.

If someone wants to give Acked-by's, I can still take them.

Cheers,
Miguel

